Return-Path: <linux-kernel+bounces-426175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E959DEFDC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E42628168A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32C15665C;
	Sat, 30 Nov 2024 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shwjXy2o"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E36155336
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961353; cv=none; b=oSl8/VeOVV7pRcYoLWEhQz0lxELFhBwysby4oTfQdVIV4e47xhqeL4iD/kl1dR+/ma5RjKcJGitkYHSLw5qf/zf5NYjNN1JlQ7KvmhIIiGhdpYxMo69uyMMEoP113nuPU+nYBahmHzxgU2P+AA4PftF3lCdVXAM+E+JiXdipt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961353; c=relaxed/simple;
	bh=Weo2a5ax1Dgd3G4tabJuyboWF8oq3jSpkgDF05+i5rw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=REI63WmmlWyQ3Nv4/MePGO9h59cM0L97oAUV5samVDWiWtx9a5asoXlaeUa57Qli9FX7frqbi+ejsdTFpKS2HM+UMowyEJj2H3G3WnG/Pgb4xwoRsfBMZ22ZjV8yTxsJ1OeG+g5affCW+6DUUQ1EqdjxJT5QZOWJDpLjDD9UIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=shwjXy2o; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5500f7a75so402602466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732961350; x=1733566150; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAH9/uMjrIge6JK5bCm30pjNTYCTeIEEafsvRP3s6t4=;
        b=shwjXy2oDhi5ItM6msESdX0ad+mtnsrYYEClv+EUxN9xo5eexZ7M418iqbcbuaKRzY
         9x3/HHIeMVtQeNXZgocpOZR6D9RYUB8HC6A93t1n9Px9dCZ+ylXVRWTyHU0xKz/MLtl/
         8c31TOOgRX0xiMn+ZQQADJ+I4mSRP+yHt5O5hPw512AWqx/5k4U8r7AZk8ksVIIZgCU1
         Kq93SqCGiJhMhhhA3wO8GSVH4G8KKzetwcOsfRUQhRSiUGGI8kMcVhme0ugVJSY5Jfgw
         DAb1qC709n7aYgQC+ffdjG5LrrzZ6/mnkxSGV9qT30pgtAqeiM7qqcJFEVatR+p706hU
         64pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961350; x=1733566150;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAH9/uMjrIge6JK5bCm30pjNTYCTeIEEafsvRP3s6t4=;
        b=Xq70lf9w0XlzGfC9KhSD8nNGgicauOB/PdiaX1Hi7oQLQr4PxI9IZ1BcJNbYZ1dlr4
         X/Eu1JZWvoYV3y+FBuxHQe8UurTTWgGelm41k/1vtkQ0IguJrvhP0hJCVwITPF38LDPc
         v7QLdsSGtVNFe/VlwPsSvrjS7oYw1ffHMm47Q2y77I3E5Wk5aTLO1LkqesJAv//7NmxI
         SQKt0rewEhRhTgQT9GzKZWIn1DEaSkflMaspuLLgW7MWtY66uWIzmzm1R8iB9EDK3qfG
         KgJijI1qbxWg7JY0VEi1oV2uXO5ihvJsWe1TEoSddNDJvgkTBPm2LRM3O5s5SdnUW/lq
         L/pA==
X-Forwarded-Encrypted: i=1; AJvYcCW/BpQ10ZvjeggavmzX4gG/5dBS2j14VF8Rmc+rslSlUYy2HmUhBR8sZulhKT6cmXMTUACYwvaxAIWR+Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLE7iFQHu0xgNQm+ofKWhiCMvGF7uwkBxHKg1XqQoROFnqeSh
	F6v8la0Lh+R9op91001HwFmCMRBv2QZGavw+fGcoBTK03ryhsEM8757b2BKy1y4=
X-Gm-Gg: ASbGncusLAd0IrABMLoCZF1rSSO2fjKL8VJeXL8zjGsuNA5EJXCi7XkvK+9+7G998or
	SBnPw0rFCmkCkUbtxySvsxk/4C/0NKmoE49nGYyjc5Yq5EZG1toPCkRx11n4zm9aXeo8OTkkcFV
	q+zlzIqVhwrIbsm7/Mw0CH84aW/6M88kEojaFktRlKW7qUpY3Rn6laCjTLe3CZ3u71LCSj5O3TY
	6Q5rd52s0AnoUbowCtkFY11X+W/RweuRdMPCFq0DZjeD2WDWvmjgGm0QNGpaBApjNAd463B
X-Google-Smtp-Source: AGHT+IEPDZM1flLC7d6h2HgZwNLzFPMq58Jh4oKHV3DLxZuKAwi6yH0/K5kWtWvk0GadwpADW8Y4kw==
X-Received: by 2002:a17:906:3091:b0:aa5:4b7f:e70c with SMTP id a640c23a62f3a-aa580ef2b2fmr1196125466b.6.1732961350575;
        Sat, 30 Nov 2024 02:09:10 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a9dfsm264657366b.157.2024.11.30.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:09:10 -0800 (PST)
Date: Sat, 30 Nov 2024 13:09:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc3-topology: fix resource leaks in
 sof_ipc3_widget_setup_comp_dai()
Message-ID: <67d185cf-d139-4f8c-970a-dbf0542246a8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These error paths should free comp_dai before returning.

Fixes: 909dadf21aae ("ASoC: SOF: topology: Make DAI widget parsing IPC agnostic")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/sof/ipc3-topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index c2fce554a674..e98b53b67d12 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -1588,14 +1588,14 @@ static int sof_ipc3_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 	ret = sof_update_ipc_object(scomp, comp_dai, SOF_DAI_TOKENS, swidget->tuples,
 				    swidget->num_tuples, sizeof(*comp_dai), 1);
 	if (ret < 0)
-		goto free;
+		goto free_comp;
 
 	/* update comp_tokens */
 	ret = sof_update_ipc_object(scomp, &comp_dai->config, SOF_COMP_TOKENS,
 				    swidget->tuples, swidget->num_tuples,
 				    sizeof(comp_dai->config), 1);
 	if (ret < 0)
-		goto free;
+		goto free_comp;
 
 	/* Subtract the base to match the FW dai index. */
 	if (comp_dai->type == SOF_DAI_INTEL_ALH) {
@@ -1603,7 +1603,8 @@ static int sof_ipc3_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 			dev_err(sdev->dev,
 				"Invalid ALH dai index %d, only Pin numbers >= %d can be used\n",
 				comp_dai->dai_index, INTEL_ALH_DAI_INDEX_BASE);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_comp;
 		}
 		comp_dai->dai_index -= INTEL_ALH_DAI_INDEX_BASE;
 	}
-- 
2.45.2


