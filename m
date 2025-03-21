Return-Path: <linux-kernel+bounces-571919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF7A6C452
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D95A3BCDAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CDD230981;
	Fri, 21 Mar 2025 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I1d5QWW1"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4096137C37
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589409; cv=none; b=BTVXyKdI7nnA4wA1hO8ANRaogg6rqegZrDhy0FFvjpRfAOH0FRau2YoGuonvBhfzoTjGiYTQQ2V2rVaZCU0VHZ5Rb0XYLf0nuZANhKq2y6YFaiwaBWRWi4Zc6Vk/Nbjsw8SckK3rGB3SV20MvcH3WYvjvHV8DiKXfKqDv/KyjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589409; c=relaxed/simple;
	bh=eEEzuF7d6T7hcnHB9cj+EdOT28oFZoy+E/XEnhCmXvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsTiKQwepRZGztqjMAs/a73JlHBVeatOIj2228eRpVm3ayFk2BcYjr7yaf3mQnWBSTcVY99Eqx5XhZUC4e6hegEN268SXGZf2fQa3uX+4OQGo8zQRGrqPFy+dr0DivJgdXCcMPDlLRi8mLcwO8TImkyA7Wvxrsfi7PGz37Hv3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I1d5QWW1; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2241c95619eso6348405ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589407; x=1743194207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=I1d5QWW1f61lgdgP4JG5BZJ/2z2v/8dLKVqYjIGTClbT6f6H6zIw/wT4n5LEeRqAH/
         5PDP+T+E15+aoq+BvWllqx5SJSvk5AAQuEzYESvtdT8zeJaJ9fVjQZlPTNKPppgMpkrC
         Ruwp7AQBeF9WE0rm5BqMG84XpsWJp1BzwQD8gATkfCqvWb6HfKj146Vw0kONkqIZFTCE
         OLl4WAPAfFW0FfeOeVO+iV53ZoBeHxDvZJ7BwItoweBqZX1Lr1KdVbUI9A2EFWUxwxF/
         Kv9wAnVJTlW84y/4DdeAG+JvXyoA4HtgXKddglYfzlE/R3c3aytmJ3VQeRL3CeN0sUUH
         pncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589407; x=1743194207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=On7PcoDCDUSeV5B2otTpwWFN6hG9+1a9Dd1v/MUB5xA7jU4WJcbf4kuawnWvHJa8w4
         iII8gYMgA6GyCQ3IreodDPgYO5rrcbbRQCR4K0pDQiCLuH6aRgkRgLlxqMsTrFREkB/9
         kAMXhHPLzTweGhsPOVffcoaWpMq35cmuLHq9yiHzxr4RyKcxj+aXjNfhA5az0f/RqXaK
         OJeWLjgcduMw9jHl2FKAEX5IKQWNJyqxJhsiako9LLoP4bzTIW5FGEBbwoayEIfo+TQq
         0srGKyNi81LZOY0WTqrJrEVeC7TmcYw+kqI2YOqFB7sY5YCINUUaKunr7WijJGP/kuqj
         exFg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwWOXWpcrgrbdWnc+37YwYDF7gDcpNI5H7prps2hs1fAG0BYY/Mk549fzfAbUb1CfRTQMMtYNP3TRBp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYEZRJP03TYCwXxYCm4B9k4wA4QpZdQmqbUi5R1OQmgKhwtYL
	jrOZStS2FbtPdz8SBrkHYnmf6qECwhCUzcsaYkRJOQdmCg9V08RjouMRmaIxSpGWy6eTVf2zelO
	xX1SuDCKvcT+Os40ped1yVvCmQEKaut2Jg9YcxfTvCrSftbtK
X-Gm-Gg: ASbGncs9Jw3ShC+FKmoeg0Y8LF7TiqxxbKqi3ZOK3m6x3lyGZgBQtI4e6nfg5iv4wUr
	/LNheYiXYZnRO7LfXWuv0l9QafoMNMMmzc1xHmK0WMuVrnnYab+1+ZepghAQxKXZsiJjmDq/coh
	nAa6fu2p16+yWK6JYbjlgNILlEY+w3xOq+xlCgKMcaFmF0HbuQjnRIsl6oWiABJCgKtrQ3E8J5u
	HIk7CafO3ipsdu2rYCS0+U4aiGv2BTrbiW9LAprcz81qwdzHU2Pegc3TC1iyjYF2eTqDo/Sqd0e
	eIFb7TIC8ccd/Pu4qGgkQV65WvlGAzEGvA==
X-Google-Smtp-Source: AGHT+IHIlCrPC63kG4FZ7I8NTyIsbgX90yahqg3Xui6KexGNSfTMzvp3/NM/3gPWtxvwIO5KlRHxc+uTqm5K
X-Received: by 2002:a05:6a00:190c:b0:725:f462:2ebb with SMTP id d2e1a72fcca58-7390564f629mr3047420b3a.0.1742589406597;
        Fri, 21 Mar 2025 13:36:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73905efdaa4sm133279b3a.8.2025.03.21.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EFAF63400FE;
	Fri, 21 Mar 2025 14:36:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E2ACCE41959; Fri, 21 Mar 2025 14:36:15 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] nvme_map_user_request() cleanup
Date: Fri, 21 Mar 2025 14:36:01 -0600
Message-ID: <20250321203604.3911446-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit removes a WARN_ON_ONCE() checking userspace values.
The last 2 move code out of nvme_map_user_request() that belongs better
in its callers.

There will likely be conflicts with the parameter cleanup series Keith
posted last month:
https://lore.kernel.org/all/20250224182128.2042061-1-kbusch@meta.com/T/#u

Caleb Sander Mateos (3):
  nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
  nvme/ioctl: don't call blk_mq_free_request() in
    nvme_map_user_request()
  nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

 drivers/nvme/host/ioctl.c | 63 +++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

-- 
2.45.2


