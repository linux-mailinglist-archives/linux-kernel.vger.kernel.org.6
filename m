Return-Path: <linux-kernel+bounces-518091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19342A389EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436873ABAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F2225A39;
	Mon, 17 Feb 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqHWf6sf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E28227B9B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810526; cv=none; b=O2nXc7qg/r0OjznWyJO4mjPcYWII3Bo4cvp7eH1g4lTWY3/4yOqaFMBldJwcwA4MayqwZ80ucWpaT6xtkp0UcguGESPu2kMyUFYc5uYpHocKJuWfqydIKwSwgtCfyGTiZZ1nSg4CVpOdzyB01yMuLxBTkf/hY81e05lxwaPWMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810526; c=relaxed/simple;
	bh=b+uEdY+iyNFmz1IDRdoHXm0B/oA8pvjvi+pDy5sh3HU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqGcojV5x2i7nkLdAEj+1COvsAezk6SJxMneVIerFOXIQtn6fAuDIOY5Vhktcec9v1R0xGRPE0f1EWW7Ek5e6k7BzfFhMU7c9OrxiAjbfJjx15xE/vkdRqyD2U4nbT1G5cP9NwJBQcpJbIr3VdMZr1iTQsBcc48P+lRpQYZtfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqHWf6sf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbb16a0565so4915966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810523; x=1740415323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6p4+QSdk7352l5SdZRRV5Uk/V8Du1BEH+vmjNhZlpU=;
        b=qqHWf6sfvk9jq7o57uayrK1g/xoGvT1HXuTAUOojIs4UK8tIpJQMFtcfeSSIR0LhBG
         yOd6uN9a10bdKmaWulKlQv0XBlYD5E73e4vyQDaw+qbnjsoFaHA7+J3rXY14ljH6d5Cv
         EseiDH0aPh+oxq8DLVFb0jRIe2DuwwqPe7zZeyNWTHWSqr4tGbTVt6M9M5Yo2Xl65umz
         LmwJrD5DERRoqyWIyu8s5+d2N84bxdfPwnw8ELySQ29HgcTLzstS2OmT3PnGuekOq/7K
         bDcfqc0+t7J/PkIh09tnoq8iBMl36d7vTEUzsgQfARuGdCXMAjOYWz3+n5LjwEsdNpeA
         /caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810523; x=1740415323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6p4+QSdk7352l5SdZRRV5Uk/V8Du1BEH+vmjNhZlpU=;
        b=gntEY1cGEE83tUY93LRkIgKCGtRFU3oht5sI6swl6JzDUM8s2smzHhWl14wM+b97KP
         r+blRjxGF1eRFfXHC4wmsbIHHtA52VEBbxlzBDPkMjSFQBbnuKdgaW+E7HdmZF3Y7kOC
         QfzjlPdCAaJBmqg5q5E9jrAxDsi3zfuJPjF7QsYXPcplEarxH2Dmh1VvTYIoHISWfzH6
         Pb4OkTXtaYfBXk7ijorU3hjNLFj5i3Ky4z2sN+9yajdA2iGIAwNRRahVKZoQnhNIawZy
         CPx+XlGz6ftSByHIuPcKyoMdjJp0uml17dAhmezGdJppLLcbxl76LwQ2dt4zFsvbgUK6
         zrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV98blMSypxyI/AcsxkaUZchl5nsoqhopHdv1Na6MVDXO81PON2DbprQdXddGJfLA/wAE2vZWnXzbcGupE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aPswA5mUGB0dEjs7+PTUNG+X31VOIWYwvdxeCNvzHBjEHCje
	DmcLUYmGdtOuXgQykNbQqXtbz0mri6G+EaHZB2jHEf5+2HfdrHfSNOUj7a33H1E=
