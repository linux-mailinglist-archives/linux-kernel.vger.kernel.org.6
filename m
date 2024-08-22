Return-Path: <linux-kernel+bounces-296296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BDF95A8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECAD1F2220D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EEF6FC5;
	Thu, 22 Aug 2024 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egz+L8+D"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B41BC39
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286310; cv=none; b=sUi0SLZCwYdM0MyrMMoAOUpbUu9+KXgQgbmksGztp/KASxo/WhwQN04iSIgmnNe6kXvSo2wwhemV+fh27+CY6uYYEndF7uokdORHqojLjkIZPTnBfRLmu/N8RM7e0E2bWS8BNp48KJXBFw1horVlWzwn3cFg7VP1LUIzxcwUamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286310; c=relaxed/simple;
	bh=aYWcy9/YcGAD0L5BqcJlxyeMVuh8DstfX11wptGrTBI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJG4vgAEfRSORMWWih+SIh0h+9KuB3GibJqNDynHF7UXAkNJ0YUQIDhlfdWMOT97uxLxn+8hJx+ZuVR+QYWNPp4O7Q7+Kg4+PK6fpDxzlQ+3WOUGdSkNt9+8HzbjNvUOHT4pbdoP6ZsYRPUfh6/yiu4Y3+/wxKEMpf5KlfTXqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Egz+L8+D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7141feed424so217262b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286308; x=1724891108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvGSlWgR2YHI06x+1roFY5gCQ/Tq2p/PLpW4gKEXuQY=;
        b=Egz+L8+Dq388tlYiHWezbatK+UnHoIwGxpe9XXmNM+W0ZOIsmWE1XqQFd8B/8Sa89U
         uAzaGguwu4TKuAWTlsh/wLAeF77pH/rSkMMkrpT10TumUlcZqpikSRsLi47AyrqsOtSj
         SnBLAr424dufkyMEUniVE9ioirIAyuQt2FR+04k1m2i2sxkw/8wZar/uIBj/vSIRtirK
         85KwRUocsBz7Z5m2JeZMGiyKYPEZ7YvioASh5mnJMmpAIpQJyS5pY6AMME4cESgyoXM+
         FbUjfCvUeVeJVH9Gq9dPcD4J3dQ6JCmLd82OAfKmThJS7wrpCqYLmKNH+I3rT/M0CFXw
         N77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286308; x=1724891108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvGSlWgR2YHI06x+1roFY5gCQ/Tq2p/PLpW4gKEXuQY=;
        b=RlrNmSvwIX/DWpcDRSIcDc6Re3+sPnL8Ikbc/+1TqagmM6Axn9UboFMjoISPpni387
         Tf6Y0gcHmjYI6a8vEV7YXAY17PfsEH+BV2oRHtfau+75pWze27bKW7hwXyaT6rhsShxv
         1peRwki3AKgthqvtF4Y4MpfP0zf8nvcJwMBegdjQZum2MyUHJwLOmhgZL5WW77tS6DLk
         Hxms+buoOPKqcBUxJ+WoBQ3bjwSdCLZitq6Q0gzI5+FeWbMAnRIZTgeLXSsq1MuUwJZl
         4ac6bxFJldEh2eETmFSkBxFO4ngynWDL8iaX84eB/Ii4IgTgEChgTwzONZogTMQXIkmY
         cXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJcl0Roz9rrhNyrzgMgce1p5fxbN/APlzzhJ0l9BiqiHFPJqIqBdmkvzs6eedR8Y4+h5lhk6ZVQHfURLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Z2GYEvcaf9OZF7erCWcBJmPPjeg/98Fwp3FUyNPvwy6N7xuk
	z28jRILYypevYWDXvnn1oIrvXRDhwt0+EvqonWGnXP0Rjl4DD0Lq
X-Google-Smtp-Source: AGHT+IEH6iDa2lnrMavByxDDh1AHFBz+yklxGqZZiLR9qrjuSM7XznYXjztVOEEDvK8I12B8CbExJQ==
X-Received: by 2002:a05:6a00:4fc9:b0:714:20a8:d79f with SMTP id d2e1a72fcca58-714364d3b95mr264426b3a.14.1724286308204;
        Wed, 21 Aug 2024 17:25:08 -0700 (PDT)
Received: from reitoria-Aspire-A515-54.unicamp.br ([2801:8a:c811:1:4f42:fbc7:16d8:e311])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143433ac53sm229206b3a.212.2024.08.21.17.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:25:07 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Pedro=20Le=C3=B4ncio?= <aljpleoncio@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix line ended with '('
Date: Wed, 21 Aug 2024 21:24:58 -0300
Message-ID: <20240822002502.92583-1-aljpleoncio@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix line ended with '(' in _rtl92e_update_received_rate_histogram_stats
in order to silence the following checkpat warning:

CHECK: Lines should not end with a '('

Signed-off-by: João Pedro Leôncio <aljpleoncio@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b3d4b3394284..1e765a1fee11 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1521,9 +1521,8 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	rtl92e_copy_mpdu_stats(pstats, &previous_stats);
 }
 
-static void _rtl92e_update_received_rate_histogram_stats(
-					   struct net_device *dev,
-					   struct rtllib_rx_stats *pstats)
+static void _rtl92e_update_received_rate_histogram_stats(struct net_device *dev,
+							 struct rtllib_rx_stats *pstats)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	u32 rcvType = 1;
-- 
2.43.0


