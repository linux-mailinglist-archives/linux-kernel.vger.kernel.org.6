Return-Path: <linux-kernel+bounces-320190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC797072B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27ACA1F21ADE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF6156668;
	Sun,  8 Sep 2024 12:08:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1918C22
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797285; cv=none; b=SquZe31V6YYPHbFGApfnWQDFhwl9nQOa1EdQsWQRMTEmMPT/LQw1RNJ2drUqMi82+zEHB2+bjfMkdkmn2hrLkj9HfENEIVI08mxBXEAfvtGxlbO2jiW9paNmSFObg0WhBEjhcXdhLW0RGlbTbjAvRm1mCMY2lDgVjhk5+r0KErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797285; c=relaxed/simple;
	bh=O2vVubl7eodvU9KCwDS4uoi5Exj56B2RGaW4JZA4MNs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FFBoUwZqmya1NTT1FcZnifIB82TsJaGXm08ctui3R9sn+5pEaWOJT4to7eVFPk+vxfZCZjj6Elz5lxYmn6Tf8ZbXvFtcqLw0G6o4lgy0fos3+pOVKkdtGgRDqwBPLtg1StaRrD9FjOG+zJDKvMBOv2NKEddd/fLCTnDQzepvbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0459a8a46so72898885ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 05:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725797283; x=1726402083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXT/3QiPRhKyZcpqb21LbK+IFZcjHYr/pzjr0chrQww=;
        b=ge6WYgho//IkMPWb4nFEA/P6fy8dbahTocp1MuxePm6DdbGrB6UahXpov0Ngdw1W0O
         EtnA7oPzynNoBvxWlgYyEtLo7yrpmf2DDXPRkFOXUFEx2sxXpq7eiILqjtfiEEgJqaUr
         VaY+6zEqR2yhERyCBzSo/pCWJeIfwc16oYIgOzrdxvEdvREnkLkBruUieV0cGZ6HeG5K
         PinP7dMlgrTS762XDcMISPF7PlwwGUW0M8qfsSz+VWAR/qcsjpcCbcJR4DUZHxv7wItQ
         npyruFIkHrFQqCKrHX3mE6FDo2LpV7nl+dQw4kqpf7uDdh376wnFNVqwbGR0CcNIEOkj
         gyZA==
X-Forwarded-Encrypted: i=1; AJvYcCXon03PtWYY85Nu1yFpd3CojSXuA3wkMprQZbeoDGxSYH7Hg2b7+fyDYE8ljSxqS+rY74jGM6IM9srxqi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIT51bhEF84+3gyHBTPVBs6/x+TfHNOCqaurOn/UslvUmk2xA
	oTO6BVHDDMd+Wy4QUBe/uR2otXX3GJPkxos76Q8FNONGca8wg+AWstyE8G1T2eoTGxrMS4mrRIr
	2cA6whei82Mt7Rak5mORoejBIdaIjK5p1XOrCSVHSyo1rD74gS63BlQs=
X-Google-Smtp-Source: AGHT+IE5W92AWfa1yaHlNdCVJm9Am5A3d6JGlM9d00zgaHkRlBoN+68Lr/mPfFCmPE01bYkYOG7bg5F2lStc40tC35Tkv12J/lus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a057462029mr53800675ab.10.1725797283229; Sun, 08 Sep 2024
 05:08:03 -0700 (PDT)
Date: Sun, 08 Sep 2024 05:08:03 -0700
In-Reply-To: <20240908113322.14366-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000583ca06219a7eab@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Tested-by: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com

Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149e589f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b6589f980000

Note: testing is done by a robot and is best-effort only.

