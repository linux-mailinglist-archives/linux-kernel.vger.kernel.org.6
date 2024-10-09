Return-Path: <linux-kernel+bounces-357977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44BB9978AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260E9B21F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEB188587;
	Wed,  9 Oct 2024 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws1X2Aiw"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ABA38DD6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514056; cv=none; b=NTmMupQG9AZbpnR24i16Fu7c/j3BC0ah5y81J+iJFX6amzYHWicHXpg2hoC6pLSqSuClYfaIvxCnB8oxddfe8oz+HSuEHY0FqJzvo2VHlEuQ25+xsBChhlnfkqT1MQOvrAJ+Yl13v22shgBokBqL76akeXjTlSh9WtSKepNeBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514056; c=relaxed/simple;
	bh=rKQ/7EiWM+14DprgcNRh2j9YbM9U6mTHjkfP6RNx+dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osS8WTZszj7nmzB/XOJOinV7sWvwRpiIzK8ypb9zRPgGD4sq8RRx5s/9CtJSsKLPR/OMp4Adgy7JAXSC5G2ON96u82RmJvulb5VnEzsmksuWMw0NyZifddkLtQklcATm/JeC2IjdTU8LFsYFyIye2yCpehtfE/ioQPTM/pq/Y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws1X2Aiw; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7afcf96affaso13102985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728514054; x=1729118854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD/taxiB32lIZLEVD63JN/O8iGf4YBa21I5+T7LszzY=;
        b=Ws1X2AiwXfxcEpplRmPffdz0xaL2Mx0R6ugX9IC2QNsZftPXO9IzXru4FXDyKvpu55
         MMtvrsfuT6HPw8rZWdK/esWLco8BlaepWZNL8NWZnSnCS5PnXC5WYGLxFfHPJ7ei1RtI
         iWD+l2GUZDI15fZlwRjZNVLdotQbu5lY7+DhkL7E4Z+g5/0gtnj+H8kMZf2OWudggtNJ
         KocLf990t7vlfo/VUlHOlvhzHbdfZm39iXByyxSyCajvr+CUcjGoMo0GnNw0RJt0AgGo
         0Rbqxf791NnkRoVtNlt8eIwNaTwYYeIoVmTBPWNoVJ1O64qYMkAo6s3TE4dhHhGh7qD4
         2vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728514054; x=1729118854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tD/taxiB32lIZLEVD63JN/O8iGf4YBa21I5+T7LszzY=;
        b=HyH591/pUhgAuVCvXn9Nq8VrFAuV1adl6TZoFVWQAJxqL68/gQwRnw7ofxPEQnkvAV
         A2JdfaNCGGlgWMJh078yiltXuBtDGDHEOieFSI27da+cfwUy3ZFlPqZlZOXzALYJRjc8
         jecJXfrNiWAMMvmHgptLFwee7L+DZnZ9IGRXL3kW7ihLyPem6F/xIPJsQcXbFDrShvYO
         GjegxxknDsqJH3rmUfgQRIlAlK3a1m3ycRYHWe8zIoGFRUEVXnJLiNREK9+j6yJMHMgR
         zqnqr9umvw0jTkWQgU47sgo2x0rrbY65ziijlTRTZgm07wCj4MuKYfZ+WeNPXHmvAaV6
         VD3A==
X-Forwarded-Encrypted: i=1; AJvYcCX+VLnHlF/Tr9eyqbwrOGhln4aRjMb7lencUQF9HmZw3zRNsUG4YZTJ6DOQdaBNSLUB0p1lzZPfu3QFljQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxshZPY9w9IsD724qWeMyuz1uepIArRz3el6P/KHrluKgC6jio
	640tOoE+WQezNuz3BwFhnHoKqIm6f4OwmJKJ60ps/3KLRO9Pchi2
