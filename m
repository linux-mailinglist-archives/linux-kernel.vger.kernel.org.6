Return-Path: <linux-kernel+bounces-428655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE739E11DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3261F283444
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884018870F;
	Tue,  3 Dec 2024 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzQxG0Oq"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040418785C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196897; cv=none; b=AZIvI6NFxQ1nhmxUbxC/xdj0glR4pP+Q8Jl0cXSbJiejA7DETKgkVBsa6RLmHGLolUr/0wSO40q9//2s7NSpWeCW0ykIQJtqP208RvBfQPCGFs//JYXz4YLTpiCAZ1FhhJnCAt0vs+2oObApY27xQSGjFvgyaSCF3QPMsN6A9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196897; c=relaxed/simple;
	bh=gG8MoTVX1P2xZqP+L+DggxSp584tVnqDd56pAULoHFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JATpr1w/IeR+/EBetOMjtU/aGTHPzMiVHS1GEEaQvbX8dPkUEWesU7brP5TYcAy3YbvDN1Rdw60bkrF5LDssFNjNbWEcbj587w3DC4o+GdDF8N9bQH9p2Kl+Y5YhRKobZxK7JgFHxYg6cAytVoedCkY9ETFdG07Y//e5UbtXssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzQxG0Oq; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fbd70f79f2so4825700a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196896; x=1733801696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6AV0h7FNjp9FEqh641JiaIQjrd1pHaDZb70DiuzgZI=;
        b=LzQxG0Oq5XzSQzg7D1WHIsmBh6EsNDTO+uvCK6X7zV311nnbRkf4vtFRW356b5ATsu
         WGoQE1cCJ5G+oYiclF0J5KESFAT1ORqdo+mwTjvHbBBTebfbe4MWsE1XYhDbQf6zxU9A
         VyqMz31K74oapjnwI4uMHNKVhi+3hL4yo5m76LItTITvjvrQUjKcQ+TZTVkmbtc+ONfO
         f86JFq1NH0NVNT5cVv8wjHoVgC/WjPdG6Ipr7LvKHF1PPS7yjV6R1+Kxe2haAzdNiB96
         Jo0PBb3rqJFTyR4snugGpZSwKNrCOHxoobbHQgOs5R4Ef/tAgtTTMEAK/wSCnxowcFh2
         /0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196896; x=1733801696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6AV0h7FNjp9FEqh641JiaIQjrd1pHaDZb70DiuzgZI=;
        b=MaXf6t1tib8V1g7A2uH40tHc+ZIObczLukvh36sqGiUQQyUth030l3WRCsIrJ4/TQl
         m86bQaZalxZV5ReY5/06J9eRGpxcIVH2MLFPcKsh+EUq127svHEQtSqK565aLivrMdWG
         913IInt2GdUdY2pAH0fnGD5QaNgzxnPEoHfbVTLnjCTqC7mnfWLsvZ9SBmRBd/BUwRqb
         8nqGZf1f7ehepk7CBnCWZq5tkRzbx4nKcGq8APgVDba6G71heHM+6S08+499GfZg66NC
         7KtufIt9hzbQBxseB+bN3lmR9/ZjkiPl2fwebtgfLHWXoTNTsyehWRH8I/CqBQpicnfb
         MkvA==
X-Forwarded-Encrypted: i=1; AJvYcCWKede1lcg5OEtYnbBqbtloQNFg9LuIfPB+T1bn7M4Xuq473hpWMuIZ9uDi5cbXyX4Q062+PJjWjUDhk88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvXRTHxyFUhBrZc3NLdCmGCpNfBuKiWg/pzwqhvRt8woJvTbE
	js6cdKy/u9fZNTPNK1fWj1sr9ivGBCzfM3KEebpLNUsVde+jqlyL
X-Gm-Gg: ASbGnct0/hujkQOmtPZKtqL5dDcewM5TLeY+oR24VYpmnK7dgoHxqQzcHgROH7J89B/
	9aHEvgwQ+6mkXFR5ugXXfBmiUVLHlXoa3zeIVTybCI7ZOg0JdpAMwKDbC3BGuRVbB8HfBaQelmd
	yh9MRvroiakSvl/4TjZyQngZ3JiZdFalz/4L5o7z7s1sdhO9iUA0E6Q585zud8ob26RcylUQUyU
	IcWG+hd/SinG0tW9IxqDs2HguAv8M2LRPwKzteauH69aInQGYCOKe/apV2APg==
X-Google-Smtp-Source: AGHT+IG/3v6d0HhuojT/rCyNJmBTQDwDmQb89wyTD19L5RRZmIzLFQmfix9M6IAIezSRwrhdjHrdYw==
X-Received: by 2002:a05:6a20:748e:b0:1e0:d1f7:9437 with SMTP id adf61e73a8af0-1e1654134a8mr1688465637.38.1733196895660;
        Mon, 02 Dec 2024 19:34:55 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:55 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 3/4] nvme-tcp: no need to quiesce admin_q in nvme_tcp_teardown_io_queues()
Date: Tue,  3 Dec 2024 11:34:42 +0800
Message-Id: <1562477fe9a03adefddf551148882d27a01529d7.1733196360.git.chunguang.xu@shopee.com>
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

As we quiesce admin_q in nvme_tcp_teardown_admin_queue(), so we should no
need to quiesce it in nvme_tcp_reaardown_io_queues(), make things simple.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 55abfe5e1d25..98bf758dc6fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2178,7 +2178,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.25.1


