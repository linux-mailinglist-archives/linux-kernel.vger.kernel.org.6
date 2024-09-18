Return-Path: <linux-kernel+bounces-332764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441D97BE88
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E06C283686
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073E1C984A;
	Wed, 18 Sep 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="SCzs+7UY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59F1537B5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672959; cv=none; b=Bdvb2LakWso1BNoHWWeyvu1jMn+nKBtN9Ioj+Eo3Qfb7f5vvq2lhwENeOFck5r/qM6mrOFAXKs51dGp2a6X5078G8Ka3zoW0r39De1uohFLZIjIoY8Z2ZxBG6QZ/9xCQX9fxVMqqYO9/0H8Z3QnZSr9qpHDXzRkwpSgoT0g1gq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672959; c=relaxed/simple;
	bh=sH+f1A0ePYFOrhGXNxe51D0lD77SGlyNw3YnEZyO0u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bclSuLrCgWwCH/DpirjNshmly9eLmyNY7oQGXv6WWGcGjSwCeDKIWb1dgwcJoGUgIktaEMstZjZdjXLzzow38kPr+dMdQEhQPANofpzODaE5cPsb3H8KyNHyNwKODaIb73U5c0UvaWu1aKKPE0RcVbd3u2ox4RW25kwug8mrSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=SCzs+7UY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d4979b843so946899766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726672955; x=1727277755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
        b=SCzs+7UY+HhJEf1YXoHubJEv4260F3YfI336xN2TTZpSkEu2f36XCvur9+kPzp6iXP
         avki0HZ7c0jCWI9ynE2doc/Osw3XOHJQ+t4KUp96bfPvmCDIHO1x4etvhN677zdhaet2
         BLt/empIIpZLc5v5qQjW0Zks2LCAYgDqgvn012QXL7CfhEfKaYlAq80YCTcprJPy1mcV
         hdhsU4PtODHVVosFEBQ4/r72hrLn501A7YIHSSuU9sotBjvWnUnk1Xfbdd4UrHs/3mjA
         mrasjjkWjMzquxa+O87JK/45abAKq7w09C7rXhQg2t+AWcY4HhEfbN9LNX1OXbTIuIDL
         y/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672955; x=1727277755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
        b=Iuqg0Xs8FbYOUCVw8fhjbFLdmMqtES/q0F6C8SL8fLDc/SpBGTpfBMe3+J6af6/Z05
         zCBsGvjwi6fjVcPwWGUvVam6ogGflU9dMbrH1URdjKcGY6GAv3157Or3eFXLZbTe1LUl
         oPron4H8ExdW7SJfnwZb464O/WQlL9CJ7mDA8UX3CpjLX9F7zneVgK4FTJoV1GdIz9Fs
         LHzDBbirntYBFlXqxga7NNO82Dul9HbYFftVzcCgvp80tGtIvp0QvRzLjAnswJjOwiEx
         SdFwBkgj1mWU82bdIVIwf6QoyBDkx8W93dLFlGJeTi9e5iKBLc8j4+pydAo7UXGrI832
         dG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/87ccjUQMuWqIGmdWRZzC24PuYGkJMIrWv6IxVAdbJorIiflXhmb3572dceH6G573yTHHP1r6CFInt9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgWTg0bl51bH1gYIZ/XIXE7L5dPUyz+KeduYKDb9Md7WXcLcc
	BzfqBvmiCSUwXn1+PVwDexJMD6kRXDxExXOz6TWU+6AFRiMuCK7Xwe4HaJMdsT9omWiI8NfhpWM
	O
X-Google-Smtp-Source: AGHT+IFlYudtYxYJqhpxsjyFTNhw4sOQ/UCVqJeeGZhxxyWT1HQQB6jd1nBpJd13J68HePHD5uGyAA==
X-Received: by 2002:a17:906:6a1f:b0:a8a:7062:23ef with SMTP id a640c23a62f3a-a90294d5249mr2236675366b.32.1726672955429;
        Wed, 18 Sep 2024 08:22:35 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 08:22:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 19/35] arm: gic-v3-its: Rename objects
Date: Wed, 18 Sep 2024 17:20:23 +0200
Message-ID: <20240918152136.3395170-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code accesses the gic-v3 node, but not the gic-v3-its node,
thus rename the objects to clarify which node it operates on.

The following commit will make use of the gic-v3-its node for real.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 2cc0a32f9d..22fa46a341 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 	int ret;
 
 	ret = uclass_get_device_by_driver(UCLASS_IRQ,
-					  DM_DRIVER_GET(arm_gic_v3_its), &dev);
+					  DM_DRIVER_GET(arm_gic_v3), &dev);
 	if (ret) {
 		pr_err("%s: failed to get %s irq device\n", __func__,
-		       DM_DRIVER_GET(arm_gic_v3_its)->name);
+		       DM_DRIVER_GET(arm_gic_v3)->name);
 		return ret;
 	}
 
@@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	return 0;
 }
 
-static const struct udevice_id gic_v3_its_ids[] = {
+static const struct udevice_id gic_v3_ids[] = {
 	{ .compatible = "arm,gic-v3" },
 	{}
 };
 
-U_BOOT_DRIVER(arm_gic_v3_its) = {
+U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
-	.of_match	= gic_v3_its_ids,
+	.of_match	= gic_v3_ids,
 };
-- 
2.46.0


