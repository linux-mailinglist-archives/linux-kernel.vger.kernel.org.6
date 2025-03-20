Return-Path: <linux-kernel+bounces-569769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6479A6A774
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C971B611A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC821CA0A;
	Thu, 20 Mar 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/LwXuCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441221D3C7;
	Thu, 20 Mar 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477771; cv=none; b=c3weWtJKL9Kq3RIc6cOw5Xe29KZX7PHdDC6HuzkwHKxCKvg3GHHgl/HMLjy3Bm3JsviRiN4INqbGZu9Jj3q1cMi3ODRsMkCwmjyKe5Sn6Uj1rUr6tlmogfaWYHuCmuFq3MmB8wh7vo8SJ9HwK2/+osAv4CSiHXbXSFRJFfJpXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477771; c=relaxed/simple;
	bh=+nXJuo4PVgrYVzRLdytPzdcjJMPdL09Z4Vn3ItA2wxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4EXPYn3TjB6XkPt2sa6s+UuvdZaarYDUu2w+StdvujNCUIRx9y9i5GKqdXe3WUdaaPF7ziMRpSDte0iR51Mskk7MFx7xGL7qAGFHGGBgbF+Nc1TRldB6hN315Q4ylAQZUMALr+fL0Nodt06rxLYUgycGfQjjn6UFobJOg8twHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/LwXuCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E784AC4CEDD;
	Thu, 20 Mar 2025 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742477771;
	bh=+nXJuo4PVgrYVzRLdytPzdcjJMPdL09Z4Vn3ItA2wxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/LwXuCd/zhrldkbCAunIsE57gCSgS9itwMKb3ImZMbOZr7o+8D2nQI03PyWDDhxh
	 OmWcLhT5ToBm/Ddz9ne3xn9vXy96MDIK2gg56dXQFdnqX2j1/0n1Y+2i7Kwcw4t6B5
	 vjBHDrbmsq+wg3QZhMxh0XkN9HRNLilBO64mikKA=
Date: Thu, 20 Mar 2025 06:34:51 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, jgowans@amazon.com, jgg@nvidia.com
Subject: Re: [RFC v1 2/3] luo: dev_liveupdate: Add device live update
 infrastructure
Message-ID: <2025032058-reassure-veneering-0fdb@gregkh>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320024011.2995837-3-pasha.tatashin@soleen.com>

On Thu, Mar 20, 2025 at 02:40:10AM +0000, Pasha Tatashin wrote:
> Introduce a new subsystem within the driver core to enable keeping
> devices alive during kernel live update. This infrastructure is
> designed to be registered with and driven by a separate Live Update
> Orchestrator, allowing the LUO's state machine to manage the save and
> restore process of device state during a kernel transition.
> 
> The goal is to allow drivers and buses to participate in a coordinated
> save and restore process orchestrated by a live update mechanism. By
> saving device state before the kernel switch and restoring it
> immediately after, the device can appear to remain continuously
> operational from the perspective of the system and userspace.
> 
> components introduced:
> 
> - `struct dev_liveupdate`: Embedded in `struct device` to track the
>   device's participation and state during a live update, including
>   request status, preservation status, and dependency depth.
> 
> - `liveupdate()` callback: Added to `struct bus_type` and
>   `struct device_driver`. This callback receives an enum
>   `liveupdate_event` to manage device state at different stages of the
>   live update process:
>     - LIVEUPDATE_PREPARE: Save device state before the kernel switch.
>     - LIVEUPDATE_REBOOT: Final actions just before the kernel jump.
>     - LIVEUPDATE_FINISH: Clean-up after live update.
>     - LIVEUPDATE_CANCEL: Clean up any saved state if the update is
>       aborted.
> 
> - Sysfs attribute "liveupdate/requested": Added under each device
>   directory, allowing user to request that a specific device to
>   participate in live update. I.e. its state is to be preserved
>   during the update.

As you can imagine, I have "thoughts" about all of this being added to
the driver core.  But, before I go off on that, I want to see some real,
actual, working, patches for at least 3 bus subsystems that correctly
implement this before I even consider reviewing this.

Show us real users please, otherwise any attempt at reviewing this is
going to just be a waste of our time as I have doubts that this actually
even works :)

Also, as you are adding a new user/kernel api, please also point at the
userspace tools that are written to handle all of this.  As you are
going to be handling potentially tens of thousands of devices from
userspace this way, in a single system, real code is needed to even
consider that this is an acceptable solution.

thanks,

greg k-h

