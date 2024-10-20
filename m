Return-Path: <linux-kernel+bounces-373396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D99A5642
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEA71C20900
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454F1993AF;
	Sun, 20 Oct 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj+lW1PF"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA97194AE6;
	Sun, 20 Oct 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453243; cv=none; b=rxvkk7zppT5GbH+hKhSw1BdrznVXuSzNN9g/sJmXK+Cl60CubpxzOHpe/2yri8ga0ttBQ/a3h1dWCafX4mf70dJjYW2+JluimFfiY9Jwyr6BW9AQO4b+YBrsQfDUCA6rNu4RBvfJetpd6YbApZ7A8NmnGjSAw/8pB0Lz/+cqF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453243; c=relaxed/simple;
	bh=OtMc8F1P0PTrSTV9GAwD2G3wO6F1jpiSdyrg5IQ28zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4IcadXDgMEMVgLQsLF6g5Sn4Iy/OP0MW3oHTItgg582kfnYOCzMmtgqGGu2VipWtrvRrBa9ZC2m9ujPliuwzPrG0bKwdcSw/Y4t7Uq/E2uRylkgvRrn9UzSIQd/u+QXiTHA1oBfFrDYkwuI5DioiHjp55QQt+izPkdDA6USd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj+lW1PF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9589ba577so519557a12.1;
        Sun, 20 Oct 2024 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453240; x=1730058040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zykG5xT9htU2beqODKL0ma8uO47wG8f6mRcFvD55rTU=;
        b=Zj+lW1PF+Rf2b7mGqMN0v9Igjl7ZrKIYIzMDzmoF8ULvJM/m5hpyNxPBO0E+jx6zBt
         FZJUzGIVxiiJb6BJ2zdiljAJ5f7BpP2vs7AD3mosFWx6VNRGe4fEmR64Wi+4UmWUDWlk
         qvX7nkJDcP/YRK72DPbGRdozKU4P5KtLzqlazMbVPZrw26cI39EyReHul2QnRr9XLaC/
         hXgYCYH4/1ogCwv2MycohUuYTzQhXdY96XJcoHDuK4CeV3pFdajid/l45crn8VdNPjic
         Ao0xtOccvpO6nlCPIyKBBPsbL+KHhBBUgOYKrAExw2j0KhGuFbYq2zBdtdCLFljq0AAi
         D00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453240; x=1730058040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zykG5xT9htU2beqODKL0ma8uO47wG8f6mRcFvD55rTU=;
        b=iY7r+ubmbSilXEkLvmXY6IoRs/tO88sBeVE111N3TBhIjySq2uCIp/pJY+C5LKrA72
         53jmPislZzodUkfwucx4JMZwQOElY5sp/lJdwaDbGs967MpYDlEi9bHMN5Zd78NLffGS
         bxoWvGr3h38MGKNtOKIrXEfHMDwBoHtr7EQNG6F9+fdLyB/12CQMW6ncrCLSmZKpeGFV
         4AJgJ/+sMKZlbT6BycRqUo+KvZKfm2wWnbwibQq0zGj5mJrNX1vZinJAkQJF6KlnJTGw
         EQLod+Tz/BEjnxOgdVBevD+dIxFlilbRk8/cwKbU8ToJZuUxGgsYPjN+KEoT8n5QHret
         7vXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVU4RA/cV7s2sco3wDofnhXbs+OoPoy8L3tL493LpSMyGjw58XhF9T8tevFiK1/P0/kbt11+BcJ7Vm@vger.kernel.org, AJvYcCXxo96JE1FqOliSRXuLqSIwaaDvfTzMsmTETzcsyIdsTeK8KqlG6ND1DZdFXQA6fNnKz4JpErLRFdAuL82r@vger.kernel.org
X-Gm-Message-State: AOJu0YxcD4zRSrq34sUkqkKqwuazZbMk/jEp0IJcsmvblEJn4FWQwuUn
	XmutspWPYPrV6mJJZaZwjqEp7tfC7UmSIWZyuyRqfvyziEg7DwOM
X-Google-Smtp-Source: AGHT+IG4jol5cTVT0VxEpWzwTs6pDZZiwMQXuY1u7NMDU1ZT0kvzqFRESig0dpSYB6tuCEztbDPNEQ==
X-Received: by 2002:a17:906:a28a:b0:a9a:8216:2f4d with SMTP id a640c23a62f3a-a9a8216326fmr231026366b.3.1729453239917;
        Sun, 20 Oct 2024 12:40:39 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:39 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 06/23] ARM: dts: socfpga: add missing cells properties
Date: Sun, 20 Oct 2024 19:40:11 +0000
Message-Id: <20241020194028.2272371-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
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


