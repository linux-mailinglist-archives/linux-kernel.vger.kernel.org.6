Return-Path: <linux-kernel+bounces-324590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC868974E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9721A1F23A20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B4187332;
	Wed, 11 Sep 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlRSAQrM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BE17E005
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047070; cv=none; b=mnDN3PMjN0Zwy8ahTTB8ZDx6REb6V+QTDupqrwES6rLDd4KzQv9KxVbeboCoZec8ckgOL5KfYSvCHjcCGz0pY785zp4VwtcudCcVxR4DXTZHWMVnweUZ14sk67HYjsmerlJmv1VDSpiLUwJzzpTbk0nTW3daCtoQZqsrJi27hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047070; c=relaxed/simple;
	bh=+C1Mr6Eih+8GBOgaIA5ob9ph+NaEjJpwr6bdsWTV2h4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kztnGNsqrpKpbKQvQZLyXX3sKaOsb9cEz5Q5PRf6tubPPr/+qaiBb676SEcN2u0ruqmigv6XaIabPO82BYaK8cs5Sku8XcPHNrK3q9UbbNnbU9RFaVGrwGTcoA7cvZJTqbocb51bpikCZfR2qbR76Q/Ix4qiZBzPr2ioUV7Zt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlRSAQrM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d73dd8ac65so187744977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726047068; x=1726651868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3Znb+Dwqyrq2cJ7HorL7uStGBaHWkuWbAR2JZBqCQ=;
        b=GlRSAQrMLl9xezMp6rRpHOu9JtlWFUzKoSiibUpP7rGvE2SZVIgQ7KAQy6m+brYwFw
         ZqU6VkcOZPsY/YYDAWxUfrZF/ydUPNdk11IZfgWYcoW4/suK/moxAOoSHolU7Bs5GWAf
         1aqKvP4ODFdzvqEShL9ZYlfWgfkPDFY/yTtMf/TqhI7QsHCn3UH4UkTot3uC/LvQhJdJ
         SkoDnaSwM62L9hlZaqOU+ql+uEpsDgybU0nawe+QhZIT/rsh9uHSZNVrs57hIhVLe44R
         3gEQuO4wA71uJegylG8Uotd4VivPO/VgceYvbRmAztr+1/P51tl3OlhhSC+cdyNFLRxa
         +ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047068; x=1726651868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3Znb+Dwqyrq2cJ7HorL7uStGBaHWkuWbAR2JZBqCQ=;
        b=FOPKZqjI36DnCSBFcQtTF+pMy0Dd/Nq+qKLk0jM6OT1YdHQ2eVnSlhq5X2oi3lcERn
         tIrb6gxnm2XSFEdf3jq3FuaedCk2mT22tgOcHopD5NHhLcuFpHyHBJXfncibOg1Kn+bE
         5KdDkcnmGnVNonjw6rVDmnY5Dq1BjOPYo9/bmuLBOL5StgMotthkC2Oh8+gRQYXEM/cj
         CoZs9Bt1t6WXV629fNQDVph6aUtTLEePHNFbkwyKyO9krGW5CHwdXczj3sduLJWTVyOD
         wXm2GTTEl1rmQWRXarvnegQMCvTCysEnI5K1eb00/gLiA81c1M5y36RcChMWhRCwXxKI
         AdhA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Kbcastc4rQtokzxoSvK9cFBfFBAc4HRzbJGdPb2rG5OsRgl7Wwo27os01G22h21x6bRzjdDDE56KmCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5HPkJsMM4Dxkus7FAxr7E9ls/mhq6q5JyM7DepcObF9PjkAZG
	Eq6CQmAKHyM+Ph556uCUmHPh+G6KR+ZHZGY+T7ASrPPlDnyjWBxq7IjEsKrrufs3cpaVhjTiU1A
	s1nflyP0Yd2lZXp7lMg==
