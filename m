Return-Path: <linux-kernel+bounces-325215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FDA97566F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43069B2330E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605CA1AB53B;
	Wed, 11 Sep 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yfEl+u+l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C971AAE37;
	Wed, 11 Sep 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066806; cv=none; b=D97SeZ8eLiYMD29Q7L3kevpOgNtMctGpWQpavuoXoeGA9i+2tWhtWyshPSRnyLLrjqlwkRFnDfEtS0rrCHYdNDcok5LHEaPTpaCBkauXhQr/2C1k8z+nohzdwtUTGXm3TYv8l1J/gLSazFPwVZL4fWA4VBsuBWluJksuJqtKHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066806; c=relaxed/simple;
	bh=PxAVjxGeVV8SEGh4YEZELG5BQJdYiC0A16CmT05zM6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEpNxTxSJqTBGvHnAUqOhAwLv5KaBxVgpmYPHU0A3UVQIcGxlfH9+HP7C8bPea4WoWjsWDBSZ8inAhPrlAJPIJ+mqhL9EsRdEDzCU2wGuFjKO0Css31lj2pPb4cmayXa3SwjPI5cE4PSfBD4EmN+Z5bQWLFsBzbQlFd6dc/Gn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yfEl+u+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B5DC4CEC0;
	Wed, 11 Sep 2024 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726066806;
	bh=PxAVjxGeVV8SEGh4YEZELG5BQJdYiC0A16CmT05zM6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yfEl+u+ltzx/dHU/F/ntQN8MT4GzcQYOfiRfsiq1b1sYx55NHuoxWtU5OvNfuOhrL
	 /b6MJsKAfFuizcsjSfyvfZkTD186EVq1r4YRwWuiw6nMp6WUbEPeLUwDOabxi8IRa0
	 JIXcxnqy+lfZa59PWyT8IZV+6OYD+mblcaBiAuNE=
Date: Wed, 11 Sep 2024 17:00:03 +0200
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
Subject: Re: [PATCH 6/8] addon_boards: Add addon_boards plumbing
Message-ID: <2024091147-graveness-manmade-d070@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-6-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-mikrobus-dt-v1-6-3ded4dc879e7@beagleboard.org>

On Wed, Sep 11, 2024 at 07:57:23PM +0530, Ayush Singh wrote:
> A directory to store and build addon_board overlays like mikroBUS,
> Groove, etc. The overlays present here should be completely independent
> of the underlying connector.
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  Kbuild                         |  1 +
>  Kconfig                        |  2 ++
>  MAINTAINERS                    |  1 +
>  addon_boards/Kconfig           | 16 ++++++++++++++++
>  addon_boards/Makefile          |  3 +++
>  addon_boards/mikrobus/Makefile |  1 +
>  6 files changed, 24 insertions(+)

Ah, here's where you add this.

It should be below drivers/ right?  But what's wrong with drivers/soc/?
Why is this so special?  Why not just under
drivers/microbus/addon_boards/ ?  Why is this tiny bus/device so
different from everything else out there?

thanks,

greg k-h

