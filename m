Return-Path: <linux-kernel+bounces-234503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9191C770
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907861C23014
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00878C8F;
	Fri, 28 Jun 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b2zqS4+S"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CD7711F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607265; cv=none; b=MWEO4EAnFZnd+/CkCXxaG/1OKqXLVaUJkpcH/6D0p6PrOQhZM/e1LphwAuhyAtj6ugzN23XXz9FuDmtNlESQiQTB8S4VMuZ0qzEhdvtj7mBTcj0a8zswYWLvQPiaQJkZIFg9FMHv4eqZfTsp+HNRSLgoB3pX5wa0aRJIu1LbfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607265; c=relaxed/simple;
	bh=fHnQaHhbvVYwukowvzyMTqQ/4nywo2XtLLUCkd1xTGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dmlLmcq7KJbbwPDH8yWh6GsKoQtf5HZiuR4Ws/7kqpu/8JKMKtzp4AKovhB+Iy+oJnLRmNohuw6gz5rda0bgDmXFyScqbuWSwMIhkFTTficHvMUCuVZc6aqxgbYGJzHEZoCOdHbHaZTgG/tIbWf3rTESEKUchIdw7kezcNoTi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b2zqS4+S; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d566951f9cso52464b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719607263; x=1720212063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/rUVUWSsqzH+BwyS/RRWB/P23DUfU4JVXChiPPIMqo=;
        b=b2zqS4+SPROCwQXFh11p5Zjq9c0VrXTMrZ4tHHyd7Qlkyu5GF9c1CQA3u0TJHlyTxb
         X2BtKT0eoxef9CbPRSZzXAHarUDZUF/255gH1nUoxjuezRoSwmj/AoRJ4DAlwgh9+67M
         d02yAlL7r/jgdAYgpM2C6OZc8x7lT7fmwvnghO50E4WO+BL/OqiJIq3rObUHNmX7G4oS
         /zBQ0+gWLZYEkXW0hltHLnNMEWzUs/WdI4gY+eVuxLybmTrzltZi+lqqnXQC1q8IF8/K
         y/P/4dLJyYQfGvNfDjJ33UdkXu7e9E3Pdu/Lub3CkZA3o272LAqOyEytEH1+z2brPmxJ
         lpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607263; x=1720212063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/rUVUWSsqzH+BwyS/RRWB/P23DUfU4JVXChiPPIMqo=;
        b=KV9m0V2is8p+YdiJhbOE+9/dFH1FOutjgmZLLdUtuRJTiGtX9ET2hvJkkVxjDWXHux
         EnBlGXP/YujuZcEJStWFrU9IRIvd8Z6whLRR0mybIZjKrIugMe8T1do1DNKMdlOJHPBP
         gqZvet8lvXj0fQ6ZEyCn5M4AIS39gUOxFhVj6tqlOutEJnI9oktgThBU+qHnH3pG1Q3R
         V86ZJwn4OuG7eq8J2zVsCWbrAt/CnMt3ywRrZF47IhFD4D8CGbHiAJfDjR/j98h0vY4J
         81WN54yjSRctuxqu8tsPUg08U6eG2e1gsvkflhidcrez/6dBFEXV9jI6WQuIrlTm3i4r
         KuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Xnv5iPPSrNrDsbpN9OK/L0Ziu+eUctE2AnS+3f/B9iKh9g9gvYIA13vZ7StzwU3NIeUYYWhe9xIVEIQ+sTYHvXCs/XxlM7dNcuCm
X-Gm-Message-State: AOJu0YyTzGnq2kfqghF1lHiIcnnBR4XulW798FzSLgPv3iCOiOHtxzeX
	JW99d3cRgEJEv8V/jbMXCha2j2cc2mOoEnjfdwuj8kA+uDhqdbM5eiCoUXGfgf44K/Wz2MOl/7z
	SMjU=
X-Google-Smtp-Source: AGHT+IHzIw2ax1G02UjYSR0YVWZnApYeGUjzjAj0KGPvETJECW1JgcPGPnjXfe84BRsFEiRcUejzRg==
X-Received: by 2002:a05:6808:1484:b0:3d5:4213:82dd with SMTP id 5614622812f47-3d542139c8fmr21229204b6e.4.1719607262618;
        Fri, 28 Jun 2024 13:41:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62f9e9b20sm427802b6e.25.2024.06.28.13.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:41:01 -0700 (PDT)
Message-ID: <dc126f39-e5a1-4ebe-98ed-ec615f553bb4@kernel.dk>
Date: Fri, 28 Jun 2024 14:41:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] Monthly io-uring report (Jun 2024)
To: syzbot <syzbot+list9762eac493f50a993bbb@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000051e313061bf00dcb@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00000000000051e313061bf00dcb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/24 3:41 AM, syzbot wrote:
> Hello io-uring maintainers/developers,
> 
> This is a 31-day syzbot report for the io-uring subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/io-uring
> 
> During the period, 3 new issues were detected and 1 were fixed.
> In total, 6 issues are still open and 94 have been fixed so far.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 3582    Yes   general protection fault in try_to_wake_up (2)
>                   https://syzkaller.appspot.com/bug?extid=b4a81dc8727e513f364d
> <2> 16      Yes   KMSAN: uninit-value in io_req_cqe_overflow (3)
>                   https://syzkaller.appspot.com/bug?extid=e6616d0dc8ded5dc56d6
> <3> 2       No    KCSAN: data-race in io_worker_handle_work / io_wq_worker_cancel (3)
>                   https://syzkaller.appspot.com/bug?extid=90b0e38244e035ec327c

None of these should be valid anymore. 1 is ancient, and all the more
recent testing and reports I see of this are not even related to
io_uring, or the original report.

2 should be fixed Linus's tree, and 3 was fixed for 6.11 as it isn't
really important. But my two attempts at getting a re-run of those had a
failure on the syzbot side.

Please close them, thanks.

-- 
Jens Axboe


