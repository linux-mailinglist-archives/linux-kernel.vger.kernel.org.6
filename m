Return-Path: <linux-kernel+bounces-227538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907339152F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D11B24DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42819D09E;
	Mon, 24 Jun 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXW/cqRw"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1319B5B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244405; cv=none; b=tY/921x+KXEXnp3W3odo7AqW3Z25v7+iBrmXHj5UFRRJKFGd8wgwCSuK5EWn8VyvgCGd+V0+nJhXD5NFK5y0q5CTnDTjXPxr4LqWScXj//uE8HQkw6Kb4t8CqlqTyP0IAcmAZjGRLICECsu8Cvds8fy9O4VAl5OyaeoOkxFSGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244405; c=relaxed/simple;
	bh=jKi55OxVN9E6pqg0nf0hRFiBKvR7IV/rv+Jve6adUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj7V5rRqqRz3itQJ0w25Wd/usnEwmOwD770dKYJNXU7n5fXlW8Yl+jvPkBhFyLRLBED6XcRFbT3e3Py2glwRsMJruM25miKT1coUof4sAMabX8MNCYzJ67K1Ta0cb9V2RLLlUv5gkvijgQeDszB9GKwV5gzdvPli3V8LzoN9+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXW/cqRw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so2191797a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719244403; x=1719849203; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lyc6GkD4mAgMnyRo8BnqmIQmllDAeNTxMyGZYMk8gCM=;
        b=kXW/cqRwMLiTV0LZdWuvAyOCwI++G7GwpujSP4+TGS96WeBvJ4jaxrr5OnuEPfgPVv
         pescwTvDng2YfUUPMAGiPdeJVXx9KLg2f95gSqAoXZiHOPs8oyDmSZ5oTg0yz4rqMpJg
         ijj8HkLx6KldU9BhoNXwcaJDVEA8kzJJNsKEiZQ4WYNJygieNX+Ihas2HmetXCwRoNb3
         qjFZ5murO6unNHv7FPUcBghL8LIln8SA2acTtfDxd8Pz3F11fsf4QR7wBJFWvKPqxqlo
         JIyAQf9GESeq68sdPPcFM75212MBeCKGZCYB/KtOLXtE3Kr9EidPGmRZle8bPErJNtB4
         LJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244403; x=1719849203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyc6GkD4mAgMnyRo8BnqmIQmllDAeNTxMyGZYMk8gCM=;
        b=S9pelG9yZ0qSVMRCj2mi2FBRVFiZUQOe4xyzMww47uyL8JHBWuECDoU+KYHJuNXi8N
         eiAixDlEq/QeGZDoHoGi0xaO1feZJMATPjCZgkp13W021EULx2Q7xwmMu6IMpPXHdSJn
         NaPsvW0xgPoedOE1nL+/uZja35gsaHEC2BaqyNMb2B2AKaE6e0L8PAoie9+CHVcjhcPH
         KWc0urdD/BQTqqxVfjP/ySsFyt4lzpWIoOpJz61zP9nnzpGKUO9RI9qhpF0qkP2zBT4/
         YIAUqiBpZ0f8TlWdfgL+/gh3t//5LhweR23dPT0x4U7NTRsnlga3Qw26+wowI4FSX4rL
         zQEA==
X-Forwarded-Encrypted: i=1; AJvYcCWpO8aNmLp9WgaEQZmOoNSAZsPj5qmHjpwWAXaHEY6tgMpbMrx8PokpscXIt4Sj0YyUPSAlVkr4H4vr4btJwueEP51qI9QRFTqY+78C
X-Gm-Message-State: AOJu0YwyLeTBlXl3EOuQ9LamSdATI36LRVaN4gqmD7siMn3WQ0d2xfuK
	fS3x2QjdhPl7SvcnKBOcQvwU+Ol2j+HygPA/m5qnqgaw3S4LerCiEJZ8jkH5Sg==
X-Google-Smtp-Source: AGHT+IExr+oWQdV6SmyJFo3PSXuR1fC0obbTr/HvroR2zBVnRzgAimU4eOTYJRcizqqaAemtFuhjtA==
X-Received: by 2002:a17:90b:1b46:b0:2c3:7d8f:5eb1 with SMTP id 98e67ed59e1d1-2c8504f699cmr4164526a91.19.1719244402745;
        Mon, 24 Jun 2024 08:53:22 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff980dsm9014701a91.4.2024.06.24.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:53:22 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:53:18 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, tkjos@google.com,
	gregkh@linuxfoundation.org, arve@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] binder: frozen notification
