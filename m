Return-Path: <linux-kernel+bounces-354133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F0799382F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B7FB22C92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E11DE4F5;
	Mon,  7 Oct 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GTl0fB5f"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BB1D8E1F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332663; cv=none; b=gI4Sn9qaVS2CMEKnKCpYPSt+qAgHaLvxhFP/FeeDFMSjnm132UA6vu/2zeaOs0YWuZNn2Z6xzxTa4WU3+fhuee4wWXRp74RjkUNKWZ11w+nw/KmlfrUWb67dl8qiC6IezCVxhuByeLth2Owmv4x7GWTdTt8AjhYTsKuH37SlRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332663; c=relaxed/simple;
	bh=eFrMJn+r7yAiwjP4GWar9qWSolN90tQJqv1zWOC0Hqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFTqVGqAxRK00U03Sn7zu4LNZvYqirmcffxw3Hy+m0WDf+522nQRq0054xrKBI3hRzW7c5LU9IeeTnnXpG0EenvuCWmcFANgXRskawl4wbneb+x/Lr3pG/w2SklqHC348sdbh8wmXxc0C65S86dyMzAva5Wt74btWecIeOQinkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GTl0fB5f; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aa6be8457so144254339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728332661; x=1728937461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4R0Q8Ynq9cXqNLTXGL/5WGAJZrmHnh1RhSna/kYwbMM=;
        b=GTl0fB5fmtyYEwUeAbdsHH2N42MA7ATTdVVacvPNIIwGKoFx1QqOSTWHIw/Z0UixDY
         n277MAdxGOQrZ5cm+n8MyfDf+Lv3jYvp8+BwaArqyY9Ko/qWyKScJKdHY4FtbI4QTnNU
         c96x1gLZNH57cHzc+WdZt7MkgmVJrvWCnkhnm7Lj+jn45bWc79GC6L1yQ7KN3XAjULGD
         KvzZJ5Enu/FVYYF6JmWeixBtrk1n3I4zFhnT8XruQ+cjXNag1pW18jVR3/FuQGKP8l1+
         9Jg82Jr+lG2+CxXE+Hv16V8ajnstgTLNQTcFgpjx37xxjUugBN1ICl7jsUUdlW8I51XX
         vTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332661; x=1728937461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4R0Q8Ynq9cXqNLTXGL/5WGAJZrmHnh1RhSna/kYwbMM=;
        b=MOgaatoy4WaTYmNXnbL+mboecyz9u8F74GN7ueqlfzKVcbjA+g8EAWdXPHmsp9qJHh
         1xO4SxV3nE17JqDYcu/6+tUHS0vIIwK15iYflT3SK54nLNBWzepQ+paRCEsvp5BgIk1L
         bKGH6OLZv17dTBeJOnyWnM53RbiTgcmmedRAyC+7wBKqWMVl3eqRgtUQt3iB7W8OSY7C
         K/ugteuOJrJsN0cptqaaaNdoWZmVvHIckRAZc+JlYeV8lGloj+3+xAP29c8yYHbRcDt6
         B9k4/EK80fWnadzk88Eis76REhNE/yeGkZRwRGzVoxTE79dS1Vuvw78GMXyEK3edDYcO
         OMig==
X-Forwarded-Encrypted: i=1; AJvYcCVFcjtDrUfEgURMd1I+bIbSwNG9FwbIDsk+gtuOkCIj1m0nNoCmJLjmEHLQ6V4+pozCNVkV+cusgwvg3yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQL7hfjk0ZtMXd3uAmfYPLauhjLi6JejoGuWcX3/PUH/I/8+9
	w/H+JBZ2ACergTk1Ud2GT8Yp4Mi0rmkkjCf5FOOd0b+uTkSnY95vxa32Ib0r9SQsv/uWB9XNhpX
	+oYE=
X-Google-Smtp-Source: AGHT+IFTl0KjXyZKmlEYggh1fWpAGTxmbvzWf6VhNC9Im+t89F1PTG+ih+zXKZ95AnSreaFzI8qpJg==
X-Received: by 2002:a5d:87d9:0:b0:831:e9eb:dea7 with SMTP id ca18e2360f4ac-8352cf7fdf7mr69497839f.8.1728332660762;
        Mon, 07 Oct 2024 13:24:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db93964253sm118966173.55.2024.10.07.13.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 13:24:20 -0700 (PDT)
Message-ID: <4c310f0e-b677-4731-b827-df14b197545a@kernel.dk>
Date: Mon, 7 Oct 2024 14:24:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: Fix elevator_get_default() to check for null
 q->tag_set
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org
References: <20241004123922.35834-1-surajsonawane0215@gmail.com>
 <20241007111416.13814-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007111416.13814-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 5:14 AM, SurajSonawane2415 wrote:
> Fix error "block/elevator.c:569 elevator_get_default() error:
> we previously assumed 'q->tag_set' could be null (see line 565)".
> Since 'q->tag_set' cannot be NULL for blk-mq queues,
> remove the unnecessary check in both `elevator_get_default`
> and `elv_support_iosched`. This simplifies the logic and
> ensures correct assumptions about 'q->tag_set' in blk-mq queues.

For future patches:

1) Wrap at 72 characters, your commit message is using shorter line
   lengths.

2) Don't both with file numbers, they change all of the time. Digging
   out an old commit with line numbers isn't very useful, you'd have to
   rewind your tree for them to make sense.

I'll commit this, but rewrite the commit message somewhat.

-- 
Jens Axboe

