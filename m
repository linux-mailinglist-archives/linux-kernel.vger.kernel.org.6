Return-Path: <linux-kernel+bounces-378721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB629AD45D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD51282AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B371DE4CE;
	Wed, 23 Oct 2024 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGpz2Tj1"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF401D5AA4;
	Wed, 23 Oct 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709936; cv=none; b=dog1OTBPI0Bg3BdpV5J63B0SPWCGUF5nOZJQ//IgUQC4j8jnfDO21FinnKk3hrSDgCGgEQTcI+Fmg08DOxrWKy23oOkEMUXKwxoKlhPNPrj685Bx7yRhfXt2UtbWBO+f64q+E6QiHIDmtwxzIZupc9TJ4bUkFFUzlIg/EnFyML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709936; c=relaxed/simple;
	bh=x204FY8czbHAb7Cmw99W7nI9BVzyf3/4zvjGmKOefJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaZbCeIZezBhdircDg2gjSTLJ8tv92igVsVCkMWoDdhEB2AENY71iXxkmBaBwVmm2GcJjYhq5dyyza26YXUkhZ2RG46Cf5mPaUTAvkte7zMBDJC2zJHAjSQB/bDNO02can1o9WJ8TqndY7jkqvQ66PSouUkvP3yKqdbMSHzbFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGpz2Tj1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c77459558so666755ad.0;
        Wed, 23 Oct 2024 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729709935; x=1730314735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8POc0ozVUT+47lXZs+WKX2u4H7qQ6BvNQLFo8yC2yY=;
        b=BGpz2Tj1MTC2J8Cnbmm6LnjUekip1LcTuAXQVfQ7m3rDet3hjb93r3J8ZPKk1HGLPy
         SRs1uyRqjSDWKREWU8Cvs3yc+O52yrNuBKob11qkldA7x8BdjrCmQ5pWnDdimI7aZoyv
         CaGMgnlDlCIe9+MwWi5eh87QTxVaLGI7ScmSakyV6+XBgNTb+8MTXmAdTaQozON2oj35
         wpNibOmD8C8DGxiSh6lrp5VmOix+LH30NTmZ8a3g81y+s8e5Qv/MDViKbvPvkbKjR8Li
         qBL1BL7oJ3vpFzGsQaUfKk3WNMaBhh6q0KcCJefUy6DQgdXA1h5oWCWN1yAqX3p450zq
         TSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709935; x=1730314735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8POc0ozVUT+47lXZs+WKX2u4H7qQ6BvNQLFo8yC2yY=;
        b=Tz2pW1jqMxHyVCkZgSco0ozfZQfKJXk56nvv1TRDNWBFDLK4GIeHSz8oeZxTau8b5Q
         YZ2d4QyF8WCmybfDY9DDA+BxS3BncG8mQU0R91f/uxaHva0QKHrDLfhm9kHZp2vE4XSV
         3nGUspyiJH8+wpaIlDnNCzgLoGFi8QdmxWay+yFa1ObofSjtMjdfqh+0wSeLR7DXn33k
         fwQW3/Uyjcjyo3n253dGz4YE/KSDEgCULru/hVD7My5z8U3U4G43OeYltybo1T6cs4Sc
         dnqfSLhHPIKglYLYc/gWOZPFQuaadTROkGnyr62ViOJJI/p5Zcyf8KtdOgdGVucW3H/i
         /CaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN+vHPsxv+vRqz0Mn2hxxu3LBDe+VlheR+Y6znFtCllvXMCQmqX08uL79Y1XB4liEdOwu7s+paPHEDCbuA@vger.kernel.org, AJvYcCVqxtXPviZxbwAvM2du762LFWd9hDphnFGDSGcJnQyG4NGiBHXRgeAq41b/2mgJ2HsiAUFnviS2NsNY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfsjhl6VJQnwJ1H5nO3Ob2H1BTJiB3t35M0+AFCvSFclXbT6lt
	yGB8cFbMREz82jQjlCRcEvCdmyMyYSQudpQBSjgUoxrAicXThmqu
X-Google-Smtp-Source: AGHT+IHH019wlye4OLyzFgAVfsYnBimRnqGGVnQAULUDSlRjJMvfsgn8n6SH4ioTZQtD+DntZKPrMA==
X-Received: by 2002:a17:902:e5ca:b0:20c:b876:5046 with SMTP id d9443c01a7336-20fa9ea37c0mr32248425ad.50.1729709934726;
        Wed, 23 Oct 2024 11:58:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:248:317f:2ba9:e66c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f6ee4sm60619955ad.295.2024.10.23.11.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:58:54 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: tglx@linutronix.de
Cc: daniel.lezcano@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] dt-bindings: timer: fsl,imxgpt: Document fsl,imx35-gpt
Date: Wed, 23 Oct 2024 15:58:41 -0300
Message-Id: <20241023185841.1183706-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023185841.1183706-1-festevam@gmail.com>
References: <20241023185841.1183706-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX35 General Purpose Timer is compatible with i.MX31.

Document the fsl,imx35-gpt compatible.

This fixes the following dt-schema warning:

timer@53f90000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx35-gpt', 'fsl,imx31-gpt'] is too long
	'fsl,imx1-gpt' was expected
	'fsl,imx21-gpt' was expected
	'fsl,imx27-gpt' was expected
	'fsl,imx31-gpt' was expected
	'fsl,imx35-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
	'fsl,imx6dl-gpt' was expected
	'fsl,imx35-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt', 'fsl,imx8mp-gpt', 'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
	'fsl,imx35-gpt' is not one of ['fsl,imx6ul-gpt', 'fsl,imx7d-gpt']
	'fsl,imx6sx-gpt' was expected

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index a2fcb1e8e74e..9898dc7ea97b 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - fsl,imx25-gpt
+              - fsl,imx35-gpt
               - fsl,imx50-gpt
               - fsl,imx51-gpt
               - fsl,imx53-gpt
-- 
2.34.1


