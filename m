Return-Path: <linux-kernel+bounces-321515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13C971B87
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB081F2428B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675C1B9B30;
	Mon,  9 Sep 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ/RoyiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F01E507
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889660; cv=none; b=teQSK7BHsSV2/Sm3uaixP7LrZwhDGkmiBDDisT7waW4SfQrdPXJZnSg6Hrm9ZXlEqLe4AzVPOETCC3CFXMKVygjCyuh2bJtpm0zyKEoy8zz2OTgz6nnn9X7l5UlxfflNZogIf3QplNEcoCdRKleFS7wXJ23vYjS1piHrmVNP/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889660; c=relaxed/simple;
	bh=ZGoU2kTAV4IE6TEddBrFeiotEx7bqq31YAXRA183Pp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AqW7yrCYsUMCncAiSYBu9jGTdr8q8lWKCOr9XHNzvE17rOzrWnb5Xo8NAJORMowrXb2MKYs4GtgPwNlbg2QjR7mIBTLhrRdghAuRigSSMzax7o2metMY9oCt6sCQ9hvNsYo3r1Za8d+yuOA5zPtfPYdszi3doqwnejdfqKV0zfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ/RoyiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E88C4CEC5;
	Mon,  9 Sep 2024 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725889660;
	bh=ZGoU2kTAV4IE6TEddBrFeiotEx7bqq31YAXRA183Pp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bJ/RoyiUEbTffx3q685g32a2Xvf2JGZsqO5PGUN1h7VnC44/5TEcH2hoQBbiafyhf
	 IVSnnPg53KBhECV5ZqiJw2+Wx919hcly8fMBGfZsgzihr/JrzuBIVxJk0OC1QFbnxJ
	 dwwvZTrc3RwOubk/JuoOz7pSJVaMTxxfihJUw7p57AXScFq7OJHLIOhLT0CTu2F96X
	 iSDUMZAoUZNPaFVUiWJX6R5uYunyCAK1q1EGNIpvgWdhBfmXbPkmgsQik+s3fCWKaw
	 OPflEi79g6PGs6ia/P1ArFCk2GDZ/bjBzBf6RSiHfZO1FqnePJYC9RsVxKz8isVzBr
	 FtbaEtIQHRQGQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH] mtd: spi-nor: fix flash probing
In-Reply-To: <20240909072854.812206-1-mwalle@kernel.org> (Michael Walle's
	message of "Mon, 9 Sep 2024 09:28:54 +0200")
References: <20240909072854.812206-1-mwalle@kernel.org>
Date: Mon, 09 Sep 2024 15:47:37 +0200
Message-ID: <mafs04j6pgcqu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Michael,

Thanks for the quick fix!

On Mon, Sep 09 2024, Michael Walle wrote:

> Fix flash probing by name. Flash entries without a name are allowed
> since commit 15eb8303bb42 ("mtd: spi-nor: mark the flash name as
> obsolete"). But it was just until recently that a flash entry without a
> name was actually introduced. This triggers a bug in the legacy probe by
> name path. Skip entries without a name to fix it.

We also use name in a couple other places:

1. spi_nor_get_flash_info() prints jinfo->name and info->name() in the
   dev_warn() call.

2. spi_nor_params_show() prints nor->info->name for the debugfs entry.

Since both of these are prints, it should probably be fine since they
should be converted to "(null)" instead. Still, something we should fix.
I don't think those are critical so those can be fixed as follow up
patches. I unfortunately am swamped and don't have the time to fix them
right now.

I also did a quick check to make sure we don't have other flashes
without a name.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Applied to spi-nor/next. Thanks!

>
> Fixes: 2095e7da8049 ("mtd: spi-nor: spansion: Add support for S28HS256T")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/r/66c8ebb0-1324-4ad9-9926-8d4eb7e1e63a@nvidia.com/
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
[...]

-- 
Regards,
Pratyush Yadav

