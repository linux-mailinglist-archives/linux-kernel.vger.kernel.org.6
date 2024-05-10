Return-Path: <linux-kernel+bounces-175856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9178C2643
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4176B1C21305
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FFD1708A7;
	Fri, 10 May 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MicMeQmq"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D8170846
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349892; cv=none; b=JfPwHWn32xhDXAl8ytS8RHgtMsc3P+BhJNbB9WLAVIOCLZIJjGHpt6dl0eSGn9+BlnZy71CGhGFUx7k/vNaivSDwVJihQYzagvpe5Z+OKppVIp9//MGtxljkT8jG+wbCvU82nVeuvu5oBEdKsi180d2bgtmaPyuyGthUOncXOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349892; c=relaxed/simple;
	bh=E4U44deHsribGfpVVd25C/wzlfyjpvU+ho5dACdmFzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LLCDzoGMelLd04Vw/ajR3lWj3yCT5ozB/nLFsGdcAPn2U8YkB4KTarr/00125zCChZ4Sd69HuB/eGPvYPVNCZJxy/GSjlVONHNOoqLZOn3VJzgXQcXfvsswXJzJ/76O8IMBevfiv06w0L2pb8Xu8u9n5r8tdmXn6d0kaPD0Ut7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MicMeQmq; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-34da03e19beso1223393f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715349889; x=1715954689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CL/txfNgiuuPvPzsKQhjy3/tSvqVyiCfEzCcmoskOAs=;
        b=MicMeQmqsH6YiGJtLQho1/uvLfQJTdGbjJSZM7vqXwHLxR4Q/Vzh3Xv//q+fMIhac9
         CLU0W3HRDtSxtwZrXLKarZrDLYiKPEmyDrerhoB7LqJ3oxqUOv2Gt5U6EKooQf1U70yi
         rVIar6kW4krj7cPTXYV5wcENlnv3zyi/mRRHA0D6HSIuSHRc+cBLtGztqaMJVZDH7oLi
         +ZHtIWFWvcuJSzBRjWT0GnYGp2M3ToMXTYebj6Jdfrq9jh90eI8tRCRXF7WUhtI30REz
         TxD8AZW5TxoxiaWCXlhwoA6ZliTqi0ZQt4nf935EnTw9JbhyWppI9hgHhjh7D2nb4+W8
         DY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349889; x=1715954689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL/txfNgiuuPvPzsKQhjy3/tSvqVyiCfEzCcmoskOAs=;
        b=ioBmlbCrBdOFRc6QKrCmAz1bh5QO1ZtYsJQT9dJtSTaGJk+cTio+dVYtJXFWLsvS+5
         91RARQj5t03seJKULFFZCJDIJmfd4XGTX/4+QG1UkL9jGwo/Zm1h2O/uGtZXjFOr5g+y
         p2r76fcpw5NaoBYNnplTSjKA4vx7L5ZXpnsZYgNQxgjdRzZHdsqdnn8CIl9LXfhPqcOd
         jG7TzkdDIfqRQjpgAVIhHcOLJrixqEB45FYp+8lhQin8oQRGJ0TRuCd4tJgiOt/jsuFL
         Eni8Nw9/5Fhr6OWTCn+Au7p3hFvBPE1vs3XkWoGZk5uzu6ndiHisSvGTZ4fHuuw2QBlI
         0KJw==
X-Forwarded-Encrypted: i=1; AJvYcCWb3SS/A+7BeK7YaGLNZONytrcbFyvpfaOU7B3wDONvWSfqM9FMUoWvT0t9+AA/647rrEovy2MTvKWo4uzNiv9r6zR8q+qDM2lv6tcn
X-Gm-Message-State: AOJu0Yw6SBGjUiyqlNis+DQV7bV+Ckwf7FYG7NECKRlFDi+Q4/VMJRKv
	0OtlemrAnA/l2WZbx4BOpezHGRUCRDMLo2UjMJfudsuR/Tb5KutXmHF4UVyUoXczHqFtf2z0RXz
	Yl3LOh9tZKJuCUoAxvA==
X-Google-Smtp-Source: AGHT+IHh/kQBnPFQXEdNhHJ2omU/SZm3QBjI91vUOd11c8oIXUCoUudPXv9RKB/U/PJtgOPyCP8KiDNz8TUZAtDF
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:55c2:0:b0:34e:23d7:3ad with SMTP id
 ffacd0b85a97d-3504aa62e82mr5154f8f.13.1715349889010; Fri, 10 May 2024
 07:04:49 -0700 (PDT)
