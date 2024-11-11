Return-Path: <linux-kernel+bounces-404769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BFF9C48AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4ED1B30928
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7F1A9B3E;
	Mon, 11 Nov 2024 21:16:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FE1A070E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359790; cv=none; b=RcibKFuLs5W3mRmY/vGYSoa5zPxiA91DITwjDLBJ2tFjACLwerkdv0upu9ayRTAYjTVaimrUuMDayBUG20IXPpSgkmNoGI79ALo4pjdquhPqv8FABoYdix30qZmIknIMVJ1O6tqdNr9BY9Bup8LkGTG3baNTlo8+g3Ea6TrCOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359790; c=relaxed/simple;
	bh=7WyqOUOYl2qSgOkIYEyNj6gMwTnxCtu7uYiWpjTb610=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lZY4F2lEzNVD9LmvE/JNMhAKTg2m1hRwc5jsY2QNbmpEeNciw4K3Oel2veXNrMTZ5+ScVo4xR8o8e+BN/lLeTzKBwMNcqeUhBywkHMltXi1Ml3/L2HP8SZv+HlO9hnBHwPRr535bUJZjA4zCYDgTmGOh7FUWwsZc0qm+4tjWc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3cb771556so61491895ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731359787; x=1731964587;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clNnOLzNPxim1+kawbjDSGfOrNZUji9+W2LA6+ReuP8=;
        b=fpqCaZPii31kotf7IHZubcH+Pli6x8tlgIxrlbdemA11mVuT3GH8HubxLVbNXOYDKE
         oCcuFGJp/rcey8AJlNV67aqlA7UHsuWzGntf5YHT2Alw35ZpZrzTpym7K7lJJKVW+bia
         iUq/8SjAsNxnVTC4+Ek44dPYcKj8zFoG4PjyZOMXk9krs/ajJl/bTqpQmtbHia+AnNXq
         y3+D0YdYe6H0Vh6ZH1QzpeGlDRpaiEgr7VH1Rj+jRLr2N3HwoM5JDQIVazEIGV0LLpoZ
         Ej2o81vSqbu2S6LEyGYJ5Pv9c4UHpBZWCwtTHONmRv7CDIklW8tssMZ7kvD1vWmhLEVQ
         rIFQ==
X-Gm-Message-State: AOJu0Ywe35ZdauCuYtB/Hl4u8vaXyratEmYD9i7bMEc4FbhHxsJfzdxP
	OpL71lCQ/i68O05lplUD1m7p34H5Cld7RkNAaEKISeDY/AFfl8hlnPX5Ow90Tt31+UP2KR+m55n
	iCN2yxJ94CNgUyWtI+TZDtc6pDjDTwr4H17b9kbWRt4o3amrkoPBJonI=
X-Google-Smtp-Source: AGHT+IF+zSa5Ro0L8wqUbsyJ0I+kSJOrwdQPGZSJEn6qB9hi2Pjs/hIzWiQUvjtbILzIDa5WoEMRGMK6egHatS4m8/tTk4+OeGpm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214e:b0:3a2:f7b1:2f70 with SMTP id
 e9e14a558f8ab-3a6f1a759aamr137811895ab.21.1731359786852; Mon, 11 Nov 2024
 13:16:26 -0800 (PST)
Date: Mon, 11 Nov 2024 13:16:26 -0800
In-Reply-To: <671877ae.050a0220.1e4b4d.0084.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732742a.050a0220.1fb99c.015a.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+4f29c3f12f864d8a8d17@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix assertion pop in bch2_ptr_swab()

