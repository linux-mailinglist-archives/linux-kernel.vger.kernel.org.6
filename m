Return-Path: <linux-kernel+bounces-315192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A184A96BF08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68141C24A21
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF51D9357;
	Wed,  4 Sep 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WJ6w3pf6"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EC1D0169
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457772; cv=none; b=ELm8Qw2Pq2zkx3x6CFlY58Hx11m2Cx8VNcgq8IgCXPRoVTI/J4BZtgzo+gOwuaUvWkdFZftJ9Pqzr7z52fbQxuhcBHYYvNvALUSnJSctVNjdckKojRQ0e+VaczOv/xviss1hGk79teuo0n0n/9eauA3AxJ5FGvaqyCxwZnHhWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457772; c=relaxed/simple;
	bh=YMNwSkqEJW9uN7bSMftt+qatI3avzVnQiPt2E71884o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqY2XaJEH6Yv6JkW06jDtb4hSGUIearI1cJaewcP0hyhAj/z9Tv4PZCWCx0LM5q4ZDeiu64ZUM+SSaDbPHM2pc8RxrBWbDJEyeH7GTqVLuaFB3j4dvcHEzHYqgGH4bEM2ANc+jjPLE+GpMJmC8Xm8/PXkjiB8664mM4sKmmtopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WJ6w3pf6; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82a73aad00bso55868139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725457769; x=1726062569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3OzM6yNBga43RZi596yJbd4sFGmjuH68EJYXdCc694=;
        b=WJ6w3pf6W8VidYgqQ953quYRg0VvCiE/ixf2+h67LNBe0Ot2QZI/1TgIWEIJ4piM2L
         mfAC+w2YRvJxKtWaUvHxFtdH1exmdayQHPsu5+HTCuyEaQYBqjivjB6f8QQ05MhrGJQm
         YnfAPjq5TXMjHxdJzV18/htxDuRx9G0rub9qjtF04EhhlaHo4K3g2738KVAmsUkzx+Dc
         fOMNDL2JuS9hy8TiC3ZjzvZrOP7eE8hX4nbeRD5heka621SuN6zS3n17829WSLW0v+oe
         rka55tlb9pWROWbOIqUp4jIRaWRdePL7ItHL9ns0TPwYva/ilmVJWjQuKezxP7K41NX2
         DQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457769; x=1726062569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3OzM6yNBga43RZi596yJbd4sFGmjuH68EJYXdCc694=;
        b=vvW3iILnmOqQvOxrHI6mzavWaMmDkn8oSlURlYcOWJmRs3iOkoHHbLY0XDgFZ3nFYZ
         6ZyzzXQAbCi19FAZTcId4KXIUMubgXB1qnWaiFy35+TadkuFwrhiw1pT/F6nnXtLXM2q
         uG4EmTz3BJRf5vxMZToRX/T77MP0C9dzae+DXwi+xs+P4g78uWoNEuduHeHy6lJo2Lfd
         eNpkZfQDasmQEHk6jzFrnNsEf1zmsDoE9AWMrjBDPOQgvLBClVVPrOeSTOhImyVtNaMB
         tRFpS5+9kHmjlMZSJycbyOCSID5z27vB5gqVWZRpbfquZ489DAC/BsqGAtEZIpdnKMWH
         MJLw==
X-Forwarded-Encrypted: i=1; AJvYcCVXXrcXib/ig6IzyWSQwvuDfaowm8h9hDtpJJKRmhuoWlexZqMyc5goJEffn2X0AwJC/l6weQ3QgnOmY28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/GNF8gw5pIbjayC30NhpCdIhb7yIUdd0ZKsq1Eyqy6pKF92s
	seRYBiB3BHqz7dhXECNiWZGpGIayta+O/1mKyobcGAPT7q+jYUJIjpsdqZTtc0c=
X-Google-Smtp-Source: AGHT+IH2T9+Rvn5lvq34B/1/vEVjOaoiI5vLsNmFeQ2xw9WWhAETa9+lwOKBoTbedzjte9E4G4daJg==
X-Received: by 2002:a05:6e02:180e:b0:39b:3a44:fe8a with SMTP id e9e14a558f8ab-39f6a97897fmr86244235ab.4.1725457769293;
        Wed, 04 Sep 2024 06:49:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d05da81bc9sm351855173.104.2024.09.04.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:49:28 -0700 (PDT)
Message-ID: <c7d9d97b-991c-4b84-a99a-60473f8ce929@kernel.dk>
Date: Wed, 4 Sep 2024 07:49:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, paolo.valente@unimore.it,
 mauro.andreolini@unimore.it, avanzini.arianna@gmail.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
 <20240904122953.fkwyfsfwhrwwmnbs@quack3>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240904122953.fkwyfsfwhrwwmnbs@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 6:29 AM, Jan Kara wrote:
> On Wed 04-09-24 09:32:26, Yu Kuai wrote:
>> ? 2024/09/03 23:51, Jens Axboe ??:
>>> On 9/2/24 7:03 AM, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Our syzkaller report a UAF problem(details in patch 1), however it can't
>>>> be reporduced. And this set are some corner cases fix that might be
>>>> related, and they are found by code review.
>>>>
>>>> Yu Kuai (4):
>>>>    block, bfq: fix possible UAF for bfqq->bic with merge chain
>>>>    block, bfq: choose the last bfqq from merge chain in
>>>>      bfq_setup_cooperator()
>>>>    block, bfq: don't break merge chain in bfq_split_bfqq()
>>>>    block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
>>>>
>>>>   block/bfq-cgroup.c  |  7 +------
>>>>   block/bfq-iosched.c | 17 +++++++++++------
>>>>   block/bfq-iosched.h |  2 ++
>>>>   3 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>> BFQ is effectively unmaintained, and has been for quite a while at
>>> this point. I'll apply these, thanks for looking into it, but I think we
>>> should move BFQ to an unmaintained state at this point.
>>
>> Sorry to hear that, we would be willing to take on the responsibility of
>> maintaining this code, please let me know if there are any specific
>> guidelines or processes we should follow. We do have customers are using
>> bfq in downstream kernels, and we are still running lots of test for
>> bfq.
> 
> That would be awesome. I don't think there's much of a process to follow
> given there's not much happening in BFQ. You can add yourself to
> MAINTAINERS file under "BFQ I/O SCHEDULER" entry and then do your best to
> keep BFQ alive by fixing bugs and responding to reports :) I'm not sure if
> Jens would prefer you'd create your git tree from which he will pull or
> whether merging patches is fine - he has to decide.

The usual process is that you start actually maintaining it, and after a
bit of a track record has been proven, then add the maintainers entry.
Too many times people start by adding a maintainers entry and then don't
really do anything. Not saying that'd necessarily be the case here, but
maintaining first and then adding an entry down the line seems like the
better approach.

I prefer people sending patches, as there's less risk there for messing
it up. Maintaining a git tree may seem easy, but lots of people end up
messing it up, particularly as a new maintainer.

-- 
Jens Axboe


