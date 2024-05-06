Return-Path: <linux-kernel+bounces-170340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B68BD567
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E8F284E97
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D2159569;
	Mon,  6 May 2024 19:26:09 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E015920A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023568; cv=none; b=tYUpkUnrpNuPgC2EPvoAgWtRFr/NYy/26Lo1QtrPYRCSl8b91XPn3BSSQZzjM4E9j7KhrdnUmkWCAjYHzE9HXKJ1lF5gd6m52JaD8psyoFcej9YSsAay9p2+NNxGqY74F1NyERdRyxX5FEWaTm//MjnO9Y3PU6mO72oTdP+nksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023568; c=relaxed/simple;
	bh=5NvJh0n1w6lBWPnK2SnxtXvu5LZHpQLhtLGSSaX2Mk4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaYIIlghKCHJTs0UFC3hCI4zIfp3MskNgSV7poTjgwxpFrGobZNfdEp3GpiA2JqjVJqRjob6WbCwMg1sjauFBHk7xCPDFXWTS2p1MQBVvx0nuqwjopV4DKf5DLzgewMjvfaqfR1A3Q2pBkZuf9W1tM2SpR6NTdtNtfiy6JvuAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 7b050ce9-0bde-11ef-abf4-005056bdd08f;
	Mon, 06 May 2024 22:26:05 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 May 2024 22:26:04 +0300
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org,
	Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pinctrl: zynqmp: Support muxing individual pins
Message-ID: <ZjkuzKEt2aiHIwg_@surfacebook.localdomain>
References: <20240503162217.1999467-1-sean.anderson@linux.dev>
 <20240503162217.1999467-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503162217.1999467-3-sean.anderson@linux.dev>

Fri, May 03, 2024 at 12:22:17PM -0400, Sean Anderson kirjoitti:
> While muxing groups of pins at once can be convenient for large
> interfaces, it can also be rigid. This is because the group is set to
> all pins which support a particular function, even though not all pins
> may be used. For example, the sdhci0 function may be used with a 8-bit
> eMMC, 4-bit SD card, or even a 1-bit SD card. In these cases, the extra
> pins may be repurposed for other uses, but this is not currently
> allowed.
> 
> Add a new group for each pin which can be muxed. These groups are part
> of each function the pin can be muxed to. We treat group selectors
> beyond the number of groups as "pin" groups. To set this up, we
> initialize groups before functions, and then create a bitmap of used
> pins for each function. These used pins are appended to the function's
> list of groups.

..

> +			for (pin = 0; pin < groups[resp[i]].npins; pin++)
> +				set_bit(groups[resp[i]].pins[pin], used_pins);

Why atomic bit operation?

..

> +	fgroups = devm_kcalloc(dev, func->ngroups + npins, sizeof(*fgroups),

size_add() from overflow.h.

> +			       GFP_KERNEL);
> +	if (!fgroups)
> +		return -ENOMEM;

..

> +	for (i = 0; i < func->ngroups; i++) {
> +		fgroups[i] = devm_kasprintf(dev, GFP_KERNEL, "%s_%d_grp",
> +					    func->name, i);
> +		if (!fgroups[i])
> +			return -ENOMEM;
> +	}

Hmm... Can this benefit from devm_kasprintf_strarray()?

-- 
With Best Regards,
Andy Shevchenko



