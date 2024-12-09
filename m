Return-Path: <linux-kernel+bounces-438142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D997A9E9D60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B5F283735
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CEF1F2C47;
	Mon,  9 Dec 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UgW0Al7j"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784F1F0E48
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766341; cv=none; b=KaAnFAvdLH91ZR7HWRjCCfG2GIY297E18g54NFTN3SbLE4W2KND+CTH5EkpkSEyqi9RFcW+dYhPWnKK7b5ejR90k6Pe2mi5h2sBXUSjguIDV9xyo0rI2lJ6fQ0S40Sa17IXox62xiD8jPJbKMrkp4E4ZlmqDk8C3yriJuTT7q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766341; c=relaxed/simple;
	bh=93qaJ3GVaHtB9LawpPgXq1EAwtT4MSNyTdLDOphV9YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1p97SsncB9LfAk2gAjvd/pTpN6vcAmNiBVf/t5T/Jrt4VpZZ+Gz6/ztN5+76iy7F+9se0bo8s7ymLwbHX95KvQpnLioyu7qwjARWSNzubsmVh6+V3Fy2gQm0axqKVLsTQ6xaQQQoy7uE1xyYVWnmOa0K4GWWLYvytWd5iOcag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UgW0Al7j; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so4006755a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733766338; x=1734371138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPxl3QSUuHKTV79x7MMAWoOiUWB66qwESu+TwnhAWUM=;
        b=UgW0Al7jzpJSHMgS4O3g56QcneFqPeLA7SPGCRZ8D0Ik/jAF8qGBQTDRcontVhnrqr
         gSeJPzOwZhhmHRKL71isKrJMYOQqxSGwpZEMAKl7E65J5JSQgm50mAo4gqoVmDYHG8tk
         Xdy1aJxvm21JuBegVfDgHxJjh5dI0KyFu6azE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766338; x=1734371138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPxl3QSUuHKTV79x7MMAWoOiUWB66qwESu+TwnhAWUM=;
        b=T2uXmGoHvb+B0iRr9SFFc+aThtsPdvOsJWYPIy7FRgIWdytoVdXTfh6nERpfoempfW
         5w9HjRrGV4vRAylAveADJuX1WnZ9JVNHPDwx9Uv59d/0oh+b2f1UZ01lDyTGiIHbVrTb
         16SkLZTJOBOrV7HCeh/jY8irQw/bKTKYB4sW+0nW7Y81O5Wma3N2FtE2dw7mVfaLTNdd
         UAoup2stSeGDki5IJADiD29aIw0ZLSTumzxt5qe9EDEibcOg8cLg2oxL88HFpKniz3tD
         28abcysISHMC8jC5guC/AKjz7jVjpwvNYQlTdRPKSSGIo28oIRVk4890Uw4DAU1XKJ14
         OtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZGjqc4C9xpy11nK5+GtudzHfW6xCGT3UJguHAeDbTZ5OqvKWr/rw9y4lvcYpjYeiesPV4ySCEUnHYM5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysimz5wn+t/bWOxQ4DXu0+C8wGx7zHi1nhI/aZa/fVZFaIuh2l
	fmuiJxJSs30pTsHEgxsBCwt+k5+mqsDMHOseE6bI+3f+tfVcZFz4m1kNvfHHcw==
X-Gm-Gg: ASbGnctN8MzMnGCALhId8KdXgHv5rC+M3vw+yrQZzAzNwbM5wlsFkO0D8ov3xygagqy
	cj7Xgh6nYJDHt03z2WlAhD7tKqPenU+gHE07cX8YdEzW5WKdLqeUZO9vRCojWU9i9qSeNBLl6VL
	FZJTzLF9ZtUNl92y3zkmmJ+W//kOwM2mu5REYJXsOp4X/SP9KQ5eRDv7Ne0AksqAFPoq3smSWGy
	BeJTCYqBj5R+SE0aKc6v4yW4Dwk4Ora5Qsgw6iHlIl8QG8Z83KwTz88tlOXyFXmzNiYIQ==
X-Google-Smtp-Source: AGHT+IEQ1TiQkcWM60OYrpKHzb5BVzSSsklo7u5kyWPZtuHxhJvmJhyRRo76EY6ccYMPTPOgDAZo6Q==
X-Received: by 2002:a17:90b:2783:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2efcf137ac6mr2051960a91.6.1733766337960;
        Mon, 09 Dec 2024 09:45:37 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:5dfc:4b08:57c5:2948])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd53ff4900sm1397667a12.50.2024.12.09.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:45:37 -0800 (PST)
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
Subject: [PATCH 6/6] arm64: errata: Add QCOM_KRYO_6XX_GOLD/PRIME to the spectre_bhb_k32_list
Date: Mon,  9 Dec 2024 09:43:16 -0800
Message-ID: <20241209094310.6.I722621804be859e4ae4b7479ce191c5e3367b37c@changeid>
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

Qualcomm Kryo 600-series Gold cores appear to have a derivative of an
ARM Cortex A78 / ARM Cortex X1 in them. Since these need Spectre
mitigation then the Kyro 600-series Gold/Prime cores also should need
Spectre mitigation.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Yes. I know. This patch DOESN'T COMPILE because
MIDR_QCOM_KRYO_6XX_GOLD and MIDR_QCOM_KRYO_6XX_PRIME are not
defined. Those value needs to come from Qualcomm or from testing on
hardware, which I don't have. Qualcomm needs to chime in to confirm
that this Spectre mitigation is correct anyway, though. I'm including
this patch so it's obvious that I think these cores also need the
mitigation.

 arch/arm64/kernel/proton-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 212481726f04..67aa54017dea 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -860,6 +860,8 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_6XX_GOLD),
+			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_6XX_PRIME),
 			{},
 		};
 		static const struct midr_range spectre_bhb_k24_list[] = {
-- 
2.47.0.338.g60cca15819-goog


