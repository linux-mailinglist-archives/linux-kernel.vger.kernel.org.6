Return-Path: <linux-kernel+bounces-234768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F091CAC5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B241C21B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F51D52D;
	Sat, 29 Jun 2024 03:08:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75B3C0C
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719630486; cv=none; b=sjZE++bkrQJT3ATgfuECBdzEkU3zlLh3IIP80Bc7cEYl6IqqOM73W0oGBy2rDK5Wo6evsfG31WWMxFEue92YmghuTw00TPj08/GJhYCBN78ka7ht8ChdnHiY3V2YDIt2cqaKm3ihNrOMHdoJNyxjkGFHQoLJbqCk+B2JkUwg6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719630486; c=relaxed/simple;
	bh=H0+F6Q7vbRJdgA5pOxUG4nvex583XchfX1bxUDq/zCQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nS0irMQ5xgJ56r8fPqEHNsk87Bty9Kh5fJNhytVP7CDdfsc3uEQP2Uc0Oy0myXKlxHl375X4yybImH40rcz2MmM/mERX8mjCJCjsVSMW2i0rrNJdYm3MGkKlMHine4Ylcl89RGUMZ7LtQk7TJA0tGGBOD1xjdHJl2n6r+4R/dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3761fabfb7eso13439995ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719630484; x=1720235284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Z+pBbG/ZpjTZomMfmAj/znk33JxSKSJdRhZWl2f0U=;
        b=mTu/PkMxle9JcNJnIKfkyU9aX9UBndVoAPDAvkRO/TLjH8OEzNLElWbA0kJ23m3Xa9
         1A1Z1Mq4+32a5CioCOJyTEI+RgQjh15lbb3669WoyQzuZbzbl7oQCRTzV7RspRmvPNuc
         F3vr8yqzT5wM9duXFjvzS6WuJeFR1DO0NBzVUJ5siL4FB1p7qXJ6GSoWIaBfSmAtKU/v
         fAZv+tglqVbLSdSh/nXFWub72UIoZp0A9ZctxYLw0YbkhKdRhqGQUivQ7lxFJOJfmKZT
         PaBrXL+96x17lZVHNd4aSAiSjOnYnTXsnrpMPyaroDNsm1RrR6D3Tt4/3t9l1qlUCWRh
         +X4A==
X-Gm-Message-State: AOJu0YyFhHQXEYchy9tKprSvToO5R/vgAQqbN+UbaG+XDdE0kWM/z4B+
	n9LnV5b8aaGWf6Hu0xE6KuLTKPTPcY1+t6OjbBJsYTNuAI4HRApoqfOxcL+E0FFJMgS4pAUKnkp
	XhUsM6ROFr99tERIallnixqGU5hCsJyeEa1FWSzTZGL7g381UTrGOvho=
X-Google-Smtp-Source: AGHT+IFm90znI/rCcAVOMghZDJBCj2s5R03rQd4tnYZrA8FHtPCqeB/6YB/fJ8J86p2z10tlyqp+TpOpvyXHa4VRd0hBGxJpUuNr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-3763f70d037mr17237195ab.6.1719630484545; Fri, 28 Jun 2024
 20:08:04 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:08:04 -0700
In-Reply-To: <CAMc0M--ds9-uTtNRoBObBhnOS7RbOhQHkvgxAky_d0QrH=jexA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d363e061bfeac1a@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_usage_read_one
From: syzbot <syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/bcachefs/alloc_foreground.c
Hunk #1 FAILED at 1631.
Hunk #2 succeeded at 1721 with fuzz 1 (offset 74 lines).
1 out of 2 hunks FAILED



Tested on:

commit:         1eb586a9 Add linux-next specific files for 20240628
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=b68fa126ff948672f1fd
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11910881980000


