Return-Path: <linux-kernel+bounces-418409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546719D6153
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15638281A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233F1DF720;
	Fri, 22 Nov 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rS2WEDf7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05F1DED6A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289226; cv=none; b=ujjKA7gTqIJvp6GBOi4VjlwZbpPerSbdqbV7e/Odq6Gq7WYPQ1D+aBiMT8Mo7Sgx0BFCmi4z5hoyB1HxhR/c8MTkMld804+chpPUCeXJikfEd/6VHWefstroLH7i7YdRbQN/v/cbNpt2ka//J/dnOJJh+ksB1obKFsNuAj4lRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289226; c=relaxed/simple;
	bh=WEn2LdCENvI7ZZRxHVDvG5b9idzgAhl/oH1+Mhlk0B0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NxIUbZhNuxDiwRNSABPvKYNKOOZQT05rJq/OLL7mNrhokeR6fU0PPMxPeZvDG3K5Uk8mujTbPauqpBoZEgYypV+wETEWtNr3XN6j2BbehKv7nvh+uO19pZ1PX28svNs9Ux5m2V52MX+QW1ML2zp12eSFXIgHMAidj4NPQW1b+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rS2WEDf7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso3349015e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732289223; x=1732894023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKboDuuAfYreEQlmYjD9FbJSEQzkrF5QbvfF74wL8Vc=;
        b=rS2WEDf7SU8TvQ5soTItLIvrQtsaxQOUN2i/OWMDgAN/UOlkm/TrXnilUTcyb3V3u2
         Bae9apcWcY+SXbQy0X1b3Ye0VuJdcrW7EbpBwB4ZB8C+nBCrQ+R7dUkVke6LOGT4eAlS
         qvCxq4biH7de46Cna225nf6gldyRF7Cn0wyXqZXxEZIU1EuLzN8VjHnfFuLh+ruGQZIs
         jv66jgeJHbqY5o7+TrHyiEoR6PJiWysgm2v0cNmdG0P+z+062UUteQVm1bSZt8yWkk8D
         ZEgR7p4XUrLuBaDnYg7ybJFYqSWfyWpCt8Wg4XfXgXFZ5DfsTx6fIxqR3suvpXgA4B+K
         DqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289223; x=1732894023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKboDuuAfYreEQlmYjD9FbJSEQzkrF5QbvfF74wL8Vc=;
        b=h3+mOCQM6Y9t2BTEAgMCsav0JNwA76iHcdtzNbwfGP9aHdA7HxgnAzD32943adAUWp
         5JCbm84NTkbEZ4vhzFRgotwaX9qG0aJMAPF/y0VIf38sEwjNzZVwvQ0JNP1VJHAKuvYi
         jdjOoU+ucycxXepw4ZyQ1IcKb2E0CWjV8YduhcFODuLPilkH5BViQJNN9VWBmsEpCYCz
         VPaHm8gq1YzGGSqVgaPSXf47OQUIrwz4iFI8x7MH5KOtCrTNsTdlPf2jzb0wAQkwUot2
         ITfiIiZGJw42Iz90GGhu9bUlMKeioO0x+RYNQiecAfSekIpM9xF70lcIg+PMJlYxufAe
         w77Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2/nDtZcOaD9WMk2k4Sqv2yZNSaCiovEfOD4ZKCPJBEMmFs6ASuYutDSsnJABKJU8W87mM+LtzkU7T0Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnllD9gv2zKwY1bYnP1GhCcDLmaOXwnppyKKbHFFhVR01A8H3N
	55zX1Dwgoq4xPhNutvt1NEzeNy8AsZvBd2lI+AMbrn+mvZHuxcSjjjkDps56Ons=
