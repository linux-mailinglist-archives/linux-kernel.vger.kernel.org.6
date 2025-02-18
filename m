Return-Path: <linux-kernel+bounces-520275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C2A3A7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E6D173EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75131EFF95;
	Tue, 18 Feb 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abzq/OKl"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCB1EB5F1;
	Tue, 18 Feb 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907706; cv=none; b=G7lBBSnmf6TYRwwZyYmyFlsaeM4IIXV2o+N1wth7AsZg3qhcu1FZQuDKfQHdjhNvFZ1yoUfWtpnlcOo/vfZPX+cGWRcViyQucKiqMqhKaMmv+uBBrORQw8p7qajXTyKIZQV3uVSxcNX16K32NgBpF27BJ7PejZQpChxFWX3knfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907706; c=relaxed/simple;
	bh=RLmgcRuN/YfAviS8slgoRb65o9ZeCPFFMuOw2ui/89I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+59cgA5a5KCYtE8mVC2npJzcLFk1hxLxDXLxgJcT/B+qMSU/9ltPYuc+kyC0Ar7d6r4unnBQkjNk7sCCb1gaSTwk8QYbqMcULTdRUMfiPgRsWMvOg+Mglda59+qLdAwBAn3vhWEueSXzmk4edGSQzYpnG7a7KVeC8bfKgVaqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Abzq/OKl; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4ba00b6821aso2075886137.2;
        Tue, 18 Feb 2025 11:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907704; x=1740512504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0uPYvx+yxtBdYOas61PHXPPfH9rcanmYIo6nKMvtn0=;
        b=Abzq/OKlrqpwHrdOljwHZjyPmjTH5/j6K9K+O7uZhP7nnx0GLmMXrVSXLiO7Sk1JCz
         M/13C6s+ubU9nJZEoQn5jbznOUrzkhb6sGEi7pW5dUPeMPzhRye6qK97WANpppGRwUcF
         ZTczPrZaPSnRYsJqw7d32RDNGs+wgh07bI9odrT8Oaxi+t+KCrPAEidRynZAz0ZkASki
         SJ4gLEsYM9QlTqmPsn/r0JaO1MqUSo/M1e7iBrJd7+gfbnmX206cBFxo2uQz/2EA3tgL
         zSU/pJjwO2WIPOOfDanUSaOOpEXSVfd67HRrDm4ek8nY1wN8k/uJ4shJL0dtfQ3IKV1v
         IuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907704; x=1740512504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0uPYvx+yxtBdYOas61PHXPPfH9rcanmYIo6nKMvtn0=;
        b=ecTE/d9b7AzEYyGTguFgnWAMdA3aQjaVBCyLyjyd4UL/57kgbZfTwhOpxNjudpe8Y0
         9uGdT1X4Pbc3Qh2ua95LlYkpY+fNIUeyHe9k/+UTeGHe0fpR4AjvAPhoX/BDBq4+UMex
         i1azooxPDA1JkitFQzE/w/CHADZSp7Lat7kZArlfEArIZT2nxEdjAIRahWiaFXMZq5PK
         M9haoH/ajXAoAAH7vKCmOoXe07SEz19h9TCQEQYb9SGEtbLM75CrH0/6OYPlqbUyaTbT
         bQSIzx3vNt/YNEgjy4PxaBeWg105jw4Hdu0JXlWHjHIOM7o7rlcS/6yMMjX/UHAAbhlR
         a+lg==
X-Forwarded-Encrypted: i=1; AJvYcCXCOf13w4kqtfClDsW0VFBsRSqR7gkptrbKtv4+jOEcLeoRVROkcbt3oNiKiD9v6dfOQGakQrklVtqnzXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4T54rctOcr2o8jnnlVlkrzWahehTGz8rkesqnA+2Znb23ZSym
	sZNvZ2Gd60gFMrkRW5JUPyipyoKCU6itSr9pliefcCwm4uU3ihJL
X-Gm-Gg: ASbGncvJ/QUpQMOri1wMd+GrTfU4lDjAbOZanv8xlOx1/NXIgp8IM80+Ir8lWUDEO7P
	jUEj7WRnpMXeBaL1OXsMirl1us+nIdp2x90Gk/U0bqOBxFDGJ7KLLRYboNgpsrM9vShrMb2dVx7
	k+aUcvqIyxpnsjTAOY/NPf3RGKt6GChWT3kAEmoUaNKKAFs+o5Yz+oX5iTkQRUwWL+QCIjQs+rb
	b8diXbz1+JoEOny51yRbuWHmrQ6aAOMU9+691swRLttD3k7tvVLyPNT+24/mW2zwOZYhgO++U8d
	54zTq5u9H3cQQu3axqG8YsI=
X-Google-Smtp-Source: AGHT+IE+WPDCXtw/dUQDMUzOw+PvlS+kr5M0BLw1Ca5k9vV4SrG+doVbbxnmxS7SqO2pUwiKKqEH8A==
X-Received: by 2002:a05:6102:290a:b0:4bb:bf49:9076 with SMTP id ada2fe7eead31-4bd3fc1778dmr9086797137.2.1739907703816;
        Tue, 18 Feb 2025 11:41:43 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc68dd766bsm2305214137.20.2025.02.18.11.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:41:42 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jorge Lopez <jorge.lopez2@hp.com>
Subject: [PATCH 3/4] platform/x86: hp: Use *-y instead of *-objs in Makefile
Date: Tue, 18 Feb 2025 14:41:10 -0500
Message-ID: <20250218194113.26589-4-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218194113.26589-1-kuurtb@gmail.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `objs` suffix is reserved for user-space tools. Use the `y` suffix
instead, which is usually used for kernel drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/Makefile b/drivers/platform/x86/hp/hp-bioscfg/Makefile
index 67be0d917753..7d23649b34dc 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/Makefile
+++ b/drivers/platform/x86/hp/hp-bioscfg/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_HP_BIOSCFG) := hp-bioscfg.o
 
-hp-bioscfg-objs := bioscfg.o	\
+hp-bioscfg-y := bioscfg.o	\
 	biosattr-interface.o	\
 	enum-attributes.o	\
 	int-attributes.o	\
-- 
2.48.1


