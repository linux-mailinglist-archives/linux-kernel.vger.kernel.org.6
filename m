Return-Path: <linux-kernel+bounces-340085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140A986E72
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05461C21A27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646E192B76;
	Thu, 26 Sep 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Tn24fbbT"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771D13D896
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337782; cv=none; b=DCztw0XdLNja5VPCrBx2AXGXngKvUv8F0lT5RcFoPffldh5KhR9oJmC38F1CV2662GZ17Vn9o/eVWP1k0WYEg9m/4PKIwMJhpf9BFQnciqaEi4CNe3KOD5kP2gFsh+6Z4gGYktkKV7vNneg4fwlr8XGUkQSigoecxbXSmT7iNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337782; c=relaxed/simple;
	bh=sH+f1A0ePYFOrhGXNxe51D0lD77SGlyNw3YnEZyO0u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnJdel70QCp7Lo3U0knPA2iqDaEBgT+hkELvNxphWV10IgGCzIeGbY7152TPCjbStm+E5ciJvktzNLTvdDhYgbdXpumvC2bN11y731zF85dToAwgoukAjOZtPPhnzsFhswTirrjPeEl1AvS+Ol3bdOARrDR4FtISOBEDnCrkjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Tn24fbbT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so287735a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727337778; x=1727942578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
        b=Tn24fbbTitXN6VkvIcKg5ZLS6kEghQCbY6z+w5ErCKmJAwGu5QaUPsz8BB5UuWRqPB
         9AqStdvO1l71IjSrO/F1qH686qqmgOv/8qPjA82TsZ/M+otteKnYvEZgqZwY8gDMs/VE
         qLG1gCAitp11g6Zxij6Jppzwz2fyTSQ+vDQ79Nyea6d56iiOBRM99jDlBaK53Wx3IAvM
         wCO8a7n4wZAKluG1tBz0sxwXDk1KlGos2FAiRPloaHhr0GJztpnW2z8aGt+n1EvVOi+8
         Iz0jOWmcvuJcPJS0fkm2ahkuB0/WYLFMN5u5SM0wFkru8SO/n8rIpF4GBCT301sHKbax
         qcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337778; x=1727942578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/rIYigK7VdzQ4KUqwavZH+9L2ud78EouKaq2G/zCPw=;
        b=J6VVNPZbBMNiD6EVFJ2S4TnVFnC+0mZo5ZMt9AmRLwKXvw8/rPwloQGdwsy72GO9ok
         m3Uu8Ap1sa0BnOe0ULa6VJq1DoMAN3D8Sg/TqLBtQEkeEccXqRln4Gd0mWp5V/lmia2E
         +ZsYJR+dtVgv0JTBCKjc+TwACApMDie0fUT0f4k7kX/rPPU8RPozV0ofPS5lnMweN1D3
         Dhn4d6budAfY84tDmckoTzkhRihyzEUKKA5gR5Bx9M354/uANHpmD17EY5NKFMjNegRV
         bn06PulXfz0jeB2BF7Aza7JoQraqY9ULMtHhIJj+ZJLtMzQGboBEw2BADoH0cvI0XE1h
         lK1g==
X-Forwarded-Encrypted: i=1; AJvYcCX8/Wp1qmzafqj++ZuRPG8Mw263GOVONS3nP0W12+V6lH5+PRHLcN02Suei52t2lxawoeidI9JFImri7P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/rx8bOCohNiHvxRg+cD13bfzJQE8wQzLJjUzfJ6WoZIkq3x5
	pvtUi5aSwj17fzCOW+z/4dGbnHjcsdl2U5ulp4AYi8IR90mUt50vn3gAt9NrlM8=
X-Google-Smtp-Source: AGHT+IFxmvq4gdw15Y1EfNcez0Fa1gfnHsOaeboDzDvRbMu+XOhAWCh7m4vbwwVKKXnl23r6QNDNsA==
X-Received: by 2002:a05:6402:34c8:b0:5c7:1ef7:8a13 with SMTP id 4fb4d7f45d1cf-5c720592f9cmr5964833a12.0.1727337778566;
        Thu, 26 Sep 2024 01:02:58 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:02:57 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 19/36] arm: gic-v3-its: Rename objects
Date: Thu, 26 Sep 2024 09:59:07 +0200
Message-ID: <20240926080021.148031-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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


