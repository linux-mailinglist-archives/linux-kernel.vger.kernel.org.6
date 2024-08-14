Return-Path: <linux-kernel+bounces-287127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3597F952350
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF37286114
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662AE1C37BC;
	Wed, 14 Aug 2024 20:23:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637391C231A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666985; cv=none; b=qxBCBhlf9iXNogeoswONR2Mwh6B6wX8Svdlp5YuwiO3Gb1D2FxC2FLAjWhjJIaW/nnUgHQ3DowYkzS0aX4Gl9KKrzrFsksKLE/cgYrJdgEXtCBsgmIHpQuz5qq+hX//Gswe2YkR2YDnIkEweDmOMpo1b+Er+BdIXpIcQ/w9w/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666985; c=relaxed/simple;
	bh=MGDlONcXKhSozFTsULFH5GyIecLMHxcjF32/Nnl/k1g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DSA2kq4SxZbQCK4nzPKYcPiFcXIFauflzZWkwjmYhVJi/AZqch8ORChGxb/EnBbWFYoExglvsvYvNjGkGkCygweHDk+2ZWkKhyI0oDRdBL9WmU/Gn6fzsz4RyYGY7BbtuqborznQIf2kbMkSeH1d+SDEQwrtP2NJMukOvRxGc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so35155739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666982; x=1724271782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e64/Ut0L2RF1DN971v6iI4mW+u5OXTu1IndUbpvD57Q=;
        b=ZRMWw/U9ZEDbgsWGMJbxJnC0LpLJkAj25ZiDBy31N4GEDWPTPAJZN405l5VkZUzDLq
         dRj6nAxvqreQHYS8Ug66x2sWOPwYWdN2WfBpV7RP5ik5iD1OWt+CHydTiVGuE/8ezbGQ
         9GVhYdjO4hEWKTfkIy3nK0KlwNXpdUlqSxC6bmZ0MSBJFw0iX+SntvOTGaBT8Ag+3bQA
         pRV1udUCIuvBVHw+SmlsxvPntWILmzXmPXQDB4WoumlMQjNrqEOnG/XybqXbcKy/0WzY
         WHbE4loj4fvUDrCnuRJMpO7Vxm/90UXf7kgZyewj9pgjr82GZm1rs+8ASPQ7oLhxwhEy
         lAcg==
X-Forwarded-Encrypted: i=1; AJvYcCWerR0FSGG6zkm/w4JFJYnAcYD7waqXZTuSfg/6dy40YTPs+aGMj+PPhFgQHEnt/dNuDLsoRWs2asvrODBKlf1W9Qu01E32wbfdoirL
X-Gm-Message-State: AOJu0Yx/hcLFnpklyoO1Fu0wPL4wCaIvCHezri9ZaWz2SYtqGVYN9qZf
	OlHlZRrwSGX/ANrEeF9+6VLiMkZ8vL6QKlCZgRNb62zN/qvLeGNrI5jbr6YaxZeRs+n6pKgHWJr
	h//NQWAneXib+KvjJfCNn18ps5c4m6qNCEuEAGysTzHNhklzzssdY5Z8=
X-Google-Smtp-Source: AGHT+IG2OD4Nb7gUpHZwhLIfrvP7x+ELA70mgM1S1ILQ9jsadGN/cWH84omc4QMsYssNskdTfUupVT/SIEQYCiclVUCtHFKgp/X5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4112:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4cab0537772mr188508173.0.1723666982519; Wed, 14 Aug 2024
 13:23:02 -0700 (PDT)
Date: Wed, 14 Aug 2024 13:23:02 -0700
In-Reply-To: <20240814185918.93407-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000345776061faa7edd@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_ioc_start_atomic_write
From: syzbot <syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
Tested-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com

Tested on:

commit:         320eb81d Add linux-next specific files for 20240814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10d4f2a3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13821a05980000

Note: testing is done by a robot and is best-effort only.

