Return-Path: <linux-kernel+bounces-573075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E7A6D2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB473B240A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393919BBA;
	Mon, 24 Mar 2025 01:21:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EFF9E6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742779264; cv=none; b=AtWMnNHVb3YiCcvJLaJ3S2Aza1rleYq31TJi40II52UF9BazOBO+yd0Ndjf9xN5GmlPxErB4m2TdaHXESLz+4b+l7xEgmuUCNfmVeUzCR+6PsEtLSXnhRVoYLbsEuuZpZ3hEee3CRzJZ+1cMXqOHwGmDGEDKidFcZAgoldwpDHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742779264; c=relaxed/simple;
	bh=0T8Mfppz62giravWUhuIq/mcQJfQzaHRVEP9TkThnLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DdrT/J2MGyIb1xirIKvQ6yVqI5Ff2ejwckej1VEeg+VpGefmAtxsXcLqd26/MAt4tK7rP8UuvgzI/DPCVNZSwqjyCOSG0I1Pm2WJg1lDZ404ILT7yWsdggY4/d3irrWnXXSg2G5Cxg9Ij0A69lnhWVLmUdvwtgJBbssQ6/V5peQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b3b781313so866256039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742779262; x=1743384062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYiIZyj/qHfZFVHbm2b+6JjYMqU44LsSQQD0rVok4CA=;
        b=EdSAzmeSF6vv+lmj/L5uZM3nRmEIVwY92Ltq4kPkDS2aqXxST34B1/qsyDmF4gR0eQ
         lgdBVG98+T8/nuGlJRODTb6SdWw8eDj01rHQwAgmMIwb5jfFk1jnIramMoXmji0OlAp2
         QrSWESWOStMupJPOHRgr1g8VrEzi6bXFe+L+x/oLaSIlZAsgdaQwdGsanqOWuFC7e9qw
         McrXvjyar4rXrDsjRZeM3wXmlJUH0wv52zvEywK6CzteXCY1S5hWNSu0Ah6JVnCvOcxO
         2jGmFS+jNtSnf65+lbZTUOBjJ3vlQHWGTK9mVvw+ddiyB69yukLcmPVJOdce35hdNVF3
         88ww==
X-Gm-Message-State: AOJu0YzFk9wsJq3AaacSmw948hEIHjVABVX+NzkUhPO16c+02tWdpPFy
	NfI+1v8SCbafE2LJVg024vlbW+4W/mB5B/9xFbjD76oHGBEhzNH2nvEL0JEyi4xh/t52mTzEukc
	ty4ftAqSpkjz7xdzlliOfUK8qfNY317LZDx+WO9yPvBgQcCct0kAQTAc=
X-Google-Smtp-Source: AGHT+IHuAnVTKSAEKRhkPgpKkOyEw5BOzxvP4CzHeG+MMRN6Yf1X9uaJnwF7C1/F+2s6voJto5J0o32nzkioXO+ywvvGxC9nEuLn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3d4:2409:ce6 with SMTP id
 e9e14a558f8ab-3d59612bc91mr133885365ab.5.1742779262570; Sun, 23 Mar 2025
 18:21:02 -0700 (PDT)
Date: Sun, 23 Mar 2025 18:21:02 -0700
In-Reply-To: <20250324010140.2046646-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e0b37e.050a0220.a7ebc.0008.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/quota_local.c:313:19: error: use of undeclared identifier 'bit'


Tested on:

commit:         586de923 Merge tag 'i2c-for-6.14-rc8' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d4644c4063c5098
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea0b96c4ddb49fd1a70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f7f3b0580000


