Return-Path: <linux-kernel+bounces-569887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365ECA6A8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0AB3A8FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A01DE8B4;
	Thu, 20 Mar 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj0a4C4T"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0B1DE2DF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481431; cv=none; b=G4QOojHZ3028AV2gOVXYTbQdeMuqK9lRdoMZ3gS3L6babgMgalCdjOjcZUFUCCoBW4On4/xHIKNxskUFQy2RNhvnipXkysiBL13RtGmT1cnOS4wIwuvnvuNXUouQXLWn3JLefgrzV8aszYg7OvrwuShb3UNVBgMiriQiA7XAUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481431; c=relaxed/simple;
	bh=/Gfb5GEBXbNXjVOKcSAvbyPEtTsdgPC9h9bjSyHrTxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCQ06dsipLGc7q9gkgMQE2X6BnYn4p2su/ukLLVnRafW3lHfD/zGdIrvnyzWom4H6EQUg5pW74dUzolC6P6DnJE0pVZn6M3ySe3CNxNp2xHQW8HcUdZJHXAOMhTcfdybgaEPyI9InjnmOcTYa6Bt2xUUhzC9o24srdiybBz1c7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yj0a4C4T; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e46ebe19368so671100276.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481429; x=1743086229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLEDllcZE9HeaNUXtT820xySgzGTQcNZXOc5EzIZSWc=;
        b=yj0a4C4ToBGXfECuV2EJL+Cu1oduA24rhyFSVmefN5FmcQ6px8hNqvOY10GjC/OmHt
         VAlWF79m1I/kks3jJ+WJ99Ys4k89FSHSkITCPn3rII96xu+4JKJt+yB527fjnB9cs+Lh
         jwUgVHCMYQbIzkwNHzgN8i2PNJZPCIhhcYN97MAujnOEcq1myJ9XgpxAZy8WZbUH8LD9
         PqIBcAvfz0PMJhsICo9/yXK+b8Cxmc14YKRdl3+D9Yel3G1CzAIPdUrUHao7oa6cgoPZ
         nGVfMbBDk96+JEBV+VqrHIbkf6ODKR/Yu/lNo49fmAZ7dkeHK0OVzI4ah/LG+0RE+Rhy
         ob8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481429; x=1743086229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLEDllcZE9HeaNUXtT820xySgzGTQcNZXOc5EzIZSWc=;
        b=Eqa9yZd2KChbk2Xkjo1d86itf8P9/hZc51F5QImhKRi5mxHo5xfi4RAslNSL90nSd4
         ds4+mWYmO2cziDMJq4M9CzYfoMM6m7ftL/i/IRvILPSmgjf8Mf/5hX/4DjFYLFfN4ji+
         rENd8hnG8eqoJEk6Q8OWruCtc1CVH5qY2c/LblAzy7iDl3RCqKp9ZIPzSR4WN3ziQqc9
         wEMG/wf9lciWprpAHS6ZpPQJGremlxT7q6ZZbbA5Ep3j06m6FxCmGODg+mQDjOVnaMCb
         rXcY/kGoZl3MHJAQNbbMu9ZspdaoEj9dZOM5bGfqPJYbtoEPIsiobra5XTjtfyRhtz10
         +R7g==
X-Forwarded-Encrypted: i=1; AJvYcCV3pspwaVyEih45WMKIpau9vNZzZpSZFmw+BmBBVnhQzHhapeFvUB+1T60N9QAtECRefX40dQYHGiW0W3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oGMuH6aW9OMwEyBSEmY++WuSSBTzytxrgZa7vWHQJw+j2HuA
	dVPRVkoDV6WZ0IuNN39J2LU9ZVZc2gx+mSgawgCMR5WCaYVjtZSO+HQm/1xzCrZSECupfyAN92J
	HDpFGJ2i4T2LB+/af44vrkXjR+KARxnpKPRHMzg==
X-Gm-Gg: ASbGncsWtDBYqSYTtkokbd5Wefwl2mlhKC5Ygl99c1RT2d3QjSOJmGcGxMnXVUkwxGR
	qr8VthYp7pji1iTc0XAixNwpxAXXOMC0XSeoDaMuzGqNfZSTlCnhweE3b9WDJhhSBRJWwT+vzNV
	QpzClyV/S8MkFD64kq+KLPFyp1NSA=
