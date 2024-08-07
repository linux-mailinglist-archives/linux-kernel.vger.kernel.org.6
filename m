Return-Path: <linux-kernel+bounces-277158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3C949D55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F282838F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075725622;
	Wed,  7 Aug 2024 01:22:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BCC8E0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993726; cv=none; b=NnmlGMnHpzV8J6dSQI3p7f8MSQPnLfj8i6pvGVo3kzIS4SwyvXZg3eO53Lh1RDeVN0CJrVIx0mfUXlB8o4DT7YXP+cdMu1nUYZr+NEhvL6+JCjVZwUy4pQX3ItzbiMRFVwXdAzjP8vVQttzLBD7qXEVkM3kfcXrK/BpqSR13lGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993726; c=relaxed/simple;
	bh=lNQmyI3szFaQOfmQtO0YuI3h4GOrATDpsdyHPYzq1iY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a+JonycTXfsWzw+TnapYUTQDG9TJVDXn1VLijpOyHauQWUCIVj2jclI+PHLNcqlVtlBDHlVWwlOPpcBNBple1m35Whly3TPu2CVclRgh6lXk0fNrd+i7F+Vkwfe/dvJsoi7XTpCMbBOJtm4t76T7ngFc/3puyaVmR8lIjnKp5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f99189f5fso180598339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722993724; x=1723598524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqkjxPdbFznXGXTnCeFHcKTFCWkzVKxwzRGAlqKPb18=;
        b=dbCrzcpf9GTUhsVj7trAwLkmNR/Qg1J2Oc0ednEmL+dmdaZm1qTTTKfVhiNF0vwn7Z
         G/2OVQfQ9vWa6nFzk/QCOSD1VyIeVbsagwsJrz9pj/bFxeVEPMYC7IZPtWtE1oxekr+m
         SejDrjkvlPbfQYGP7N8vkoVC0zQ/7qGCdgTeZEToZchFOmypJuvNZQfV94cgyHhdBvTo
         GJOY6etkAYAHihv5TWGx8fGNAIKOoeSu8qdlRBa4Nhj0EYS0gJT1gc21u5RifiluWJvu
         +knYeeaAskE7J10LjDTOrmJjbBxwiuV+vJomIQDxVww+MyojexgZJdg9TwIrYAiM6d3Y
         02bA==
X-Forwarded-Encrypted: i=1; AJvYcCVWCSjUNQjpO4XdYpObsBK1yJm12vrocpqYAbZ5dFxcNQ93Bg3NSViLekdi8DT7uklViclkfa6ZuVl6gNpIT/a0g+2PwfjAhuTIeoeJ
X-Gm-Message-State: AOJu0Yy47tjLQbkx/0iQNs9F6knLP90/VxbD74zIWpBxkd226S6cq0fT
	UDvj6cPVW75F4Xl0vZ0c575T2NKJ8utgZcdSLIdD36598m9P5vExcCEfrDP1OwWDpPuA4SFHjEd
	cnnWS9U1mZePDTrM/wfb08rD4LE1/jMXK8iy0cklDNsiQQLt8ZTKDUJA=
X-Google-Smtp-Source: AGHT+IEyc3ELMgf/Nq3156UOnN5FSmHIoGVjFTmZoYObQsZ/cuYMVtxhpBMjLc09fM6tYo0WE5//tH0ClyU601+C12ZYHtgPRlge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39b1fc7d74cmr14208155ab.6.1722993724042; Tue, 06 Aug 2024
 18:22:04 -0700 (PDT)
Date: Tue, 06 Aug 2024 18:22:04 -0700
In-Reply-To: <tencent_1DA5E7E446CB52E4066CC9B82EC96EF38C06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df4c76061f0dbc17@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com

Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=136c665d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133521c9980000

Note: testing is done by a robot and is best-effort only.

