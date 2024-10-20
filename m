Return-Path: <linux-kernel+bounces-373398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7E9A5646
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4F21C20F20
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF41199EAD;
	Sun, 20 Oct 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lULRPdIL"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F7195980;
	Sun, 20 Oct 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453246; cv=none; b=jrnG9348PgEt6MVKwgXmOUQumjHTcBjo7dpkb6lpsYIodMkfErldFrmE5rkI5pBgfFlups/pCFr6Tod5hf0VcnCDTM16nYJ9STLVddUj8xmwpG+hvzzJwY+DBUgC6Jc9km0EsTOlyNSPFUgosfweW8i33Ve2e7PL9g2VFvwgxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453246; c=relaxed/simple;
	bh=y6S/vFniqdK8FnY4Owxt462kYlq+HMo/27OIQpdXFyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHBi9/Z1pWpp5z4Gy55760vSXIKSXyQ71kpKcMhue+qBNrdmHwcnEl/CkiaBt22SchzhvZOJm6JacOUX6OpvhdB+gDqFgE4GO7gAu/qlf+ghR0UQ2OFT+Pq6Hn4a57hpRhTf6jX9mGx/WiQigC5KhFBiAYsh48zSOMF7lq/i9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lULRPdIL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c8ae7953b2so613131a12.2;
        Sun, 20 Oct 2024 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453243; x=1730058043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbnDXxocaCyheHFI8hTECOWKPKoXgfCmEGz3dctI1es=;
        b=lULRPdILEfYpJGcHQoiuebKm0ukTR+vGxSDi1swTMXhwUFOcka9kF08hEsJEmIVbri
         GNC+YLs7lCTYZcZeYqa9dDSx+vdjeU/svkHgm/Ak3QvcLSk63/tC4Bb931h0mpF05I+u
         iQnPF8IIo9lpdzpXlK763KNA2REjE0LbChcPUVAuEuPwtzJaPs3RN/dBkc7q4dLtGwuz
         Ox3hmfutBZ6AG3AzMyGxVILQbDGm3tCbxFhp8XHHMjWuxv6b/B/S7CTlqdWRHAH5kS64
         FmGtbm9KI2GViF3Tl2Zk4hS6xSFLZbJS/n14vQGsk1s1KmmGjzFaCKf98E3ppXkBwUod
         nW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453243; x=1730058043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbnDXxocaCyheHFI8hTECOWKPKoXgfCmEGz3dctI1es=;
        b=SLL6mRcn+Imf+/9irAV3lH9VCiq26HiZvw68C4dfUTRx4d5amuN4DZgndpMdmweGP6
         wyyrbHXisYYNVc99f359pyBYSxmV1UDb6F76j1Eapq0AYJiywZbsLDWJ/jvqZxGiseK2
         +xo7B0vgEmA6gX89UOInCiH37QrfveDkrDeiidANzwMtWfKYBuYthhodo8+9TWMBF8z3
         aIOobDXHtSM+5IES0o+bQY/wpkE0TWxEb1oB+TS9vK8ebXJHw87y9TEgLQwNoIU+C11t
         VxmAMusO8fBlDb+0c1kKmI+oqsi7ItFz2NvH+mzPM8RivwTKVMtKy2nENWeWiVo0v9de
         ZSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaSDJYSoXG0R6VbFEBpPkMKgXYPNTrLzJONc3YPe6yJ471sKSTOnNEi4UUMWtmgaA06IOXUVaMzA0n@vger.kernel.org, AJvYcCXdLzwvqZoBa0V8+Tn0f+o+vnr1n7bYPnN3T5He2F9rHs6iNGLnnZhLzQ1Vt2WwViIIFJGKvAvRv3wzPyz7@vger.kernel.org
X-Gm-Message-State: AOJu0Yza72lsfMG3em5XfPlRKqghiUj7EX5UgwH9GVZgJl1MW88OA3VM
	Y19iUUMAClNOOlLaV+YethJg/2TQi7skyS/naoFlZWXoy6LfUy+y
X-Google-Smtp-Source: AGHT+IEjTtTGxSGdX0i2yMMew0hF21usnZjLRMotUlz/FT0METXEgvaxuYjPqd6HCeN4v3FhhksB5Q==
X-Received: by 2002:a17:906:4113:b0:a9a:7f84:9408 with SMTP id a640c23a62f3a-a9a7f849ed7mr252065466b.3.1729453242665;
        Sun, 20 Oct 2024 12:40:42 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:42 -0700 (PDT)
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
Subject: [PATCHv2 08/23] ARM: dts: socfpga: add clock-frequency property
Date: Sun, 20 Oct 2024 19:40:13 +0000
Message-Id: <20241020194028.2272371-9-l.rubusch@gmail.com>
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

Add 'clock-frequency' is a required property by dtschema. Initialization
is open, similar to agilex devices.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 65d04339f..5f4bed187 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -99,21 +99,25 @@ clocks {
 					cb_intosc_hs_div2_clk: cb_intosc_hs_div2_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					cb_intosc_ls_clk: cb_intosc_ls_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					f2s_free_clk: f2s_free_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					osc1: osc1 {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					main_pll: main_pll@40 {
-- 
2.25.1