X-Google-Smtp-Source: AGHT+IGLDwuEvPABNDqvH8Sg++dMtxuwcekvvB+mdlvGgakHsDV81vNGD+1s9/U83hwKUFCHyv+ChNKx4+eFMuKzFbY=
X-Received: by 2002:a05:690c:4a01:b0:6fb:b524:48bc with SMTP id
 00721157ae682-7009c151fa0mr105912607b3.35.1742481428540; Thu, 20 Mar 2025
 07:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310102229.381887-1-o.rempel@pengutronix.de>
In-Reply-To: <20250310102229.381887-1-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Mar 2025 15:36:32 +0100
X-Gm-Features: AQ5f1JqncR6FnHE5M2Ntpmi-B4Cz544fyrHiSkMY_eDdSJ-_u8NqXWoMcjOkT3c
Message-ID: <CAPDyKFrC56BBJk=YAPWCCNYNqFAoY74_yH0ZXfNQEiDhaA2xJg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mmc: handle undervoltage events and prevent eMMC corruption
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

Hi Oleksij,

On Mon, 10 Mar 2025 at 11:22, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> changes v4:
> - drop HPI and SDHCI related patches
>
> This patch set introduces a framework for handling undervoltage events
> in the MMC subsystem. The goal is to improve system reliability by
> ensuring graceful handling of power fluctuations that could otherwise
> lead to metadata corruption, potentially rendering the eMMC chip
> unusable or causing significant data loss.

Thanks for posting this! I will spend some time reviewing this next
week and let you know my comments then.

However, I just wanted to let you know that I just posted a series [1]
(forgot to cc you, sorry), which also reworks the way _mmc_suspend()
understands what scenario it should be running. I am guessing that
re-work is simplifying for your $subject series too. Maybe you would
like to have a look?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250320140040.162416-1-ulf.hansson@linaro.org/



>
> ## Problem Statement
>
> Power fluctuations and sudden losses can leave eMMC devices in an
> undefined state, leading to severe consequences. The worst case can
> result in metadata corruption, making the entire storage inaccessible.
> While some eMMC devices promise to handle such situations internally,
> experience shows that some chip variants are still affected. This has
> led vendors to take a more protective approach, implementing external
> undervoltage handling as a precautionary measure to avoid costly field
> failures and returns.
>
> The existence of the "Power Off Notification" feature in the eMMC
> standard itself serves as indirect evidence that this is a real-world
> issue.  While some projects have already faced the consequences of
> ignoring this problem (often at significant cost), specific cases cannot
> be disclosed due to NDAs.
>
> ## Challenges and Implementation Approach
>
> 1. **Raising awareness of the problem**: While vendors have used
>    proprietary solutions for years, a unified approach is needed upstream.
>    This patch set is a first step in making that happen.
>
> 2. **Finding an acceptable implementation path**: There are multiple
>    ways to handle undervoltage - either in the kernel or in user space,
>    through a global shutdown mechanism, or using the regulator framework.
>    This patch set takes the kernel-based approach but does not prevent
>    future extensions, such as allowing user-space handoff once available.
>
> 3. **Preparing for vendor adoption and testing**: By providing a
>    structured solution upstream, this patch set lowers the barrier for
>    vendors to standardize their undervoltage handling instead of relying on
>    fragmented, out-of-tree implementations.
>
> ## Current Limitations
>
> This patch set is an initial step and does not yet cover all possible
> design restrictions or edge cases. Future improvements may include
> better coordination with user space and enhancements based on broader
> testing.
>
> ## Testing Details
>
> The implementation was tested on an iMX8MP-based system. The board had
> approximately 100ms of available power hold-up time. The Power Off
> Notification was sent ~4ms after the board was detached from the power
> supply, allowing sufficient time for the eMMC to handle the event
> properly.  Tests were conducted under both idle conditions and active
> read/write operations.
>
> Oleksij Rempel (4):
>   mmc: core: Handle undervoltage events and register regulator notifiers
>   mmc: core: refactor _mmc_suspend() for undervoltage handling
>   mmc: core: add undervoltage handler for MMC/eMMC devices
>   mmc: block: abort requests and suppress errors after undervoltage
>     shutdown
>
>  drivers/mmc/core/block.c     |   2 +-
>  drivers/mmc/core/core.c      |  30 +++++++++
>  drivers/mmc/core/core.h      |   2 +
>  drivers/mmc/core/mmc.c       | 127 +++++++++++++++++++++++++++++------
>  drivers/mmc/core/queue.c     |   2 +-
>  drivers/mmc/core/regulator.c | 124 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h     |   8 +++
>  7 files changed, 274 insertions(+), 21 deletions(-)
>
> --
> 2.39.5
>

