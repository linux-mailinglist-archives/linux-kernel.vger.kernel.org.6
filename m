Return-Path: <linux-kernel+bounces-173859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0498C068D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE8C1C2119A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A7132816;
	Wed,  8 May 2024 21:51:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6237D3FB
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205067; cv=none; b=U80XQk2cqOQj1MCZwP1AHn4mfIe6BJJ17e+ZuY3BJVd2upqCgJNGuPag4znjGraAZ4hZB+10MhPlFfl4LaepM1oKw5WVDZRQdR/TuK+lHB+Yw/vr685ys+6taGvZO5fYxvROCmuPt8yUks2lu7uBSfMo10oRpiUcpqWk2LZrgvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205067; c=relaxed/simple;
	bh=eJjEcSgebcwFM059pnNtpFNbNgETDRBOLS9rFVm9fNs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M8xEo9JCVmWrPx7BugiP7biLwX4dMjlSJS+m/JIUvngaJBjrhxDE3tvWuDw/VZ3Fo1fhR5moNRQxAD3fJMRwvWeEK5/g2th1ijVRBWEjkPL9coK5TRwOIUDdFWTp9z432G/8q+R2WZNP6ADQRG8PeyyzKOGkSibgIy9WKkisG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so17303239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715205065; x=1715809865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6r/rgrh99pD91WI0nDuRj5BeEdIm70lvzLY4UwUiEPs=;
        b=RnN+oVyLAXUmt/9EdCNIOlgLKWzeg720YG6RAia41RvKCHXcDbypOQD2EIxINCB85f
         FtahD0G6jyqdeBw18fIsl3DsAUS7nHGB86mQrSbo/Qv+rnGMkoDEtxcYq5tKEu9h5zch
         ZIRFcyaVTr/gkqd26DRbVfcgblZ5LR3F9KUeP4g3HZwXyhm3x8I6rCbkY0Gxlq/hfVNs
         yhbpk38D6YjE+NOO+EMYUZwlU1JjpOECnsrMVnzccwP9nr4TX8WBVoTiRL3xmW43UOO0
         qRjyUrOyV6k48TgJwsM0FruyAcJLlHakyGo6KwdWCbG8jNVRGlj48mLs9H6N/OVY566W
         5P4Q==
X-Gm-Message-State: AOJu0Yz2U7DLKrRodoPK7az1jqyevFu4lLDwSCBtcCOV/Zv56wfim1/R
	PDwwWCAH8tSpbku8t9uwtJdSDBlTUo3t/TwQ+uHyDa+acu9occP824alBRtxsEKj43Fg3omGSOQ
	XIAL74RiQ5KhRuO4KIckHjdRxnGprdeYpxP3RU6SZj9XuRoFIKTEHMNg=
X-Google-Smtp-Source: AGHT+IG7jDohLjMVtPwTyHt/8qpbFkWXXDCFJCYffFRYgFYWFnu9kqjXYQstkRNmT+pT0qXG7qDcOX7U0kAx/LghlRGYTMko8WJU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:890b:b0:488:b7c1:401b with SMTP id
 8926c6da1cb9f-488fdd8402amr295571173.4.1715205065578; Wed, 08 May 2024
 14:51:05 -0700 (PDT)
Date: Wed, 08 May 2024 14:51:05 -0700
In-Reply-To: <ZjuXMtWceCuembsw@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6a5940617f84cab@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/master: failed to run ["git" "fetch" "--force" "675adff2843877c2da27b36b2517f827bc9915ea" "master"]: exit status 128
fatal: couldn't find remote ref master



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a463bc980000


