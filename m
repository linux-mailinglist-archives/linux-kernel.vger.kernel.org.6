Return-Path: <linux-kernel+bounces-282467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89594E470
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E76AB213C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D824B5AE;
	Mon, 12 Aug 2024 01:19:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654014A24
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723425548; cv=none; b=sGXtFvVDykLgW+aLybHI9pzue5TvfXnJT2qhIN1ByVhNuV7UUtofgmedIO0MvqluWENhI7bit4IYrth2+aFCiVN0aWOhjzLAVIsi+2UkHYiCTzzgA6jhT2lycv/6ItMqfiXsQPQpVhXBr90VQNFaattEFTouLl2q4DqMRp8aMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723425548; c=relaxed/simple;
	bh=Zh69rWHLJng2lHajM1irZM1c3ZtqHByp5xijl7PI/po=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AtW9hl3dNVRTyw8rt+o9IMIVy3FtN1TDG/Mg6KEjChqv3JrMhCSbTS1i8jH0T6FBc0vD5RQX19UNce42tGUKV54kmpSpuje3X5QChQOCiVbuozuv0HrAgje5re/SCp+cXnGicCQ8YvGH8FbpylH3A8wpP/W1S4a4ZRZIU3/j4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso49448845ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723425546; x=1724030346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh69rWHLJng2lHajM1irZM1c3ZtqHByp5xijl7PI/po=;
        b=nCVNS2h9+iTeBh7n6aczwGhXR1eER2+Hw3aESZCJ3hGosEoCNrZXjX3gkYUbfYY5dN
         ApckRUqyXx+Qa2oFnwhIHGLIXkIBCq3rDvCMQmoBid6hjnzhFCXK5VVv3dzvPPc0aGum
         Yy/ik9TzfeWJE1jpz9sKAudTBPwqEf4DHdddXo+yrfKTDBGQVaJSn2ZQW2objSaFQj+O
         PVLpBtLgjglYoqYHEHs70UpwFPjhrF1QQh6k1a31wvRfWqhTbK56rliF6rrB0n2r5bX2
         JqsizpZpdzaqNoIP6ey0jMYfHcn6XoHXKC2Q49jn8/6++YmhfTj9ETd4SQ+bPFME/nYe
         5BNA==
X-Gm-Message-State: AOJu0YycF5K3I7zqjPST4bvv2Wi+Nif5Tt46Iii/SkS6r1jNOwnAWsJS
	SMOUQ1moGtay1VVmhsMedDg3ch/0tGibdJUTj9CrzZVoLknEGMTuHCOLqSTFKGg748eHdfu/v0K
	Ylo8C7Y92OtrMZKnLJbKaf/l8uSWvlNmPA//fQ2j3hOqKTzeWJniF4kY=
X-Google-Smtp-Source: AGHT+IEwUvG35loDqgshs4ndYvwkfoX7MJanOB8tiEX0ifYY1wynPXOx8iEZJorkXCtAuoDnz6WLgzpebykMdyFQdM3lmap6POKu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214e:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39b813286cdmr8275315ab.2.1723425546482; Sun, 11 Aug 2024
 18:19:06 -0700 (PDT)
Date: Sun, 11 Aug 2024 18:19:06 -0700
In-Reply-To: <0000000000005f5a6d061f43aabe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ec4af061f724751@google.com>
Subject: Re: [syzbot] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: BUG: stack guard page was hit in vsock_bpf_recvmsg
Author: xiyou.wangcong@gmail.com

#syz test