Message-ID: <ZnmWbpPNjQf0UUYB@google.com>
References: <20240618221347.106627-1-yutingtseng@google.com>
 <20240622031600.3762859-5-yutingtseng@google.com>
 <CAH5fLgjR7iLHaWGy0NAiKnOUKro7_fBLoqFFzkdjn926jUdyAA@mail.gmail.com>
 <CAN5Drs0Gw6=xYVi0Naxm+A86mqckG4xjbEuvO9+UbAYHoEqYCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN5Drs0Gw6=xYVi0Naxm+A86mqckG4xjbEuvO9+UbAYHoEqYCw@mail.gmail.com>

On Mon, Jun 24, 2024 at 08:50:43AM -0700, Yu-Ting Tseng wrote:
> On Mon, Jun 24, 2024 at 7:25 AM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Sat, Jun 22, 2024 at 5:22 AM Yu-Ting Tseng <yutingtseng@google.com> wrote:
> > >
> > > Frozen processes present a significant challenge in binder transactions.
> > > When a process is frozen, it cannot, by design, accept and/or respond to
> > > binder transactions. As a result, the sender needs to adjust its
> > > behavior, such as postponing transactions until the peer process
> > > unfreezes. However, there is currently no way to subscribe to these
> > > state change events, making it impossible to implement frozen-aware
> > > behaviors efficiently.
> > >
> > > Introduce a binder API for subscribing to frozen state change events.
> > > This allows programs to react to changes in peer process state,
> > > mitigating issues related to binder transactions sent to frozen
> > > processes.
> > >
> > > Implementation details:
> > > For a given binder_ref, the state of frozen notification can be one of
> > > the followings:
> > > 1. Userspace doesn't want a notification. binder_ref->freeze is null.
> > > 2. Userspace wants a notification but none is in flight.
> > >    list_empty(&binder_ref->freeze->work.entry) = true
> > > 3. A notification is in flight and waiting to be read by userspace.
> > >    binder_ref_freeze.sent is false.
> > > 4. A notification was read by userspace and kernel is waiting for an ack.
> > >    binder_ref_freeze.sent is true.
> > >
> > > When a notification is in flight, new state change events are coalesced into
> > > the existing binder_ref_freeze struct. If userspace hasn't picked up the
> > > notification yet, the driver simply rewrites the state. Otherwise, the
> > > notification is flagged as requiring a resend, which will be performed
> > > once userspace acks the original notification that's inflight.
> > >
> > > See https://android-review.googlesource.com/c/platform/frameworks/native/+/3070045
> > > for how userspace is going to use this feature.
> > >
> > > Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
> >
> > [...]
> >
> > > +               /*
> > > +                * There is already a freeze notification. Take it over and rewrite
> > > +                * the work type. If it was already sent, flag it for re-sending;
> > > +                * Otherwise it's pending and will be sent soon.
> > > +                */
> > > +               freeze->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
> >
> > I have not done a comprehensive review yet, but this looks wrong.
> [resending as plain text]
> 
> Thanks for looking at the change!
> 
> The code here seems correct to me. Could you please elaborate why this
> looks wrong?
> 
> This part of code gets executed if freeze->work.entry is in a list.
> There are two possibilities:
> 1. The freeze work of type BINDER_WORK_FROZEN_BINDER is in the work
> queue, waiting to be picked up by binder_thread_read. Since it hasn't
> been picked up yet, this code rewrites the work type to
> BINDER_WORK_CLEAR_DEATH_NOTIFICATION, effectively canceling the state
> change notification and instead making binder_thread_read send a
> BR_CLEAR_FREEZE_NOTIFICATION_DONE to userspace. The API contract
> allows coalescing of events. I can explicitly mention this case if it
> helps.
> 2. The freeze work of type BINDER_WORK_FROZEN_BINDER is in the
> proc->delivered_freeze queue. This means a state change notification
> was just sent to userspace and the kernel is waiting for an ack.
> freeze->sent is true. In this case we set freeze->resend to true. Once
> the kernel receives the ack, it would queue up the work again, whose
> type was already set to BINDER_WORK_CLEAR_DEATH_NOTIFICATION.
> 
> Yu-Ting

Alice means you want to use BINDER_WORK_CLEAR_FREEZE_NOTIFICATION and
not BINDER_WORK_CLEAR_DEATH_NOTIFICATION. 

> 
> >
> >
> > Is there any chance that we could have a test in aosp that would have
> > caught this?
> >
> > Alice

