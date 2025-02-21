Return-Path: <linux-kernel+bounces-525019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7743EA3E9E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13651893F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BBA45009;
	Fri, 21 Feb 2025 01:24:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56C38F9C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101044; cv=none; b=RfQzI1EBCjp953vh24Y5QcNQWQU+YDDr2qBrfCyLyjr/CW4qovDHcFlaKmXkRQk08IqMyo5ttpDKnytJXyi3ifbTTEFqWMXRvntOjg4AnLvfBpMACwuYPQ+7pjmfZekJ0g0VJem7shuSDK5B7brw4dwDkJVoShHcS9CrL8ls+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101044; c=relaxed/simple;
	bh=jrQ52m6JpwsbYtQI1WnLDlD3pHj4DazqYNJrkEIlhV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wa2E5pCCkJk4NGE/HM5/vcjq5s9gKMQUWAHjH+05qZRxDG7JnI0ZBIyeucyDqx1J+fUNiHkSmtKNEBDZ0ynk98EqYV6sqZ/DQLrdaGqF14BuvDO2w5loqgWh8WlEQNxeA3S9RBOAWH1CV2PuL5Y1kLyEHc8vRBXivsR3GkqM3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so28813795ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101042; x=1740705842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHxH46aXVtdrh222WoOA4E4C774aWwB24NtlR/Rj10M=;
        b=c6xrpI0zM0e40KvPi5DcFq6psQfh1wPIyKF4eRJMCQ9bmbhHr5THAFh3UedRTBvoC0
         gry0YqiooOCx3ctNp1keXwLflJtxSm6rvoTTrFTObOafWcLeldOn+EjafWjJOTLb20jG
         k20gAu8do7P8P0M0EnrXnmHPIP1t9hA/EB/bu8NLGzZeTo+XgEzvkeulzFTwNFc8Sw1U
         nMPvH15yJyWyTUuO6keb2C5/XJQQ2PC9fGj88bxlB1uCT4OnfJMssZO0UJW/cADrG5JS
         uOhIMUl20MebOAsUreY05Ld1lD2P5wJ7oVgH6UpePrz0D+bxAxq6elaHe9hdflPDNdsq
         dPHg==
X-Gm-Message-State: AOJu0Yz+vx4+ZA817u0QCYjCBfLNJjdbqII6u5EqRkgGsCUy03Q0Njpw
	oqLMoGLC4MDglTlvZTy85xtmtmiPUcq2l4jjqFmZmNgMcV1+qC35/EpJj0e+IOricmHxokFQuRl
	X7tyIPa11o0lR6uZU3WDkmGUa1ocZVgqjv7aSg1MM0dakMzzs64+YMWg=
X-Google-Smtp-Source: AGHT+IFUMCn8xRYDePI0G2i+6SY7sQsK3CEzcx82Dxum47Bw6btWjbz4I1SY2F7Llr435rZ8w1akPJ7ikNJBPKa7kTaBqieM2fYG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3cf:c773:6992 with SMTP id
 e9e14a558f8ab-3d2cae87c65mr15728435ab.12.1740101042436; Thu, 20 Feb 2025
 17:24:02 -0800 (PST)
Date: Thu, 20 Feb 2025 17:24:02 -0800
In-Reply-To: <20250221010023.1766355-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7d5b2.050a0220.14d86d.0304.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_close
From: syzbot <syzbot+9c957444e37d521b3b94@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

<stdin>:4:15: error: use of undeclared identifier '__ref_stack_chk_guard'


Tested on:

commit:         50a0c754 Add linux-next specific files for 20250220
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=9c957444e37d521b3b94
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162567f8580000


