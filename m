Return-Path: <linux-kernel+bounces-526505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B719A3FFA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B187AFE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26038253B5D;
	Fri, 21 Feb 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRRIezyM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495525333E;
	Fri, 21 Feb 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165595; cv=none; b=j8U27IfKzUeu1UpNLw4frhHAv8VQksV3RI/3/3g3OZgNwiYWqE3tV7rOl8tPSNYj01cqgsBK1PvV54HSs4kqgVoCpD4TBuGKhmhVLMXIqNXhGQI8GeM88YI16zgnpGBgOEKT6710dGC7l8E7ibNODsrWEk2ERbNy7Ptf+8HGens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165595; c=relaxed/simple;
	bh=8RjCHeGicpAI7VaTcNR4h3jndERCQ5XJEatYLWqDA0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSiFEKqB2aU45P6bz6It9cKu0p03EXcpGLDd/KaV+XjCamMLZ0PfdBiTdNd+mylsvewvXgy0Lup/A12HHDlT2Hnta1xtymI3ZSRY1Zpltp+Vio++jsdTT8vn0JjVJ1caQ0WJbucex2m5bk7/VIHyS+WZAhzrxwGq4ispxiWe9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRRIezyM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7f539c35so482807966b.1;
        Fri, 21 Feb 2025 11:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165592; x=1740770392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZM3oG7u9MlBe7jgQYod3pM9eHw7F5bbi3sRetSKux0=;
        b=CRRIezyM4aiuyzleHQg0CqwlkjW8yCOVWCuOoleX7khXdxwXzbdXKgAFPQ4+z8FV2j
         eZ0X2MJSKtArslC4JwYw7SWuphxI16W7wvivgH0HclBF4Qj+BNVA2wJNdTDxz0A5yqom
         Byr/O0EsBRBP9JQaeRuK+DPbC3XIj+1V8VABLK/M9Z8tgm1qnJF/Tdw5yqzs+YriLmz3
         Oxjczn8hwAhrT1L8Lqev80M2EmiOHtFq7JtJlbNaxeDW7MqB4KvtwvhSodhyj1/U2Tfc
         DaMNc10/6hh603Tyu51YHd7T9o59Hmoglbxd7FKkWmcYjzWXpL2uqdkg7j+twnFk6vGb
         SsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165592; x=1740770392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZM3oG7u9MlBe7jgQYod3pM9eHw7F5bbi3sRetSKux0=;
        b=kxiwGvclF1RkpYPVx+dSN9Gs0r0mGwh5bOxQwX1ghyLcXWIVa/1k8EQPVcRksTsdo6
         JMjyWt5dUhAYWcGkYa6h0PzuEgB/OMGNY5zAxmOz8IwYWJC5kX6Bo/67ROH0hKOiPOHm
         FyZNCa2nyKh3wxx+NFNo4YAxkelTWvu/OLDlVO4r2GmX8RdMIZ4HHycKF7yfsAHDSxdt
         ncMB4hZpfNAkb0/O1MDZlITmm0bQymsEYF6ducAucpKJcOgVMZo9anN1PHlBqtWJdnD2
         0ye8gDzCt5f6V+Xuu2V3SNdGp5K8Su3rmLkLmfBxXOuAsGtBjODDVVQL6sv7oglCNUCG
         R4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcJW6/rw0DzQ4u0h5IiOwUnya9Eu6FFyZayCEgPNPUkyz+cX8OZoF7p2Tr59782yz8lZF1vq7eOfrr@vger.kernel.org, AJvYcCXMJzfTuc7iamFA+rhKYaSY2+BnUpwsy8jeGzvsCwWoaH/3rNXM+HLkmFxw7wSKll71tVQz2uWTC4HRAV1l@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsyXvjjZbVXdTyoaYhSCaPLTPcAqOzWWGX9WqjGZY6jTcWhdm
	XfhYR6CROZzRn+usLOm4yaI6Z/RINpcHNfVxpJfcQGqKkfsQQrjV
X-Gm-Gg: ASbGncvPzbudV5jv9XbTxq/Cj0N6Ja8Jr+DcoS0yM3TzKLWzZoGxKoYx7Z6E/JPr1vH
	9zGwZszQlDao7TAdzFneI55S+J/gGphlTIMjdBJrKlPoqNdq8J2X4cqZxxFFPLsbne2a8t+4yni
	Q3VkDyfwGiRNFJFH5D5zJY21Z7VnkYMnGFNE9Kc21MGSbp7Bz+DyiBW3IblobxnYHLPbtPCo5oy
	Zal099XHtXdNHOvs/U1bUlNMf9HNmBEmfMijUZdEvOZHGv2uR6fPDRCtrADlMbUmmS3K5yl6x76
	p1MQwCB4ur9HvFPyFEOh4iYzK/FntL/HJ1xPyINv1aHbc7Gf5jNRDefjGcE=
X-Google-Smtp-Source: AGHT+IFhYP8y5xpswatsEAcBPviWPk6yhTISADU0DuizXwbXYM7HIbRp4R+leRv7ntYUsYVDT1hb0w==
X-Received: by 2002:a17:907:9446:b0:ab7:ed56:a780 with SMTP id a640c23a62f3a-abc09a97abbmr474131866b.27.1740165591932;
        Fri, 21 Feb 2025 11:19:51 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9cee79fasm995276266b.129.2025.02.21.11.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:19:51 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
Date: Fri, 21 Feb 2025 14:19:06 -0500
Message-Id: <20250221191909.31874-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Some DSP instances may have their access to certain peripherals
conditioned by a bus access controller such as the one from the
AIPSTZ bridge.

Add the optional 'access-controllers' property, which may be used
in such cases.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index ab93ffd3d2e5..869df7fcece0 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -82,6 +82,9 @@ properties:
     description:
       Phandle to syscon block which provide access for processor enablement
 
+  access-controllers:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1


