Return-Path: <linux-kernel+bounces-438136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7089E9D54
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B5A2834DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DBE13F43B;
	Mon,  9 Dec 2024 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WKeOy/6q"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B61B4222
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766333; cv=none; b=OsEUM5fzLc1+i2O+4gagBCSy14vK8Z4+fgF5OmOcIlO+E/CVFP9RNAuZkNDN1GCK5ZeAzkloDr3JPVMHuxGHYnQPEIw4hjknGenJXoQH/UDrO1O60bBiyGOgdxbQcGdW+eALO0Qh5nvTLghfNEnf0M1+6+ojPLOEkS3SWuI5PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766333; c=relaxed/simple;
	bh=GmNqesxkgBcJIscVO6PMD2XTQoHeWt84/rl2brvJAtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+bNpRYqcXL81D9v3YQblX0bfgdcuwtR+6RoPTEYu4GmmVcUW4YsbfWyzjhsTJe3nPSz38QQiHj+kKnLSGQQbkcnCjDPFb/pI3hM6n9hLTvYh6Lca/t16Xz7VAq7wGA470xz3OK3OjKJRAdG1kN2RqMgvtReVapPopUL9EAcwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WKeOy/6q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725db141410so1499108b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733766329; x=1734371129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qETIrWIvBOaJo01797E2hvCoFBrPeIJqundEykxnLWc=;
        b=WKeOy/6q2armRGhaVvnP6PmnrZBWCqITFsA2UWUDL/uvb2iZF+DGIofk6y/UYN2s4v
         +wc410KNOqdcohqVYkF9zUHrkkE5KGTY1oWRTs3VAdQho5dqhRvsmtZBxwklYCxrcrFU
         gW6GwXzZTuOlNEWUP4k40ydF2d+MOS1pWk/0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766329; x=1734371129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qETIrWIvBOaJo01797E2hvCoFBrPeIJqundEykxnLWc=;
        b=QcUvpgfnMeo0L7xnJhFX5Sr+JWAaWRyc1NLDS+BHiLw/JCR8vajOm2rKfDhd8Ac6SU
         ce1MYzfpJe37vi50vPIf+xlhLE0IJNSlVIbYFSg20wMcJcSxdoVyVEpEB9LoTgf+7jS8
         SlhjDuli+klFgofsguh0248q2YE5FVS98VGeBW8kc01q9lXu/yeT0m1HYuMwIc9MeV17
         oUeq+Pc7pgeuZ9zWjyA34vq5bENcS+YBTlRBkmZhg8q66vlxN5tPok/vnQDxpjbdc7XO
         mTPN6+ndYUbpMBUMLd6hloIxW67iWxNt/ZqlSFn+ftBt3KKWj1EhCygqHPg/mcTG/X3R
         qsmA==
X-Forwarded-Encrypted: i=1; AJvYcCVeFRYsin9KGnekScRnNQ4Sn7Pu24eJLcJBQ2lE8kRcB+CFUdLI+1VWs7j+UXRwGlTjM6HcqTh+vHcUYkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6Q9kz2KbgtRGl/xPbU2LUnbD47zu/JhFqfzndUm5L8YVuwK3
	YXcItKPqoPsv+izG2mk+OhjQRJPIWCaS9NaSFiNgaGIS90dUTMVThSfyOUlCYQ==
X-Gm-Gg: ASbGncts8gpxkatEGCMOyhKWNnqw8N3kUJILSk3A060E9mLQoS/n2Spm+xMkltTtovH
	ksqt5efpx86xPfACrWKdjN9wQLKRquLV6NRSOVSNusgB+BJ7bgb9dlXautBT4FNJudIP2G3lMgr
	/2v8ED9/ozGGICL7SDav5MO/nyVZmIfUvXNtrC+53F5MtfHFf1aZHW2Kr+Pb9nJb4VkdRLgQ7jK
	WhgjxiF4hdYZUZ/WLJwTt3cUxwsTGSLzOMhczmvo/9I55aUnGNkvIOZ4A7fobbF6wr9gWmWOA==
X-Google-Smtp-Source: AGHT+IEXGhJtpWKLCDTsUasg4AZJ83eo6fiziwMvcakNMUhC1SAx4Xv/ur4wHscvWzwdgagPxhNRYw==
X-Received: by 2002:a05:6a20:3d89:b0:1e1:a3cf:c199 with SMTP id adf61e73a8af0-1e1b1b8a4fbmr2336458637.28.1733766329338;
        Mon, 09 Dec 2024 09:45:29 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:5dfc:4b08:57c5:2948])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd53ff4900sm1397667a12.50.2024.12.09.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:45:28 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Julius Werner <jwerner@chromium.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Roxana Bradescu <roxabee@google.com>,
	bjorn.andersson@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	Trilok Soni <quic_tsoni@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: errata: Add QCOM_KRYO_2XX_GOLD to the spectre_bhb_firmware_mitigated_list
Date: Mon,  9 Dec 2024 09:43:12 -0800
Message-ID: <20241209094310.2.Ia3dfc0afadbfbee81bb2efb0672262470973dd08@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241209174430.2904353-1-dianders@chromium.org>
References: <20241209174430.2904353-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Kryo 200-series Gold cores appear to have a derivative of an
ARM Cortex A73 in them. Since A73 needs Spectre mitigation then the
Kyro 200-series Gold cores also should need Spectre mitigation.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't really have any good way to test this patch but it seems
likely it's needed. If nothing else the claim is that that Qualcomm
Kyro 280 CPU is vulnerable [1] but I don't see any mitigations in the
kernel for it.

NOTE: presumably this patch won't actually do much on its own because
(I believe) it requires a firmware update to go with it.

[1] https://spectreattack.com/spectre.pdf

 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index e149efadff20..0437be7c83bc 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -925,6 +925,7 @@ static bool is_spectre_bhb_fw_affected(int scope)
 	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_GOLD),
 		{},
 	};
 	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
-- 
2.47.0.338.g60cca15819-goog


