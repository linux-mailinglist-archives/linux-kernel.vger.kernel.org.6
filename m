Return-Path: <linux-kernel+bounces-432507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942CA9E4C48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25F31881861
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7597318BC19;
	Thu,  5 Dec 2024 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVtsZenq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D365383A5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366031; cv=none; b=Cj8EfRNX/QUq3AIcHbh6Vfi6bQXosO52Xzp6KmQaazQpPMPCNVhNbIGEU6oIzzUOW9pmgUAE+9z7utd8VCuVGyXuQr39uh4DXxaJoXIp0RyMZJOLNpIwg7WBfGXsekejiWjbmiieSjIS61PNPKx/hc7kqr1aYxXIV4jM2E3iaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366031; c=relaxed/simple;
	bh=xhvG2NwxZkcFR2qB1vfTSDmCdapS/aAksbx9vqP5zRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLVnkOgqst0hhFbfmUn/r/raXzHyL/0+EfhRIt7U3R66jH1oAgTejzR15ng0B3v5ZoRvZ/aojkx6wnrt/mHn6LzV8tl27szQ4TZuqs2YzHMW80/9JtZ0u/PsWMbHixqW57SJq1x8JZs7jSaDZnDwyRk9qC5T77AMG14ZpOOlpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVtsZenq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso2647305e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 18:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733366028; x=1733970828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw/euE+jaRn8KaVOalk6xiOyoDYKCjli0xV5JRXUqKk=;
        b=HVtsZenqqmf2GIaHaHwMI4CQeBSGrP2f4KYceQoyYlX5igziiZQIR1068CCGOJxWrJ
         8cVYj9tRpbE2d6FNWADYkwUf/mPkTTbs4SMVab4CoNYBaaJRu7Tp/w/ZWCXZSisFLJGI
         yMfZP7szpmPqZ6qP08h9EMDa62W3Sh6/Q7iTwnzVBARES622ltZnwfWm9VzsomO89EWE
         rT/2uI+phns73rwwUEGI5+HUI6f69uUd/kPZD/Bpzh4nNFK5DsYV0gpMnZKTyiiWBCLY
         NuM/xw60tWyrpfns5WAyp9PY+WftTEcFiFso0I3ndYl0S4LwQuci5OgE0/8o+IcMj66f
         2ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733366028; x=1733970828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw/euE+jaRn8KaVOalk6xiOyoDYKCjli0xV5JRXUqKk=;
        b=nCJDHLgxHUlh5dHI/tKK+NPHcnWljkyJlINsAF7ihYskCK1zxe9yE5hTxnwIOyuO9k
         1K8sc+5mMXY0nty17n4hg7hRc7OsQeo86XCCHJvE42w+2bezPEhkAJ4+4h+BP6IJ8Org
         71ZnZaZK4Sw81uLeQCqeOoBBlerPpZ+VoSzLrZ1AsZ745p21e+CADZmFreqsfKmLYHc1
         GTRFZEk/9/Pvi9GSBI7tH9HrfFQpNQ0KOxHpryCoSxmyVjEmpDekfALmlv0dG+GsM95O
         9hWAj2UMU5ETbahCIO5DGlzaizBGUO68nYzFjCmpwTmy+Q0h72WV49DtnZg8Y/GnQnmK
         cTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXCIsRNh7Vr1Dok9nmSz1sVCnkCvsUO9VmM0xm3MyskxycDhnQ5Y7mBOvNZ8i7G8hyJhQzsWB72M8zpnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqWOQyO+cDzlupyJJAa9kFtGHLlkGJ3jgI8tn+9+e6CjxRMid
	0PoBsAncDUQLHij1Rb31kg/eABgeGwz4Ldy6lcMnOQaF/zWN8tBK/8LdGFkUkMI=
X-Gm-Gg: ASbGncsXiXrUu3HgkzeOF24g6wIfGt3O6/nVF0onou2VxGHq/VNTB4Yvww8brPfJ4m9
	rkhHRAnlryDtqw7DFFKO5QpDXkTK3pziZ08q83YuzZ+3uRcm+3jzS5qvsWByBMLk+9VslxgRI/+
	SGO3UAsUJmVZjTwl368T1ZukSkY5nNmr28NQKD0oSifmbfsot6ZrMiSWjUZeQ1bAFXRgkVjwSGg
	zxVFNLGoEKI+dlYg7k/y8mWKzB4W1s6sL6aMV6ZT/D8xIIzYlRmS2IljIgbmfGyvSvN
X-Google-Smtp-Source: AGHT+IGRZIMmR1wcEX/dxzQ8T/nOq0eVnMC5OkJbJ1F2kUPg8auZ3LPl2T+hZ3Yyor0+FmhMD22q3A==
X-Received: by 2002:a05:600c:1388:b0:434:a04f:2557 with SMTP id 5b1f17b1804b1-434d09b1575mr75575205e9.4.1733366028411;
        Wed, 04 Dec 2024 18:33:48 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273440sm44444325e9.18.2024.12.04.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:33:47 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] ASoC: qcom: common: set codecless link to be a backend
Date: Thu,  5 Dec 2024 02:33:42 +0000
Message-ID: <20241205023344.2232529-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205023344.2232529-1-alexey.klimov@linaro.org>
References: <20241205023344.2232529-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When codec subnode is missing in DAI link description in DT
the DAI link codec will be set to a dummy codec and link will be
recognised as front end. Any playback attempt will fail since it
will not be able to install hardware parameters. Fix this by
setting codecless link to be a back end.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 928cf5cb5999..e8ae15fcb1a3 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -159,6 +159,10 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			link->nonatomic = 1;
 		}
 
+		/* set codecless link with dummy codec to be a backend */
+		if (platform && !codec && link->codecs == &snd_soc_dummy_dlc)
+			link->no_pcm = 1;
+
 		link->stream_name = link->name;
 		link++;
 
-- 
2.45.2


