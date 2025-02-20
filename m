Return-Path: <linux-kernel+bounces-523389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C63FA3D61E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4289C17C602
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DD61F12F8;
	Thu, 20 Feb 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKIjMOwq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D51F1302
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046129; cv=none; b=jz5uP1oJlOENR0iijT35KNGk1gLYon/ZxXnXRkmW5VZFGG0UWzrLBspGRlbP+bKljhlNkpkiDgMsQtuj3Bzj7/5kEzhqR/4h/XzwsuFYM3f/O1IUkQwpcW4XCJctsqlzov6afdA/nasE9xAwpc6zXxgkVPSyD3sKJZjMRANO6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046129; c=relaxed/simple;
	bh=FgJVBSjYusgZgNG2tQQqs/1on/o8VH1/MQqBVN+UdAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYxaItyjSIkY40hnOCzoxYqQWGh9+conVYboQfPlbGvZ8G30VX6AZsZLq63qMw9y4QximTOFOeuldUokfwKcvHSA9cq6Xx8dQHBN1RP1Mi/39Ul6uUOaaXecjacwCTk/lwJo2XnW0VpFDmBSNd4qX9Ioj2JHYwJvBU9FyKham+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKIjMOwq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22104c4de96so10429355ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740046127; x=1740650927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meTtqveZhiyJw9ezonjEpVoABcseZWYpFPvHUuAWv9M=;
        b=XKIjMOwqqPHLUlzVmfabnjG/y9G6wrDOnymNeaMNeNcCKdQ2HRLGVOV+RqSLJ1vupU
         Sr2DIg+L5yO7JvzqMB0oSdQbz50EEWqu7Y+VvAieeI7s5FDjWIuuSHphYzMgMRwTebbz
         PtArFsW7juJbbWExLE16zgXDy6WpkC3zsDiLwHuh25Dq5Sb1T9ACmabWaonZgWEh7myv
         1xrEY/4KuqDSZtoHNn3WKatRev10B/PtbcjK8MfTNx79DQCrvqywFnx9rVi8xbEK6axS
         QN+E89VEEdguQ41LPXNHFrChGjiVtniHNJu9vSbn5K0CXHmQT1nBQJ4IIWr3xmf801s8
         qw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046127; x=1740650927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meTtqveZhiyJw9ezonjEpVoABcseZWYpFPvHUuAWv9M=;
        b=ClQ6/snXTtPGHLAgRqO5XQNwEcIB23oCUpItj1TXWoANlszvF+gwSzJa+kMscTyGHj
         YNBetAZOnzqWRdJsR7kD/QPeNXxVpLVDayz1tqs0MeD0SA3JXSl+LAhiId6rfKDluCDq
         S46gFFr7ebjj8vgoh6Dn3aE6IQDUpVDAnH0RVbrUJhXAh7BdtPoLv1CM15qH1vGhZIFr
         Vne/+SHBaY8C+8lIKDtiGRCJPUyeXlmXZWWIp0mqq9NP65BjHsjub6c6sLx7MyksEk9v
         8aPF59TRqNOuxNej05hRRSB5257cO7OfjQm/fNZK0afdjr28lNr0iUt32eCrdOoq8wyK
         Hx8A==
X-Forwarded-Encrypted: i=1; AJvYcCXoX6GZWtHyllscBewbAHJgakqXNOeElh4GB93mcVudEYJ9FOlFEqiWrWgGSmznmSdpL1NGETkAvaGAclI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkF5NDVOnvVaGtdoSdYtUBAGPh+7vGGEUBdt97dJl7h0sBnkT
	vqh6fyh4f2Ppjo0Mk6l73Ip0IvmCItDbn5Yllb+H0J2PP0rjLihc+dVZtYGqtK8=
X-Gm-Gg: ASbGncugV4KDdDFkZFRVFKDIKJ15/ApQoJo6XpvZTyVC1r6VtwT7pP6J6/fwtHtp+XN
	o7lFR2F+A3bIiQzEHBY3PGrEgCNpyx8EhwL5qioiI5FIS9cDdzjynk91au3rcfPdDlq5g7tK85/
	VsV1qcDBmmVN/0fXosGHHFbJ8P++58Ks+4L8SbG8xca1V8xx3sZnVrjjM79iMYui5TVZ82+WAdp
	DRx7NfKhPEMcduNC5CGFgU+ImBXwaXhb9rxCv4V7KJJ3Cfk6skMPL9p9DDkC2tYPG1ISFTgzA7E
	fsduS4LyjDMD
X-Google-Smtp-Source: AGHT+IGD8wqaCpXBwdzW85qDe+j1va1f9U+T7g4YEj1TqycqH9bnYqKAjfpfwmdIfdAez2gbLo1Zwg==
X-Received: by 2002:a17:90b:3b83:b0:2f9:9ddd:689b with SMTP id 98e67ed59e1d1-2fc410493acmr28089738a91.22.1740046127187;
        Thu, 20 Feb 2025 02:08:47 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm15304645a91.6.2025.02.20.02.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:08:46 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 20 Feb 2025 18:07:55 +0800
Subject: [PATCH v2 4/5] dt-bindings: display/msm: dsi-controller-main:
 Document dual panel property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dual-dsi-v2-4-6c0038d5a2ef@linaro.org>
References: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
In-Reply-To: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740046076; l=1495;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=FgJVBSjYusgZgNG2tQQqs/1on/o8VH1/MQqBVN+UdAQ=;
 b=oaEXnf20Cz3Ju+1zO2v+vtkcbrG+X7KDJR0PpZRcUkf0QC2Lo0cvU97aOJrdgq8tfBzlaNeD0
 vvilHqVr9BpDIW2cesJxDngRIMCexsZ2QgBOnuum6tB6wsLrIJuhgMm
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The DSI interface can be connected to a panel that has a dual DSI channel,
or to two separate panels, each equipped with a single DSI channel. To
prevent the DSC configuration for the dual panel setup from disrupting the
current configuration of a single panel with a dual DSI channel, add a dual
panel property to support the use of two panels.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index ffbd1dc9470e2091b477b0c88392d81802119f48..e3f2eabde27609a66d6d81fafcb14e1bc014613c 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -88,9 +88,15 @@ properties:
   qcom,dual-dsi-mode:
     type: boolean
     description: |
-      Indicates if the DSI controller is driving a panel which needs
+      Indicates if the DSI controller is driving display device which needs
       2 DSI links.
 
+  qcom,dual-panel:
+    type: boolean
+    description: |
+      Indicates if the DSI controller is driving display device that composed
+      with 2 independent panels and needs 2 DSI links.
+
   qcom,master-dsi:
     type: boolean
     description: |

-- 
2.34.1


