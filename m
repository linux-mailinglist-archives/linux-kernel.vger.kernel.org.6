Return-Path: <linux-kernel+bounces-364909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B5799DAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3681928161F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC314D428;
	Tue, 15 Oct 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="gorHUc3z"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47112F5B1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953608; cv=none; b=a0MhlGvX7cGiS/105ETudPMC2L3Q34jYrTBhifomLCs4Y7ZAbO3MxnXpODjwgmOm6SfBATuWtY21W9M2RkogKbtVFyclaPy31U5Vp4rZaDQkH4vLHqiTpAKHGTzXjxsaVtB8k6/cViCTYjo+6OzFUDM/4pn2V25wQ9ofOSH++aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953608; c=relaxed/simple;
	bh=D/197BE/sOYqXX2tpg+U+8HUYL3PdYWLDigStzikrII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2jCzgiFAXoabLSFCwaP0cDoh/b8S/ZYQbI29XH7ml3psQtn7Frs/I4EgMY0bp5QI09Nr7bO6tUt8PjV2bdMKyeWNs3A+GEAsNuAmQmE0/n3nrSJyDsflm2zYAGr+6IXMJrvBdmpsXoWWkpddLJN6g6PMmGCsu+dirv/sk/RLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=gorHUc3z; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe3e99680so23799096d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728953606; x=1729558406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5sMuvbvS93s8VBrWna8b+u0k8/Hrp83bAMUi4V/Ays=;
        b=gorHUc3zWdnogJpmKPsaTFysElvz4KTihj2uvNlOLTgFiYTpMyLVyYI7i7AoVl1FmE
         gMFYJZZAxBLFKIqq6XP8jubxYveXYJk+zdNQw96jey9Mu8X3tKkhRa/aR/xkgGtAJJ8g
         6LmPnHiNw5lIwhDAUnWbGlAgonmNHlu69q5oDHVeCC5JAjW1k9oCsQL9IXEiaok5d82U
         UPq18iCtoGbvsA84rT4hZBpFFEfL6JcYifuAlIcUxJjetGCjzBnQBDHTmSdcoi8z7s0F
         oyycz4IcrsK3X5PkK07RMCIcfeTS5b2uSpoU+G74lMXIGp2HPQJcr0uup7hwK3mKWawD
         3WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953606; x=1729558406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5sMuvbvS93s8VBrWna8b+u0k8/Hrp83bAMUi4V/Ays=;
        b=h6FfTSGyZgCVwADDQpF9VzsQWz8OLbGxqHXf8m+gp95yZa16LA1UbJhJPj5PTqFx/I
         4zDgSgUDBTh+sXQx8xP/F4NtR8DB6+qn1BfpuvcBG/hMQefmrIGqcH+fW598CjfRRJex
         i6UZXkf56o9r6hPyKPAth06v73bPBtx6SV8lDqv95GN62ZHeDLxPRACcXVjU+2KjY29+
         RfkaO3rO1NYWraaLSAOegk5iv6OxZipKo7QJHWP1OPd5vN5ITbuTrPiiCLuAPqmx6fJK
         /DmNGN7e2bi3z9Spag9unwxSor/ca/SbZsPUAA9yc8NtqL2aUimSINO8UU/EkghG4S+3
         ravg==
X-Forwarded-Encrypted: i=1; AJvYcCXnHpYxCMK3QnA5Gk2pgVwSqjQcrqLHPl1LjyAYvm5brDdCmqoJ6j2u40nsnu0SF8zZJWqh78Btdm0b400=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+A+K+FuxpzT1d1eIiGbCJkbjbpXbNMW7XfXAI6aliUzKgVHZ
	dys6lZzVDZBcwmpaq2UXLLzWTY3bzIZ3M49TNrq7HFUbbwMvmb2kk0N+z+gBdSc=
X-Google-Smtp-Source: AGHT+IGXvonG83/eQIbYXj3ksxCLZFkMceOKEHMdRUwHpyHjjqjMQeiXX3BEFIWdL8gQbPL+A0apfw==
X-Received: by 2002:a05:6214:3387:b0:6cb:ecb3:4d3b with SMTP id 6a1803df08f44-6cbf00ab35amr199972566d6.42.1728953605683;
        Mon, 14 Oct 2024 17:53:25 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910f0bsm1213956d6.16.2024.10.14.17.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:53:25 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/5] arm64: dts: qcom: x1e80100-pmics: enable RTC
Date: Mon, 14 Oct 2024 20:47:28 -0400
Message-ID: <20241015004945.3676-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241015004945.3676-1-jonathan@marek.ca>
References: <20241015004945.3676-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only access to RTC alarm is blocked.

Enable RTC access by setting the qcom,no-alarm flag.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
index 5b54ee79f048e..b665cb75c2b75 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
@@ -223,8 +223,7 @@ pmk8550_rtc: rtc@6100 {
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
-			/* Not yet sure what blocks access */
-			status = "reserved";
+			qcom,no-alarm; /* alarm owned by ADSP */
 		};
 
 		pmk8550_sdam_2: nvram@7100 {
-- 
2.45.1


