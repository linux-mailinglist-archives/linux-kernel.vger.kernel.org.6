Return-Path: <linux-kernel+bounces-446553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875F9F260A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CFA1886096
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D81B87F5;
	Sun, 15 Dec 2024 20:34:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F27282E1
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734294848; cv=none; b=dG+8NhgP/ADC2n6JE0M8keis10/gVetDCbzpBKdVoBJkV1J+ejrlkQ29z5loSEv2rLCPZgnXVkhDRYRTCeTjN3TvPyeaiNKjsrMtx/p+Qb83ppp2A/I5YBFzBotni1pajRqL8RMjWOI96qgAHLTImkvzHXTIVr9WMnEY3HzC5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734294848; c=relaxed/simple;
	bh=YjwSfN7Twn4IPZSz4VmIgBeHrh0c84QUs6or9fj9OBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uH/SvRYrqIpV/pEnuMRFV6s6T+puXIxpWHtIGFMmf8F29ewfmzXhiUo4jkZpsTUlr/TMIR1xbLpGp8be6ENnemjeranWXGNnkITporJ1ENy0/jMTKO+GMx6TNmUfXpTi5FuXNMDGOMA75br8ZcI6iTD17T6VW4X1iFVUpufOK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 3SZbd4r9Q96lrZsWPPqzJg==
X-CSE-MsgGUID: L2EbLFJSSNCJcd9lJG+chg==
X-IronPort-AV: E=Sophos;i="6.12,237,1728918000"; 
   d="scan'208";a="227902833"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2024 05:33:58 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.26])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4A361406865D;
	Mon, 16 Dec 2024 05:33:45 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: robh@kernel.org
Cc: arnd@arndb.de,
	heiko@sntech.de,
	krzysztof.kozlowski@linaro.org,
	lee@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	lpieralisi@kernel.org,
	pankaj.dubey@samsung.com,
	peter.griffin@linaro.org,
	sudeep.holla@arm.com,
	willmcvicker@google.com,
	biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 3/3] mfd: syscon: Allow syscon nodes without a "syscon" compatible
Date: Sun, 15 Dec 2024 21:33:44 +0100
Message-ID: <20241215203344.46158-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211-syscon-fixes-v1-3-b5ac8c219e96@kernel.org>
References: <20241211-syscon-fixes-v1-3-b5ac8c219e96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rob,

On Wed, 11 Dec 2024 14:57:14 -0600 Rob Herring wrote:
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index bfb1f69fcff1..e6df2825c14d 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -171,8 +171,10 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
> 			break;
> 		}
> 
> -	if (!syscon)
> +	if (!syscon && of_device_is_compatible(np, "syscon"))
> 		syscon = of_syscon_register(np, check_res);
> +	else
> +		syscon = ERR_PTR(-EINVAL);

The current modification will make device_node_get_regmap() return -EINVAL even 
for syscons that were already found in the syscon_list, which I believe is not 
the intended behavior.

I suggest modifying it this way to maintain lookup functionality for registered 
syscons while implementing your intended changes:

static struct regmap *device_node_get_regmap(struct device_node *np,
					     bool check_res)
{
	struct syscon *entry, *syscon = NULL;
	struct regmap *regmap;

	mutex_lock(&syscon_list_lock);

	list_for_each_entry(entry, &syscon_list, list)
		if (entry->np == np) {
			syscon = entry;
			break;
		}

	if (syscon) {
		regmap = syscon->regmap;
		mutex_unlock(&syscon_list_lock);
		return regmap;
	}

	if (of_device_is_compatible(np, "syscon")) {
		syscon = of_syscon_register(np, check_res);
		mutex_unlock(&syscon_list_lock);
		if (IS_ERR(syscon))
			return ERR_CAST(syscon);
		return syscon->regmap;
	}

	mutex_unlock(&syscon_list_lock);
	return ERR_PTR(-EINVAL);
}

The above is the resulting working function I've obtained while testing with
different scenarios. This ensures that:

 1. Already registered syscons are found and returned correctly
 2. New syscons with "syscon" compatible are registered as before
 3. Nodes without "syscon" compatible return -EINVAL only if not found in the list

This has been tested with my v1 syscon work [1] and with v2, where I remove the
"syscon" compatible string for custom regmap initialization, aligning with your
goals for this series.

Let me know if I should add this series as a dependency of my v2 or how I should proceed.

Thanks,

John Madieu

[1] https://lore.kernel.org/all/20241206212559.192705-2-john.madieu.xa@bp.renesas.com


