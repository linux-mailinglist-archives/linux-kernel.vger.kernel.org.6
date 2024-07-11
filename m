Return-Path: <linux-kernel+bounces-248742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA592E163
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE35B23921
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38C14F111;
	Thu, 11 Jul 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IRdbCcLP"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011914F9F3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684474; cv=none; b=SSDdKtc+CGbQN4KiE/3IAC+a+O2G0qCsbjsGQ56S2bCgfHvnzlsppknlKGV6PI/nnEOkUN3feQqBKnfZ8O9O2XulwkmdycTUuS4uClg9ib31yHISh6h9YJra3zY6cqcC6MuRHrqx2MgqVMQe1Bs7gj0ugNW7P6BBSycehDml/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684474; c=relaxed/simple;
	bh=A92cYfBEW7Y3ABnWziZPRpDNTgfCIvtH4E/vUiYo7Us=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pi1dD2aq5fdYr7PvWdPbAH21Xt80auKVubXCMrnchEtDle1WEYjEQk4SJyrpFPmApapuXIEqjGS/07KVV4brAW3U3o3VYcFQP3ST/6IcX2Z4n/t3DQUtslqlFm3hDvXBACRe0eKyRvXLhnf3FlpNGsI6WhjGcnLdnQNBvYwnS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IRdbCcLP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee94169e66so276871fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720684468; x=1721289268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIvPtYGCegg9+pbyH7kzgxVBSj+brhikI982VwxShJc=;
        b=IRdbCcLPJyajc8nRRPOHpsNhMAwJJkR1L4oMgUIOdxAcWg+d8xfz5IPXG1jjxur9Mf
         SbNQO29OPhiiGHYqYGqcVfVvbQG1D8WrAdcWfLwAI1LsfU2WJJlYUapVJmAjSvhBXYZK
         U/b9TQQvHSDZ1Kj9q6ZU1D3LBS2o+keeF68PLoxA7dp/svxgpwkJ0ARWgYg8slMc29WB
         LJ5z4+YYQYFatYe+lFBMvtoA/9m+KnUdQzkR36J/vJ1bUWZ/izQPQlxb55SvbFv8XWLO
         h8A+Q6t11EK97zGVP+lTjFgZTofugPol/jDR8xb5L5gINQqlwxvr7qN0d8/iirLySdzh
         BT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720684468; x=1721289268;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIvPtYGCegg9+pbyH7kzgxVBSj+brhikI982VwxShJc=;
        b=bLoQNSPAoA7n+hOSVp5Do4AgaupAnmlvG6QeNgZkqcIpXQOy0V9Jt8AwFuDuoc1KQQ
         yx0ILKPEwyyxLUjDoQb8VYhzvNw2RouhHmJHibsKKa4iNtgbEZX+mdkPFBING5shv+8D
         JVY3+Yy2QZi+S9LiNEALitROa2kjMa5rQlmPJSELdBa0pgfH7h37PGMrdQB6QbuMflQh
         WXe2z5BBZmNqpMnXO6r193tOqt/TCatcxyJXNAI0n5UbMbhigthQa1gy6tCpRYrmo0QW
         JOC1e0BkeTH9SS6QMMOv4rfAtzT2djl32RXDWf15aQJfnAIO0UjdJtj3zONDugOYsCCM
         S2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv0zxMZw/wHwUnCWt0hMFDZmsz9p+iK8llbHo7yUBWvXWRx1wt61VXXS3vpOMH33mhZlHQcFKy5fDik/hUjh1j19wt1wz3xzZADg70
X-Gm-Message-State: AOJu0YzRVBaU9sWpfxg/f+eGti4TOMXXV6Nhbi9w0g3wnMrZ98BhBToE
	wosndKEaqjWcn9YiFi61CMdVjPZy7QjkrIN5zVvtLOMFsbva8UP+6IC2BC718yI=
X-Google-Smtp-Source: AGHT+IHFZ82UsJR7gXGZBhnud53dyW1eXMgpAEcT6yABHF3RycaKBs0ap+1Ma+a/PT2YdTmftJhYfQ==
X-Received: by 2002:a05:651c:2129:b0:2ec:4287:26ac with SMTP id 38308e7fff4ca-2eec98c72c0mr9505191fa.4.1720684468016;
        Thu, 11 Jul 2024 00:54:28 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb34751c3sm7778181fa.94.2024.07.11.00.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:54:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Tycho Andersen <tandersen@netflix.com>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
 Julian Orth <ju.orth@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Tejun Heo <tj@kernel.org>
In-Reply-To: <cover.1720634146.git.asml.silence@gmail.com>
References: <cover.1720634146.git.asml.silence@gmail.com>
Subject: Re: [PATCH v3 0/2] fix task_work interation with freezing
Message-Id: <172068446669.395668.14041206933640697434.b4-ty@kernel.dk>
Date: Thu, 11 Jul 2024 01:54:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Wed, 10 Jul 2024 18:58:16 +0100, Pavel Begunkov wrote:
> It's reported [1] that a task_work queued at a wrong time can prevent
> freezing and make the tasks to spin in get_signal() taking 100%
> of CPU. Patch 1 is a preparation. Patch 2 addresses the issue.
> 
> [1] https://github.com/systemd/systemd/issues/33626
> 
> v3: Slightly adjust commit messages
> v2: Move task_work_run() into do_freezer_trap()
>     Correct the Fixes tag is 2/2
> 
> [...]

Applied, thanks!

[1/2] io_uring/io-wq: limit retrying worker initialisation
      commit: 0453aad676ff99787124b9b3af4a5f59fbe808e2
[2/2] kernel: rerun task_work while freezing in get_signal()
      commit: 943ad0b62e3c21f324c4884caa6cb4a871bca05c

Best regards,
-- 
Jens Axboe




