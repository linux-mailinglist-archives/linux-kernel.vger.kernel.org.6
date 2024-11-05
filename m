Return-Path: <linux-kernel+bounces-396694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7DC9BD0BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427E4286782
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499F13D52E;
	Tue,  5 Nov 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1oEd/DAP"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285F7346D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820998; cv=none; b=G0P6VaUIfeFeweM403baXzWs28MAImK2E4eGyflQ0Gy6uFgHgwQcZauoUObkOJepQfNlSyuxWgVmz2rd8r5zPzHOMwRvdV+UBX2RSbuuyMP10CzvvQDHFEZ8zARsjCKXdSGOys/FFzwMEv52B+/fA4QKrnTmD3yxwkb+ogIoAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820998; c=relaxed/simple;
	bh=3qOAQweVx8go/6a8DGN19gQKBMpSOFnPNCJ71Hhovok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y57jk4bVBc6kfwnSQKDTxf63qsgHQwWBHnby3Iz+wtqyus5W3FNhpJHjNyWnuM3iBL0RMH0SB95J7XZzs412LVba4Gnx89YIk0zNav57Md4dNWPKq8ylHMbP0fDwZSJ02QIjpVVd20Lo0trMvtJTiJeNYBVG7kWfvElf4kyCOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1oEd/DAP; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83ab6cbd8b1so222109339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730820995; x=1731425795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmLLpOa66xKN7e/dPjNSt+R/ElYlNs09AMsOIw/+QDo=;
        b=1oEd/DAPpX2Q/Tj/+iitfsorCzsiZA4uUk4/fjtphFjzlCQzM6zOZRnTRA2B2ntwkw
         Y9nC0Qe6q2TlITI1x0uSWPzfIXL6yy6BiG/3jxn2AkQiqqzuRr0O2NMrkgMFsNlhh2Hm
         1l8gFuTVGZ5VaMfWi+5CknBx1HuUSwPBPUT/8hwB+qR/76vJwn1s03kCUcCbgi686Mss
         MpbscG+D0Mq3tPAxvCIYYr7OD9npjs9JmnQoexqaqJIxAn2Mk3Gs8jXiY/5GDBA22Wyt
         6BgzdtXcUKDmITaS+yJ7d9XZLYrPLwaKcjDXbkUmjPpcoGh/YnKxdUPYpln12e1vC7Q3
         pHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730820995; x=1731425795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmLLpOa66xKN7e/dPjNSt+R/ElYlNs09AMsOIw/+QDo=;
        b=gx+llZ2gkW3esrdjRlhqCMYmajiF8+Z2dPANtIXpALelApbHRU0cOMS9NO3meNMBMN
         odlE8lYXmt180TbAxKtWg5DTX6cz+s18vGfAv78N3g0/7UrIrg0v/BGBN1QsdfagcaLW
         x3qhWAPxP2LBuEYUQinLOClfg5DJU9kQDs+dEGHqE6F7XHQBf4wibiiKeNmrjGghqpgx
         z1X+uJBZZef42rdIywQuOEl8wo9R6LkbofJzSQ5WoycZGdHvJwfjHPxV9I7gwlEpujHr
         hbbkYKtIQOdgIV+ZRg1yGcooZ77kmcIZaAmaZFbGo+Lc3IJnCA0+VVFtkKL//AHYAH6B
         R23A==
X-Forwarded-Encrypted: i=1; AJvYcCWgM0HXeCC3+xL6LKO7RgZvut+14mTNcG9PhhYIy8hnu62nLbyxGv2nCaQXzkerzjw0Q5u2hMMyxfWDAMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JFLcG6N3Rfbckrv5/pQAkyvqCADinyBuL36Hr4Wy/65+DGxZ
	5pvfPFlcHKb9cYW4E0L8YGguFiuRCa0MBTJ/HKPvmCnfRZJWymnLdZaZJAHyDsc=
X-Google-Smtp-Source: AGHT+IGb4EKj5FtrVMRuQmc46nAw7b8SHqOu6tMC41J8+QExMoMpOSEGSHwr+Hvnk6c2GHfwyX8Ksg==
X-Received: by 2002:a05:6602:3f85:b0:837:51ba:60c with SMTP id ca18e2360f4ac-83b7196161dmr1254163639f.7.1730820995052;
        Tue, 05 Nov 2024 07:36:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04889516sm2472424173.20.2024.11.05.07.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:36:34 -0800 (PST)
Message-ID: <e86904d7-bf42-4b38-889e-3978e89358f2@kernel.dk>
Date: Tue, 5 Nov 2024 08:36:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test
 variation before object free at line 583.
To: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <202411050650.ilIZa8S7-lkp@intel.com>
 <20241105153422.GA7132@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241105153422.GA7132@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 8:34 AM, Christoph Hellwig wrote:
> On Tue, Nov 05, 2024 at 06:52:25AM +0800, kernel test robot wrote:
>>>> block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test variation before object free at line 583.
> 
> Does anyone know what this warning is supposed to mean?

It's supposed to mean "use refcount_t for things like this".

-- 
Jens Axboe


