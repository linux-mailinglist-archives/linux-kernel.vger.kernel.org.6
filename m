Return-Path: <linux-kernel+bounces-254967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D5B9339DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1C51F22AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763F740848;
	Wed, 17 Jul 2024 09:31:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDE9461
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208666; cv=none; b=WKtLrPHNDbLbmKZ0Tx8MbctxwDcfRJeqjSKt1PfdrOIrcvh9kD+abEJgoOWbJ8poOzO3+eP8S8/dE0bWoGxcO4fsB0TwES7vYTidY6x8XaLo/ykHywcv/AVZGhpoFb2ickpqJL1ORqMC6/80cl4cn3YAHhKdR5H5eKm8Pxm6UAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208666; c=relaxed/simple;
	bh=ogNnNgO0+GrLUD5WRf5Wbn+gekguxVpPFYVZDXgYLTk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tZhDoWzTdKD7R30f/xw+R2DYIySzCc2RQfyzmtDUlP7qEwB5QL5L1nK/ogxSJ7Jgyw1PoToLSDQpEVigR1R8Fy8IHF0ObcbroQqZSVnVRlu+FfeyzY+6Czs7IH8BPbDsn3eg3k0uFevAZ2C3fhinIvT1+d80VKNmZZJXDRI4nVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-38437330bb9so11089895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721208663; x=1721813463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egGL+kFdfG6SMmdJoiOJUagZhwUcoIBVT2MsQhZh308=;
        b=Cfu+zVLPdqDk/hW8EO59rfG4yO/bn7ZcwBOroDCPsX6WhYx/O0TIhRmDfeBYl82MGI
         fIdPgmV2GMj99/PeDc7nO0OX7zZDqyRHiqJYcM+crUhHDe3ycgD2IRO+C7AcPJ8HRigT
         95C+lz+MCzJqO4lCdeGgwiYU07V9pv73EmVS8gEbRxwOmzPSuWpMQL8gQkf4RC4rQxFj
         +tjFn1k9YXuggv+mTZct2T+JiJzLJf/XT7mYr5be043Mx0S7bFjJWmGabnQSNfdFjVGC
         nR30EfjGDKt2WdR5ToZeMqAJP8QKQjU1cLH2kGKYoVxPwi7Gn4yzOhQbM+GAWQ1eMQeZ
         ay8g==
X-Forwarded-Encrypted: i=1; AJvYcCWbDfL+StDVhiKOtx6FAOlcjXAkxhNZkQGU84Y3yvvyGWJXBQ7B+bne9idiWdcCvIoJDekCuH+mAw/XMzEmwTc14srVd53PiZ03E003
X-Gm-Message-State: AOJu0YzQ1U4Q8i1YMKKCQyYfv8rPi3SIFyLHd1yXBIvSbXOxZbX7RT+F
	uVoRrmaTzAJlrr0I4y6Vd7VcBlbc3gb4mc+nSgzg5Uze5fCBaTLpXVRqSw5DxnngTXyRvqpvWT6
	BB6qC67vEXOghJVqn0T4yGnhYZ6OGSZibHXflMzIq3ZO41uH7EPIw5wU=
X-Google-Smtp-Source: AGHT+IHcvDHKAnx32u0HTApFSP/vf6dakN1uAkgY0LTox0GOxxn/ZZOR9o9feOXEN1ZTJox4TBAiw6dWn8LCj/A35ubk1jahWfho
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:0:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-395574243f5mr1017815ab.3.1721208663718; Wed, 17 Jul 2024
 02:31:03 -0700 (PDT)
Date: Wed, 17 Jul 2024 02:31:03 -0700
In-Reply-To: <087fb68c-7c33-4bbb-8b9d-281ea1dc1129@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc6bc5061d6e1ee3@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in attr_data_get_block
From: syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed

2024/07/17 09:30:00 parsed 1 programs
2024/07/17 09:30:00 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
write(/proc/sys/fs/binfmt_misc/register) failed: 17
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed
 (errno 17: File exists)


Tested on:

commit:         d57431c6 fs/ntfs3: Do copy_to_user out of run_lock
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git
console output: https://syzkaller.appspot.com/x/log.txt?x=168672e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

