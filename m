Return-Path: <linux-kernel+bounces-276869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98231949955
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330FCB25907
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473615FA92;
	Tue,  6 Aug 2024 20:42:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9D15E5A2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976952; cv=none; b=LSQI22uZ6zcIlTxP8pBesfihUlIjAeqEMtl0G+u0PNvkkxk30884XahT98sQ69d26Svj3pzJUesGj6zRhatfAiNUXJAFKCFbC1R6EqxF9HBzhNXA6H2xZUO4T2d49ZDtjYNDPXAxoDDWqfnVNLqKlEDX6GbUiwY9oaybGVOd/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976952; c=relaxed/simple;
	bh=jY5BSyz0WxKp3foQy0heEmwmOgRG1MujzFV7BIR9lGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z6cXR33MV7f+e7OoT2MRzB5kJW/7guRQa60ASs/nyins4RRdfvLpMEEce2f/4gX1IuAdtdaS5SGAzwKWd41Ly6FecH0oprTgD/BUIMiSyYl5zqJS3FAFSnnp0lK4JAk/ZYv2tTJkP6Iny4vNSTXL499GB6yIlmkrTmOxk/36MUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8edd731cso125008839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722976950; x=1723581750;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JX9QYjiWYjUgmKNDiSd4NlOfDvEN68gZgPgKnOqjx6k=;
        b=dXJ0EsyqvShriQk1m3P/RUHJcZb93kPuGPCzzU4JZvHtp3/eeIXPbDF6Pu8vmar9yo
         VXmhvEGUeyT87hkkAUhAWrOzUWaaZiV/FxJrUghqcsiXqEvNvG86GBrqJIyVwXL23j4Y
         P1ObMutdE57d0eYQcRu3HE8nGfKRa1FJwsKswPB6R2yjieH3gxIjPmFCKhL2uEGoCTxJ
         SmfKvxmZaZZGl12yTJjjmsL2dLat11tAi6qpIk6H9epqi4i4vnFjuR7TQ88w8HkuWoFc
         jqkb7iGFV2RgFGVayEabLFIEqg8eECEh6PECHQ220RqgWYyrcQUzlr649drtWYltWi/i
         3yNw==
X-Gm-Message-State: AOJu0Yzkb+x54lhwb10WafohdirsUaDRgvq/f+HeS6cbAmrqpC2cjA3B
	qx23S/zZbSoytbIFkUb+tZSzf15m3fWKpQg2MCxdN6mXwSfIGGpMfaUVhmlDrkzNF7YECpMNhXI
	RqkA56ax451cULQK1uhXlD9oAEJZ3RfRexqy5D+gNyXsRFnL9LhlalY0=
X-Google-Smtp-Source: AGHT+IGF4e/GFwfgWeNbCb2WIyMKO8ukObWNCcVcX0YSzht50pJko1r/BYAdWiL4CQZHgicxTTh86b3ncEZNutAdHBXRJVf+ogMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2486:b0:4c0:7f0f:b42e with SMTP id
 8926c6da1cb9f-4c8d55992aemr879272173.1.1722976950404; Tue, 06 Aug 2024
 13:42:30 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:42:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015d75e061f09d592@google.com>
Subject: [syzbot] Monthly trace report (Aug 2024)
From: syzbot <syzbot+listc4b13dec77030d708b1d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 987     Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 269     Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<3> 30      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 7       Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

