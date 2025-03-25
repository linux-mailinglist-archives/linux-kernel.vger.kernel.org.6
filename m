Return-Path: <linux-kernel+bounces-574627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B805BA6E7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD31F3A4CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558778F4C;
	Tue, 25 Mar 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ApgJceq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2543169
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863795; cv=none; b=ETXnN/aRE2O6ry6uXwuG7FwNPoWICWIMN8B6D8ZbgKHEkfWKA1RHoqP8yslq/qVq+Vm5pim7bXI3pdrhKhpQ6E0jjkJ5jdW+Uh86M1dbAw5IJdsocrfXBgMuJR9XHrgXQVulrbSOvoVX8tHMOxeagu9iOU0VPzWMhtCqjdntuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863795; c=relaxed/simple;
	bh=j6Klsb4thp1cQVepxif8KY5/V7b0H6oGeIsv596vS1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO1ee+HjRx95MxtRfBdRRHoNwumcaz54Twt+XM395gE85Liy5NNJhG7V+pSGBMD+a/arEfpDU4pl5bXvD/YS1o36AND3YCczRMfgrJzkNJFyGnyGZ+CvVDq+JN9jz+EhOyp8QzKebCqGugjlWtW4rwlngkv8uSL2OP40k7ED5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ApgJceq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2263428c8baso68505ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742863793; x=1743468593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OaD7q3ZQOQjfRhBGVXHdE9Gzn34bnoG0yDb7obc0zLg=;
        b=0ApgJceqnh2SwQhtTX8e3psi9FQ0ztx7S2zR8A5iXyIgkuDPjdUhMtap7GThzat3fi
         C1h5JADKpg8hBdRy9u2YDMgnt4NMMPb5vhRdA/WmcGFEXSfnq3f/tERqzGVaw5vXdyme
         ViBTfgNCpadyTETcDi8NFKso9jpKI+8hdHcHsUj7ybprZdwq/sikmNl1/mIpJun1brYy
         oM4AAcTDAwScuaEMfUAG4/Ad8kHVttPuXWJRAMVVcEi5K0sGIogSJRzu8QBuSypQb4DH
         YPp6tiHbgGPFQp5wXac4Z0ItuIPasZJVsKs3N5BzPGGNQ2hLqKf+P4n6eTNGniPzogC8
         Wg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863793; x=1743468593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaD7q3ZQOQjfRhBGVXHdE9Gzn34bnoG0yDb7obc0zLg=;
        b=M2ly2GXRpWpHUBY35EQ3yiuhfo/o+WQ5RJmcBFfB8J37gbG2Y35hc9fck1jfMu3Zvb
         qNk5p/mzKpRqrtyoc7tY0LVgljSbHlSwcTZnzw/9ML0ugqiSS67b4Z7PnE+5BTJPZV/m
         HjIcYuU1L1YWyzHC4EJnjcsS51JhjaLctIMWt2DR2R/oYw5Z8Ki3ETFkekoeuXR5b6rK
         awMsJICS4RboAH7CaIo8OQNRXzKvee44vD9wOB9zFK5gAAZmRy45+gJS28MqWJSroOed
         d//N/WUhgQ2mEB+Tj9XsZ9996yRRhjV0uDBrMFbQU7MA41bNT44/UB65lUJc/BCNS/9O
         /6nA==
X-Forwarded-Encrypted: i=1; AJvYcCX1eLKsjsKJdK/hGYOpPQoVrqbGA2mA1VIXIWClgyxcRjWNnmmiTxcCfyIbuNxGtjhpKKf6g3EiVGSPzac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFryX1myTlPlUKZuozgElnyHlLEe8egAHD2f6QDag3wQj5VFCU
	rduCa6YOLD1pusg52O3jUJ++/k2GQqUHbcCKXoaHQ8RlWO3UaWATz6fdMkuFnw==
