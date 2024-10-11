Return-Path: <linux-kernel+bounces-361403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89699A7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF9B1F25202
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C61953B9;
	Fri, 11 Oct 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="MdIBIvS/"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864B7DA82
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660668; cv=none; b=Orr7RxwbtF7rDxisLIQ2flCB+YED26fwjKoWYALLlbGJ7LMUpaZgEhfBs0qYhl1w7xNTaW+sdZru8tUMfq8OIvushQohYw5n1ML6UMwS909+653KAV0ezZZkhQPtZBozlfC2igk+tmNAar+JcSEIy/m0r7Jj57wsNjfCYjNMu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660668; c=relaxed/simple;
	bh=zsdPhLIVMFvAHfZz46sNbQq6eV1/GIUeuQonFruN8KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRO6d5KvF8J9u6vItJzZwXlETKJP2YDpD04DSrWb7GAU01sJFb26HFKMf98sMs+YnyL/WJ3l6jUm51slVYbz4z7jAOVjSaefmwxG0/VC3qa05RXuXkJ1Lork2Tqhi+q60viLIsD6Pp/J+e73DACBCSb0FTXEVgBSFmGmoX/u01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=MdIBIvS/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b02420b600so183825185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728660665; x=1729265465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKrcJiYut4ZlcvJ+rK0LHOlWG1ixpD8CA4mx8U0b5EI=;
        b=MdIBIvS/UhH/OVT8ml2WSIk7CgTtCyvRhcNUFTJT0ruXAr+VVnz2pNzWpnZfSw6u62
         xcAFokuJa1w9KkyjkeP8Wbtz8kC6SxNi89QPQQdvlurTqCDlUU2jj5P6qwBxmkBz/pUu
         wSbtA8NX115Zf3Wgox+zTicc+JRcuVy9V3lgg9sexjE16AeXnPQTJUVrXkYHXRzQNRe/
         SzL6yi6JOh+1PyEZ42V6REYbSfiY1p+FkbclrFPB/5k2+8Slze/Z2V8irg/s6CSC2lL4
         dH9im/xUPCsaguZQA2J4MpX2bsG503JOVE34D6sw6zrAx5yyJ0ERiAnWJC2YzQXwPQ2f
         YOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660665; x=1729265465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKrcJiYut4ZlcvJ+rK0LHOlWG1ixpD8CA4mx8U0b5EI=;
        b=AHn0W6hCe46b3tpVQF8LJGwqA210yvHHsijEh75ljT3YwaxL2lC2PSfRmbfahdMSGW
         NvpNf4/JsSnkLhZbmHgWRHfgRDwPgY0kNOOJ3kAMl96xpgCMmn2SILf5Bcjz6HPfa8Bh
         HxUN+MU4upUPVGAvfVwiZvIjlGnmM++sUnW76dBMdTUmlq70IDBeEV5eJoKUq+qxiUI3
         rEVLT5lBJ3Wd9WO87K8BT4eNwBr8jOuoPBSymlMsASI32dhMKlIByILs5ieFTyd2L+dk
         3Z7v4sn7MJCpBgkpHCXobxx+QebsDr3P3bvrzbUsqp99cvxgyXGUzW97xM/xu0fk4TGA
         fIxw==
X-Forwarded-Encrypted: i=1; AJvYcCWObxabxp96vaFfsnO5UlrFMS+pIQ9mgWndgfEYeJgrGv0tO1SrG5AaUxx0YJP4xK3QrlegQf5r6BiaCBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIucGD7AHtyd2OK6JJZkqZLFQIJXoBtGzOrDzwaDGEFf1efY1
	UwRj+fIZWt0uvgCsmgeLatuxPvd2aItkJWFb976YdxLK99hSc5C77rbFtvuLbz74+qCLF/uTgmk
	GPwc=
X-Google-Smtp-Source: AGHT+IH9yonfsSPQK7ryj38gl9MtqzNSqnaDaXVaaDFmnZ+fQ9xGaeiY6zFJQHQJ9GmvJeawHGFLYg==
X-Received: by 2002:a05:620a:468a:b0:79e:f851:66ec with SMTP id af79cd13be357-7b11a3c1e9bmr447744785a.61.1728660665457;
        Fri, 11 Oct 2024 08:31:05 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148d6a09sm141714785a.42.2024.10.11.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:31:04 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: enable otg on usb ports
Date: Fri, 11 Oct 2024 11:27:11 -0400
Message-ID: <20241011152712.31571-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 3 USB ports on x1e80100-crd are OTG-capable, change dr_mode and add
usb-role-switch flag to enable OTG.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 6dfc85eda3540..53e76b3f0c831 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -1558,7 +1558,8 @@ &usb_1_ss0 {
 };
 
 &usb_1_ss0_dwc3 {
-	dr_mode = "host";
+	dr_mode = "otg";
+	usb-role-switch;
 };
 
 &usb_1_ss0_dwc3_hs {
@@ -1590,7 +1591,8 @@ &usb_1_ss1 {
 };
 
 &usb_1_ss1_dwc3 {
-	dr_mode = "host";
+	dr_mode = "otg";
+	usb-role-switch;
 };
 
 &usb_1_ss1_dwc3_hs {
@@ -1622,7 +1624,8 @@ &usb_1_ss2 {
 };
 
 &usb_1_ss2_dwc3 {
-	dr_mode = "host";
+	dr_mode = "otg";
+	usb-role-switch;
 };
 
 &usb_1_ss2_dwc3_hs {
-- 
2.45.1


