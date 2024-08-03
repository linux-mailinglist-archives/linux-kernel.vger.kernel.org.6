Return-Path: <linux-kernel+bounces-273425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BBC94691B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F6A1F22CBE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8072135417;
	Sat,  3 Aug 2024 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1VxwT01"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E451133987
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681709; cv=none; b=uEbIZ1PC7zdN8OgejyBCjWT0TcCbvXRHJnwkFgEhnnbxGQ/o0rp++8BaU+Vfci1i9skqLUtu3TUnDnBi6C47JfJ23cAz2H8AK4bnv6EOsRGlxvmkornRouk4JDvdNAzwk7w7T9O1YM8KkKjPCVpmtiiqSxckY3KvWDqpiEwg1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681709; c=relaxed/simple;
	bh=5AgJN5aHDblbftkEIFfXfOsOG4+a7awLLmKJqobEli0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8lN3OraV7MrYGB2xDq5StdbDkieKLSzB8XeSC2/+17gGLgW+dU8ndXA2g2XQb4/szjYKpBGBdMhNpA3u38+Py6klivbnfArPNBz/7FDDQJrh4e7EkdAKtELEd5QR1HYAbfMtoIZXWhWy28UDBapb0JIkri6dyGj4NRQiGKZzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1VxwT01; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a94478a4eso717893566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722681706; x=1723286506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8XLJ+HA0unzIKoKdtjXDUtkUVFRpH3N4K5zB2zQ6s4=;
        b=k1VxwT01D3KMJEO/kmfuMby77/JLWaNMCCCAaZ39VCgJD38z0RxCnO64FjXSf9tVtZ
         0bgTWBqxMw5siefbWP6/IsmBeP60bR5+ETwmdSdo4ngPhuCpEnWTNoNlaZsfLiy4YPK2
         7Lp9cym70xyRgAQaxsrxGTorMrXR0E7BaQbnIr1zsdAR88WzZKWDgL6FrareMpp8kq7H
         gRp+/4SDl2w1m7d/tqgwtUP34S6OFq66MJVHt+KVphTR9Wm5jT8hJ4vaFFXLdQFw74sM
         wkQXnuxErfPcKFic7b+MsAGSjC4hrG2FxhmCSJWoVyKdQIHClSqqGHWv4LvhfQxhtShN
         Kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722681706; x=1723286506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8XLJ+HA0unzIKoKdtjXDUtkUVFRpH3N4K5zB2zQ6s4=;
        b=K/9dfwH1shxh6F4rEZz4f8XgZE7oIvQf6YYO9wc6XRGkv+OjbD8ijhGzCGgvSXkhKk
         kz/UmRcSHyKzo3NTeQwlkgLU0QGlRqYesjjLziBpKD+oHmxqcvqqq9k7NR5tWISXpuFq
         SMwJFyv+ItjpPGv0XjxbxgDWV/9u+GCG9K2yRla+KxheQD+YVuNyV1uZiLYx2n9UuTdz
         vWj/k4pfmic3HURQR0LwrnmMX8Q/QqvkLdKKUE5jlEBI2HhHloMTzUcYJtfGb+3mtAel
         +1mRqWMvqFmR44tu5oYlwt0A+ZfvHeGW1nzCmSGWzBu8KKCjkWvurE3owIOgx0KzI8is
         necA==
X-Forwarded-Encrypted: i=1; AJvYcCXhF+2Da2/gNSaH28N2DGcfTYqPUkKYEHCo1nOU/meq4ASdr67DFyFcdTy6xteYqMv8nO8qOHN8NOb06MHQtrxkXF22nKiCv/JylFoO
X-Gm-Message-State: AOJu0YzFZymWGA+VnEyyMDhJCwNylM2LMKKWBpVB0qRe3HCCQC5uzOaX
	Q0Op9AgSKirDPU7YsuM2BhJ8KYeovic0bH20G4SUo7LiHdSlteCRTPqiLK3/jcw=
X-Google-Smtp-Source: AGHT+IHvt7AU+zU7xwu3ztuEExFnHw0l6EN0M9aJEJT/i5CZBMm1ydae3AJtvueqBZdlyT6zILCzIg==
X-Received: by 2002:a17:907:9689:b0:a7a:81ba:8eb3 with SMTP id a640c23a62f3a-a7dbe630868mr712622766b.27.1722681705810;
        Sat, 03 Aug 2024 03:41:45 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7feecsm202086366b.176.2024.08.03.03.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 03:41:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 03 Aug 2024 13:41:40 +0300
Subject: [PATCH 1/2] ASoC: codecs: lpass-macro: fix version strings
 returned for 1.x codecs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240803-codec-version-v1-1-bc29baa5e417@linaro.org>
References: <20240803-codec-version-v1-0-bc29baa5e417@linaro.org>
In-Reply-To: <20240803-codec-version-v1-0-bc29baa5e417@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5AgJN5aHDblbftkEIFfXfOsOG4+a7awLLmKJqobEli0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrglmLHOXtJFkuzvtwm4NKEq4/Mw0jlQEd65rl
 co+5GQLEJmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq4JZgAKCRCLPIo+Aiko
 1VFGCACvWH4yrjqDg8O8sGmAjvsoB7gb1LhWyK1QKUHycyeWlFzFIe+RQMGDqrWahB7sI+3kVCV
 o57BPiJmwj3QT9WRDwqaRt/N35ws7e8rmLeg33I2mVe2aimoKjenIQsiU31f82e9oxyfAxriF3z
 cgsdqXUiubsimZUB6bNQUtCWDWBdAW3kHD98O6eAV+fN/70yoCp13O+sLh2eIFwI85BQJHpBBLv
 MZCkKSIfQTFcPQNq4IqtffQt7+o++ReYgL39jsSq+mHzj7ACmXa5yG0OsCRrxVZY9/u8DmSqmnL
 na6rBtue7cMa1CdXkfliOOOhjaofxxnj2TiuNvFgW0bqyb2K
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add missing cases to lpass_macro_get_codec_version_string() to let it
print the correct codec version for 1.x codec platforms.

Fixes: 378918d59181 ("ASoC: codecs: lpass-macro: add helpers to get codec version")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 sound/soc/codecs/lpass-macro-common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index 21cb30ab706d..fb4b96cb2b23 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -49,6 +49,12 @@ static inline void lpass_macro_pds_exit_action(void *pds)
 static inline const char *lpass_macro_get_codec_version_string(int version)
 {
 	switch (version) {
+	case LPASS_CODEC_VERSION_1_0:
+		return "v1.0";
+	case LPASS_CODEC_VERSION_1_1:
+		return "v1.1";
+	case LPASS_CODEC_VERSION_1_2:
+		return "v1.2";
 	case LPASS_CODEC_VERSION_2_0:
 		return "v2.0";
 	case LPASS_CODEC_VERSION_2_1:

-- 
2.39.2


