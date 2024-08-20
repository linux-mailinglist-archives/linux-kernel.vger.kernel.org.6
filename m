Return-Path: <linux-kernel+bounces-294144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C89589ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12C5B234C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08274194138;
	Tue, 20 Aug 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXVPtgty"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F7191F72;
	Tue, 20 Aug 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164715; cv=none; b=mkVqWbdpWRFM9HiSLuENbLWd/ENOLMCPt9asMMD4dE/6AN6BcV4jl1y8g4mg5IfsbNGCzt7kfEdVgd3W0JcyXjg3cF2KJ2fp+glDWlvEOXEcPsv9kQLDbX27INeRZ+83gly3moT0Gw7EN89oUeuMa7qeTmjZk32ldZ1BkicSTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164715; c=relaxed/simple;
	bh=o+e6mZf6wtIb/qdtsdAqCEiKnYEcfJt0EJnolihIkt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jc/beLByZ5Nh1UXGxT9JbQg98qK8B4fsvTa9gTFHKPALTo1EACF8gJH6EklcnS7SD8j55cBbsxLWtbm7uwDU9qC8XCMYvGJUiA9mvMFYz4f+EO6qjsGWkDBoaiQ/5CCRqejASGYNJrj0WaepALh8Sdm/d5bL0ftvA9dN5Px7IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXVPtgty; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso7330291fa.2;
        Tue, 20 Aug 2024 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164712; x=1724769512; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt9Va+56pU7ZDhXb7NcEk5Z+FfkmKspU+Icin+0hIu4=;
        b=HXVPtgtyfhxONT/+PUO3PrM/gYe7pHh7NlTrPveihy0r5/UbKSMCNViRd5W5fN+DsF
         pQxRyIfggWiTVrlAJcm1KN86VuQ6sSvfu3PFOlyNG0sEve7oyYCQGT9oqP9Z3Us0Zxql
         pY7PwaSA5cQBzBgUQBUzTfIZpV9mqay3M27h3TFgjCqOJxGP/zO2jtPbJZlmqtQiKcIn
         kfnhQvqSQzQ5o8eIZvdxdr7luVowTOubLUKtpjHNXxlOI5kqqHGzIIQABolWLFZqPGfR
         nA1D+RzeeBKl+j4ZbJzVwHJbKmJaHypauOW+C/8ITyjUDPoXvupjjxtgAYDxABLH+bVW
         qMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164712; x=1724769512;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rt9Va+56pU7ZDhXb7NcEk5Z+FfkmKspU+Icin+0hIu4=;
        b=ssiWqDKJPIkY+Zzm0J49z7mtruNFui7qkM+HsK2eJ/Iv7eNZ5cDqhJ81he+8OQaPhS
         ti8lbsmP8Jx+HDeCfLO82wYE8lLEy28AlTYqjBtXBVkdbt8geoDIzM2QSUIgm/HQVHTr
         Vy/BqScyytnvv8WKRMR/jqa+WbJWEVB1SQs9CJ42j10q+cf7prtDEtDxcRFZ0P87sS7u
         RXLZPF6HE55d3H94GC41UsiSQuAJb36go2Ux9uk4W5VC3kbUGOPXsF+Z7ODrBXnFBTu3
         Ax2Arv0DMtmT3GmQk7W6f87gi6OIs8YJYvFMpYkNfE2e1w5kWZq5bhSzQyxyQH6wh5yT
         InEw==
X-Forwarded-Encrypted: i=1; AJvYcCUO4/jdEJ41hc/khGtpZnjtf54mEgIfcGNyyRpujjWizyVHIYeo2u9QLeTGhOLbNIAuf7tPSDzePF2RJLpKikG4H0saXMZkSCCBL7HA
X-Gm-Message-State: AOJu0Yz4l0O78ANQE4gAbMY34eARa1JY5ZD1eYEuv2CJ9zeNbfzIbhts
	9QcgUj+sR5hlIgEJ8dZlnzrVkI2YCNH5Cx9M06w8i8GBarMgmOcp
