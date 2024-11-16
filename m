Return-Path: <linux-kernel+bounces-411605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815A9CFCB8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 05:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0A01F240E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6319004A;
	Sat, 16 Nov 2024 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhpkXuC0"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BF2F43
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 04:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731732993; cv=none; b=rVcVNfAlqvkPWknKh28M+QaljyMrK/5IfyIRJLHhmI2Qr1b7DvfO/kjKja97opuxIFFblUNkEIzefsaZmWmSsIybCsbEU+RExHD1ginazasudaWBfu3ugBpZqSyIHiEllapQBTBCDA+UNikL3fPsgkbeRG80HYsNCB0mMQWcOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731732993; c=relaxed/simple;
	bh=WfSkP59nGDZxTT9OfAo01FZ1TXW15IDpEjvDUDEoGR8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t8cYJzjkwrIGD9rBRFQjpnirD7lwOMR8qC4Vv3PpYWuVUKu3G6YcTEEOPVNsLXdNd/CrXEX2fzZpT/x3XTvbr9NITV9iKT24Z/0ow+4iUc0Kwk05IVzBRzWHB+cmUuZEL1MfzKiPNsoWSgS9Szpikc9soU81mU2K2ufwAu4MC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhpkXuC0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539eb97f26aso2607051e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731732990; x=1732337790; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tx4wyFL5lWK8s00cmYE7AG1FhaMrCGq8SKhd6TPe6CE=;
        b=lhpkXuC0jKR26tosHhWXe5HJzVW/zkcNMqeK7PXrHADxA76vzRXOZJUC1EgxNb4GtJ
         2dNhSAzGrYNORv6zPw+c5KNUr+NF10pyBuYJ2X+vQpKxCW4+iJ0LVg43863E/6KWrLfi
         4vsr+lyR6fIFfNKDxmViZxvVOTFIMXwNNjiNN96RY4LE3y/00si3KBNvAqGgpbauDMF0
         pJ+yKa+RNIli7uwoyH9cQV12n/EAcZmUEW27vt7GBeJY9ex+2bN2E0c8f57EE1UGUdax
         mNuKgDsx+cCb3Lifve5zZ37mqccrzgNhByMgsXxsJbFbjJlBD+XIEB2V/7sm516b9Du/
         b7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731732990; x=1732337790;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tx4wyFL5lWK8s00cmYE7AG1FhaMrCGq8SKhd6TPe6CE=;
        b=F+JZpx6eKDL+/bRQcpNRWGWNojETR/4n485hP+bQmi3QliQ/c4SqSYLem5FQrprq1a
         fa6M5NggGj6VbkuPikMdzHIm6OY8WugVSHpxNS6K3Igsz5RMwC4YzI9qyKIDPRjCdN1Y
         s397gSavi/7xLBBh2DyOZAZj13Ia0HQheeimJSrmg6hf9blS4MZ48ZypZE1gLWJG17qx
         9eqb8j1+s7bFRz92k+0QLLOmQrii4YdBbZ9kumn4W07R6MoaNP1QN74zntlPltuXhstS
         rBb5hH5gU4efWBuWNwrl99aCilqe8kk2i8R5DQlV35x8faAORM77uYlRSOW2Q4Yb+8t7
         QB0A==
X-Forwarded-Encrypted: i=1; AJvYcCU/onpnWP8AEXYkrSnPD9vXMougN0aSNFlRc2XfqX29jtvansSjhxzhbXBUStDpWoQaC6hVoy1QckqSwdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8aA3GJEJkABnZlYA7pK/95NbABOjtGl9V36/STTkEd9fELVs
	BwRBzIO+gZwh7mnkgz4o7Vt7LvotRQeg8aKlyQyTWpRdX1bSu4usdbzV0VLoRz6V1OG17hboSpn
	b5ZKIxd5X+ScRfGKjTmb18sivRhaDb11M
X-Google-Smtp-Source: AGHT+IF3nevvzkFFYM4REUxJyG3tvQXzh6K5z6epuhDxzGDD7g6DRUmqcRbBMPGXd+xJzhobvyVjrrwSZ93zUJXipsM=
X-Received: by 2002:a05:6512:3e0c:b0:531:4c6d:b8ef with SMTP id
 2adb3069b0e04-53dab294150mr2574346e87.6.1731732990120; Fri, 15 Nov 2024
 20:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: shaarang tyagi <shaarang.tyagi@gmail.com>
Date: Sat, 16 Nov 2024 10:26:19 +0530
Message-ID: <CAOAOcWt4p8ng6yxod0wU4XZfOcT=UFTuzaFxWd4rsfU=H3_FVQ@mail.gmail.com>
Subject: [Question] [sched/fair] can vma be unmapped when somewhere inside task_numa_work
To: "tglx@linutronix.de" <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

In the file sched/fair.c  in the function: task_numa_work(struct
callback_head *work)
My question is that is it possible that vma is unmapped(concurrently)
after the null check in the for loop has succeeded ?
Will it cause a dangling vma pointer?

For example right at the starting of the do..while(end != vma->end) loop.
Or vma is unmapped right before where we dereference 'vma->vm_file'.

Best Regards,
Shaarang

