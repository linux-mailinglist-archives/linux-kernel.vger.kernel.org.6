Return-Path: <linux-kernel+bounces-577408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F4A71CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B3B189395A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3B1F8672;
	Wed, 26 Mar 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d+O+IyA+"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7E1F3B9C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008709; cv=none; b=oUopqfw74dQ56acSST0e5ixV8vKtgJArwIxmvNviqnqVBs4d5clUoiHjQUXa9lxeFUfjG9o/4+yAn9R/d9MmvgL5qjGea5d0Xqm4GxBc6o/P9gDwnarXD56Y1uDQoImG4S1rUCyO23POcaNRh9uLeCTZkqGSVPpSCHFsZL2QtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008709; c=relaxed/simple;
	bh=bJM/U2KIErHcbrpoSbkqV/L6KHKuSPxeK7SWuXRVQU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXOM6vv04aE1lsby9+mb83g1Z3GdTjl/tzvbj2XW45Spq5aTFDSoKV7bTUnjGMl1FSeNgaCJCg1y5+f7WlBBvXtGyreDrtSYKAdmp5T5ufkcGoBizbnOZMUM8zvjGt1hM2sVwExSdVgC/LIGWLGZsNDBGun/mFw7a/crkTuErVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d+O+IyA+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so5736d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743008705; x=1743613505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I73PY1mjkb5IFUpjGFh5jx5We9m1IBveOeOAn7WEGu8=;
        b=d+O+IyA+e5wMywypk4Gc+nNx1qvjR03WDOx342LH69RLxG1ES8KxU3MSjfvxuP+zEm
         C+m+ncxydXr6koOoJcgDmABSiLIEXTgK6rojZSPEuoPjknsQmenbwX+qDncIIzdhOSXY
         3M3GBSD+nq1+U5zBSxQB2e2OqFyUyG9nJWRHmiOF7pUbOFEGZMw0Jv/LgawTv8fSBiGv
         K+ZZHiKJam2uQh8O7HZph3XdL9i8xqmYM55xM24dWkrrAA3uOgPInCI2ihiSuYG/A2kW
         1iYmlmNRyF+bhtioWIgVQf1p/DE9kN4mp2GzbDNJfNgQUSgjaFAj43Bb3ErrFDBqQ/V4
         I+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008705; x=1743613505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I73PY1mjkb5IFUpjGFh5jx5We9m1IBveOeOAn7WEGu8=;
        b=AZnPkORl60rT3c+zZz2AvdvmgZRUyQfWcMl7VLLVdUWfeoXRZTuTh4ztHDBZWnCnXb
         tZ1b1r4iDGyybgvqNxojT7A9dqGZSPZFB2GxN/A9QgUn4xfoxa/1CDNqx6ydEVFeLGc1
         +IxtLADZmZwn1PJvl32AUF318kJ5em7KLOSVwpN2nwxEHp0QKZcE7+Ccyb6ehP6vCjhD
         0KG76F5OU/7nvznvTX2J3V3B+0JOE4QC+UYKtdHn8Th+1BMnxNsswWi2Jc46r+kgE20H
         vsaQuKvecGoKFxF4/sC6JQV+AVYAC5Dv6ZiZ6N1gfyuXf0eKSnsUkiR+SiGz/XR3Dc/H
         6Jww==
X-Forwarded-Encrypted: i=1; AJvYcCUN9zQJZtUJuoXBu7CQXjpLrMdqLC6UgAg7Yz+I/eOl7o74BwYMz6xe+PCpp0IqIltkQ27qxPhwvSCaR7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19LNP40BND2bonpnTsx+xu0KIqVp2waaoVYeI10bNi3hMQJX+
	W+Czoafpk0ws4mis0uwhbEZOu5QlR2ypwZEvwiW7Lfu4nE9q/aMXSXinA0FOCSM=
X-Gm-Gg: ASbGncsFv0O+1vv0HPBEGqBaIKgf0mxhFGjI76yjnV0nK1oWOYI5nUE7sPjdA/D8p3m
	AeQnJRtLMSnbgFXgv9t0t4eMg1zJa+LZL56BOHKq0zOCg3JBNCZdyHJjh0FSa/1q1mDJJLXc2YJ
	UOwvYrU3repF1LCh9dcwtow8nezri85kJmKh/O7FOq0A+XyrbJdCXLm0NEc7wcJc7pDD4slMt6j
	RzjiBtwD+6Z3u/hFlhlm2nmQWS858B2TWzjGZZ1KM39Ijj4BWtc/UIkPY1oFHlg8z41bLnQoeVg
	F4FbH06Zuo6d3MQ9kkVjVtVkWMyJRESoWEERiQQ=
X-Google-Smtp-Source: AGHT+IHu+Vsyz4EOtnj1TNh8JqfFnw1qNqrb8unnl7fgTesbDtUyjffDpeAqu2lE66Oahnty+UNLlA==
X-Received: by 2002:a05:6214:410f:b0:6e8:f166:b19e with SMTP id 6a1803df08f44-6ed23898ecbmr3304216d6.17.1743008704882;
        Wed, 26 Mar 2025 10:05:04 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef344fasm69659916d6.57.2025.03.26.10.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:05:04 -0700 (PDT)
Message-ID: <9770387a-9726-4905-9166-253ec02507ff@kernel.dk>
Date: Wed, 26 Mar 2025 11:05:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
To: Caleb Sander Mateos <csander@purestorage.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250325143943.1226467-1-csander@purestorage.com>
 <5b6b20d7-5230-4d30-b457-4d69c1bb51d4@gmail.com>
 <CADUfDZoo11vZ3Yq-6y4zZNNoyE+YnSSa267hOxQCvH66vM1njQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZoo11vZ3Yq-6y4zZNNoyE+YnSSa267hOxQCvH66vM1njQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 11:01 AM, Caleb Sander Mateos wrote:
> On Wed, Mar 26, 2025 at 2:59?AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 3/25/25 14:39, Caleb Sander Mateos wrote:
>>> Instead of a bool field in struct io_sr_msg, use REQ_F_IMPORT_BUFFER to
>>> track whether io_send_zc() has already imported the buffer. This flag
>>> already serves a similar purpose for sendmsg_zc and {read,write}v_fixed.
>>
>> It didn't apply cleanly to for-6.15/io_uring-reg-vec, but otherwise
>> looks good.
> 
> It looks like Jens dropped my earlier patch "io_uring/net: import
> send_zc fixed buffer before going async":
> https://lore.kernel.org/io-uring/20250321184819.3847386-3-csander@purestorage.com/T/#u
> .
> Not sure why it was dropped. But this change is independent, I can
> rebase it onto the current for-6.15/io_uring-reg-vec if desired.

Mostly just around the discussion on what we want to guarantee here. I
do think that patch makes sense, fwiw!

>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Thanks!
> 
>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Note for the future, it's a good practice to put your sob last.
> 
> Okay. Is the preferred order of tags documented anywhere? I ran
> scripts/checkpatch.pl, but it didn't have any complaints.

I think that one is minor, as it's not reordering with another SOB. Eg
mine would go below it anyway. But you definitely should always include
a list of what changed since v1 when posting v2, and so forth. Otherwise
you need to find the old patch and compare them to see what changed.
Just put it below the --- line in the email.

-- 
Jens Axboe

