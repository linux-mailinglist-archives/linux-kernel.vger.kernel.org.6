Return-Path: <linux-kernel+bounces-347201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713E98CF65
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB431C221AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2335197A66;
	Wed,  2 Oct 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrImwCSL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD833195FEF
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859681; cv=none; b=ocPE0bfyWwuOGri3jWIaFSSCKe3Ythpd2JORmKNBA8+M3+KUPEId0UNvLxdNpDXSquVKmCMHQduvJAUZ8e070wSncBsobDwpsy/UIVcxc+xVUPpwNy6Rvc4jAvltUwdIcuSSCUPmgIuPByMWiwNfYI5gVGcdZDnOd8qEb1UmlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859681; c=relaxed/simple;
	bh=o7Hs3p5kzPl0PCLFLFRNhiRRnoslwIg5x3LWSomZSNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDHLLenuKV2QWUZTzOdGQdH4bL8zqZnW7UJsw2HO0yW3lL8po3N6fUShYgSTwo37D8jj1t7iFHhTeevpXj98lwCl3Cy8h23sYn19Ph1hEaP/8ou1CYKN0MMh5f3iK3JAtqKPdag/YsvtEGobnqHIbCzmf/W5QZBjWDqGXa83XB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrImwCSL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727859678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg3hLBpw2lXNlF6GTvj5Bh0oaVkp6KYwsqc2vlIMji8=;
	b=LrImwCSLy2K96douieTKFecaLu5upvo9978aMLkTo7tpbdoQjM2MwlhoWmdLc9i6mBN1gt
	bzBSJeLGO8wJASCN73vzwvD24OPNzuc+Ur19ldUfZqDV6YBsTQsaLZSPWEYc29UFzNj7gp
	Bx6kFi0W5w05OHnvXlunu4BKvnG8KJ8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-Uf86hJObMEexsARoYseOsA-1; Wed, 02 Oct 2024 05:01:15 -0400
X-MC-Unique: Uf86hJObMEexsARoYseOsA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a7f3f191dso38869666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859674; x=1728464474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xg3hLBpw2lXNlF6GTvj5Bh0oaVkp6KYwsqc2vlIMji8=;
        b=W0e4PqdthX2194b4khqW+t0Nv8ctgAJAGMuGWkGnLqClJxrX4IITUDCBm975bjNYf3
         X5xhFwylM1Y7X9Ds0D6UNufJyx4+/mE7dzBMFZTaUb0euQOuPg1i4qyOjkj1vg9pkm/I
         PaRmyXsbK+tZ0zvq329WS5+zxCIx/GzsqG0yO8UPh4ssVOCswoWW84mN4zUI1Sp7dhgS
         9y7S3TNkm5bL9Ig9hnb1kebDlBDw6ogSCjJ1nRy4Q1Wrclxz7sSw324w3Nb5sLKM2XBJ
         E0zU0ANljZe+ixtdZAoZ1RqOf9OkTc8l2JC+lvy+Txec6fNonD5oNZu7yG9JSdB7TBKV
         1Pbw==
X-Forwarded-Encrypted: i=1; AJvYcCUyzUi2SPfSGxIEycboUeJ8WuLQjWGzxgI9EkyQh/B8d5ZNvqJgFVX385dr7RpQtFpxwpVv8ZrHcnzozhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXh41LHnMHiDih8cDE0Job0QKKCkRXuRDsZ6lD/05ClRsUpI0
	/Dg8Au4uNK6eegZXQPT6jMihiDVCCDkh3Z7SM+QI9wA6Oz73WSngprNN7aRVvIk6TSn/nsR30f6
	84IiSJOwdQy6jnfC2vBr3vPhu5NUSNun3s6DdcmW4OE4mi0v5mzszr42kGJSXNo89Jj12NKG+Vd
	V9Pt1K2tqO0idv3h7Vhmt2GiTFw0+tl3GmMX++
