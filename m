Return-Path: <linux-kernel+bounces-424205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C855E9DB199
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC51B21A43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EEE6F06A;
	Thu, 28 Nov 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv8EGtJB"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B02E406
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732762369; cv=none; b=e7sYh5JH0nMr7+po/iVgy835zEI0lZr/d71YphMwDymmUndGMl4sEeKpiN4mERukzK7V22Qn6XMfpe5jOFX91HW8VHncrREEqGCDVErZEWVmsbgCUdP8HFxMdCkrRUCLFlzGdhyUhaDkAWKu0hFsn2SmWVXzDl0TS8iGIHjKfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732762369; c=relaxed/simple;
	bh=ORMQBLb0HOiwDsPRNKeOsoJpwug3UgtJhA4Nvn5Ga8o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WnUUEJaWntWQ6WTIC2uPhBPRYrwI+n2yapzX3AUZHcXWtHuNGUKaOuizoVbssTjKt77rCCk5ED2OdVVkGAfs/uy7wL5TF5hBydhFEpGNddIWWZ8fE0bljK/rnZGIqnx1Hgw8QBxvF8kWIb01JtbisQEJG9zJaMV1IKr60K2yw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv8EGtJB; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-84386a6669bso12712739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732762367; x=1733367167; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ORMQBLb0HOiwDsPRNKeOsoJpwug3UgtJhA4Nvn5Ga8o=;
        b=Uv8EGtJBl5SEOqFm+khUia6jVa1b7c+jiwb++nJrAp0T7CPIQupufYNZvGLq8kl4Nh
         /F05N66XWxSsOHaRvoDDZab7ULYV5oqUHCxz4/5ANrTPyEtIqcgnAGf0UKhOXgtvpVlL
         Rv0DH8xqNzRDRE5qeLg5iG/DC6A3LoGtGVsNlxpxpaOgETud6gFDQFR0mfruXSVSwhVU
         +qrFjbSoHymKY4wxCpy04rkMIwkrrgEFAcZVduMpWpno9Yh+ZyArcxQpkm8s6QzDlcLi
         A5TU3wDDGYUy+4ZVF9irNoPYThIfEt+Qocm2mbAzwlhxC2wVYFZQ2stTcEfiCYSeqwvH
         XjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732762367; x=1733367167;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORMQBLb0HOiwDsPRNKeOsoJpwug3UgtJhA4Nvn5Ga8o=;
        b=JE6t/Bvlq77jfEjy0sSTJaY+3RWIvwaKhd/7DFdZuRJS5IX+gVwGEFxM/311/y0JZy
         UBXDvpuTgJeiYu3c2RBn94tnYQFyzU3n7P4NJQUT0Z9zAkQWntICx95oEnKeuNY+uO0D
         ty0tvi+mFGJijHnp/we7zKAOL+vXFLMTcrGugkPO0TOAnx0RpY6hyFOtuGYKKGkha/Pb
         qtQz40ntDlBn93PN4ZakiQHMsndvdnrqxf0FzJJ2qc2UF3nrMqB6DnHN/QzwBaRG4fZ8
         rqB5VZCyN2qN38D6RixCpvHTLgBI4lEzPU/CxSCF0jKQ0S2omZLM7Gu36eesvuO6Nlse
         a4vg==
X-Gm-Message-State: AOJu0YyOkWeq/Tpq2mtQkxd8CqPtWItWgcFUlaflL7P0vZBBL6tFYUZZ
	GbiIltHdk8OGS1zuNH6A/VFqAa9kRRz9i6cJNwlTxfz4KTb0TSRDAhvp2FMDjt668e6maG8pFSQ
	vpEBvWZ1R3pNC2hnveaFaDq3Ku6wUtq+041s=
X-Gm-Gg: ASbGncuBP5sbVEJZvGHTfd/1EiXrTrdC9c8dy0dapilc5lVRByqn2pgHVIK62VPzdQg
	YXD+o97ZPl127Nkz6Q2AG0aYjS2/JjPy1kYUU48ya+FFmp/m253fFBE5Ahckv/Bj1
X-Google-Smtp-Source: AGHT+IE3YN0TT7jtbLwphdTNCN50OmvopGL2FFKdr6kftF8ClFLJNjU/FGzyqrwWYOjdDr9P10xUyYMkrNywgMFnpSw=
X-Received: by 2002:a05:6602:342a:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-843ed09db4amr764987439f.12.1732762366991; Wed, 27 Nov 2024
 18:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rui Ueyama <rui314@gmail.com>
Date: Thu, 28 Nov 2024 11:52:35 +0900
Message-ID: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
Subject: Wislist for Linux from the mold linker's POV
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm the author of the mold linker. I developed mold for speed, and I
think I achieved that goal. As a ballpark number, mold can create a 1
GiB executable in a second on a recent 32-core x86 machine. While
developing mold, I noticed that the kernel's performance occasionally
became a bottleneck. I=E2=80=99d like to share these observations as a
wishlist so that kernel developers can at least recognize potential
areas for improvement.

mold might be somewhat unique from the kernel's point of view. Speed
is the utmost goal for the program, so we care about every
millisecond. Its performance characteristics are very bursty: as soon
as the linker is invoked, it reads hundreds or thousands of object
files, creates a multi-gibibyte output file, and then exits, while
utilizing all available cores on a machine, all within just a few
seconds.

Here is what I noticed while developing mold:

- exit(2) takes a few hundred milliseconds for a large process

I believe this is because mold mmaps all input files and an output
file, and clearing/flushing memory-mapped data is fairly expensive. I
wondered if this could be improved. If it is unavoidable, could the
cleanup process be made asynchronous so that exit(2) takes effect
immediately?

To avoid this overhead, mold currently forks a child process, lets the
child handle the actual linking task, and then, as soon as the child
closes the output file, the parent exits (which takes no time since
the parent is lightweight). Since the child is not an interactive
process, it can afford to take its time for exit. While this works, I
would prefer to avoid it if possible, as it is somewhat a hacky
workaround.

- Writing to a fresh file is slower than writing to an existing file

mold can link a 4 GiB LLVM/clang executable in ~1.8 seconds on my
machine if the linker reuses an existing file and overwrites it.
However, the speed decreases to ~2.8 seconds if the output file does
not exist and mold needs to create a fresh file. I tried using
fallocate(2) to preallocate disk blocks, but it didn't help. While 4
GiB is not small, should creating a file really take almost a second?

- Lack of a safe system-wide semaphore

mold is multi-threaded itself, so it doesn't make much sense to run
multiple instances of the linker in parallel if the number of cores
is, say, less than 16. In fact, doing so could decrease performance
because the working set increases as the number of linker processes
grows. In the worst case, they may even crash due to OOM. Therefore,
we want mold to wait for other mold processes to terminate if another
instance is already running. However, achieving this appears to be
difficult.

Currently, we are using a lockfile. This approach is simple and
reliable -- a file lock is guaranteed to be released by the kernel if
the process exits, whether gracefully or unexpectedly. However, this
only allows one active process at a time. If your machine has 64
cores, you may want to run a few linker processes simultaneously.
However, allowing up to N processes where N>1 is significantly harder.
POSIX semaphores are not released on process exit, so it may cause
resource leaks. We could run a daemon process to count the number of
active processes, but that feels overkill for achieving this goal.

After all, we just want a system-wide semaphore that is guaranteed to
be released on process exit. But it seems like such a thing doesn't
exist.

