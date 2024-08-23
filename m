Return-Path: <linux-kernel+bounces-298264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3673B95C4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87B9286424
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF8454662;
	Fri, 23 Aug 2024 05:32:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0742C190
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391125; cv=none; b=DTMXnNHenI3yFYmVnfDX7DznxphBfcFCJchiiIEWZbXdONg9XSiaV5McYEVuPZyJ/ZVOQrO3UQxKySikhKuEzwZl4R/F8ODlUPzUc2HgI0Y5VVcxm1dGs4gCt0zBBVw6HKlnqIY+8AjXrnO8Of0DPpTezdqylwfwALQFfeNj8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391125; c=relaxed/simple;
	bh=tjrQgKnSLxU6gqtQhbFxAS8Cues4EU6rrdqxMr7StuI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ozXqZ5EPPwBbRtPmKdBj9NNorQKv1VTtcv3clXrRDGaUBovQVLyMul51IUElwdjVIbI/e9y0TmyRGywvzHgx8F9UcOOcYPTfvLvS23u75bPgK8+CtbuzEEvF8M4Gc52jY1a6Y0uo+/vbUdzTk8Mcq0jQwxZ3RG4YNkLpJkm0ATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2c44422eso15296775ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724391123; x=1724995923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2PVRUYIT6Fc4Ub3JqcZqbEIaTP7rGZEx+EtrUsZTBk=;
        b=pK7PKylNWV3Iqgeh5IgQ6tqtAdhYVIO3SPTgmV33xVXAnv5bYiySwm18nbssO83jJm
         Cc3WjJjm/zKOi5f1ZTwg5ugkyncBXstSEKTtoEwM48FH2up0y7lpLZycOn4b/4TkA+nj
         FG5MxKmB45osUt5hSmsepCOr8apxQtzUbBM+oYTxXqsja0K3wstj/c721DQOekFdO2PG
         20Ju72IFhJEl4e1ls8+avwjh73GlX45G4GQVyVInstGLjwfXPIf7ZfE/GQuB4wCGWV31
         zW6tLj+AjEZeBp1MEcN/ufpsmCm80l6DJ8TKn6ewYdQ9JKb1fa2SuQWwE7G8XNZxlBAx
         JSBg==
X-Forwarded-Encrypted: i=1; AJvYcCVd1MxNSNeIcOy/zAH22Ky63q+fqt7M+2fcx6zRPz8i4tTKtO/+jkilJdTARTSTQ40ARj5X2/cke2Qn1fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+da01quRCiHR1G7rbRH38TU2CSZkycTIa8ODtwjTWZeqUAHq
	7QpmDpd47Xo0gV/ufnJ9acUn8PlJPDNaVlpi13tjeoFqubbtmFMC1bfQrxa+sGdk8YVIJkPJAE7
	q2HOyMMEuiu2akNZbW+RP05P2nKEVigaN1cXp9eVdWpG/yGglSITEbIU=
X-Google-Smtp-Source: AGHT+IGxIGinQXrgQeu1aksPsuMqmFhb2nPAuudXA4Gm4V7OxTKgl3xmHX00DpYnL37BZRFpnyg+c5Cac15bGnSmjxGVFZZxOwqf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6a:b0:39d:300f:e91e with SMTP id
 e9e14a558f8ab-39e3ca0d343mr429575ab.6.1724391123033; Thu, 22 Aug 2024
 22:32:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 22:32:03 -0700
In-Reply-To: <d97aeee7219040e77c575d78995307cb7e87fcf8.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057b4b806205318ab@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in clear_inode
From: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/inode.c
Hunk #1 FAILED at 723.
1 out of 1 hunk FAILED



Tested on:

commit:         d30d0e49 Merge tag 'net-6.10-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=399230c250e8119c
dashboard link: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ae4b05980000


