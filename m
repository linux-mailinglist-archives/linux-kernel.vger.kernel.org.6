Return-Path: <linux-kernel+bounces-547177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3833A503DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439641891CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235D2505B2;
	Wed,  5 Mar 2025 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DznLa6bP"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6C2054FA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189987; cv=none; b=gH2MoKD80155SGFPqc4rFHqXTvuDlTJ10X7TReqA/kI7va3S4iXbNBDZpwoiAt9cQWNzOGX9JnSSYGx0fi9M91CAUJxzJ7nyu6KrH9Sy5hh//nOS+aib4/0UthCatOLLux0/sG2G7IslBXlcoKzmtJIqjCp+QCoy5OrY3QsQnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189987; c=relaxed/simple;
	bh=ejgUc/LZ/UfsVpSHUflxnnj8E8T50vAH+ZXLjI7I/3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lmSz6L7bToT1ZsAgwEsyrINlb4Uv1D8gr4PrD105OEvKNkYd/5a4DyG92oAk0cu9lshKzKrK43vqJ0jXtbz5qMo1RnyL1p6EmGjuwZYZurhTvRzBZ/f1KxUY2oXwSayTwomsQoOWOgX8TaJ7bRdV3jtNOsbGYCUhX7DQr1L2crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DznLa6bP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bd45e4d91so5214295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741189983; x=1741794783; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c462OaYKk6lfJmqhikiFrNOzY7hRupVX/eToM6qJ92c=;
        b=DznLa6bPiJv/ps+xhkey3XUjjpmqIEBGRR0oWlk2LrWU4JMr63j02Urpy/CW9L1STK
         9QfiHJefR+586E42t53Luj6ySZxNFrM1CjWK17OyDIRViTPnsD0hETMK4JGlD6FiLWQW
         xvk04Pow4chehYBbqyp4wre7ZpEFeGP4wjzmfumWfF4+ci0rYr6Hgs0bPqmXEg3mbTPB
         aa8n+eVGuEcmGf+j5eVxqqUdMCZ057salpTopGJYLanC7rnZMAJsMSqjti1H1hODB+P7
         +ndjOzjd36aVIL8ZS6CqP0oBgzJ1LFJqx8K6jX3MbNJPTN7gj2MpN7dECvUOKXtyqv1N
         RBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189983; x=1741794783;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c462OaYKk6lfJmqhikiFrNOzY7hRupVX/eToM6qJ92c=;
        b=RukJmK5/RZUE5x2ah5S/RDAtgzMdrIs8t6osaBkrQKhWiuiQukT7x6TcOwa4awuhms
         RnN+tfx6BsZCTJ7LDXROOnP4A0pjI1SmpHc+6crEX/70ofr+Vffj2OYmXFrIl5T526bQ
         RcbZYVZcKAHfImN4y7XzzOL8Tx3vuv31r7++mSugMKJf4hKh2GoOg98gQ0eqLabe08Tf
         JHUuY7CRbQrvm+s3atVhNpe3P8G4F+hhwmqX4ePI8zJ5abqPiuc+W0qwdTs22ahTtDhj
         hPuHK7PuIiS9seGdhYWI5nBMcMUJcZivHvn+x4lbLHulY/OZQv/JsMtQiQ/v+DlKXgjc
         7G9w==
X-Forwarded-Encrypted: i=1; AJvYcCWmotpL4OmSKc0UvBsF4cmqor5wZ4XoypJr5fCTO/wsaT6Ng+h/U4b+Ac0I812DLC0WDpv1HHIQxPeGOIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7AOpOOzZYP3oYogwofGV9PztIkLTU5MDZpG7JHdMMYtNx+k5m
	MHi9gWDTu2OlejU3oRY19V62btg5Ngboo9RDXuVlFrty84yNgsqH3XZxAiKYh/E=
X-Gm-Gg: ASbGncs7sCK+VDfSuCb1kolUDtcTVqZkGL0WoztbGc4o/J9uEg4+vDtvP3pAbPSaojQ
	f7mXq3NYFX5U6rVVA0DNgYc+uB/SF7SST98Sfc/fu31lxvybd/cPo06/Al8ZFNqgLKIO7AXOB4M
	81FPFF3wslq61iBD/qzav9rHCcTHXInlbqDnPTJpIrdx+7q80ZKhEh5bBKL3dk8sysCRtre87cf
	c84DUsNvkSF+OYeJSLj7H1bqN1OBRUmz3ENy36+qgHSIKDrI5VYagQ1CEjLGIDPs9XMV2jjbGAL
	B9+zerr2h2nHKlpQaiDTJzbYuHRMqXa43ogjMQzi55NUa2D4VQ==
X-Google-Smtp-Source: AGHT+IEqknS+DmHCo8DS6gOa0BLl6DqpnB9v43dYGVNmBmhgHO9bWC9dVwlJMAbbJBAtRqT0CdjIig==
X-Received: by 2002:a05:600c:310d:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43bd20b5147mr31087475e9.7.1741189983473;
        Wed, 05 Mar 2025 07:53:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd41c7cc7sm22761795e9.0.2025.03.05.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:53:03 -0800 (PST)
Date: Wed, 5 Mar 2025 18:52:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
Message-ID: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kernel_recvmsg() function returns an int which could be either
negative error codes or the number of bytes received.  The problem is
that the condition:

        if (ret < sizeof(*icresp)) {

is type promoted to type unsigned long and negative values are treated
as high positive values which is success, when they should be treated as
failure.  Handle invalid positive returns separately from negative
error codes to avoid this problem.

Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp PDU")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v2: Change the style.  Add the Reviewed-by tags.  (I will feel really bad
    if I introduced a bug in between v1 and v2 and cause everyone
    embarrassment with the R-b tags.)

 drivers/nvme/host/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a9131c95a3d..b23ce31df97d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1495,11 +1495,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < sizeof(*icresp)) {
+	if (ret >= 0 && ret < sizeof(*icresp))
+		ret = -ECONNRESET;
+	if (ret < 0) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
-		if (ret >= 0)
-			ret = -ECONNRESET;
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-- 
2.47.2


