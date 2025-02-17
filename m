Return-Path: <linux-kernel+bounces-517115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D37A37C58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B87E16F823
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2419995E;
	Mon, 17 Feb 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/bQSt82"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A2194C8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777572; cv=none; b=F1BRezAdZQduUWI15trZ7Nvu2U2ar8LiecMlqHrmgJZQliTEqSz8K283agut1iTV5H7b/toGLaXGNrniBeDZ8rhwA/h/EfRcm8/wMjSYhIPa7pF0rVydxUN5wKP2H83U0xn+HolNpCRLxhf7fP6C+aahzDldy6mNhLbREaYmiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777572; c=relaxed/simple;
	bh=r6aBwQGIKHihW7+Ag844yt6fSqk0SJomx7ZY5GraGU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DalVdqamT8whOhAehKL9l41zjdUDGqzPH6EWm1YfcZljsyMPohdUXzaRi1uEd3yV2E/F0lbXkllS8WZdw+VJN8BUhMk+w3HWV84qnCq9nRzJu8sOoCsJ1Z5fTtgQPUtRmPUC8+5o5i9iIleKpmQPW21BD6bRHJzGHFbfuXhhz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/bQSt82; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb90f68f8cso174466066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739777569; x=1740382369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMllDSNz6y9GDkrgwRaQVDA/pIhA4eMkvxsotewnFzc=;
        b=L/bQSt82XGSdLraoupLNCMzX4Qc6baDNAILNy7VNwqsGFqRAxDbyijzY5/T5swPIuB
         dAkBiOb3AEk8cx+XvHd6TFb1adgyeCKFyEkUp/gOmyc49T9dLFY9gNR7ssrBQhMWa7i4
         D73DI3RS+daKOmHWCc+0lJj4KUy7FR0inCFCyWXnZwB8ZzmOrrWhgxmeoBOmX97zPWjA
         tTSo4/SCnw32jObqpXG+rlN16/C4ia691amGPdnM21Vx1g1Un7zSwSkeQgqIso5ZSx9A
         ySmhPZTCC0Xx9rfpwxENPvjQF26PDYZAjOe1C1l6kPfP8MBtA9plTvoeoRmDE0eLjsIw
         SBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777569; x=1740382369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMllDSNz6y9GDkrgwRaQVDA/pIhA4eMkvxsotewnFzc=;
        b=Txy/KXp/WzKuv9qAzvZkaNvLKbgPsZ4n6cVqhRpDgUOowF8XaNqJMnlr3FhDzCWR1b
         DHChB4V98u8LqF+l1D7f6y9R0kFcrhpOscHJrqauSDZ9qWQ4nNcA8D/czCSdAoJZVvwn
         hOC7M2LaoYM7DQaPpqm0n61VavtlO6BaeJzHs/bgUYcdhidv6V33BtGBWMXsMN0U6vjq
         Avzl0UJ3/GY3jctxSVEZeGXQqpFqFFxdmG3hT1MWpt9BZ2PzugUZ89lBjzjBs5an0cY7
         5KJSOHN1Th3lCaANgsZdQf8ym3+5NADUmf+Io+kFxT44S2BaC6IBqU2j4+LzFUZPmU6S
         BKwA==
X-Forwarded-Encrypted: i=1; AJvYcCWNFg/YRzI/lqYJ19b4y77mTCfzrA8nAEicwUygr9ZYpYidw23mJ0Z0i5Jbs3aW904yZwQYliuREgoCFgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJeTfKbnlhHe/5SjG1sj0+6wBgduTpo9n5O2OckMc1bPAp5x4
	5ORvnbEDFOWey5jTy/hjM3RUyT3etR0gBSa5ru6eftqkkzNVVoyewoiuUUW3EZ8=
X-Gm-Gg: ASbGnctAkOC3G5duIzTMGqhBvcWFdQ7U+oGjFYM5yG3wuOlFsrD5LQP0nLsgtjaBjIJ
	tYtHTEhsIr1rUS53wjvGXaQtE4oQ/f/cfLWm8Dt6qU8MXT8e37F+l0pWYh1BVfGlSi/CmrdnC9p
	6o9cRlAQCkVCM9Ncj9zPyWpwlEvQsO5CFU3WQ6gri077PrkTvIVHtIa3N224Pt0sZ01yufxW+Q0
	Yyz8eDMygz/4ES2xvm/aJdX+WhiTWAUm7+ma8ooysPGTl+fFjLYWJAFjWrz+KU3QYqC/8nbgd80
	gkwhV05fMYdDIwwo/a+K
X-Google-Smtp-Source: AGHT+IHJ6d8K2hnOLwZegjEVoeae7Dajjoxiun/dSlgu+G3MOV8fyQIllsHLSF3ttg4CQNHc/VyvvA==
X-Received: by 2002:a17:906:2454:b0:abb:9c8a:fbcd with SMTP id a640c23a62f3a-abb9c8afde3mr235343866b.53.1739777569229;
        Sun, 16 Feb 2025 23:32:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbac867bbfsm7724566b.137.2025.02.16.23.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:32:48 -0800 (PST)
Date: Mon, 17 Feb 2025 10:32:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: SOF: imx: Fix an IS_ERR() vs NULL bug in
 imx_parse_ioremap_memory()
Message-ID: <68973636-eab8-4d82-8359-ae2c8f60f261@stanley.mountain>
References: <cover.1739435600.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739435600.git.dan.carpenter@linaro.org>

The devm_ioremap() function doesn't return error pointers, it returns
NULL on error.  Update the checking to match.

Fixes: 651e0ed391b1 ("ASoC: SOF: imx: introduce more common structures and functions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/sof/imx/imx-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 82057af1436c..5a385d140bc7 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -338,9 +338,9 @@ static int imx_parse_ioremap_memory(struct snd_sof_dev *sdev)
 		}
 
 		sdev->bar[blk_type] = devm_ioremap(sdev->dev, base, size);
-		if (IS_ERR(sdev->bar[blk_type]))
+		if (!sdev->bar[blk_type])
 			return dev_err_probe(sdev->dev,
-					     PTR_ERR(sdev->bar[blk_type]),
+					     -ENOMEM,
 					     "failed to ioremap %s region\n",
 					     chip_info->memory[i].name);
 	}
-- 
2.47.2


