Return-Path: <linux-kernel+bounces-215758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D29096B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73022284C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FAE18037;
	Sat, 15 Jun 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCQNYtfP"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91517BCB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438727; cv=none; b=K5KyT4CJx9zyIoF3K9FpVnVT2AcjvJenJxZEcI2j3u4vWH/jSCA0hbjjXsfNY+sZJjonYQAJ0IHlaG2dIXWkawwwBAAwu3WaA/z+04sGN4CC/hog0P5Z1FStE/uBb0F8wZal/xVgwYEfu68y6dyw9pvdNtFazxRCASmIbTnB/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438727; c=relaxed/simple;
	bh=bpSAqltJJDrc8OIeVMFHLNWqmBjNYkwRBQsDvwe2WRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2MrHVsEZzimBW2el/gFTVNCoBO0wDBG7juKuXAD0SoV2XvQr0ccNoXCf0vpigwfr0MuevkVf63vsV2WynQBZ6YKrLFSd44fiNtggdmiPtPCxdL9X0JCHdH6oby/aqMVOBtAQyVGcaaSpScAR7cCJfCAOOgrqrgrOqhHSNKXv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCQNYtfP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso3774129a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718438723; x=1719043523; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kZSSAKx4JLVIw59Xf8Yxuy4vS34XBtSXCGo/Ramx5QE=;
        b=LCQNYtfPN1bBi/QP7uXl1fPo3s+m2DI6urqhvh7jLW+cD3DUiZwJH+OJEM287ceQKO
         VKr/UbMxOLNSH7FD2wJai1FvaaWG8hvPUDlRqWXjWV1OvAeuzHgGjsvRx0SK0feKcSyH
         PTk8t8TRv444/mrBeDrz4sm2zYr4lLjPB3ym3ycIBsRDiiGEePdX/M77GVLDk9LBw2ns
         3IUFdHSkGz7lD5eq90kxrFmYBJ5/9wL+4787r/FVO+QzYBNGLTJwoGSe/0278bMyHwcY
         Ki17nFCLRurSWVfpN4N77gWqLSS3diRyxB6nBGherAOXcCZUhlgcxg/k/485lUXv5Ghd
         YA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718438723; x=1719043523;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZSSAKx4JLVIw59Xf8Yxuy4vS34XBtSXCGo/Ramx5QE=;
        b=CsjcsQePLm0IrdqvKNEkJkaTxZRWAiumzNeX0qEewywzwOUqTPFcxm0sEXFP9kNMQ4
         uneqaewlmFhN+Zrn5TqC3Y6MtGQVAEzsPICWabMqeT3MWMdS9jD/Pv7rsiQRnHKVEhg0
         huGr1AUopHpd/0m+/n9KYIo6wmVyrQR5ymmpDCVMzpfZOkALXLIeltCEpEELw6YVlQD6
         sK9gSOClSe5TSuCN36h+IuaK3uix+dBuWqkjbKiwhal4y7l0A1FAjNgFLFW7SfSrVlIv
         mHFtHBdx1MmxfYTXKUmY8Hq0hJQyTTRh7crw9vw4LSChx1YjL90JwRaThSmJ/Un70mj+
         mSzQ==
X-Gm-Message-State: AOJu0Yw3cCAL7KbKuBo7OS8ouTBs6HHlpvMkK3A9mccA4lqhF9XkJiKw
	BwKTV1P3MsZu5fmnCyLJn8UpXjz1IM14bIkgP5Bq5RNKYfS5qJ54
X-Google-Smtp-Source: AGHT+IHXPGNjdD4QpU7d+X3owTVDjEqfEbbeIh4LCpwxNcLB/ORjMApUnEdqifIFzhmejtjnZdrpYA==
X-Received: by 2002:a17:907:c302:b0:a6f:6c57:603c with SMTP id a640c23a62f3a-a6f6c57627dmr200513166b.70.1718438723298;
        Sat, 15 Jun 2024 01:05:23 -0700 (PDT)
Received: from gmail.com (1F2EF7F9.nat.pool.telekom.hu. [31.46.247.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6b1asm270437866b.88.2024.06.15.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 01:05:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 15 Jun 2024 10:05:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] timer fix
Message-ID: <Zm1LHnqOv9SsW9EM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest timers/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-06-15

   # HEAD: 07c54cc5988f19c9642fd463c2dbdac7fc52f777 tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()

Fix boot-time warning in tick_setup_device().

 Thanks,

	Ingo

------------------>
Oleg Nesterov (1):
      tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()


 kernel/time/tick-common.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

