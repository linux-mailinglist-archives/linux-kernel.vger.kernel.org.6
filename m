Return-Path: <linux-kernel+bounces-431899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 399729E42FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C53BC77EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20A6212B00;
	Wed,  4 Dec 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QiuW/xJ0"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FF21148D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332499; cv=none; b=spzJYRrnKgcj1WwLInJc2+u2MoshSHB5BA3rcBVYDWyxYSzp+Uh+AZ3rBABwQ1/uatIsLWsR45LcEUi5C69IrQy2d9LK7U3Ufy5Tx38hc4ur5wcTOfWG/5ID9Xq84EJpfW6HtHVk9ObCAB6PqonQ8PK1saXK2ov82OkEckXYVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332499; c=relaxed/simple;
	bh=oRh+4j/GgOIJhFfck3kU0IcbRnoakstTGeiTJ014bCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SW+Gs/nCiprjwWLN/W8Nzo24JDYLsiXV1kYv6WM9j9S+w7GOuFQqy/lHz8npCt862F1Z+6hbOdQvWgya3wRP/OiTUbJAvnXIz7QxJLoDHU7DQdPZqr5uQp9v42X8hOs8mNRjrSY6MUSu/09NfX0UWQY3AKvcthPpsVDwYWgkxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QiuW/xJ0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4667cd408a6so9958011cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733332496; x=1733937296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dzk90c0GQxgRHOCsDrxKEl9Uy8NC4dJyzqrN7VeRC2w=;
        b=QiuW/xJ0yvyihyeGShcIJ+A2aAKIUy382CoJrCjscjaVLjCRwghLzzvzktkavf44+v
         SsLn3poPGo+8j45HpBLQsWteKjS+M38yCTOZ++zt0Z185ucd1sAlySIqYz22BSaEE6Sj
         w2JBrkkTKCp2c39nwNp8Vdo2U2GaPvvzl+L7ECch851mwNDiURoVtNbQtLGPGnPtsSOt
         hYwyY4SkYBjs1dBmNAzDJ2XSFoy4hQHIEY6hkBhPB1yjRdyQxGtVqqgh8jZfZjSfLTHW
         2RPasxGxvqXiQjDopv7oSYpUGg8ayJfIzUf9lWcnL2MyJtoUWOa+adO0kJImtMJ3L/2e
         XXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332496; x=1733937296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzk90c0GQxgRHOCsDrxKEl9Uy8NC4dJyzqrN7VeRC2w=;
        b=F3WFcQp3CimsFGh2SnI6UKURAtehY8SyJnSYOkvS/6Jh5tJoThYfhRVc1z4bf8JEnT
         l0o9b3gZ++ITP68sStnpwTWn+mSkrCF5hXlilxSed5RPBjfFhMoPtotlkgzCCAmQJPPz
         gK49rfIrDau7jZQJg7QR8w/T5a8AWtqUOBBPNOwjcJDVSJ1z2CdofOnklBPct6WBRoc4
         ixJ0/0gMHgp65MTM8wT5FLGLe0JlwT/v/aty5WmVEEn3WQN8JUsEbdD0zkn4x2LNj6df
         MxIFdxYqDlvhR/sDjKnZm+j+FRS6KpV/UOh8zzO7op8xoPMh9ILcI2VQzzUJRh/kXTSO
         0p/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMW9sIkxPhBwbsrXkQzgBy+LcW6tsnguPHzx0Tch/QewBr421a51gYbSezDzbbAJC0lE4NUnUF7itSTj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyNju3Ltp1u0Ac/cdqZgYbIARLEaDNvYeGsmMHWXLYjrpgxfq
	NAokzN2+5aCUoKjPXU9SRcwT5tTwy34NZsif8e1GG8srmGGpw9gVv/E7INf1kQfhv3lJZvXGlAv
	e
X-Gm-Gg: ASbGncvcCK6ICX6p/eO3ElYhZ/+oFi1jad+my5Z2KeTCoxRjTS1x+gk6HvAF0/RuLwc
	epR28aAB3B706bAHsQ4Qtx4oTE9e7BZbukpBjUkkHlmEVLoPDgcT9j2p7KqvLqopuEFaahkBIqI
	6htPAsv6Ds4PM20mUCKiBROKm7Mda8BEFMC/CjwDErhj8tkBaqzOh1hmP8hc/FxjeRfWYns2iwH
	jQn5EZXOp8HBxcewo9cFAT6wCVXyADVVhCdqVUGGqDHkqzRLVTWDPfuIw==
X-Google-Smtp-Source: AGHT+IHBt5UzfAv+PxR3SAoeVjIi3Nv045+sXhtCM1sXI+ESypaB+D6z7xn3nscOvrxNGu+pH9IrHg==
X-Received: by 2002:a17:903:22c9:b0:215:58be:3350 with SMTP id d9443c01a7336-215f3c69d29mr2273995ad.8.1733332485916;
        Wed, 04 Dec 2024 09:14:45 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215714b4f77sm68395025ad.202.2024.12.04.09.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:14:45 -0800 (PST)
Message-ID: <9e8ccb61-e77a-4354-a848-81242625658c@kernel.dk>
Date: Wed, 4 Dec 2024 10:14:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_sqe_buffer_register
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67253504.050a0220.3c8d68.08e1.GAE@google.com>
 <67272d83.050a0220.35b515.0198.GAE@google.com>
 <1ce3a220-7f68-4a68-a76c-b37fdf9bfc70@kernel.dk>
 <CANp29Y5U3oMc3jYkxmnfd_9YYvWK3TwUhAbhA111k57AYRLd+A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANp29Y5U3oMc3jYkxmnfd_9YYvWK3TwUhAbhA111k57AYRLd+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 10:11 AM, Aleksandr Nogikh wrote:
> Hi Jens,
> 
> Just in case:
> 
> Syzbot reported this commit as the result of the cause (bug origin)
> bisection, not as the commit after which the problem was gone. So
> (unless it actually is a fixing commit) reporting it back via #syz fix
> is not correct.

The commit got fixed, and hence there isn't a good way to convey this
to syzbot as far as I can tell. Just marking the updated one as the
fixer seems to be the best/closest option.

Other option is to mark it as invalid, but that also doesn't seem right.

I'm fine doing whatever to get issues like this closed, but it's not
an uncommon thing to have a buggy commit that's not upstream yet be
fixed up and hence not have the issue anymore.

-- 
Jens Axboe


