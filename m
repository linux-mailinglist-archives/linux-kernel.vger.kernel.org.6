Return-Path: <linux-kernel+bounces-532774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFF9A4520E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8CC1726AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096B154BF0;
	Wed, 26 Feb 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p11TR35k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7994A21;
	Wed, 26 Feb 2025 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532624; cv=none; b=CrSSbynekKO+kCbnscPNCJUX9smmRwCVqLiloXqxUdpDC9RfzWSqUGYhQ32NlwzUVG0sgknH4+7UmzCPO92K750IJSjz/VIACEKcr+SQEPMAwn7e4KW5bcz4bvEEN7jQS8FUkdFzsXn6S1gCxiVf7MPbaK5a2E1NAwHIW0NOjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532624; c=relaxed/simple;
	bh=/7QHcznAJAo2yO+ZPSdY6irpP6OfrWikh/lcuG95OFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEAeeImfOdX9r+gyoF1gFMpmbHR49vDkCxcoYfHODHPVMWJzLHmpENmz8WUDpgJxovyiiQZfmXfIvoi6chgXJt8ZAfkBoyJO4ydyCGBklGUAx7nkztb5W8P3m4a8VuubU2q76S9hxCPW5jiSeZdQhRpBHrolxsg1ZsgJYPDR+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p11TR35k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B45C4CEDD;
	Wed, 26 Feb 2025 01:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740532624;
	bh=/7QHcznAJAo2yO+ZPSdY6irpP6OfrWikh/lcuG95OFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p11TR35kWUbmfwGxMqGmTqthyQsbWbW+CFGBtI5o/Ob8QMYY1UnP4MtYbTKTKEsgH
	 FDFsOntZsdBX+turZ9wTl0d7BkacQd12/dVNgMLSEEN3gR7PnN708BO79xgfKX7xcF
	 NaDUpeRCaupQBQ5LxeXT8g733HGkQLnoeWp/vVaI8Op1fNZp3N7licTuG71KCl+UHG
	 GYJrZHgyb1ZLvbHXTe2fqHiZBXVKL+hLpdg6EibLqVp8VJuQP/+x1BE4jNP97570D4
	 KSCdGtnoxJZM89fuGrkrgS8Dl3yEE7vr6/zkF7fFe0qnwwkTW4qkWX5hEU7BhnBWf0
	 VaX+E7EGN3F1g==
Date: Wed, 26 Feb 2025 02:16:58 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z75riltJo0WvOsS5@cassiopeiae>
References: <Z7xg8uArPlr2gQBU@pollux>
 <Z7xh5bEyh_MII4WV@pollux>
 <20250224184502.GA1599486@joelnvbox>
 <Z70EcwNIX0KtWy36@cassiopeiae>
 <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae>
 <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com>
 <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226004916.GB4959@nvidia.com>

On Tue, Feb 25, 2025 at 08:49:16PM -0400, Jason Gunthorpe wrote:
> I'm pointing out the fundamental different in approachs. The typical
> widely used pattern results in __device_release_driver() completing
> with no concurrent driver code running.

Typically yes, but there are exceptions, such as DRM.

> 
> DRM achieves this, in part, by using drm_dev_unplug().

No, DRM can have concurrent driver code running, which is why drm_dev_enter()
returns whether the device is unplugged already, such that subsequent
operations, (e.g. I/O) can be omitted.

> 
> The Rust approach ends up with __device_release_driver() completing
> and leaving driver code still running in other threads.

No, this has nothing to do with Rust device / driver or I/O abstractions.

It entirely depends on the driver you implement. If you register a DRM device,
then yes, there may be concurrent driver code running after
__device_release_driver() completes. But this is specific to the DRM
implementation, *not* to Rust.

Again, the reason a pci::Bar needs to be revocable in Rust is that we can't have
the driver potentially keep the pci::Bar alive (or even access it) after the
device is unbound.

A driver can also be unbound without the module being removed, and if the driver
would be able to keep the pci::Bar alive, it would mean that the resource region
is not freed and the MMIO mapping is not unmapped, because the resource region
and the MMIO mapping is bound to the lifetime of the pci::Bar object. This would
not be acceptable for a Rust driver.

That this also comes in handy for subsystems like DRM, where we could have
attempts to access to the pci::Bar object after the device is unbound by design,
can be seen as a nice side effect.

