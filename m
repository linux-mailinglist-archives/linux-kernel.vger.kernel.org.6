Return-Path: <linux-kernel+bounces-285448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A45950D98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84380B246B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8B1A7049;
	Tue, 13 Aug 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+a9BFGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C991A4F30;
	Tue, 13 Aug 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579656; cv=none; b=QlBL4nwr8W624RcHXEQQ0NRfvTwavys5fgaH00lpP9QrwAhoMQrke13mD/vbyaQzqAMErJT+tvvOuB+LuxLhJPjzk57oI5ZAvOzsDxFVqjL87YbV3VZTe0NSNYeC2/6mPt7POMg3RcRzoIf0iv0iR8MU0/7vsgTrLmZJEBcnltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579656; c=relaxed/simple;
	bh=pcU0DlQ+ID/ze4Ee6AQQElRUnHpjqLCr6VqHuIdU5FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYaytyvTYYbHJUJlfo6hR7LPMrmBpiJf6zEOj8w4Lm2VKFWt9B0taE+YrtSiOVgPwgclA+U0UDwc0kdM5u7wJZmRvuoo+dOS3boGzIbt6Sgz7utT+vk/1GgdcH73pKWm+TMnKK+GLbyw/qED/uvDdGusCM3qFXOBdM44Oxt/SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+a9BFGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ACDC4AF10;
	Tue, 13 Aug 2024 20:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723579655;
	bh=pcU0DlQ+ID/ze4Ee6AQQElRUnHpjqLCr6VqHuIdU5FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+a9BFGu5rXoC2VXF6YVaCHXPLBvjQuCO8q/YvNGn+2s8sNyKgBQOKR/h+Ir4j/no
	 olrDkMK2uBr05dFbfSDhtvK0drNBkgcfwHf0f4I4yBTsilX/69neoR+L9aMLsl97ot
	 v2XrSh2CgqXEZlReERf1DOAfXBEFIiSX49Run3f1H/eIYLw5Fp3Q8RcdUyKdNAEu9N
	 Q1kzD3q88FLCEQb5JTURDmmAikCCifDm+nDix/zedHtEqRj6rmIzIEeApdN5iT2uf7
	 0B/2krLSkbGHqqWiM1VXpoV6E/5RJRBy9TpuHYIfHQ40KAr4ZG5gfWjAt7dzQPBQlg
	 1hhTdmNsn2RCA==
Date: Tue, 13 Aug 2024 14:07:34 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions
 node in mmc-card node
Message-ID: <20240813200734.GA1659224-robh@kernel.org>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172106.25892-4-ansuelsmth@gmail.com>

On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> Add property for defining partitions node in mmc-card node to define
> partitions in DT by the use of the block2mtd module to use block
> devices as MTD.

You justified patch 1 saying eMMC already supported this, but then here 
you add support.

Both are a NAK for me as both already have a way to describe partitions 
with GPT.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)