X-Gm-Gg: ASbGncsjOzdW/p3ooXWMw7TJvNtvZl333B/mn3FMl0grf4sNRzf/IOm1ISMiQ+jBWXF
	RUOkBUNtQDkGmP91PkWoRxf05oHpwcc6H4eCjq9cKOWg9wj5DSjzlkp1734MthhSPOMqLTGEIIF
	JvpHnDlSeJQ8QXoCzCsmq8FomiqSW9S27sIARFNxQI7U8MBSX4xW4CAWKS5tVSV/X7Yqo1UtO0r
	6uK739tj/QhvTSJVFAI8nmS/An8/yLEEIV4CCm8PPhgYtwAkucA2ZEdQd0rsTsNcGIq/6WNbGr8
	usnVF8qyD8dRlReimvrOpNmdGCLTcxFwLMQO2fBoIVx8fRHcL75aDMRBe0rQKIh7QEd50CpXUKI
	ml8CR
X-Google-Smtp-Source: AGHT+IGXMGB5BIztLF+KW+EFyu9AEbwESCHM5GYmH0GeZR1XvtB1o65cw/3QX7jDCkrukwg1tu9BmA==
X-Received: by 2002:a17:902:d4cf:b0:215:f0c6:4dbf with SMTP id d9443c01a7336-227982bd0e7mr6009575ad.14.1742863792544;
        Mon, 24 Mar 2025 17:49:52 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45f45sm77436155ad.87.2025.03.24.17.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:49:52 -0700 (PDT)
Date: Tue, 25 Mar 2025 00:49:47 +0000
From: Carlos Llamas <cmllamas@google.com>
To: syzbot <syzbot+810b8555076779a07399@syzkaller.appspotmail.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	maco@android.com, surenb@google.com,
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Write in
 binder_add_device
Message-ID: <Z-H9q5X8e6uYiaF0@google.com>
References: <67d755ef.050a0220.2ca2c6.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d755ef.050a0220.2ca2c6.0004.GAE@google.com>

On Sun, Mar 16, 2025 at 03:51:27PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b7f94fcf5546 Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=134f303f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc24cb631dc9bc4
> dashboard link: https://syzkaller.appspot.com/bug?extid=810b8555076779a07399
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

#syz test

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76052006bd87..bf79a0e339fe 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -79,6 +79,8 @@ static HLIST_HEAD(binder_deferred_list);
 static DEFINE_MUTEX(binder_deferred_lock);
 
 static HLIST_HEAD(binder_devices);
+static DEFINE_SPINLOCK(binder_devices_lock);
+
 static HLIST_HEAD(binder_procs);
 static DEFINE_MUTEX(binder_procs_lock);
 
@@ -6929,7 +6931,16 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
 
 void binder_add_device(struct binder_device *device)
 {
+	spin_lock(&binder_devices_lock);
 	hlist_add_head(&device->hlist, &binder_devices);
+	spin_unlock(&binder_devices_lock);
+}
+
+void binder_remove_device(struct binder_device *device)
+{
+	spin_lock(&binder_devices_lock);
+	hlist_del_init(&device->hlist);
+	spin_unlock(&binder_devices_lock);
 }
 
 static int __init init_binder_device(const char *name)
@@ -6956,7 +6967,7 @@ static int __init init_binder_device(const char *name)
 		return ret;
 	}
 
-	hlist_add_head(&binder_device->hlist, &binder_devices);
+	binder_add_device(binder_device);
 
 	return ret;
 }
@@ -7018,7 +7029,7 @@ static int __init binder_init(void)
 err_init_binder_device_failed:
 	hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
 		misc_deregister(&device->miscdev);
-		hlist_del(&device->hlist);
+		binder_remove_device(device);
 		kfree(device);
 	}
 
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index e4eb8357989c..c5d68c1d3780 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -584,9 +584,13 @@ struct binder_object {
 /**
  * Add a binder device to binder_devices
  * @device: the new binder device to add to the global list
- *
- * Not reentrant as the list is not protected by any locks
  */
 void binder_add_device(struct binder_device *device);
 
+/**
+ * Remove a binder device to binder_devices
+ * @device: the binder device to remove from the global list
+ */
+void binder_remove_device(struct binder_device *device);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..44d430c4ebef 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,7 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
-		hlist_del_init(&device->hlist);
+		binder_remove_device(device);
 		kfree(device->context.name);
 		kfree(device);
 	}

