Return-Path: <linux-kernel+bounces-536926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB46A4860E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F95617B373
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACED1CB9EA;
	Thu, 27 Feb 2025 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esdqqd88"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72221BCA05;
	Thu, 27 Feb 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675316; cv=none; b=K/ALe1wQ+vHn7OlkuUyOYL9FQKdJzUequt2qJ9wwVcR65Hteldyg5pu1aG8RGlRV1HKKlI5pW3V1WdTSYAhAznTYuASMC9oqfq9YkruHVvGMz3eDbnt2P41PcBN0ItZvk9f52A7qZ6OND5pLv4Mm1H/wNWFR2VMlFhA90SmB9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675316; c=relaxed/simple;
	bh=Q6r7lq6fDrgjS7IbvymC3A/zoQkNQP7m2zNY8NgX704=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq4JvY5Ui0wIVxMulEnxpNSdfmwBnp3vjiOlFdjiACSZAcsdozDxwuSBA2TzLHGnWw6+ZFXlcF65dtGCfhxx3lJEm06Wu5puDKP6+dmn2v3dpFiSjDFqZqylzE6zyZlwudrNF7Y3Dyiwo7r4S7BBTT0HLS/SvJdDqS4zKVI5yYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esdqqd88; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso18038306d6.2;
        Thu, 27 Feb 2025 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740675312; x=1741280112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=980w1YB2itkCLikkG2aaoTrs25//o08fnkucvOSS5Ig=;
        b=Esdqqd88GBJzj1KRZmgwGeDaaRAj+2ucgTzvCDAYqntLh+Yb0ChPFIrpfUkUaGYL7I
         hHD+3zyca3LX72aAbiw9FLCTDrpKkz1ZxWza1YpKpExhxepg8JqoOzftIkKacA1Kc/1T
         9Lwcbfo1qDAPVBTnvTzvRHQFR6kB7TQhnFsWXga/nfT6mZ6U4b4nhdixQECy9inSOkdj
         ZGssG9BSCuS5Ts73kAzdT8aPbqylP0V5jW96NjyeVRjtAwVUDt0IwqfaQDzzTA5o8/WP
         hGU2DSM6+dwVRYF0bHwbz76Jwup0UfRxKbuVWxQiTFYU54XarSM0SKYzo9Xt0M+5auHs
         TUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675312; x=1741280112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=980w1YB2itkCLikkG2aaoTrs25//o08fnkucvOSS5Ig=;
        b=AeP8LiCI2gPdPB6JTBXzGkSIzFcolc99KZfjlqXIrGkFiUpDZrTGE9VBKCwuKmfAf5
         xxi7xLVDaz+2kToHhzNqxZ/Zi72MtdQybVbUHQ4sKhI7lHTzDBQGZSFDrYLm+5aC+7y/
         Q3+rR4FRZAlRFAtWy9ocLEAMFzTQtel3GAfpFXiDntnmgZz9NI5irQrdNjlS7KRUBFtS
         G3HSWQ0ZLMJl5T/R6NkA6PuVf7mrInhfxPRAtGmAh8wrP7l7+P2LW0QVLL49Cu3yc3ar
         rSbVNcqx7zWbuGN/sAHx6Jwp5DEpstLW+Ha8zUIvRVm+C9gWvMVRK0UDyKwFq1T2u9FP
         nMCw==
X-Forwarded-Encrypted: i=1; AJvYcCW1GV9G4EW/ITiaSe0LV+3OY2e6je/vWTHWmuy0aenfGdW2XzHlLBbDrm9hs44c/C++DxUos+8J+nQQkasm+lM=@vger.kernel.org, AJvYcCWDBDJZe7wwdN+XwPiwZL6HLPNma/FZsRxyiBqH/i53GwUH32YX7um4G3WzGGjA9mjKo8ayhiYAiQRLdkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxObDsoNTRaokqc9ift4Gl4xJx5mX7dOTDjcyWZ+CaoVRXCa9X3
	ItREkS12i2ygMT7MVWGebqW7f2vUO16TOuEN0y0b/l69ihHkE24a
X-Gm-Gg: ASbGncsUFaNVaIsJ/HIEdZhsfdlfqijhn9xbgTs1+Zw3SAQUn41l59SEGUx00iKj9eV
	JE5+HUicn9xgJ730a9iMmAJsZlzoIh2+2gbN7DdNmL69pY7C7rcKwch9NK/FK0Oq5WmudEsX6sb
	0qz+oPDww/pSYN/CgDFSwwaXxT7OtgCOAR2VsBiXaUkMWf/uxe7NgOcwgd3psRZkH2sB6dutiF2
	uhakJs4w1lefGUVwCm1LFuCXNF3zEurygRW8yCJ7ZlyqghwQO7ZgW+h7P+g6PGIbRXlO9lDCuv7
	f3UrDx2+g5sdtl6CEri5flqXlRtV4Lg40ZWz17yZmQpkMVFUC4arIy6Bfo/iN5pAbWCpHwqs4CV
	TaGMD8s6PCtJI+Cg6
