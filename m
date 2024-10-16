Return-Path: <linux-kernel+bounces-367603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C629A0450
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495691C24A75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636D1F81B5;
	Wed, 16 Oct 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmpPJjX7"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC221D88D1;
	Wed, 16 Oct 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067553; cv=none; b=bhwKNRcHPbT6+g0hnUEbtNl+fSv2hJ5ZKmEuFzlbOel5s2dNMcNZ9ev6VXSb4HHeL/va/HTos8LqMu6RZc764NBYJq+ChVSNsl+mBvZnTGneRZmTkZYHmfWsoL9Sl8wRJAadGkwyC7E1Q/QLvnGflPh07imHeoBeh5d5tSGEgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067553; c=relaxed/simple;
	bh=UpxHjGlwptIY6hb1ciOY6vnYQldv+ntwJPaiFY74vc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5QMqNQm6NGtqqu27yGaWO6SDwx6aBkLdHoYwWalReqiTPY0gTpwdhkfkEuZDQB+JnvUROaxpWneN1m9p87Wy2nzfRPc4sZig5o91iCZmC8c1TPJvOX80ZoooriHAj8l1nSSN1b7ewFpNiaEIWDGj5u0h0ycr1JMm1ZPizUAz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmpPJjX7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea64af4bbbso404627a12.1;
        Wed, 16 Oct 2024 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729067552; x=1729672352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkvqRkXMu0WbwdlNBbyi9/KgHkkN3Ncs5otSFtEzCg0=;
        b=MmpPJjX7mWtRsezGZmWL0eXlv8qpxFdlxmCsrIse2rFApGyVW654goNtQATve6BWKV
         p8yWEm0SNtcthaLqmScETUv4dFON1R+7sLeyT5mxo3EtMuC2jV5cq3aX2RRUPu0neW/F
         gzvt9CUD/Bw3/q6cChRSo08/CLE7nYVJeRw+IDizNrBQKCMKLdzYIM92u//APZayINQZ
         w8m5oDiHP3Qr2P3IPQZ2UGJ9+VfaGKgisXZXqASnU+2Ta60IGsK7SBuYKMKzrKygWWcb
         EHUOlw4A29mj+McIGa2io3e1OtPlWF33qCZowiYp6rMij2uEUUk5a09zIGDW/QwUd2Oa
         8tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067552; x=1729672352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkvqRkXMu0WbwdlNBbyi9/KgHkkN3Ncs5otSFtEzCg0=;
        b=S64tS2HqtqcHFap7e2iGmDdjIXmPfpvPScVplVzQWf91Y7WjimFNQgMYrYxEDi8OEo
         8sglXgZcATa22o8Pn46TzdEyH+CvRqMJrIMsLBEC2JAmsgCrRrxeQQ19QNzStvRvVMAD
         bC290W8kXh7X9Jz15VZ/kBDQ+HYBj0obbHoKNMAzOk/LvUA8TESF4vJM+ya8yuaiOT0m
         GnNY54uMWrtlVPn2lRnYwYzhfLwyPWKEK2/aUizCEtzgxqhGErJtgU2xeJ3eQSrymO3B
         hWQZxoNanhgdhNY9dF8EneW9uM6quCEV5rwBUvgJk1NMEvFbAthY3ZJ6GUQhIZrmCCD4
         v62A==
X-Forwarded-Encrypted: i=1; AJvYcCUrsRWepc76vczdXDHWTWs29Dn2XDe4Lz9IrqAepRZklIbDhQFexSLGyx90Usosizh7QFDDxcRnqcmd@vger.kernel.org, AJvYcCVFyf6kK6V41XuEsKKEFxxWRHiWtYUXpGzdY8rgB8rbPprRDoKBi2oxaMsh3PPfLVxHUHSyAqQeG+eMPDsn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6hBf/isxpPI0fuRZiIGIpAeMg5KXgkajerx7ggJxbYlBnCPB
	ijMCnTZ74zs+FCLHfUM3WobNCba3Xrr50GgoDyAScYPAc14Mqk6b
X-Google-Smtp-Source: AGHT+IFMDyRo+nhzjKM0ITHKuIUCT/fwiSYJItDfy7iC/4cEBwIZYTdSwUQo1SZUUDlkKEHKATkTMg==
X-Received: by 2002:a17:903:191:b0:20b:80e6:bce6 with SMTP id d9443c01a7336-20d2fd34a58mr10929065ad.4.1729067551670;
        Wed, 16 Oct 2024 01:32:31 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804eccdsm24067755ad.223.2024.10.16.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:32:31 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH] dt-bindings: usb: add rk3576 compatible to rockchip,dwc3
Date: Wed, 16 Oct 2024 16:32:24 +0800
Message-Id: <20241016083224.14839-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Add the compatible for the Rockchip RK3576 variant.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index c4924113f9bde..a21cc098542d7 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -27,6 +27,7 @@ select:
         enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3568-dwc3
+          - rockchip,rk3576-dwc3
           - rockchip,rk3588-dwc3
   required:
     - compatible
@@ -37,6 +38,7 @@ properties:
       - enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3568-dwc3
+          - rockchip,rk3576-dwc3
           - rockchip,rk3588-dwc3
       - const: snps,dwc3
 
@@ -113,7 +115,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,rk3568-dwc3
+            enum:
+              - rockchip,rk3568-dwc3
+              - rockchip,rk3576-dwc3
     then:
       properties:
         clocks:
-- 
2.25.1


