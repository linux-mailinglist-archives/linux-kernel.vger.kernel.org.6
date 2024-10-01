Return-Path: <linux-kernel+bounces-346851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA398C9AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FDB2842C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FE1E1A30;
	Tue,  1 Oct 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vvSlo9Ee"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40271E0B62
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826845; cv=none; b=d4JDLAxAR6xAdGjC7f2Z5O5NBetRwYKB8puMOebUQcMQ6DYAeHoFysQnymAp3Lg2XbDdM7mqGEVJYa5xdOs71geyU8pCS0NY5TohRSSwVFAbm6rF5IY3TUcrptiNAYMipWZKX0eWAf1lirh5PLoYVcIiTUvqxSjGaKhzQAy/l3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826845; c=relaxed/simple;
	bh=o3D87lP+KNy+Jir/fY7fvLsBvMyy9THUtqA+9zYkCpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IbqTYYdNvolBTwpIBmkXRbnNXZYZDWCKpzf2KfcgdW8axjBl4RfDwbBAx1rZ786RIRmyhYQ1bsxwj/lYz1llU7900s1xOX1cvzJDNBR7x1+xtisITGZHfSh+3KN0bWyKxTqRlc14sPvYzQ8IBDJNEJNZqBUheNoPqKmeNMx4Sxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vvSlo9Ee; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e09f67bc39so5023395a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826843; x=1728431643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLF63g3UxuFOgNadANGg2+qqv3YqiRQyKEar+/98gi0=;
        b=vvSlo9Eelee5097/8c3VFUiWk5vJI1GPF+ur0suqFmVXNp4IQa68jwxMIzjarE2L2p
         /gSLra0OAbxh4K4QH4DPjMiUbE/q0nRGq5uyN5t2DKLzC5vHRNSfc1q0ldj8l6RnfqdY
         1/DRSiviWHyyHh7JVOO+HeZSZ9lFKBRCu4iBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826843; x=1728431643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLF63g3UxuFOgNadANGg2+qqv3YqiRQyKEar+/98gi0=;
        b=a/GpyGdnPjgTFdcDwYSU5Nxkq70nc15RQ6TI242EZ/H2ZfaCKTdNnQpJjzMwsY5ZWO
         p2DYGAM22mXz6tOGfUQtMJ6M2koqDjgWSb/jWlWk8wCTmIyx9Wlwiw+fENV7wDtRBPFQ
         is6pmcIKDeTa3s8lXeOsgO+Psv5YKGq0o1J1NcXpeqkfbJITMe2YPRVxOZQUkzKhKCGc
         +szdSBq26jfKNKb6q7WGyADSHQTTF5i9TmVNRzkphoCpdyDUo1WUGWqBuMvx7ITmV/wT
         qujoFmQ+jPyrCU48B/LGCzch9smYoJG6+Cx82s7dh6FHACthXWLkwYp2fCNtTf0SCy3c
         A+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsvO9fYQoZu0rWFK1D78FLQ0kWUetsuMVdW+h1Ne7p/AoFw0Yp7JyucY+OKcUrtuLbuq4GiPC3VzDZM8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9x4T6J4+r7D52vN92BV/INuZ/rTXw6m+W/xKP9e4tkAopHOK
	3Z979xoqThBlOXUn7Hejtncbl2pTxby1Ie/r1EbjJhLJx3PhBBJGsXmQHLrmXNM=
X-Google-Smtp-Source: AGHT+IEziOa7A+MAB9R2Y08fOCLGpcavYwRLkZ94iRWB4+/kdOklKsQcBgrXg0q1p/jteWgh+MwIQQ==
X-Received: by 2002:a17:90a:1b89:b0:2d8:89ad:a67e with SMTP id 98e67ed59e1d1-2e1845511e2mr1931370a91.1.1727826843241;
        Tue, 01 Oct 2024 16:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:54:02 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 7/9] bnxt: Add support for persistent NAPI config
Date: Tue,  1 Oct 2024 23:52:38 +0000
Message-Id: <20241001235302.57609-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..f5da2dace982 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
+				      bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.25.1


