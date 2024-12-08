Return-Path: <linux-kernel+bounces-436454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A39E860C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246371883EC5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E915C15F;
	Sun,  8 Dec 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="d1Iv4bpY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A41581E0
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673167; cv=none; b=k8M4uQ+NGkzBkKWAZJpAgavgr7s+WTkHOaAjWY1Z8V4Jb/uIQoqfjKdDe2L7qmy08RXDfHSn+6jja5o1jzDuooUIOkn7o1h1Fr9+RRrcooqiTk2ef1D2Rr2abUhAyt/TVmMkzA5n+yMou9iAoS3bo16sWCdgTQspgR5u36EZisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673167; c=relaxed/simple;
	bh=pR239TJH6DkmyjLOOWJrEa9qa6lKwq6zBqCCU7HNb+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsDKfh7+R70+Uwf0zl7D9QXqkNbTwjYgxzSK6vEkPhY9tINtmuHF5owkSFnX/SYV1RDzazH8Y3OC+VZ2OAscOeUK4dOIZmxfHu3FjGYMc8s4WnI2lEUO8+eukJ3YIwXPOkb2SoTgEQ5wcxfJdikkstxokFKLEcsvGyp1PxKF+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=d1Iv4bpY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so793497e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673164; x=1734277964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM5DZdXZqiBry1GF0hiPMUU57y91Is3FbX9t5e3p81c=;
        b=d1Iv4bpYYgxKt8zGwpriFDplZs2LllAYlDDcdMvk+YGdmkeyc24NiIve5F85xmWY2B
         gGDjXGCL3uYJfGwbLxJvapUleLflyrW/AhZ35GbdiAIrPxJXzyUCjPFdVJWlx8FieEvP
         4NPSLDNFX1fnlRk7HNOJhzmYVsv6RjPubGHwSuYGaKegtEr8JkVhl6JVK+DoWZ3/Yd++
         uVoi76ppkhQv0h8fRHZNtom3fodCbWRadyntxgr82uEpM3LYsguzBnMzq1wb6b7Z6QJO
         dtxQsRvWVI9gPeytZS8XnbGY18/mOsj9FajuOOeYUDRjKF1PWm51HG3ACBPDTyQgXPAf
         qxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673164; x=1734277964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM5DZdXZqiBry1GF0hiPMUU57y91Is3FbX9t5e3p81c=;
        b=tsnqpL+fSpaAdWv2Gxf9gGR65yYoqSguwdmkai3W+PhBm0A1Zz1AFNgYQnL3Vfo3jC
         iUtw9koblr2JwIcBn4Uml8MKZ+N/u5aWXPAO4s4tSKnrj5d3G0v6OPXJu371T4E28igd
         7ZQssYmmOYZ/9a5IqtNeSI1uxgCxsYRhvtjKJlfq+LjCOP1Sb4jKvVf2gRiMEi13XgOH
         K9Tt1DafjQ32/nuQ9Pe04k+XcbWv93IW66u/vUtFG6XZ+dE7GydClwFy1GSxR/gh9erM
         DcfxbMkhDAIh9cHOz+0sDprb6SeOx6VD68FSMwo0UDJQqsg+781yKqdmdVfHBpt1FFzJ
         PI6w==
X-Forwarded-Encrypted: i=1; AJvYcCWXEHJl6ksbZAOFZwCGExuyq3mkersEKt/ORtTv/D85efQxZoGWl9mecYt4WNIhB5LcvCirWZSdabV1KLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHnnwhlNt55eMhOFjCdNaN1bImtxfrWd+nAz68+8d908huDcn
	DlOd+J1RxH6U3+fBvMnpK7Ea1MtxU8pQQBBYxQ+NQwmLJhn2PlORSZCSEkZh09w=
X-Gm-Gg: ASbGnctQWILElIH9WoOCsrJMwwbphi4OIfxYbCRIAoD2Rl4VnvRAGZgHKAQ8K+iI2DI
	9ZKldh49FE5p4zIjagzqi+rLFm+mZCAgv+9oxMqb+sLsU95X2shvnOun+/tSXkOtw1aYcQTuFIV
	8UojJ/usxUUE5OZ+KvlM++pwABKC/SSKUGrInSO3dyay8WKsBCMc3fFe20QYldomH8PQCPVrV3U
	/ifsTryYpdlVg5Uhhql3UZPW0E7ocfEolnepmko5Y6Rdd1dJNLZN2z0NKa5f1j5
X-Google-Smtp-Source: AGHT+IH0mhFJkzgTaRltbt/3f/uOZ0/C8ZdKxaDXSeoLslSVJ6jaMefU1FWkl1ufVYiQ/d2eGcmVPQ==
X-Received: by 2002:a05:6512:2823:b0:53f:232e:31ea with SMTP id 2adb3069b0e04-53f232e3741mr1250833e87.54.1733673163671;
        Sun, 08 Dec 2024 07:52:43 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:43 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 1/4] net: renesas: rswitch: do not write to MPSM register at init time
Date: Sun,  8 Dec 2024 20:52:33 +0500
Message-Id: <20241208155236.108582-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPSM register is used to execute mdio bus transactions.
There is no need to initialize it early.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 8ac6ef532c6a..57d0f992f9a5 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1139,7 +1139,6 @@ static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
 {
 	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 		       MPIC_PSMCS(etha->psmcs) | MPIC_PSMHT(0x06));
-	rswitch_modify(etha->addr, MPSM, 0, MPSM_MFF_C45);
 }
 
 static int rswitch_etha_hw_init(struct rswitch_etha *etha, const u8 *mac)
-- 
2.39.5