X-Google-Smtp-Source: AGHT+IEPjYZZ2oXKTRwJNy0PcSnF6FIti7QGrLcbGHfPwDUeSiz8QXt8FWcfj96E0QZoSJs4Ih5dNg==
X-Received: by 2002:a2e:4e01:0:b0:2ee:974c:596f with SMTP id 38308e7fff4ca-2f3be5bfe54mr98249601fa.28.1724164711158;
        Tue, 20 Aug 2024 07:38:31 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-154-163.multi.internet.cyfrowypolsat.pl. [37.248.154.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde3edfsm6807548a12.29.2024.08.20.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:38:30 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 20 Aug 2024 16:38:14 +0200
Subject: [PATCH] ARM: dts: broadcom: bcm2166x-common: Increase apps bus
 size to fit BCM21664 GIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-bcm2166x-apps-bus-fix-v1-1-0478a3227e86@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFWqxGYC/x2MywqAIBAAfyX23IJJiPQr0cHHWnvIxKUIon9PO
 s7AzANClUlg6h6odLHwkRsMfQdhc3kl5NgYtNKjslqhD7sejLnRlSLoT8HENyqKIXlHNgYPrS2
 Vmv6/8/K+H6rJ1thnAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=o+e6mZf6wtIb/qdtsdAqCEiKnYEcfJt0EJnolihIkt4=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmxKpklbjLa0VDiwZb6ueoWUyzT9lHqNQUauloz
 Tflf/1SHjKJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZsSqZAAKCRCzu/ihE6BR
 aLqhD/9qV8z9JmtZVKFrDv5tJYwO8Nf4+jrzeFXthIM43Ownc+LbR+C5o9tRQ9liW0CXoMRV36h
 LFnHqE+/JG80DyTrpseSnstFctKFRHse33KfLy8NeORok0HvAUQ/nzdjgRRKEXKWUPsN8rkRnne
 I4M2OGd6a4R4zuGpDhAwop9zJsRJmiEz3ocid9MLK05wIa/VwGt4kOxNvebMNjWdVvkZwDw1ebz
 ocU/J18QD2KUOeIqrpUR2Via85E6Que0kYfinVHqW0p0VA98rRlFBueWtIB2zAqUeLeYwsLhjIl
 uytwYFJRKtW5j6/S7Brx7y/MwG+LLODADwXCyLYTtjwpJiA8RghNDzDj+R9ajyskUDGDbqAjeFf
 hgJtVgkY0FCMx2Ot8S1HWiDcZD6pQLAT/rfeLQqiBh6xmpymHhzOuRzTZ2yzUc8rh5OOR7sDeQP
 26N1vYekWXbuNLmAWJtLsoEX8JJB6J+gOIODKm9SmbIJse5TqqZxouIXOfxF2+venYv2nUVjn8F
 /E2DycZ40FWVMIVzc+ACvdtUgyEruAHjlh1TzZuHxJATaF93xdo1PzftnYOfDnWrBr7R0tjDlQ1
 l0taln6xwSTZp+vIvSp5w+D2ml3tAwtduuwiTvkfSZzLctlbxB/hiYg9+SXJKLG7moKpQf373Xq
 wLvhhWRI3WL7ZPQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The BCM21664 GIC sits at a higher address than the apps bus currently
allows. This is because the apps bus was inherited from the BCM23550
DTSI, where the GIC sits at an earlier address in memory, and the DTSI
wasn't updated to match.

Increase the size of the apps bus to allow the BCM21664 GIC to work.

Fixes: a5d0d4a7bab5 ("ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BCM23550")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
index 049e18b61ccd..87180b7fd695 100644
--- a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
@@ -135,7 +135,7 @@ bsc4: i2c@1c000 {
 	/* Apps bus */
 	apps: apps-bus@3e300000 {
 		compatible = "simple-bus";
-		ranges = <0 0x3e300000 0x01b77000>;
+		ranges = <0 0x3e300000 0x01c02000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 

---
base-commit: 44ccb92bc64a6f92666e69c7c30e5713758641e2
change-id: 20240820-bcm2166x-apps-bus-fix-0edcfbae8dcb

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


