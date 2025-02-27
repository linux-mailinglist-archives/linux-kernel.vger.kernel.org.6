Return-Path: <linux-kernel+bounces-537318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F2A48A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B226F188AE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42E27126C;
	Thu, 27 Feb 2025 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/RG9RAQ"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35B1EB5F1;
	Thu, 27 Feb 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691562; cv=none; b=OZmkP5+HSe01w6Pb9dBeRmXq32St2BiznvIkhpUd/G1qqEYixo+bX2CMs5GRDxDNepBLK63UpD8yUCm+wrEHC0j/en1B1seMo0XuWn1hPfHnbFd+WuX6hsquZMG0CvU2zpD+dl32Uu5YsVFat933hMMYd9Qx5TCk8Ci/7+6ZlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691562; c=relaxed/simple;
	bh=BnRT0agxpjJu/+j+sV4LZsUmjuzv8f7CPDnkH+dM3Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb2tIp9+FNygQc/o61Ua5uEtM/K//RPAHweOWiab/9FnVQhM1J8RQafX61sCHirU0xHjaXH6f6DvHzx1iI8ecP8jGt5dlJ0Zm/acfOlZr2y6FKGXv8inha/1GOzsE8Pezlj6Ims889oycZASkdpGrEbtUSdyaIlIzTU0BBexza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/RG9RAQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd15d03eacso14510836d6.0;
        Thu, 27 Feb 2025 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740691559; x=1741296359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UF7O2o8LV3sBQN2Z5pMzAnL0OBwN8vfx4Qu6oNc5dM=;
        b=S/RG9RAQ5LweMuTqvpueUUdepQKap7xzOAS19+kR7xPPCH6wnJKh+B00S0vetb4j0A
         3EiOe9E5r1XbzFpuXhykQDYK8V2ooxB5S9YOu7qaX9JcA/pNrlIygCqy9XSevD1tZP/D
         gekQZ6jsW1uDwts0nVD+OgrdHxIiP68sMNfixUKHBbaJkUOPeOUeK1G4jpT8zA0xmJYQ
         z6T2rb8QXd/Avip8DaJ25CEKRv9oEGNEgibOojYlB/DvIAtlq489O0732ocLSqU2xv7c
         IAMYh/SxSL3wpphtBQNk2VOwrkVN4mnHsauJ2ZspXwWRgtyU4Zxf0RQADteiRZIWQ0l9
         ApbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691559; x=1741296359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UF7O2o8LV3sBQN2Z5pMzAnL0OBwN8vfx4Qu6oNc5dM=;
        b=n9xk2ZcPWTs+5+lo+dz8r8u6vPPda2sh/5Oq7ET6ekDXuiWqnfRzE/6dyGwkoq4nvz
         yZxtVMaAPR9+w7W3fxothbZwrhcpFx515hSTWbOr3+ZCOS0iIJ+6dKhFOVpmnlbQAki5
         g4HllbA3dGPxFMlEFLwmYq0S2+6PFALENfcgK3t1Ml5g+5zqBzhSwekrSvFpKCkn7l9D
         diCP0Mspd2LEy3Wff+jDew/uo1OQlqVl4Rk4l2dv8+v1twHFUcdDAubz6B9uoMauhQsI
         s04j120rp80FlceRQFlYxmZuQHkSGdLYwEde45NxtYLvtd3lOH7SZ10W8qusEXAWkPmi
         aEXw==
X-Forwarded-Encrypted: i=1; AJvYcCUKosZILYKJu+0IJ9eYDKxoyTt8kr8qOs39Fi2lwluD4oLKmIAcJdlobrkha+DaZW01WtiM3mcmSgOKcnJDOlA=@vger.kernel.org, AJvYcCXeEkyhgtySDRm66lhGl3UJI1JZyr0FjO7N1RxP9BJKMt+cxCuahmeYcfzJXQhkJtNZMTFHk6bmENfasVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Gbhw+m+p9j4s9eHhL1lNSwJQg9mdXWjueuRdiIayg/FmACnq
	KN0kRgKOIYfF1r47E0MBAEtH7FIskjjVWOEjtdz0vikXS38BvZKK
X-Gm-Gg: ASbGnctjtm45RtX0eA+XDR4UTpBUwTf1VkcIVOHDBdfAw96YsjpPdABpSNHC4CCR8kk
	bmrE6lh4JZ/2K2RfK77BakDU9N8txuz4/BvKcKRMAtMiSXHmr6uQLfSOFcPs0srkdbHyG+t1pwy
	+J9MDi6d6OwfwC/IUBPEwvA3J4IAuwcONVwK1XzKc3kX6u209bXGa01M/2YdFaGyxmJW1ZrMln7
	tfXj0Bdz/kJMTb2QkfFL+ZN0Ke0U8fVNjkkgk6xTbP7SSrVfHIvMNCQLoq56i/YnrXYrAFxxTmJ
	IXE5dukTfjPzPUy0l83nOhpkuVvh+qlauC/FeIgAtWs0L6i/pcT6kwQR1WSceyRvFao4L2qpCB4
	wV2a+UbSSvby1vQ+n
X-Google-Smtp-Source: AGHT+IEPDOQ7BZ2Sbx86St0jP2+DOKauK3d9nYm7k7AYGnZ2YAad8o5P61Ob7AwAw8Bjzh+SoVipww==
X-Received: by 2002:a05:6214:2aa8:b0:6e4:5a38:dd0f with SMTP id 6a1803df08f44-6e895798e25mr78217746d6.4.1740691559215;
        Thu, 27 Feb 2025 13:25:59 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89766087dsm14124836d6.52.2025.02.27.13.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:25:58 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 32F7C120006A;
	Thu, 27 Feb 2025 16:25:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Feb 2025 16:25:58 -0500
