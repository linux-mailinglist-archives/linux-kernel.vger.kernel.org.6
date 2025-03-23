Return-Path: <linux-kernel+bounces-573008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC322A6D16D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158AD1895370
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F29B1C7007;
	Sun, 23 Mar 2025 22:24:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF003B1A4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742768668; cv=none; b=TimD3vTAIomqPM8vEHvCjsUUXJcflsrjevfx0xFg+OTXAs2wFKfzTdO65nk+2I2TZFXJ2nhikve6QPrVBdyEV78oZHTZiQ7MXST3PBhftXKLVIibwlOYI28XyjNsMWY6DF4CGbfDNbaTxz4o91bOkHB7+qrbp5QjqgppzRomb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742768668; c=relaxed/simple;
	bh=BEBfxi84Sx+LWiMfPgSqol8/dVxJ/6WfZFAZV5OkNrQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ieHvsWIIsX03YTXMK9wOzicNccpovSROGGt1fDOfatHNK/eD6d62rihdyOoMTkTh+EbmomCQeDe7JzbgtqImio+6XLYvt5483JYF45p2eIt23VPzZauEGxDkHbmkFMZx7787KxUAGjLiA+CP7afFKYg8lMSY0B1E0mlnFXxBcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a379bbf0so74144225ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742768666; x=1743373466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8SHUbNy7Bs1Yo8x58aYTf5+tCG6xrViHLpd6oKIB/g=;
        b=fQsybGE/EfDd7K8e1LgdsMAyqEXqcy5PRlRB4cADtusu7jiyv1HjxTLEwVJWg0E/Bo
         YnjjczPN60Hf27/VFH2Cn8KWE4rmg0CC0U7Z9KyUqVtLeOoAw9z2bgp9iBcq0RlIDmzF
         i10+hC1F4EBSvNtGQj/WAZE3Smv1uGy3NH0gi78M3zsiduUy7Ha4T8lfPKiXFAAW76Yf
         4NUWCYgnPQIRAguHVyQ0YDx0L/i6+XCwdNodVI05SL0gvg9MNlvCcuRaxDXaQL7edF9F
         ZrYwCGKfARPbxS8jogXsZFTuDlRUXCSufeHzxM0QS/Lby8gA+K38qek1LpF72A8sZu66
         q4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkyJMW1GW8di+VSLKOK8KvxLTuNZmb9zBAEuEtgBaatOTKYAqWKf2Am8eJXgdTdAws/wCmztVHuWs+wpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4qdU2mAHmWooi65tomfGu2T9TRvVLYcrgreQ9cF6TMz+OStw
	yRfhB2vztBBpkfHT6xR/2Vlg6AyNmdj9y0lYSqt1I+AOisgZREPWIjwSpmT6tJQ3PVPrp7dEMTN
	lU/RpUS7BhlxTJ7NPqFyDX1IBYeF698ymYdIkrhxLD47zJQJVeGEpMNo=
X-Google-Smtp-Source: AGHT+IEgk/+ut+LYjpCks0O3waQ8ZdvGtupC8gp6xuLrneppz6wBtvnkxpFJkf05t9LxA9VFwehOxxV6AhzrcIsTwOL87A0ojOCY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3d3:eeec:8a07 with SMTP id
 e9e14a558f8ab-3d59613e5f2mr122306025ab.6.1742768666459; Sun, 23 Mar 2025
 15:24:26 -0700 (PDT)
Date: Sun, 23 Mar 2025 15:24:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e08a1a.050a0220.a7ebc.0004.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Mar 2025)
From: syzbot <syzbot+list3422dac14361a02f01d5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 1 new issues were detected and 1 were fixed.
In total, 29 issues are still open and 282 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21440   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  2281    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<3>  2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<4>  242     Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<5>  178     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<6>  78      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<7>  68      No    INFO: rcu detected stall in sys_sendmmsg (7)
                   https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<8>  56      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
<9>  40      Yes   INFO: rcu detected stall in ip_list_rcv (6)
                   https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd
<10> 31      Yes   BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
                   https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

