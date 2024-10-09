Return-Path: <linux-kernel+bounces-357928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4B9977EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF0C282EA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233861E3DDE;
	Wed,  9 Oct 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apiDZ00b"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331901E32B6;
	Wed,  9 Oct 2024 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510673; cv=none; b=lzmipT9qEws11S2NY9kHi4tlK+Zmjz32viaj+pNUNrFYbHPFp5L7284C+nVHiXSGlK7Zyc4ecMqYydo+vBakoZscTwIXcVgelF3JQgfZrkDjG6rmH2w7/81lcXgjQ3vgyfbyuk/hMMhCtPmbp72ETvTgEpS4penTatUFweAVMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510673; c=relaxed/simple;
	bh=ONBNSlAlXIlnWIDU8T+Xm05D9sszY9YcES1lOpBMQWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN2LcD6UYmmG701MUUO4hKUemTW9uSxuTwngiiAamyr4DgKGezNHkFU9Oa4YBY9BneygA3TKwhB8tFsco5kE68qJmnscov1pWiqNrFjA7Zj9DHCZyXbxhjdLarP30OgrYnzIhP/p6fNWr135Gi7/yVpeEAIY/dlirs1aPhFNPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apiDZ00b; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db908c9c83so164087a12.2;
        Wed, 09 Oct 2024 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728510671; x=1729115471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/C0CgZTEJhSuNYzvbdQeNWumuAuuIpwzCV8FmhMBfQ=;
        b=apiDZ00bitHwV9d2TwzHM1J3hqJxjPHLu4OV8pb0/56bXOyJyuxgMIgBUh08UOLxf5
         llwUOdKcTX78glpq6+rUvdlumcuwRBYb0mhReOPnNsXH6TBPrVrMSYrsGyAbVZsz9+rn
         +xB4my5MIb7lUWifEbSWPXV5ttf60AgfDqfqtw/u41mmQfg0Masi+zxox4YWZvCc3AGH
         kdoEb137DkjYkJIDSva4HtqKsNTA6FCrH0bJV4d/CQbBpix2xiEApcO9oc+0V386lcDH
         EgzfbKmoMCro2+Yt6XNkwGGivh3h6uPu13WqkcHPVuKg5Fhp5+bDggdZ+sVVYA9a1rJV
         Wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510671; x=1729115471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/C0CgZTEJhSuNYzvbdQeNWumuAuuIpwzCV8FmhMBfQ=;
        b=W/Prmm8ejRnVaOZUwmST6CdNJOCU0/jMhExq1anr5rhDsgZaXOeRTRJwDU2kg8XKqh
         UWHweaGf9j0b4OiYJK5nXwjWPwk56afGSIuoJKqsk60WU0OsxRS74Bw7itleOBjlKm6z
         PYdxkJy64ob+dpJC1O/TXvcPA4PSQkWuvYv5dfOsKytpcg/Wq3pPI/wa7TCvv+sSXzlV
         zIk9CU+5N6GHUGQV+0BHHAKYFll2MeSCu2WIHb+V/83biRos/GAQRfMXe4O9mMp6evZL
         VS88kzMONOhiAXd9NwL8MrOtYnXMfZIOL3zdQO827I7s8mPnQquefzmBa3VTHa8wu/6F
         5QDg==
X-Forwarded-Encrypted: i=1; AJvYcCUaER0SHcCVxkYKMT9OJ9bNegKveqdY1mA89yBB/zZ3kNz9DY5R3tonwngINcuIDQUwJis5xtbsktuwc75Q@vger.kernel.org, AJvYcCXvH8ethLZQyNY1N8VIiIZiLBMVI5ds9etVEkllkeUzx70T5lYp28vg5+zK0Pt7OfI8uT9JCIoDQ5Dv@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHEh2pyQbPMTAfud6gVmvsLyK8C8taproALvLzCsWijBj0Au2
	eRXf2u9s1mJpf61ZmMz1lSiCr8Z00wm5nRDb0qQLlRdPLRXY3suK
X-Google-Smtp-Source: AGHT+IGtMH2k2lnk7wn24iMUNlbma/K9cYS39ZHsGCNlcQSd2U8eAqCmfGJhbRyIjqI6KfMytGDfQw==
X-Received: by 2002:a05:6a21:6b0a:b0:1d8:ae90:c651 with SMTP id adf61e73a8af0-1d8ae90cc40mr1302204637.47.1728510671574;
        Wed, 09 Oct 2024 14:51:11 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833a95sm7651847a12.52.2024.10.09.14.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:51:10 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 2/3] arm64: dts: broadcom: bcmbca: bcm4908: Fix Asus GT-AC5300's cferom partition
Date: Wed,  9 Oct 2024 14:50:45 -0700
Message-ID: <20241009215046.1449389-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241009215046.1449389-1-CFSworks@gmail.com>
References: <20241009215046.1449389-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the previous patch relaxed the BCM4908 partition DT rules, it is
now possible to have `nvmem-cells` directly under a BCM4908-partitioned
MTD. Make use of this in order to refer to the nvmem MAC address the
"correct" way, and pass the DTB check, for Asus GT-AC5300.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts   | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
index 2a0d4ee3bd79..e4687176cffb 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
@@ -185,17 +185,15 @@ partitions {
 		#size-cells = <1>;
 
 		partition@0 {
+			compatible = "nvmem-cells";
 			label = "cferom";
 			reg = <0x0 0x100000>;
 
-			nvmem-layout {
-				compatible = "fixed-layout";
-				#address-cells = <1>;
-				#size-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 
-				base_mac_addr: mac@106a0 {
-					reg = <0x106a0 0x6>;
-				};
+			base_mac_addr: mac@106a0 {
+				reg = <0x106a0 0x6>;
 			};
 		};
 
-- 
2.44.2