X-ME-Sender: <xms:ZtjAZ5xiCQj1tMhaxghzhrNFsXc0VYP-45C8hZJpzVts_mPyzLI6ZA>
    <xme:ZtjAZ5RAXVI0ln7niV2HDes9T-ndIGX57kNI1tqAbzP8GHwsmqvmH2T21mfxi9onf
    SPhQawZhkLrnSwV9Q>
X-ME-Received: <xmr:ZtjAZzXPibEUnw8gs_pK9FWxq3GpZvvNGu8T6Xre1aa3fhtObNNT_UHYQs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeehhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ZtjAZ7hDlqdN1I5R7i4hpxdt_QE8BVIdqpH1m4SFCGUhSpHlUsdb-g>
    <xmx:ZtjAZ7DptZWXmZMeZ6xDEnwJV0DYHrTujc3EL3aRFuW56V2GXN0DCw>
    <xmx:ZtjAZ0I8j70c-gvzPmtP21DJefEBUeHAtRm7OYjzNOS14hgzgbCDVw>
    <xmx:ZtjAZ6CFlaGMj7OZ24M6YZ6jF3FgQ3jFPnAVwHVbLwl3HX70SVON9w>
    <xmx:ZtjAZ_xx6BrgASXaWs5JOVwRlPZp3ATVyj0YMbg6d_eL6dsONWdXTO-S>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 16:25:57 -0500 (EST)
Date: Thu, 27 Feb 2025 13:25:10 -0800
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
Message-ID: <Z8DYNszfONdsKZsl@boqun-archlinux>
References: <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <Z7-0pOmWO6r_KeQI@boqun-archlinux>
 <20250227144618.GE39591@nvidia.com>
 <Z8CCKl_yA74WjpQ1@Mac.home>
 <20250227161733.GH39591@nvidia.com>
 <Z8CY7fqbtbO4v1jv@Mac.home>
 <Z8ChnwPC0UwM8xBe@cassiopeiae>
 <20250227192321.GA67615@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227192321.GA67615@nvidia.com>

On Thu, Feb 27, 2025 at 03:23:21PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 06:32:15PM +0100, Danilo Krummrich wrote:
> > On Thu, Feb 27, 2025 at 08:55:09AM -0800, Boqun Feng wrote:
> > > On Thu, Feb 27, 2025 at 12:17:33PM -0400, Jason Gunthorpe wrote:
> > > 
> > > > I still wonder why you couldn't also have these reliable reference
> > > > counts rooted on the device driver instead of only on the module.
> > > > 
> > > 
> > > You could put reliable reference counts anywhere you want, as long as it
> > > reflects the resource dependencies.
> > 
> > Right, as I explained in a different reply, the signature for PCI driver probe()
> > looks like this:
> > 
> > 	fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>
> > 
> > The returned Pin<KBox<Self>> has the lifetime of the driver being bound to the
> > device.
> > 
> > Which means a driver can bind things to this lifetime. But, it isn't forced to,
> > it can also put things into an Arc and share it with the rest of the world.
> 
> This statement right here seems to be the fundamental problem.
> 
> The design pattern says that 'share it with the rest of the world' is
> a bug. A driver following the pattern cannot do that, it must contain
> the driver objects within the driver scope and free them. In C we

I cannot speak for Danilo, but IIUC, the 'share it with the rest of the
world' things are the ones that drivers can share, for example, I
suppose (not a network expert) a NIC driver can share the packet object
with the upper layer of netowrk.

> inspect for this manually, and check for it with kmemleak

In Rust, it's better (of course, depending on your PoV ;-)), because
your driver or module data structures need to track the things they use
(otherwise they will be cancelled and maybe freed, e.g. the hrtimer
case). So you have that part covered by compiler. But could there be
corner cases? Probably. We will just resolve that case by case.

> progamatically.
> 
> It appears to me that the main issue here is that nobody has figured
> out how to make rust have rules that can enforce that design pattern.
> 

Most of the cases, it should be naturally achieved, because you already
bind the objects into your module or driver, otherwise they would be
already cancelled and freed. Handwavingly, it provides a
"data/type-oriented" resource management instead of "oh I have to
remember to call this function before module unload". Again, I believe
there are and will be corner cases, but happy to look into them.

> Have the compiler prevent the driver author from incorrectly extending
> the lifetime of a driver-object beyond the driver's inherent scope, ie
> that Self object above.
> 

Compilers can help in the cases where they know which objects are belong
to a driver/module.

So I think in Rust you can have the "design pattern", the difference is
instead of putting cancel/free functions carefully in some remove()
function, you will need to (still!) carefully arrange the fields in your
driver/module data structure, and you can have more fine grained control
by writting the drop() function for the driver/module data structure.

> Instead we get this:
> 
> > If something is crucial to be bound to the lifetime of a driver being bound to a
> > device (i.e. device resources), you have to expose it as Devres<T>.
> 

I feel I'm still missing some contexts why Devres<T> is related to the
"design pattern", so I will just skip this part for now... Hope we are
on the same page of the "design pattern" in Rust?

Regards,
Boqun

> Which creates a costly way to work around this missing design pattern
> by adding runtime checks to every single access of T in all the
> operational threads. Failable rcu_lock across every batch of register
> access.
> 
[...]

