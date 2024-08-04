Return-Path: <linux-kernel+bounces-273689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D2946C7E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 07:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BC9282114
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189243AA8;
	Sun,  4 Aug 2024 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIjCvwAU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A839FC6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750036; cv=none; b=Vy0SSm+l3SkFDnP7miO8Umoiu3aI2HEJJzQu/kR74qV2to5VMJb3GWSu9akm3DVnAo496HPtXxagjhoC23YypHpnijt1x/au9H24N4lvk8AVnsTCCXTW1AZFgR51rtdJ9yAx/Cwe/GNtbNpJBFyd0B2IjCe8v5vdEP7SbLJL88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750036; c=relaxed/simple;
	bh=+6qOXA/nRYvF+LJ3fyjiDmQq3/m44DEzHQz0B5kY010=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQpYcb+8qzqH+mJvN9vKvAHWjye6HmucDpAvNuf38+SZGX+bGKRGgSN7Q842pOh8FkN71SmM6Fg4Hh52o6FNMcCNrzd2B+ikrBL3+QcwfGM0b343CoBNFgWOB0/R+iHqKM8FUNwEziHQltNSid32kBA7PNa4QPtXCsAjY5R51QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIjCvwAU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso321283166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722750033; x=1723354833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZj9/52rwWNE6aCx1N5+a52yjuW6g5rJuFXIxcVgEH4=;
        b=WIjCvwAUXg4T8sEHbmYQJY3U0g+td/WfLbRVrkllLQfgHB9/UpA8fZp+lbJoyZDQEA
         350lK2myd+trsWAK0DXrtRVuwpwSdiFdgY4HDFnxIChW/hwx3BXKjo1bziAztgM8wabL
         EAZpJgpUgZ+S5Y/99v69jxAK/J/Q6ltQ/cw/Nfq1S9b9EJ1qf7Wl6rGEj1mwikAYRM16
         1UVwf0iw0JdAMn1dXzQwpjNPIAE23PrdYkzLtjqdCDnOij/W8ntTaiLz3+FksIx64vsG
         1LRcq5b3RKz1CmPc4d5J925r7ozbVpMsWP9TXYq6Z57g9eKqveke0/kipbJw5mCijF1V
         /oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722750033; x=1723354833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZj9/52rwWNE6aCx1N5+a52yjuW6g5rJuFXIxcVgEH4=;
        b=DbcJ0So2CyHSbNw2rHFTjbGQJnDS/NwzoKMlyYlCMiD57HcY3B0IGqgx+4D01DnFxf
         DzSYhzej6oe1DnxDG+RMCLbIr27F8iyQypQVIF02xBtBIrn03GBWD7Px8ZJo16Q6EneE
         4VrB5bQRPJ/Aa+1Y+odXEaPsFW0GMMSFjMfgTbO11hzYy/wZYkECPDcszjpKjOOyHIWm
         B+T46EJ/tSbjGThRWcrfeFMb/ak0PRQmlyZWjqey8y4t2QOlViqJipQ4fWMoKrpnmeUm
         he+B22XbikW1hlbMfcwO/o8xAmJkKtKzo18WxUtr+Q9c8rSSbKL+IUlNMpC8r7J69uFC
         JmJA==
X-Forwarded-Encrypted: i=1; AJvYcCU4TXDwM850lIFLqTa7Nblxo60aIC2GiZlDSXFpKSqsS5NRGBMcJGBtU/rBtu6DCWBHk6hXDv8Xyi87uPrsmySoT4qlEGW648y2oTNj
X-Gm-Message-State: AOJu0Yz2JizS/es1DHr0D8M4KOd1Rh344VTGuK0Jq2zi/GtTRHytRXuA
	9tNqp3HmwiIUUTlRspOn3euRgmCG4qmN47QzAhJ2bJdjHuKj6Ex8NOYRIlhfncI=
X-Google-Smtp-Source: AGHT+IHbci0hVaQgSOMpebGYXLXoRbSJAPdeMpWLhfgxvxEZR+HSx4w/E5jZTEcJ0B5zpBDG5TQSnw==
X-Received: by 2002:a17:907:968b:b0:a7d:c9c6:a692 with SMTP id a640c23a62f3a-a7dc9c6a8a1mr583045066b.51.1722750033049;
        Sat, 03 Aug 2024 22:40:33 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bd7sm292248466b.34.2024.08.03.22.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 22:40:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 04 Aug 2024 08:40:13 +0300
Subject: [PATCH 09/11] arm64: dts: qcom: sm8350: add MDSS registers
 interconnect
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-sm8350-fixes-v1-9-1149dd8399fe@linaro.org>
References: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
In-Reply-To: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+6qOXA/nRYvF+LJ3fyjiDmQq3/m44DEzHQz0B5kY010=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrxQ/EZqpfORfNpqmB+gfbID37iTSi1xyvFhc8
 yGcwAyMPX6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq8UPwAKCRCLPIo+Aiko
 1fEVB/4poQ3kFh5IcUQVcpD9WN/E8hoOPvW5xikRPjmU3YFD3FWnNBXl0NKC2mQ7WS3PnupHux4
 FvdTXUXKBbSus3+FQxXGfy1KvXfiw8Rfq+bBZ1fSt//qdVQNygZHM/LAU4xRdOcd0+0YshgpLif
 r0DdSq9HK0mJds3+Utjv76o8LBIV0Vzu5vPJe/TAp8BdLUk/GneFDKIGgPfPx4Lvj2JAd/N/Jfm
 uj2wWVPXuNxiDTBUBJGcAVBivZkGTIFe0kMQBzzL3kS0L6oPgcGjU2goCBY29+xl6qt+IoIIgnv
 qFb7CLYVIuCQMxxpLvagpIAeRD5Gpp/pQ9wrZrumALkiMHSh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Aside from the MDSS<->MEM interconnect, display devices have separate
interconnect for register access. Add this interconnect to the display
node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 38ee0850c335..27f36e6366df 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2490,8 +2490,12 @@ mdss: display-subsystem@ae00000 {
 			reg-names = "mdss";
 
 			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
-					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "mdp0-mem", "mdp1-mem";
+					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem",
+					     "mdp1-mem",
+					     "cpu-cfg";
 
 			power-domains = <&dispcc MDSS_GDSC>;
 			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;

-- 
2.39.2


