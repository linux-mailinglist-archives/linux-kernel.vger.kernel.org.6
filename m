Return-Path: <linux-kernel+bounces-512071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF5A333AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154541668FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E4214204;
	Wed, 12 Feb 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="I9ZE+9o+"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255C2010E5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404538; cv=none; b=toLeBLVODjNuWgMv89mKbxRY46KtCxNdcERnQRVrEffpLRMmX3BTBUAxijewCvcEOdBfhHmyS+t2vUofw7d9b2p1ZmvWtUuBfiWiaUl9rEvvL9J9NapmxaIvBJ2+qWap++q+YuGrttDpznTHAInO+n/96e9D9CddhBQXd7TJIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404538; c=relaxed/simple;
	bh=BX2Vnm1dvN+dZi7mnduhrhCzZmg1hL39RaIgC960Fd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqTRLjHPJffDgWRVgiZKP4j5lQD7bb3Z3/THSRku9A0riDn3czQ9ZU9T8mD6QYLlSblhNlqmy6+Ys3HEyOp4L0as6rmn5A5WJ3Q70NprokVPbNnXC28l++vZcrQR4PhJdq28MHNF4S1wFaCQsgp8baBl0Eyp8I2Rj6/p7Ff8cQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=I9ZE+9o+; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d050fdf2ffso900435ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739404536; x=1740009336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5T5KWhJatXWshxJvkWL9bXGaHOpBQ3aVQM+8yUJxnE0=;
        b=I9ZE+9o+S3IEVbrhV1IB7OvF3hCXHavOvPZfVTtrzN/0g5jC4FCMLHhgU1pjxrrbLJ
         2QIyOYdsQaFLvSKl3IPWvVYh11xMI7xMtg0Lb75+Qg+PoCIkjN+XzaVqbetSdO1J6nmn
         JBn4KI+sqnBdUiYNn7XvMKsSWjD92nFraaWesaTukva4Lkxxc+25M98rjLHQhlK6yaU8
         /nEJz9oVzur0mki/8h8eEsgsWgdY03eWlpqLOyrX8WJTKn9ikj/wPG6f1mgswMQIJCkv
         PrkZjKSGRBXuTVMGrx2i1QhMjpkGLT62EC1utaYcbLiGu5mwJDdT3uc9mhNEYGfXzwod
         8cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739404536; x=1740009336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5T5KWhJatXWshxJvkWL9bXGaHOpBQ3aVQM+8yUJxnE0=;
        b=lap9ivoZbxhOxcV5uSP13/Haknek510csqZGJlsknCfscCE/mmwnU6mgJXXnJLRTsN
         tUWUV4drYUbjdetThapop4916enP9IjIz/tQtzZneAE/3YXQ9Dj/ZTQGq6YAZCi7ERsk
         +FLevqfTIDCeKfQmVaaHPwF0hzdzYzLQRpNdrSXtuY3W6qdIUVXRygPj6OeLNsn652K3
         SS4QzFJg01HhOkzsfwhPhmrmxJkehDoIkxW9EoIjoXQiNVjZrSDOUCvwMrkElYFKatRZ
         JSOTNpdobAm2nlymZ1uPrVBg9gbY3Ymdnxg/iQjiZLXG1vZ8aEvj6wIKn1tUoK0537k4
         VW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW6hPIKq53U1DNh+n84jkS/ogCyQTC3GonSmcLZefBgK72mP5incxnZK/yMEFyEzBAJ0vIirZVc5g5cCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeTTlbaeHhq2eSP/3f8kU+XCuUa49PYqYt6AAxcbClT5kkZus
	faByZsjlRlIo4kOfCcK92XCsEWd28WpmS4Djt/yI30wtX99eJbQef2T4rBLXDQ4=
X-Gm-Gg: ASbGnct6eqUD1jajM9DjVWL1jVC9odQ84EnjrIHFA6A6etOdUqShqXIoHeTtI1DUquj
	sSdLfrBj9HF2ReAM9HvjCBdjqL9zv7ZMqdVFHVP2p+Wv7Nl+ZeOwIkfcqPHoYfwrNOIRkgpspJo
	w0HTMEyBPXC8O9aSm5VjJEZVbju6/FkUoT+nx2YPSTXFEUre/6WvKxqv75EbTmGN/PaOioiCsOA
	nT3BMWqLJDikkbe+4IA3FVTWd5LXLSgfr1N8HFqmLpm1N6TmJhh3Whay0CZi3PXdgg2UFV/EeBi
	qHjv2Rnt5Qef
