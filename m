Return-Path: <linux-kernel+bounces-325208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF925975623
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27F21C25E18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DC1AB53B;
	Wed, 11 Sep 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tDmogz9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DB1AAE37;
	Wed, 11 Sep 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066578; cv=none; b=W5xCKmDvjuwnyAxqUbl9oGYud3ROXkbzHOqndumPm7Z9Vn/Nzrdd2kiaFrOgKUhtTMoiimd8gyKaYu0RzfCqSpcVZpVxJ5mDqsH/HgnvP7PzfuKPEuOymZjA5P/bivae2TDy1gxdO2deyjiG3mAacu1dbglkWFDUDq5GctQQX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066578; c=relaxed/simple;
	bh=OPBj4Qudavihi4KmrNd2ipOv17IedhIybARx9D2kEns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXR0B4m9ITpeXZoQ23cDbm/nfdyHt655aJ8nucyx/TO5VoV5ohoVybjUMyxs9Iwnf8+CznUya7FEYwjBRNCOikrDg3mYVtuw6c4oEr+sF+51+vQCEHMkEEKgcdXt8xnSpuYje/sblpoOMB+QFkdtR1IcuzXYrFujjueDwlERpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tDmogz9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39136C4CECF;
	Wed, 11 Sep 2024 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726066577;
	bh=OPBj4Qudavihi4KmrNd2ipOv17IedhIybARx9D2kEns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDmogz9lkBqz3punQT2C12MDWaqNTFOGfwXmIgAy/y537o7njVPpicrO0C4hAHN7m
	 wIOp7FWkPKgfmLXbTQ9ConR/swll0oAhX0nprTmCkoezdXiyL1/F/MsAW0TGHm3rYd
	 zj4e6iluo33WS4ybOYFEMGlZni4xCw/mAjLx9qp8=
Date: Wed, 11 Sep 2024 16:56:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
Message-ID: <2024091106-scouring-smitten-e740@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>

On Wed, Sep 11, 2024 at 07:57:18PM +0530, Ayush Singh wrote:
> +/// An identifier for Platform devices.
> +///
> +/// Represents the kernel's [`struct of_device_id`]. This is used to find an appropriate
> +/// Platform driver.
> +///
> +/// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
> +pub struct DeviceId(&'static CStr);
> +
> +impl DeviceId {

<snip>

I appreciate posting this, but this really should go on top of the
device driver work Danilo Krummrich has been doing.  He and I spent a
lot of time working through this this past weekend (well, him talking
and explaining, and me asking too many stupid questions...)

I think what he has will make the platform driver/device work simpler
here, and I'll be glad to take it based on that, this "independent" code
that doesn't interact with that isn't the best idea overall.

It also will properly handle the "Driver" interaction as well, which we
need to get right, not a one-off like this for a platform driver.
Hopefully that will not cause much, if any, changes for your use of this
in your driver, but let's see.

thanks,

greg k-h