X-Google-Smtp-Source: AGHT+IFZH/bq4PBfo5JkoQRcCnek7eycxVwpDI/O4N5aADIrrRHM4Y9CBi8g17hXzU4f1wl6FDEpXw==
X-Received: by 2002:a05:6214:21cf:b0:6d8:9960:b063 with SMTP id 6a1803df08f44-6e8a0cbf934mr2932786d6.14.1740675312516;
        Thu, 27 Feb 2025 08:55:12 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccaefsm11596906d6.74.2025.02.27.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:55:12 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 835DA1200043;
	Thu, 27 Feb 2025 11:55:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 27 Feb 2025 11:55:11 -0500
X-ME-Sender: <xms:75jAZ0WzKQvhc3t7LIKrUC2t4q9d1dfnASwGx_e20ITekrwy_i05Rw>
    <xme:75jAZ4luY5ksvMI3XAy6dKs-nt-lDRBOPsTAm6f85XgyHKuTcJYYW7iZ58yWWz9m1
    rDWJsXGiQM2jVMXTg>
X-ME-Received: <xmr:75jAZ4Z-UVB6mx_2UxOMWjchVeST-YtAkTQporvT4fHwuMNcr4IFkqJ7zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhgrghhn
    vghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprggtohhurhgsohhtsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepjhhovghlsehjoh
    gvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhhuhgssggrrhgusehnvhhi
    ughirgdrtghomhdprhgtphhtthhopegsshhkvghgghhssehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:75jAZzWvyoa746mp6f3kYrg60ZJZebGajSgx6zGAZ9dhRokOSlqtFg>
    <xmx:75jAZ-n71TRELjp0KTgB60thZUKAaY3jnfUSjQMs3Um6gKwAJUt3eQ>
    <xmx:75jAZ4c0IomtWna8NCV1c6DBn_b2JZOkiCyqNtUaI-hDqDXDDEndQg>
    <xmx:75jAZwE50w-W2YitkacjsQX4-IR1OrMMQd063Ohlo83o9Ui9txhhjA>
    <xmx:75jAZ0n4wvVIvs8zW-nwIKsIS-pIhYQt33C9iJbOOqUrWQB9hKvbKt0O>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 11:55:10 -0500 (EST)
Date: Thu, 27 Feb 2025 08:55:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z8CY7fqbtbO4v1jv@Mac.home>
References: <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <Z7-0pOmWO6r_KeQI@boqun-archlinux>
 <20250227144618.GE39591@nvidia.com>
 <Z8CCKl_yA74WjpQ1@Mac.home>
 <20250227161733.GH39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227161733.GH39591@nvidia.com>

On Thu, Feb 27, 2025 at 12:17:33PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 07:18:02AM -0800, Boqun Feng wrote:
> > On Thu, Feb 27, 2025 at 10:46:18AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Feb 26, 2025 at 04:41:08PM -0800, Boqun Feng wrote:
> > > > And if you don't store the HrTimerHandle anywhere, like you drop() it
> > > > right after start a hrtimer, it will immediately stop the timer. Does
> > > > this make sense?
> > > 
> > > Oh, I understand that, but it is not sufficient in the kernel.
> > > 
> > > You are making an implicit argument that something external to the
> > > rust universe will hold the module alive until all rust destructors
> > > are run. That is trivialy obvious in your example above.
> > > 
> > 
> > The question in your previous email is about function pointer of hrtimer
> > EAF because of module unload, are you moving to a broader topic
> > here?
> 
> No
> 
> > If no, the for module unload, the argument is not implicit because in
> > rust/macro/module.rs the module __exit() function is generated by Rust,
> > and in that function, `assume_init_drop()` will call these
> > destructors.
> 
> That is not what I mean. You can be running code in multiple threads
> from multiple functions in the module those are all being protected
> implicitly by external C code functions. Rust itself is not managing
> module life time.
> 
> Then you are making the argument that everything created by a rust
> module somehow traces its reference back to the module itself,
> regardless of what thread, callback or memory was used to create it.
> 
> So all bindings for everything are expected to clean themselves up,
> recursively.
> 

Right, that would be the most cases in Rust if you want to control the 
cleanup orderings.

> That does make sense, but then it still raises questions that things
> like workqueue don't seem to have the cleanup.
> 

It was because the existing Workqueue was designed for built-in cases,
and we should fix that. Thank you for spotting that.

> I still wonder why you couldn't also have these reliable reference
> counts rooted on the device driver instead of only on the module.
> 

You could put reliable reference counts anywhere you want, as long as it
reflects the resource dependencies.

Regards,
Boqun

> Jason

