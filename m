Return-Path: <linux-kernel+bounces-568391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03501A694B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C526F7ACB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2F1DED51;
	Wed, 19 Mar 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAtMgXrL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD191DE3AE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401291; cv=none; b=lYUYh+i23/q9itPqlWt73Xuoc+lEohGhCaMjjc1VJ7NY284hQIKMyUkX0GhowSMmnIRmkXbE++ItU6mMhKdIpaLI6gH2kl9hUka967y1U2TmosYEpfGRu3Aw54RXaxNmxDgN9bwme4Ryt5V+FFEQLyqNK/4/PaOeLaZnuLPYhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401291; c=relaxed/simple;
	bh=lq9X6f5rVWemxyluvt6OwcygPboGXhQUAKNek3zdLrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOKaMwbIKyPvKxYQ2XCR00wnNV89KqSaJ4sePckJ8js6SBrPLeASUchrLWvY9yAdzcbbRHBZCk/QMSJnuTuX6sUh91dqYfIqq6N24c8HKqFsYjSyQVcR73CFoalzmcsefcuhSE187JcUNXaH8+Wsx7+/JFQDWMJoEr7qMHPKFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAtMgXrL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742401288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOpqJkUFS2tciZtn6NxMptpspHchhF4kFtYH07Hzmws=;
	b=LAtMgXrLCH4lhWmg/DvaWatBUHEVucrRqXYFgeF/1saAYRT3CqEUumpA4I+Lyur4Po5pt8
	T+hNY0HVFsiS2dRsQYM6QTf5RTvEqQ8WF+lKvXHH7LMUBFQSruUjkiUlnQs5cbAf8V4IT7
	QYaVxLRwQ+pJofbzh8DLIMCubbLaHm4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-84oLPk2nNgueP_uHDx9ZSw-1; Wed, 19 Mar 2025 12:21:27 -0400
X-MC-Unique: 84oLPk2nNgueP_uHDx9ZSw-1
X-Mimecast-MFC-AGG-ID: 84oLPk2nNgueP_uHDx9ZSw_1742401287
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476b2179079so137800721cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401287; x=1743006087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOpqJkUFS2tciZtn6NxMptpspHchhF4kFtYH07Hzmws=;
        b=ChE7Y8Q4MDtZ9bwRyWQDT7Ud4QmZapW+RU+YaofTS0sudSYr2mYFlafOoxWsj+JSnD
         5H5Cr1AC6lESp2szoVvpPxKbDEDRIJez+TDpZnWuqh3AkN/ial0OO6mklXieFW3C9mw3
         /LUwKMUInHc3Qew6og3NWA+bXyTa77VjBH3LTgV9kws38QiP2CJ/uTN+r1rRtdn5qh68
         AMR8PWHqSXzVldjw/W3aUsayi2YeM2xMtFyRfSUfRs/gfxcFkaXYJDl175jNNPJKG2w/
         3w7sxSz9JkuzMJSKigMuYGNJ9tFCG55nGDFyDTxtjYQu8n9nlLOPtcaDyD/GFBumkQzz
         yD3w==
X-Forwarded-Encrypted: i=1; AJvYcCVjKQ/IbvxzxhrCR+L9/UrI+Wx8jJ4w316MgKqfNCJ58gi71JscPSPFzRDUj5sTVgRrmv6a0hIoYJCnBEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpe68FZiSobJjchorrepMAQGm4MKo+Fvvu0HNLjBzF6WAj65L
	pRxkDIo7edsIwUwnL2nwMr8b2zIiaNBCKfITaNQRQKAMTu5hnpwnClszX7Ba+3noa9sONAHpOor
	Ldc8OZLBFd8e5hyAgYhT7XMDlMQg53N5PX6G3w4rKHkmbdZ/imu6agoZazuTADFhopfmi221b71
	GDhp8ERQDsQznNoIs58GxJbeyZK3sZ9QziUo48
X-Gm-Gg: ASbGncsEnv+7smssfkKplfdbdfqwDMZ71rt7BfrnQ78/TvQsOect8n3k8hKTpx1yKGS
	fBV7ivj1NqMPgFoAskrGSEaRa8685g9SWAQ3Tk2CjqpGC9K273ONa0GIZx7lzg0Jmz1nyG47/Jo
	LbPmNs2NmrM9Icg3RJbQpVKmbeElsPsw==
X-Received: by 2002:a05:622a:248d:b0:476:a969:90c5 with SMTP id d75a77b69052e-4770835ee45mr47928001cf.24.1742401286957;
        Wed, 19 Mar 2025 09:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq0WBTdUbfxwEVbo37+U0Z4XQZwzQBI6UK5QfoVOWzEKA+jKrkY6HS88cD6LTiUix9oV0Ssh8A6+qBy79YGiY=
X-Received: by 2002:a05:622a:248d:b0:476:a969:90c5 with SMTP id
 d75a77b69052e-4770835ee45mr47927731cf.24.1742401286668; Wed, 19 Mar 2025
 09:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314125725.6425-1-gpaoloni@redhat.com> <20250318110700.510f05df7e113180503fc036@kernel.org>
 <20250319051317.670ba86c@batman.local.home>
In-Reply-To: <20250319051317.670ba86c@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 19 Mar 2025 17:21:14 +0100
X-Gm-Features: AQ5f1JqNVJcfdW-NN-v_3Y6r0ZqLbaTg-J7YEdwOWjVrfDSN-7gsg_RUGixj8UU
Message-ID: <CA+wEVJbraZfyF1-4J41maJHtBYUAZBNWMUA9z+PWPXYeR5jumw@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: fix return value in __ftrace_event_enable_disable
 for TRACE_REG_UNREGISTER
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 18 Mar 2025 11:07:00 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > --- a/kernel/trace/trace_events.c
> > > +++ b/kernel/trace/trace_events.c
> > > @@ -790,7 +790,7 @@ static int __ftrace_event_enable_disable(struct t=
race_event_file *file,
> > >                             clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT=
, &file->flags);
> > >                     }
> > >
> > > -                   call->class->reg(call, TRACE_REG_UNREGISTER, file=
);
> > > +                   ret =3D call->class->reg(call, TRACE_REG_UNREGIST=
ER, file);
> >
> > This is not enough. As same as enable failure, this function needs to h=
andle
> > this error to report it and break.
>
> Perhaps all we should do here is:
>
>                         WARN_ON_ONCE(ret);

Yes I was trying to address the request from Masami however,
if we look at the error path of TRACE_REG_REGISTER what happens is:

ret =3D call->class->reg(call, TRACE_REG_REGISTER, file);
if (ret) {
   if (cmd)
       tracing_stop_cmdline_record();
    if (tgid)
       tracing_stop_tgid_record();
    pr_info("event trace: Could not enable event "
       "%s\n", trace_event_name(call));
    break;

In this case it makes sense since it will undo what was done before
enabling the trace event. However I don't think it would make sense
to invoke tracing_start_cmdline_record and/or tracing_start_tgid_record
if the unregister callbacks fails since the event could be in a sort of
unknown state (i.e. we cannot trust the event to still be enabled).

Also it is probably not appropriate to log the event using exclusively

         pr_info("event trace: Could not disable event "
                 "%s\n", trace_event_name(call));

So I would agree with Steven or else

      if (ret)
           pr_warn("event trace: Could not disable event "
                   "%s\n", trace_event_name(call));

Many thanks for the review
Gab
>
> -- Steve
>


