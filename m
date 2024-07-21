Return-Path: <linux-kernel+bounces-258245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CFE938573
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07771C20B6D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C4168488;
	Sun, 21 Jul 2024 16:10:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD8944E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721578204; cv=none; b=SZvGljbWoxO0psviJjHT9MIbygwyjia/1ch6kIVdfcHC+MK80FQClzb0pqEQHmkjcJ1K0dHxE3wpMqO9QLjflXYiJiM77emlfL457NJpHqESXiZvTNmHKSjMPcAhHkPuUkdKfPYaGMhMqX/0kH3e4mdoH5OsTJMUWCvFqgIPSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721578204; c=relaxed/simple;
	bh=B8Ue0v0mmr0GDDE7tv7KtbnpwheEIzOE3tyxtc5UxRw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pl7rK08m+I/AGF7DxVdrlCkaCAu5Ccqfm3ctALZGgRfhJ/OZaJTJshTFDAtmWK0cCVDNPAzAhOOYkF6As2vMBQMRz3gUns50P6J7E5Aqs/IyL1jiRkxddjS3HXB20Ef+zOH+Qm9MD8o4BtvEtu1VOBlR4TO7osk8arQ62vFO6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3962d4671c7so58696065ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721578202; x=1722183002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIw3IWCpVZIdtIqZ5qjnD2b9aCPKeWYWvOenOdwEm9I=;
        b=jvfc39lX82kSQP22iGJYnojdwvFSmb1fvYlFixZnHAvfDjQWnFN0pgGJT4GRuXugxQ
         4iBY82mjBMBOn4u28iBsA5LId2aUhDUgOlkXPA2NhNn/FPlIRkdGMTIYqq3qyRxbyYiW
         19T1B713jsLgZkegquAHn0/Jd59ZwdjFIgo3+dwZ5L8ph26CYW7rC9b+xICK6FyeRaHw
         baq/xyBoJrKkCees59yjVuuwc5djraCPczs7Dbmyxb+2s4KsOT9BLQ81rmto2PvTpHl5
         FwKauOxftdhfH1HDaPEhd1uWtLWqqoW3cUVmTMXgmvB2XP80VuwnxXIdDGpCV3Ah1/FU
         1WWg==
X-Forwarded-Encrypted: i=1; AJvYcCUY50WbUnEsfaZbuJ9WlH9ITqEWcOTaJyPBjMIcNMTv/3wDTLUQOzIgktNzTEdvBFJrdvNLMBR5tbZRPjZwZMe/geQK7ZUpTLDiVWil
X-Gm-Message-State: AOJu0YyXCDceY7ZrQd79RrIFYG1nI9q7HU8zgr0YCMlj7eiYwhc3w8A2
	YH/YQrb1BO9WJRWTKkc3UPBW0Iq+nemwnT9pcOgS1M7gaSx9nISiSIM0g3Pjgtz0oEvOnGgXTA2
	BEgUbEVMqym+SP/8a6e3vS7TOsTNtfUw/21NRxJmyOysEZ+YN672LyP8=
X-Google-Smtp-Source: AGHT+IGVCfSgPQJfm3Xsw3nreXjHt1241tKocKjpOsb4P7nuX08cSPNsr89p6nHW/v6sRH91Iquv63EqBTScG4+gknNLfffmPkwu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3044:b0:4c0:896c:515d with SMTP id
 8926c6da1cb9f-4c23ff47b09mr394761173.5.1721578202171; Sun, 21 Jul 2024
 09:10:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:10:02 -0700
In-Reply-To: <20240721154738.269841-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031985d061dc42930@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/upstream: failed to run ["git" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "upstream"]: exit status 128
fatal: couldn't find remote ref upstream



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ca6cd6f392cb76
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fef15e980000