X-Google-Smtp-Source: AGHT+IG8Yp3/vNWc1eVDjxHNF1J0kVXOD/+ZWc1QtlutbEWzZn6SSs9A5fEd+JETGfAPxWJo8KZwcw==
X-Received: by 2002:a05:620a:290b:b0:7a9:a810:9930 with SMTP id af79cd13be357-7b07953e0c3mr704660685a.23.1728514054096;
        Wed, 09 Oct 2024 15:47:34 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c70basm1288185a.7.2024.10.09.15.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:47:33 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 526AF1200069;
	Wed,  9 Oct 2024 18:47:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 09 Oct 2024 18:47:33 -0400
X-ME-Sender: <xms:BQgHZ8FuoM8r3h0JC0NxBXZrnKQOTJxb7boOSHMyh2CKRfwmqC8Cmg>
    <xme:BQgHZ1WqskpM_yrLO0gY1d5yrNwRY9Hp5lLO7btzyAiicMZfYqcopQM9TNmPPIsii
    Ec15m7P8enzOOwx7g>
X-ME-Received: <xmr:BQgHZ2I81wav1NXzesgQIcFzlQmRReh3Xnil-S36fJy-AK-bk7dydhvQpiCreA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hllhhonhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopegsihhgvggrshihsehlihhn
    uhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    epthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:BQgHZ-EtIDXpdXpqv9ceJJ_B96_ijfkKBq2zCiE58afiunp7kxk8NA>
    <xmx:BQgHZyVzmy2fOBpZJ4BFkzuOGQpl_b2M0pV_EGMDoxMGlFlW9jF8hg>
    <xmx:BQgHZxPhpdGiphFSBzsUVgyEcHCkoWY1RVD48h_pgDiOYaiWzpz7xQ>
    <xmx:BQgHZ514-bVbiqqN1UEQkkFDplP9tDaxdOcul5N2LLPEHsJY9AJpSQ>
    <xmx:BQgHZ7U1Av0KCw2GZfLfXTd5d_NwHZE1Rz1VApuQDY14Y71CsYpH9YMY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 18:47:32 -0400 (EDT)
Date: Wed, 9 Oct 2024 15:47:29 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] lockdep: Enable PROVE_RAW_LOCK_NESTING with
 PROVE_LOCKING.
Message-ID: <ZwcIAS-P28BQIAUx@boqun-archlinux>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <a323429f-66e8-4951-a674-54dc25429a15@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a323429f-66e8-4951-a674-54dc25429a15@redhat.com>

On Wed, Oct 09, 2024 at 12:50:39PM -0400, Waiman Long wrote:
> 
> On 10/9/24 11:45 AM, Sebastian Andrzej Siewior wrote:
> > With the printk issues solved, the last known splat created by
> > PROVE_RAW_LOCK_NESTING is gone.
> > 
> > Enable PROVE_RAW_LOCK_NESTING by default as part of PROVE_LOCKING. Keep
> > the defines around in case something serious pops up and it needs to be
> > disabled.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >   lib/Kconfig.debug | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 7315f643817ae..5b67816f4a62f 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1409,22 +1409,14 @@ config PROVE_LOCKING
> >   	 For more details, see Documentation/locking/lockdep-design.rst.
> >   config PROVE_RAW_LOCK_NESTING
> > -	bool "Enable raw_spinlock - spinlock nesting checks"
> > +	bool
> >   	depends on PROVE_LOCKING
> > -	default n
> > +	default y
> >   	help
> >   	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
> >   	 that the lock nesting rules for PREEMPT_RT enabled kernels are
> >   	 not violated.
> > -	 NOTE: There are known nesting problems. So if you enable this
> > -	 option expect lockdep splats until these problems have been fully
> > -	 addressed which is work in progress. This config switch allows to
> > -	 identify and analyze these problems. It will be removed and the
> > -	 check permanently enabled once the main issues have been fixed.
> > -
> > -	 If unsure, select N.
> > -
> >   config LOCK_STAT
> >   	bool "Lock usage statistics"
> >   	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
> Acked-by: Waiman Long <longman@redhat.com>
> 

Thanks!

Queued in my lockdep branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=lockdep-for-tip

will send a PR to tip between -rc3 and -rc4.

Regards,
Boqun

