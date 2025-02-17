Return-Path: <linux-kernel+bounces-517116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A1A37C54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0943B0141
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7431A3152;
	Mon, 17 Feb 2025 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXMqjGEx"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFF19ABAC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777585; cv=none; b=ukew2cc0qJH1Vt8XP4HuYScF2TSVG8XmRTQmMsvE06BXEzHJj/1v/v5p0kccTSUCzq8N+p5KVjEATgxCc2i0sIfdQdBtoBRgwbv6ZgGyGks1xJBfpJOByYsG/+/65U72yXKIhNumuQ50z90Q3H1740v0IhPYK1INqQ5obIYpyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777585; c=relaxed/simple;
	bh=FfWHZuQZXypGn0iKgdsEA81WCv53fdyk91H2fpR73eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4TfIh3RCSdLvK6bjW0qjsOslReBt/QP/UZdZ469rEPgiN52b6M/bygUmaZ6MDt9YUz1maTrLdfN+tSB+DwDh9ocwR2pMYhJCUg6oocrwwcytU1G83QYlYRQl76i0fI5cbqXQwELtdYrR9Zps9dyw1StcAonqdQIYdCoP2zpXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXMqjGEx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7360894a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739777581; x=1740382381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEayik6VOEEEPJcIMY5xwgGCKxgBYCRm7JNtr3cWVws=;
        b=hXMqjGExdlV7VkUlUeurStT6I7SP6UnaF+1YEoVfdfqZOyOaCOly3GwJWw4IhiWDNm
         lPxjH8xCMqZ+SMdf0Nla5o8zJjtlU+RBdUANdohgqOLHJSr8q+K5vqNInVijaQa2nWEV
         ssgSnfR+E0q33HmOCGojhZ1l+GAaUbNCW8JYD6JSM329WdI1z6NaFjWhcJNLwFJVdc1E
         yEiAoQZYzBMg2w4v7YofUPNcKb6QmzspCYJpv9PM9twn6y9oaMApZAm0CSiXiJPRvdV7
         LsY3mz+mM6F/F02dfrlT8wwSEh5gZIrifNm0udXeso5raINar4fJMOuf2vKrHB0EToPl
         XtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777581; x=1740382381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEayik6VOEEEPJcIMY5xwgGCKxgBYCRm7JNtr3cWVws=;
        b=wFj7PGfDnbNLVsIpR/KMWJiNs1d0vUkPSCx5iMEBYemDWYrpki2q4L2zSYh7dqy3yU
         gL3UD5QTfUCPydpZ7CPCFy4d7dg1cJUG2QZ+NcWoX1v/MQ9zJhmgUyCnkU6Mmi5s3nwX
         aI4sW9A2QHZKdTGsNFRXIjCzndEiJO5idWmcRl2C0FRCmJ3N/yLtdooYvEHhE2gEuW58
         DNPGwLjC+wkhqvISp1j5dpaKvNt65RbxHbpYHZhFaXGaBNVtaRXlwlmtHspDHhlNcnrA
         tNS6QK6JG1Tc3flC2/3EW+gCoHdqIVOrzBR4kD95UyozbOrhaYlDe6P9aS7IFN6DDZqf
         SFVA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1GG0HG03n8aHj5ffDb+oCnoUtl/bkVLZTUsErKD9vu/2lLje5R95ReT5omr/u2R/MVadRqdwkjxrcss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkfAgsxGmfyRAeiRIJCZLXOGfrenI6Ol2mHNDguWTMc5E7k0b
	2OotZH93ZxaQSo4DXVmECnQcKXJYUbnifORL1NEyjHR8DwoS6XsLSQ4VrVzCM+s=
X-Gm-Gg: ASbGncsQ4OWlqlRLg056az/0gF5XxnBOYIFAoB+vGIxm0r7uxFZltiGsTnlxXWqxdHU
	s3JYErTT9A12lMP/C23/HOQMMqrLe1LMFIJGcBDorX6xpVuBdyRl2jfOPmugfD5Y6YnrkDz4TZr
	0n9/IisEA+xgJiDmWfTzCYQ40KM2D46uK0R1SY/pfn8PYEKoFL4LIVB690fsvotLFsByabca4rP
	7pLEwUUjXjy+oenggl35PhzbJv38IFDTYLcTLtRVreaftgnnC7oL3JJ5E9wWJ0Avaq7fDjBowIy
	9Jz0MziTdp45D/JgJY3g
X-Google-Smtp-Source: AGHT+IH5auVQWVVUALzd7Oc0j1nTT3hXLvhxHDF3eAMDVv+bnSi3aCKfLrXYNuutS90Ras7QTpnZRg==
X-Received: by 2002:a05:6402:2384:b0:5e0:36c0:7b00 with SMTP id 4fb4d7f45d1cf-5e036c07d5fmr7098145a12.31.1739777581089;
        Sun, 16 Feb 2025 23:33:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece2867a1sm6812015a12.66.2025.02.16.23.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:33:00 -0800 (PST)
Date: Mon, 17 Feb 2025 10:32:51 +0300
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
Subject: [PATCH 2/2] ASoC: SOF: imx: Fix error code in probe()
Message-ID: <b30ffe7f-21fd-45f9-9528-d6d689e04003@stanley.mountain>
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

This accidentally returns "common->clk_num" instead of "ret".

Fixes: 651e0ed391b1 ("ASoC: SOF: imx: introduce more common structures and functions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/sof/imx/imx-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 5a385d140bc7..b8df8bbacad5 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -424,8 +424,7 @@ static int imx_probe(struct snd_sof_dev *sdev)
 
 	ret = devm_clk_bulk_get_all(sdev->dev, &common->clks);
 	if (ret < 0)
-		return dev_err_probe(sdev->dev, common->clk_num,
-				     "failed to fetch clocks\n");
+		return dev_err_probe(sdev->dev, ret, "failed to fetch clocks\n");
 	common->clk_num = ret;
 
 	ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
-- 
2.47.2


