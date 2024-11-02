Return-Path: <linux-kernel+bounces-393073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF059B9B92
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50DD1F218EA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37AEE545;
	Sat,  2 Nov 2024 00:30:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BE5223
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730507407; cv=none; b=X2KVU+OSF4WUdz0O5JsAmYUNMknQjNy9ybsYM2D4YWrSzaDxJfvkXn7Q2qXwTd+20o/ZcGkrLE9JU8q8PaXc0ON9w8xY/qCuKd1WYtj9zJxfZ/Dd7yym0gwPpatTiX+gW/Z8w0IbRhY5DzXixNDPF2Mh9V2Kac+2dzQFw9JgV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730507407; c=relaxed/simple;
	bh=pMfgz5FZcB8V1A7a+f7S71bDBICz8+sYDJAe+NTatbw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LzMQwb5MW84mb54HXVKYNI/lZwgf9T1dOzoJQc90f++Q932u4GB8UCHfQQwo2/XR3g3yFggf1h360kYw25wiYRIAQvJWiTVEw09ObXw5sODfuAaeBTKGbLpo9ZJRwo7rx7CHw3vxcynwgIESan2fFRxKYmZabnGAgjrIUa33fqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so11315915ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730507405; x=1731112205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvYoAlr7fwQXNVysMTBydtr2zz2d8WPLkEiP1079ZJY=;
        b=nzFB1p2BaeKiQ9aTlFYRTLS+WyyuTvgrFUXfFhNK1gymerR6LmR+lkwSLwg2fdY43m
         Co80n/nKgT9y2Zl3al88941kA6CsKYY8/3o5ockZwzntSdkG5zXc5tugieC6c9upiJTL
         ao6JTiGI1vbNxGJaDeqaxvzFla47ZPHLwGZRHqLacMrtR8keeoBYlSAzxt2ePjmkrjip
         2Mvu1vFqyujg8x0APF42I4l/asKMRri20ch11K+7vIg7GFCs3fHE8nLP6i4wY6vDlwoe
         EaDUXM5iQ5TbGP8ZEYd89bWZXYgB13mS6QN26lE6wYH1btbV4MlISPk/YZiUcFUyevh0
         tUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVytdElpGP/hsZNoVQ2okOACsB/I8t2c6JbEDvhTYP5PFDQuCswjhWyEHzZnTd6s/7sNhaxyyJsivOryEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvqQIkseUACeS3oS3Em4aCqVLghIjF+Pt/qpZlcjTb78epzVB
	6wdAhe5cd9xsOVml5CMw9ENZgxnDiQBzaeW9Vg9eNzfHHRZl922Hs0sOvL86CyZx0WZUy2kRRGs
	gqEDh/i8+Kclw9alCF+mfNd045KoFhRoODQCDtfcUeI0xai7Ko4CUSbk=
X-Google-Smtp-Source: AGHT+IGLVu54dCKeipWN8mJjJQ+jVBl61bBu50QIRiPDovbY6NM+cKRfEZ3D6qvp74f+akmS1xDJi/TJh3WezG/xoCeTijggyW3f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a6:b9bf:71ec with SMTP id
 e9e14a558f8ab-3a6b9bf7f81mr25163805ab.8.1730507405136; Fri, 01 Nov 2024
 17:30:05 -0700 (PDT)
Date: Fri, 01 Nov 2024 17:30:05 -0700
In-Reply-To: <20241102.090820.1442069226259701918.konishi.ryusuke@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6725728d.050a0220.3c8d68.090f.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in touch_buffer
From: syzbot <syzbot+9982fb8d18eba905abe2@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9982fb8d18eba905abe2@syzkaller.appspotmail.com
Tested-by: syzbot+9982fb8d18eba905abe2@syzkaller.appspotmail.com

Tested on:

commit:         c4264568 Merge tag 'acpi-6.12-rc6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1454f2a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=9982fb8d18eba905abe2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1726555f980000

Note: testing is done by a robot and is best-effort only.

