Return-Path: <linux-kernel+bounces-361685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B899AB6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3184C1F23C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7B1D173C;
	Fri, 11 Oct 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NmSiXLfZ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB341CCB3B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672371; cv=none; b=B2gAZFI+VIikW8uTR3PuaO3SBtNH6cVRioAmO+zcLDH9YeZpWezALqnqZR3Ej3hijef0Q71BHf8Vk9hWdkSG88b6gl1d9HhXwe++Iz5NKrERxOscjtj7kUbeofc1sql8gE0mOfk3t2hfr7NgEiyiUZde9eOJ3kgR9mpMN0rHocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672371; c=relaxed/simple;
	bh=Ay+s0guDrHAq8MnuDnxM0ZdAsgqJCoes87n91IKUUZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGSBKFG55u9KX5jJXGK02l+hxwC32z2E4sreLIhy/1WybHvO6AuEAp5a8XKBIeo5bpuJcinK4BOEhG+ab0shBnxBYkYzCzpx28K9AnY5R9OjUNrMAN380dlGEX2Ge1HCuh5x3Id9Vw+pyEtCa+jQjz56vSdhdvB82A8/N/3Ap+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NmSiXLfZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9ad969a4fso1691920a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672369; x=1729277169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2sSEQQaNvDLDNmmYALnWN9i1EK+aNS4wMNnm/Kh+Q=;
        b=NmSiXLfZeNa1txwLYlXh7WYgk7as8D1IKm1A+Yp2I1q1Xc3Y7jGMSfzjKJKiQ0CThg
         nTPr3/O/ZBLadBtVWq/GB/zDqddRwobx0SfmUP6GBD0KmUiOYJwQbAHp1IKRg/SFF1Bc
         /nRD2XaCHmzSOPydRtZ/ca/TllAqP8gmMWnCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672369; x=1729277169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn2sSEQQaNvDLDNmmYALnWN9i1EK+aNS4wMNnm/Kh+Q=;
        b=j3D/oWdAVRRlPw9XUVJDvQsG5xuVselk6K3YhPcn8QnEpDyQm8vKlISXoJZo8OAQIG
         /JCjfOaAMx6DhkHtg4PGxRz+u90QKTbVb0g6Jy5dXnxMOJwz6PA5ZDoN+j8nVKW/WDwQ
         AsoMUQG26JVdm5NO2iysfndSar8IIfnCNg5cxFH6K199upDJzyvpGuT2hggGUa9VoR8M
         x/noc6qvWOreBjBJh6jqA7eWqrRU3KuY4nRIUpyzZU0Y7CPCiQJMrljcstk+hqxqLXwq
         CfAUypgcZpCrg8W5GRRdXWTnTc1jkb1kUhhM+kbzIXAkosPhFPcjcMHqABbhwIBWh3K0
         TdGg==
X-Forwarded-Encrypted: i=1; AJvYcCW7MiWowMEF+doZn/rrLZKNO43+GD99Ut7VHHbcuJ/t+UQxzf13KQiLWnf9SbiZ6ZddRQcfsx8uT0m0XoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmhwXCDQmqYgtY/7mA4/CV8C6obWbBdw+C9poNgMus0TElJTV
	5LnomxkmKcGcfnZ5N2HUQ5Xb8ia31x1/g5OEBOEXM9ecHuAh4ReQgZJU+HCOqXM=
X-Google-Smtp-Source: AGHT+IFmnoI7zdMShGQdX0K5KPw1Wu5OvLwhLQCL8LnCffu2Y9WFXd0TLNvEcwdmpwS926sN5ZEeUQ==
X-Received: by 2002:a17:90b:2246:b0:2e2:da81:40ca with SMTP id 98e67ed59e1d1-2e2f0a4d957mr4649758a91.2.1728672369296;
        Fri, 11 Oct 2024 11:46:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:46:08 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 7/9] bnxt: Add support for persistent NAPI config
Date: Fri, 11 Oct 2024 18:45:02 +0000
Message-Id: <20241011184527.16393-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