X-Gm-Gg: ASbGncsxvCv3FhKlhhmHJ/V2iM2QhHb4x8rS2ymfu9hOCOTrD8lASiy94+6KU72XTvE
	wV344k4JU27r9+oKVt9XRZb73wiAUidZWx+5FKsNEQHToSC5YUdnURvcrvACWtfpXbAsCU52qy4
	z4fXYQbotCeW94A/BLJtBHMni5E+01V48xs+567dtIbtKP0xRDjYyGTSNfMYunfrtar7f6IoKL3
	POyW21C4NqT+COvjVuMhDhrabmS9h9e8YNLjaprHznRqrKEi+qNd6YmyoSeElI2WhzQXRJkFtqC
	nPA8thypvQ7cIhEpRXSBbNMg8VoBx4o=
X-Google-Smtp-Source: AGHT+IEf0N+YXNj+Lsp8pSLDVMmk8n6zVEVjQz9QSgt08hAUoLCi7hE5mlxyzTEta8YrodPyyRpM7w==
X-Received: by 2002:a17:907:6d17:b0:ab7:be81:893b with SMTP id a640c23a62f3a-abb70547245mr386804666b.0.1739810522989;
        Mon, 17 Feb 2025 08:42:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac781b78sm82647966b.60.2025.02.17.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:42:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Feb 2025 17:41:31 +0100
Subject: [PATCH v2 10/16] drm/msm/dpu: Add handling of LM_6 and LM_7 bits
 in pending flush mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-sm8750-display-v2-10-d201dcdda6a4@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
In-Reply-To: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=903;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=b+uEdY+iyNFmz1IDRdoHXm0B/oA8pvjvi+pDy5sh3HU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBns2a/sM6sYomoofm72CEjN1eXM1WFCtr8vOTkk
 B35Et4SOmKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7NmvwAKCRDBN2bmhouD
 10TfEACCYRiC4TTn8bnLGvE29vlC56l6pDMDYXw8N2i1iR7JxQfSkt+G1VnWermPCGGAqingyzV
 zujx4iEb+ySY1ESIg2TVSjU+es4jH5p/yExyqiML8hwntHzZo5ad8nt9T2Js9aC+s+qmU9ADaTV
 4YHfTCfNPtimh/Y7lK3qviz1KcEeEMDtYmpeW9C9SQwydzqapB9ebc6rKjg39yLDvYrxrGuXFg0
 16R2QzW2Tk1ZHKZKXApVF4HPe9SMpnYehocY/0lpCNRaqclM/RGnkliobRxe//OdjAcVYQUeCgQ
 lv9PwljqgGakdLj76D+BXQu4n/w1Yqea8At4rBnfqd5QrNm4ht8xcIWSwaimeC7E6Zr6uDgN0OE
 esgwRZdH+QRyvjROWF2JGxItirMQt+3S0RLIIDJOgzFZyIgsUCiJz0uEUJBgoWVmOhD312M4u5e
 bbsvr7YhTh3Y3UNn6O9+yxitbx7PHLH8S75tLahRHdxPJytzJqZLV7w8ZPIWDr5SSxJ4jcBEhkN
 SnqvS5cwNham3nirLF/rm2Pn5mj7kDnGLSSNv+wWtwFOIVmV9agjIkmMkHIvOBiHnBZ0M6BojJn
 PR2rgDhPivb2tLRncp5+R8fkSyXV3KpeZBXLJRRzGv45MFOTuAp668j/ManMrDwdcJVHBOJ1HQk
 d5LC5uHDSS2+qjw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

MDSS/MDP v12 comes with new bits in flush registers (e.g.
MDP_CTL_0_FLUSH) for Layer Mixer 6 and 7.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 0021df38f8662683771abb2cef7794c3209e9413..9d4866509e97c262006e15cf3e02a2f1ca851784 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -254,6 +254,12 @@ static void dpu_hw_ctl_update_pending_flush_mixer(struct dpu_hw_ctl *ctx,
 	case LM_5:
 		ctx->pending_flush_mask |= BIT(20);
 		break;
+	case LM_6:
+		ctx->pending_flush_mask |= BIT(21);
+		break;
+	case LM_7:
+		ctx->pending_flush_mask |= BIT(27);
+		break;
 	default:
 		break;
 	}

-- 
2.43.0


