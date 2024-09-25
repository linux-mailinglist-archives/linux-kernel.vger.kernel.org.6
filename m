Return-Path: <linux-kernel+bounces-339400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515FB9864B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F5028B206
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB03D0A9;
	Wed, 25 Sep 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YJJk3XCa"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF8266AB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281261; cv=none; b=pqgLUvmxey2xS9y/cg8WKU0CJd0Jh9hY5bnoiRJEb/EC6LqFd5ztySns6sKBOWYXkeIoWkZq6+SdREtSq5F9VbhDiur3YhNPTLPDtfudAz9ClPDM4IMswz4QHDW38+g1UOPSXeA3fdoaObMRt3gMK84OKm4Dq2YJMtRYes34mFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281261; c=relaxed/simple;
	bh=Dk6X+xSiHfgs31VmHqZTurDjVbP1XP6i/9hilYXsQhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vk4xa/NxioDPX4V52S/5j//Jb8OhVVjCxfROSF+lZRtWEN17aQzthLhbPtWnRJZBBrA9wCCrAiHhQPai6xz+G8I09MvT6xWs84sFaPDZUfDcaTq6FSM/9LY5ZuwtCcM8ucUT4utWZQ7Vh+pCJWa+FT5NSJEWNtZ2plVQ9skQY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YJJk3XCa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206b9455460so703305ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281259; x=1727886059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VX4o26UEjmYDlazuMHXCVg//sBBLs3VDVwOlYuEl2Mc=;
        b=YJJk3XCas/axk3+CX3C+sd9qF2ECTduISzaNOuGNzOOcCTYxhsalaK+Io8toyaEqI9
         SPdF/tnRYnCmssj6wQBb2WJ00vew6YC1lLFJpdAjt+66dFLTCawOz3H3Hn58LDhDfGfr
         BH2wZWFGAs/J+6tNmnLKzgPD2jF0VtCEKUT4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281259; x=1727886059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VX4o26UEjmYDlazuMHXCVg//sBBLs3VDVwOlYuEl2Mc=;
        b=gzHIEFFduBfL/gXpt3AeomijHHvGXyL8gje+ySODDukZIw4AGiBfYcc0qH07B343jk
         EMrZ+SjBZdKJ5TqapRuX+fikbi9n5HqtrFht93wawfNa1ZXHpYhC4q2h3fQb+JxD2Ve+
         1VJ0olOXX3AL/Fhu9gsy2wHHAGP4kkDwAmjb4EPZvpuhVp9EWNRce9EN4IBwJZvjs7d2
         k5p6tSEEon7YJSoqG1ACm1ndnVHVRdwUnbvFiVpj05j2TzNKMobeRzakoMDYK1AQyCHw
         0bHzw5IBli8w1/R7h6QvjlMW2jBBVk5CHgZeG+HWRuZijUFHbE/1bXBWSSDyMQzfwpzj
         32wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/fKvCDWnLYyxVskfN6h9SICqoh40i/6kBMEfYGrg4W6CX0L+vj/tM60k8A3UccmGxajmaAkY8qrgUr44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHoMsS9q1jiYJ2Y9a562AiIFv1KHbpNDSwe6pMwGnrHSwBG8Z
	jcLhrBJuV2ygWkBPpQw65nFc2zSwyI9AOD8qQMEIXkWAhcNiWpaODofGLCbdPZE=
X-Google-Smtp-Source: AGHT+IH5OPAlqNY7D4alHb/gHJCc50Tl/V50oHFttUV8VmEJJhr89TDA+wKDchkkCoWXUHzbHXM4yg==
X-Received: by 2002:a17:903:32d0:b0:205:5a3f:76b2 with SMTP id d9443c01a7336-20b19ce53cfmr2078495ad.29.1727281258969;
        Wed, 25 Sep 2024 09:20:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73341sm2948433a12.72.2024.09.25.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:20:58 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Michael Chan <mchan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [RFC net-next v2 0/2] tg3: Link IRQs, NAPIs, and queues
Date: Wed, 25 Sep 2024 16:20:46 +0000
Message-Id: <20240925162048.16208-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This RFC v2 follows from a PATCH submission which received some feedback
from broadcom on shortening the patch.

Patch 1 is a revised, shortened version of the original I submit a few
weeks ago [1].

Patch 2 is a new patch to link queues to NAPI instances. See the commit
message for more details and sample output.

I am sending them together as I plan to send them a series when net-next
reopens next week unless there is any feedback or changes requested.

I am hoping that broadcom would be able to take a look before then so
that these patches will be ready for official submission next week :)

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20240912155830.14688-1-jdamato@fastly.com/

rfv2:
  - Switched to RFC (net-next is closed).
  - Patch 1 incorporated the feedback from Michael Chan in the thread
    linked above to reduce the number of lines of code added.
  - Added patch 2, which implements a new feature.

Joe Damato (2):
  tg3: Link IRQs to NAPI instances
  tg3: Link queues to NAPIs

 drivers/net/ethernet/broadcom/tg3.c | 31 ++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

-- 
2.25.1


