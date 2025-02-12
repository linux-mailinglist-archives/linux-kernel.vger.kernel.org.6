Return-Path: <linux-kernel+bounces-511899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F7A3312F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B792E3A51E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210561FF5EA;
	Wed, 12 Feb 2025 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iAQ9fRTI"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1B1EE013
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394125; cv=none; b=tEZfaXTSRsU5qBLasbbcPBCfy6f5oL8UZ7uh/rJihYcr0fZIkD+zpVRrK/NI/FoWsROXXX3hiJyxGXWSj/x0gjS2OdCv9dmD4oDMex6Ro1IDrPyuVaPuuEutgf5yeKhcVsXhVq1jfhXQzJMW+weFkA4XPiMdLqlZaE27NszxzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394125; c=relaxed/simple;
	bh=37WHG0BZlPCXddrRTjVBqTDTx+dN7uo4aIbb/vw21ig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZSjK3JnYgu2OxJtRqV0bt3H88md27hayuomVp6jaLPGvYRQnE5cGNVVQ6KOwBW2AYlffstYd0UbBSzrVE5LrvYw4hUtA/xbPLfNikaYtecMaOvC36UIkPacQcFwBPPgpprXruQQYPGcXYYTN0NrqjckIsVqtALihkyRo8sG9Pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iAQ9fRTI; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-852050432a8so4522939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739394122; x=1739998922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2qVwVfu1lfq9SDbxbqN79ICyHcSg4LU3QV0l4opQl0=;
        b=iAQ9fRTIw7hHjxKOrchnyQwISbLAxz10VNPriSbmMtds47J0uCnpCF7kR3oCrPdHvu
         CHIHCQ5nY469+fCBeFz5Y4u2IAp7sg6KGS5HHBb98HVb0q+cEKGmuqs80kPZKX2eyNnM
         iOZgHaKAJgF/uKGT27DpwRkuBo+Ng6hBsX+JvC/Nlb6xzzV8b3FQbv4+31FyVfbMakke
         3Yp8nZZHXvgFQ1RqsV8f23k62agSgrIJf5n5idKOCt400fc8iAxkdp+xAin7UDeu/K2O
         cqxRIE/59N4fUZIm/FEJwLSIqZwyUW0ZDkDSFfJll10bDJBnM06iq65x+zLWyMYBz6Vd
         8Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739394122; x=1739998922;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2qVwVfu1lfq9SDbxbqN79ICyHcSg4LU3QV0l4opQl0=;
        b=NEs+2upbi025TxIN1X6hh8ThHup5nylVsGYzILoAEiKxgBjxJml/EWqXhM/bGYFjUh
         YM4KPU4SC0GVyYgU5IHH1w+1WUOyPGRY/bA8v6zRW0xjvC42YAvOLv2aJJLYdnbfvkZu
         5t1P6vosoEI6wzIJ8p4+W+M7g1rDK5pLXeDBKkuYSEp9acy6B8BVWiFnp8PT4mw0UxbG
         VHv+a7CSitMKwGDTie0WcTOhrDmKhDs4YERgfTmo4783PKMrq9ZUlODAkhrrVYB0RohS
         oIX6V20jHOriRx9Qj/vlMmPQYR/v67LnPHhX18hI+1TAJbuQ1zZ/GL7Dk57dYFIpYLW5
         Iiaw==
X-Forwarded-Encrypted: i=1; AJvYcCXoRZFZBgwYmKyF+FszclcJF5XG0+GnVgI405wVlsLhSY2kDe9pca9jmleHA2MOc2YWeE2E3BKqWV9ifFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMJUYGHEcVrcf/X2TQtw32r+cv15M4+KAb5WA8aQ+I1P/gc3z
	b3+Ywb1RacryGjSgHBXSiaZi+9oXKS9hVtAxscR7RXa9jxHDoZ+4xHv5/tNOloo=
X-Gm-Gg: ASbGncsK6tBEYBkYFNAQPjuI3/y8u5wXaB5lAVQz/rBb4IN2dM43ws168DtlRBLqb9X
	g7l3BVAt7rXI4eQzza3/xTYKqeLtKFAXNnLRKjWy4U3zw9V/DKHt6GdM6aNX4wN8diyusFEwu7y
	RKWVimB1Yq9OnjflHY+3OHbPL6EputnuEQCX23VNIZN2gBFrrlAqsBnXMSqY6Hhqdr3TZrOnl0f
	dWLlsecRoSjChHXvUHTM9rSUOKQH8eHCIhdXiqM6VQLfMNIY6Bdx5edWD2n0ifgQ5yP0aF251+L
	lOjZkwWmzXI=
X-Google-Smtp-Source: AGHT+IGvjQx0sAHyNOIQkle6qQTPtpxNNBhNT3fL29MqucbkBu5KPBkiJcSQxQwu/s/6Iuu+B10X0g==
X-Received: by 2002:a05:6602:6194:b0:82c:ec0f:a081 with SMTP id ca18e2360f4ac-8556528161bmr38148739f.4.1739394121844;
        Wed, 12 Feb 2025 13:02:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed1f84f281sm307907173.9.2025.02.12.13.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 13:02:01 -0800 (PST)
