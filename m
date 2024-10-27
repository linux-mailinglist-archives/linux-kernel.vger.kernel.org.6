Return-Path: <linux-kernel+bounces-383656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CD9B1ECD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D59281AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0018132F;
	Sun, 27 Oct 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt2jTpu7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EB17C7CA;
	Sun, 27 Oct 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039829; cv=none; b=higG9QmXRR05t4IQVSgRzg3UZkKrEzMkBvkq/QtMAHYTaAuU7QnosJSgbMw2N8WalXd864euVBOL52QTMdhxYsgpLTSuSzK/nmo92KGFv+UjoI7n0OKs0rBe73v4Xj71ASD4WTaiAER1fnMnaVlICMuNz2FUWGHgw1KUfUfySkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039829; c=relaxed/simple;
	bh=OtMc8F1P0PTrSTV9GAwD2G3wO6F1jpiSdyrg5IQ28zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzPWb1RYZxlTnuGtFgjBE7EoD8pgzu8WT6fYkR+BlgYHmjlEFsDikndSlPSX9nXCvRQ1qTTSq3o1Uhu9Eb3m5qp+tVROJHgDZeDYq0U8yMQSgG05ycWk5E8IcenNtBmg6EApE6XtNDfkgJZ5NTnjauL7TW3rVBEqCYBCSeTR4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt2jTpu7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a966de2f4d3so43926966b.2;
        Sun, 27 Oct 2024 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039825; x=1730644625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zykG5xT9htU2beqODKL0ma8uO47wG8f6mRcFvD55rTU=;
        b=kt2jTpu7H7Od9SE9S/USh7wVyhJiPO5JmfuKfbb+Zp/NgmAvg9RDyVD80rtlO9Ifcd
         BMOUouzdCZDfLBOCBWAixSvRpgf47gYAM8BTa9cM1i3cCEFHrdrf9+9vJ7q9uwODPPt/
         N3AntTyNHJQLc86O+sitRdxXK2MiuEfHyrqq6ffq27yD0aQMU0y9qvMWjnk3vWA1U0/i
         iutbjeVaWZATla30aHbr7wIMpR/Yo4FuBct5EC/EbyZFcuT4sx9CoiDQytclfrw9aFAy
         CjeqU2123Mdwl4XYWgxF/P7mZXWkb+uXqb751sfJ3QmZ6HgpJd6q0eN2Fg7CvdTP9UOE
         4MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039825; x=1730644625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zykG5xT9htU2beqODKL0ma8uO47wG8f6mRcFvD55rTU=;
        b=koiArjZBz5WE+YZgdinw2UBsUPFeghAwczg/xH/JPmu0cTlTEiiNQXBs1WdAIlZfT3
         1+GzNh1t4bsHUTdTXma9JwsJ95x3x3Nj8ZZA1ltnYYKYE53XIVu9AKiWSIyn5YVw6gRC
         4+sDoETr7jPvKm8N6kaXK/jEqk21LyxYJ8Oft3cB4Ec5Z+i3aVBnPHHyo0PypYi+/GFY
         NqIo5ur90GwETlzI6tE7ITb8EBJsmPyGxFQFFqDs3TkniQ+9GPZMrYBC1X38CyKPTfGC
         Up4ctnE5qfQqq1p8mXZ8YtANvckawgRsFjAdvskVjl6y1xtjW9bylEDl6PmpMYePrOyB
         tprw==
X-Forwarded-Encrypted: i=1; AJvYcCUP/lKNZ+K/U89B6yv5nz+Y+U2P0Jdf/kG009IK6eduPuuE18+rtvhG2L8udozXOuHh3QHg+OR7ktrVH8PP@vger.kernel.org, AJvYcCX/Mv5zuzAQizOVfLU7DN1nKCgjDcTNdqcI2pBbyWgEBY+XdhdS7MuFSkM3WuUu4eY76vRSlGHVDtSC@vger.kernel.org
X-Gm-Message-State: AOJu0Yysom9zc4rzyjC8mC7LWVyppBIiypqHa4Vgqgw75bsqgSg+ipyR
	kAYX/FiXceV7QXaxwHBm0C8NIKGXvCYgKBlsfDVnJngmsY3mMLqL
X-Google-Smtp-Source: AGHT+IG80f5DbgfZu1EssjWcBVSD7TKjNuwHRHvQM+3EHA3QJl8++utETn/JSBaSgAeMJJ6bjjTUcw==
X-Received: by 2002:a17:907:7248:b0:a9a:6700:1ee5 with SMTP id a640c23a62f3a-a9de5f04372mr189557766b.5.1730039825333;
        Sun, 27 Oct 2024 07:37:05 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:04 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 06/22] ARM: dts: socfpga: add missing cells properties
Date: Sun, 27 Oct 2024 14:36:38 +0000
Message-Id: <20241027143654.28474-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding requires size-cells and address-cells to be around for the SRAM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 7f7ac0dc1..4b19fad1e 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -684,6 +684,8 @@ nand: nand-controller@ffb90000 {
 
 		ocram: sram@ffe00000 {
 			compatible = "mmio-sram";
+			#address-cells = <1>;
+			#size-cells = <1>;
 			reg = <0xffe00000 0x40000>;
 		};
 
-- 
2.25.1


