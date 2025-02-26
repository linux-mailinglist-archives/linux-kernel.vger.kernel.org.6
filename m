Return-Path: <linux-kernel+bounces-532852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95936A452F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFF83B37C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1EE21A44C;
	Wed, 26 Feb 2025 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTcx8rXo"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD4218AAF;
	Wed, 26 Feb 2025 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536150; cv=none; b=bFq8NRYezN7Fru4xJOWDZ21hiKMT3+zFoB4FNX7Gwh21sYT8SdZgo9m6Lcl8RCs0EF+tn/+vRpKBMekTdSA/O62x84qBLh1TUoSTGUAJSR3YcK3N6G3dtK0wGdBDrB+e3XhtU4JnprUT4XrVYlW2pQvB96YJxituMSY09S9+4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536150; c=relaxed/simple;
	bh=/r37Uw7CkBPVUgHSzBMXiIbx/pc5+LM6KKEWlFa1wcA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6BfMLMHisFtkv4O7gstYkSX3CWv4Pge7c0Y28N2/7v2LP71ec0IUjg3lY82ZSUDmph6uJghEwocQOSLFBAIas5RpbGbwPgpd6CyTa9b86J+ilprGCz9Oz3SQv4W5LNyEtChVoihhgEDxGhCs2hN3aXjmSLMHp7Twjuz2fXL2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTcx8rXo; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fcd509468eso3043066eaf.2;
        Tue, 25 Feb 2025 18:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740536148; x=1741140948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHGavz6z1XAW16p7P/7q7QGD5LUvtpVWO2vRaC4bQT4=;
        b=FTcx8rXojkKKHryAKa9gqn6vI0aHYfe3zVRbY3N32RDp1njWR2OZfptEB/aBPZQV2t
         LtrJagGRZB3fPiEesW2ZODsmebAaW/U2nA3svbQ0TkdOvG3TOVs+dl+HxnR1LHlHCafo
         Rc8OgEfpDsn7GcVHhnnYjiysb8oczdWXBewVh5pIXK6eUvxOE1NeC4hWEwVryKlUoWfz
         ItPOJ4iziaFmnOGl2tEiePuo0CHcnmzVUN3+YvlC6t13m5O9PKFkCnm/uCo6M9oP/dzA
         IzIJ2TdmdDSLWOWRR1GV62dkgWtyCWOlrf2nXx6k7xHLrVVeRxYPBeKgAAtzlOrJ7Qhl
         aOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536148; x=1741140948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHGavz6z1XAW16p7P/7q7QGD5LUvtpVWO2vRaC4bQT4=;
        b=NZh86OgFL/FDnC2vKm4p6yQFg3wNRhtFVX9XfDBupGrCN1L0aDU70RBAjifVhyG/yJ
         ClvgQes3blsu75dtSrYXuinfhFjzO3c5TJSF2Vb1U7K1eooVW7zA63T1ZFgkeybxjERi
         PAvhu+Ytx3dKjXtfwrhUFGEw5QmIo4g2LYDQhG1gVz/dvOwFZ3mN5QcWoqoGjMmvORCo
         Zan80DcBKWGNVvcw+hmcZ+D74LHAkFFM1QspaEA3k3r5/zy0nVzwPsU5aNbCEt4ah/AB
         DWNpi3mL3ADtqs7LDVoZcPNgeEKda8G7NEnh3Ls/vB2+il//lFH7+YO4Si1Y1SfUDE+n
         MqWA==
X-Forwarded-Encrypted: i=1; AJvYcCUDannqm0qg/2QjlT4GDRQug6e8N0cXFbdX8bD7v/XOsJEij6E47BZc5QXY4f280QRJLJB+Jmtds5Iq@vger.kernel.org, AJvYcCWYrv0sbU0H7qGVSB+g1q6vy9CBufJbNfuhIlVwH5lCFjKS1qaMqLYhrbQX3vE9xGE6YAuDmGknlWE91k0j@vger.kernel.org
X-Gm-Message-State: AOJu0YxOi0ZoWrwhVrMgKpj0aiv06j3L402doFji1sRaeyPpmiNorWva
	bEJkG1Vj9a4lJJ8sUZMBiiA7pwpYTA20lu2esAkgsEmXsb1/76dJ
X-Gm-Gg: ASbGncthcEVYG+Y1muEl1sju+a0TYVSfM6vlbSZ5rGvcRLguN1JtX2UKYRKzDe56lID
	oxEkXZY1QhGk/0G1jchgUPQVJXJdcSp/t8KZ2F7IibbVeP6rPb3JFX+Fi7p11jmcBuheY0WSQPI
	vEx4LDDr0Iaq1DPQsGI6EjOCjUFXKQeX4cXt3z7EgC0QZzZtLR79y7JPHRt4E+qpRBEljHuk1Ky
	9/M8PbO/UPXMhikVlPLnQskkoz5JbBIgOeMqnjxtE80fmVgnoTUxRN/atckteQ/BoSOAB197bn8
	hYq8iw76qAmDIc9mKdO4/7ktO4A0cFiCRjPQ
X-Google-Smtp-Source: AGHT+IGLYc8zwdtfmLaEsvbdDcjtt1ROPr3PJkWV4l0eqsn4p4lu2DNAkyhTkGMvz1D3nRQo2igqow==
X-Received: by 2002:a05:6820:1b92:b0:5fd:f8d:3870 with SMTP id 006d021491bc7-5fd1a77973bmr11258701eaf.4.1740536147732;
        Tue, 25 Feb 2025 18:15:47 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9410df0dsm523864eaf.3.2025.02.25.18.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:15:46 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH v5 3/3] riscv: sophgo: dts: add msi controller for SG2042
Date: Wed, 26 Feb 2025 10:15:37 +0800
Message-Id: <f47c6c3f0309a543d495cb088d6c8c5750bb5647.1740535748.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740535748.git.unicorn_wang@outlook.com>
References: <cover.1740535748.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add msi-controller node to dts for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55a..fef2a0e0f7a3 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -173,6 +173,16 @@ pllclk: clock-controller@70300100c0 {
 			#clock-cells = <1>;
 		};
 
+		msi: msi-controller@7030010304 {
+			compatible = "sophgo,sg2042-msi";
+			reg = <0x70 0x30010304 0x0 0x4>,
+			      <0x70 0x30010300 0x0 0x4>;
+			reg-names = "clr", "doorbell";
+			msi-controller;
+			#msi-cells = <0>;
+			msi-ranges = <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+		};
+
 		rpgate: clock-controller@7030010368 {
 			compatible = "sophgo,sg2042-rpgate";
 			reg = <0x70 0x30010368 0x0 0x98>;
-- 
2.34.1


