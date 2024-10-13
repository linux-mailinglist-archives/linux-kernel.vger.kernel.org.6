Return-Path: <linux-kernel+bounces-362712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55B99B85F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 07:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853081F21F23
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F413DDD3;
	Sun, 13 Oct 2024 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="Sa4cB3ZB"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0813B2B6
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728796966; cv=none; b=ifgBC5JaX68aMKBcz/t891NrT2A1rSaLO3TMAvVrnIBFd0J7m9ocsiCstaQylC6a7tBmZGSEDCYzO+MdCjmSEov83yzjsUlr1z2UM8N5QuvylU/vPR7J34Zn7mrQAJlHSAExkM1lc2w+dpiPQlr36UrNRFC7qkjCCynwopYUD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728796966; c=relaxed/simple;
	bh=yOQYLbpufnAQd61mNPx8dF0RUdCNPiazkZMeVKYLML0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iT9xe4Crw0UhEc+yvwrFgwrbDBEQjeWBcuOW+mNi+tw++JZW/A4z0bwdJPXq4ZkrSBfTkF5y6ftGywMWoZkDOfrdrpAXyUCyFEVPVtlTSZx86QSF01h8n2Ba3c0DHND7RxJ/ZAOujPhOynlX4mAILIgLgyUzTqYfO4FIO38FzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=Sa4cB3ZB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so30118996d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728796963; x=1729401763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shwb9N4WF4JyvqNRDgkrcwpOBqNWS70KY1SExpzylBM=;
        b=Sa4cB3ZB8zCVV+gf2TrAgtRwPunQ4Hndjj1z0J5+v6RLuBqBW5iRFzsvSDhelZjKuI
         EuLl1lJnWGqTdwiN988ribTa8r7kZtC5jE/lLbH/Fcc/vfnIc0AID1ldNcIc8mJJCFXQ
         lhO0NU8P6rMvQgT79AvnNMHo+hj515OEZGzl4sRSNFJ6ssxeHaZgsq1mQZSRF3NAAtAS
         BPSYbi0a466R/Ef2XRfztWlsnBwrmC9KXxUTpj4PVW/HlEw4TJy41tLxdrrVvzycVZNp
         Em3PwnQJ9FtSH0fImqYNv0/6P1uwrOJ+IpP1Co33y7zLiPexvZeYQaWeezPebIvC2AZm
         OHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728796963; x=1729401763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shwb9N4WF4JyvqNRDgkrcwpOBqNWS70KY1SExpzylBM=;
        b=uRsoKaO49y3DvSyjqRciI6o0cg7FoNp71SzcPQFkzPvbZpq/UnrsS64Rtr/4XSsyrm
         MwXsY+bXiJ4gjcdYnTPYi9ud2FmAL/hKLdagM02BMStXU0jp5OtK86p1L7WhlHf9YQ7e
         1AJBZgU8EVN3Jh2FkUvNBwlLYn6MCaDwygIhPHMDsSfKgO5Y6yAoeCNGUkmaw+Aczi9P
         BGfm8YT0fSgqTuB2OSSvKFlHwtH6aJncZFzbX5e0KYlDx8oUoBRbFv8axPELatmgtejg
         sXdRK12VpQwCtgahwl7tybsBOAaQ9E12tZNW9nX1oEvG0aOEsbUB/I7F6NvfuYveXSXS
         cg0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHvMWJzdqTaWatSxxS+bWqFAprkLwQukVD2OLhyMfqxZzaLsSRr7ud6kojZ/NLv5TV+oYKWg3OZa+uKIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERdHbfQ8fXxBXqpyENdfPFkLu/q0hWTviibVIT5sKQIW4KLZr
	xaigrkTUkSrTIk/txi1YxPbQdW2BGaNkYnxRdCy7Pk7sCGc5cOnG0v602X/VaXqhMTe47cwhI1p
	JzJQ=
X-Google-Smtp-Source: AGHT+IEy3DhBkV/4tsh5OQ4TqIaCRLYxUH/ViKmGl48XQk3QJ76bWUv6FLpogI15DSs5xRjZR3nj0Q==
X-Received: by 2002:a05:6214:5b0d:b0:6cb:e52c:c8dd with SMTP id 6a1803df08f44-6cbf9e9f4ecmr71827136d6.53.1728796962626;
        Sat, 12 Oct 2024 22:22:42 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608e2csm31821496d6.102.2024.10.12.22.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 22:22:42 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/5] arm64: dts: qcom: x1e80100-crd: add rtc offset to set rtc time
Date: Sun, 13 Oct 2024 01:15:29 -0400
Message-ID: <20241013051859.22800-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241013051859.22800-1-jonathan@marek.ca>
References: <20241013051859.22800-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See commit e67b45582c5e for explanation.

Note: the 0xbc offset is arbitrary, it just needs to not be already in use.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 6dfc85eda3540..eb6b735c41453 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -1224,6 +1224,17 @@ edp_bl_en: edp-bl-en-state {
 	};
 };
 
+&pmk8550_rtc {
+	nvmem-cells = <&rtc_offset>;
+	nvmem-cell-names = "offset";
+};
+
+&pmk8550_sdam_2 {
+	rtc_offset: rtc-offset@bc {
+		reg = <0xbc 0x4>;
+	};
+};
+
 &qupv3_0 {
 	status = "okay";
 };
-- 
2.45.1


