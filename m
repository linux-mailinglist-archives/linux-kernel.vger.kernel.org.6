Return-Path: <linux-kernel+bounces-264915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE293EA15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CAC1F21A59
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80D7D06B;
	Sun, 28 Jul 2024 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MXz/agCH"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5B5FB95
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206808; cv=none; b=ipHOIj7aBg3NZHKsPJPcoTJUqK/AhErJ+Zwzm8ywiWTwdNlNJlENzoD8r0L5/ARnPH511AoQ0f6Q4y6SMobqOetI/gJGP/WbcAQJet2d+Yg3ee/jKDe01pgETsuBo25jDOwQjoPmSGVjZ9ZxsyNQWNS0Krj51Frarrly0k+bN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206808; c=relaxed/simple;
	bh=+37D/4nCO54n90M/u+NZWBYjP0tnb9hWEUzfyevPfCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fDigM7BkpTKJmRGMmTupf9x2mu8rKg0bz1UrWtdLRkpHUgvD4ZlC5p4I648v8ImX4Do/Pgo2SYyJ1ua3Uy80AAWr6lm0RJrgumVOFsM50tV1nuGWjpAmRcc2OAlDRc9TvJ9xOttJ1FrK2/5twtS66S4euZtXpg6rKz3KDDkfndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MXz/agCH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2ff38af8so199909b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722206805; x=1722811605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Xqiho1AouRxLOnHmIj3zOU/N65RdIyhSd2t/vYTGc8=;
        b=MXz/agCHZbwi9DCKAS1c7J9CCTHBpGnNN/Vk8Ny5o44HRv0o9HAFAY0zmqQm39Dm5P
         Lk1EUgHBJncEWegHMxxDNcwdaUf0lnxBC/QBKt39WSIkg44em0Q0A+zPkmLOcRIeP1KR
         9TOgMuvVNBkcb3Owus/aHh0fhevA28JNgAg6TrFq6kJA5X2qXmzYUZoBhrt5Cbog8Zzv
         9DpZG52Mimj2dgyXyeepG8f7GMvaHUls9bHsjklvrFwsq3Wqx6TsygI8eP44EYa0F+OW
         68nC4r31603r5Q5BCoPoWM8Z27zJEnu/M8vmmWGeiTUCIsuBFA78XuNKJo1CFXol+a9m
         jOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722206805; x=1722811605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xqiho1AouRxLOnHmIj3zOU/N65RdIyhSd2t/vYTGc8=;
        b=tBvGOvtW98jWtYGc7Pak0SxxzNpQJ7bezQYmBeUyhI7h/ORQgcJUKxKAFQxRmK8XLf
         xk6hVxQ8uM2A+ms5iwWUhhT1CMy/ILS7tn5DX1FnVZzhADBUQeNhunQBL2varQi3i73r
         hejhvNsN0fa9V+RWg6we8sklO8Gzkznj99FJAPjy/0SJCKHbhFLGSi7pPJ0ft+xZ+1mw
         2yoF2VMhqXzKYE+t+mHrNFx74s9xsxlLWnsT2TDFyIZLM2BWKfksanD6YNFd43ssd75I
         s7aoMU0LWwxRh3yWpmN7HsMzZUXCWxWfMD2sOh/xkJHBb6fSbjF5zsjFfUaNmg6LBthK
         neHA==
X-Forwarded-Encrypted: i=1; AJvYcCVQSeHLRzQ1fpeQGYUtO0TVj0ffFqP89NWnwta2NRlnB2lbh1Hw/El55blsUsFgW5VOyB6JlRMEmhSiMpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWdYCMCJ3PQwlLeZMbAl0AL8sAAi6cgqhyyEj1HXr+pvOkLA8
	Qa5KJjJWO5ssixqoJGKjMQXM5Swde2avmTPD632RmtfJc+HCg3HneKjW+oanOao=
X-Google-Smtp-Source: AGHT+IHKg+a0YE3GUIxnhPOnInI/3RKPsutZEg5X+UAgetWdzYR/LDdMjPmdpFW1kUTtooMwSokq1w==
X-Received: by 2002:a17:903:234d:b0:1fc:4377:e6ea with SMTP id d9443c01a7336-1fed6cc839dmr83385505ad.9.1722206804553;
        Sun, 28 Jul 2024 15:46:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa0dsm69378485ad.187.2024.07.28.15.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 15:46:44 -0700 (PDT)
Message-ID: <f768298d-c964-466a-b8d6-ff0a8b4ca0e4@kernel.dk>
Date: Sun, 28 Jul 2024 16:46:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in
 ext4_read_inline_dir
To: syzbot <syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com>,
 adilger.kernel@dilger.ca, asml.silence@gmail.com,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <000000000000f70500061e55a074@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000f70500061e55a074@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/24 3:43 PM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit e5598d6ae62626d261b046a2f19347c38681ff51
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Thu Aug 24 22:53:31 2023 +0000
> 
>     io_uring: compact SQ/CQ heads/tails

That's obviously wrong.

-- 
Jens Axboe