Message-ID: <50caa50c-5126-4072-8cfc-33b83b524489@kernel.dk>
Date: Wed, 12 Feb 2025 14:02:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] uring_cmd SQE corruptions
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Riley Thomasson <riley@purestorage.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250212204546.3751645-1-csander@purestorage.com>
 <401f9f7a-b813-43b0-b97f-0165072e2758@kernel.dk>
Content-Language: en-US
In-Reply-To: <401f9f7a-b813-43b0-b97f-0165072e2758@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 1:55 PM, Jens Axboe wrote:
> On 2/12/25 1:45 PM, Caleb Sander Mateos wrote:
>> In our application issuing NVMe passthru commands, we have observed
>> nvme_uring_cmd fields being corrupted between when userspace initializes
>> the io_uring SQE and when nvme_uring_cmd_io() processes it.
>>
>> We hypothesized that the uring_cmd's were executing asynchronously after
>> the io_uring_enter() syscall returned, yet were still reading the SQE in
>> the userspace-mapped SQ. Since io_uring_enter() had already incremented
>> the SQ head index, userspace reused the SQ slot for a new SQE once the
>> SQ wrapped around to it.
>>
>> We confirmed this hypothesis by "poisoning" all SQEs up to the SQ head
>> index in userspace upon return from io_uring_enter(). By overwriting the
>> nvme_uring_cmd nsid field with a known garbage value, we were able to
>> trigger the err message in nvme_validate_passthru_nsid(), which logged
>> the garbage nsid value.
>>
>> The issue is caused by commit 5eff57fa9f3a ("io_uring/uring_cmd: defer
>> SQE copying until it's needed"). With this commit reverted, the poisoned
>> values in the SQEs are no longer seen by nvme_uring_cmd_io().
>>
>> Prior to the commit, each uring_cmd SQE was unconditionally memcpy()ed
>> to async_data at prep time. The commit moved this memcpy() to 2 cases
>> when the request goes async:
>> - If REQ_F_FORCE_ASYNC is set to force the initial issue to go async
>> - If ->uring_cmd() returns -EAGAIN in the initial non-blocking issue
>>
>> This patch set fixes a bug in the EAGAIN case where the uring_cmd's sqe
>> pointer is not updated to point to async_data after the memcpy(),
>> as it correctly is in the REQ_F_FORCE_ASYNC case.
>>
>> However, uring_cmd's can be issued async in other cases not enumerated
>> by 5eff57fa9f3a, also leading to SQE corruption. These include requests
>> besides the first in a linked chain, which are only issued once prior
>> requests complete. Requests waiting for a drain to complete would also
>> be initially issued async.
>>
>> While it's probably possible for io_uring_cmd_prep_setup() to check for
>> each of these cases and avoid deferring the SQE memcpy(), we feel it
>> might be safer to revert 5eff57fa9f3a to avoid the corruption risk.
>> As discussed recently in regard to the ublk zero-copy patches[1], new
>> async paths added in the future could break these delicate assumptions.
> 
> I don't think it's particularly delicate - did you manage to catch the
> case queueing a request for async execution where the sqe wasn't already
> copied? I did take a quick look after our out-of-band conversation, and
> the only missing bit I immediately spotted is using SQPOLL. But I don't
> think you're using that, right? And in any case, lifetime of SQEs with
> SQPOLL is the duration of the request anyway, so should not pose any
> risk of overwriting SQEs. But I do think the code should copy for that
> case too, just to avoid it being a harder-to-use thing than it should
> be.
> 
> The two patches here look good, I'll go ahead with those. That'll give
> us a bit of time to figure out where this missing copy is.

Can you try this on top of your 2 and see if you still hit anything odd?

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index bcfca18395c4..15a8a67f556e 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -177,10 +177,13 @@ static void io_uring_cmd_cache_sqes(struct io_kiocb *req)
 	ioucmd->sqe = cache->sqes;
 }
 
+#define SQE_COPY_FLAGS	(REQ_F_FORCE_ASYNC|REQ_F_LINK|REQ_F_HARDLINK|REQ_F_IO_DRAIN)
+
 static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_uring_cmd_data *cache;
 
 	cache = io_uring_alloc_async_data(&req->ctx->uring_cache, req);
@@ -190,7 +193,7 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 
 	ioucmd->sqe = sqe;
 	/* defer memcpy until we need it */
-	if (unlikely(req->flags & REQ_F_FORCE_ASYNC))
+	if (unlikely(ctx->flags & IORING_SETUP_SQPOLL || req->flags & SQE_COPY_FLAGS))
 		io_uring_cmd_cache_sqes(req);
 	return 0;
 }

-- 
Jens Axboe

