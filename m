Return-Path: <linux-kernel+bounces-198230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF748D754E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2599A1F20EDF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE103A1CA;
	Sun,  2 Jun 2024 12:24:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D638DF2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331045; cv=none; b=iN1kot/qieBwqYLLszzNYxfw9IqKinPlSGNRERgSC3MTGjquWaWkPNb8tar0wFZXJ0Qj1/xDDR1TS8Vv4cbZ/6a9RRYQy10S0ExXweIyCt8xAeigYMY8YaiRE4tJE77tvclJtfdYs4njcyCFVcvOfy3H1J/tXh8X2UEfdOqXM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331045; c=relaxed/simple;
	bh=EesLtMAhLrcIWzxdZAlO5jwMAuoDubF0qqE5OkVGy9o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vbc0hG/k5AEkJEy14ibmSAOET5TJt+Ir4tGGDM9BFrutMTZdpGSetrYz92nnhW7LttrHQvLte33qRrhwSlfYNfUj3n92H5Wzg8HEFehDSb+U8mezvUxqM31O+YXIpi063VwmzTDqrI4tnfUUG7febIb1K9C18OCFmELWJBU9BJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3748bce476fso23153945ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 05:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717331043; x=1717935843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/bgrlAK6+pmuhk09u3abLby214Hev3WEfSamPUksFk=;
        b=Pn+7GXiPnrNo1YjFly+fImnRmaMX292guqeYc6eVhjSmOOMNKJP36udPiPhwenc5YL
         UEe4NiO56rBgzvbEbD+N+E9ND2hCaEX9Srbzw2yhJlzmLMtMTjvZWGktLQegTbFVJnJb
         1qLssjXSCMvOgc7VmrwKPMB+C2yvUh4Ns5Asx1t+4dyKovVo1CDUUN87hTMMgCqS7OmR
         3e0pF7yFNyChhGbnDL2JcTn77xXdTnYGhGEJu6YRBvaXMQuLGMACiEt4Y+p8Mcu4YbvJ
         DGxDlXhisq6iO07ijOnKDWM3WJkYaSgM8AMFmLxcU/Kpun2FsWJDasOaQtVm1QqyaNRD
         647A==
X-Forwarded-Encrypted: i=1; AJvYcCXCw4EC8Rb8W8JSY9vaDqTE1o3sr53DtILUoajFUE2XV9icBU+VkuydqlI2Mz8zDOICTKR4mzmw3ly9Dj1DyEE4pE12InH6xwVb8cT2
X-Gm-Message-State: AOJu0YyRAzGHy7ylLXeP763Q/0aYvqWfaGvq7ygRvV65ftDYas2/132q
	Mw8FvyX4r5ENaV4CZ82WjXvZX1YlamoSseFOWvZQJ5RC0bARo9qSuNtkoj7X239K1vdESy+/LZo
	vO0oCQC3zXcg/3Mue2NuICF/atO+/ujuvToDBt5e3kN6Y/4i2XPuE7F0=
X-Google-Smtp-Source: AGHT+IG3DkmM2kHZdmO3T3fYnBgXQE8fyrMzvrMvByA1bGl058YUrInEdtRACnZ3QDaYa94CdYeXzX8NDwHiU8sIjbuwF1HblssS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e2:b0:374:5d81:9136 with SMTP id
 e9e14a558f8ab-3748b8f2daamr4884135ab.0.1717331043570; Sun, 02 Jun 2024
 05:24:03 -0700 (PDT)
Date: Sun, 02 Jun 2024 05:24:03 -0700
In-Reply-To: <20240602114905.1462-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0687c0619e74aed@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
From: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com

Tested on:

commit:         0e1980c4 Add linux-next specific files for 20240531
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=109d8d64980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=848062ba19c8782ca5c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1662e9c2980000

Note: testing is done by a robot and is best-effort only.

