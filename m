Return-Path: <linux-kernel+bounces-415087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB489D3164
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB13EB2239F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6FA939;
	Wed, 20 Nov 2024 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jobyaviation.com header.i=@jobyaviation.com header.b="hzZc2lHz"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A01749A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062616; cv=none; b=P8rk/FFD/OetXLNBbYUOeQGFa8+wH0aiP7HwRPMoB7iwhDk04KFutljFqP1sTSj2qm51PWw1PwzLmSJdqRaYqX2YCn92kjsk+bxr9lDAceiuEhhFmIazEZYrVcewmuohZRNn37e/oxn/GQWvmQXxKDfHwhO7CAABmJXJm/2nbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062616; c=relaxed/simple;
	bh=d+BVKrZpfVweKPv9g43tqBXKWhOygTcYMhNhb0Q5Pms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W63Xc6BqYC1IUq+sEdDfQkMDuvCDXxmYE92JxUNwPL0myC83k2fRYo63AKMwVQVd9iFgIItlgrXUJ5U52GaiP/xWbqmBNATjolzL6SsHV46CaCYIL3Fnxf8j+2ctGiY//HQs4cgXCAfT31mu4FyAUXoeQ7yZDKFBhRILuzQzwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jobyaviation.com; spf=pass smtp.mailfrom=jobyaviation.com; dkim=pass (2048-bit key) header.d=jobyaviation.com header.i=@jobyaviation.com header.b=hzZc2lHz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jobyaviation.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jobyaviation.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so2583998a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jobyaviation.com; s=google; t=1732062613; x=1732667413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+BVKrZpfVweKPv9g43tqBXKWhOygTcYMhNhb0Q5Pms=;
        b=hzZc2lHzIu7b7OwKUdtpVeUqT/fyXHlX6Rjz1qimJ3rUEX5A9hMPq4VR9e1NQGJtL5
         9lwNGwjkkkny80FCIuYjlFr7WHNTbJgp+MkXFINQUSRyRzVmzKyyfkdEExn/8FlE05Hx
         fF3g0GSMmwopFPVOON2loTLof95Ao1VP+KNIgcgRuhLomc1Si07OKM7tHkdLeEYDwvPo
         Ovhofr4xFckxEvbB/X2w85689Sn1hBOZMKe6NtFbZ6Rej30DTo4UziZVboB+v7Lxvt9D
         Z4u4gmttVUVlKABDB3uRqmtnIlUxotlKax3s0l5M4T+8CxfzOpauSgqtGT9qk+ZUZX/R
         EEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732062613; x=1732667413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+BVKrZpfVweKPv9g43tqBXKWhOygTcYMhNhb0Q5Pms=;
        b=K1N0bojf+NjsQd4vii4yPZYnbqbvcQC3Ro/v4CS0NAXz0A3kGv25sxgyKAQiH0VFK7
         yna5XEGA6CAd3J0T8/T/Tn2a2KBH6OL0gitmoeDmn36A4DJUw/48ZkY+uUSwJMDDdgCM
         921Dj7jf1qyKiJgi5UgXPgo3h4vWsmjRjzZcRV404ivHCJR+9uYHAvS4DX9BE4whGemd
         TDJKGtypDKhlIsK8c69pBEzDQ6abxsRMi6Mt9tJyujMXpWoC8AxyzkNQj/qCbRt2YExl
         Zrh79YtZLJwnIm5AadJYcrJ1IQuKZ+m1jLUxfew9x7T8Dmb4Dwj0mGyuE2akg/bp7877
         k2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUg6ypvpFOh7Eom9mawGZwRJBadrAhh+crer77op3RxjE1me/x1LhdVgsYGdJtzjWXW4BWjRIhia7Jn5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbXMgFkSTM5HXQuYabhn9kuSE0ktowhXx5po4VC7CgT2nUjNd
	1tyrALhnaU8rWKAO7fqMiIiXtLDYnkZirxZXPWPssWmYgeoSqyHzQQXjEahVbHuFKIdLjEplmAk
	tI+KvchYCMMnsWWYTGG9JUeVd+5bs0Doa/Ib6S4qI6GyQw2DdssLNAOTo38kh23LX4WjThgFrzl
	KXy8kmrE7o+3qC1bV4DEZY8MHjh5ef
X-Google-Smtp-Source: AGHT+IHu9jrG/J8KeaPlX/LhlcBm4XHfdDXQTx3GImlfZVKS2/WywDBk8jc+b0UcXIXPSYPJO1YtWXaskuNq95WNG0I=
X-Received: by 2002:a17:90a:d410:b0:2ea:5823:c150 with SMTP id
 98e67ed59e1d1-2eaca7c5872mr1011629a91.30.1732062613481; Tue, 19 Nov 2024
 16:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenbo Lu <chenbo.lu@jobyaviation.com>
Date: Tue, 19 Nov 2024 16:30:02 -0800
Message-ID: <CACodVevaOp4f=Gg467_m-FAdQFceGQYr7_Ahtt6CfpDVQhAsjA@mail.gmail.com>
Subject: Performance Degradation After Upgrading to Kernel 6.8
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am experiencing a significant performance degradation after
upgrading my kernel from version 6.6 to 6.8 and would appreciate any
insights or suggestions.

I am running a high-load simulation system that spawns more than 1000
threads and the overall CPU usage is 30%+ . Most of the threads are
using real-time
scheduling (SCHED_RR), and the threads of a model are using
SCHED_DEADLINE. After upgrading the kernel, I noticed that the
execution time of my model has increased from 4.5ms to 6ms.

What I Have Done So Far:
1. I found this [bug
report](https://bugzilla.kernel.org/show_bug.cgi?id=3D219366#c7) and
reverted the commit efa7df3e3bb5da8e6abbe37727417f32a37fba47 mentioned
in the post. Unfortunately, this did not resolve the issue.
2. I performed a git bisect and found that after these two commits
related to scheduling (RT and deadline) were merged, the problem
happened. They are 612f769edd06a6e42f7cd72425488e68ddaeef0a,
5fe7765997b139e2d922b58359dea181efe618f9
After reverting these two commits, the model execution time improved
to around 5 ms.
3. I revert two more commits, and the execution time is back to 4.7ms:
63ba8422f876e32ee564ea95da9a7313b13ff0a1,
efa7df3e3bb5da8e6abbe37727417f32a37fba47

My questions are:
1.Has anyone else experienced similar performance degradation after
upgrading to kernel 6.8?
2.Can anyone explain why these two commits are causing the problem? I
am not very familiar with the kernel code and would appreciate any
insights.
3.Are there any additional settings or configurations I need to apply
when using kernel 6.8 to avoid this issue?

My CPU is AMD Ryzen Threadripper 3970X, and my desktop uses Ubuntu 24.04.

Thanks again for any insights or suggestions. Please let me know if
any other information is needed.

Best,
Chenbo

--=20
This email and any relevant attachments may include confidential and/or=20
proprietary information.=C2=A0 Any distribution or use by anyone other than=
 the=20
intended recipient(s) or other than for the intended purpose(s) is=20
prohibited and may be unlawful.=C2=A0 If you are not the intended recipient=
 of=20
this message, please notify the sender by replying to this message and then=
=20
delete it from your system.

