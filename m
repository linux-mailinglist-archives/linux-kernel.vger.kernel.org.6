Return-Path: <linux-kernel+bounces-426812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF049DF8E6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49C82817F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F41F94D;
	Mon,  2 Dec 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRhRUePK"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE71BC49
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733106584; cv=none; b=hfJmeoVPu/mc2xudMVGlVxhA/sBOhw6RuXwywQ0e3EsBlbtUt1D+bIHjexndc+2OmXzYRuwElqM6OMe3etQ2PndfjFFQZn28iwpfwHb29o1MQGWCAhtM8XmvGGRmJVDCS0/r69zH8diAj1Q6u0wdvglHf9nTFCIkp3iQ/lOhMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733106584; c=relaxed/simple;
	bh=NmVyXejsczSuwa1hkyRmy1JM6R51NmnsIX+swHBgk/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l580WtnvXQHSLntbR0Tha0WqiYDyMQw+UQUNLkc2TctW3H4jR86+ag+Wof7z3qpAW6cniqO46SbQjuXr94+CwGic30HRgxVfXf6oMpPWj71cA+o2kbHoM/dp5xK4FOY25iQxPP6Bq8af+UIvWVx33nVMA+eTYsSlHP5Q0ejlwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRhRUePK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0e75335e3so854768a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 18:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733106581; x=1733711381; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7IBdvmhVXmllDliPTYs8sv0YFIfPVy9moMVVv1tWd78=;
        b=WRhRUePKnKcIJB0zI+XvUDkP18XHB7BArobt+evsglYhSNlml/CGF8koyBQ/lT5Bbx
         q7/2tDSr+Qzhqn1eJZzdnDv3CSxqQ7R973Lpq5Y3dEkVPUCwznJBJSlyc064IItVVmtZ
         V82amxN8d6PNNqg2i5zwZplQau7twq9RW72XdzRzkX1kho4MKrtBwdZrWDkh2y/8qz5z
         gjGZN658I5MQnbZ/F3neRfL2unP/EefiyTYq4csLJhsV98PPDD9ddwwfWITSysKo2zg3
         l1NIggnDz3jsoa/u/5PlSalCH+9H13oD9bZaW2K/bNnKzEtf4+McGImHgANvjoifuWcw
         3rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733106581; x=1733711381;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7IBdvmhVXmllDliPTYs8sv0YFIfPVy9moMVVv1tWd78=;
        b=w0d+FPwitm7qRMbuZrNzFCh8AIUA9FSQKGansXx2xm7zZEM4XDEOoNfaMtWQuuYfWi
         2yvEIhTYuUHdJ3yZRWzwDKcJF2CzuynMbwdINLofVeRHYYT2PV6Y+HbDih5t8GxzadYy
         2uao64hC9X8yxNNMv4xpQPWLfZvV+rEJ99+/Cr1BiLLrUrXUcY+4+PRkzbbO/IyqdmTK
         X7XQLKt83fcAmnQj9UNZllKC/dXew8Fio55Nnt471cj+AkZEgRCoYy02GB7NwQLmd+VJ
         9K+NtKBYd10RxUCPMkxFp1dUqL/VOAGCykePegVnMuIF3F5aF91ZmO8SLjhwdx9nATFN
         4LQw==
X-Gm-Message-State: AOJu0Yyf/xLwUborox+cgOqids55VX1lKiAKfiBYW4LrsqzL/+d1J9IW
	TGFrqZhzPw9gqzOmAKqv8EFXZ9yT+WIs9fZLBajBJyRw0o7Aqw7wM2iQy1CXW/IEhW8jFgtUF5s
	Ns4TR+SSzAnJqRhr+n+gZa+OLi9t/rfASvv8=
X-Gm-Gg: ASbGncvg23pMVwTID4AXuY8yaLf8g5YHoEWm3jBv9EYfSOOtUJfFyBlfqMw1g73ypI0
	nGg8NmMqNchczm3/5gQjCbX7KpqPOKHmB
X-Google-Smtp-Source: AGHT+IHQJWqCLMEHVQ37WqLw9BgxS1ARYHq9V93gGBh17YEVKcR6QpQpoAG78+EDh+C7gmVKlV8F4/vID585OjVokxY=
X-Received: by 2002:a05:6402:34c5:b0:5d0:e3fa:17ce with SMTP id
 4fb4d7f45d1cf-5d0e3fa1d65mr4595833a12.22.1733106580765; Sun, 01 Dec 2024
 18:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 10:29:29 +0800
Message-ID: <CAKHoSAuo37CMpkkij7SzPgra4VqJKUMWVV7rd=Mq6r5hXLmhvw@mail.gmail.com>
Subject: kernel panic: Failed to create the TCP control socket
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.32, specifically on the PowerPC architecture.
This issue was discovered using our custom vulnerability discovery
tool.

Detailed report:

bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver hub
Freescale Elo / Elo Plus DMA driver
NET: Registered protocol family 2
Kernel panic - not syncing: Failed to create the TCP control socket.

VM DIAGNOSIS:
15:22:24  Registers:
Failed readin g regs: dial tcp 127.0.0.1:4441: connect: connection refused


Root Cause:

The root cause of this kernel panic is the failure to create a TCP
control socket during early network initialization, which prevents the
system from proceeding with networking operations. This could be due
to insufficient system resources (e.g., memory or file descriptors),
improper initialization of the networking subsystem, or misconfigured
kernel options that prevent the correct setup of the network stack or
drivers. The absence of the critical TCP socket halts the networking
stack, resulting in the kernel panic.

We would appreciate it if the kernel maintainers could investigate
this issue further. Please let us know if additional details or steps
to reproduce are needed. We are happy to assist in any way we can.

Thank you for your time and attention.


Best regards

Wall

