Return-Path: <linux-kernel+bounces-429097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5A9E1755
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B8D285D06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F161DFD84;
	Tue,  3 Dec 2024 09:24:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC81DF99B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217846; cv=none; b=FUUYqlNHYa4Lk2vBsPVeJ/V7ZWW+P2sLP+OSF2ynteIMnCBkOzgE4F3m2/N3gJpucDSarLskEscZ52zmF1G95u1V5+RoCd5KBFtRGUuoReSo+Zss+nfWD4EcCUJs5YSGYzuHPDYTHwUXNhCq95AVrFxJC+9dhSOLyTIBEd259mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217846; c=relaxed/simple;
	bh=U5gFM0P7/my7RfZwV4TtPACCBwlaO6G1/uLoM//Tktk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SucmHMYswGUilpvmbQDBWMtraXAHygpoRwyBVN4J3rXULrZWEyJTniuQxFyc3wTRgFXr/D54kiE2R25JWgO+9fgMvp3eJR1bXz8Of+JcptjvDjWjPTSbm85ve3h/9dM0+OO3GN+YreBI+CItLl2L35X0Wbjoyu8cyDCu5qAWOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841ca214adaso484857139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217843; x=1733822643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0fPxjWxKndEQxqliEaE7vT7Iz9iAgeM0MtsLI7IS0A=;
        b=rPnoHT8Fnz/LqvZsP/2PqIRod8+SHJOHMzNzWM+yAMDZ+5GazACMAdpm69Rk/M01hI
         w2t1T3SOlQUwezzST+uHTO9B3oiIaD555TpVqz3B9zhfijxXjlUozAFRx3zJcax/d6QV
         R2FOAM06VvIn0WjQsPJqX8XTRo+IIj4JVIXF33scASmnW8wF3kjBa1y68jq5egPwFvf8
         hty+HDnvEionI3pOkUiSFNTb2rLVNc4+soXfHhGEK78yg7kBXFTKZPTIiTxdvHOXLYqY
         5cYjDxVeiBKlYQHMrHhneb6kz7OAQUzZOnfgq9lw5BSioY3RjP5nupFXAMncMfykQm0D
         FtEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjyuDMhHdbqdI32OkpDtlVttlENT3SpOQ1ccPxhrXSN2TPSk9Ylgv9SnPeVlFqhy+WY3GJ0MmlEEr30yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFBwVnubfhrZO4XXdTb+P9Z8yu7JMOo3NiL4Cd2oJxTutnpON
	Li1o8gXUXVy1a0uaOPIJ/uKg3gz+eB510D/NWLITsIIn46iGgvlv1noYC8NqEB+eF1i0nvmujGI
	/2K6YjJ78ccD9WiYyRKiBgBihHFr32looOOUdy7wUhFc9AytOIovoAgo=
X-Google-Smtp-Source: AGHT+IHYBbTeEEbam2y1aOV+eOTFTYcg+EuaNTi8l8MTlakoTXmep7lCVZWycMrq10xHZ91ilnxWzUqPMmomyWWPb754QxPRph19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a66:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3a7f9a324d5mr23657275ab.1.1733217843406; Tue, 03 Dec 2024
 01:24:03 -0800 (PST)
Date: Tue, 03 Dec 2024 01:24:03 -0800
In-Reply-To: <tencent_71D0A5DA0DCD1219DDA35DBD9936CF948D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ece33.050a0220.48a03.0030.GAE@google.com>
Subject: Re: [syzbot] [jfs?] divide error in dbAllocAG
From: syzbot <syzbot+7c808908291a569281a9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com

Tested on:

commit:         a4326560 jfs: check agwidth and agheight when dbmount
git tree:       https://github.com/ea1davis/linux jfs/syzv2
console output: https://syzkaller.appspot.com/x/log.txt?x=113740f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18d90fa8ec96d8b0
dashboard link: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

