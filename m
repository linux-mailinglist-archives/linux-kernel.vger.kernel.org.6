Return-Path: <linux-kernel+bounces-512015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A5A332B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E42188818D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B3D204594;
	Wed, 12 Feb 2025 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TrMFcIVK"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DC51FFC59
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399656; cv=none; b=GRQRIlmKnWErBvg96IpDgdUSv68wMd6ikanVhIiNxDAIkOfNQ//EuHeWmRysVlu38pC9OkU43RAQqbHpxxJJcmJtIZq0kGYvRm/wN4D6r8kI9f7N/9ix6chPObpOL6Ym4djruX3MzB7tQCZ2o8u8uOLI9Om9PdDNdYA5UatTVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399656; c=relaxed/simple;
	bh=iI8oTfV4x3Xm93eIuNZRvXks7mKqu5m+w7wgua/5S/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtBAMaId7s+QDgW0hhvH9Qu36F53PkJ/Er01loaNktokC88xhZY0eapGnDp2V1NwkBfOkYlmzzlnC9lN/UQwMLav9SNeXKTKnbni8pi52gqWJU9Qr37Af24RFJmY61W66wOjDEY8y8VdzoWC+VkXH2TesA1DhVYzTDIFpgxsYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TrMFcIVK; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so14051839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739399652; x=1740004452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdWVN7dXCOa0o8E0xnUgj4zHQmXLVLq1Zm0R2oAFuGQ=;
        b=TrMFcIVKChUNoFKeM4a4fLDH9Cp6JFm+YldRWT87uF6VJPtaPtrA5FrhLJD+G5DUzB
         0hbxoUxFY8ZKhXPos012heZZwhmKJlvlb0drZ6hGkm3yODJMYImIxYzJl/cs2odrKKy4
         yBRecBPzogCwPnA3r2plIxMtFAq1jlvszQI0LrPZyaCHtCS4RXxNDZbkbiCC07BuoDkv
         y6dL0b129iPqbWPTtRgjG1n4pSCIy5FvbAlpgJf9NajC+v3uK8r0dwipiYo9kajh5bAP
         8FdAV0Ph7Bn/2WkDegW/Kd5EnSj5mFplZo8lSCXuFvMXlEBQgtUc7EJZs8W+mCLSDhqF
         rJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399652; x=1740004452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdWVN7dXCOa0o8E0xnUgj4zHQmXLVLq1Zm0R2oAFuGQ=;
        b=uU1QLgPld/gnlLWwnYR7KfXmbEloClugRgZZMuaWi2nZRXLwJPm/4VRNsW/IDGJa4W
         TGqPtF4DcFUXjDWR9OXGp3TxdzJANdaTIM4zr8gn17IUgjKVyaZkgpnyPbmRiiNOSZ+N
         GALUznpfTQDc3kto775J58l/ft+IfukO0vXvgqpxj9jw2hqSY+r/SvgbJd2L1kUq89CG
         Lz1fm2XngtopxjzR/EETCYAK3gqWLCU1D6+e4xvjZOk2fftZI/f3QEsidfLGLun1Tank
         1fDXM68s3Zopbt2Cf5n4rBoDF+NQGdh+CB9X2zkddPvOSjEMDD07BOiSe5c6j9ZgIG+1
         ICSA==
X-Forwarded-Encrypted: i=1; AJvYcCXw2T/XsOb0a3sIwHWOXe5LO3F0GHGE7yFVL95Bq1HqMxzGPTCY+xH8/2bSLTua/aRJHb3w4YvEY7qun7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvleAyo1ejoij5HiUOHFfGHvEk3IaOqhpC/UE7zl/Nc5rJBTK
	vhSP3tU+OzPjs09Oj9Q1Th6+FZlyoM0sHJS+108ya67LJQPiL4i2c386twySvoI=
