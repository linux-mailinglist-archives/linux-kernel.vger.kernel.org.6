Return-Path: <linux-kernel+bounces-551723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8FA56FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CE03AFB8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655D24BBF2;
	Fri,  7 Mar 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbrEB+ju"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918624166B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370285; cv=none; b=adA++n0sjPHunNE8JSSN3NuXziH2yXnA0dktKVcJm0QyswPOtd5K3jeYXnEQLTZTmKic6ul+f30lKLKh1wXKoDjdQwl6ifoN2oPsZKE1Tnf5ocPNm9OhmtE8cZ/0nSX88F+gc3wRP71bYBVZDpYhJkO7zHx1Pl6EB0yh6pLKPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370285; c=relaxed/simple;
	bh=CL5VQxbiWENOkfWwBEcP83blwdFS6pRCFRySkIkfpEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMkiHcnNNZBovq7+XgPRMzOsh66M4WHBwiJFmUUdu1IGYjEtYmCEh9dEuowBNb56pw6cgYedobjzJryElOUgfYe3pHSywUubAwJk3sJNCbcSCpn+VSXSmETkEFjAtVh+RoaK6iKYnqfwmsyJAKeF2PUSEnOThi1PGJqDGFO0pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EbrEB+ju; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso2918106a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370281; x=1741975081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSk3DiPjcws7yxLurqs4gzQevc0VMHE3Mbu1CPv1/P8=;
        b=EbrEB+juO7vc/MbSYLTzI0qclWc3wM8LitozWv+OIBOFLsn+ahjx+z+iWIMQBO8vfd
         DtkiJqxrVzptTX1+ps+oV9hCe9VVVyNNEpu1yHJb96mhtw7GAFdDWJRT6q9WrkVxtHCG
         ucfZNdL6Cb9NqV9lfZ0zVD0ZtywnMVqIE2N1KsJBn4Sgq8MgmrJ77EBIYvFJyCKm7hRl
         eOD4i+2ok05iwcMfGqOg05OcS+50aC2hmtgRxG4IWxwwbcvcH05MfhFOvFofQBG0/6FQ
         dxUhWSJHaU6nlvxTx5X430QKcuZS+FgOSYccwcH6UZ3Jg0vh9QSYR8gigPJVE0bGlkDN
         K2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370281; x=1741975081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSk3DiPjcws7yxLurqs4gzQevc0VMHE3Mbu1CPv1/P8=;
        b=fJRRfARP3feX+B05EZnyNRuVGNrffKAz6mrCIqTuRASd1tbi5ucLP1E2vbLJzeUW2I
         k/j41i5yRwiQqntysHVdsZP5AtcYw1i2ee3tOLjfTnqUFE+rDkS7pXNRLE5CGulfdQyo
         RoQ9AyEMpCxZUvV44zs6KUBzBjANhkWVuj/LijdgQNi96oRsMLQJ9LbKHlbomGZU9UlZ
         QoPjY1aJRZ/Z/jAMRezbKFyGZ0YOjjiByjpdLUQodh5rNjUdsOIdDiNam51v2EftWBB0
         vk7Dfmx58Xb6vNDSQtl2F6H8hiXFG84edN6iKSFOfSqmkN7b9JY7b4dtECm+VlhhPgCq
         rlQA==
X-Gm-Message-State: AOJu0Yzw9bEfjfjovYu1AIrW2rhQ+W0XmQUIU0TY27YTbk/LGVIlRbq6
	MgCHi5jf4ymU4iQlQ+zSFWV8lMU9mWhJURz5kSNIF43tW/iySoZJuDLI73MKXrE=
X-Gm-Gg: ASbGncuZUraEN/DcoGrhaDrbrl/ov+PyOeuOGHAT9rKrbYKO6htqobIG5zTziREYFA4
	sS1aYjwnJzJnIgqwMtOofQ2PfuYdVau5VkDC+zo/+MbJnyiyxCUDXR7zG1AT3YxmHhToPzruu7Q
	u1W0K8dX98jG7u1p6UV8yncMWNhAGBec/a1VBgTl/5qMOh5A+U4DPSYMIkr7znV4itVrYQhEOg0
	AlpnSpYaa0nfNp/xIS1rVTuQhXgcxb+8Jucr26S0yon9gWh3uMoWcYeQYKohJoSPEC9IqSf7dhh
	uVHJoz8i75NNVlEsGbjSGXpmtqnmMfZkSzQsfkOkcfNGZ9LEw9sb8BWkL/9wd070DKonNA==
X-Google-Smtp-Source: AGHT+IEHewVZ77D5LEQE1Ql1hTigIxhOXaY4LRThScV56ml+lGYp+GOLFIo1geZGXUNH3Vv1a4GpIw==
X-Received: by 2002:a05:6402:3583:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5e5e22bf1b8mr3864611a12.11.1741370281361;
        Fri, 07 Mar 2025 09:58:01 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:58:00 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/14] nvmem: core: update raw_len if the bit reading is required
Date: Fri,  7 Mar 2025 17:57:20 +0000
Message-Id: <20250307175724.15068-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=xVVZjRsf56W4+bQzTy7AY8cftfLAm8ijSLXuk7bNC3A=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN96jPOMBgH4szUGTLHYuB7YAdWbuTzMIalV 8RLx+cjJw2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV NzOIB/kBTQbl8usgSteslbgvRoLsbhvGvV3kta9lLU7TKLMwM04vsvf312YxQyfKT0qhBLdOuUs VDfzh6DWqn7Uyea+x1LIf8nku0kJnSkBwY1cXIWTbHwDKRPpHrPWp4fwj9nrhh5oZJ3Lma76sCJ v17ODqZNAieMYOMrJVAaKMVyz4aBCWgZMc3NYIPdaPF37P1hV6RxpZut77CmbwzjApG48OfPvyY qR1gLs2bcA+wcX4VqRBvLvyuzTnKqiez3wVnlkanTaaGGuU9mIFTFXq20Pr4nXNGf5TZe+Nl5m1 J7+6b8V+T+EcITZwZYGXvukTQ2rQRHx97xtRXyycWzWjH9uF
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

If NVMEM cell uses bit offset or specifies bit truncation, update
raw_len manually (following the cell->bytes update), ensuring that the
NVMEM access is still word-aligned.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad9b716e8123..b6f8544fd966 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -594,9 +594,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->nbits = info->nbits;
 	cell->np = info->np;
 
-	if (cell->nbits)
+	if (cell->nbits) {
 		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
 					   BITS_PER_BYTE);
+		cell->raw_len = ALIGN(cell->bytes, nvmem->word_size);
+	}
 
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
-- 
2.25.1


