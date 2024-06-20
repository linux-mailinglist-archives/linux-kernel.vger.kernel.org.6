Return-Path: <linux-kernel+bounces-222163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91790FDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646241F21916
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189234502C;
	Thu, 20 Jun 2024 07:28:13 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1341EB2C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868492; cv=none; b=BCGDXKGJ21i+25hzXq3hl0oKBViLu8hH9oPYfSa5XtLrWSH+7do9/QQ8ULT8QG6Vi8QQN7zTEvfy1fz5hBVkTVPZA1OAWkogELHqVRZGQZWJrDhUAt1BHS2O8Q0fXvqZ9Ty31lKgQH/0NVKPVAQokCDd9nUMQbJIBIRHixCWRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868492; c=relaxed/simple;
	bh=JrfP7yYDriYkOONFrOPCfb89zraenXhfVUqeDxtAAEY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s6dhPZrEt/5Y/aVDQupm+QI0uBkaOo3IE0LjHb90x+J0wrE+eLpNt4mmWQZ43H4ib+G31pJnlaQKFAV/SUaK78pZbHhv0BlIeJ4ugSppVyPYyDmFOHA2NLY/yoQDWtLNWQ7mEdGQ7/nVu754wNY2FUel93gPl8dQfL8mnLGS+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3738732f988so5673975ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868489; x=1719473289;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrfP7yYDriYkOONFrOPCfb89zraenXhfVUqeDxtAAEY=;
        b=oVtcnLfy7qs3BhnM81j4y++BRwEDDEoxXB2/ZZmkZZLmmhlKKLCSN9t/U3tjiMd7tv
         JWjp/3oP3lDbdVIiZC07ifdYFkYWlI1PXM9fMvRqOBnTSOpJoQ0iLNAhpAbn/5LPrD18
         Kc1DdptRYeZeSUt9fkmD3J8MHB0kIbWezMBiD1H6uMh8UDUgI9QydqOCyQZCwKklAc8G
         OU4WM+eeZAJLXdGPs/JxU+jN55G2EB+9uMVD/DOwgSAR1WH9+9MRHmqt5x8TRn4Qd4Rb
         EYEUj3WgO/XVLtoDt23GSie65m+pbE+vCeYcs4g9cNN9KWhfKVk4jUV1LPv21QgU3E1u
         AEAQ==
X-Gm-Message-State: AOJu0Yym4guZMR3paGhps22nC2UHdIT7mxoTF7RO7nO6yq8ttFzaZ1F9
	NQhxrMrJnidywkFDlNzifXtjQLUPOTSaOGEhldlQT0wjdK6u4drTk8//CaNcrBVmg7mX0Veg7cr
	+SQbUwo9OLA7Hme8sRAYimchdLDCZ/9vk2924BXokfi6JfUBbPt0lvTY=
X-Google-Smtp-Source: AGHT+IHIpUGbSagwrkccICYwt6Vy+nrFR64KqgZPGnisdqMC9JKa9Phma7evTBUN3PO/PjlwYVMsr0+wS4hFyQhlU3bW89KR2Dye
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:374:a2db:d6b0 with SMTP id
 e9e14a558f8ab-3761d6b8850mr2533865ab.2.1718868489356; Thu, 20 Jun 2024
 00:28:09 -0700 (PDT)
Date: Thu, 20 Jun 2024 00:28:09 -0700
In-Reply-To: <000000000000be1f530615efc5ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b95b19061b4d417a@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in sock_hash_delete_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e=
478cf26c556e4ab572ab0ab2306c986901dcd61
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

