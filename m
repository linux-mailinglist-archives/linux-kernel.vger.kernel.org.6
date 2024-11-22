Return-Path: <linux-kernel+bounces-418676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3329D6432
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0459C28177F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692C1DEFF0;
	Fri, 22 Nov 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn5SR7Qp"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9502FC23
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732300394; cv=none; b=bw40YS55JHvbs1kLQ1R4WmFQ9Imt7+HR1XyVSzy13oB/RsC5I1PKWjfDO10YF8void0xi4KcmiS4k3BMuGMK4YAr+Btd8rGZBVnNls7IFCBr0B9Fy1FjsWg0b4J0NPoYTt0+BAtiEMagaTT/KM7Jc79zJL+oIFn4+1MSG5YabP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732300394; c=relaxed/simple;
	bh=QAqtsA1lQt4RDvk8VIPXcQpS7FAUE/0q9ovqiVrQLyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfvZvi9FbxMRax5CVZqfoloeDGmy4IK7t0FU4CVSBcgMjeontYHPWSo/4nw7WlMEkX/iP/MFdRlV9oEEt7Ua1vnizsc6RDgRY7cdNj8FjOma8E7nW/YYxKJgK2MU+WRY/fOjpGn0fjkJx54CadxELD+FcbuSioPQuxciECshGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn5SR7Qp; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5edfe8c17c4so1296988eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732300392; x=1732905192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw43YBjBthpUezCIjA8DES5chSM4etSGbiu+LtX/Ywg=;
        b=jn5SR7QprZcOcT7tz21rAAbP6EI6JTD3qGvN6GsrEg8EoSV499MJiYo+tvPoqJcSpT
         f5V/IONcXbUV3NJsERh0f+kyKpupBDnGo34mJXW68Nrejk0JZjVTq17fGh/tFp+5ZLsH
         6ubjkECjMPjgeGT25yN7ixONromyW6coEOjyafDAB22LNv18CXdLK9/8uNyDZ8FUdd+g
         HHCGsy440lSXrqif+3se5+m4TajT85Sv9L/oIwS06BUzQ7q7J+prYniN468YabyNB8A7
         5k2QUro2kXviH6pZRvIV+tHiNIdLSvRDinpzjs58DcU202KGWO/y5ImEkr/yN3VuB5k9
         zEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732300392; x=1732905192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nw43YBjBthpUezCIjA8DES5chSM4etSGbiu+LtX/Ywg=;
        b=K6v5X2IPOm5SvOSfhHsG61hFd2A8KBK08cLriifJZvIgDtnxc85ATEiy9KiKgX8/Da
         5JuiVEKqrscWEOVU6ha0rJmKa8ueegBQdutRo9T0k+f6Qo1Tm4gILH+LRGwNEqOh18Hj
         ouWPmJLfQAxipJAyvdem39ZPGqqz0vDPjc8jaVeDWDORbqIB9EwFAdC2Kbxp8W0l2Nab
         9aRMHQQgKJ5T2Z36U8cwwtp5IHNTKtKRZHWL0gr75/Yknz2Y7qWHJH8Q+Szs8GfZOeqG
         zL3N1ekR5TAkX8NCmBwTxusQ2i8GrzlNSljVKmLIng2PBeU75qB7TwuwBvPwVHqg2qTD
         FuKg==
X-Gm-Message-State: AOJu0YyN0rQudgYsR9ZL1C5OmAmKZkKUUiS2AVQ83Ierd/eBwtLQfavx
	mU10BOH12Mp7Q3Pa2DLfDe7SS36R3qY93ZU57V1R3Dc6cbGZJfAgbJEe9Uy+lQEPAX1A98+w9H2
	OvUiNctRM/sogBXk8CUEdAW6jZy0nwkINRAI=
X-Gm-Gg: ASbGnculW7V6Om6VG8FsHG4VbEWWBJOoqAi3ktVxDZXsbnGIvEwLP1R+048s1YlIf0W
	S+JgfjIH4IUyPzbwUflSODSzr7dcPMA==
X-Google-Smtp-Source: AGHT+IEncVKmf086CoFYNI7Bxme0hENXXUWfpzFsaYTe1V/9HPH1Ht5MF0RBwtOcJkv0w9sONKvc+cwKJtur2X5/1/k=
X-Received: by 2002:a05:6820:512:b0:5ee:e2eb:ea57 with SMTP id
 006d021491bc7-5f06a6f7d17mr3924004eaf.0.1732300392271; Fri, 22 Nov 2024
 10:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPXz4EOcrGyLkp9XGn8-XgzfuebuW5=AdR72hP8Qf2hK0DrHcw@mail.gmail.com>
 <6740bb9f.050a0220.363a1b.0149.GAE@google.com>
In-Reply-To: <6740bb9f.050a0220.363a1b.0149.GAE@google.com>
From: Nicolas Bretz <bretznic@gmail.com>
Date: Fri, 22 Nov 2024 11:33:01 -0700
Message-ID: <CAPXz4EO5poAP+8+TVWOzahJMa7Q9NGVs+6RuvV38u=YX_xyV+g@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
To: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3562,6 +3562,12 @@ extern int ext4_get_max_inline_size(struct inode *inode);
 extern int ext4_find_inline_data_nolock(struct inode *inode);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);

+static inline bool ext4_inline_possible(struct inode *inode,
+ loff_t pos, unsigned int len)
+{
+ return pos + len <= ext4_get_max_inline_size(inode);
+}
+
 int ext4_readpage_inline(struct inode *inode, struct folio *folio);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
  struct inode *inode,
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -668,7 +668,7 @@ int ext4_try_to_write_inline_data(struct
address_space *mapping,
  struct folio *folio;
  struct ext4_iloc iloc;

- if (pos + len > ext4_get_max_inline_size(inode))
+ if (!ext4_inline_possible(inode, pos, len))
  goto convert;

  ret = ext4_get_inode_loc(inode, &iloc);
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3061,7 +3061,8 @@ static int ext4_da_write_end(struct file *file,

  if (write_mode != CONVERT_INLINE_DATA &&
      ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
-     ext4_has_inline_data(inode))
+     ext4_has_inline_data(inode) &&
+     ext4_inline_possible(inode, pos, len))
  return ext4_write_inline_data_end(inode, pos, len, copied,
    folio);

