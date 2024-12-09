Return-Path: <linux-kernel+bounces-438139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474739E9D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D82166D1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07FD1F0E3B;
	Mon,  9 Dec 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FAR6xBXo"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E711E9B07
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766337; cv=none; b=mmFmUckHE814x830cnd3iLuXU0AmfUR+BgKgPnXO0WdpkvhFqQwmMWwrEkzWCIiJknHyCgMrs1szai+0ai0mHUoNTxr6DXPxcLE8KCKQMRGv4YWdVN33asDHBhedzJnMwDgKIe4oFVOpwPT1KeHxBIDNysjs29bMdp88i8IM+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766337; c=relaxed/simple;
	bh=51iLuxBMckF9PLpCnsh9tOBy/nP2wx6MKEOSwidGqOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzgm39JDF+DItdfTAcV4/PUEY81JXP0U0XcqB5yafPQXjUthLPScYW8REung2PZ2xBTPh9LGLwtXbOOT2S2XU1yRkCMp9la6F8spzXTxwePnr3aggp5d1SOgWUPyJGOuCe2nn0AoivWTGdkUwZSsYJCuK1t4yMWgoHg9cLX9bxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FAR6xBXo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4719653b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733766334; x=1734371134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev4g8LO+jsu6za6TCZISAQbXcC0h2bQ18wxFdEcBjYE=;
        b=FAR6xBXoB6/XlSar1MvySlrHlPW804/ESPl3DavhHzHIgl36qzcm8AZ7nGb3lDa04i
         ARac94sdRSQp/HtHSlKMJfl+Zu7xvWyQ3/8BbJn2apfMZqKJUU7/eMGqdW2vNPzGcZT1
         xFDOzhy0ufJzLT4YhpXaCz0pB9WzfEyDc9gD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766334; x=1734371134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev4g8LO+jsu6za6TCZISAQbXcC0h2bQ18wxFdEcBjYE=;
        b=GBI0G49uh1ksKJrtO1E/X/j7nzWZpXeDpcXFeIGj1y+i74wHfnFV6n9rkv9cMgkRoU
         XdMZU8wDMiRGGr3mckBN+84sUju5hMgK/VSZzSMVnn7CAPUHvX9I6HHpkoHtF0xqoO8I
         yzAF2JV5GlKTTxRzo1NeUdVTRjm6Jy2tUsb87fYTX0+1ZUO5acIRIQwVyigIjBiaepu5
         fMaPA7Hq8c/APGsg/YRUIvkocF1VmJAgk47buY2WX1pH0CT3tgdQI8mH9Qylh8NARCnw
         HSpzXBi2vFGBfy8rPwyJHIbQz9Vj/veKjQWoGY21CM4o/Kvc3N7Uv7uUAHr/OqNzjbv+
         VjIA==
X-Forwarded-Encrypted: i=1; AJvYcCVqZ2rBgA92rEvx07z1+dTr7k9hfH/CCwwEye44mPEtSKXjWBrYe6+qsUlNjeSh0xChFJyHXTiHCHu5DX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8VVxPpAzE5LdgCoPqNhjU6OfuXJelvmar9NFrCUWUP4PIJj1
	IA+A9bNxTZn7V30ujzbaw2x2RmTffsvuVIDqYAW/w79ifurOwMRyx/zfp2CpJw==
X-Gm-Gg: ASbGncsnvmYCzsNRXSJYqrRT5TR11HyvHmGtpGuDeyo+eepfkptLaidMJyaYwBTrEM3
	no2r31qI/qCGQ/rZEVPBUdfymToUj2W6e7P+W4b4AFohYokt4YW57zQdJtbPLiPniNJCBHD4vZH
	Dxh3z2ThYPv1h0C8OWT0z8gYjJdZzzGidj6dIB8TggeX429kPmSm+YyjqMFhsJPz2VBC85lij6J
	ylGXZOQAj+bCMaM0qrTO27DWbFI5hLgJvgKZYzf6oVVVGksmCXjAvzCeQDaEEsIlUzuXw==
X-Google-Smtp-Source: AGHT+IEnZSRvcamRsFqfzU4vT8XoxmVAFMYsZp4K0Vnxwtmo9CBfsTPWh3l3tzKCmptOqc3Lav+yqg==
X-Received: by 2002:a05:6a21:3290:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1e1a8853f19mr7243347637.7.1733766333900;
        Mon, 09 Dec 2024 09:45:33 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:5dfc:4b08:57c5:2948])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd53ff4900sm1397667a12.50.2024.12.09.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:45:33 -0800 (PST)
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
Subject: [PATCH 4/6] arm64: errata: Add QCOM_KRYO_3XX_GOLD to the spectre_bhb_firmware_mitigated_list
Date: Mon,  9 Dec 2024 09:43:14 -0800
Message-ID: <20241209094310.4.Ic6fdf0e43851269d10596da7e6ceae959431f9fa@changeid>
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

Qualcomm Kryo 300-series Gold cores appear to have a derivative of an
ARM Cortex A75 in them. Since A75 needs Spectre mitigation then the
Kyro 300-series Gold cores also should need Spectre mitigation.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I have no idea if this is actually needed and this patch is purely
speculative. Given that A75 needs some sort of Spectre mitigation it
seem hard to believe that the Qualcomm Kryo 300-series Gold cores
wouldn't need it.

NOTE: presumably this patch won't actually do much on its own because
(I believe) it requires a firmware update to go with it.

 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 0437be7c83bc..b1881964e304 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -926,6 +926,7 @@ static bool is_spectre_bhb_fw_affected(int scope)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_GOLD),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_GOLD),
 		{},
 	};
 	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
-- 
2.47.0.338.g60cca15819-goog


