Return-Path: <linux-kernel+bounces-423196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F096E9DA428
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E16D167F64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2D190493;
	Wed, 27 Nov 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFajuxcn"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0D188904
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697543; cv=none; b=ZZsgad9GPTICwnO9hyID4bmE6Y5c18tQ9ZVEu2m465f5wYGmaHAQA8W47qR8QariZjK/HNaZ0yKfjuL4LeJv2dmQmmVCPPg0joereiiv4+gjyg4GUmRzrzqbw1ixcv71Fo+BWBcmmy8Tvmj5X9k9G2SDrlRqEur8Y3FALxwgqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697543; c=relaxed/simple;
	bh=wY6f7nJu9Pg2hjSOyD0ZoDO4+PdS+dIa8RaflRe+mA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJbaJLpYqFSEQtkhfNxtGhUfUjyiiyNx2SGrWbY/4FO6Uh/RwFifEpGYgMVTtsRQVs09DAQ4bILqcdd+wQHzEt17wG+zy7NsaWpmOJ10f9LYt1mXOpRBLLtqQvNKyTW1vPPjQXPzf42vQgxl9mvJ1Prh0UEopnE8FH8XJ0EWbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFajuxcn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724e14b90cfso4659084b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697542; x=1733302342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5TXHgZ3Z8QTGy7TWH/5+kFsxPLaG9TqvwezPRwTQdc=;
        b=XFajuxcn4dstM9oYc/PefeDLcfGcCpIuPYbMdj3tnhJtkdItBOuFRQaIVDKXt0Sf2m
         lX94PNnQuNlJ5Eca+aUUotqnebAAqPjAuj+ZDVZvv0LjWkqjRj8pLLOiV0aeJdLwW2jm
         S/6L7WXC+hCMQ2QECw2zNBl+Ra4Lif0swIkIwlwOaMGwjMEneMxw7/2OaJhjDAOsS6A1
         8lPKG9rWOLVoBun6SALz6dUDUbXf35Sa6Q1S37uMQTzi6EIZ1310lbICSs1Sc/IGmHdI
         Sj3AZOw5gSuEPp7EsbDMDJmL2sLvbCefBKdFtls6kHsToqeT9pkGT0105QIfqvcJZfyp
         RieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697542; x=1733302342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5TXHgZ3Z8QTGy7TWH/5+kFsxPLaG9TqvwezPRwTQdc=;
        b=MzJ5xLT7KnEV2Em7mUIhRDZwVpF7VJiiBc1y1+bpfLU2KlJKrEctaDg+GhzSmay4fe
         qqu6/NkDTj+PFr0nD/ZLrLWKMWJriqp5MQZEVD2VRgRFv/4AvYGcKozicKK9VgctX8ei
         EYcDOhGKIvK7wQ/FiLPXfvXRIiN6K34STPJwgbaXfgW2joLHOicom9DarkJ6u65jMGZ4
         infs324TqN2rqiZNsc0HapxWDG5/Zsxcs6QDdY41h5Bn8+GyUKFVLx+LRpkc7koqVo2T
         woDfFRQCu/MRsSgzrgYeQqet+tv/OvqPH9r1BJZgHFrHNib0XNJLVpOXt3qo0t5dZtAW
         udOw==
X-Forwarded-Encrypted: i=1; AJvYcCVlt8Q2tdA0jQMWN7HU/4Xza1uAfs1BBgge8UBEJNFURds5C7f0SeYjlpXK04RQy/smPE8WjyCIlGc/a7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2G+LHY484sbnyClEBHLYOLzkxJDpOJ5EeyIlTZ7cuainju+6q
	G+GKU0kp5pV9BA9oa4P5gDHzpaHgShCaNpHkmEkZO3hIGyMwtfVo
X-Gm-Gg: ASbGnct3ERN1d/DXkQ/pXvkU5URW03qfIO60lfr+0O6TuaztofuCbdjIletn+22/yh2
	Jj7QV9SHSp3mC633NpoVkEsy38F8sTYwWlcTFzEr6VN2sYTo3Pd9FVtTYQzfBPSpvA8TwBtlJz+
	vRFpIRRddGkpLR+Sj4+gMLBK57zgUmezcOe77Ev318GxnuaGAfZWenIRHbTvhPooJvCqzKpfO44
	m6WfdXQkj5Ffvs1lEXt3eIH1lSAcpMgZdOGj2didQjUJOkqGr/k4Sj+neot+g==
X-Google-Smtp-Source: AGHT+IF6CYkTsIeE1XeYAMX6OTkwBCN+caMMwhD4ZTXviHRAggHQYeZCg5sgJ6GOgj0vulov/WbgKQ==
X-Received: by 2002:a17:90b:38ca:b0:2ea:4578:46c0 with SMTP id 98e67ed59e1d1-2ee08ece4a4mr3032590a91.18.1732697541734;
        Wed, 27 Nov 2024 00:52:21 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:21 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] nvme-tcp: fix the memleak while create new ctrl failed
Date: Wed, 27 Nov 2024 17:27:47 +0800
Message-Id: <d57573f42413b9e46fe227ef389e2f8a6971f1db.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now while we create new ctrl failed, we have not free the
tagset occupied by admin_q, here try to fix it.

Fixes: fd1418de10b9 ("nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()")
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..55abfe5e1d25 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1


