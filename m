Return-Path: <linux-kernel+bounces-536665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB88A482CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844EE16B257
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044126AAA3;
	Thu, 27 Feb 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbxGZtP6"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A825EF86;
	Thu, 27 Feb 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669488; cv=none; b=eSob+G+/PH7Rr1yOgNkbeuSWAa6+B2OZp3NxwiVxbEBYolFllyxJ5+nX5DBksL7lztEWVqk0XoJE/SA0SWkQ53bAUdjBF7SQgN7q2f/IgO5A4RtTsx+Erafy+D0hsnpFnDGDPLggn0+kKdZ2yGIuzsR2kGeE/VmyjBk5d3X/Jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669488; c=relaxed/simple;
	bh=6t5Fap2+DkrrxA8hPtgQtWQe5PBFSXmY2/OBWqSbOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWFIS3ns3ASGe/J4BjVlkPEbyoHs3FXbKLeqpGKTGnj0EjaEsfOSePfIux0ik620w8l6ammtAmJt6tF8KaATJnBFjBgytjctsJOZjvg0UFkWUWoqC+61xt6aQhvRzZkcO5Y5YQnxFxIi3OdL7l10kiWrWmVQFum8Lxu27dhDcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbxGZtP6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0ac2f439eso120931085a.0;
        Thu, 27 Feb 2025 07:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740669485; x=1741274285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGggIkK/XZzPteLqAYumoxClI9/TZi6ilC7vijsxqiM=;
        b=jbxGZtP6HEJFGjzYfRVOTtmzHcFyjh2MqVMOvShwHCw5w8sMTDLMGQYRrmxnJCZEnE
         dYGMzPanjTvEQkDdOqBKQas2D9RguhyBHc0/ofyNBw4Pvct9A+xdYqcnHHij7grdn3il
         k0ZrDi8kHM+QlhRNJzPM2L1GLxGuEGeHRr431ezKlw1A1FcYR7e8BFqkYMQKrnGkCbds
         mxCaeopt1Kl9ooCJ0VS063DULFPRCvFS3vuacpygKpK8RS8kreLYkX41jr+dGsJqJZ5s
         4gyhYBHgB1+ynNJ7I+PbuvKasUwAwgq3Eiwsr6xs4XwBB2YZAtbTUL79uCbuaqYXUGnz
         rsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669485; x=1741274285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGggIkK/XZzPteLqAYumoxClI9/TZi6ilC7vijsxqiM=;
        b=Xd/mt3ofCp3Kp+vDKrTVqp+Es60niq/BZeILuDZKMeQPK6xs5Mp/Hxx5xrepO2TOVZ
         CcGKHleRdjIZJEH4AsUeHBKgR/OHXt86rGgI/cnCMGTy1hRx1rgwKWX7bgYfl0gc0rry
         fiKJ1girV3c62EiRfCKEfbLDYdc/EsECZBXKPrwR+8cNGRHXzIqdpMSYv9u2UL1GBmR9
         B3rSU4J7lGTpjFTe4vYBNxRXeldg0VJzzYbkTk1/VkIj4q7cjuxSCxl1fN5CCkGNmO5R
         U0uE9318jnHNEk2pUzpc2mBIbz66B73qBA3sOEc8yzgCNwnIJquzCVoa92kUdugpv2nJ
         /z3A==
X-Forwarded-Encrypted: i=1; AJvYcCV1Zo+Z8G3d7NVWpgNMfIDQUGlXAY/QJbrWcfKxjmEJTWdXR7eBgJCF6iC7tR5IhagpJXO1DFiFBHM2635r0Yc=@vger.kernel.org, AJvYcCXjDYI6MxwVtys3koiQNhFqXqlLOgamhFj9ImZiDbBBY9lFIWy9hR1FuXXxfltvLIAaUKyczppfKbX8G5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YynpEbjaW8fypEWX72JtXdlipiBLjVd9lpRuBBQBkYREvQBdhc+
	lee+p8/LHKeJIEzaZAi6lpLEBcRsj844DcOeoKwCu1osRUkreJHd
X-Gm-Gg: ASbGncsM98p9BcENYdtJdXY51AEs3Iz6Nq4GdnsraQLEcc6cYU4M43pWuiNzbIw7y0m
	lXKtfNCXsuE4PiWDfvuJU0YfRx1ppAcVSOZOmCUmWIAbNINuiAdTu7+AhZgiKuf9Bpjr8kVHuW9
	jT8PtSxW80tgu+zHrpYE9pfBgbKZiiTC+3eMFuJaAk9UbgWpkhoELHCga6IriMOO1CBJxVezirY
	382qa0RM4vCV24oXiIFcJs2vRPspsI5A3ve6u629HXqcV51eqYlyqZ1QPCBOERinvr0qUuE9gqr
	Txe/4u5PoW5B/tiSFcLYq9d5P5vL5PtppSfmabyiH3oo0CRHHprIePDr9+QskuDtXpLNXY3pnuh
	G6V1Us/JOoaEDh3a2
