Return-Path: <linux-kernel+bounces-373327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C474D9A554E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF7B1F22357
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69042194C85;
	Sun, 20 Oct 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlYz4JPw"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BD194C78
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443073; cv=none; b=FEIfbpXf/Xpdlj6SKx2xDY/Jn3cZWqxaL8eSo0VmBT2Yc/1kanKtTrjSh12eioEEJ8iFrcWGePkOwhCXNtTBTrOLEVdB31CN9/l62SCRW49+tthjFxS+r26mFiWCVtuXE4RLpcPBxPSaRGg8ua3a9uIq4nM/vsPIiowrABLdSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443073; c=relaxed/simple;
	bh=l55fUVEwYdHEtOoAGHIhjeYgjYqQttKvG6kUCjXFGWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz1jH8sq+0u7wp3vISTBoLRtaEYaK3jdSX+okDLTbLZ4NfhMAklCxLMqx6tSVnsLOVIZzpBQhUFoXAjr/WZQ2v+tqGw6wTkm9+hvBx8tZMEFF43d+AkJrnP1dDZvyyi0+BoJzaLUjvTVK+mzVKSyniejzTjH6ZHsWK8cY6Uh6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlYz4JPw; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a4c303206eso695915ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729443071; x=1730047871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYBLg6rMRxWp9iLFroMdP8/SxVXSgHBiuOWN86UrkIw=;
        b=DlYz4JPwTRgAb1Qk01SZ9f+rYqWI6ffyeuPEzMZpbgWifxeUp4kuvekhjHdnCN7QrK
         RpTymXluZS1tkoEVNE1qrfRRHX7InozX2syEAmbx98JYFtGYgE6Dl5lCWN+ovvtsPc9/
         uzJkQKF2YnzmmezLYolGMiWc0qSt4Wz3CHwBieZXBVIZFLRQ9E92XRDwwV9avHcDE+qF
         do8ynUXPN7NztbN/oMuT+tjH2+YmJKJmJsalAIQ2gEng2zmvSbBs8EvQQe7Vdmuhunt6
         /z37IGWI6iCtJJqZKiMumbehxWjfk+9ErGAnu7AdBvpRCI1Hui/+77ew05qsv3d2BSxS
         6H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729443071; x=1730047871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYBLg6rMRxWp9iLFroMdP8/SxVXSgHBiuOWN86UrkIw=;
        b=HchOoPhSZihdSgmhGeql+KUMQhC4i8qommUtgRl8n/5vkTHPayMM9t2icEgoyy+BP6
         I78v/yTwelHbq8h0Faerov8LsOucjyMWy76idohXayzCfiP2OSRSbLyzElRzEt0T4fpk
         axP2A2DLiTkmAa5UOMJoED/OLRLSKGVDuV68Q2Ha1J86Y3BwTdiBMynUeBY4kV5UBlxn
         Zq/jFIjgdqSH26dXB+XwyJqff+kN2hqskOhRm1isdRik4NNyiV0DsfBlJMs2GrNn3WyE
         8ka74YVH62u9X/X+Dw166C/v4CjEE7NQYgT4dzlfkO4dqM8yvs48vqrD+mMFfBvAyiI0
         J4ig==
X-Forwarded-Encrypted: i=1; AJvYcCXqWAXRqhNj3SDvgPv69ZIiOqDPR1u5ZcHRnW2RWcsm/sWrmjpe5AwynXONLzLOWm2nHSnteqK9I6+BSIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFUsKOpnRwghMZjeJQPCTw1hbQA4layp5I4SbyDpYBLyH/QYw
	T62fOW89Oe25weuWC5cDhXChgWrdtAN+slWYvKc22iom5GIXV2JW
X-Google-Smtp-Source: AGHT+IFuzOTVocMaas7n+dappwDJvhkG7PkLCuHn3PZpVgaEfKIahES5jrLYoOT+UvM5KMHwUDN6Ww==
X-Received: by 2002:a05:6e02:1564:b0:3a0:a71b:75e5 with SMTP id e9e14a558f8ab-3a3f4054351mr81781465ab.7.1729443071006;
        Sun, 20 Oct 2024 09:51:11 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net. [75.72.162.184])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fab3sm533821173.35.2024.10.20.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 09:51:10 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] phy: freescale: fsl-samsung-hdmi: Stop searching when exact match is found
Date: Sun, 20 Oct 2024 11:50:46 -0500
Message-ID: <20241020165102.340838-2-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241020165102.340838-1-aford173@gmail.com>
References: <20241020165102.340838-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a series of for-loops which check various values of P and S
for the integer divder PLL.  The for loops search all entries and use
the one closest to the nominal, but it continues to searches through
all for loops even after the nominal is achieved.  Ending when the
nominal value is found stops wasting time, since it will not find
a better value than a deviation of 0 Hz.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 3f9578f3f0ac..719f8972cb5a 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -440,9 +440,13 @@ static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u1
 				min_delta = delta;
 				best_freq = tmp;
 			}
+
+			/* If we have an exact match, stop looking for a better value */
+			if (!delta)
+				goto done;
 		}
 	}
-
+done:
 	if (best_freq) {
 		*p = best_p;
 		*m = best_m;
-- 
2.45.2


