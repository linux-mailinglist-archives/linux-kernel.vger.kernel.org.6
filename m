Return-Path: <linux-kernel+bounces-544622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B966BA4E324
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B55317F8D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96C27C17C;
	Tue,  4 Mar 2025 15:15:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99225EFB7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101323; cv=none; b=rkzm89+7+7JlQYNwlYCSz447CjifRp98PDGBxT/XrgL39pM2+uw/IEQkE98aOKsIHCibryICx/JfbLkPu8f46bEEqadEhjoHhElLSm9uo0ciYDa6j4uPBpk8/fUGd37J7Gkkzjf2rSdmP+9GSqNVtNnIf+EkaGjF0Nb2+T5Jvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101323; c=relaxed/simple;
	bh=mcLZWbvX4OASqJ6TP4DsOuccHhHsTxZE1ZtN7Iwta84=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EIoKiAYAqJs1HhuVSiGLEl+Bf/n7DJuQ6htp31LdMqutGm7YnAcbRXRSfS5pVXfAUq4zIkF3RUiSyddvt3CUxA9EGULsNvNpTtBarhrY496s8+tFOx6qs1IRZRlnLUwy5/F6Pdp4HnNHzBrS/51yzBIsRZS6/MQp21hBaEG0syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso134301755ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101320; x=1741706120;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCSESAKsiqQ+IFJbEFJWlyCbShr8mBIqRgAxgCfBLE8=;
        b=M0Z8OBRbzR8nJ7ngN/gsEYGULLky29NPwTfL3VoiUg6lftkwKC6UhYXyDVJrfmO+PE
         HXcNW7K6KW1HFRVGiTxQEEPLczTpAxussWOfqbtwRyG7McS4pf+QAhJZTVfqXxCbNdFc
         iaBVJ4LfPPUAV9iEB62ZLn4OW/iIB4rvQzqklnNKEJAxcYSHA0zQ9CbU2BqZIaU1atJx
         ZD6cOvkt0q2iP0KOHffIUQgCIxC+bGOVJapsrpINKJUaCEKENXDAHQNyNn0zKwD4/5J0
         8q6HCFe0UJNU0GQK1iXcQUILyeh9xRzsHVwCsddoUgUvuKHn01juXbzLgo0epuGNSxEp
         8rbw==
X-Forwarded-Encrypted: i=1; AJvYcCXflm+//WIqIH7t3ZfW9sw/PaOpPNhCOaKyNNsm3Yj990Tz+lN9Qb8K9fuIx9jqkhKanTHtucUtn5upLVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgBS1YLc+9eofNBjN/hU1eyU1wVkCejFiiDDKoC0AcNuNq8sb
	LGdJHWFs2avo04f2JgiL7yn8qeeitQYowlWQ5mwTHZFdtx36wh6Co3kIcx6GsIySO1+D9PzprXT
	Z9bmPzMHK3YgfMMk67t78qUWuWPGOxhbfgp2gguH725II4bOl1iqNOVg=
X-Google-Smtp-Source: AGHT+IFPSuVdOkDMWbPlHI6z489JojogoUgQt+6oFcvH+IjYcYZ03ZG8x9ZGyJ2qGUlEY8tpl46mn69MJBTzEUuNU9ZXyrhahC6B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca06:0:b0:3d3:d8d2:2900 with SMTP id
 e9e14a558f8ab-3d3e6d78964mr168396415ab.0.1741101320684; Tue, 04 Mar 2025
 07:15:20 -0800 (PST)
Date: Tue, 04 Mar 2025 07:15:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c71908.050a0220.15b4b9.0010.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Mar 2025)
From: syzbot <syzbot+list1809e16a6bbc3c9e72b9@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 340     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 275     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 45      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 42      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

