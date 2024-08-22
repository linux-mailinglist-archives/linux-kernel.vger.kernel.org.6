Return-Path: <linux-kernel+bounces-297751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14D95BD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4E1C22245
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABE41CEAC6;
	Thu, 22 Aug 2024 17:26:03 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99631CE716
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347563; cv=none; b=u2TPfCFOoXpeJy48/HQTOxbDGVo6/lpokrE+nhiIE4gOCR2HcukwfX63gyo7FhF7FjtxF4uuAyWR3Kd87FAhzVfA4EM4Tk826TL0z9BvqyerQhVMG1t1B+dJAYR8whXG22gGPeXAMhenz6uti3qgEGdqwQTHctKMAfuIWVKgk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347563; c=relaxed/simple;
	bh=V5BwEY53IfgWFUEAQ+k2/OnR1Lfz74vgdv4muSZtReA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VfhG1qHc60Tv4jWrbIm3u5tjBhAjIk7J91fkE92pp48YLDEQ2BRLGdfVFRD2YyYJC903pLHVfAnAzPar4lwjkcr09JkRxtvmYXbw17YpJd3VNwiFzQ4tcVKry4eYVVpV+mZhAucb3fPRX6+sAQwvVAQFlHs2gUL8qgcacvSkqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f87635cc1so109090239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347561; x=1724952361;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5BwEY53IfgWFUEAQ+k2/OnR1Lfz74vgdv4muSZtReA=;
        b=gng/St/nVKDYTo7/gOPaXldAY+S4tdDdGxPLHY0QPiAHIe15HWLqRC6jgIU9gqO00U
         8ZpqPs6RCymvj39C2k1aAXFh6zr4SFzqzKPitEPH7Aj6OcBHepZc+PrGfFJ8HxDgLJ7y
         nvvWFEsUJW2Ns51pAMBGCSCF+N53/FzG7qL9EPmeJ1DHgT/hrG1H6Ps43lAdWp9wu031
         +vAGnvevwp3l5RC6LdP6ooy/lb99Jkl/AN9ZWxSxw2lB0/K1xSFpE7hqf22/flNAO+Hg
         YpU8K9DRnoaEJIwVKg0i4E1RdqnO/68+dS/pGsUN50AKchXVXkbdLqaDE1M547ZOAJxI
         3k6Q==
X-Gm-Message-State: AOJu0Yw8ffoMWkfU3u4QHdV2O/sJnnZGEQNde9ZdAPrmuT5nNyGd/Utc
	wVeLIDAsMJSgvFp1AQ1jq23wgoLjTnQqMkYU47sb52q0Xk4zLd/c/qA/R0fE08hffvfqMDULptr
	hxjdDqjiOZB+/yuuwZIIhMRUO5TJjmsLPLkuENbkAhN4iuWbGWkEKzVU=
X-Google-Smtp-Source: AGHT+IGd10sMIHkeTp0nX53qTlIlX7joeDtuGDvIsGylJx5WGaWZew+2Ykelb7ShgSDlPc/UH+ulEdrYDH0OpQxUcTStxQU4gJiO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8609:b0:4c1:b049:25f with SMTP id
 8926c6da1cb9f-4ce7f3ccac2mr36730173.1.1724347560797; Thu, 22 Aug 2024
 10:26:00 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:26:00 -0700
In-Reply-To: <0000000000008c9a4c0617b9140c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4b8c3062048f38b@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_sort_keys
From: syzbot <syzbot+300755e8da6fa5e5edec@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: kernel BUG in bch2_sort_keys
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Fix needs_whiteout BUG_ON() in bkey_sort()

