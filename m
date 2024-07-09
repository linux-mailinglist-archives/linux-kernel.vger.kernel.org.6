Return-Path: <linux-kernel+bounces-246724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C3D92C5C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056501C220AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392918787F;
	Tue,  9 Jul 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="L/lbTHYE"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F3187853
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562240; cv=none; b=mKaaNe5zKRdpdYONU0+lloTW2Ze6+L0no8dAOIRNX82Hrhjo3YwEj6pUYaF3+i5wbYWRB4FBe0jgdfePOGqfynTk42+ml5xXwKg2xSltlCywhf5UKH2emwvGr4UXcNrmpERSFZr27v62cAyHbUW8uR6XXwemUeth2IbPfhRShDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562240; c=relaxed/simple;
	bh=JUqS5ttBBM1omPFCYgFWCMxpQuQRl+1KMMx3uqcfNqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFndxAFuYpdNZuwAHsHRuoHjBsNNpWEoAKK6H4W8vBgaNtaQr6DUTUsVDp6UFbvVdo1oX3rQaqZdp7W2l7/nkhliFsENNQ3wagiahx+ZzcVyzFcsMCLaZguRuj5n5SwKTV1h9BpjaDXrsL69PhKT5oLwnqr4HNn0/YcKBR6a2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=L/lbTHYE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5957040e32aso793339a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720562237; x=1721167037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJgVkcG2gOFg2qkpKsciV3FiyRxdKHB8MVcn4EaNMzM=;
        b=L/lbTHYE//IOA3xtJVToffU9ybVoic8qvNnOkgMQs9tCydP+ZQ2X82mjvrfAuNfEtD
         fAHuYHh1xHX6uMTIX7hK+xT5yqHEBddQgm//xhuTTfNr5SWh3sY1UztxnBKGitSHU3xa
         Pm449Jj7vx7u4X7UBncOGiGQN+kP370Cf1+x4i01vIFlg/PxwDJFz3xiQ4Ex7ZMQg/+v
         zRw5L7bgE4IpsujG6kNNQKTI4zNpUglqm5/on3SY3V22Ln2ToM10WwyAHmOVFQ7B6Gy8
         zJ9IEgZKqyS++mexlyagT0E4hGRsAhCGSCFDEbrMlCoulMlmFXORPVymF6vBEiH9MJlF
         yZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562237; x=1721167037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJgVkcG2gOFg2qkpKsciV3FiyRxdKHB8MVcn4EaNMzM=;
        b=VEJZgtVjp3YNhw7/Opehfzn2lJofLl1SVdzihkau+AnNnWC+VdXxZBlPKrZup6qgJg
         uru9BmQq5gRiUR0407lL0qYPnTWpVpe8INKg2CYUJzrt/MGqeKfLQ/Fbl+kx9kmPdizU
         ZkNH/mZvohc8qr84xpY8ppXv5nWzyKz59dUAmJRwxe/amh1+Ll8YNmVDOC0mCCjxKc3O
         tC4iPx5myYFc+YbQ5hI6sbJXsrd/j2R+krjep91CW4Wvh5QjxdLqzGljqi/TLHDhN+f2
         ZTGnRyfkRDxZpjBAgaXAXMMxyUL5yAhlWeyCp7Tx9b3KJrLkGL/Es6p44Fwseksls2RN
         xvBQ==
X-Gm-Message-State: AOJu0YztX1Lqf/gvybqErr/5KeU+AtZX7t676gqmNm3lZ61txvIAWM6D
	Ri2kf2QBRQIrhfg6We8Y6Zb7FDaLsYvXWZus2E51XPQuveUiw0r5gle80ssDO9c=
X-Google-Smtp-Source: AGHT+IFJslFIOpghoKDTLR0OGIUDV2UVIGb9hL36ZC1+ww2JbzD7HcVhw/J/gYtk0+dYuF64+MiEEA==
X-Received: by 2002:aa7:d0d5:0:b0:58e:2f7c:a9c with SMTP id 4fb4d7f45d1cf-594bc7cab19mr2781021a12.26.1720562236651;
        Tue, 09 Jul 2024 14:57:16 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-224.dynamic.mnet-online.de. [82.135.80.224])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bb9605dcsm1499572a12.6.2024.07.09.14.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:57:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] ring-buffer: Use vma_pages() helper function
Date: Tue,  9 Jul 2024 23:56:58 +0200
Message-ID: <20240709215657.322071-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the vma_pages() helper function and fix the following
Coccinelle/coccicheck warning reported by vma_pages.cocci:

  WARNING: Consider using vma_pages helper on vma

Rename the local variable vma_pages accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..473ba56b889b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6226,7 +6226,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			struct vm_area_struct *vma)
 {
-	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
+	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
 	struct page **pages;
 	int p = 0, s = 0;
@@ -6252,11 +6252,11 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
 	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
 
-	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-	if (!vma_pages || vma_pages > nr_pages)
+	nr_vma_pages = vma_pages(vma);
+	if (!nr_vma_pages || nr_vma_pages > nr_pages)
 		return -EINVAL;
 
-	nr_pages = vma_pages;
+	nr_pages = nr_vma_pages;
 
 	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
-- 
2.45.2


