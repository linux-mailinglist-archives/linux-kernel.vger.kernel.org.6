Return-Path: <linux-kernel+bounces-428652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477A19E11D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB58B21995
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49C15E5B8;
	Tue,  3 Dec 2024 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmaNaeFB"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7853D1FC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196892; cv=none; b=bMoYslF4ZVbioh78caUdKv5hyXQUc1jmKsxHDtQIrBfUCYL9vavMOtFvXnlZEn9TYs2OTmdyPjoE/BKLe+iQQoyIBoZSHmOkkYD38DapbUAKilsK1M6gjLfBqcymRxuc1fxxh7/cn5fMpu/6pep9dXTin6GrcxSnJmLveSMFbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196892; c=relaxed/simple;
	bh=L7U1nydFfgrQOWCGZS4qJRJZctZY4dxZ2e1fP1mYc2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cs63Yc1R6peLNTUWGgHGr7VTpFBkCKVbym2p5+tUoUMHOO/UyCaFf5UPMXZs7wM0OBkLO7luCa/KZFLEv2fgzHIvQTCpUbh86BvmC3bbI8dslT4aQBRs9uR9YmOMJuW1zvLWLt9iQdTkqAZq7v53D3Lwmua6e6iP+m1tlYn0NaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmaNaeFB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-214d1c6d724so39162875ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196888; x=1733801688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qad7UAjPFB3sv8Qh6ihgGL7fJSwXVqBT9HWXeuX/QE=;
        b=RmaNaeFBgxzzFqYBwCqg/EzEuhwktGubI54KZZVQO/5uKNQwKH+yoqh8Rr5Y+7LT4I
         slVJ5ysBOwAP3tFLNMw+XT2E8Bc1tbwsPNX9Wrv4s9iaWGvQQKxDnlnUAaVmnhw7V+v6
         ccr6GSKsf8JIIBdLbSieM4FF55YcBmffDHvb8IAjfJYWNtCoaUgW/Wnzg3bbd3dSHFOD
         tdJ70yfVx89wNdsPX39loCIFbJ+LqtRs8L3yhJ1yw5JuDymXBpiIIRGECBDYYJ+WBAVH
         aEnscfC2Pjt+A66o5aj03jji6JBxPMjEjlVBhB5Hw4bY5HcNBYntB6Eo27UXmYy9LYuG
         yUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196888; x=1733801688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qad7UAjPFB3sv8Qh6ihgGL7fJSwXVqBT9HWXeuX/QE=;
        b=Lvgb+GFDyaNiCuSldUaWtgqRDsRmsR49a4B9/uhIVFs3MTRbCSi/LSEhCkWWZrTvZG
         9Qf5NWkErKt4t9jP9mLr71XUBk8bnDBYMSAHTmQoWOiXI2h6D8LefI/r9w7+OjC6AWcW
         lMTtJnUQ8GqmPzmuQdBkIZ0yTyxuwZJ9FxAqfAb26jozRRoqrHx7Cv4MPzHGJ2TSdNIp
         qI0gu+JXHYoGf84mG0G0TT/hHdj6nuUw+iHh2kGkoWLD4jyaJgyvixpvc2u72R7NwkQr
         J5PlzNViwhoOW63oE1dXzKV5wrF5qr2OdEUYhhmMfogYC42iK6W+fy5d2yyI6POUbb90
         bj+A==
X-Forwarded-Encrypted: i=1; AJvYcCWofXDGXKVdpfVXF+vbBYL30J+3Twrlxh0tpdIhMnzQiCMK26vWDeWg0cXew3E6TK1A7wcsw72eJ0vqcTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAmUgSMgTdiH5ws/UuAhpqxEh2AegtzhiUaZISrICl4CEB61c
	9hqh+bqgdQp49PSkijQruYbvpdwcNUbNtnyorup1pXInu68BdpGz
X-Gm-Gg: ASbGnctb8iSGXuO+tboXhSq1o4lMe06NarmAkROnX9Q67NnpG0//g1A0gANs4juhOAM
	Z5xh4xyJ2xAAZtIhitWtaUHKynqVqMenR9M2FxJ+U7QZTIEdSRRYgay7N36/Rj9/BQJmft89DHR
	0iHGPTGBXirV3vvn4ay/8Gd50C3qUS7G64GGFZv/vAQ4iNuPWnZQE+9qje/xEhxZ1ERy8r2etJQ
	/mYbDJQDjfPwVMmb5Neb1A2PV72YZ3bFBZsewIDzyhaCdy6f7kXih5Wve6zDw==
X-Google-Smtp-Source: AGHT+IHYsCiulfikKq8SXVX55DiDBnsAUlHnBhrLpFkvJ5VkPE0a4ZqbrvjPdE5a1iYYNJH9GI4C2w==
X-Received: by 2002:a17:902:ec91:b0:215:8ab4:d00b with SMTP id d9443c01a7336-215bd10ebf5mr14939785ad.30.1733196887738;
        Mon, 02 Dec 2024 19:34:47 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:47 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 0/4] nvme: various bugs fix & code cleanup
Date: Tue,  3 Dec 2024 11:34:39 +0800
Message-Id: <cover.1733196360.git.chunguang.xu@shopee.com>
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
nvme-tcp, and cleanup the relative code of nvme-tcp.

Chunguang.xu (4):
  nvme-tcp: fix the memleak while create new ctrl failed
  nvme-rdma: unquiesce admin_q before destroy it
  nvme-tcp: no need to quiesce admin_q in nvme_tcp_teardown_io_queues()
  nvme-tcp: simplify nvme_tcp_teardown_io_queues()

 drivers/nvme/host/rdma.c |  8 +-------
 drivers/nvme/host/tcp.c  | 17 +++++------------
 2 files changed, 6 insertions(+), 19 deletions(-)

-- 
2.25.1


