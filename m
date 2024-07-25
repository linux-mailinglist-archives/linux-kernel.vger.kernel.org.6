Return-Path: <linux-kernel+bounces-262355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4A93C50C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C461F24230
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D019D074;
	Thu, 25 Jul 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PCQXhSs9"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8921E895
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918799; cv=none; b=e1CtzvJpm2Ee7g5h/Y/SaVzewP2CHYAFCZXdZ+fmYQNW8Ldz4S1bfWEtU9Wu0vVuunPW0Uk9wfBbkNxZtsDGmoslwcFtzc8nscjxwBQ7yMKDL+6cjxiZiBwF5UlBOnwUwHuOHsnCySokdyHogFblJEt0zQolJ4k/35KzUfrJjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918799; c=relaxed/simple;
	bh=mT9MNFKr7aPAgYb5AtQxuvxZh/ZL8WawfhwUBSoD+kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N8cgnZE00TQ3T7Ad3smXfeNvQ0SpMqxAjs+GYrPamDQw1cxl89mtYT0HdIdxxYhPA3yk91k9/WafcGV2zklaQ5WyYdGqwH04CWbqFeaFYsT3PAZ7qO366jCZ+Hd41CZVXHekPiRJlixCfBVdPL+tEr0gGRvCq1UeE1eXhOPA4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PCQXhSs9; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f3c804daf7so1992139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721918796; x=1722523596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJ44A6ixhFSJuEsftmBa7Xjp0gzBXl2+go4fssUyIos=;
        b=PCQXhSs9ZcXnCyYEtAsvfzs5JZVl6r9m/gfizQoQvy+ZZ2YEFTJaTEV/bEiUfzz5d6
         xqyP1W1REeVLNXZj0xlp51pzP4s2xvTBWu5mxDrmComg6D4Lof3OGDtP9yUm0SOpCRb9
         babTrl2zG1/pZL8+VkJg1KCtQ892ALaRyI7beMIXF49MwwVwhrD7qWgoBFAgZBY19BaD
         W1joZJI65+Ds7hQwxlLBco1SFfWtXyyd5s+KBIjIlN0Lfk4Bkn2jQ5Au3ImT6c5pnu4J
         77nYHLqngGy1p3xIjjscDgBDCs+amYNhgX3K0QrejE7whA9VJ4PYRIhtCM64v8fKk7qJ
         GjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918796; x=1722523596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ44A6ixhFSJuEsftmBa7Xjp0gzBXl2+go4fssUyIos=;
        b=ZoqA0gxWDF0pp9NEPe/XDg9O8ybFyxmMjOi87/sJK568qm99staEAWbZWW+e99pGQn
         ROZhs1eczzT2GjfpEItWCQbmYxuRukhii9mm3PNs3dQwPGZ60YweTosNxeqtQP9Aemlf
         SFMbp/JfScFZc9b13uPXTeKcOXRnkg+gxzEfsEefyCeiggRl7MLMRisa/lumu02EZ7qX
         WnXzLLdVZcr2/gTPcjORMgQ7qhNlGv4oa5HckumbKwPdlyIjMW3mCr7WSSG35u8/Gorw
         6U/8glrSO8eQLKYkPKWs5Pg1zJ8NeWeIH8usMibfsRL46uWDl1HVeG3zFeHKXG8FQCco
         8WFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8VTZMV5YW88gZ3OS4zmfG28lMr6OwYbn1NJ94ndfb5FSiIOcdah62cjlyA3vOdfjD8ThqgpFEszaotnPc3FUVh62Fm3Tn52vaW8fo
X-Gm-Message-State: AOJu0Yy3X+mOAhZ+IFjaFiifxQM8w0NkkURa1EreNFRV5zt2zl/wFlkx
	cCIToxO4eCm4cBtnSJ4eHArKhNPqQDIgD3rEjT/y+FG6ot3wRfse9xHwdiHK3cyc7saKbSC1EeH
	G
X-Google-Smtp-Source: AGHT+IGA9KwcxBUdYQDg20GqQAKCjSIkt0PdFqcrD+7PVFv1W533RWITS7rn/Jx4ssMY3sa3NjAzQA==
X-Received: by 2002:a05:6e02:17cd:b0:375:a4f9:e701 with SMTP id e9e14a558f8ab-39a22d22302mr19350355ab.3.1721918796065;
        Thu, 25 Jul 2024 07:46:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa5a0c5csm1086245a12.91.2024.07.25.07.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 07:46:35 -0700 (PDT)
Message-ID: <b8783e34-1011-4eae-86cc-9ba2b310863d@kernel.dk>
Date: Thu, 25 Jul 2024 08:46:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in
 io_req_task_work_add_remote
To: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a4fe65061e049a02@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000a4fe65061e049a02@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 3:03 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com
> Tested-by: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         c33ffdb7 Merge tag 'phy-for-6.11' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d29bb5980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f26f43c6f7db5ad2
> dashboard link: https://syzkaller.appspot.com/bug?extid=82609b8937a4458106ca
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=120b7dad980000
> 
> Note: testing is done by a robot and is best-effort only.

#syz test: git://git.kernel.dk/linux io_uring-6.11

-- 
Jens Axboe



