Return-Path: <linux-kernel+bounces-566204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87FA674D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ADD3B313D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A02080E3;
	Tue, 18 Mar 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nATSPoQP"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313AB20D4F5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303976; cv=none; b=pitu3x42Gj1LYGk6d+P0GfeQPCMHYiUCUkeH6izhPfW2iIpxIK3eYZqIuJ72hH5OnV8NEoQvOA0AZx7DCp5i3IDThuNQDpelTjBkiAz3CDZkNjLmSvI3y0QkbZ7nfus5vXQqoVYhZ1ChixeOij2Vc/higQnE8fFR8WvmjB/Xaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303976; c=relaxed/simple;
	bh=xtVjxeR57GowxzypB8yIQa1TkgnQW6NgiPkaxFWelL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3iXpMaqK0mpTTFV6mPGf1FhI0cleLLM/0rl58Z7eHeF1Vxnl+3vt1F4865UOCzp51GxN4VoAds9wiE015Vx2zYSfua7uhNI9+fGfH4FbphKVAdcOLbam/VBmmc7Wjr+sHaeiosjNR14STh+5EePqA6pqo6rWd1qDWk2a6bvjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nATSPoQP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-226185948ffso40139885ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742303974; x=1742908774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciKBTMhrTNIAwAunPC9pvKe2rqwBVkggfAdVsShdNfw=;
        b=nATSPoQPoJCVuT9r+2PYZ2xWBfqCHjFBcrSjoIjkqBw7j7ghhNj70YxpN9jfYuWCr3
         /7c6loPN/CgRPfT8frJrge0vyTytpKmfs/Q5QfKLq2tz2uTSYUBhgWMa1WKdViT2EfFf
         efxFxqURb7A6ihacqxgvepyL/6eQGwH3TaUBfVUtkHHIdMJB8pcpaXjN0EiIXs40cTOY
         +oQhmJo5pq9ARHxWSU9xO3SbyrjlqpCPO7IB3MOPQrUqnhWimZJmdbDILka85NcshkB3
         Wnht3HH/Zj0o/z8793USFRyfy7FSo2vkoy/Owa6M4u7qKTux33LeWi4lJXNSzQ7aBIY9
         ep2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303974; x=1742908774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciKBTMhrTNIAwAunPC9pvKe2rqwBVkggfAdVsShdNfw=;
        b=fVKrVS/I2XFraaPLewJfGaKNezjdET6uHI+hv34zJdPz3Te5ADTIgxJKafCVFKt6ow
         XaM1PXpJRV9zS3fdkZqvrj4NQ97fCM5CuXL+2jwQfxzQ1YvS50TWYjfLqwtqskxPGltL
         x0l+EiAkpiUrlo3DW2CL1ckc/fbt6dPeaewUs4nHQiMagK1E8v9UjHEpOP2ogXpqmYO6
         jlvUVTvhrXbwQv4D7wjc0qvTTN0qlwEdK+jpebXcIb3ZaENcwHdphLhA7qcEvu493YX6
         e1gLE9JxxMz4/zc9SvxQ+QsPYz/3rlUVT0gUVH89NbIk+pejPDjXSALze6b1ryj2GZjr
         UkMw==
X-Forwarded-Encrypted: i=1; AJvYcCV77ydHR13+UM9DKd9k3Es0uBc1y04ELg1Y0hBijjn6tUEjmqvpXZAMlWjgzirgYw5R+q6HZTQXlJ2f/AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7bDIgu5Lg2nkx2JZ6J2Yhxm+v1DTnTZHI92e10fxX9AjYrOJ
	qQDgDmRgnOrkIoNmFoW16DxI9nqpiNd7R06y2mDXdKQ9yXcDGONXFUO3lBrWcHI=
X-Gm-Gg: ASbGncsoxsx9V9BWi34QnB6LOmmHWslDpI7J7tGqY01hwDZjVeGFHXxDL3ikIiWj3Yt
	fbY+SDy3O45IDwKagfWVu9xqc6KLuKhF4iNHoDbUWO3qxwUuJ6pSfAbwivd3UNQJQV7M0izLAgC
	A3XQ/jkf5EkFmFDiYm4gdh4wcz/ZNmXU5UwjhqmE/iMDJea0tlVX3ytP5aA+6ME9cyAC0sEMFRm
	B6HIxZNjGxlZ5EG5bIKeIUFGy5GOeAY2QCMxXC0kguftxyTYCBhgkzpwxhLIb7oX0ppV+yir3pX
	PNaCDTUQnjuxNfuPomQ5guFhDRMMzXr3Z2GIUAFVTg==
X-Google-Smtp-Source: AGHT+IEGhoTxzsJdPHXpMJwhvk5arIo+nzvTx/l2ZiSw07Z2Knppa9h9oRSci/7G9rCpzmb+KAK03Q==
X-Received: by 2002:a17:902:e801:b0:224:c46:d167 with SMTP id d9443c01a7336-2262c539b94mr53342395ad.16.1742303974447;
        Tue, 18 Mar 2025 06:19:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688d9eesm93737005ad.35.2025.03.18.06.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 06:19:33 -0700 (PDT)
Message-ID: <17154add-faf8-4150-bc07-57e07b5c9ea7@kernel.dk>
Date: Tue, 18 Mar 2025 07:19:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/5] introduce io_uring_cmd_import_fixed_vec
To: Sidong Yang <sidong.yang@furiosa.ai>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <fe4fd993-8c9d-4e1d-8b75-1035bdb4dcfa@gmail.com>
 <Z9kjoFcHrdE0FSEb@sidongui-MacBookPro.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9kjoFcHrdE0FSEb@sidongui-MacBookPro.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 1:41 AM, Sidong Yang wrote:
> On Tue, Mar 18, 2025 at 07:30:51AM +0000, Pavel Begunkov wrote:
>> On 3/17/25 13:57, Sidong Yang wrote:
>>> This patche series introduce io_uring_cmd_import_vec. With this function,
>>> Multiple fixed buffer could be used in uring cmd. It's vectored version
>>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
>>> for new api for encoded read/write in btrfs by using uring cmd.
>>
>> You're vigorously ignoring the previous comment, you can't stick
>> your name to my patches and send them as your own, that's not
>> going to work. git format-patch and other tools allow to send
>> other's patches in the same patch set without mutilating them.
> 
> I'm just not familiar with this. That wasn't my intention. Sorry, Your
> patches will be included without modification.

Assuming these are from a git branch you have, just ensure they are
committed with Pavel as the author, and git send-email will do the right
thing when sending out the patch.

-- 
Jens Axboe

