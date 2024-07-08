Return-Path: <linux-kernel+bounces-244014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161D929DF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2640C1F231C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28E39FD7;
	Mon,  8 Jul 2024 08:05:15 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464EB38FA5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425915; cv=none; b=SjNpvhZfJYSzq0dD8KXdR2749ZfpPIjSsfosEHBHiA2iYbEcPKJIJxwAUPqaact18KDyjKcbzpa+aH08F4SJFMxh2xfo0gRQG64gQ/uR1C6EUgJOeAbvvHNkWk8ZKgVaxjB2uGZ/7wHrueC6bJvyF21ZYuul2YWJZKZjFZSjCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425915; c=relaxed/simple;
	bh=xQoNS1Tk+szSoOCXFIOMqOkk0zQn1dyH3JBGi5nkLqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G09IatdDFF90DGQ8lZPXuSHG9VhtbczDKdHac+dUs/cAX71Jj1GSFoc2L7eglNUGYa7ESVhTkHpkQFV+odsQRgsX6BPkyOc1tyxe4wDabrPshkxYzcAmiUkS372Et4AXtDjp3e1NUX5DXr2Pg3Lxzw0RU418l81Us3Cq+7oTwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABnbsqsnYtmDZM0Ag--.7496S2;
	Mon, 08 Jul 2024 16:05:00 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jlayton@kernel.org,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ipc: mqueue: remove assignment from IS_ERR argument
Date: Mon,  8 Jul 2024 16:04:04 +0800
Message-Id: <20240708080404.3859094-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnbsqsnYtmDZM0Ag--.7496S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWw4xurW8uFWkAFW5KF45Wrg_yoWxGFXEga
	1UZ3WvqFy7GFnI9w47urWaqF1UCw18W3s7Ga1qyFW3GFy5Arn5urWrAr9FqrW8JrZ0gFyf
	Crn7A3yDCw43GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
	ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjH5lUUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove assignment from IS_ERR() argument.
This is detected by coccinelle.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 ipc/mqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5eea4dc0509e..a7cbd69efbef 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -903,7 +903,8 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 
 	audit_mq_open(oflag, mode, attr);
 
-	if (IS_ERR(name = getname(u_name)))
+	name = getname(u_name);
+	if (IS_ERR(name))
 		return PTR_ERR(name);
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
-- 
2.25.1


