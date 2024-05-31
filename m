Return-Path: <linux-kernel+bounces-196578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5A8D5E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C88E1C20AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7DA78C99;
	Fri, 31 May 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSXl6MM/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FF770EE
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147465; cv=none; b=HN18vMpLZY2+f8RjNyGhhTVqSbr6yF6fXFjoRhm106zUWwnCuK5yqi2bVt5kpZvYbwHyB+D1GssQfxrPaUUYv/cNXgWrraowbhah5SQT5gPqVPmAXI9lAEPFtpbDPRuKnY4ccoLvs5Jyfw07zE3G+2HthMWSDS5ZV6Tfkto0glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147465; c=relaxed/simple;
	bh=njpPL1V1veKANz+pyjKvPcN17ctn8E8cPDIE73nMeXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VSFHIHVuiMGzch4oIGgZUPrGz9qjxgCBFkFKV8DCyB1NaCB9PsT6VEFqng12IberuiWRT2E0jYnul3iUbNlcSIkBS95FFhMmc5yz7y9kHdSfcxNm5BBvG6Bu1Dk1FDPxjXoRQ+HW0UrP00XEKeyZS/3YyY3XnjP3h3Nhi+CG8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSXl6MM/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f61f775738so11638735ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147463; x=1717752263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrKkBvog5oyiwqctC5TCQKtV++LMDGUX2RPtvKV8xCI=;
        b=DSXl6MM/CVfNGKXsmOmQSSqdMd9sE/X/IesPX1xuyrA4PwuCiSL3Ghc+YV4SSZSmn6
         yMBc8gp2hUxORezbEQnqPv8thlNpFn91pfkRKXTVmkLrF8mKHYsu2V0ryEdppTBf/5z/
         YEfPLz9/o3CBdPkdb1YqS/E4Uon5oFWZRsm2nDFxbpraHUyUPqmER132i6HYMjXahPj4
         Xhp+rnbCio8YBH4hQIvN37ZFfxkUeMGg7eGuNcJutFj0AV2XEmWOG2ijl4nidCOoHTlv
         bi5CB1bV3+FaVPNp43gWzRlNyJt+Ca09tu1/NWP6JI5HJnDAoNS/9oW7+qZNNCrrjnWR
         NzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147463; x=1717752263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrKkBvog5oyiwqctC5TCQKtV++LMDGUX2RPtvKV8xCI=;
        b=vaMyuqPvDa47AD5ZZvZCjd3cO8nW0/wTBYjOrDlKvbzYCaWFz3EjVQWXuJ1/oBx7BS
         GFI9A6kd9EqRC8OLfDIvJp8AI5zF0kx3Nuf5y8+4bYNqT2ik4QjZUZhs+xsPP1OWi+Jc
         r8DRWzdUDY8eIf6wxqDnZfJcw9c3BZOc9q3R5HQ0dqK6B2KlaBa2tgFlmxnv9836qOjj
         ejvh/5GHYtlXVbAv5AEGNqUJK+ibE6hTj8ZBRgERveQlm/TjBj3q4zWekCV4wHIyb+lx
         LgNVnawd6Mjzx9yf5L2T0KALKVwPtmdPbUZj8uPI9W2s/pNsWdVPrf0o8hxcp6IS87tq
         414w==
X-Forwarded-Encrypted: i=1; AJvYcCWHr2+6mCu7ueTbRGb8bdtVQZUUyeTiTBbXpQ/kC87IuSi25w0GfLCmQxePuGaM9/mMMvk+nk27G1pdQo1SgMAIBdjvyOOPJENLFSch
X-Gm-Message-State: AOJu0Yw5dIFEApSPwRS+bz1dzELzcsbY/nl4xWt7I6k8wmCl0RUGWvTU
	q5IT68ELG1hMzUxm5TsmxShlaesOt5GTZ1ywpZj467rC1nip5XlKyDvnMvrCZFo=
X-Google-Smtp-Source: AGHT+IE6gGq+eCrjF3uWKXdUrVl9nCO1Z75cjEF8h5pRBPogQzDAKCEb/EdSACkI92nCASHWM37d5g==
X-Received: by 2002:a17:903:1249:b0:1f4:b858:5fe7 with SMTP id d9443c01a7336-1f6370cefbbmr14952105ad.61.1717147462737;
        Fri, 31 May 2024 02:24:22 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dde85sm11870975ad.149.2024.05.31.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:24:21 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] nvme-fabrics: use reserved tag for reg read/write command
Date: Fri, 31 May 2024 17:24:21 +0800
Message-Id: <20240531092421.317296-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

In some scenarios, if too many commands are issued by nvme command in
the same time by user tasks, this may exhaust all tags of admin_q. If
a reset (nvme reset or IO timeout) occurs before these commands finish,
reconnect routine may fail to update nvme regs due to insufficient tags,
which will cause kernel hang forever. In order to workaround this issue,
maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
tags. This maybe safe for nvmf:

1. For the disable ctrl path,  we will not issue connect command
2. For the enable ctrl / fw activate path, since connect and reg_xx()
   are called serially.

So the reserved tags may still be enough while reg_xx() use reserved tags.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

---
 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22..f6416f8553f0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.25.1


