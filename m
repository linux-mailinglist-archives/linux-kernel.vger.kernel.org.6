Return-Path: <linux-kernel+bounces-431332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DB9E3C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246F2281F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D151FDE2C;
	Wed,  4 Dec 2024 14:04:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8861FDE05
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321047; cv=none; b=JNvGtRhlimidtAE37ysvAn8+Mkv15w3iyJgwWZPY0IYG/Jtlc1+5VHF8IZ7ouvzcHXw8gmpIlSHK3HjaLL2LNmRkaY24noKvXpue0BLXfcPNQLdvuC7VhfwWYXO4HDV8ukpAydfOuAiVgG5Rs8sLzL19bAJrUAuqGqXVig6tiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321047; c=relaxed/simple;
	bh=4Gj3kqfWElIWpR2YznFjYowx9bJlOXWWFDmdTukH3Kc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rWqsggya1sbeRI5RsWJmGdEfyyR72aPf79lE4kTG7ZIyTgKGd1BD3JxJgh9PUKdGSFi9DBpMT4RT9SqOwB4IcGuwOuuP0Zvuzu5xb0NWVfr2WakEBNeXduAInKOTcq1M1xc5tvkeERD002e5M1JWX2jI/NNlBGmGyPibushDkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso132875105ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321045; x=1733925845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovPKx38lZVzOl1kDleOE/Yvfcqptl8EjKTGxTyapQh8=;
        b=D2npMfiFaR+3C7M1rwAaGNTiUKZYL0KBcH/6bChtljvHkTEqYYdB29mWN+f+OllzeT
         I49KNHQkLA+yVs2GQFlwZ8nAu/IXU2i8WPUle261cc7rgNpCXlkPCmFLU8uRwQ4ZF+E7
         Ze0pDMkurKHOGcujLXSdIwikSZMta1VZZWG9iRTguhpqy/9vohOjdqtJCCEM1Fv1Lo1x
         05GCALKv/pIGzGQM8QubIQ5zVGhh+KNAmD+YNn5x/+stLu7DvbJF5M1+azSEa0Uteo6K
         SuvT7Xung0fwtvjf1mngGaoZDTnDenoOZKp+EL+5RgmLYz2dMPJMEmLLrNBIIoZUBUEM
         5IXA==
X-Forwarded-Encrypted: i=1; AJvYcCVtxnBXJOSslpmN4MUgtU9jxcWd50vuQj4lVhWxWeaN39cR7rXsHugNrWrreZ/6CCme7S//iHhrOI/2pHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6tjTYV+GCAGSWE6W5192KznWKlNfgyg4ttxpbv2yI1Z2vyetd
	/jZL4XlqTyhjztgEAOHL9fPuteKZbL5YSvLFA4vGwphqTWKL1kLtEQWcG8Yz/BpUx0Wb0wFU1PO
	fsetRphQH8QPk8hfHEewjyTz3JywhDPvB72qtttroWAPZVxr7lRQGKqU=
X-Google-Smtp-Source: AGHT+IHmcyq15VqWSA8qBbrUK7rYL1FSKaYQedwe2i83e4b/FEzYZwUISd3qXbaRpUXtiRPDaScS+sIhZGiM3Ip8xIQPdtcITanX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:3a7:d7dd:e70f with SMTP id
 e9e14a558f8ab-3a7fece32dbmr42547585ab.12.1733321043724; Wed, 04 Dec 2024
 06:04:03 -0800 (PST)
Date: Wed, 04 Dec 2024 06:04:03 -0800
In-Reply-To: <tencent_001B704B941B65254DBA10BB92337F9E7508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506153.050a0220.17bd51.006b.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
From: syzbot <syzbot+9260555647a5132edd48@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         7a22f39b nilfs2: replace drop with clear for nlink
git tree:       https://github.com/ea1davis/linux nilfs/syz_0163_v2
console output: https://syzkaller.appspot.com/x/log.txt?x=1629a330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35f1fa828fe386c2
dashboard link: https://syzkaller.appspot.com/bug?extid=9260555647a5132edd48
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

