Return-Path: <linux-kernel+bounces-325423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AB7975984
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991B31F21CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9A71B4C29;
	Wed, 11 Sep 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miLmdgGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2E1AE852;
	Wed, 11 Sep 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076144; cv=none; b=XtvlNr2FJbhlzGR7vUKSPMOlRp8tFYqzQRc0enfspGmpHFPhWdumr2kiyk4P3wiXudLSBprNqACx6LNeBkL00/+1aVtIUtnRUH9pJNyTy5Wo4YO2IqZV4p1zCfa8ZXRd+RpcZgixcmiYZG8Vmu860hhKgY2xehS9W7olRnIrw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076144; c=relaxed/simple;
	bh=YbkFZVRnO7z0xDZitZm29si1xpSBine6L+hGh61wN1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgg2N+y1g0KC9V24EXWMfslTmL/6cKHCqhA/5/a9BSGbKqMcOHP711XDQ1uwBLsY8bmXxezlrgEqYS7zh4uX9jnikVbIBRqpZjp76I4uZO1BDnNJ01lIEEUybrf7c9RLlLBTtaGamiDYyiOxYfNmEiqsSQRN0xHMBw+U5BC/YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miLmdgGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195EAC4CEC0;
	Wed, 11 Sep 2024 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726076143;
	bh=YbkFZVRnO7z0xDZitZm29si1xpSBine6L+hGh61wN1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miLmdgGorlsJh0FQ94RmjTjwSf0/zRABbJ94KLqEmEDIjjdPPXJ34x69OvXCpI9nx
	 Yxf0CufuinCFr8VaPmOMhDerDsA8hp49UbpnvvfTAUO0R/mssnjDuPOnfVPMsHdwkZ
	 dmZzUnDLnYY54Wh9WNmYqdfFXYkSkwYzpYoj4W3xgZjzJx/RJjVKlhhbmnaDvQJRzU
	 PhAPSO4s0fMSwLMAC5lFT22m3syGPJVsOVCuRr41760TEVausfkYOezblo9RkM0xHz
	 E9v9kAHilNC13DoR/thFVknR2PQsN7/Os4jOIpTQbQECNMdmjxxaKZTPRv47DUpjmM
	 Ii9Du3WxbVnaw==
Date: Wed, 11 Sep 2024 19:35:35 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ayush Singh <ayush@beagleboard.org>, fabien.parent@linaro.org,
	d-gole@ti.com, lorforlinux@beagleboard.org,
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
Message-ID: <ZuHU5yrJUOKnJGrB@pollux>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
 <2024091106-scouring-smitten-e740@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091106-scouring-smitten-e740@gregkh>

On Wed, Sep 11, 2024 at 04:56:14PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 11, 2024 at 07:57:18PM +0530, Ayush Singh wrote:
> > +/// An identifier for Platform devices.
> > +///
> > +/// Represents the kernel's [`struct of_device_id`]. This is used to find an appropriate
> > +/// Platform driver.
> > +///
> > +/// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
> > +pub struct DeviceId(&'static CStr);
> > +
> > +impl DeviceId {
> 
> <snip>
> 
> I appreciate posting this, but this really should go on top of the
> device driver work Danilo Krummrich has been doing.

If everyone agrees, I'd offer to just provide platform device / driver
abstractions with my next patch series. This way you don't need to worry
about aligning things with the rest of the abstractions yourself and throughout
potential further versions of the series.

Just be aware that I probably won't get to work on it until after LPC.

> He and I spent a
> lot of time working through this this past weekend (well, him talking
> and explaining, and me asking too many stupid questions...)
> 
> I think what he has will make the platform driver/device work simpler
> here, and I'll be glad to take it based on that, this "independent" code
> that doesn't interact with that isn't the best idea overall.
> 
> It also will properly handle the "Driver" interaction as well, which we
> need to get right, not a one-off like this for a platform driver.
> Hopefully that will not cause much, if any, changes for your use of this
> in your driver, but let's see.
> 
> thanks,
> 
> greg k-h
> 

