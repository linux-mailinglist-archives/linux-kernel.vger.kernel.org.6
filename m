Return-Path: <linux-kernel+bounces-436874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE6E9E8BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9D4161741
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFF214A71;
	Mon,  9 Dec 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf6P2Fe0"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EF214A6B;
	Mon,  9 Dec 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728355; cv=none; b=DNLQocRc/CWzwx//7U5pdpTlFvqoUw0d+j0Tyc0ZjYZHBsVNFoJOSge94z+XkYf60QULoWDi73UiHjukU1B30S1nyu9KUSwubFgS5URlGdUZY48HplAFxsc+01KT4SdizIB1zFK69dpIhHu23TBtIaOol18dFuMsVpuiHWPct5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728355; c=relaxed/simple;
	bh=3UJWlBeu891sG174aw48+XCr5dZyD574d5GCBGwqEC4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csyOIfljJ73tn6Yow/ZFgwuqUJ9JekMUBrXRGFcHHFg45XHhzfazW9pYDVRnS+Bz+4TDj/Bsdo0JU64/XdXlo1MnEsjcJNwSJJrEvaI0yWSiSGb/31PHlE0HdxkOTrxTNlTvgKHjA7FYUadbuO/opfmpohPr1N+xyxGAnikrDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf6P2Fe0; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb4da24f3bso422361b6e.1;
        Sun, 08 Dec 2024 23:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728353; x=1734333153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBYCDLmiI5Ul4WtnczXeDvi2MdVWE89AendZ5YRaAK0=;
        b=Pf6P2Fe084Bs2GjWdGBH2I6TvYXk09oUR0YDXLOQlgWxyx+8PmSnP9T/hw/OSVokX6
         rmIN7LPEDW17VScPfyILooAesec44vJOpr6Ti6dEjdR6HcgNn9fc8jjSCzga8kQ0fwM+
         FdD850PMtv3E/VM6oJh2He72wEJDsIV5UEYz8ifx/4FwYRGhmQF8C9HVH51E83y7wtWH
         mcnRjaRgLgA71hiqdpzEhfPA/Ic08C00Nc6x3gihw62e4PH5h5dV20uYHltS5QDeTPIX
         +/xsLTmtApCzBXgsAXDlc91CpG4i7EpRxuEb+vgTK/+DAw30GMjFseFzIYYipCbW+o25
         hw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728353; x=1734333153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBYCDLmiI5Ul4WtnczXeDvi2MdVWE89AendZ5YRaAK0=;
        b=wvM1G4HeGSHwdt8Oy70cX8SFrVAoLntMZ6E6xhygxiDU0q3iFhdXvWcsdSLjkJv3nL
         /NzpOWj2GL4T2C6taKYb3jXurFdDwsRMoQKeBIN8Xr0bUR7OCdACIBMvQTMNLgDHC0lh
         qNIgD1SedGEKAxPuE6OYaYpzYwu/8XFwaDf/+LtPo43rm+6Hd0EOQ39ZxZIeglOWP84s
         qFOneZ8Yk8KaT/p9n4IkLqQFVKCglbt2DVd4G95luhHTOqYIpVr/9dxhyLoOUQtQnW06
         qgEQI5QOoDjhsRX1hB2b7GWJxLD+ZyrMrajKucGY61x558rP3YEGxMWi974iqoaszTa0
         /KxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4W6JAJYcpaC6rqsvw3/XkL6jsI1khSoW6uvzWgwC7WElJI1uFjTZ3A5oNhCeeFVgjIOm/OZ9bO6URVX12@vger.kernel.org, AJvYcCXSH9PHHMb8C8KpizBpPMrPb9fpj8xdfWet8P8ovi496NssZ5TOAUbpf0I5cTiu9bzwQ+B3bzAPfN51@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHUNSc/1tYy8vg2aIE7Yir6RAVHf9wiPhjfmrAyBzjnEodsuI
	HcjYyYuqyCkbMtqVtLiqSlh5laFTZbOFq8T2VBPu3DUv9kr7Dyqg
X-Gm-Gg: ASbGnctFS7zSFtZaFXfswnhE1W8Duuj/mw4TCGZFjDm8lOm/r+0fdQRsIDj2jNtYA4a
	8SvbUfL2qGgFmhIGWKr+FuopeexiKnUTY157LwWWtno0y5ADTa2uaGBAR2lpQtXXkEZQv5ApPXL
	KyLSnIzYVUxPM7oX0S0OkY9pjtgaMLNamqKoSWD5ghiLQlTeq0BxUF11+rzRjKgccDJ8D0lQ0bQ
	dctw4PHLyUuBMwKrq4B9F9kiOdAymN0FvVTGoN5afX2J3Gynnwg05jLYG7Q
X-Google-Smtp-Source: AGHT+IFxb8pbBX+e/TYceKryXxdB/wQe+lQAG69/HoUcIQJsTXDcI32zHcg1iLxG5yHXc/sDK/0Ojw==
X-Received: by 2002:a05:6808:1802:b0:3e5:f4f9:3280 with SMTP id 5614622812f47-3eb19c770c5mr9478218b6e.10.1733728353439;
        Sun, 08 Dec 2024 23:12:33 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2793249e8sm2011256eaf.39.2024.12.08.23.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:12:32 -0800 (PST)
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
Subject: [PATCH v2 3/3] riscv: sophgo: dts: add msi controller for SG2042
Date: Mon,  9 Dec 2024 15:12:24 +0800
Message-Id: <ddfa1512140be756c0432084e18d5d29b1f653ff.1733726057.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733726057.git.unicorn_wang@outlook.com>
References: <cover.1733726057.git.unicorn_wang@outlook.com>
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
index e62ac51ac55a..bda49a398daf 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -173,6 +173,16 @@ pllclk: clock-controller@70300100c0 {
 			#clock-cells = <1>;
 		};
 
+		msi: msi-controller@7030010304 {
+			compatible = "sophgo,sg2042-msi";
+			reg = <0x70 0x30010304 0x0 0x4>;
+			reg-names = "clr";
+			msi-controller;
+			msi-ranges = <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+			sophgo,msi-doorbell-addr = <0x00000070 0x30010300>;
+			interrupt-parent = <&intc>;
+		};
+
 		rpgate: clock-controller@7030010368 {
 			compatible = "sophgo,sg2042-rpgate";
 			reg = <0x70 0x30010368 0x0 0x98>;
-- 
2.34.1


