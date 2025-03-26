Return-Path: <linux-kernel+bounces-577452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03606A71D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4BC189FD06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B54239099;
	Wed, 26 Mar 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QfS+Kf+m"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12BC238D49
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010315; cv=none; b=rvvScl9WsnKmqFjRbz+WJf6CY78hyB16Qcpv8lv+4Z3i2HzfbKuZiAu4DYW8dukDpMd2NPUwiKU6KskYfWGxCthmSQDGYwp/DnOqIUDuS/fcBuW3xKoBXpM9uH/A0ZgkdTHwWs39mecjcoYUrKOSYARPCZi9H28n5LGHKBnzCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010315; c=relaxed/simple;
	bh=ApVXiA9JPxeDJiY+bJAZzl9b29ymaQInYWf0uYBUIvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnpkUnFoNqDYyPG0uMzHXnGqVFjr4YdPwiBfks6R2FObfHCSMIa1t+ej0GECpDNbILNlahakMEllZpIqf6bQQYksfeoZ1VWG99hgWXS0R1RZiO3I0ljoUIR1MJ8mhoh/s4Ok0loQ3m/dRyAVL+ZO7j92EkqIUApj8j9mTeasAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QfS+Kf+m; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c592764e54so17927385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743010311; x=1743615111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkIulgoTL6tlyyzZtYI7VaNWhJbd+nkeEIRVTyUEc6I=;
        b=QfS+Kf+mystD2rnZVReDRZVVp5u4UXnwdTMdBCa5X04vCgxMINb7/eQ2qDN8mhu+s7
         fmVoPL7Z4C/lIe+f9zeM7IafqcWp0KKUpU1Bhf6BNDdEzalZOnuJIAEWQp9+V6O01fhj
         Y7pimAdw3oGvmLaHRD2N3Rx6K9WgwYKVjP916IxI2jYjHiKtoGk7wM5BhXDUlT4XVk/g
         4V6QWSDE/kCTQCF2w7mzSCfWU2AuTIO5lhXH+0Z2BOsJU+HLJmFTfBFbAGeo8GnNz2ys
         z0pxNYdZq8rsM1DUqZ26FGGTxXCNZvLfhERv2gblrfTUq0C9iXa5D5VvVxIvTWNx0Ak/
         oTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010311; x=1743615111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkIulgoTL6tlyyzZtYI7VaNWhJbd+nkeEIRVTyUEc6I=;
        b=tkWsDoFT0hhGEZ8OHxal1LoT6pUu2GDvk+m8T+vLH61Y2WbPdqQTUbvsiginX1vPBN
         DdOsbS5TmMJ3Ye0XTQZxRVs8JYwAuZJa2zgUFtisrWNygFNr407b+Mz2gulk/iUOsCL8
         LXENhNPJZdoKmAPgz0+rK3WvuyxDmW1pj23komeZ0bqUr1AQHYpAOsfxe92BILu0k9t/
         zYnVUHLy/sBdrqzlgf4Xu+wy1UNOt78GknwOj9uKYoURJ8i+t4h0n4yah6jC6zItpE1W
         vfmc6JkKBlErFuBq7/ZSMmGYdlNVcH0lMc+KEtkw4M4oFiKw46LMoTJpif8FpHVIaafk
         rGsA==
X-Forwarded-Encrypted: i=1; AJvYcCWL2M3pu3Ivkec8faI/z2MD8IU+H3VUL6xs74SbbIQMvtlpJaJlqX9u9YCon3P3mb4LE+8zcLg14a1YaZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxelf63F8vgDXNcWlwlUUcISfrWzlscPx4rzPMH1mmhEq/aCyF4
	47ibgdmcL+KbJpij8qsWMr6hh72uNnbB+oemosaQ+CzvWqNbBf8LIlTz8I6R5/90z/IfZkmU647
	ndXM=
