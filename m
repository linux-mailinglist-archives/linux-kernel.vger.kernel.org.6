Return-Path: <linux-kernel+bounces-352812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831D99245E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F5A2825F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021E140E5F;
	Mon,  7 Oct 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt23kY9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29D42077
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282359; cv=none; b=RBfNDEzNz9snKe+Rc490qlCAFkBtoidTutHf4CCVPYRp7uRBNt0iTS4ULjn6t/CG6kmDkv14hcqwwEM1xDS6NHsHfTu0cIn740TcnuG1cZDPAyTibJPVfXiq7iSDIDQFC2LpFBNRY8edyGYmyk41r0TgzZ4CRbBvRQWP69bFrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282359; c=relaxed/simple;
	bh=otylH51seDcjzZdnOTrbEFy5AZzZJ7GqteM1gvrFPKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCcXyzbAEd2pOV47X8SRj1RoaZeDa8sowXwigyj/hG5OoUX5evW/THyL6QjA/z5YbOXKOYknrNrSr1DpfpdAV9Bj8M1Sgy+nu3DEsmI++IY7AL8bKPrPzCtbOLSHFf1VVblaPXug+mlQ2hIKA27CW23GYdrY9cfuuvM66/S3P9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt23kY9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65F9C4CEC7;
	Mon,  7 Oct 2024 06:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728282359;
	bh=otylH51seDcjzZdnOTrbEFy5AZzZJ7GqteM1gvrFPKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qt23kY9lRZNDq3iHRnH5ihM3unoyhjdW9lAQD1NBy//M18273+UYeATcCaCsMgcr3
	 YRCQ1qVRyZ6vTyYHDLATNA0jmkOngdyVm3prA//tl3TVMtzyF2lyV8lRc2YCakUZYO
	 1ZOxr+tqQsMKHDguTGg9SsnB9DrgI9tOG7Xb+ibKCoWi1K08Uxr7Fb5e0XVcv4sF+8
	 yF1olnUQjX+RzPh9lqlR/7/vX0Q0q0CcZUyyq4gKglvy9HPauNf6dDblU7N/2XR7a/
	 U2HhD3HUSz43eEj8hi7JB46JjA414yF3A6YmIsSOGwtCCpi+sfvBgtraksnZUD/wiS
	 ZEn8LJZ30ijeg==
Date: Mon, 7 Oct 2024 11:55:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Swapnil Jakhade <sjakhade@cadence.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	xe-linux-external@cisco.com, Daniel Walker <danielwa@cisco.com>,
	Bartosz Stania <sbartosz@cisco.com>
Subject: Re: [PATCH] phy: cadence: Sierra: Fix offset of DEQ open eye
 algorithm control register
Message-ID: <ZwN+8xpOl4+Ggaha@vaman>
References: <20241003123405.1101157-1-bwawrzyn@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003123405.1101157-1-bwawrzyn@cisco.com>

On 03-10-24, 12:34, Bartosz Wawrzyniak wrote:
> Fix the value of SIERRA_DEQ_OPENEYE_CTRL_PREG and add a definition for
> SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG. This fixes the SGMII single link
> register configuration.
> 
> Fixes: 7a5ad9b4b98c ("phy: cadence: Sierra: Update single link PCIe register configuration")
> 

No need for this empty line here

> Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
-- 
~Vinod

