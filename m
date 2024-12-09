Return-Path: <linux-kernel+bounces-437420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239349E9308
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9092872D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA1223715;
	Mon,  9 Dec 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/BQYd1b"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB1222594
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745391; cv=none; b=FYUe9McC0nOjWjL1cQAa3BSU45gtbGadRjcs4fk8t+MNrvCXO4lkh7Cn06cy+noUw5jj72eC7Mcl3rOmuBBpxs22Y34l7lzFcFGl6vKOSVi7xCLTBdqZvIeHI56kUavHik9rwOhmjqzAwmG2R9V2ivXanZy5oJkALTE/nEXV5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745391; c=relaxed/simple;
	bh=njRJMFS53oVLlFPOfYmEgfNE0jHwMkDusGCNOuUeDQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl+vIJQ/NXqUU54VDXXBtiCg4smjYLm9J8TTZNQ5C8ovmZhHdBneuuYqJ689ytX6XlmMPvwrmSIbkBd8KNOTHqm3QpU2USW2pgi7O+6msEI+mXC8e3igBTtYMqhnsYMkq3GLrq/mBVSrf40l5vyT60QX70M0VwdRrFqSOCsXda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/BQYd1b; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3ce64e7e5so305158a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745388; x=1734350188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDkrPmX+rnC8j6/Av609kaQIfkDAMEkIyzULcEtJ5go=;
        b=j/BQYd1bNGzUkFsKBJ97waycncUj6HWilLt2nGPQr9Wp3LE/rBSW1qHpru2HWJoQlO
         MRqLdiQSGJv7ewJXBGrY+Vnei/L0QJhg/NJTVdrvKtKfO42H7jcyHCwntu3aJhUIl8UY
         t0qj9Qdmu9+E5A36Lxn1ee0Pauim0RJLtyfeSxmlYODjfher7O6LKzeAoNeftXWAqipG
         sCky3v+8JHnfUzd6e3nQ9ruQl/zpbIg5R2hazKrLL1o3fmO5r/8mXAyoFizp0zMadLv3
         VKUw9LeYn5RJiP27gE9ydGgFq4kRocg80kt1/oWxkSx2MEFDaq20LIuDU9A8cPZw06KE
         MneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745388; x=1734350188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDkrPmX+rnC8j6/Av609kaQIfkDAMEkIyzULcEtJ5go=;
        b=qSXov5RsuIUpjJ6JkSgUY57ySsf5hmaSPyr2weBa4TFsnh65KKqI95CwW1j+S8d+Cg
         N/MoKHrTan+pEvoV12nCuoEEIAsSEJvnLi+wHnSuYpenDn0m9fSKG3dWp6rBagHinOT9
         vgbyFm/cW+lvZ2f67G4yG/wdu6F2ds+Wf2rOWwbJbTiyiLMPOtlKxn1oUuT24E4K/Iqm
         Kz8Mn52kR8NtuYkK9c2i77F9kAicMZP3MSCETMYUf2gOmxf49lvfOG8NRH3hnov6TN4t
         M8cLCEDdIPSNy4zI7EDrm21+9TY7xNovWr+w/24IVkt6oMu6T+nhS1dkvaNuzUvjAudr
         uAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWOYx3H3x/ZA/gkzi37Sxsp2De61lnDNGujYqnSkx1Ncqbz8A+zitvRxRxIehcXooXyPKXknVNiSrD1gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymYZ7gXfy1ohSe4AqQyokqZEbgQthK4VyjU1BP5tYlpRnpKKyw
	X6eBepxCVQhVYxt7hAaWAd9zzRysXVag6NOdTMLEDoTPxgnWJaY5fE2xINCxYKc=
X-Gm-Gg: ASbGncs77BA7v8G43hz0BKnyQUbbIuxezK1FxynDYuvydySviyE8dQbwdlOl0hJBPHM
	PSbWjppV5tZARd+mwYr9s5H5LSHfOuz7RFL8rvxf5sUA+Y3vcsIkfJQB58NU3wJeqUdntI8P4CB
	YOqKaKyxdn//MpN/1cQsUUbIF/N4i5I+joCJsZCoYgevqOMaDqGuM/6Hk05Qrz+PuCCsGVTx69I
	m4xeHHrQ/oqgbHQNytYLpsCYidnhxwNPNZQLIa34HFNtgeeSmSK0+7J0ihvJRw7
X-Google-Smtp-Source: AGHT+IGaZyqKQzZD247wMomlUwBJH4NbdZftbTBnrY74rFdm2bKBbV7DjbALRQ98dOG8bxWswacXHw==
X-Received: by 2002:a17:907:3f1d:b0:aa6:2572:563a with SMTP id a640c23a62f3a-aa63a10f275mr510577066b.6.1733745387038;
        Mon, 09 Dec 2024 03:56:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6651c01c5sm343333766b.23.2024.12.09.03.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:56:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 3/4] soc: qcom: smem_state: fix missing of_node_put in error path
Date: Mon,  9 Dec 2024 12:56:12 +0100
Message-ID: <20241209115613.83675-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
References: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If of_parse_phandle_with_args() succeeds, the OF node reference should
be dropped, regardless of number of phandle arguments.

Cc: stable@vger.kernel.org
Fixes: 9460ae2ff308 ("soc: qcom: Introduce common SMEM state machine code")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Add Rb tag, combine from other series.
I don't quite get why rest of other series was applied, but not this fix.
https://lore.kernel.org/all/20240822164853.231087-1-krzysztof.kozlowski@linaro.org/
---
 drivers/soc/qcom/smem_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
index d9bfac6c54fb..cc5be8019b6a 100644
--- a/drivers/soc/qcom/smem_state.c
+++ b/drivers/soc/qcom/smem_state.c
@@ -112,7 +112,8 @@ struct qcom_smem_state *qcom_smem_state_get(struct device *dev,
 
 	if (args.args_count != 1) {
 		dev_err(dev, "invalid #qcom,smem-state-cells\n");
-		return ERR_PTR(-EINVAL);
+		state = ERR_PTR(-EINVAL);
+		goto put;
 	}
 
 	state = of_node_to_state(args.np);
-- 
2.43.0


