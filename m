Return-Path: <linux-kernel+bounces-211799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5380B905708
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D6B26C87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DA180A6C;
	Wed, 12 Jun 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjNn8WYv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E151802CC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206531; cv=none; b=ATWI33VC/pUfAKqhIcKZdvxbm6SWkXu9IjnePEj4OgIAf7uH8LNmM820SomaCrE70Z8JnRHB+15iRbn7ESFHsMRQOUFlRA012p+wFsF28efvgXaP4DiIoefckfdaC9oEpWWtdALEYRok6Jyc0IT17co7z+xxZsmA98FiABp7VMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206531; c=relaxed/simple;
	bh=/eth/rLHQaVXa5Gg6iEJQONz1lIgOpwaz6EWrI3kLxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I28x7hfXT9OXHvlHSxBBtqLeOzg+RNmiuZLlJmb+N/M8m1/DIApj4O8u1I8ELuqKo2SVRl6j4poV7Sw7hKIVUD0AEhG0EtrW1bFV6oNC0tm9QIt/nwxk0UPgpPIaUnLWzYdH41x00mHQ2/65SuoDQ/JBVTneJH+afGHKqdcA1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjNn8WYv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718206529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLPk25s5a0RpSrB3M9CtlVSrmFBRqAPSDQu7Lqf2nKs=;
	b=TjNn8WYv7s65Qe8aDAZDViKHrYOA+Zg1N1AnH4OI6XpTHzHSzalafNHAK8laoQTBfjOi2p
	CqpnjTZK8mlPn7AWPCnDf+kr6Iaqp4XULhV9NTb+wB0uxt3wS/eLMc7RpRXBOTd4Ml4PV8
	oS5/s1CmMQON3eaj4GQs9itTcgOxnyo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-ZdJTzZ4qMtmgLey7Pq_ipQ-1; Wed, 12 Jun 2024 11:35:27 -0400
X-MC-Unique: ZdJTzZ4qMtmgLey7Pq_ipQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f2730d114so436306f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718206525; x=1718811325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLPk25s5a0RpSrB3M9CtlVSrmFBRqAPSDQu7Lqf2nKs=;
        b=a8KCt5lFNY2go1okn4pkrLuCDggXdlLKR6ON5hcsQySQcFCqt5A5BHJU2vUG3Afz6V
         4r8xps8/MgLIXO+jQGOzikLYsmmHDYYD7vExiyVFBYjVDF0YVhuNprzqFpVGJIEpJg4j
         nSm7FTCzwao4Ck45QRPYpqe92DYQGakQ0y9qjRnicGbY9GoeJjXY3qi83OBXm59hCPhy
         Z0YE8e8PERuDKZKr48RkDThibGttwlQmZtUHw/w+Sbn3J7P3KKPsTTYanWfiSQ/+uoC/
         h6krjI7UyrCGIcx/2hQUuX4Ak5AO6febA9ISqmnkF7tT2/GsHKjdeJG1Y1rDmakYTAqW
         6UHg==
X-Forwarded-Encrypted: i=1; AJvYcCXW+GkEKQz6369DFBbM7VZES0hyXO/oruW86/GqtTXHoWqmpSiZJuWzpUSUARB3XZFcVUE32ZWUXpgoKex+eLcMpINvHvU+o1eeV7/G
X-Gm-Message-State: AOJu0YwB/bVs8zWLrHU4SPg6n0aG8m/wC8Gg7r0bcMKpT5VWrSkVPn9R
	v68XWD4KglIt6co175YibCSkH3sqI/8L17+iwijR94LEJPSZ1mYljwnVxW0q11lEhKbM0NdCT8b
	KlJ3I2gt5OwBWqB+cZOt18lTIOugXng9vUZpkzIiR1ZhGhjRanDCXSxwR1+WuIv1/uxVkLQ==
X-Received: by 2002:a5d:69c2:0:b0:35f:1c95:4042 with SMTP id ffacd0b85a97d-360718c9d97mr28086f8f.4.1718206525126;
        Wed, 12 Jun 2024 08:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtDkYfyxEJvsVijeUZeP0vECL4S57V/yigRw4w79fBzt8VAsMr+xkBwdMj5gMa5WMGHSk9JQ==
X-Received: by 2002:a5d:69c2:0:b0:35f:1c95:4042 with SMTP id ffacd0b85a97d-360718c9d97mr28048f8f.4.1718206524664;
        Wed, 12 Jun 2024 08:35:24 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef70csm31041305e9.3.2024.06.12.08.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:35:23 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:35:21 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rafael@kernel.org, mcgrof@kernel.org,
	russell.h.weight@intel.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
Message-ID: <ZmnAOfCUFkZqhDji@pollux>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
 <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
 <2024061245-kangaroo-clothes-76e1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061245-kangaroo-clothes-76e1@gregkh>

On Wed, Jun 12, 2024 at 05:02:52PM +0200, Greg KH wrote:
> On Wed, Jun 12, 2024 at 04:51:42PM +0200, Danilo Krummrich wrote:
> > On 6/11/24 18:13, Boqun Feng wrote:
> > > On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
> > > > On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > ...hence, I agree we should indeed add to the #Invariants and #Safety section
> > > > > that `->release` must be callable  from any thread.
> > > > > 
> > > > > However, this is just theory, do we actually have cases where `device::release`
> > > 
> > > @Danilo, right, it's only theorical, but it's good to call it out since
> > > it's the requirement for a safe Rust abstraction.
> > 
> > Similar to my previous reply, if we want to call this out as safety requirement
> > in `Device::from_raw`, we probably want to add it to the documentation of the C
> > `struct device`, such that we can argue that this is an invariant of C's
> > `struct device`.
> > 
> > Otherwise we'd have to write something like:
> > 
> > "It must also be ensured that the `->release` function of a `struct device` can
> > be called from any non-atomic context. While not being officially documented this
> > is guaranteed by the invariant of `struct device`."
> 
> In the 20+ years of the driver model being part of the kernel, I don't
> think this has come up yet, so maybe you can call the release function
> in irq context.  I don't know, I was just guessing :)

Ah, I see. I thought you know and it's defined, but just not documented.

This means it's simply undefined what we expect to happen when the last
reference of a device is dropped from atomic context.

Now, I understand (and would even expect) that practically this has never been
an issue. You'd need two circumstances, release() actually does something that
is not allowed in atomic context plus the last device reference is dropped from
atomic context - rather unlikely.

> 
> So let's not go adding constraints that we just do not have please.
> Same goes for the C code, so the rust code is no different here.

I agree we shouldn't add random constraints, but for writing safe code we also
have to rely on defined behavior.

I see two options:

(1) We globally (for struct device) define from which context release() is
    allowed to be called.

(2) We define it for the Rust abstraction only and just constrain it to
    non-atomic context to be able to give a safety guarantee. We can't say
    "might be safe from any context, but we don't know".

But again, this is really just a formality, the C code does it all the way and
practically there never was an issue, which means we actually do follow some
rules, it's just about writing them down. :)

- Danilo

> 
> thanks,
> 
> greg k-h
> 


