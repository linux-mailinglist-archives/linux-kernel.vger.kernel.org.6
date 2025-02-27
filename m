Return-Path: <linux-kernel+bounces-536419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B01A47F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BAF3AB58A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A422F397;
	Thu, 27 Feb 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksKRITal"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E965224246;
	Thu, 27 Feb 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663311; cv=none; b=ep0afLqNqSpiKELh3gk7+r2xuXYOj1LwpU3d27oqfgluruNOMIVj07TfnbSAf8Yj+IPEzDQwXUPWY70I/WyUvQmqo7ToSsr8kexi50v+nE60JmV9l/nrrXanIfth//vSg81YMnh/aoIaE40/m3Wjy1MW+xWC0akihropiPQdW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663311; c=relaxed/simple;
	bh=Rr/ZAs6GmOH5Zx/oWHv7ST2gf2X9v75nhFcxZDN+WmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ/mqXUO0wFqz7n9k9VCjwggTSgbelrpj6Cdtj133YeQfywrIyZNwvDAWewUQyPMUxzYtcNj/2Uh8v1NyoTJYI9qamMkUZVmZS0ShlUhQ+o/YiGZ99Zhf98GYLefjZty9APQaaF63NuZBqlOcj85lrTZXUXNgRD5DobAwVkKbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksKRITal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42518C4CEDD;
	Thu, 27 Feb 2025 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663311;
	bh=Rr/ZAs6GmOH5Zx/oWHv7ST2gf2X9v75nhFcxZDN+WmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksKRITalBMRrx8PI2TYjkm6vqOT15c6BEkYcq9R7/5hpch/3Nw6p4/kOieKMPaw4J
	 7GgLzIYzIMOBgD6A/WdxtiUD0jaj+36l+qoiwF7o9rCr7lxIn3NzgJKZJ9j0D1iHPd
	 HTuST4IABwd0KVMebmBehOzqITu+4rkxfhtZfXTAMs+hD48dp9n85DgtJgIhJlA921
	 zM5Ta2d5Rd16mLjG5ab3OBw7XqdyINkexNUjcIGdgxTpU+1iULIfNJeNBneD52cXh2
	 ZSbo62gxrAsG0IrH64z3y41cNX7KDfO22hj4zMDV0REErtAlWEPDCwRNTIJqyVwW7U
	 gUmGMdpg4PVLw==
Date: Thu, 27 Feb 2025 07:35:09 -0600
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: reset: add generic bit reset
 controller
Message-ID: <20250227133509.GA2021892-robh@kernel.org>
References: <20250226234234.125305-1-inochiama@gmail.com>
 <20250226234234.125305-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226234234.125305-2-inochiama@gmail.com>

On Thu, Feb 27, 2025 at 07:42:29AM +0800, Inochi Amaoto wrote:
> Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
> a simple reset controller by toggling bit. It is a hard time
> for each device to add its own compatible to the driver.

It's a 1 line change. That isn't hard.

> Since these devices share a common design, it is possible to
> add a common device to reduce these unnecessary change for
> the driver.
> 
> Add common binding for these kind generic reset controller.
> Check the binding description for its requirement and
> suitable scenarios.

We generally don't want 1 register per node type bindings. That level of 
detail in DT has proven impossible to get right.

Rob

