Return-Path: <linux-kernel+bounces-383655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2009B1ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A2D1C2247A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490C17DE06;
	Sun, 27 Oct 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbP65hSP"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B417BB0F;
	Sun, 27 Oct 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039827; cv=none; b=IgdJLU62wdPwSFLz4lqv6CbsLsCzWDvW9x+eHkeKMqjQ9Trbkr6hNAtwgJqOGEp9OpGIygS92qvwNgWcbKBeufK9cjWuIDXc3ErK0a90lV+sP75zVIyIMGJ6mnw8jMXDiTMotzrUXl+rSzucdCZ0s42sGrFYlRW2lfi1ux/9Nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039827; c=relaxed/simple;
	bh=V2yl4lNntEuPEV0X2MVL+IE3GiZVw/y9HCOf0Pz1aTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFNe0Cp3Q7HvSq5ljobkXkFQtnkaUSmT/C4GH59hExxJ4qjPa+8PkmnAR4FVdrlxh26RR9s+mmfDNihKUMK00FSnVHlQSULk6k+Ce3sU5PtXpnBHT4uoIp9Wg3Y/8THYIikQlpRBsrzsH9wumvAmOJ4pwdUA4upWtwnazvsONro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbP65hSP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cb991f265aso606201a12.2;
        Sun, 27 Oct 2024 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039824; x=1730644624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wwdH5E3n/FKvtFIFoeUG2vP8wssuIiUjkTOLgVYvdE=;
        b=KbP65hSPNYKPV2q3ZrfosXlt2OgRmYglSwAVWbtYJ8W1FFd3KmY1/RoetFElVvanAM
         P+MHehjImvnoOVC/vNGrs9YPrXRmfCWTFgnCQpFCQYxE1WVOd3b06wvpJeCVOyYfYWwg
         8RH0Xc9NDFHRTmFZ9Z2W16+Hwg8oj8Xvgz4TWZ5UEuKJAZeI566RnyQDk061OYswb5jo
         khY80b73q2qW376vYJq/p+uZB6xrJVrw8GTYSbhyhJAQGWgO+eD/Nk91w8OsiyzLK9Qp
         ZZmBR69A162kRvhxTzXBOSpVDTtDzN/FcgM7NQQiiYIUWiqIJY1jyJvdSUL3rCtDmlOB
         dgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039824; x=1730644624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wwdH5E3n/FKvtFIFoeUG2vP8wssuIiUjkTOLgVYvdE=;
        b=hvaGSnTCkyhvZlwbQXZfiGrY1y9tSewqlx5y4brgMe7a6YqubIc5mShEg3kMBlmvOu
         SRqERKwpw7MYsFKOgzg7o6SOcwt3ukXdtZ4ftxevwzI3i86yKyHPTERn76TKP51h9TpM
         dNrQfoYHYITWEwBZFgRF/09p4oBApnw8H7SRgPNcwAvW1CM1GdPxAMOPSt4CoFcHUWrf
         6HctN2rPiv138oWHIr7iOeCRnupy7Gw1wQBxbHDOUomZDq0mnLzHR49ZyhS9WC1C9Nie
         /VjI9f9fboXkmXuzrUT0MvNynVzPFhd3yFFb378vcv3ulcjc9kMl0O/w4PSxqQmrNnA3
         WFsA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NC3TNh5tALBTsn9lFz9542t+3nNV0YP4+ui84VQPEnUsrrsssbtzkhFVm3Qab9iZNYo57M9ZqveQuxrP@vger.kernel.org, AJvYcCVJSJ+UJdYoo+XjAVEzRhIgxmm9Nb65MhzHnggfk2IcWDDyp6ilIYoS6zOaEMSiqOpR/eyzKjoxxlQX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80Uz8IPJC58PH3rElRkaA9Olp9ErLdEGvfZMuvDueWp02idZR
	UGj1Bj1FyO+RQwjz0YfUNVfFoZ+n6BWioaqQiuJhKUOzhgnnFXjU
X-Google-Smtp-Source: AGHT+IEcHq6ID7YTtz8muc3a2G7bHYg93FDPSlg+XYSAewEbpQvis45pEdsc308nxvWHdXiJyKN/gg==
X-Received: by 2002:a17:907:7f0a:b0:a9a:8216:2f4d with SMTP id a640c23a62f3a-a9de5cd2244mr169957066b.3.1730039823488;
        Sun, 27 Oct 2024 07:37:03 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:03 -0700 (PDT)
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
Subject: [PATCHv3 05/22] ARM: dts: socfpga: add label to clock manager
Date: Sun, 27 Oct 2024 14:36:37 +0000
Message-Id: <20241027143654.28474-6-l.rubusch@gmail.com>
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

Devicetree setup expects a clock manager label to be around. In
preparation of upcoming changes to allow for compatibility.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 90e4ea61d..7f7ac0dc1 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -88,7 +88,7 @@ fpga-region {
 			fpga-mgr = <&fpga_mgr>;
 		};
 
-		clkmgr@ffd04000 {
+		clkmgr: clkmgr@ffd04000 {
 				compatible = "altr,clk-mgr";
 				reg = <0xffd04000 0x1000>;
 
-- 
2.25.1


