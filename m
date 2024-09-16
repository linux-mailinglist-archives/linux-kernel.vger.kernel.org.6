Return-Path: <linux-kernel+bounces-330653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D897A252
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA4CB22574
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC32156F21;
	Mon, 16 Sep 2024 12:28:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA58156C40
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489712; cv=none; b=PwkAFe2TQAKX95nQmADk/9zdKUf5DzDQVZowWx7di9SgxR/xU8uCX50BshiWhYWxhXhTTZJ+IM3e+5nAht/JuuIwujtqSQYoW+MMxzLb3vn8L9Gz4p1e1YOvpsWrp2vemvTQL7ZpkKg5PeZo2szgoJvFo2mhIso0oukReMJ2KY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489712; c=relaxed/simple;
	bh=N6/wv7GidHUJiNRQA1UFPw6IYciiC30WmotMokzlOR4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VeXyBU1RFApagsuSfhghkT8mj66BHLzaryRVQfByQIr1OeEj9q4r97fyg6H6TnM40oLh9eluD7ojltmpMcmp1uxRu7vAUd+LaBH50rA7Bi9c6TSsogfo4bt3hwvERent9zxSybvnm2hQ4b3qL/TcjE52U3N9CZEeoUxXhHojQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a08d90c938so67623695ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489710; x=1727094510;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylofmztIO6ncylNsOsc0kBBnxWRBGIttzbU9VVZ/d6I=;
        b=lnS9S2bRhVYv+RXCnMwN/fCvZOhm646UgQ9agDTtFAgEhdj7J2jL2BYVVJseePqV6+
         V2mFiNhDPTkxgzVJUUNaj4F0yCKgNZjI5FxsJJLLnZE695LPjlC1BqJHd+eD7RB7ubf9
         Gx46H16sxlW0FA+9gyBXlfmYNRH9JmpsW1zD1N3QLDcgJ4zg0rojvHi4hPaToXd3m95u
         M+KZeRl20R8awoxe7coSwxg7N0ciWj6UX/z7egOQ4b27v+oGlUItf2Jkpe2MY8bywJ7B
         3jooOSVclhzZKnDmuodQtFauNxHBnq0gpgGpsWdy8wxN03jixlPYX4hy7ohcU7B4mcJ4
         BAwg==
X-Forwarded-Encrypted: i=1; AJvYcCWIRQADypMfAhgOC1z68rq21Up9tk2frBV2IbO/lLKGVunyJN5agpIkVCdrbHHOWRVL01VrzBnlSJhavdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMHlvHnMccQjad1denrgWF5WrfjaYvlFt/RSehsTlsYW8NGKJe
	HO7bTux2rAp/afJgYQzxZEr8ze4fnO5dymATgbHoFCKMW7DB6Xls0Klox9+fYqUrlp23NEm19A0
	jcVv4OiK3hTr/Wjj4O0iMLCmmWhPNhzty+iXlyffbLD+ehnfiVMveIYI=
X-Google-Smtp-Source: AGHT+IFbERDi9/K27TPzljL8tAVhFoo3/YSmBJxaurmpLtwQMRcIielSy8gg4WJy4hNNMNwYtmy0nnhx+rXfQ0XVw/DyJ/VNLZAe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:3a0:ab86:928f with SMTP id
 e9e14a558f8ab-3a0ab86a5b8mr5844435ab.26.1726489709857; Mon, 16 Sep 2024
 05:28:29 -0700 (PDT)
Date: Mon, 16 Sep 2024 05:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd62ea06223bb5e1@google.com>
Subject: [syzbot] Monthly udf report (Sep 2024)
From: syzbot <syzbot+listf4f31286193af881ad4e@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 30 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4864    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 3249    Yes   WARNING in drop_nlink (2)
                  https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<3> 388     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<4> 29      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<5> 3       Yes   KASAN: use-after-free Read in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

