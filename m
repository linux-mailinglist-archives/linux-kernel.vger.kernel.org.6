Return-Path: <linux-kernel+bounces-261098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E993B2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A08281EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7815957E;
	Wed, 24 Jul 2024 14:38:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057681581F8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831886; cv=none; b=NG2k8xp2LQSrLS0ocurCLFe49yuhZ92LDTzt0Je+Pidxmk1+Dduzvd8eY0cK/spidHShBeZXA5cIuc4vngEqmyNN6Y4Hpj+BKbv9YLqGrF5PPZ186qkPECTxdCpEHxVKK5DnCQMEdamP/Il3X1F6u3/q/5OGkU4dc/aqU6NdJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831886; c=relaxed/simple;
	bh=VSzUN+7of4GRcQovlCWWbxPAubkyRLqf6Z1vDSDsgCQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b9UibF5EBKxGKjgpFPB/UwfK31FBUrAEUyia74StuXzpgtz0NvMFEgJgDC8jgHaJPOGiDfU8tUlCsGHVes8CD2N6yOu8mM+Qzmq/1jdV9scIlExaJaTuemQlSgpfFuLAmouroLsPW8z6yCXfZ7AyhxaG2iohyU9AgBi09mO8XV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39835205d20so94571605ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831884; x=1722436684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChCVNVmIACxTTFq+mC/JHK8ic/0GbWjXuhUHRRKJw5k=;
        b=dNlbSbc2EcVMpOY3zOii00GiKExgIGNZKV372qZxYPPAjWYHA/isrs4NjmefWEQXc5
         9k5ADFIwq9d2fiCsOL9t3I/hQX7b0MUyzh/ZVBgN3pohsinornEdDTeXxliR7IRnDmcc
         h20eA/l2Y1gZKSTpDdKYzg5U5e6273X2InSIH2WLYBS9mkuksdlNhmbVrIw7lHpQpo18
         Sa7X+wp8I2nk9p6KNLPO2W0Yy6g/dX9mxJUDq8km9ojy7anjijjzsO8Ia8fiqJCe7jNJ
         FeN4sL8vkq6SctBXpUg2e+wW8RSw7+3ukpEr7bEVc4kjuGB2PKmWWma+iDbSN/Bu1NZe
         qS6g==
X-Forwarded-Encrypted: i=1; AJvYcCXi2i3DhkoXwZh65WYIfass5jC50BdXak648Nbt/LwBtZWt9Gwo0HKfthWVlSkXAIlUEmVXQfNHoZTme7IXNmYtuWwhPS8Fyz7jqt6J
X-Gm-Message-State: AOJu0Yz2+mA3GPdZHvkwojt2pjjPBcq9H8BL3U5cEDYobrtuOJPEQI1s
	OTakuIwPdCoJFiF+2bsUQ7xjwQpamyJolN0Mi7+TbYKX+9D/yPt3mCxavkVRIATbGV0/xadxCUy
	ZI2m64j6kz/74q5rm/QfE2C/rrqt4P5O4KutaaZbItU+x8PJQkz7kDSw=
X-Google-Smtp-Source: AGHT+IHi69WQbtqh16a6xzw8BoxzZyB0CbcC3G9iR5j5cxsRCrUOCs+bFvLYnC0JbTSqNlChsGQpqQmtitL1eKucuPh8bjdM3T8B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:396:a820:a62d with SMTP id
 e9e14a558f8ab-39a16dcaa11mr3510075ab.6.1721831884223; Wed, 24 Jul 2024
 07:38:04 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:38:04 -0700
In-Reply-To: <20240724141325.10569-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d283a5061dff399c@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
Tested-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com

Tested on:

commit:         786c8248 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146f5203980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47beaba1a1054668
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122626e6980000

Note: testing is done by a robot and is best-effort only.