X-Received: by 2002:a17:907:3f25:b0:a90:1ed4:dec6 with SMTP id a640c23a62f3a-a98f836ec85mr276957466b.43.1727859674399;
        Wed, 02 Oct 2024 02:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1DUJZ7WWAEYAEDtW3rfoL7KwkxfPpeY/J1soLKL+cyng1nlALwHtjzI7myC7aEkqXfEcFzENfHkk52JC5K8A=
X-Received: by 2002:a17:907:3f25:b0:a90:1ed4:dec6 with SMTP id
 a640c23a62f3a-a98f836ec85mr276954166b.43.1727859673929; Wed, 02 Oct 2024
 02:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xhsmh1q27o2us.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <cc537207-68a3-4dda-a8ec-6dda2fc1985d@paulmck-laptop> <250cde11-650f-4689-9c36-816406f1b9b8@paulmck-laptop>
 <182ef9c6-63a4-4608-98de-22ef4d35be07@paulmck-laptop> <xhsmh34m38pdl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ac93f995-09bc-4d2c-8159-6afbfbac0598@paulmck-laptop> <43d513c5-7620-481b-ab7e-30e76babbc80@paulmck-laptop>
 <xhsmhed50vplj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d6033378-d716-4848-b7a5-dcf1a6b14669@paulmck-laptop> <xhsmhbk04ugru.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <64e92332-09c7-4cae-ac63-e1701b3f3814@paulmck-laptop>
In-Reply-To: <64e92332-09c7-4cae-ac63-e1701b3f3814@paulmck-laptop>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 2 Oct 2024 11:01:03 +0200
Message-ID: <CAP4=nvTtOB+0LVPQ=nA3=XdGLhDiwLjcLAb8YmQ+YqR9L+050Q@mail.gmail.com>
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
To: paulmck@kernel.org
Cc: Valentin Schneider <vschneid@redhat.com>, Chen Yu <yu.c.chen@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, 
	linux-next@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 1. 10. 2024 v 18:47 odes=C3=ADlatel Paul E. McKenney <paulmck@kerne=
l.org> napsal:
> Huh, 50MB and growing.  I need to limit the buffer size as well.
> How about "trace_buf_size=3D2k"?  The default is 1,441,792, just
> over 1m.
>
Yeah, limiting the size of the buffer is the way to go, we only need
the last n entries before the oops.

> Except that I am not getting either dl_server_start() or dl_server_stop()=
,
> perhaps because they are not being invoked in this short test run.
> So try some function that is definitely getting invoked, such as
> rcu_sched_clock_irq().
>
> No joy there, either, so maybe add "ftrace=3Dfunction"?
>
> No: "[    1.542360] ftrace bootup tracer 'function' not registered."
>
Did you enable CONFIG_BOOTTIME_TRACING and CONFIG_FUNCTION_TRACER?
They are not set in the default configuration for TREE03:

$ grep -E '(FUNCTION_TRACER)|(BOOTTIME_TRACING)'
./tools/testing/selftests/rcutorture/res/2024.09.26-14.35.03/TREE03/.config
CONFIG_HAVE_FUNCTION_TRACER=3Dy
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set

>
> Especially given that I don't have a QEMU monitor for these 100 runs.
>
> But if there is a way to do this programatically from within the
> kernel, I would be happy to give it a try.
>
> > Also I'd say here we're mostly interested in the sequence of events lea=
ding
> > us to the warn (dl_server_start() when the DL entity is somehow still
> > enqueued) rather than the state of things when the warn is hit, and for
> > that dumping the ftrace buffer to the console sounds good enough to me.
>
> That I can do!!!  Give or take function tracing appearing not to work
> for me from the kernel command line.  :-(
>
>                                                         Thanx, Paul
>

Thanks for trying to get details about the bug. See my comment above
about the config options to enable function tracing.

FYI I have managed to reproduce the bug on our infrastructure after 21
hours of 7*TREE03 and I will continue with trying to reproduce it with
the tracers we want.

Tomas


