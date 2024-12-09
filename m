Return-Path: <linux-kernel+bounces-438137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD39E9D57
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F84E1671FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF3B1581F2;
	Mon,  9 Dec 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCvoPW1b"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBD1534EC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766333; cv=none; b=FES2msWr9swMaJrcIsfC2rQTeDD8KYYOyY0WdU4Omi9rZToGoL8/Usd2VuzlbzLulpaOGPQ+nKx595EDu4Ca2k5LwtzLwITTE/hyW7TKdzPXpr0KABTQXZ9qVLOimIcgKbEyJyqeX+p+nybio/wxJifoPXqZetpZw7UsW7SZN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766333; c=relaxed/simple;
	bh=/DhZ74IafBvOEaRNTiwePNlJ2TNuZ4F4qMfGRFUHrhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1dF/qsSTS2BCtLJdAGtxfWNDVjeYhD7TDCcsEqx+qCfvBqdBXXM2C8U9QQcRbXB8YrbMLXvHHazA07j6O4EckoylyCyp7+beHtCbFSQi7GB5HlgHqUP/e8xR3mApU+Yudo/g2E7r4sqGm8L8xmN3KhY+3a1jaHPUPYh1ml9ZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCvoPW1b; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7258cf2975fso4016206b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733766331; x=1734371131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGAjyEPuT0Sy+GKYtRpRtSgrFjpUx/s3n7hQod37S3k=;
        b=FCvoPW1bomEFPshuNDc2Aq2j/HMteADvyVAlpRa22ikY7+ReHAKY+AV+1tq/fynNgj
         57UswU99sOrYbcpKQyyybCjcUalIR4ni32WwDbDQfPkypD4O2bM9yZ4ch/ytx/0oLtMP
         Bwm+FL+7bC8vBJVwbrLQb2Wt8+yfE44Obzryg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766331; x=1734371131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGAjyEPuT0Sy+GKYtRpRtSgrFjpUx/s3n7hQod37S3k=;
        b=iTPbAQ4JLbebxc8Vt/ogKWOMSUM6Ukw9ztVISpABtDlyAjC5jP0R7mk7QfECXYGIrl
         ccGvuy9zbAUqhWObq8U2weD3hcwBsUifUhktAIEHdBwQZTBZpw+1hvhlc+exR2sViK2J
         1YST8lW1NfZ9E9K8d/OxXyzWRkPHfDRkHjw60bnHWEWtUJoRwuaoDnq7xsPaPMwpsh+M
         GAWE1diqBqiJoEBVuZildegPb4p7wYBNDA4H/MusQKogxobKwIVVdcSKijOYshPUdoY2
         7CkFHtgbGePQ8BOh7ELEbLoyd2QsDPKwawQU1J3ixRERqhAyprswLYixKU8yc3yzlTd7
         TM4g==
X-Forwarded-Encrypted: i=1; AJvYcCVaz2yXcfV9Hq4C5cK2zdNpDtkt2YqglqSxmEXzTLjg+pNdDVIH4KaHGmJQN6E5rxit2cseAwNszTiVok4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQHx7KqJf10GtTLcpyBFPGrf47ND93W8CGHFCsjDsYvROpaeQ
	VTZzJMC74zOwUTSa2hPrtO6kzUV1cx+q8RFJ2MaAwZW1dVeoFBrtx/+EG/iStg==
X-Gm-Gg: ASbGncuiwKxWG8iKvPaE0YWo0aSELWFjp4O7+BD6wSy1gRqBxExbD4bdP/wQlacF8ez
	/SEFnSpwnYMlPK7R70Zesioo5mLma4PUivgxXSmx8JNj6cBN9OMOk6rsdg1Iqo8W1SSJgmQH/9r
	rWXwLmxbAeMUYHoH3NSnszp89/TR4TjCGkJbZFzY6fvBaONCDRZEoHky6ZjR0q2F/cD4ogN3MGx
	LiiCXfvt5LDQ4dXTceED8Iz2/EJlgOuoWDr4fTlvaE/16z0iolUq9LeGS5fSajCdj9LnnKgAw==
X-Google-Smtp-Source: AGHT+IGIm2OSph5NAKJa8gdDHdlDAkZKg2Ze25JJ3panR0ayICXZnis7gphzZlRUR4Rf5fjAX/kMgw==
X-Received: by 2002:a05:6a20:3942:b0:1e1:aa24:2e58 with SMTP id adf61e73a8af0-1e1b1a79c30mr2366050637.7.1733766331535;
        Mon, 09 Dec 2024 09:45:31 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:5dfc:4b08:57c5:2948])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd53ff4900sm1397667a12.50.2024.12.09.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:45:31 -0800 (PST)
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
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
Date: Mon,  9 Dec 2024 09:43:13 -0800
Message-ID: <20241209094310.3.I18e0288742871393228249a768e5d56ea65d93dc@changeid>
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

Add a definition for the Qualcomm Kryo 300-series Gold cores.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I have no idea if this is actually right and no way to test it, but it
fits the pattern of the other definitions. Someone from Qualcomm ought
to confirm this.

 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 488f8e751349..c8058f91a5bd 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -119,6 +119,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -195,6 +196,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
-- 
2.47.0.338.g60cca15819-goog


