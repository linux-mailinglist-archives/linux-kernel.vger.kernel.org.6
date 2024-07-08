Return-Path: <linux-kernel+bounces-244000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BFA929DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45E6284DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CF3B192;
	Mon,  8 Jul 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHlfDzBF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887836B11
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425093; cv=none; b=BvEknlgAPM0ogEH42IUrb6OPmJVWzBb09iBLkTAIa1YlXPZ4dSyOnxLbiN8uQkh/jxZg84bUAuCUTMDtn98WXPGozG9nOzJew7evDD2GeWWu2+u7KF/e6xWcr+yfvsa5hUqFYOZJBbzx2HiH0NmTLi0THyhHoVtCNQ0UIlvA3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425093; c=relaxed/simple;
	bh=sMCuHNPwMzVOTIECsai/oVdKXcj1XiUQZZ+KQ8wvdlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeUZzmp/PVJFS1FBv7JU0lUkIWYanVIOXJUcMYTxRYcInzQM1qGskUQ2DcwzXc7hRiiyz3KP/UjdUXJSU6N0zqEwu53m3q1UdsnDmov4tQ9zeJv5GHxDq0ACK+FWaBDeLzpn9Y1uoL9GigMYJIDWoCtG4NyuPre9afI7vKNCG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHlfDzBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720425090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mbt2usRMEhPQM41Uc5WG7giJsy4J3tFaRLey9pcvtWo=;
	b=CHlfDzBFRoQYTepBz/g+Dr+p67wdQ6uf2yLq0AqXlfAXyXrvkwqtI6qbYEayaYOngal5bp
	mzLbHQh7jAiOuVkm5ZwhbLhGaYSigz8FTuB4iQ5T4jfqWeJ3tLXfGN0WNPwFKf4oF3LX2Z
	ypIoQsp2zBv12iliocaw5HCAaJpB+Mc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-m21sXNNNOLKEFnU2TNRM7w-1; Mon, 08 Jul 2024 03:51:29 -0400
X-MC-Unique: m21sXNNNOLKEFnU2TNRM7w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42668796529so5426895e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425088; x=1721029888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbt2usRMEhPQM41Uc5WG7giJsy4J3tFaRLey9pcvtWo=;
        b=k3UmWg7JrUM9nnKsBIhXPpznIN/bV6pRFBrU1a1IlDuJExn11SuOKQYgZ/oIUqSSS+
         /NHHbjG4hdkfIOdgzkLwYpEsM0KfkIOI/FT9CyvRobplY3VI30Y1T6zxBCKTmrLrXRv+
         FN+rHc9Kav0vkQ4TNFWlfKJnn5xNGyI9KPE1cCF7Sfufh9Ya9bFHF5gxTi7Y9Z+znEgr
         wVBO2BF6d6oEFxAtcWu0wcSki6e5AVWqTaZ16c9LJI1m0NjuWXxWL295xRg+h2Or6w/0
         aepFc8RHnoRaRQKxs6Oj2THQrJiHHDE2aiPAKPvQrVdcubr4Q2crRBJV7VdkcG1UQVKo
         p18w==
X-Forwarded-Encrypted: i=1; AJvYcCVgdwYMqg6yS9udx3s7hGgFK5YI/ik2xEMsNixLT2I0UzSFaZxPBXzwe64321SM5fp1nWc1Ih4bFVRUNquVNlcDH2/SSYxNo/k1ws30
X-Gm-Message-State: AOJu0Yz70U1J5yrIId9gqbkbdiZALoH1J/RxA/zFYvGs/u7caRxzAua7
	l9K+UUPL2WV374jMDx6a2lchCcDWbYPR6lUxbBVuDpEyhDn4Zeu6WBfpDu32R5Mv6SwpVChiC+2
	Avzt4djnzmKmR+Q2f+PkrBG/Wb1ZyEcJ3gRPusT7LqaeJlJGOwD1pAdpT5VDhoQ==
X-Received: by 2002:a05:600c:2e49:b0:426:5471:156a with SMTP id 5b1f17b1804b1-426547117a5mr52986545e9.13.1720425087995;
        Mon, 08 Jul 2024 00:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgOpusd4NR4jXY1q924v3zDOMC+LgMqX0gtVRoZWih+SE99nRuVfWcAwG/NI2cxpeKYpWMxw==
X-Received: by 2002:a05:600c:2e49:b0:426:5471:156a with SMTP id 5b1f17b1804b1-426547117a5mr52986345e9.13.1720425087614;
        Mon, 08 Jul 2024 00:51:27 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca4b7sm153482915e9.37.2024.07.08.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:51:27 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in QORIQ DPAA2 FSL-MC BUS DRIVER
Date: Mon,  8 Jul 2024 09:51:24 +0200
Message-ID: <20240708075124.73522-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 78fa0d19a50a ("dt-bindings: misc: fsl,qoriq-mc: convert to yaml
format") converts fsl,qoriq-mc.txt to yaml format, but misses to adjust the
file entry in QORIQ DPAA2 FSL-MC BUS DRIVER.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file entry in QORIQ DPAA2 FSL-MC BUS DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cb9f0819d8e..13332cfc15f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18588,7 +18588,7 @@ M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
-F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
-- 
2.45.2