X-Gm-Gg: ASbGncs2QVQHad14HQheqrGwKQ6KLGPu097Vmap2hL5LsiJ7OysAcaXZbQW6bs7swoO
	w5qImaNzIbv87VphRYjtnzZLmEHROiju1neE3oVTBpal3QxeBiv7YT8l+/sNQ2LSUnXEtn2EGYB
	zLexFXIjJzaekMgdrOtYeF2eJBU2Tsvs+fbK2yqJWmY4HC4WpwRBdVXGU3lrtV4ht1JZIXAIkix
	WyITvin/SPN+ldVHQ9xAy6wK1Se9Sc0mLPUXFlL/ABXQk8zPObecYZYsROLlhySDQ==
X-Google-Smtp-Source: AGHT+IGdGcc0ozdHBR3hwfKEVkKOVYmxhtDyvuHXY8O0HrEo4F7ZttU57Vr+Wky0g7Y/Ju9JUxfsgA==
X-Received: by 2002:a05:600c:1ca8:b0:42c:df54:18f6 with SMTP id 5b1f17b1804b1-433ce426bf4mr12465095e9.3.1732289223104;
        Fri, 22 Nov 2024 07:27:03 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4c68sm93002935e9.22.2024.11.22.07.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:27:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Nov 2024 16:26:50 +0100
Subject: [PATCH 3/4] arm64: dts: qcom: sm8750-mtp: Enable CDSP and mention
 MPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-sm8750-cdsp-v1-3-9a69a889d1b7@linaro.org>
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
In-Reply-To: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WEn2LdCENvI7ZZRxHVDvG5b9idzgAhl/oH1+Mhlk0B0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnQKK/84NMiEC2kHae1rNdwnjlqul7ZcsmQB1N3
 Ef1HI/0NruJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ0CivwAKCRDBN2bmhouD
 1xstEACPa93odV8tfqIs3yAXU0wZFdwt8pn/qke37JGNl651UXjIwP0yEB/Tf4lLXIaRPCXqh8w
 GoxuZ8mcEHAxXDziBBjq22DMJnpkKk3kU79tvuEH7TI+2qgiyHMIJ22aBxp2+cQq4GRTbX+PPZD
 PSPPYaaivihUWoHAlfd6oFPe5Tb0Mz9eLEJCfvFPbIoqh3fvCd7uxYqSA/9HtzcQFOpdxKuRhjQ
 pZABgHBRwquCdozPiQqYzj0DBFm01f/RrjQk8fqe7g7t4q0TbGO2Y0qXEMXi01f8xbiSUIuoAAj
 BC81frUKRywRqtuzOdXuZG1BUo/F4hLUY80Jyt3xVxqWid/+S/RXM00u+kQ3a9eyoZ/qCS8k3G5
 tbPjq/xekhM2riod08TZLX2MwQoyxmAuAi3faIf98MSEvFWBMZWB7CZL5x4RqZvylgOgrQJdJRM
 MMB5ATxgRG5A+EIB82eDrZVLDIEsnp7eLP9X1KioiHk/d4XLL1LgCyIeg1nUCKrowHSGFV7jm1e
 kiWd+XkWKwCfeBRBlMSkABiMVlDvShHBLKqnKDBAeu+2f+7Zqd5Ds+4Tk2hBvYVb6hy6h/NEZgU
 h82YJmEVEicpDJnAg0fA1qU7KgOK7Ux51NHtbH49SAOxxVYMylE7D7kaY4Rkez4GehEI9bRc3wl
 Z1cxCYIwZiZ1z2g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable the CDSP on MPT8750 board and add firmware for the modem, however
keep it as failed because modem crashes after booting for unknown
reasons.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 8eeed7f2f7766326cfc7830002768087e9783b9b..e2562ea5996ddfb1bee03b367082f4e1890131f3 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -791,6 +791,21 @@ &remoteproc_adsp {
 	status = "okay";
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8750/cdsp.mbn",
+			"qcom/sm8750/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8750/modem.mbn",
+			"qcom/sm8750/modem_dtb.mbn";
+
+	/* Modem crashes with "DOG detects stalled initialization" */
+	status = "fail";
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;

-- 
2.43.0