X-Google-Smtp-Source: AGHT+IHYFHt0UZ3Eu9kV2C1JCYy+xM/C/iX1RnaOCm9KoKnIXKw2eDtPqV1Vosoku1pEt3y6yf61rg==
X-Received: by 2002:a05:6e02:1c2c:b0:3d0:4d76:79b8 with SMTP id e9e14a558f8ab-3d18c0abe5dmr9464135ab.0.1739404535904;
        Wed, 12 Feb 2025 15:55:35 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed2816ee33sm50323173.31.2025.02.12.15.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 15:55:35 -0800 (PST)
Message-ID: <49382366-c561-44cb-8acb-7241d0b95dd2@kernel.dk>
Date: Wed, 12 Feb 2025 16:55:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] uring_cmd SQE corruptions
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Riley Thomasson <riley@purestorage.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250212204546.3751645-1-csander@purestorage.com>
 <401f9f7a-b813-43b0-b97f-0165072e2758@kernel.dk>
 <CADUfDZqK9+GLsRSdFVd47eZTsz863B3m16GtHc+Buiqdr7Jttg@mail.gmail.com>
 <999d55a6-b039-4a76-b0f6-3d055e91fd48@kernel.dk>
 <CADUfDZrjDF+xH1F98mMdR6brnPMARZ64yomfTYZ=5NStFM5osQ@mail.gmail.com>
 <Z60s3ryl5UotleV-@kbusch-mbp>
 <CADUfDZqa5v7Rb-EXp-v_iMXAESts8u-DisMtjdBEu2+kK-ykeQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZqa5v7Rb-EXp-v_iMXAESts8u-DisMtjdBEu2+kK-ykeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 4:46 PM, Caleb Sander Mateos wrote:
> On Wed, Feb 12, 2025 at 3:21?PM Keith Busch <kbusch@kernel.org> wrote:
>>
>> On Wed, Feb 12, 2025 at 03:07:30PM -0800, Caleb Sander Mateos wrote:
>>>
>>> Yes, we completely agree. We are working on incorporating Keith's
>>> patchset now. It looks like there is still an open question about
>>> whether userspace will need to enforce ordering between the requests
>>> (either using linked operations or waiting for completions before
>>> submitting the subsequent operations).
>>
>> In its current form, my series depends on you *not* using linked
>> requests. I didn't think it would be a problem as it follows an existing
>> pattern from the IORING_OP_FILES_UPDATE operation. That has to complete
>> in its entirety before prepping any subsequent commands that reference
>> the index, and using links would get the wrong results.
> 
> As implementers of a ublk server, we would also prefer the current
> interface in your patch series! Having to explicitly order the
> requests would definitely make the interface more cumbersome and
> probably less performant. I was just saying that Ming and Pavel had
> raised some concerns about guaranteeing the order in which io_uring
> issues SQEs. IORING_OP_FILES_UPDATE is a good analogy. Do we have any
> examples of how applications use it? Are they waiting for a
> completion, linking it, or relying on io_uring to issue it
> synchronously?

Yes it's a good similar example - and I don't think it matters much
how it's used. If you rely on its completion before making progress AND
you set flags like IOSQE_ASYNC or LINK/DRAIN that will make it go async
on purposes, then yes you'd need to similarly link dependents on it. If
you don't set anything that forces it to go async, then it WILL complete
inline - there's nothing in its implementation that would cause it
needing to retry. Any failure would be fatal.

This is very much the same thing with the buf update / insertion, it'll
behave in exactly the same way. You could argue "but you need to handle
failures" and that is true. But if the failure case is that your
consumer of the buffer fails with an import failure, then you can just
as well handle that as you can the request getting failed with
-ECANCELED because your dependent link failed.

-- 
Jens Axboe

