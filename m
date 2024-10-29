Return-Path: <linux-kernel+bounces-386325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25F9B41F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40701F2356A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46C20127F;
	Tue, 29 Oct 2024 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/hFyasG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9020127A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181177; cv=none; b=rcvi+XmKN7tgSn4btJ1Azrijc8fnZrn9KG5aiIyirBn36yXUW/HuMSbtDxXWm/QByyaxCGmqHcjq4EZlbt038NoU8w0rP8IvR2H8sgU/5VWwmDOEH6R4kXnTn0inPOw4IOOF/KjHo2Kq/nmA82NsebB3e3VXC6bfQntvnG+mFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181177; c=relaxed/simple;
	bh=l6XG8mRUC//SlLNTRFRg+qa2UDiqGVwkf0ym7z2vsXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjO158cP0FHOjGqDPo1jMxjjrVNNNQRvQHUvBesI44s+cGjzQBkighI6Pwb4YZvUeg1HbSMTXCAQ7HgQakwVNoKXDwXXQvA13FunFkecDJhYUa86leafYMBIaNA98UymHkP97uqKdOu5oKHlFKhSVXe4AL2lfb9seXNuW4fO9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/hFyasG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FowNBWjWbVItvQ2T5CYr3SncrK/lJISla1OHhnStC4=;
	b=R/hFyasGJi8y/lISiH/K6VTyu2kq+6Ek6gv3Y3WuqSVuYZrmAvyW9JAHYicOjkeaBgxvW1
	ydQQoxyaHbzN/RLkGUti9XA5I30DeeVo4QaUtneDXGFJv3AVtyGJDja0kaTfH+PneUb1Jw
	H2N1FFi1lqF6mPo8pgVfNFezjhoAD+w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-VbDpjaU5NQKIM7UfHUVLlA-1; Tue, 29 Oct 2024 01:52:52 -0400
X-MC-Unique: VbDpjaU5NQKIM7UfHUVLlA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2e146c77cso6329824a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181172; x=1730785972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FowNBWjWbVItvQ2T5CYr3SncrK/lJISla1OHhnStC4=;
        b=pyrzxlSebMwIzN0mvtZ6d6QahXjnNEJ845dcSk2DhujDTz2TXzCg3wzfO1EwJoxToa
         kPoRTfxgQ2Izk9MPlAHiue0AqdyKXQfPpvEr1faHZ8fArSVMo0TAsNtMt2eGfzuoXM0g
         1j9ASiiuRol+phcsYsC60B17D5Cz8MQzMdyL/yFn/t/18Zr50jBS74tKB+j0GNJdo1La
         gQfsdtzbCEbP/xkFvVlMz8JEiVyi4IAk2RYzAa0wM2WOclIHHM0PA5bsVjsfv6N5PGOz
         z8FtDnECzDymLcpXFKRZTCWgveae7IOK9LNqUQwPDOLJZdcHRAqJtr0YJ+mTOR5xar9k
         kkQg==
X-Forwarded-Encrypted: i=1; AJvYcCWfmNsRh0Po0uFZ7vbvBNB8Yog6tLLOPEfLr1pQeLVBtMCzpezJe3iol33ws+E/z+hpq+b8KI/+L0YcWnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpiynkpG2W/cN6UdlFad4DWSRAgGDSmTLclTs8rpBOJdxF90S
	AeFM1zJYRAEjQRHS8yHte0pnwiq2ZQOHz3yxGSlXfoPAPqLZvi/wd38F3lnHQmmsVg/NJHDz85G
	VfPdYDNz1DLCmwxkuVNAaGUtfqP+KXiBIorWUcW3MDLf+mGlQPFkw6DmMJjF3ZA==
X-Received: by 2002:a17:90b:4c8c:b0:2e2:9522:278f with SMTP id 98e67ed59e1d1-2e8f11ab132mr12515455a91.32.1730181171801;
        Mon, 28 Oct 2024 22:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaZ9dQJ+Cd+rSku/B/Cyoe7dof5e0gGIxGIvrF0pzJfr4i782JDqBryN6BPGY3NXt1ZlWUyw==
X-Received: by 2002:a17:90b:4c8c:b0:2e2:9522:278f with SMTP id 98e67ed59e1d1-2e8f11ab132mr12515437a91.32.1730181171510;
        Mon, 28 Oct 2024 22:52:51 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bb51sm10510164a91.11.2024.10.28.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:49 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v6 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Tue, 29 Oct 2024 13:52:17 +0800
Message-ID: <20241029055223.210039-5-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there are CPU and memory hot un/plugs, the dm crypt keys may need
to be reloaded again depending on the solution for crash hotplug
support. Currently, there are two solutions. One is to utilizes udev to
instruct user space to reload the kdump kernel image and initrd,
elfcorehdr and etc again. The other is to only update the elfcorehdr
segment introduced in commit 247262756121 ("crash:
add generic infrastructure for crash hotplug support").

For the 1st solution, the dm crypt keys need to be reloaded again. The
user space can write true to
/sys/kernel/config/crash_dm_crypt_key/reuse so the stored keys can be
re-used.

For the 2nd solution, the dm crypt keys don't need to be reloaded.
Currently, only x86 supports the 2nd solution. If the 2nd solution
gets extended to all arches, this patch can be dropped.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/crash_dump_dm_crypt.c | 52 +++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index ec2ec2967242..51431f93fc1e 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -28,6 +28,20 @@ static size_t get_keys_header_size(size_t total_keys)
 	return struct_size(keys_header, keys, total_keys);
 }
 
+static void get_keys_from_kdump_reserved_memory(void)
+{
+	struct keys_header *keys_header_loaded;
+
+	arch_kexec_unprotect_crashkres();
+
+	keys_header_loaded = kmap_local_page(pfn_to_page(
+		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
+
+	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
+	kunmap_local(keys_header_loaded);
+	arch_kexec_protect_crashkres();
+}
+
 static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 {
 	const struct user_key_payload *ukp;
@@ -150,8 +164,36 @@ static ssize_t config_keys_count_show(struct config_item *item, char *page)
 
 CONFIGFS_ATTR_RO(config_keys_, count);
 
+static bool reuse;
+
+static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", reuse);
+}
+
+static ssize_t config_keys_reuse_store(struct config_item *item,
+					   const char *page, size_t count)
+{
+	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
+		kexec_dprintk(
+			"dm-crypt keys haven't be saved to crash-reserved memory\n");
+		return -EINVAL;
+	}
+
+	if (kstrtobool(page, &reuse))
+		return -EINVAL;
+
+	if (reuse)
+		get_keys_from_kdump_reserved_memory();
+
+	return count;
+}
+
+CONFIGFS_ATTR(config_keys_, reuse);
+
 static struct configfs_attribute *config_keys_attrs[] = {
 	&config_keys_attr_count,
+	&config_keys_attr_reuse,
 	NULL,
 };
 
@@ -233,10 +275,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 		return -EINVAL;
 	}
 
-	image->dm_crypt_keys_addr = 0;
-	r = build_keys_header();
-	if (r)
-		return r;
+	if (!reuse) {
+		image->dm_crypt_keys_addr = 0;
+		r = build_keys_header();
+		if (r)
+			return r;
+	}
 
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = get_keys_header_size(key_count);
-- 
2.47.0


