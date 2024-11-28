Return-Path: <linux-kernel+bounces-424245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B659DB201
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA462827F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514013211F;
	Thu, 28 Nov 2024 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ioA7tJAE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B402563
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732766048; cv=none; b=MDz/N3/8ggKi0hcSXzlRPw1qpe1qP8ZPk3GuqrOVZ5aPtEdHuQGYkbWIfnpiVPf3TREH4VRh2/NLOXTAyqjGLi7udMrMUC1UhQk8FFAlsWShkTkFLAhxXsfKH7QlG7emEBjB4xCq3VGyHhlja+dmw2W0fvtqzR6VS4h41xSMcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732766048; c=relaxed/simple;
	bh=VmRHmqJGZNsVUqgTQtXEBy3bZGPIe6ah/oVVl+q2Fdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lYNY8cvEJBOw8rIWM1Ncg3iiCLXiTrrwn5mzPISRS+mpSHj/Jjpo63JTcXMx4kMqFZyDsCcpmTLzDbyGb0L44/9Du35+rb/bejRlRvyZvqto7iKT2Oz0Mkxws+5Q3Ii8gHb+McEEMtOExefjGlFhmiQSggCFJiIPH60I7SFpJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ioA7tJAE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-212581a0b33so3463835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732766046; x=1733370846; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF5il+e7Kq8fof0AwUQ4lkAD7fimdwuQEUr9/oLqqYc=;
        b=ioA7tJAEMGkTKmaX/OlxNBWXupm9WeXYdyKObiWfLliaC2x129hzB78VRo7JhEju0d
         S3o8Z1WokV0S07+M5L4KkZFvB3XUu0S07yj/shomHQpHE0kkejCHTcmTXDp7vcSARCCl
         PdcpDIRPj3YDfJQ9cNVw5VkSi8fLlBOlhYGvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732766046; x=1733370846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TF5il+e7Kq8fof0AwUQ4lkAD7fimdwuQEUr9/oLqqYc=;
        b=vymGU3hOSbuI0tIZ1rHiPdP/46HvPIoRv78ycXI9CD2RxMDC6okCf/lVq5hTHPktJl
         MRarHLKhW5WevB1GpGwepz0JxqmIA7859a5OZyvOp6V/Cat1/Fu3hQV+1eR5nda2F9QV
         RizYBvj01lYnMKVHQuYPU8b30mWjEOJ8H3o9BDem/iAmTz7/013bEeNqjKzidPIQ0sxZ
         MoQRxY5SK1Z6oJJ2gcKoLTtAtWW8SsvmzxZJG0Bq8qr9D98Uz268Lvoyyw6dcOxTYi/z
         3m9GQ7ZgtERk28lGJR301buUtNruhQlzQ46IePJyffIBbh//ujmzynzcurO6vrr7eOox
         EIEg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/CEn/dr/I/7GFPXogtz+AyVa5GpHPuvnYGMXHQrPF6OsQFQ1azi6G6ydeGlE+mgiY5FwlR2K0rYRzLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjNqJHXVcLpfzAF99p+/pUBcgSGsL8eZ8K7oZ1D39MfSRLDJX
	jdSVUgbVgAyJEAGy0VSjhAfO6glsyRuNKJI1qdY/jA3vnj5WobrWcTGHbyDq4g==
X-Gm-Gg: ASbGncvjgRT6Sj2ivETL8salO9q/uT98EaLWTzsbr7sWJeTje1e148ONY+OniBAA5xZ
	EjgOxKtKX/6tVsYHrVB05WFVo9pfLYT03PTXKSN4TfxGZBX0vouMLOUt4y34PdFAPcZ/lo1Csr2
	SMMRNu3iDZK9JI1CvZG8KMj1ctFcd+OrHuKYV5WS47Ck7rf0RtS30Sn/egsdoxpydQCaaMsp+/U
	B7Y16GY1BMpySCXbCwhxnXKXdxwwGVerzE2c32DDxqbDa7xBd8ZOA==
X-Google-Smtp-Source: AGHT+IEnHytmJOdlEbxOpHUoUCVq72o0QdAQmffnOzCaX9vUp9WWUHEUK7ZrwamHbjp9SixH9iqliw==
X-Received: by 2002:a17:902:d502:b0:212:6187:6a76 with SMTP id d9443c01a7336-215010960cfmr71640485ad.14.1732766045920;
        Wed, 27 Nov 2024 19:54:05 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4351:dff5:9f71:a969])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f22c2sm3512125ad.26.2024.11.27.19.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 19:54:05 -0800 (PST)
Date: Thu, 28 Nov 2024 12:54:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Tomasz Figa <tfiga@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: fuse: fuse semantics wrt stalled requests
Message-ID: <20241128035401.GA10431@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Miklos,

A question: does fuse define any semantics for stalled requests handling?

We are currently looking at a number of hung_task watchdog crashes with
tasks waiting forever in d_wait_lookup() for dentries to lose PAR_LOOKUP
state, and we suspect that those dentries are from fuse mount point
(we also sometimes see hung_tasks in fuse_lookup()->fuse_simple_request()).
Supposedly (a theory) some tasks are in request_wait_answer() under
PAR_LOOKUP, and the rest of tasks are waiting for them to finish and clear
PAR_LOOKUP bit.

request_wait_answer() waits indefinitely, however, the interesting
thing is that it uses wait_event_interruptible() (when we wait for
!fc->no_interrupt request to be processed).  What is the idea behind
interruptible wait?  Is this, may be, for stall requests handling?
Does fuse expect user-space to watchdog or monitor its processes/threads
that issue syscalls on fuse mount points and, e.g., SIGKILL stalled ones?

To make things even more complex, in our particular case fuse mount
point mounts a remote google driver, so it become a network fs in
some sense, which adds a whole new dimension of possibilities for
stalled/failed requests.  How those are expected to be handled?  Should
fuse still wait indefinitely or would it make sense to add a timeout
to request_wait_answer() and FR_INTERRUPTED timeout-ed requests?