X-Google-Smtp-Source: AGHT+IFSAGx//hRZK4AAM97oklvEIfq79G7ievWf/yDgvOrEXJqZ7cy+6snJMt8gT5Wm1/gNBfGcYxIfKSWjx/Ue
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:2f89:b0:6be:9d4a:f097 with
 SMTP id 00721157ae682-6db452739d0mr2138547b3.7.1726047068233; Wed, 11 Sep
 2024 02:31:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:30:26 +0100
In-Reply-To: <20240911093029.3279154-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911093029.3279154-11-vdonnefort@google.com>
Subject: [PATCH 10/13] KVM: arm64: Add raw interface for hyp tracefs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The raw interface enables userspace tools such as trace-cmd to directly
read the ring-buffer without any decoding by the kernel.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 1720daeda8ae..0d0e5eada816 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -740,6 +740,86 @@ static const struct file_operations hyp_trace_pipe_fops = {
 	.llseek         = no_llseek,
 };
 
+static ssize_t
+hyp_trace_raw_read(struct file *file, char __user *ubuf,
+		   size_t cnt, loff_t *ppos)
+{
+	struct ht_iterator *iter = (struct ht_iterator *)file->private_data;
+	size_t size;
+	int ret;
+
+	if (iter->copy_leftover)
+		goto read;
+
+again:
+	ret = ring_buffer_read_page(iter->trace_buffer,
+				    (struct buffer_data_read_page *)iter->spare,
+				    cnt, iter->cpu, 0);
+	if (ret < 0) {
+		if (!ring_buffer_empty_cpu(iter->trace_buffer, iter->cpu))
+			return 0;
+
+		ret = ring_buffer_wait(iter->trace_buffer, iter->cpu, 0, NULL,
+				       NULL);
+		if (ret < 0)
+			return ret;
+
+		goto again;
+	}
+
+	iter->copy_leftover = 0;
+
+read:
+	size = PAGE_SIZE - iter->copy_leftover;
+	if (size > cnt)
+		size = cnt;
+
+	ret = copy_to_user(ubuf, iter->spare + PAGE_SIZE - size, size);
+	if (ret == size)
+		return -EFAULT;
+
+	size -= ret;
+	*ppos += size;
+	iter->copy_leftover = ret;
+
+	return size;
+}
+
+static int hyp_trace_raw_open(struct inode *inode, struct file *file)
+{
+	int ret = hyp_trace_pipe_open(inode, file);
+	struct ht_iterator *iter;
+
+	if (ret)
+		return ret;
+
+	iter = file->private_data;
+	iter->spare = ring_buffer_alloc_read_page(iter->trace_buffer, iter->cpu);
+	if (IS_ERR(iter->spare)) {
+		ret = PTR_ERR(iter->spare);
+		iter->spare = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hyp_trace_raw_release(struct inode *inode, struct file *file)
+{
+	struct ht_iterator *iter = file->private_data;
+
+	ring_buffer_free_read_page(iter->trace_buffer, iter->cpu, iter->spare);
+
+	return hyp_trace_pipe_release(inode, file);
+}
+
+static const struct file_operations hyp_trace_raw_fops = {
+	.open           = hyp_trace_raw_open,
+	.read           = hyp_trace_raw_read,
+	.release        = hyp_trace_raw_release,
+	.llseek         = no_llseek,
+};
+
 static int hyp_trace_clock_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "[boot]\n");
@@ -794,6 +874,9 @@ int hyp_trace_init_tracefs(void)
 
 		tracefs_create_file("trace_pipe", TRACEFS_MODE_READ, per_cpu_dir,
 				    (void *)cpu, &hyp_trace_pipe_fops);
+
+		tracefs_create_file("trace_pipe_raw", TRACEFS_MODE_READ, per_cpu_dir,
+				    (void *)cpu, &hyp_trace_pipe_fops);
 	}
 
 	return 0;
-- 
2.46.0.598.g6f2099f65c-goog


