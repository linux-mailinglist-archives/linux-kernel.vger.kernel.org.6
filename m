Return-Path: <linux-kernel+bounces-423195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60F9DA427
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB51B216F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77AF18CBFE;
	Wed, 27 Nov 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnQx+8k3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F71154C12
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697542; cv=none; b=VhYuLunSNclv+3kNIAeT/TbugGnb/c/EeeLqmEHllnHZ27Ly+zsiK9mWrhuJzyuy3L3vM0VP5nFvZnt78EOUCBYS258qAXs4bPY29b2+iusw954esyW16t3qu1PKmLIrGh4J+u+m28+NScggXlBdGsyfvEieK6G/NzpS8veGzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697542; c=relaxed/simple;
	bh=uCK/Xd1aQIJ+wac+ROo7rJ0da2p+8gibtUppcXoYDQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKQ5M67YOQ41nBSszgX4MmsU2pnQdTFc/b9k+XTRKCjPuXTMjnR9Zua+IjTjQsP1HYt4hlIH8lRywNTBWbJt33ZW1oy+zsqoysJRymu1mocPxCD53uWpM/KJN8ET4XOrR6h+noB2b96FrQQuV8HRHTco0s4nnIhN+j/572XHKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnQx+8k3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea39638194so5611118a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697539; x=1733302339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjlAXoFz2XIqbM41yoAxAFwBhFgti6gR6NuKnlZ7RVo=;
        b=EnQx+8k38Bo3PNbnIrv+exhPiWODueZNaSEW3pu2Qj2497PJQqFqP2oAorpsmfcL9a
         tNXbY6sGkhh0y8ovxm7tyLLeYdm1rJPhnv0Nc3LecjrcDYQp3kZrAc0hTYkmmcnMBMTc
         gA7Doy0lIPuxcAj0SwCYoDairrlcfTIXzfMeWNnfRVoi91rxlMdwY6NsXzd9n1Q1qG30
         Vj3RXkXZthSzNwU8DKVStLASBjttEep8HcESZzRTqwQOFZiYGCwlz8c/LyGvV4609lOi
         0xP6BA78DUV/jrkDrM+JnI+5IGE2Ff85x2zfuw/H7mmYkUJipoZBKepub1cE9WTEI53a
         W8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697539; x=1733302339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjlAXoFz2XIqbM41yoAxAFwBhFgti6gR6NuKnlZ7RVo=;
        b=Cm48iCQQRJg32EGyjhxQdnTeQYUB9ztbscJdoEr7EEv+VM8S8q0omgJ6l37j7p7/d7
         crlwo4WYwr4lbr3aQFcEmoe7WmNc8T0CHAHERsK9WpCBgScOP3NEw2K2IwbSReB0f3OX
         ga32fEgSXAX6e7IGKWumyc6XdOWPF72fhCHj1J7C62bl0LN/28aQ1M0dKRCfWMFMQRrT
         Jl4+L0rlDc94ZdXaRqNzr+2hlKknhA1Diwdu93W+qrmCFV11+1b1Bsa3YLlkkZn4T7NH
         tvt6ZwYqePwntm2lt+VLK3e2X/Rkx/mdawp93Tdonm1IT5NyqBRb0ZsNwcrvkrbZUyxw
         WBvg==
X-Forwarded-Encrypted: i=1; AJvYcCUKUt0YUvvbh+Aj1WVdvsMjoj3t0E9Z0d3M8ibuq1PCP+GIuAX3j4u/F8vigjm8edgRpLaDAH48EwNwDRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eEDtJjAzluGePeMP+/Ap+t9fu3dtte28ZEx4SWvH0Qbwo8yo
	ErTzT5ErGxzKREoGHrQqUbIwWNmvCzWGUsE95JqBTpQgPm19V731
X-Gm-Gg: ASbGncvsDlRFNMA8opPjQlvrKatzEDeHGYmbamyrlp/zLiUl5smyv65rjNy8ZEIkA12
	J/7IFueGtSO+tnrtZrFwpM88Aaty/IRZ66KP/MsuKQM4HdUfHARINY4gyRl78VZunwxffUKIJOy
	ssJsBeUITHzUMD/tHOt8PV/ScF0IpHj3UY1UVNocZeLte3VRyp6qLl/bv7nuQMo4UHu4gP7bjSm
	y2w1UIKU86rxY26Ym0UJiganDs2/12scdjK5rHlyBlhH0QXtrbM0QWDZrxtdA==
X-Google-Smtp-Source: AGHT+IGZOzHPfNQAD3KDCajmMQ+5AJWsprxedR2u/LUupJmxIGBxc5DBj64TblnUzXu/sLlbWzFr6Q==
X-Received: by 2002:a17:90b:4b87:b0:2ea:6551:da5d with SMTP id 98e67ed59e1d1-2ee08eb2b6emr2727673a91.13.1732697539243;
        Wed, 27 Nov 2024 00:52:19 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:18 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] nvme: various bugs fix & code cleanup
Date: Wed, 27 Nov 2024 17:27:46 +0800
Message-Id: <cover.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Here try to fix the hang issue of nvme-rdma, memory leak issue of
nvme-tcp, cleanup the code of nvme-tcp.

Chunguang.xu (5):
  nvme-tcp: fix the memleak while create new ctrl failed
  nvme-rdma: unquiesce admin_q before destroy it
  nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
  nvme-tcp: simplify nvme_tcp_configure_admin_queue()
  nvme-tcp: remove nvme_tcp_destroy_io_queues()

 drivers/nvme/host/rdma.c |  8 +------
 drivers/nvme/host/tcp.c  | 49 ++++++++++++++++------------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

-- 
2.25.1