X-Google-Smtp-Source: AGHT+IEq6UiJGiAn5J8WLSyd0NSIn0Gz699g7En/BXC3Xd/QEAVezFlMxxou7MPtwiZYDc1OaY4iKg==
X-Received: by 2002:a05:620a:4508:b0:7c0:b7ca:70ec with SMTP id af79cd13be357-7c0cef4853emr3674139285a.41.1740669485263;
        Thu, 27 Feb 2025 07:18:05 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9fe36sm115572385a.83.2025.02.27.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:18:04 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 46794120006D;
	Thu, 27 Feb 2025 10:18:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 27 Feb 2025 10:18:04 -0500
X-ME-Sender: <xms:LILAZ_0n7FGmGJITqMKE32EJqDyy7Mzle5qLOF40jUOUKhGz5PUfZQ>
    <xme:LILAZ-FwrJixiSMy0LZApN6iZ3P5tpinDuFaAS_OzCXV9t5zpdL3s4A-476yKgaoC
    PPcnauyTW5KvJH0jQ>
X-ME-Received: <xmr:LILAZ_6NohMDVnPg6nF5cxXv5QjESw3A_S6s5LSYVBgruahHifKY8yP9UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeekudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:LILAZ00V1NaJ4mvj1-dwMWGjY-pTlO3NLGn9enWCsVKsRyR1AXVXDQ>
    <xmx:LILAZyEEsKioUNzF4sPKjWl06vG3bhu69SMl19pvBls-9V4UOFYQuw>
    <xmx:LILAZ18E-uNORxHsgOKOQ3JOtrZTzPTOr4UiT0IRx0C6WLcEXbJZkA>
    <xmx:LILAZ_nHko2mGSrMEiqf4tOvdP9950Gc_aexl4qnzS1hufAHlKN0-w>
    <xmx:LILAZ-GnZXcGVrbFPYhz1nd--0hhGxQeONVznQF9J2ZrcQii6wBtc808>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 10:18:03 -0500 (EST)
Date: Thu, 27 Feb 2025 07:18:02 -0800
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
Message-ID: <Z8CCKl_yA74WjpQ1@Mac.home>
References: <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com>
 <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <Z7-0pOmWO6r_KeQI@boqun-archlinux>
 <20250227144618.GE39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227144618.GE39591@nvidia.com>

On Thu, Feb 27, 2025 at 10:46:18AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 04:41:08PM -0800, Boqun Feng wrote:
> > And if you don't store the HrTimerHandle anywhere, like you drop() it
> > right after start a hrtimer, it will immediately stop the timer. Does
> > this make sense?
> 
> Oh, I understand that, but it is not sufficient in the kernel.
> 
> You are making an implicit argument that something external to the
> rust universe will hold the module alive until all rust destructors
> are run. That is trivialy obvious in your example above.
> 

The question in your previous email is about function pointer of hrtimer
EAF because of module unload, are you moving to a broader topic here?
If no, the for module unload, the argument is not implicit because in
rust/macro/module.rs the module __exit() function is generated by Rust,
and in that function, `assume_init_drop()` will call these destructors.

> However, make it more complex. Run the destructor call for your
> hrtimer in a workqueue thread. Use workqueue.rs. Now you don't have
> this implicit argument anymore, and it will EAF things.
> 

Note that HrTimerHandle holds a "reference" (could be a normal
reference, or an refcounted reference, like Arc) to the hrtimer (and the
struct contains it), therefore as long as HrTimerHandle exists, the
destructor call of the hrtimer won't be call. Hence the argument is not
implicit, it literally is:

* If a HrTimerHandle exists, it means the timer has been started, and
  since the timer has been started, the existence of HrTimerHandle will
  prevent the destructors of the hrtimer.

* drop() on HrTimerHandle will 1) stop the timer and 2) release the
  reference to the hrtimer, so then the destructors could be called.

> Danilo argues this is a bug in workqueue.rs.
> 
> Regardless, it seems like EAF is an overlooked topic in the safety
> analysis.
> 

Well, no. See above.

> Further, you and Danilo are making opposing correctness arguments:
> 
>  1) all rust destructors run before module __exit completes

What do you mean by "all rust destructor"? In my previous email, I was
talking about the particular destructors of fields in module struct,
right?

>  2) rust destructors can run after driver removal completes
> 

I will defer this to Danilo, because I'm not sure that's what he was
talking about.

Regards,
Boqun

> I understand the technical underpinnings why these are different, but
> I feel that if you can make #1 reliably true for __exit then it is
> highly desirable to use the same techniques to make it true for
> remove() too.
> 
> Jason

