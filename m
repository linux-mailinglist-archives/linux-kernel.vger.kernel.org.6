Return-Path: <linux-kernel+bounces-169407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDD8BC84C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2061C212CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DD128369;
	Mon,  6 May 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="JZcmtWYM"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B43FB89
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980371; cv=none; b=Vdrb1GndQFshLJeQfMo6gjTii1W/zeBZ2AQ0gwrbExv2rBKG2B9q040EUBc/EqUCNxNLhZ6NoyATOL+CUibAHj6hHQHALgC2N/XEHzcC/BLrL+Jt0nM8V/bjFatEDATm9jIlt1rqKXisw7FZxJevH4t0768vyc6AOoTrqZKrbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980371; c=relaxed/simple;
	bh=kNlC3ytR6jF8KFvH38aTFlOjsB+JSnIeAJcLtaQm2ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MrvoGyJI0WYmxCv1IocZcaN0u4rZdYmzOwvM/MwjzoO6axdMHw6aLKCDI4GfrOasHB9cOxjtCr42QAasFEoF5ikF5D/kZIUUVDZV/LpAEwyycFqjkBGC4tXdS6qsZQFGBf+AKIk3wdnSgGs+27esxHXgRWcmRF867d8TDr1KxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=JZcmtWYM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59ce1e8609so91606366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1714980368; x=1715585168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1s5Au78z3qxhcC37ngaPrO+T+4+oXjIpiq9d6KPXx0=;
        b=JZcmtWYMhxerUKFf/7ApcRu3vXhJKqcQa7uk0DV87jGwaBeGzwmRqXiwidA81n/Ejp
         JVZGaxdaLMTV4/7HfyjUp29d5uGb+YuLz+QAVA8fGFGhNgobGEfwKSgUqGGaYgBCCIOe
         dR1B99uAuJnfj4oc4fMOnBh7yGKz6dBwH2jGpOs/XZtLCqlNGYQovN+lFh83ocdjYXdK
         zted1/nTrAXFmhI5qPNxRnbKTFB73MeBmB2F8RJfIEdzWd6lnNHUt2K4TvfrOSZHhity
         pHtY1avVk63Et7ZyLI6szLTjtvLwgc7YGIPIgjGgLcz+6CJ+1pzD4Fa7Xn7dUFNyARAP
         N1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714980368; x=1715585168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1s5Au78z3qxhcC37ngaPrO+T+4+oXjIpiq9d6KPXx0=;
        b=CTn/xcKv5vJZte53uDSZMKThZPxhw5QxUQVARXyNQ6VReyY4o+YJNXtzPLGaqPcyRB
         mvr+lfm7IsQlTtFDl69mdg/z6lp1JAJs3weBYueIaTG5SFXbOeDzUD+2Mqgt6pI3cQEw
         8n3pHE+7RY5ufXJYXnvpY7hmByLFAX8sHhg9K9NJx6C41y7G1DpsdehoHydRIePkfcEv
         CymLxLt5oldpH4yoR4JoSHlUCwOq6Z+zOrLY7hitqgEk+JhVUttGhsHNOxKZAZ8CE1Ij
         WwimmNv9isbCTyF+xWvxPLaOpYlhljvPhZ8Xn3CtvVbZgh0SeSIxrH7Gy5ULwY2fzsFb
         OnMA==
X-Forwarded-Encrypted: i=1; AJvYcCVmhFY0TCu2DEEF6kHSpw3jYoV1aQBHRe7T3+E0zhdHRH5YbX1VLFA+cBEt75sr6Gdj4e12MPeGWdMg/+R7cLxkUd/HCZFG94I5SRwy
X-Gm-Message-State: AOJu0Yw+qXLfotvDx9s+VeE/tWyAT8TqAKS4+odW5lKI6U7pUu+6HbGG
	1+2099Nr8DEoLug5CCUlsFN2xyxVAou5cFNoYOqjF9B7bBhWrwuSLg+2CCrxfeI=
X-Google-Smtp-Source: AGHT+IFrbGs1O2fanbF809F8RXY6VU0WzF/1lz4jI9rBNxf2GDcabB3G12LmCd5CDLAyuh2x3yW7tA==
X-Received: by 2002:a17:907:1c28:b0:a59:bb24:a61 with SMTP id nc40-20020a1709071c2800b00a59bb240a61mr4310500ejc.30.1714980367753;
        Mon, 06 May 2024 00:26:07 -0700 (PDT)
Received: from jrc-a.. (213-47-229-24.cable.dynamic.surfer.at. [213.47.229.24])
        by smtp.gmail.com with ESMTPSA id oy17-20020a170907105100b00a599a5dec53sm3552611ejb.125.2024.05.06.00.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:26:07 -0700 (PDT)
From: Joel Colledge <joel.colledge@linbit.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] dm-delay: fix hung task issue
Date: Mon,  6 May 2024 09:25:22 +0200
Message-Id: <20240506072523.399767-1-joel.colledge@linbit.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The tests for DRBD encountered an issue with dm-delay when testing with
a 6.8 series kernel. Specifically on Ubuntu 24.04 "Noble". Here is a
minimal reproducer:

virter vm run --name dm-delay-test --id 10 --wait-ssh ubuntu-noble
virter vm ssh dm-delay-test
# truncate -s 100M /file
# loop_dev=$(losetup -f --show /file)
# echo "0 $(blockdev --getsz $loop_dev) delay $loop_dev 0 0" | dmsetup create delay-volume

After a few minutes, the following is printed to the kernel log:

[  246.919123] INFO: task dm-delay-flush-:1256 blocked for more than 122 seconds.
[  246.922543]       Not tainted 6.8.0-31-generic #31-Ubuntu
[  246.923753] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.924932] task:dm-delay-flush- state:D stack:0     pid:1256  tgid:1256  ppid:2      flags:0x00004000
[  246.924940] Call Trace:
[  246.924950]  <TASK>
[  246.924980]  __schedule+0x27c/0x6b0
[  246.925002]  ? __pfx_flush_worker_fn+0x10/0x10 [dm_delay]
[  246.925011]  schedule+0x33/0x110
[  246.925016]  schedule_preempt_disabled+0x15/0x30
[  246.925035]  kthread+0xb1/0x120
..

This bug appears to have been introduced in Linux v6.7.

The following patch fixes the issue.

Thanks Christian and Benjamin for the comments on v1!

Changes from v1:
- Use kthread_run() instead of wake_up_process()

Joel Colledge (1):
  dm-delay: fix hung task introduced by kthread mode

 drivers/md/dm-delay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.34.1


