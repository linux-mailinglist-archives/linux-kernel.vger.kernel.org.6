Return-Path: <linux-kernel+bounces-381030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A49AF94E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9A1C21E32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A518E058;
	Fri, 25 Oct 2024 05:51:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0052433CE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835468; cv=none; b=LuJT4H2o2+NUlLaE06K20gy9zlj82piemRspob0pK5OxXocA3+fnXXvvX/IIvsQVceIkhGhiHY9o0+5p5FuhRRQFwzFpAmlcHgAeY+xnYr09sbGmjdZQ7Lw/H3w0dvhqZa4TCY4Tb7I26G9GhRa1eZEO+uTb4T6GXJ0ZzPt8udA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835468; c=relaxed/simple;
	bh=kaIDtti5ztLlhYQtWcRvX3nNnZFCos8gY4VpmzEz0Ws=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AAWt8+n+UaEASjnbqWBww0QUrKvZKf7lYIBXPn2H5pA3t5YUk0ejtuWR/TxaLB4D0/W2PJF1yRRGl4umApdhusoiqLU5Pu13K1MbYpO8FfeVHROXk9Ysq9SmwRoJ64f/2F5FRwxVUS99sBr16t5J7DMCWzPhRZdFRwePBfh6p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ac354a75fso165764939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729835465; x=1730440265;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8cO0Y3s+vIDGgrL4ZpopjujCRB1n9+Cmlj0DW1dNZ4=;
        b=wLNh3owGokz2Y0JnQgT6DzvImbWHUzx0N8U5ksPRm7q8pjfk3aOCgx1IVf5BhrIEkL
         dVy/MiP5J/Fh1f4ulcWO3Xew2boLCtvKHNl7NXvrawPTFA3CbMu7MB83ihNvrxvKbWjf
         fcVN4OuJwblxyL26SRvFuWwhMESKeqDcoy7f2w5uxsR4bAuadrNOm4VEZjWvaAVHBXr5
         Mgb24pYUIbA5y/eDxc6SrAAiPF5pNhYk+7nYZBZKZGOQozPlhmZIfSfBxKNxBvmJwJxV
         KS2qoWI6tWzQaBbmERvYH8g8nelc3mFsap30c6EWo7asXDBhzx8n2Mw22qjLtrWLeOpZ
         VrpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC1CubusOswGCkpbnChh7q5wGvgFMtgNDdOHWkFMI2DoboQ5w2hku9MHfT0LrFB34UcIJc4eYuKEXWrdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznKPZ4J13wbWXaVaNtcMgdSP5jGsDxxxagqWexX2unjmSBChHE
	BIKaDd8c4XfZGYtmWozIzWejVt6Z8Kt9eh3XV59YtA34Sdlov/wLqZ9jdaNF57ikJBFcHHoooVo
	4e+cPFWzEBWRivDLpjdpHXyS5mtDL1Eq/t3xgjoxUbIToOltD/Pm7IkI=
X-Google-Smtp-Source: AGHT+IHz0DJFM0dWMDe7qJ0C7fa+k2EXRF/CGEcIxKHFpo1rMLKzrBJ9hfBtQUqLtezguq9nvnJyCINFRBUCZgUKvFHAWJlO0lBd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d08:b0:82a:9cab:9be1 with SMTP id
 ca18e2360f4ac-83af61e95fcmr1062861039f.12.1729835465645; Thu, 24 Oct 2024
 22:51:05 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:51:05 -0700
In-Reply-To: <5950655c-b84f-4a78-a44f-d2fc798cfb03@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b31c9.050a0220.381c35.000e.GAE@google.com>
Subject: Re: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/wireless/ath/ath9k/htc_hst.c
patch: **** unexpected end of file in patch



Tested on:

commit:         eaed5fc0 mac80211: Remove NOP call to ieee80211_hw_con..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10caa8a7980000


