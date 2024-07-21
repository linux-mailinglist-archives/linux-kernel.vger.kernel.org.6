Return-Path: <linux-kernel+bounces-258123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D382D938413
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107451C20B04
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6240101C5;
	Sun, 21 Jul 2024 08:52:15 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79ED502
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721551935; cv=none; b=Uo3MURD7NnU833xyKvLcG44eamqTgZ1r2fI4J3JozdFXdaRWyY3tyt3aMQhnvG5mJaaI9vdHYqRzpja5za/jR2BbQBLrTwk1i3DPObH5MA+m7epQmGEiOMOxsHcHXL84KHU9CDnnWTaWPQeVUL4euJYHQmGbXyi18RoZeXh9row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721551935; c=relaxed/simple;
	bh=5K+CoNRq3SiBElqS87dI+lVo70G/oRy18WeTE82B+iQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=di4B6abE7AzTCLBVOdHaeO02Skw7yW9iFfQW6Kjh8dOoZGTwhgwDy5CqD1F3XvqKDO9G0p+HJvTYMp3iisSSTpT5wOzdOu6T5/gPwC6zYrsFqlDSb5TuQOelOcug5MN8UkHoq1Qjq4AANceHXhdN/uOGD7W5KVaOHw3z+q4H+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso570827539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 01:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721551933; x=1722156733;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K+CoNRq3SiBElqS87dI+lVo70G/oRy18WeTE82B+iQ=;
        b=jVHTfMkKTF3+1G+hX8XviACbHySiNfwncJd4uVqRrlix6yfI+ZvE8ZUC72nn5Uiltr
         PnJp4GwBwz/TKyZJ6KEUwspafl8Q77SSht0p+xWYgP8366u1eRMx5YbZrn72jx4TH5bD
         3DEK89LVcKN1iz0kl2j2BjD2ud0oOYqD9dGSI+VRt4E/nJqtE2T5CUNQxcrmHcsxIYxL
         9QxL5KH0VtqLRpQrhZ/GLkOQ6j0zuFOsCH/4RCKBI6SHTbCls2G2hX4GB3H0q4N3iyXl
         PMiDN+ti5dSGEJ04GfKQTF9IJghXKarCWZBEtKJRELXMekSKABoyOKir1QP5hsh/Ss0p
         6jEw==
X-Gm-Message-State: AOJu0YxqladinykBwUm7Qu7Gi8RtmP9LfPgyhkA5IiYZKkuLCBS6JdSJ
	64Cd9XSLK5QKyf7t8KBZJljtSDn0yk9rYIvK5pwvxOyO3yHqdSp7RMH2UJkFBkr/03SnnqW+Oz/
	iyuZiQZaEaWaoJjO0ewjx+nSDI9RwhzMqhCw7cDfezY/R4Wsum8WvUB4=
X-Google-Smtp-Source: AGHT+IGoydKLUBThvH+3d6fgUvt9hXrZw7cocgo9dBaV3MwW9VRAXYGxoqY6ziHjrHwtdZ+I/1hWHG9rTg7hke90hfpuvyxkCspM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7104:b0:4c0:a8a5:81e7 with SMTP id
 8926c6da1cb9f-4c23fda54b7mr383644173.3.1721551933280; Sun, 21 Jul 2024
 01:52:13 -0700 (PDT)
Date: Sun, 21 Jul 2024 01:52:13 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007227e7061dbe0b9e@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

