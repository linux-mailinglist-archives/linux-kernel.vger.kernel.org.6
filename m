Return-Path: <linux-kernel+bounces-553175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0018BA58527
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9183A167486
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE81EF38D;
	Sun,  9 Mar 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnyb2MfZ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2881E5205
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532264; cv=none; b=CZRVyXPGiJCejz+7DIKb84x2uyEMe+pyNxRm7nCYIgXkFN6ekswvm8lKT0f1WM1PEkwJISsEwwuZSSPRdoSBrOR9GZo5ICCEm4Nb/ekzVvoBA95lWgkc2mhOdZ9QZn0QLYsWxjbBOpl6dWTYIvxXYQfURx3RAaDN59F4H68Xw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532264; c=relaxed/simple;
	bh=uhHFr5ZcBYSXRZg+1EFSf+qV4LAGtXIShJKYOeyyoPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7kmi+RdOprlBVkyIfo1Xmy2BZAiS61dEcQHAXHsxTwqUrfFCTJPj52BPh66hAx/Ly4rsLzQSeUNDsysxIfNldgfIqFToPjfyZHZAOqfF9nkMKzNF7NElXe08E01b9KL+kZedQcQQ8EAa12cmc/Z2DFFRBtFf9g7f4zUjeHWz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wnyb2MfZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so50360f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532261; x=1742137061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBbc0AKb6l4hZdbfGv438FhQVfxtFcmRgrMMnsTyw9c=;
        b=wnyb2MfZprAFcEd7ogfMrL/oC+YC16IWENu2yGCiPKn6uNPQkMoIVvVjVneg3l8Qd9
         NMZEhmB3EsgW4GIMw/dUCB4hdI+zyGNdnz2niiOxM1raDMbzBB31ppSugVtx+H0jGeO/
         iWG3M9tk9Z4eNilkScBgVFo9LnUZ760mu8IL7wjJYHk7Dmp/hE1CQaSB+Pt8MEZR2H9S
         +wSWoiiZWwHNFUWBJJtoC+hzbpynd03obcEfPCQZjHdIxiN9v1RG7pEL88Cspgk6U1le
         v3VSbOyCmP2FBVRVPWOayZM6C3MaJo+8/fSy84VttrCm54dpuITXjEcPdad9n9XYvZcI
         Q8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532261; x=1742137061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBbc0AKb6l4hZdbfGv438FhQVfxtFcmRgrMMnsTyw9c=;
        b=Gci9mu7whWoWSc/QU4E3sqazJ5lgtptQM7apt2OufNICdMVjte/M+mzeCnfk/goJdK
         igQEpvILqlcMG7uaFyOahJ/jtRl5DdHeUgrDajpMSJwvUCI38xw2WpOcL6uEgMm3CZke
         Dc9eVfRiIgZNM4kku8bfh54jl/kEBVc/IWQiXpBGYxEn9vdY3Mfze2ZJ9x47VQpednqc
         C4NDmIGfLyutfFc0VM/qx7F15yNk5hxtLtE+Z3KgHERbj/9eJLu+XjjjdynryMtSApb8
         aLqkm6PWn05w56LRrNYNTiVX1FPvEgf0g7PXRT3ePCSFko3dhy6VERoqMQa7vpWhmQDJ
         JyGw==
X-Gm-Message-State: AOJu0Yxfr5VngJtZbKRzHc+aYT7y9T+Was6PWz6olCA8x4s76Y/j3mSX
	fSG51k9tjXLYWxVhHvFSE+KCtjCHdsgomja76pyFaXLSHnUwSUclXjT+ZSMnxiY=
X-Gm-Gg: ASbGncsqruZbYKlJA45vRPz+ada8whyIliQMgcjibIJoynsHIL6pisohbhiXJqVOe2G
	6cIKPLNYY5etlwbwz397bQ0ZOYs29DfjP9Sar8pp1aNL3GY3Qr9gS0Q5sDDSYtelVXUtwRez08Z
	qwsAj5YAE8u+baS2y0ssAJRuAhCdbiKT60NbSg3kyXW1ksdhnKXnFGadsUnGB9EnHgOGxSynZUs
	u7CzBPYlhnXMkxm644aAUSwGxtSnlVRAo2nHwR6TOjFXM9YF+K2qDW5YMB5Y6aqjYdeP5BSYaqc
	k7lBr1eeK81Hy6StiWp4cgTJd3J+dzhVArBvFHT/gcE3reZId8qRKq5OLz7cr37QCxYrcg==
X-Google-Smtp-Source: AGHT+IEw5h2a0WEn0bhRlp+mlyJcT3pN1A/VuH64jALp+0D/cCHxFxaiwY++WUs3sW8JXqDdRoDG4g==
X-Received: by 2002:adf:a311:0:b0:391:4052:a232 with SMTP id ffacd0b85a97d-3914052a523mr1765987f8f.55.1741532261433;
        Sun, 09 Mar 2025 07:57:41 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:41 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/13] nvmem: core: verify cell's raw_len
Date: Sun,  9 Mar 2025 14:56:59 +0000
Message-Id: <20250309145703.12974-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=JKsSzG/sjkpcuFD+zlm0BqfW6mfZc8rShFE3F/wWs4E=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5+xU7dYgwj+icd5hmOJkkWKWoxYggK1RNy 6W/gO1yZL6JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N1ynB/9ZdeJrhzKOdM2mYnQC+dAmmhE35LfRyC1PloRJTGWaAqx3T7c7hdatFEUUUNfh8Otghz1 YS6DJE5zoqkoj7EQYkC3da1oIEs1qt8XDbZrrql0hvldhyUqB9TfSRUFiJV1o+5b4qTbVTxy+ie JH1LtIFlbe80kWKXfp9kyaPbwx0ArkjECJRM9wmCzcRIVu0jBHv+nsy+kJYv4IXUMZlaj4rXoyJ Ea79ERSfPqYi3UyWpwoq4QdqY1/5M0DBoVElZHdQVx36GuSX40RuQgusVJAKOT0hsML/qveVFUT PGkU3GOeXK3hB/Nw2m1kWPW6MTbK9nvho592if4+J/nZAXwm
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Check that the NVMEM cell's raw_len is a aligned to word_size. Otherwise
Otherwise drivers might face incomplete read while accessing the last
part of the NVMEM cell.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7872903c08a1..7b8c85f9e035 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -605,6 +605,18 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 		return -EINVAL;
 	}
 
+	if (!IS_ALIGNED(cell->raw_len, nvmem->word_size)) {
+		dev_err(&nvmem->dev,
+			"cell %s raw len %zd unaligned to nvmem word size %d\n",
+			cell->name ?: "<unknown>", cell->raw_len,
+			nvmem->word_size);
+
+		if (info->raw_len)
+			return -EINVAL;
+
+		cell->raw_len = ALIGN(cell->raw_len, nvmem->word_size);
+	}
+
 	return 0;
 }
 
-- 
2.25.1