X-Gm-Gg: ASbGncugu5PdOArH3N9eNXMn0POSrA4frchHQiHtKJ4jRps3t2MTdRX9NQgdPu/33kc
	nWAEKRo0P10YCE0PwgVbgQF+4ZlIsCzmqiS+bEB7upKQsQzaY/0IrijRXpSM46zxmlc9BR4iODB
	Y3DFKwB/e2xv0Lf7bHfM6MkxaZfDkaypOJ9w29qQRgxOCAu1+znoHRMe14hSOD68McS/M9ipLZF
	TKKA99fdWkyuYc7c8ZYhaDMyfQK+/VWikmW+icaLkWWLkqCJ9R3n52eE1/qZ9LApTodZ8RzdX/D
	a0cS9F0S6G/o
X-Google-Smtp-Source: AGHT+IHMpl+TjRIV5ZfN4Zt0lZhGHVSO11io9umn6Wzi1n1RjxU1Rse2BOVGsB8l5GQjDlP4aqYuFg==
X-Received: by 2002:a05:6602:3fd5:b0:849:a2bb:ffdd with SMTP id ca18e2360f4ac-85555cbe80amr571816039f.4.1739399652071;
        Wed, 12 Feb 2025 14:34:12 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282af37dsm15675173.85.2025.02.12.14.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 14:34:11 -0800 (PST)
Message-ID: <e315e4f5-a3f0-48be-8400-05bfaf8714f8@kernel.dk>
Date: Wed, 12 Feb 2025 15:34:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] uring_cmd SQE corruptions
To: Caleb Sander <csander@purestorage.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Riley Thomasson <riley@purestorage.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250212204546.3751645-1-csander@purestorage.com>
 <401f9f7a-b813-43b0-b97f-0165072e2758@kernel.dk>
 <50caa50c-5126-4072-8cfc-33b83b524489@kernel.dk>
 <CADUfDZroLajE4sF6=oYopg=gNtv3Zko78ZcJv4eQ5SBxMxDOiw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZroLajE4sF6=oYopg=gNtv3Zko78ZcJv4eQ5SBxMxDOiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 2:58 PM, Caleb Sander wrote:
