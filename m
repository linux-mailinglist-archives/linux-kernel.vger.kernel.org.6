Return-Path: <linux-kernel+bounces-296709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18B95AE16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600D11C229E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000AF16F0DE;
	Thu, 22 Aug 2024 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FVMD93cy"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D2152790
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309555; cv=none; b=N0Pv+0cviK6Z6iZV3h9pMicqaB5L5yCj2+Ofzu2P2lg33/H6X07BjXRJ9+AIJ58TEaBaaClYG/xVk9iEVOthMcufx5hjtZ2lj5M+1odd3fFLtJ9V4IoOQZ9cCnlFAoTKL8XIjaRAkYt57w0AMUEDpsJXpmW5kVObFdIHOr6Eyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309555; c=relaxed/simple;
	bh=JgAmkYSjEtGXpZHuLDgMgHpuHbneSy/7OfpTBL6KeyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOv74pI1Yck7qj00CPBr7VVPleQaGMbiZNdMeAsVhYBQpab9fe/OZ/v3Rta30oQRdFK+8JhTZnH2+Y60xntkA6Y7JXIpgYa/Le44n1R4K2OLtZRJ8ORGnfTYSMWraSxwBxtJqnXJubVkGuo49M2lekqhj7WsDelQlqB6+UmAbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FVMD93cy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2020b730049so4073635ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724309551; x=1724914351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/FFKtEYzldzsVLIxFmFWKtQdzfb1fksBJ/Gq1pcja0=;
        b=FVMD93cyz8YoLJfMly2Qv2Gtdr3B04sJe7e8htroJ4yF2PKBk5T7IxaTRsuFQB7AgA
         uoHWvprFKuDXYGKgLe7ygyB2EyODSc32qz5RYk8UeCvQZ17Yb+cIqls8LnVnfLtsf6eK
         bxDdV/EvH7OZGI39+MjWDSGgAqt5XVooUi0EXXfupoIOwp0BzDPzeKXwB3XmJoubtQ8O
         iWnomo8KKbIhbxxuMbYTJPPt1P9LeKFqaXw2wNeE1Fk87lYvBgbUu0B6FebsoRN1uD+E
         W88T4tchp5+wN/PgribUUgIbW63dcN+1NjZvUtAr7hB27l+K080qxhkiV9F0u4Vu9owF
         Ccnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309551; x=1724914351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/FFKtEYzldzsVLIxFmFWKtQdzfb1fksBJ/Gq1pcja0=;
        b=Uwhs9ir7KLpcI9kIdi6rj6Jm4MA2xTM7gLciX2D4EZjpBMMEsyBPxG6b1/Sa/bXNYl
         LoVPNENG0sonB1qn8kwXvLdtWWuF2q/izv8OJJyw1GJix90nyU1ekb49MQD2hqmYi7gQ
         newmerBKlEKbwe2RYHE3QbTlnrBa5xYlilfC8lZG7wjCYbKo/RaWfe70AxgX3ol0+sd6
         qlaL/TQmjaVOlf+bfgO9xYRc1kNJn2f2nrxboShR84jSlJtEcutsrbiNJnK5S4P200+q
         kFY1JFda0KIv/2K/9h7Yk6qePZmuWwdwhSuerO7C1U++Ytu/6JriZXsX8tDBLl7royIP
         +M5g==
X-Forwarded-Encrypted: i=1; AJvYcCXg7V2A/DH7Sn9BoJZJhzDZz/8nuRKWUAQZk0LthCGdUb/006cAxKIK+31cDxI47b7a4UBmI6Greck3sG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygIcpt90F7o1aK0zGK5tbL4x2jQQpI0CKii2PEqlYv/IX7ir7p
	SwLC5t7gE7LFIjit4P8oUzCkDSJHuWCcwq8M2ZeO7wzjQDeQ5yVmWzktYdjsSkGYN3yESkTituo
	g
X-Google-Smtp-Source: AGHT+IG086DtRWTiv2PguF+J20DHGb88+EC7cNQNKHEMjrRPETRD0uVqkbPkuHnqyQjVbQvWS64zXQ==
X-Received: by 2002:a17:902:ea0b:b0:1fb:3474:9500 with SMTP id d9443c01a7336-20388235274mr11843445ad.27.1724309550911;
        Wed, 21 Aug 2024 23:52:30 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581165sm6150645ad.88.2024.08.21.23.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:52:30 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@nvidia.com,
	leonro@nvidia.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/3] RDMA/rxe misc fixes
Date: Thu, 22 Aug 2024 14:52:20 +0800
Message-Id: <20240822065223.1117056-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please review these minor fixes of RXE. Thanks!

zhenwei pi (3):
  RDMA/rxe: Use sizeof instead of hard code number
  RDMA/rxe: Typo fix
  RDMA/rxe: Fix __bth_set_resv6a

 drivers/infiniband/sw/rxe/rxe_hdr.h  | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1


