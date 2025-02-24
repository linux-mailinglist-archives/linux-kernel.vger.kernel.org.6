Return-Path: <linux-kernel+bounces-529003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E2A41EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288311890C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A60248894;
	Mon, 24 Feb 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyvqeT4k"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FC23BD1B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399344; cv=none; b=ELKbxk/wP9NS+y/vEXf5I8ODAoBZBG5cPr1c5m1CFgw45RMc8Ngq9Xx4pz5xKsDKlVyKeIhZ8oPH3AJkyLUdnOcCMIYT8qb5lKJKYdJh4JOuFFIRKYUBluuSWx95QrzFRn1oratIC2zryYSHnBMnuaZ0bVtFvU5cR9ieYA0wzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399344; c=relaxed/simple;
	bh=ZS31GA9EzXEB/v1lDZyHCoVFCGAVaKAjGLC9nk18GLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SNoTYYPOq58UN0U8r4/RcyknnHW6IPn49k57yKkUdCTj+stK61tCdTa6QuIm9UsT/N/7lahu+cU659jrefo9Api5qMlps8P8/l+1ErcVacahUiDp6RREVboN3qraEkITt9TVxJ1IA8V72wKn4320/JEG76+KJ1Eqix9sL7gJNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyvqeT4k; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4393b6763a3so18208785e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740399340; x=1741004140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAhUrVqLivzp9jwXFDW1HJkTiMmByFJAoDrNGn0+mK0=;
        b=lyvqeT4ksZvTROmsXDGTcW3+cpHkzxZPpATWA3LvjimVbFFRL/vHda1gWW5XEZFfK/
         93otXOaHD6P5kN/ewKx12O38WxhZERvGnYc6QinY7BGsphp5akpA8WQZHsiP6p5oeya6
         pML/kdj9Yldkk9PmpyH7YgpkKXh/W0oWiskVJvXZ4g2mvI3BqePXO4yqEKRYHBzrGiDR
         pqta5gNaTL4iVzmIaByY6N6IRmJKh2LKcmpA1N+KxLGlOcETjExpYrAKBKGaqVk4immG
         jqI3/SMCITrwyV9n+YcMXCDynJRkBl3ql+DQjTopsJy5cCv/d6WhmmlAyfyxSTFDSEvW
         Sq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399340; x=1741004140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAhUrVqLivzp9jwXFDW1HJkTiMmByFJAoDrNGn0+mK0=;
        b=MLXSVIoMqacaqhAHQlaGuFdW9mk5C6LeWm5519rhz/aYLQDedwJGsnKpBVwzp5N86z
         TnmfI1FOX5270onAyoA+MjbS66V9moMtXmAygnz/Dolm1ZEOCUJzkO68HB5CJ+7GKEWa
         wzepnQNqHlRwm/eYkKwGt40mn7CGyxrpTfRJwD1dFeZr0bTiKZf4yUKAihI+Wxm2WvqX
         HVeO8iI9eHkfjWR/udox+mL4RozrMlEFSqGgapd5MdCwXE73Z9G+nJ5CrYm5ceHZiqXE
         q6eBQRH3MLA6AuVfDYRmQvgE93Ianw9YEpMuSWQUk+Yp8Dh6ja7/3qme9umQ/e1GEGvu
         hB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqtkSBhyN5vfUgg+A3b1m2LxOpaiD5FqfJtDCf5VkAQYsNYf4RdAe/kuqW/rRRzeTDg1ABv6ie11AySus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vyp7zRRdl6zEzw4ALYYrtrtYWs2HelkafVGQmieHYp1RLmmn
	INdXfLr91MultAu5WBKJszeFFvlDlvA6bjwg8Y+zDjojEcAndFDFqnxqrwIjqaAbHi1JcBXRPrd
	gteix1D/rKawu+kgPTA==
X-Google-Smtp-Source: AGHT+IHQGpayqqEkTmw/Zvqr6LdF1E/ueJfO1lglmZUQzjDwUDQWHOMK/KK1dg4emFnGMwfhnTYT5JRRxbk4ic04
X-Received: from wmbhc15.prod.google.com ([2002:a05:600c:870f:b0:439:858e:8ce6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e23:b0:439:987c:2309 with SMTP id 5b1f17b1804b1-439ae221d7dmr101374675e9.27.1740399340381;
 Mon, 24 Feb 2025 04:15:40 -0800 (PST)
Date: Mon, 24 Feb 2025 12:13:50 +0000
In-Reply-To: <20250224121353.98697-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224121353.98697-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224121353.98697-9-vdonnefort@google.com>
Subject: [PATCH 08/11] KVM: arm64: Add raw interface for hyp tracefs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The raw interface enables userspace tools such as trace-cmd to directly
read the ring-buffer without any decoding by the kernel.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 3f91ad69c25b..38d97e34eada 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -746,6 +746,85 @@ static const struct file_operations hyp_trace_pipe_fops = {
 	.release        = hyp_trace_pipe_release,
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
+};
+
 static int hyp_trace_clock_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "[boot]\n");
@@ -800,6 +879,9 @@ int hyp_trace_init_tracefs(void)
 
 		tracefs_create_file("trace_pipe", TRACEFS_MODE_READ, per_cpu_dir,
 				    (void *)cpu, &hyp_trace_pipe_fops);
+
+		tracefs_create_file("trace_pipe_raw", TRACEFS_MODE_READ, per_cpu_dir,
+				    (void *)cpu, &hyp_trace_pipe_fops);
 	}
 
 	return 0;
-- 
2.48.1.601.g30ceb7b040-goog


