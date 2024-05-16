Return-Path: <linux-kernel+bounces-181485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120288C7CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4301F219AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05195156F28;
	Thu, 16 May 2024 18:51:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF54688
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885464; cv=none; b=fkm0QXhDh5dBhG2G/8w0DHEwatvqR8UG03YJG+7cE8ZeKMVizDM7RjzjUmd9mqqPsCbkqPkMu6tICebUCsxC7hT8TceAA82XB+Q9Pp0AlD2LAg/Hdlky8HiPaQYuEtFTcT9OXCVc82R8usnW5aa7tc0230jJkAAt6tEZ1fKdUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885464; c=relaxed/simple;
	bh=wKf3MK9DtGzKUzdQByd/03VlFSVP+H7T9f/Z5DRUA/s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VKvSs1horQOYeIQxsqAQgv3z5Y+YRdP+nA9z2WQlE6b7AbDyP8AMtFzim6jL7StQtz+/Pdb/1ziKkkp+3FagFb7J8r6S22J5I0q7189zrQlsQSc65qmodTV0bUMhTQQrpnNPMdEEKQvFYNeJfDGc29kn0KpjaIvbfrBcTX81UR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da4360bbacso1006462939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885462; x=1716490262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKf3MK9DtGzKUzdQByd/03VlFSVP+H7T9f/Z5DRUA/s=;
        b=bSx6lYEGSevX5JMnh+/2Chj9tGAN4HvUwn6EXbIOYIcmMI1oq7+iLgrZHM+WTXVfNx
         DDf5LeDA+SQVTu6yiA4oTNKhtDeWxHd/q7BVaDnnFsnW9VQGJbgP7PblNSwpmUQxhSZA
         7mFyx7GnZ9h6j6AFTkP/fQ9z2DT7xgzkM65EsSwV+VCPMiTQxnW6fysm63fyUP0jzJr1
         lwyDSmMbj7+385gU9XLkcYOR6kUMrQtwVQLpWYxOeNITb3IwgRHYQsmwIHptO2NrKV4W
         uUxSlvfhurX8aMdBNNHPt9+pun1DZJU1LwGojDIMBjp6j/ak448TJgAQHCzBLumnwJPs
         D8Xg==
X-Gm-Message-State: AOJu0YyIkH3i+LclELTgdPx2iOKgS9m73G4CAwfKZL5buQOtujWC/rAP
	khULZNwSmu9Fh8ohmU/Y6uyqdRotjGT79mmADKPBahWQJ6FNz0OuceHWksvxYBD8i3f21XytUMF
	5ah/TohUaYNvoiQAXrgKjmAiyCE5s6uviI01oMEbzxzqezmmt1JKZTyk=
X-Google-Smtp-Source: AGHT+IHRBoiwu2oaacgR3qVFP4x4J/MxRwHJtMr2+sL4DUH4NsLXaPGSu0aqg/Ji5+8nH/5YZ39LquB5vp1iyVZYQjfIcHk5fcVz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:134c:b0:7de:e75e:6170 with SMTP id
 ca18e2360f4ac-7e1b51fb329mr86964639f.2.1715885462582; Thu, 16 May 2024
 11:51:02 -0700 (PDT)
Date: Thu, 16 May 2024 11:51:02 -0700
In-Reply-To: <000000000000aaf7ec06186a8d13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000790b48061896b7b5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: use-after-free Read in
 __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in __ext4_check_dir_entry (2)
Author: tytso@mit.edu

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git origin

