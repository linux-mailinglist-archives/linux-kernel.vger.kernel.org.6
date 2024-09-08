Return-Path: <linux-kernel+bounces-320310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E279708B2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3EF1F2182C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7CC17BB1C;
	Sun,  8 Sep 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UdSsw1xu"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2317B402
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811743; cv=none; b=hAoHywEimvJXGiDPPgPKZ4Nm7NVbPhpELhm/4ip35E3zsvn9hqH7tdIRYKLU/BuTR97ZtENQipzSW7h2t40xhYHKsjVKU9CFHE7jXdEpNpZl7OvgVGaKLkRkTO/hFya9XmaVAadZnPfyBHGRyRJ3hy7NR488YZf/oXEv6hPidGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811743; c=relaxed/simple;
	bh=sHhlasbwVibNkDUBcgYAgRqAvPf6JXUYUczB3y1i5Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObhCKgpFzgFHAv14EOOHLmWNHW4/0yGXOizRxwUvccuI6YUlOKRJtcWxSm6xQd0Vie587VWqHVobXix0t24XuSe796j5l5my0TMJghoc84stMKOSf+QgiVgOk6b75Cy9jIkePmVT+Mn88wNH8MMAOu+QFfxJ7bywaRQitwKGFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UdSsw1xu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-717911ef035so2727027b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811742; x=1726416542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBjxY6TwnFpEzcM0rCGHkoag3b+h+m2LlFoiqk6FpQ4=;
        b=UdSsw1xu2zxAdxGDVzh0RGT27Zwr+T4mt/eleZqCVq6rQKxU45nvv3l0X07q9uKsHu
         72EpCTWEs5FksIy4sBEWbcUuJseZPLgAoD3vaR6sQbbITt1/G86ABBhWcFcq4z9oboV6
         xU/cOGIkk+tCLm3WOQuZeqWQd3Y0qchQli5XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811742; x=1726416542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBjxY6TwnFpEzcM0rCGHkoag3b+h+m2LlFoiqk6FpQ4=;
        b=oapvPhIhdQEj0fIu/7PLo9dy5e2ObIxpnit2dshorueBqcKbvn+/wae26iB+T8C6sv
         Lxy0ekEMi8UhUAyfkQFBvb/psGJiYUp0JQOokatpwHHGZx8OUVGnvAMrjTWVI8MKGWBp
         UqmdEryFHzpP7c9GGGRke9v9SXNG7tnJZZ75WEFPgInmjaX4vG+I/pWuFeGw3KdP3Do7
         VdrV76EY2/N2mmRqBo+ZtFbqWuNYbXiNCGxigBSVjpZk8b1+jReuQOUJw8bagClLDuzq
         xPHdBqFXr7MC6BKGiEvdvyygHepS9Xqprwx3D7W+FfRFwIZYCvea4oVAqfPC4TukISRK
         FNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUTcwDqCTEl3cXYVT6S/+ecLo0cw5enqFTTm/aYiq0mMXn8bopKYKDwS/3EHud+ryX6LiV2FE2QdSCcppw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvABabqVlS62uv5ZbS4gL+Q0iEyVW6th11E95BP+XSYivR9MT
	cNDB/W/8bEm1PQoh3lWmjHiXFWa4CUGY1NHYdwfQt9P5z1bDebxrchPiRz/f1fE=
X-Google-Smtp-Source: AGHT+IHqM6CtrXmsR793CAG4W9wDsYIOiyXLouRIaKFNMJRjMOv0JN+CqWwdUpDW1v2w42mf6KOc6g==
X-Received: by 2002:a05:6a21:6b0c:b0:1cf:38b0:57ff with SMTP id adf61e73a8af0-1cf38b059c3mr1076308637.48.1725811741803;
        Sun, 08 Sep 2024 09:09:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:09:01 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 7/9] bnxt: Add support for napi storage
Date: Sun,  8 Sep 2024 16:06:41 +0000
Message-Id: <20240908160702.56618-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c9248ed9330c..6f231a43775b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_storage(bp->dev, &bnapi->napi, poll_fn,
+				       NAPI_POLL_WEIGHT, bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.25.1