> On Wed, Feb 12, 2025 at 1:02?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/12/25 1:55 PM, Jens Axboe wrote:
>>> On 2/12/25 1:45 PM, Caleb Sander Mateos wrote:
>>>> In our application issuing NVMe passthru commands, we have observed
>>>> nvme_uring_cmd fields being corrupted between when userspace initializes
>>>> the io_uring SQE and when nvme_uring_cmd_io() processes it.
>>>>
>>>> We hypothesized that the uring_cmd's were executing asynchronously after
>>>> the io_uring_enter() syscall returned, yet were still reading the SQE in
>>>> the userspace-mapped SQ. Since io_uring_enter() had already incremented
>>>> the SQ head index, userspace reused the SQ slot for a new SQE once the
>>>> SQ wrapped around to it.
>>>>
>>>> We confirmed this hypothesis by "poisoning" all SQEs up to the SQ head
>>>> index in userspace upon return from io_uring_enter(). By overwriting the
>>>> nvme_uring_cmd nsid field with a known garbage value, we were able to
>>>> trigger the err message in nvme_validate_passthru_nsid(), which logged
>>>> the garbage nsid value.
>>>>
>>>> The issue is caused by commit 5eff57fa9f3a ("io_uring/uring_cmd: defer
>>>> SQE copying until it's needed"). With this commit reverted, the poisoned
>>>> values in the SQEs are no longer seen by nvme_uring_cmd_io().
>>>>
>>>> Prior to the commit, each uring_cmd SQE was unconditionally memcpy()ed
>>>> to async_data at prep time. The commit moved this memcpy() to 2 cases
>>>> when the request goes async:
>>>> - If REQ_F_FORCE_ASYNC is set to force the initial issue to go async
>>>> - If ->uring_cmd() returns -EAGAIN in the initial non-blocking issue
>>>>
>>>> This patch set fixes a bug in the EAGAIN case where the uring_cmd's sqe
>>>> pointer is not updated to point to async_data after the memcpy(),
>>>> as it correctly is in the REQ_F_FORCE_ASYNC case.
>>>>
>>>> However, uring_cmd's can be issued async in other cases not enumerated
>>>> by 5eff57fa9f3a, also leading to SQE corruption. These include requests
>>>> besides the first in a linked chain, which are only issued once prior
>>>> requests complete. Requests waiting for a drain to complete would also
>>>> be initially issued async.
>>>>
>>>> While it's probably possible for io_uring_cmd_prep_setup() to check for
>>>> each of these cases and avoid deferring the SQE memcpy(), we feel it
>>>> might be safer to revert 5eff57fa9f3a to avoid the corruption risk.
>>>> As discussed recently in regard to the ublk zero-copy patches[1], new
>>>> async paths added in the future could break these delicate assumptions.
>>>
>>> I don't think it's particularly delicate - did you manage to catch the
>>> case queueing a request for async execution where the sqe wasn't already
>>> copied? I did take a quick look after our out-of-band conversation, and
>>> the only missing bit I immediately spotted is using SQPOLL. But I don't
>>> think you're using that, right? And in any case, lifetime of SQEs with
>>> SQPOLL is the duration of the request anyway, so should not pose any
>>> risk of overwriting SQEs. But I do think the code should copy for that
>>> case too, just to avoid it being a harder-to-use thing than it should
>>> be.
>>>
>>> The two patches here look good, I'll go ahead with those. That'll give
>>> us a bit of time to figure out where this missing copy is.
>>
>> Can you try this on top of your 2 and see if you still hit anything odd?
>>
>> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>> index bcfca18395c4..15a8a67f556e 100644
>> --- a/io_uring/uring_cmd.c
>> +++ b/io_uring/uring_cmd.c
>> @@ -177,10 +177,13 @@ static void io_uring_cmd_cache_sqes(struct io_kiocb *req)
>>         ioucmd->sqe = cache->sqes;
>>  }
>>
>> +#define SQE_COPY_FLAGS (REQ_F_FORCE_ASYNC|REQ_F_LINK|REQ_F_HARDLINK|REQ_F_IO_DRAIN)
> 
> I believe this still misses the last request in a linked chain, which
> won't have REQ_F_LINK/REQ_F_HARDLINK set?

Yeah good point, I think we should just be looking at link->head instead
to see if the request is a link, or part of a linked submission. That
may overshoot a bit, but that should be fine - it'll be a false
positive. Alternatively, we can still check link flags and compare with
link->last instead...

But the whole thing still feels a bit iffy. The whole uring_cmd setup
with an SQE that's sometimes the actual SQE, and sometimes a copy when
needed, does not fill me with joy.

> IOSQE_IO_DRAIN also causes subsequent operations to be issued async;
> is REQ_F_IO_DRAIN set on those operations too?

The first 8 flags are directly set in the io_kiocb at init time. So if
IOSQE_IO_DRAIN is set, then REQ_F_IO_DRAIN will be set as they are one
and the same.

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index bcfca18395c4..9e60b5bb5a60 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -177,10 +177,14 @@ static void io_uring_cmd_cache_sqes(struct io_kiocb *req)
 	ioucmd->sqe = cache->sqes;
 }
 
+#define SQE_COPY_FLAGS	(REQ_F_FORCE_ASYNC|REQ_F_IO_DRAIN)
+
 static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_submit_link *link = &ctx->submit_state.link;
 	struct io_uring_cmd_data *cache;
 
 	cache = io_uring_alloc_async_data(&req->ctx->uring_cache, req);
@@ -190,7 +194,8 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 
 	ioucmd->sqe = sqe;
 	/* defer memcpy until we need it */
-	if (unlikely(req->flags & REQ_F_FORCE_ASYNC))
+	if (unlikely(ctx->flags & IORING_SETUP_SQPOLL ||
+		     req->flags & SQE_COPY_FLAGS || link->head))
 		io_uring_cmd_cache_sqes(req);
 	return 0;
 }

-- 
Jens Axboe

