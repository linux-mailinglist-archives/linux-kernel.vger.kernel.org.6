Return-Path: <linux-kernel+bounces-357260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0276996E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F0828212C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59D19DF8B;
	Wed,  9 Oct 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEbyTuRi"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171A19D097
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485401; cv=none; b=oRhzJ6S8o/w4oMIfPzHsHYFF9VU/W756sk/7JbHsBcYtUHZDTsDT3MGN+eb2YFbGqGi1qT7gW6QxuCKBDM5rcf/Bqq4tIUvYjdSNg7kQO5jU1MkCc/paaG2ANKfDvDNRq8T82JsKX/21LUYeotYIyE9OSeFiYzzIn2if0b6TP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485401; c=relaxed/simple;
	bh=jI42gm9yHzosLjf63lCdwLAufnB9RNOSfSocSRIwwSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rPiUg/OxAHh3iNOS87dE4JgY8iAGAh+6sc3z/iAzxB4H2r4Pf0O10yrXWT1msMk7gQUmd+xx/lO7igi87wdmXNs8CHDNJr0OepDl2S976Jh7HDQ974nV5PWBIyJFyILQLB2KXDfd7LYJt6ZxvSP0G2WQRsLZsxGnoevQiLqIX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEbyTuRi; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso6042866a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728485399; x=1729090199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0cFSs0QjALvU83azYSnG8bluIcRDBOO61SIPn7WdBU=;
        b=kEbyTuRiHZUuRzbC8kzrYqRyqU0ngOr1sTMLc5jjPPVSSetV2PUCbgHJ66Y7ry+MaC
         rmaSeA6oj6ma0kQ7vEywEwLFyYnfjIzbpZRUNaaJ/tUyAw2ys/dx4xN3MMChVFwlIOFS
         WM4UG7zhC2DNIy0GtxnzNr0O3QowP6rqGcF8SBifZjgc2j0YZc8WsEbiQ+JufxdCfafa
         r1lUspDZD9FKkPhP5+4zpan/7vYzYgvtaUOVOmJ4Fyhtn7zpM3cuc+b06uqNSgKgCFQO
         ei230SmWsd1mlaq2Nz/cDU2J9j9/qXKpjNz8zvLfeny08LwOZXlPGxOIeUm3EF4Mbe+G
         ESug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485399; x=1729090199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0cFSs0QjALvU83azYSnG8bluIcRDBOO61SIPn7WdBU=;
        b=uCZKNm62Y3KpB9/SAwqbSodi/TqfCs57SoAYsK+Xn0jPUQEAP5lbLDa7heJG2j7QMZ
         aLObEBu0IgE5atotavvbJiJC36KbL92wx8rgrn1O8aeknqW5N45BRVL8L9xLyu5oQSUs
         EmZUNaHXLxCm4h4+RezDtogx9s180q7xBmZ60uWhL2ev98t9oSxMKsNkc5rkuFdOwwbm
         GL6uT+MvGQXaIwvgsCuHxGM139QlUzbS/vmoJVusuRrn8xopg6XZKHKzcE3JORNBU2Hg
         ljgSwJGeuureop7A/HA4zKYhLILhMQ6Y161sbvADQ+LSb7hZXufTV0wtBkGqL/uOUusH
         UBYg==
X-Gm-Message-State: AOJu0Yz8WJxaQcgarvzam2/6wfIiRG58Pw2+L86IlRbPZT/pNPQjR/Rh
	CBlP27YkLRIe2cAOOK2wkzEN9lZdhUV7o+FlegErBiWsi3DYgWnwY1g+hmX8mgs=
X-Google-Smtp-Source: AGHT+IEKANU4K0hrTJKs6iR/X7qHVUMKd4jjB/pwe5Rd/jMJ7UYsB8Dunv5ImI0ZaHToSFFzBukq/A==
X-Received: by 2002:a05:6a21:1585:b0:1d8:a208:f309 with SMTP id adf61e73a8af0-1d8a3c3d2c0mr4578354637.27.1728485398693;
        Wed, 09 Oct 2024 07:49:58 -0700 (PDT)
Received: from localhost.localdomain (1-171-60-106.dynamic-ip.hinet.net. [1.171.60.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d439sm7823706b3a.213.2024.10.09.07.49.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 07:49:58 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	davem@davemloft.net,
	matttbe@kernel.org,
	Andy Chiu <andybnac@gmail.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Leon Chien <leonchien@synology.com>
Subject: [PATCH] mailmap: add an entry for Andy Chiu
Date: Wed,  9 Oct 2024 22:49:34 +0800
Message-Id: <20241009144934.43027-1-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Map my oudated addresses to mailmap

Signed-off-by: Andy Chiu <andybnac@gmail.com>
Cc: Greentime Hu <greentime.hu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Leon Chien <leonchien@synology.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e51d76df75c2..7dd21494aa6c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -72,6 +72,8 @@ Andrey Ryabinin <ryabinin.a.a@gmail.com> <aryabinin@virtuozzo.com>
 Andrzej Hajda <andrzej.hajda@intel.com> <a.hajda@samsung.com>
 André Almeida <andrealmeid@igalia.com> <andrealmeid@collabora.com>
 Andy Adamson <andros@citi.umich.edu>
+Andy Chiu <andybnac@gmail.com> <andy.chiu@sifive.com>
+Andy Chiu <andybnac@gmail.com> <taochiu@synology.com>
 Andy Shevchenko <andy@kernel.org> <andy@smile.org.ua>
 Andy Shevchenko <andy@kernel.org> <ext-andriy.shevchenko@nokia.com>
 Anilkumar Kolli <quic_akolli@quicinc.com> <akolli@codeaurora.org>
-- 
2.39.3 (Apple Git-145)