Date: Fri, 10 May 2024 15:04:33 +0100
In-Reply-To: <20240510140435.3550353-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510140435.3550353-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510140435.3550353-5-vdonnefort@google.com>
Subject: [PATCH v23 4/5] Documentation: tracing: Add ring-buffer mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

It is now possible to mmap() a ring-buffer to stream its content. Add
some documentation and a code example.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5092d6c13af5..0b300901fd75 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -29,6 +29,7 @@ Linux Tracing Technologies
    timerlat-tracer
    intel_th
    ring-buffer-design
+   ring-buffer-map
    stm
    sys-t
    coresight/index
diff --git a/Documentation/trace/ring-buffer-map.rst b/Documentation/trace/ring-buffer-map.rst
new file mode 100644
index 000000000000..8e296bcc0d7f
--- /dev/null
+++ b/Documentation/trace/ring-buffer-map.rst
@@ -0,0 +1,106 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Tracefs ring-buffer memory mapping
+==================================
+
+:Author: Vincent Donnefort <vdonnefort@google.com>
+
+Overview
+========
+Tracefs ring-buffer memory map provides an efficient method to stream data
+as no memory copy is necessary. The application mapping the ring-buffer becomes
+then a consumer for that ring-buffer, in a similar fashion to trace_pipe.
+
+Memory mapping setup
+====================
+The mapping works with a mmap() of the trace_pipe_raw interface.
+
+The first system page of the mapping contains ring-buffer statistics and
+description. It is referred to as the meta-page. One of the most important
+fields of the meta-page is the reader. It contains the sub-buffer ID which can
+be safely read by the mapper (see ring-buffer-design.rst).
+
+The meta-page is followed by all the sub-buffers, ordered by ascending ID. It is
+therefore effortless to know where the reader starts in the mapping:
+
+.. code-block:: c
+
+        reader_id = meta->reader->id;
+        reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
+
+When the application is done with the current reader, it can get a new one using
+the trace_pipe_raw ioctl() TRACE_MMAP_IOCTL_GET_READER. This ioctl also updates
+the meta-page fields.
+
+Limitations
+===========
+When a mapping is in place on a Tracefs ring-buffer, it is not possible to
+either resize it (either by increasing the entire size of the ring-buffer or
+each subbuf). It is also not possible to use snapshot and causes splice to copy
+the ring buffer data instead of using the copyless swap from the ring buffer.
+
+Concurrent readers (either another application mapping that ring-buffer or the
+kernel with trace_pipe) are allowed but not recommended. They will compete for
+the ring-buffer and the output is unpredictable, just like concurrent readers on
+trace_pipe would be.
+
+Example
+=======
+
+.. code-block:: c
+
+        #include <fcntl.h>
+        #include <stdio.h>
+        #include <stdlib.h>
+        #include <unistd.h>
+
+        #include <linux/trace_mmap.h>
+
+        #include <sys/mman.h>
+        #include <sys/ioctl.h>
+
+        #define TRACE_PIPE_RAW "/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw"
+
+        int main(void)
+        {
+                int page_size = getpagesize(), fd, reader_id;
+                unsigned long meta_len, data_len;
+                struct trace_buffer_meta *meta;
+                void *map, *reader, *data;
+
+                fd = open(TRACE_PIPE_RAW, O_RDONLY | O_NONBLOCK);
+                if (fd < 0)
+                        exit(EXIT_FAILURE);
+
+                map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+                if (map == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                meta = (struct trace_buffer_meta *)map;
+                meta_len = meta->meta_page_size;
+
+                printf("entries:        %llu\n", meta->entries);
+                printf("overrun:        %llu\n", meta->overrun);
+                printf("read:           %llu\n", meta->read);
+                printf("nr_subbufs:     %u\n", meta->nr_subbufs);
+
+                data_len = meta->subbuf_size * meta->nr_subbufs;
+                data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
+                if (data == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER) < 0)
+                        exit(EXIT_FAILURE);
+
+                reader_id = meta->reader.id;
+                reader = data + meta->subbuf_size * reader_id;
+
+                printf("Current reader address: %p\n", reader);
+
+                munmap(data, data_len);
+                munmap(meta, meta_len);
+                close (fd);
+
+                return 0;
+        }
-- 
2.45.0.118.g7fe29c98d7-goog