X-Gm-Gg: ASbGncttjmPPygdFu7oGE9x5SlyycpMrXOXZa6jrxu6RKPXOaDxZyhUNaUI3QXwID/G
	qQIM1UMM5KFdDz9LyHWplUR7X79Hno/pt52c6YH7/krUScyYTWPRGpG1qQ2F2IeeiqBME/PmeyY
	Uh+kr5hN2lMxO6MlfSVuBb2OlMQ40pwnKRaKJgtriQ0FPGxsoPC2q/LlX4VIJmw9IirE7KLP/5A
	n6uycNEwvxdfudOddGnc8xPyNgOu4Pl9hJLc4AizIh4cgolWUTk1N8KEs9sHapGOdy8cQA/9xTX
	MZmz52jkVEvidEWRS6njASNbXC8SCkYbJOy1HJE=
X-Google-Smtp-Source: AGHT+IGcpvYp3s03Bz7oKBIO03FZbkxQfna6XvWcbUmCwGiU6FTlnxHk33r6KzJ7Cawr3NxN8yaEZA==
X-Received: by 2002:a05:620a:2912:b0:7c5:58b0:42c1 with SMTP id af79cd13be357-7c5eda12934mr74754085a.34.1743010311319;
        Wed, 26 Mar 2025 10:31:51 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d68dcsm786416685a.42.2025.03.26.10.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:31:50 -0700 (PDT)
Message-ID: <570272b0-4d96-4e98-bf73-e313cc49918c@kernel.dk>
Date: Wed, 26 Mar 2025 11:31:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250325143943.1226467-1-csander@purestorage.com>
 <5b6b20d7-5230-4d30-b457-4d69c1bb51d4@gmail.com>
 <CADUfDZoo11vZ3Yq-6y4zZNNoyE+YnSSa267hOxQCvH66vM1njQ@mail.gmail.com>
 <9770387a-9726-4905-9166-253ec02507ff@kernel.dk>
 <CADUfDZr0FgW4O3bCtq=Yez2cHz799=Tfud6uA6SHEGT4hdwxiA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr0FgW4O3bCtq=Yez2cHz799=Tfud6uA6SHEGT4hdwxiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 11:23 AM, Caleb Sander Mateos wrote:
> On Wed, Mar 26, 2025 at 10:05?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/26/25 11:01 AM, Caleb Sander Mateos wrote:
>>> On Wed, Mar 26, 2025 at 2:59?AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> On 3/25/25 14:39, Caleb Sander Mateos wrote:
>>>>> Instead of a bool field in struct io_sr_msg, use REQ_F_IMPORT_BUFFER to
>>>>> track whether io_send_zc() has already imported the buffer. This flag
>>>>> already serves a similar purpose for sendmsg_zc and {read,write}v_fixed.
>>>>
>>>> It didn't apply cleanly to for-6.15/io_uring-reg-vec, but otherwise
>>>> looks good.
>>>
>>> It looks like Jens dropped my earlier patch "io_uring/net: import
>>> send_zc fixed buffer before going async":
>>> https://lore.kernel.org/io-uring/20250321184819.3847386-3-csander@purestorage.com/T/#u
>>> .
>>> Not sure why it was dropped. But this change is independent, I can
>>> rebase it onto the current for-6.15/io_uring-reg-vec if desired.
>>
>> Mostly just around the discussion on what we want to guarantee here. I
>> do think that patch makes sense, fwiw!
> 
> I hope the approach I took for the revised NVMe passthru patch [1] is
> an acceptable compromise: the order in which io_uring issues
> operations isn't guaranteed, but userspace may opportunistically
> submit operations in parallel with a fallback path in case of failure.
> Viewed this way, I think it makes sense for the kernel to allow the
> operation using the fixed buffer to succeed even if it goes async,
> provided that it doesn't impose any burden on the io_uring
> implementation. I dropped the "Fixes" tag and added a paragraph to the
> commit message clarifying that io_uring doesn't guarantee this
> behavior, it's just an optimization.
> 
> [1]: https://lore.kernel.org/io-uring/20250324200540.910962-4-csander@purestorage.com/T/#u

It is, I already signed off on that one, I think it's just waiting for
Keith to get queued up. Always a bit tricky during the merge window,
particularly when it ends up depending on multiple branches. But should
go in for 6.15.

When you have time, resending the net one would be useful. I do think
that one makes sense too.

-- 
Jens Axboe

