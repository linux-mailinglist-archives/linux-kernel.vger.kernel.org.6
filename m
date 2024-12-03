Return-Path: <linux-kernel+bounces-428653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739BA9E11D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A56164D50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCCF168C3F;
	Tue,  3 Dec 2024 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dym/Xevg"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680722905
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196892; cv=none; b=tBv16IjEP9yBSZ3ykzDqE05sLyXeP2qPSeefB22oWOQaZgWRO3j+V56UHQ+dJL7NJpLelo63GyuscC0gb1dTz/cWtOMA9CiKAM8LzrYVhGP1OYZGlgXYc6ILpIOlJbvATw1uFOVKw5M2jRhMsdfNc2cUMmY1WfjFoZLpU93lkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196892; c=relaxed/simple;
	bh=PavmXKb7c01Z/dnMBjwCAK9z+jnOybfldhgG1FCXYD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciQtyOyxYBy+ZwIIGlmHiw+dTF4qzVTjG3w0eBxKvHx6b2bDWo7P29piqQ6aIeHZzrdUQO+Dmdza+MIfC3pte2s9kyJD+dYEH1tXMLWwS/Regm7qQBn0QsAHd2lu9yK+OZbqJDJAw48aOHYH4v8UD4vwuczTdo1bwrFl296pc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dym/Xevg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21539e1d09cso45936765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196891; x=1733801691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7u1S0eHhsN4mYxNA4iXN1JMBrK9KSvAJK6vFPRdxHE=;
        b=dym/XevgobvVpkFA90Gtd+N57CV83KyHJtYdtRa4NNQ/sqyVAi+a6rxYuMasJ83Qxo
         KXkNVQPp5QUWytLtAJjzJMBVHdrCMh0AtQWT2C9PZhHI1hzX+n2gtRiPItDF7coCJIIJ
         1M/xFGm0O7Pn3AmAMBrjJmegU9YFKLjfv4oUi3HroA1s4N8tBszmnlQe2wVFzZAKHC9W
         Ml+l+gPHDk2Q989VhCd3X1vEfgBR5wwU6LEZ+9NeqzdscHMzx9isRFNwaxLenerzCwZ0
         U3OScBaE1x66yvSeBHydx+lZMT2hTnPBDp6gw2bGGr1icIN7V/83rWrvQwYczYWvP7Nh
         H4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196891; x=1733801691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7u1S0eHhsN4mYxNA4iXN1JMBrK9KSvAJK6vFPRdxHE=;
        b=n2Cg8UPqc5N6gemzv9UHq3zbokPbbfBY6NMTmzu2lTgLZptcinsl8ugkTfqbOaZdDr
         MrMrPxtaOtwJGVB3d7/mpllRvbJmBHIRMZIXC6yRuYqq3MWXN6LXRC6jVdX9SME4Uwe+
         hYKnZPY6LFq2G4Tcm28S8tXSOaRM6q1S7JnTjgshskgHwE0l7JegkqMHY9vhGqanLV7h
         YmBNbDId/ef7AFsm0NGzUxoEm7e5SApkG3MX3OVP602rGKFG+tSBn5HRG9dIagFfZhNP
         jPKuT6DU5kKZuckYg3l8D7mjqd6Jd3A7VDZNyIu/N9Ql3KX1X1H5qrjpnnvPewXg6ZZM
         IZTw==
X-Forwarded-Encrypted: i=1; AJvYcCUgIhE807+1OS24yQaedorAThanyY88qvyjpfjP7NZLG/lgbzyZioy88h24A6qEyWrVWy/rAuVQK7G22hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BoRNsrkd2N/IzQnDlTd+8UcWoaJFivSqfMDqS5Dkqgy6mGnC
	XcMGsuVA3aKVDyn1vCc99ing9Ec/qyeSI7YxbfbGmXOix1CI9mx2WDBRu7xvAIg=
X-Gm-Gg: ASbGncsHf+V1f6Fj/fQNlLXXFlVMEr4RYfLBObDqFgNC/876UX7dZzdTjuZSQxite8Y
	M157KVuGrKZn7yhckIuY4FVinypnCMaTsziH0Q5YBEWGt/44UPJu5pOq/jCuXR5odefMlojqbvF
	/mZYCdWtT8JN+ArUytq3CZudD0veBzHjJUwDBs3XJqqEhJn0lgR0yLFfX6guOaltPy78LmL8fyV
	YYboFe4z/WCD2TOAX7ygZ3jXRBKrZdwAlqwSZAA7tMJ6HZwXkFQIqn5ebE+NA==
X-Google-Smtp-Source: AGHT+IEQVYb1UMuUdfZdRH588z4/zfIk7I6L4N+qQj1+gNpi0vAJ5WzL3BoXukZp5mc5P8q8Z5nYaQ==
X-Received: by 2002:a17:903:1c1:b0:215:6e28:8260 with SMTP id d9443c01a7336-215bd266031mr10635355ad.50.1733196890290;
        Mon, 02 Dec 2024 19:34:50 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:49 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 1/4] nvme-tcp: fix the memleak while create new ctrl failed
Date: Tue,  3 Dec 2024 11:34:40 +0800
Message-Id: <b4957fa602ebb3af58872042d8e3bf1adf3b386b.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


