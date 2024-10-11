Return-Path: <linux-kernel+bounces-361394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F241299A7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D14B213E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5B198857;
	Fri, 11 Oct 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="eTAHlZHK"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205B195803
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660455; cv=none; b=Pc3GEexX4m7MK/jHE2ayuMwpeMB9cXsugluEmelVZTWmJNFqY/cPQmejbTnIf8e1fwpQEa9hV/y2WRkMdbq/uNMCasLh+esGv+Hct/M98kHpcfKQHdgY3ugHOXWWNY8UCc3wWxkjCI4FqCxFb/duEsGVWmixYQww7nxRs+divdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660455; c=relaxed/simple;
	bh=gygbM/0TWbve0yTggoKlMNvknZTLgYXQh0HMHtv9mEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE2mxQFJAbkIV+AP+OG3vu+LkpYgYFV3/gov+5nSnNvOEPSA0Gc75Dh+wEqZo8i12HPwmeqlG48v5it11mX63nIB48vbmXDwWEatVV83lDpLl4uNXgngzu+xi2MbLzOgGkb3XS5j9wmKbD+Ul0oAJV4X5qEXP8Z/ZNX56BbnYhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=eTAHlZHK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7ac83a98e5eso183606085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728660452; x=1729265252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NvbtWswNjmMVigXav8simFFQPZnS0nT4PzjzHauoQI=;
        b=eTAHlZHKgXdhvHPRoUscEYmUQlokGEzIl1MhqslOrWmVCcPIPKF+f97VN1EXHS66mB
         BT++1EeDmZKMG/Fpfim9OM/Z7cfxxkyF8PjGa3myr7uqlpEWsFyGEcwcWplwk0umc5Tr
         MFoYnH5/TUplB/PomtefmpZ/vghoAkSizrfcWI6ssi6MYfSTMLMejqjU7MdadHz2CpSc
         4hvnFx9eRNHg8+zRcXO+lHYkR9GrjXBTfDir/EhqCpzLJ4NpZmBUVi9qFywv6dGkBzzZ
         BCIPmXY+A+e6nE9RfoLTou4IkcygjYxB4bNOO4P5PR9aHRKsm9/y8MXpjruHeHdoVx6G
         A1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660452; x=1729265252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NvbtWswNjmMVigXav8simFFQPZnS0nT4PzjzHauoQI=;
        b=Rc1zUPP1tKs+PkM6m3Lav/uUaYr3DIOOmQnryCC4CLIXSvidGCoMSfQS/h+BnF1IM4
         SybboZNc+90ox7CtZJZgorFdrjot+AyVO29ZYAvfTQ/DCgUrgDyY1GHIhEY2SQF64P3s
         n78Sx1zdh7bMjzaET3UzHkNtEYE4w2r/VmanLTc1yM1BAMkP06RQgyBwiowlcsxmfzkM
         RcH9HuSRRKP4t/BxdA+5cJtxmbMMrJbCfPw3LoHQP9sWwhBFq0WfUoyJao2Sj8LyS37+
         nxl2V25qBprYmNoONPtetD7YsddkD7kCRco/ZB1kdE+9OtxtbQKArdZF4KQ9iOMJbpL+
         B0LA==
X-Forwarded-Encrypted: i=1; AJvYcCXnQE0JAikiUtjji4+S1Qdx44oWfBf/sf631Bu4ASkKmnF8M2NsCCfrZ4295JSZlDv1+ToJegYPrbkERwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqTOqj98184EuQpxldyPUefxUml8Dlo6M6QcrsXfzbbLrQ/k9
	Z3/MvfyPRr2kKyGP/Hi2QHojFYZszZDsVIDtnuAlNTprej53LERMI3zHtpfjSIA=
X-Google-Smtp-Source: AGHT+IEuUyr47HQ77Dj6rHURBePuo97R3GxYp5l2VR2BBG5BruZx4SafyF/ZWlHT/YwBEzdpqhA3lw==
X-Received: by 2002:a05:620a:46a5:b0:7af:cea2:75f1 with SMTP id af79cd13be357-7b11a3b5c47mr518993285a.24.1728660451832;
        Fri, 11 Oct 2024 08:27:31 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d5220sm16344131cf.32.2024.10.11.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:27:31 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Satya Priya <quic_c_skakit@quicinc.com>,
	linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] dt-bindings: rtc: qcom-pm8xxx: document no-alarm flag
Date: Fri, 11 Oct 2024 11:22:40 -0400
Message-ID: <20241011152244.31267-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241011152244.31267-1-jonathan@marek.ca>
References: <20241011152244.31267-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm x1e80100 firmware sets the ownership of the RTC alarm to ADSP.
Thus writing to RTC alarm registers and receiving alarm interrupts is not
possible.

Add a no-alarm flag to support RTC on this platform.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index d274bb7a534b5..210f76a819e90 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -40,6 +40,11 @@ properties:
     description:
       Indicates that the setting of RTC time is allowed by the host CPU.
 
+  no-alarm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that RTC alarm is not owned by HLOS (Linux).
+
   nvmem-cells:
     items:
       - description:
-- 
2.45.1


