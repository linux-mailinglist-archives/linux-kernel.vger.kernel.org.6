Return-Path: <linux-kernel+bounces-225853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9791361D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D83B215DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C176BFC7;
	Sat, 22 Jun 2024 21:07:21 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F010381AA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719090441; cv=none; b=NExjY/Z6b6WLhUK9HnkFOufsFYWS8QWcVL2hFSCJxnICdQLkk/CJesqh/VpyeYkY7caI2P3rxAgnxZQPDFP6bjRN3K4fO/s91HOLrMbPesdE5URMzgtSOHIznmjAA/5mvNmK+GZGziDmbJ61qfImkkeQ90fqN0AZe0qPBjgmh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719090441; c=relaxed/simple;
	bh=0qq/XgnD+9MtID/8d4WdFBhDOrYfUX7/J8TvzWdjbTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX2qTjb3vY8leb30SMnGy12jKWLf4omqnVP45x9hTY6kbzOEpNMBqq6dku6knm+FqCnSe96lA3DXMVE8lVMRM/mSsmfPB5/ecKbFCvhioajQlMCTLmjVVnlyJs6uHKeb+dnndo1DZ2UAJiWN5JmkX1obBb9sajVUFrN3oaGcIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sL7x3-000000005mW-11XI;
	Sat, 22 Jun 2024 21:07:13 +0000
Date: Sat, 22 Jun 2024 22:07:10 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Gagan Sidhu <broly@mac.com>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	ZhaoLong Wang <wangzhaolong1@huawei.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
Message-ID: <Znc8_hcjH3_0plN4@makrotopia.org>
References: <251ae039-9f46-081b-a7ee-fe47de268865@huawei.com>
 <EFEC7C06-A3B2-46D6-99F4-ADA7F7199188@mac.com>
 <45d2ef27-95cc-16c4-8b0a-4413421d785b@huawei.com>
 <772249DB-434C-4AB9-AE6B-1CB684E1E11A@mac.com>
 <e562e94b-274d-4a82-3dad-d3e1109a2607@huawei.com>
 <7558AC97-FFFC-4593-B946-9F8FBD8D62FA@mac.com>
 <da6f4aa8-e79d-d70a-eeb5-0068ffc1ef52@huawei.com>
 <BE6684D5-1CEE-46AA-84BF-C6146667D84B@mac.com>
 <69656f63-d2ad-8215-eba6-12603fb38f62@huawei.com>
 <4FBEAA67-7829-481C-8EB0-06621B73F935@mac.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4FBEAA67-7829-481C-8EB0-06621B73F935@mac.com>

On Fri, Jun 21, 2024 at 08:43:47PM -0600, Gagan Sidhu wrote:
> [...]
> GLUEBI should be operating on the /dev/mtdblockX device and not ubiblock0_0 and thus the boot procedure created by openwrt should be unaffected.
> 
> at least that’s how i would understand the situation if each are creating their own devices.
> 
> we need to figure out a solution or maybe master rich should end our ongoing discussion because technically “it’s not mainline” and we’re probably boring the recipients.

I've suggested a simple solution here:

https://lkml.org/lkml/2024/6/17/1602

You could try that and let us know if it resolves the issue for you.

