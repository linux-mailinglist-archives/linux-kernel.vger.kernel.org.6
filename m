Return-Path: <linux-kernel+bounces-571959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF569A6C4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285183B69CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB2230BF4;
	Fri, 21 Mar 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DtTVifs6"
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12507230BE7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590648; cv=none; b=LnYzvvcpE6kMk1Gp87D1C8r9YTJNYfGYtaBOmgmIyL5IZc85qPMFrA4fx1UmLcvDMsJaO6EUpdHPenW9CbdqjVtaNHMngVnOdvqmn3OEjx6SHGmurCehCazJcjVoi7ioDfK7xLlp0n8hM0LhazdKyx7Ur6z+190QfPW9Jwc/V5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590648; c=relaxed/simple;
	bh=FqJVruJuk3jZA1jNU+P7yclz+mvpP/olvfNDLk1TT8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0ipUg45bVIwBebqKFBuTBNScn2vuc9Yhq0jTj47p9Gmcr6tNBoOYF9YiCdSamZw1geWje9jfqcwTRbGjnFDuN/lnZCFmIqmGpBgz7OQ2/ofTXHOZuiTC2XpoHYdqCjIgQCwCwzluM3S7SNayS0Yji2lJ1NYzV/VthePGjmTdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DtTVifs6; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-6ff0a728a71so1416857b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590645; x=1743195445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=DtTVifs6R3jjGZjeYT5OIPRiQmch23EDQQxnIzikcAG0XhPhVfHf6NQE/pcM+BV5ko
         1tlobc+5YU72mWPzW9fGXfpFkq3ge+fZxyLABlGGNQolwC8hThdymVKxuIay2WztqOFk
         tolrQIhe4Z3cqR/MZEcuAtOx21+Ip3ClLa2aDIQy6WvGMEhpPU+ICWOWpWIa/KnKiOQw
         4+trO03R2KO03EV20xDHChpDS+lOOliJEx2EYd3gTy77M/BVMYHWquZFDv7m5EVMR4na
         cPCa01s3WS3SKDL74DzD0Tkktanb4kyMdeBxKIpTpfRJYXkohjZcm7OMYp3hk+gz1EsS
         myDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590645; x=1743195445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=XbyUZDmyo+0GjOYNo6CAg0It1/DbpaAoYubohSiGtON3lXM95Q8aO9bXZSA+cV5rn3
         TEoLa9t5s34jowgPMD8dNK6ACQqlO9awMLaeKbHQ5PlGvZrxyVFuBR+q8D3RWIcM0vqQ
         5dAbfayaIP5DjvGyRMKP/FOF0hQ+FKVAcdzD0ysUiY/u8tAEhixZNZe7OY/3dLj+Mzde
         7nsOHbXTwQjrOVdcV2iMtL51k9+83QIKqj4ORQyRO50VtAlbFdpVb1jziL8ECWvVrj56
         H9fkvrtRj83xGfcXcZP5SDbURqF7Cis+00W2qyF19XO5Zr5T+u0rZOeIximILHz2CWS0
         oOXA==
X-Forwarded-Encrypted: i=1; AJvYcCVPQV5KHTUvY6MLU3jxQ69LXtI8vGJrfWmNGtyKesnb542+tOCOEOZ/1WNo9dnP9BBc6PcMLgu3JP8KDaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORQ193gdjHXtwKPXDwMyd6awRvs+CAnEI8QrIXEdpBRh3lF/k
	E2h6xRsRC7EtG63vbMvQtNC13g6TOfswJUdCqYse6eTq85ca0E/mc4BVNHkXL+8fFyDSYITPbN2
	FJovqgYkxv1YbbtaHdXmhHnGWmOKun7Cj
X-Gm-Gg: ASbGncvLtGPJ8C2YTCm/2aniV6awoNfOn8ID2YnhIKApXuFMlziUx8JIN8yfcvQHOHO
	R1qW8GclkJ3VCgyTYz4BSVwDQ0X5eDedqEfXJuEhGvApjnVYtraOQwsF9x/XCJnDgDFHBVHbAyn
	Ry9Z8ClOYdWMPpbAKkIf/5py/iBUBXqtJkSc4ykn2nde+hEbOC+P5WM01sIAXaJu94e0sRvkHev
	CMFuim3LeSO0rY+3A2wFKgIr6PgvlApaJUaO/n+pw/RlwlVmoUMEDh6GNrrqS2R99V6gnDaOzpV
	vRztsOvapi2Ac0o+Vc6G1Y9KeuPGBxJCR8o/dpy5OJpfguE0
X-Google-Smtp-Source: AGHT+IE3BtRl/WSh6iaNlwOEOXdQObIPCzquvtJGf00g7uu5DR/ectGIv8i7vMguwPF28H34WDvjPk15RDsW
X-Received: by 2002:a05:690c:92:b0:6fe:c2e6:bc66 with SMTP id 00721157ae682-700c7681fbfmr8416197b3.2.1742590644709;
        Fri, 21 Mar 2025 13:57:24 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba6da1bfsm1624207b3.13.2025.03.21.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:24 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B9A6C3400FE;
	Fri, 21 Mar 2025 14:57:23 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B541AE4195A; Fri, 21 Mar 2025 14:57:23 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
Date: Fri, 21 Mar 2025 14:57:20 -0600
Message-ID: <20250321205722.3947901-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321205722.3947901-1-csander@purestorage.com>
References: <20250321205722.3947901-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vectorized io_uring NVMe passthru opcodes don't yet support fixed
buffers. But since userspace can trigger this condition based on the
io_uring SQE parameters, it shouldn't cause a kernel warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 23fd22e55b76 ("nvme: wire up fixed buffer support for nvme passthrough")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 41907b4e1869..6c27d72e8cee 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -139,11 +139,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+		if (flags & NVME_IOCTL_VEC) {
 			ret = -EINVAL;
 			goto out;
 		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
-- 
2.45.2


