Return-Path: <linux-kernel+bounces-313294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF096A352
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8C5281BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA9188929;
	Tue,  3 Sep 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cuoUFfXh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643C2A1D3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378707; cv=none; b=C6zIHSNcFJueXOgBRsbUQEmv6/F0sqKrDsS4r1TVp+7oq1TMwemjDsK3afnLEAqkwdl6rpjJh/SvN7PM2F81vP7goQ0cWoLLWcRwLXUOfIhQ8B2FLtUlxIcne3jS15cLIzTaorFiGMmHBmlYjH/SHTebs+nd33bVCIhgnuWY5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378707; c=relaxed/simple;
	bh=dsBOFhgSQ20VWG9N7TaQ72g5Xti+njXE2CMMbkMUqhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbmzW7oCYna9NOkWz3f9em9PUrCyqWovacJC3CxetKlROmzvRvlbGNBFekA9UrP8JMcN6HuPVJI7gx/9T5z/djt8VqDB0QgHjA6dOOXUi+Zda4z6S+H4/oT13grUPQQg2APbpGmsJghnaDFn24StdsuP7hXPo5O7Yo+zZZAxgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cuoUFfXh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fee6435a34so39260665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725378705; x=1725983505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CTJ70oGdDlKxwej4nIFhqzlt6kbdcbSl6hDfUkSTBo=;
        b=cuoUFfXhzoQiaFGPCDhtSDbuKUF9c3ceGsJjLD1nylbp0aV7iDbQRcgJQ0Tw8r2wSU
         oZ6bNKMWCimvLIp4Vlga5cday2rkJ9iB5sy7EwTwSnGBN+xH+B760XzzuQCTmmlEGoYv
         8SUjc59rZ+mJKRKh1nFgXVq4P09945MtbtCUy99yJgbZneblxJOfbhm6QkZi+FdV1l1E
         2ycXAAj0Yj3+7AwvOeGFOjwfWbhbX4Ccbyj8hc15mKy1mPUEXZYag2Tj/bnRsBTIhrDx
         awQ9RI7ITLS8kI01Rp04gxg78rgchBBaPwMGSr54KR84vZWRsV5I/1So5B0gCUjyOMsF
         9p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378705; x=1725983505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CTJ70oGdDlKxwej4nIFhqzlt6kbdcbSl6hDfUkSTBo=;
        b=hjZ5ORXMFXS699vBJ3CQ43Y9dcL61eFzT1j38r6YgB06n8JwnqctELoUqC5MaL2UG9
         FUUPQIEf6cvYVXyjo8kuehewPhTGvhBX4QSNscN13pqkzb4+wT73XLXGbJLSs9Zmp+06
         Mp6+f1YTKMXPYK6AFPFeADbDXnjvH0jFMDd/kBOkevy/Tdb4XVRpxCcAZ50/52DgLtu/
         DtCv01QzhKtaBXUgKuaBDsmvP4rs3L30AzVUFh1GL0Y0B48hkXvHAWbXZI8Panl1icbT
         47onCTMQ/j1/K7q7dgBlyZI+RDjNf9YQXsE7EuRNpYx8ExMV7g0I7l4vQxLMOQTawvbF
         vEOw==
X-Forwarded-Encrypted: i=1; AJvYcCWxbwL4qaJ3R9+YUWISLHIg4nAzRyLn3mwN95UJ4w+TxItsyETcXgdD85umAjCDY86DRcdJ+yZVmoedinY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZtY2EK2MzmYliXkiKwpnj7/j/d7oZpv+vYZ7QQWnyKX/WDQL
	eEsqOI5RhbGHqIU0hSi8Je06BNUWA1Q0cW/xJiyU5l+ggkfp8P6lXa+wCud41Qw=
X-Google-Smtp-Source: AGHT+IHNCkFTZ+tQgNCw5YR4zc40yXygu4dQL7fmOyGsHVTkN9zbIFM4qpX1e8RQjgG7bMszJHZFJg==
X-Received: by 2002:a17:902:d4cd:b0:205:3e6d:9949 with SMTP id d9443c01a7336-20699b36168mr29065275ad.52.1725378704682;
        Tue, 03 Sep 2024 08:51:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea384e1sm136775ad.145.2024.09.03.08.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:51:44 -0700 (PDT)
Message-ID: <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
Date: Tue, 3 Sep 2024 09:51:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, paolo.valente@unimore.it, mauro.andreolini@unimore.it,
 avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 7:03 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our syzkaller report a UAF problem(details in patch 1), however it can't
> be reporduced. And this set are some corner cases fix that might be
> related, and they are found by code review.
> 
> Yu Kuai (4):
>   block, bfq: fix possible UAF for bfqq->bic with merge chain
>   block, bfq: choose the last bfqq from merge chain in
>     bfq_setup_cooperator()
>   block, bfq: don't break merge chain in bfq_split_bfqq()
>   block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
> 
>  block/bfq-cgroup.c  |  7 +------
>  block/bfq-iosched.c | 17 +++++++++++------
>  block/bfq-iosched.h |  2 ++
>  3 files changed, 14 insertions(+), 12 deletions(-)

BFQ is effectively unmaintained, and has been for quite a while at
this point. I'll apply these, thanks for looking into it, but I think we
should move BFQ to an unmaintained state at this point.

-- 
Jens Axboe



