Return-Path: <linux-kernel+bounces-204132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31D8FE498
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6626CB2758C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594991953A7;
	Thu,  6 Jun 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncFqx3Pi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09ED18C33C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670972; cv=none; b=VplKFdaxqK/vkmk6ln77t5hAZ3Vgncaoi2QbC0onwvPdYZlfm8QbWJDAtdQkH2F3RivQC7aMFc9E3nx9h2FzTgpWTL+l83HU69Y/6AZzHgADCSjpNYJhNRO0ciCK/X1QLXWnxXFdF7xeJMaF+qYqE7cH9TAezzLXDcBPN1y3Kb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670972; c=relaxed/simple;
	bh=A6SXqGkyXxxcgHrEZHtDmBI/tOkvX/XnW5ssJY9STpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmUCI/5ZJ3DZNKgBAK/hUt/1r9NAlcFVH16b8RCdnjCf/EmQxsbbIxaf7uGukvXCdQu15tQ/mHUnSG3jJVnsjH5/f7t7itCuSm7A5r2IABmBzyjV0f8NMj7udoj11AEvvCKnXEt8jGn1W3HNgCIlZw079ordYWFdbnTwTqFL7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncFqx3Pi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42108856c33so11350545e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717670969; x=1718275769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3FtJnXuanKqQrI14wMr56vQtXua9vfr0htfdfN4mK8=;
        b=ncFqx3Pi+v/GVLF4h3HueB4Mg5izbr6ghey6c+x8IkhWROlJGucWpqIxCONo/yRk9p
         5Y7rW6PQ52bHX666Ui1cqraW1lggKOKbwigpbK0Ly+CWNBmkQr1lXg+gj+vyXxbA8R2p
         55A1jaCb5cx7sy+pG8Xn1J21JYuClBFvgIkbEYg+xzDFBSgoV+tYyFvSxVBsF3ZZehtB
         lFbtRk5G0eAopV0t0GfUoXloNyNPS3AkWlLO9+z0ecupcCsrrsSPkUZxsvGpBH0AqfZv
         oagEbVnDIrcVys8nPUMr2MQk4OuD3ik+6+nLyABro2zrxFfTmrVUGMEKC5/vgOmfAiu8
         ainw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717670969; x=1718275769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3FtJnXuanKqQrI14wMr56vQtXua9vfr0htfdfN4mK8=;
        b=gEdj/dAbrwAOYgFWYoVFlfXWvyIFyOfq4stVJzHh9jehJlGq3iduFxdMPEWp2xxvA4
         lrGr/B9VpV90M9o6VRO0qvSzPBAZdlvfKyrhe2wZkU2nm2jXq7eIPMpSJ37pgwkHDY14
         QnsQcRa20eVtFWqWIZ1c2uP079y2Hat7p9r6pMuoPrMfOWlmFR0R3wKFu58YtagZL6Py
         vcsT3I4eBSosxdw+SOXb59ZMOmM7jUSH7PGf/9Agw0+jeA6osUWBbHdTShdJvAGVu53T
         kEKtYLAxESY4AD/MhG4qrYY2GHL4TMTIAyvZTIglnXw/N2km1+lKKCN0U1YUsZAsK4Q6
         C0xg==
X-Forwarded-Encrypted: i=1; AJvYcCUZrFK6BxflObRYqc8yp6WVi7ECMghIW6trVczoBI5AzcteneAJyRUKcxj/fJJZEoSVDTexkLSQh2E5tPdU59p6rAp/SH7nTzh7ePwR
X-Gm-Message-State: AOJu0YyBYVnYu3y1qaC21eI+dWgfFVWIQ99k9a7YSuZPQq3sCuu0EAVO
	iVEb2eN265+gZTOUvGYhu5f2gHXXLLg4kea4us7W9ZORrRI8DbhREOij07rjv5o=
X-Google-Smtp-Source: AGHT+IGGh1ki9EKzIXM30V5LNCm2Ko5lpV0vUeAV0GMLMi1Sr1y4SqZGh77dYQrdKIRcuwCFwEQ0Rg==
X-Received: by 2002:a5d:5223:0:b0:354:db90:6df4 with SMTP id ffacd0b85a97d-35ef0da7179mr2046837f8f.23.1717670969348;
        Thu, 06 Jun 2024 03:49:29 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e95bcesm1223185f8f.77.2024.06.06.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:49:28 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	krzk+dt@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/4] ASoC: qcom: q6dsp: parse Display port tokens
Date: Thu,  6 Jun 2024 11:49:19 +0100
Message-Id: <20240606104922.114229-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606104922.114229-1-srinivas.kandagatla@linaro.org>
References: <20240606104922.114229-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ri4vhulg4ZINJtTQIuA7x2JtkitUZzfgA3Wq29ZBz3Q=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmYZQxG2PLQMRgwWTkOxdJVbHoXpyRODp3JfC8D 48WQNk8tgiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZmGUMQAKCRB6of1ZxzRV N7iQB/9w/lG+yandz7RnuLtqKi1u30/oeoJ2aJw1Z79swhcGbEJ7eMqMVbkZ9PaHhPOPUIZs9jR tctEaoWtuXyhgaPVGVzPg0/I0AUmXaw/hlzxuj6BdhA56PYB5vk678+6iL57kY5117PQzRqapOH by9WZRQJtaq6oAb8w3WlnJuxKlCjwVOklREKzMTTXqwYnuS7l+OZAFyesYus9XRLQ+cchSISBTN S8QQS5s7Pn2Cjiqcc8bpPYXS5pfr/JnE7wqkiOau9qLM1iIvyFn5wNszwxWPdbWdpbtjj17I5io rNZIQnU2vhuz4gZljD2QJWPBOIVj00r6VOtsicZ/9kVeWXZG
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 70572c83e101..27a5adb201c3 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -730,6 +730,29 @@ static int audioreach_widget_i2s_module_load(struct audioreach_module *mod,
 	return 0;
 }
 
+static int audioreach_widget_dp_module_load(struct audioreach_module *mod,
+					struct snd_soc_tplg_vendor_array *mod_array)
+{
+	struct snd_soc_tplg_vendor_value_elem *mod_elem;
+	int tkn_count = 0;
+
+	mod_elem = mod_array->value;
+
+	while (tkn_count <= (le32_to_cpu(mod_array->num_elems) - 1)) {
+		switch (le32_to_cpu(mod_elem->token)) {
+		case AR_TKN_U32_MODULE_FMT_DATA:
+			mod->data_format = le32_to_cpu(mod_elem->value);
+			break;
+		default:
+			break;
+		}
+		tkn_count++;
+		mod_elem++;
+	}
+
+	return 0;
+}
+
 static int audioreach_widget_load_buffer(struct snd_soc_component *component,
 					 int index, struct snd_soc_dapm_widget *w,
 					 struct snd_soc_tplg_dapm_widget *tplg_w)
@@ -760,6 +783,9 @@ static int audioreach_widget_load_buffer(struct snd_soc_component *component,
 	case MODULE_ID_I2S_SOURCE:
 		audioreach_widget_i2s_module_load(mod, mod_array);
 		break;
+	case MODULE_ID_DISPLAY_PORT_SINK:
+		audioreach_widget_dp_module_load(mod, mod_array);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


