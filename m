Return-Path: <linux-kernel+bounces-438134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B29E9D4F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BF9166F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E8B1B4220;
	Mon,  9 Dec 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDMc/zLa"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365414A0AA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766329; cv=none; b=MWZtV3HHjWmuuG2JbChdy/mJKKMxyzIDgbjPAVh/ZzITVCcm1yi4ApUhJELfAT5wwGlGTFFqw8K9rMOoHakFu0HYP7/A8J21Yf1rIS+jZd5NwNA3255C8bzj/bjjV/WIXa7sqRcjR8Tc1jQYKWWRSoJwG/T6vMx8tj6nOClqt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766329; c=relaxed/simple;
	bh=bAYs8FkdlQE5eqssU46SL6Z8HP476md0o5S9+WxIxJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX0575aEK4791T9HMpQK6tS0bgn7RvKv84nbqpKGMtGHbiZ2D/71fmc2eY9CrAZYDQQ8pLhbnZkxUp77hhHrbpDvOjKWg35Xz/gAfX1PkYZQbeycSddbdmRqHBmBBzU+QRfgOpM4ge4pWgRaHoRCbYqptFgrBeifMPZw7mj2Rc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SDMc/zLa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so1128462b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733766327; x=1734371127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEHuQ+kXoeUymHTN8eFGc9cWNeb9aYeLC76//Gda7iY=;
        b=SDMc/zLavq1qQZ8iEHyXR2eWNO9DNVQUoVF8QGsrCdxYS+Ir00ElAQySwQHtfj3DIv
         Grzt9anBLDgEa+C3uf2svO9pl4gHDPK18NDoqljklWvtRovTLr4ACAUkvc+PfwOQUB+A
         dq6H07+vLRsORVLxy+cqDSlAah5c6WyT1T6vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766327; x=1734371127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEHuQ+kXoeUymHTN8eFGc9cWNeb9aYeLC76//Gda7iY=;
        b=V5OIBGPnWKfe1SZX1XnRoEaqtQ0tT8Aj/NlBlYjVhCVceeW5X0YQSp2847eN1NWSzE
         Z7EO4cfESoLn9XrIQ7z0wCMkqOG0tMNP24Ri9EC5e1iy0D/u3RM2rjLb0w54BYQ0tOPL
         kVtCzauJGzpqSwgKtHH/F5YWysnvodxeRCb2SOJLCfdfNffRF7RmhQBLlYXR3jg2RFy+
         Ozt04ew6Gyr3xsyigxItbiu6rLVq0D9/49STc7UDJGXGMhjWeH2DdXrfPZ0bgBgkd+uM
         rgTgNVNWRmYIFy0Zh0Cni2CxiziNBN15nLW2KGUEPoXweSt/cs6oL8QWeouw0yJYOjYN
         qa1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK+4Acx8nT3cJEAzVbV+EKAyAc3zUOv6UTmfyjlNPnRYIBY89Z80Q9m8wKoANoZ7wWhKoafiiT46Sh5TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbtWBcPp82rljfDfjkUtF7oIksDJ9YvhbGRnUjQ90QL1YzgH6
	ro5Rhgm47FdT/X4XrCwAvQxg2IqPSNgxPWfpwnVVDz8BYvxP1vT5H4OL8/9RQQ==
X-Gm-Gg: ASbGncu7JaUGm3BJjmEwtxdEoHY9ppeNC8xQdgziVd5z5bCqDMFD5zGtcs+AuukWA6C
	E6x0nC0LEEFqmuX5cYw4uzy75w0qkUyOIe++BuxWxxm0LV1V0IM9Vdxgja4Tvlv221uTX9GcS0J
	KPMxW6dvqf91gHDQO8oHvWu085UGyaDQCsSOnZ2olQUPiGls0zlptyyL7AQDQEj6J19nqYE4887
	tThsda0BqMB+HmgZWGtpYAar4fmJjCoFzzOPjd79SU38RAhLzVPcaczhGDCTwQXxLpX46ul8w==
X-Google-Smtp-Source: AGHT+IFjr+LTfoeQGGEOWgSsIBHfiAjG9a3g370Vtf8TA8xvJXw9gKEbo9AZcL4ypGc2Hiq/SZ2LKg==
X-Received: by 2002:a05:6a21:9999:b0:1e1:a48f:1215 with SMTP id adf61e73a8af0-1e1b1b519b3mr2234419637.35.1733766327345;
        Mon, 09 Dec 2024 09:45:27 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:5dfc:4b08:57c5:2948])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd53ff4900sm1397667a12.50.2024.12.09.09.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:45:26 -0800 (PST)
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
Subject: [PATCH 1/6] arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
Date: Mon,  9 Dec 2024 09:43:11 -0800
Message-ID: <20241209094310.1.Ie4ef54abe02e7eb0eee50f830575719bf23bda48@changeid>
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

Qualcomm Kryo 400-series Gold cores appear to have a derivative of an
ARM Cortex A76 in them. Since A76 needs Spectre mitigation then the
Kyro 400-series Gold cores also should need Spectre mitigation.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
The "k" value here really should come from analysis by Qualcomm, but
until we can get that analysis let's choose the same value as A76: 24.

Ideally someone from Qualcomm can confirm that this mitigation is
needed and confirm / provide the proper "k" value.

 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index da53722f95d4..e149efadff20 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -866,6 +866,7 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
 			{},
 		};
 		static const struct midr_range spectre_bhb_k11_list[] = {
-- 
2.47.0.338.g60cca15819-goog


