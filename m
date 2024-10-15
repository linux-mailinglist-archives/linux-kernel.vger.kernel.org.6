Return-Path: <linux-kernel+bounces-364910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B999DAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9738C280CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601C15884A;
	Tue, 15 Oct 2024 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="MiF2VvUd"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248E1514F8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953610; cv=none; b=KZikWanmysPHUX2HBpOE2nR3ygEQV53+CxOMxuKLW+g0E0DFvJ+fUfEfzqdi5/VMY8daavQgRKizmmlFmVOqNgFYRjUqlkvNPO88zNVgLJLJDZtnLLCrD5LvlKzB30/dTyv/kKyHyZ/2VNSmAbSd6NQMfSQA0gF1OI0YxDNS/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953610; c=relaxed/simple;
	bh=yOQYLbpufnAQd61mNPx8dF0RUdCNPiazkZMeVKYLML0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkPf/hB/511ki527FEaSjt0KxsnegrgClraa+xw27TK89Vy7G5vWUM2TXFt2hVDcwJT1/SPt4MTdmMLVBMqwkaf1jxZi7e788zDGYh7utwGuO1ArmdSYykJINRw7aOsRSHP5EWq/RFH5vMgwKYD/Dphncuw04qKt/3r3uY5n2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=MiF2VvUd; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf693d794so25587096d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728953607; x=1729558407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shwb9N4WF4JyvqNRDgkrcwpOBqNWS70KY1SExpzylBM=;
        b=MiF2VvUdYdYBK9wE5b5WEfODl9qHuV4n6lmqoZLM1awZZs2JTtpb/69EoS35UcUuP2
         x3nY7h9T722Gpn/HkHF01khkVckDzODWFWbKFhDxI779CFOVDWKlnEqLftdS0YBATK8y
         L/mlTdT7lzEGpqPsEAzrZ4xw9zIdBvDTL4oErltuGI77Nzcw1epFUYfcGVRzHVjRSSKr
         p/uMODHjD4Yz4+mGmYqfgSSD4GVjNDLAHGFMsZpamuSjbtkkaV9ZEY5pPMDgB0wiF/E1
         RqyZ6Z8UCr/dSg4u/yLH9AybiaG8GJxTHjvruaBopgJENCl+HP3w60G3K+I7JQiZuvYT
         q4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953607; x=1729558407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shwb9N4WF4JyvqNRDgkrcwpOBqNWS70KY1SExpzylBM=;
        b=fQbtyzlbKvtqiWGQ65n8NRvP01cHFFogXP+wAax8TgZf6GH01uxq2OsGIkbtIAym+r
         FION15NbJ6hty9fxw2H6lBRYudoADcCzaoowwKH0+jO+k/LsiWIHY7h0SLxuYKB91m5v
         pln1Pf4aqZIcNfLX3odXxytpYqpKI5kT8EkXCnhc5ucYw2iMXFSp/lS+hpJjwYocIbuX
         x6hvr094/wWyLpUAC+RkAzwM20uFAFQvKm3/JSOmDGJWU3mR260BG58d81VCEGLdwg87
         Cyd/S+M4e/pb/05D7auMjDfdNpUAeLfkzakGrxkmdBVcl69amLVBSxCI/awTRRx4Y+FO
         Z2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIDFFAfR7Am2cWsDEUhIbvfhwXlb4NXilrAtFAAQoyBPST3qeoxZr+LTB2LmW19X9m4zC+x56hiOBfLj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVFNdKbRt6hJ6AF9wyKdopp1oV9Mw9/9JFod33NqpKidjEeMM
	+481B5IiZouULz7sDipWB+unLNZLEfLoz1NtxyfVXSi8xw6swPo8jenfHv+fg5I=
X-Google-Smtp-Source: AGHT+IH7AVHW9VFOzpeP6x4ojtz/8ibyMXkPEVnAGtTyL6fVgscFm6vGD8uJ5o1+Hzti6qm2yTnlMw==
X-Received: by 2002:a05:6214:5f08:b0:6cb:d0a3:35ac with SMTP id 6a1803df08f44-6cbefa894a4mr225021416d6.8.1728953607014;
        Mon, 14 Oct 2024 17:53:27 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910f0bsm1213956d6.16.2024.10.14.17.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:53:26 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/5] arm64: dts: qcom: x1e80100-crd: add rtc offset to set rtc time
Date: Mon, 14 Oct 2024 20:47:29 -0400
Message-ID: <20241015004945.3676-5-jonathan@marek.ca>
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


