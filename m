Return-Path: <linux-kernel+bounces-304134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C04961AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1827828388A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26911D47C4;
	Tue, 27 Aug 2024 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="TAQ8TDQH";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kUfLFSMX"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051901D47B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802565; cv=none; b=JUkd9WskfVu0U4FBjOsROb2D+NWeCyQUKvyGlXVVVzWPrJ+Ao7p8N0BEnyg5sYNtTqJY/kU2ijuU/fR4999vNCsLjY+Zy05xR5i5kI95c1qZgoOMhYU8OXxoqMVsv8Oz5JN80ZACeoIi7G12bYkqng3dHqUaDCYfS6e76n1RA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802565; c=relaxed/simple;
	bh=Oa/q/B7QC9shO/oS8EXiewx53fGXKpzhCJSJ6R64P3I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lHm/OuZQhapgOU2N2wjWdbcYApxwYfbXRqVhwJzMQ7TW/VNJX8XjEFe7EK3oXE3lIv9DDGpeTZuV/2E5uCpybRRjSHl5OUWVvH6XJh68RKPDSUn+cOZWDM/zH8W1R3Ct6LKws0gfYI7QRZzlhgKHlLq4Zo+SnC+ObDO80qRVA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=TAQ8TDQH; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kUfLFSMX; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724802564; x=1756338564;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=Oa/q/B7QC9shO/oS8EXiewx53fGXKpzhCJSJ6R64P3I=;
  b=TAQ8TDQH82fuWxeJbHi+p3BH2+AWTbvjtI8UYBqA6H/zTJpYWhv5h/k8
   SJRbMdX/mwOBd3Ht/juplzzO/P3y0e4LdZAyB+/HX9cP/4aNz+DUWnUjl
   fKGO6gLa0KfPVylpEQLYLRSih+EdMrS7bv8SOip5tvVi2a7KGRMISq7Eh
   kEKYliZ+XruF9zTV11WcBxx/NhfI9IrSHmR4mKzStsiUhWPWJnUl0FYZB
   eO8ZqCQPIxQfm8GtjG0jABWWGczAuvVhSQiXhovjYaYsQWSLLcFsx1j44
   +U2j0FjxvwDy+6RwY0mGLEifCM4HESSzA83lKAdPnDG70Zz9qJGaNRpyH
   g==;
X-CSE-ConnectionGUID: 6nM5VPwaSnKMiptNx8OWhw==
X-CSE-MsgGUID: FzX/a6fJRim/OZWQ93XV+g==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Aug 2024 16:49:17 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d51267620so68901855ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724802556; x=1725407356; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VhkdcW8ZfYHu6XlXCqHwIh0I4/YRYFz8/VqS+ioBQ68=;
        b=kUfLFSMX84oVMjEfw+lpah2hotRY6CcXigKX/e8RIS7QkoRAbUBVOIG+sf6CIwn3N1
         qd2N8WHWvs7ym9XXhtve60F9vrLVsmeAKN2xoQCBwA44GuH7z8EsSKitX1fwDn0XMZNB
         F08/oTRTyPt3E3duA4nm8eAAun+/FYAfRDmQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724802556; x=1725407356;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhkdcW8ZfYHu6XlXCqHwIh0I4/YRYFz8/VqS+ioBQ68=;
        b=EkejzCg+B+ReZgyRRNuhjfx144smDi9QApC7L1KSFfSzCXQAlkxad1UzonVqNWLv5V
         tWa6eoW5QNkC2ftDDky6rFyj03/f48Ix0PqtLIjmT9ZlXlggOHRgI9cuApv2+kMsp/DN
         2hLEGw0/8P9yFgSadjua9U23Ph4ZrVBiNrOuOwdJ7H6Y1ovXn8r8yOlHBKfLwREakSJe
         d/K6iLeYOpZKpkO6Y5T9yWqCnt2YepzRhaDhQfGYCcRZl+m7k+RLI5hI9rh3ZUqby/oY
         hacv9QPF1Rf6Gwcz7+2tgnYAB0T/Ko5WGZPxxiMNMuF9TNvQfzg129MvoyR0czfmeqtI
         i6dA==
X-Forwarded-Encrypted: i=1; AJvYcCWDudWzOFw8prGX6OGO0fhAYCOA7AbC/Rw3YqpqtGZijxTvONIzpi3hyrtNgaA/Xxtl9js3IAyy+17uBY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTmo94glIpiVUT09sjSqPnc8bOviD0tm5y9t9b+fxJVLtIt6o
	rWq2PeEfnsGcc1of4aR5nq3Ng8bwMF1nbeSJQrk+XGPKb6WZ09iFOIKf5moU/+PZn4JJPOyvgLx
	QoDtRWJcCObUPxTTofFAsbpWj6dOiDlpbqHKVP53InfnGJYvOrRzVfxMbO39b/oxj2RoLo8PREg
	UjDOrpRBDmIAB51dx5eLnM+Q1Vd+9QExn/vmyYAQ==
X-Received: by 2002:a05:6e02:1562:b0:39d:2a84:869f with SMTP id e9e14a558f8ab-39e3c9756e4mr163288765ab.6.1724802555935;
        Tue, 27 Aug 2024 16:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUBOoBnmQiWTUynS2fxSdY+CC+P2PsHPuzJdu9eahzwq/2ll+ccECRRFgXem+6XGY2oTPkmP3A99AQ2q0lQ3A=
X-Received: by 2002:a05:6e02:1562:b0:39d:2a84:869f with SMTP id
 e9e14a558f8ab-39e3c9756e4mr163288615ab.6.1724802555664; Tue, 27 Aug 2024
 16:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Tue, 27 Aug 2024 16:49:04 -0700
Message-ID: <CANikGpf0OmGMSkksH_ihW9_yXVAL25xKD4CBy8d1gpKj0inPjQ@mail.gmail.com>
Subject: BUG: kernel panic: corrupted stack end in worker_thread
To: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
The PoC generated by Syzkaller can have the kernel panic.
The full report including the Syzkaller reproducer:
https://gist.github.com/TomAPU/a96f6ccff8be688eb2870a71ef4d035d

The brief report is below:

Syzkaller hit 'kernel panic: corrupted stack end in worker_thread' bug.

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 5818 Comm: kworker/0:4 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue:  0x0 (ata_sff)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 panic+0x331/0x850 kernel/panic.c:347
 schedule_debug+0x2a8/0x3f0 kernel/sched/core.c:5964
 __schedule+0x12b/0x15e0 kernel/sched/core.c:6630
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 worker_thread+0xc6b/0x1020 kernel/workqueue.c:3424
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..

