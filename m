Return-Path: <linux-kernel+bounces-299282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2E95D251
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147C51F2698E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F5A185E7B;
	Fri, 23 Aug 2024 16:02:59 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E14186E47
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428979; cv=none; b=fvusCllW/jbdDUZPiiz8kxte00gv4VHD6MeI9GFscOsiMgUuxIKzHBvFUWib48ZnLAMTmKOplsRDg7pekSLQd9ABKm9yRKypvm9B51CZb0VoFvtExhaij64vsZedouoQkF1jpKLXwuUuTOOwWWJqK8WEGxCTaqiFz2G61GNeH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428979; c=relaxed/simple;
	bh=Uaq1YphO+taDXIi18Hlg7iUAK0nXx6GfH0xMaSpgjsQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sKA2R2BI/Px6vY7+ngtxqrBlLe7XeNMfDZ62RKikxLO0BXLXBJ6/XHrSHVNMD+6Iax+GohW9Nlj9C+yH08ObL2Ywqvz4L7pKKzOEw4VpYocoIm4rK0nszCNbG6M4MjldLw8SpostHxyNojwd8tfezUZQvRpFnH/QeQORprPZXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so23298765ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428977; x=1725033777;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uaq1YphO+taDXIi18Hlg7iUAK0nXx6GfH0xMaSpgjsQ=;
        b=ofmALyd29clGNPymMQmnP4c4Sz26ocKKydPwfdKO1B/tD1xV383freMEabElTcNqC1
         V1+5f5HRYPdX6nzw2e5PGS5zXAAsR3MdzFT6cLKl07rgFEix5SpiHWqkmKx9dFW3TrPA
         u4lCU6Zpdp8zoeJfbMJhDa3/cdB7A7U6jn/Z8sNfz73KZBWaBZ+RxaH7Y0A1VLnyurSy
         6D2gu/vDgnZsPBo1fXN82sRRPuusANkqyplllboLnRdSe22oceHrEJG0YNOJ2WUprzQl
         BallMVZfSnjj75ygkUC0UG1h3YzjcB89JDCquYHsNp9Pclmiz4SGmnVKtHsD1WHAnieD
         sTew==
X-Gm-Message-State: AOJu0Yy5LzBputGH4wmfMi34YNcQV/4dsLzA1SnPJXXv1EKnLVOnVfu3
	Kxl2DgFWDOHP2FH+G/htPct8id5eVxH03J1McZko7hoP7QcB65U9Q627nojQn1aq4mgr43iM5HU
	kZu1XkluQbBHasUrYw/uq9dqt3TS7Trm60IjltjgjHfRyeTGzJ1IqSk8=
X-Google-Smtp-Source: AGHT+IG4irDPyzZ4B1dxTSJXlZchHjGqOFGw9R6B18gz9rAM6KQMfN/4heShUi5VgujNLX+RNceEHKXLvGiu+Tw9Gxonz/7fpmj3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:39d:1a4c:b853 with SMTP id
 e9e14a558f8ab-39e3ca20521mr1850945ab.6.1724428976587; Fri, 23 Aug 2024
 09:02:56 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:02:56 -0700
In-Reply-To: <0000000000001a94c3061747fabd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009714f706205be86b@google.com>
Subject: Re: [syzbot] possible deadlock in ntfs_mark_rec_free (2)
From: syzbot <syzbot+016b09736213e65d106e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in ntfs_mark_rec_free (2)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master


