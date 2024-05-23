Return-Path: <linux-kernel+bounces-188073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C258CDCDA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758691C210F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5812837B;
	Thu, 23 May 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jq6eWdjw"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB884D1D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503127; cv=none; b=hc3oFHEb3CFnEutm7GDzERAnwVeHlQ5TYSTylC5IV8qs2fhMg8L7vvIqSGzhj7AJOE2Adpu5o+YSt4TuH1nLenj+WZprJNURQhALcxwoBYUF3CM0oLtyyfXL0QRShlzOaFyKQaSWouGLXJiAO4fFKSdVcAGOb7TXLdjw+oDl8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503127; c=relaxed/simple;
	bh=twa6gKc4Ja8rI61KLX/gmR2tcMYRjGwbQv1wJFVxwtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOmOdxeigwIW4dqwZojxy2wrJ0Qtu+kuCQGSa6hwfBUAbwxfB5+4ob38BqvZ7bvFwWvx2cVOz+bB7RHig/z3Pqr+zFRkVMiRwa4HAOrIhlawaGSVxyCrZNBAyHpVqZXMVsVlGGCxgIMaA2fvO17MUySo6eR8R+3xiWCvs+wcHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jq6eWdjw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a8d467aa23so32550436d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716503124; x=1717107924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WULqNW39evuzHzZCXCVZ3XQhyYSJZ/maSvMgmWDC3c=;
        b=jq6eWdjwiInLk8BKDEM5MKiiwcx4RhHvhGecPWkruHcs9V8YZi+sh64LNt5zVk1WtM
         OdGnqAT776WPbylKOTBlPolG76/zHX5UVP0FUJp1qd0DaoDTP2XWPclQV+HIlaSb05L6
         gZm8svTKuGQKCH3irUOhH8U6OxK+BsqgOnLRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503124; x=1717107924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WULqNW39evuzHzZCXCVZ3XQhyYSJZ/maSvMgmWDC3c=;
        b=FmBIF6HJKjqrqXUKadpeyHNENu8qy4R+rCluft/G94HDdCAEUGv6XCuji7H7JKdsMX
         vvfni1Ashg/T6pAlR7GS0UFPrbxZsFWHzuuyI1r9mFAA0RN+sbysH6sa7QWiEMmbp4LF
         pOc9DWHPJrf9e6EVYL7NrwDT2m7ZkXi65/TQQLrsMWI8w2g9pI7Axc+2HKsPT901+6DP
         X9FlpMJTwUeENG7HCuEefhyRMa2lvZRDe8Kp5ntTvnVbXogOY9to8btRhRFYkVnjU9pG
         vwuGcOJWTwgEiL9qePSovaFuheYB7J5uaOUpEQZEmZ5Brv4+HAwjmZv/aPf72KsxeBQV
         F97w==
X-Forwarded-Encrypted: i=1; AJvYcCUv0AtmkhAQWBWlBlADvhxt2OqwSj3dyhSAa1xu2iwecZ+MQWF6qESp1JLq5tt1rfNuiBoloIIx/H3og+xuTakpj0wRt8STGtqjfBwY
X-Gm-Message-State: AOJu0YwK4nOosPU4WLShTM8fyYsZdvxM1inM7CpaEJIPxHc2Lpt/UevW
	s0+Wrk5cqlqhxiqeW9wTX+PtLWAmHmAJnfO67vAIyXgTYCXC4E6DQ8IPJUT/44t/BpAMx7vJWTg
	=
X-Google-Smtp-Source: AGHT+IFaP9n7c9taJbwlYNU4M22uJroMjqJKQgNg5cYDxldhTkaVoujkwjd0S2Rto22qLlTH47nYgA==
X-Received: by 2002:a05:6214:3a0a:b0:6aa:4a99:eaba with SMTP id 6a1803df08f44-6abcd18e43dmr4534446d6.55.1716503124495;
        Thu, 23 May 2024 15:25:24 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17f348dsm1042261cf.38.2024.05.23.15.25.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 15:25:24 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43f87dd6866so117741cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:25:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTlEv6h0/RaeONx1gl4qEN4c0X293ELexWaMSY599QmjxU6YiuIQIPSUuVOkqUQLa9uvrOEQWpHlftcy/LdHP+/+z0vk9yOYqc+aH9
X-Received: by 2002:a05:622a:4acd:b0:43e:398a:b0c0 with SMTP id
 d75a77b69052e-43fb0194a6cmr918141cf.12.1716503122909; Thu, 23 May 2024
 15:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318194902.3290795-1-khazhy@google.com> <20240318194902.3290795-2-khazhy@google.com>
 <6bc61553-6c8e-4705-9cbb-8e73d3f8c801@oracle.com>
In-Reply-To: <6bc61553-6c8e-4705-9cbb-8e73d3f8c801@oracle.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Thu, 23 May 2024 15:25:09 -0700
X-Gmail-Original-Message-ID: <CACGdZYKihs6Zfc9vpN5LrFVwx7+qqxV-cMzsO8=cpXpFYWt6ig@mail.gmail.com>
Message-ID: <CACGdZYKihs6Zfc9vpN5LrFVwx7+qqxV-cMzsO8=cpXpFYWt6ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] iscsi_tcp: disallow binding the same connection twice
To: Mike Christie <michael.christie@oracle.com>
Cc: Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
	"James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:34=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 3/18/24 2:49 PM, Khazhismel Kumykov wrote:
> > iscsi_sw_tcp_conn_bind does not check or cleanup previously bound
> > sockets, nor should we allow binding the same connection twice.
> >
>
> This looks like a problem for all the iscsi drivers.
>
> I think you could:
>
> 1. Add a check for ISCSI_CONN_FLAG_BOUND in iscsi_conn_bind.
> 2. Have iscsi_sw_tcp_conn_stop do:
>
>         /* stop xmit side */
> -       iscsi_suspend_tx(conn);
> +       iscsi_conn_unbind(cls_conn, true);
>
> to clear the flag when we clean up the conn for relogin.
>
> 3. Fix up the other iscsi drivers so they call:
>
> iscsi_conn_unbind(cls_conn, true);

I took a look, and it seems like the other drivers in-tree all use
iscsi_conn_unbind already, and iscsi_tcp is the odd one out - only
supporting stop_conn, and not setting ep_disconnect. Just swapping the
iscsi_suspend_tx call for iscsi_conn_unbind works, and makes sense to
me - but makes me wonder why we were using suspend_tx directly in the
first place.

The only other side effects I see are we set the session to failed
momentarily if we stop the conn while still logging in (iscsi_tcp will
quickly change this to _TERMINATE or _IN_RECOVERY once we hit the
stop_conn), which seems OK.


>
> in their failure paths so when they fail they clear ISCSI_CONN_FLAG_BOUND=
 and
> iscsi_conn_bind can be called on the retry.
>
>
>
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > ---
> >  drivers/scsi/iscsi_tcp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> > index e8ed60b777c6..8cf5dc203a82 100644
> > --- a/drivers/scsi/iscsi_tcp.c
> > +++ b/drivers/scsi/iscsi_tcp.c
> > @@ -716,6 +716,9 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cl=
s_session,
> >       struct socket *sock;
> >       int err;
> >
> > +     if (tcp_sw_conn->sock)
> > +             return -EINVAL;
> > +
> >       /* lookup for existing socket */
> >       sock =3D sockfd_lookup((int)transport_eph, &err);
> >       if (!sock) {
>

