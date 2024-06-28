Return-Path: <linux-kernel+bounces-233701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EF091BBB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1C81F21F41
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213D154C0F;
	Fri, 28 Jun 2024 09:41:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9F154434
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567692; cv=none; b=C29OKtNBXFSbJqEC/BCARs5bfedB6BgeJfAQW/ZvXeANAQVCVEpIm9z4rHgXFazMj9JpUX2w9Fvp+4yJowjyZmG733EeGFdn9owfxKmsHIEt2puvnnmQrcy72Puz11Mce5cdsoQEs6kLfbbLvmO72Dpq0vNDEGNOor1aQ0+5bQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567692; c=relaxed/simple;
	bh=yO1zDuylT5rWn8ha52gqFPnR9QISsetCVs+zALr5qXc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GUCaYcWXusHAK7Asq4TFciQyk7AjkwrNudSscVnF1bqyFmwPkkPhD0QYpyitB7c2+KXgnurwK3kh/uWtBaLLcC04wN7O+QiRF6kc0eDAhuhSSbU4wI1UimJM/lezkj4Mtks82dnNJzoHm5itDhW9pRI2bCYGwgArxnXw4cOt1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375c390cedeso6075455ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567690; x=1720172490;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NGXqmOLebbDJIT9oTfJXpzUo10RZPHybUkmo2OlM2I=;
        b=tysAiDMCj155/Z5pDUKb55Fk3zMkVbmL9wO60gWjdOz0+tovyBKp5UqlLES1Ffw4t1
         xs9FKYqdRT1cJ93vthsItDpVLk2qb0BAvz87AhPz0Dq5JVMfDv8kzt0SDrqKEp92mJCe
         rJ0HTXFk/W3zhkLCs22BGfWwlqvSkZYObYtlwN1tMQ+9oRj9kzTNj78mXK+Pnuu4S5Nt
         ydKcu/O9flnZSuJEId8aY14JouOvHq4F1pb2fXBrI2slEXdnjWFYbK7MxnpFjdHNDL3o
         QfpnE467b7Ep+00zxXesfmsiTWV7R0BnGNoGDRbt0ogEkujdOQtecVqRuHeO8t8UGRMN
         wAnw==
X-Forwarded-Encrypted: i=1; AJvYcCVppCPQPundgw0rYcs8sIO8zDfg36YWaZc9oQw+9dsgh6JHrqfFffZeJFxmNTOM+X2ex1r0pADCyUmqSaHNYF4eGNiXwHfq6nITZ/le
X-Gm-Message-State: AOJu0Yx9o/RoxMCM0OjSF/BbK675cKcSgao28Ir4zwCBVirCK+7uuPqt
	PJYpftCXqlRzrtGpOGWlHcAUaEROafjDUkQSbMvgoVb3YiAzwgBwHVzH82bHDMEAw616s8pTZjw
	rFnWvobLvq4hMFOkOaoe7dgaAegkzZ8zjNXmf1FhQ2yUUKzyQLUH09gE=
X-Google-Smtp-Source: AGHT+IHdeejDSZhAn30k4xm25I7eJXA/fLrw4Z805HzDM+y1JExIYlj7qBs9T/+DDEHvSmAW9/2RfvbhaoB5y9fsWKiWHQ6WzfeT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:375:a50d:7f2d with SMTP id
 e9e14a558f8ab-3763f5c9fc5mr15563345ab.1.1719567689830; Fri, 28 Jun 2024
 02:41:29 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:41:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051e313061bf00dcb@google.com>
Subject: [syzbot] Monthly io-uring report (Jun 2024)
From: syzbot <syzbot+list9762eac493f50a993bbb@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello io-uring maintainers/developers,

This is a 31-day syzbot report for the io-uring subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/io-uring

During the period, 3 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 94 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3582    Yes   general protection fault in try_to_wake_up (2)
                  https://syzkaller.appspot.com/bug?extid=b4a81dc8727e513f364d
<2> 16      Yes   KMSAN: uninit-value in io_req_cqe_overflow (3)
                  https://syzkaller.appspot.com/bug?extid=e6616d0dc8ded5dc56d6
<3> 2       No    KCSAN: data-race in io_worker_handle_work / io_wq_worker_cancel (3)
                  https://syzkaller.appspot.com/bug?extid=90b0e38244e035ec327c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

