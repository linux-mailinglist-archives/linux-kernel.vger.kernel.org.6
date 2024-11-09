Return-Path: <linux-kernel+bounces-402565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC69C2918
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3ED1F22CE5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648131CABF;
	Sat,  9 Nov 2024 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kj2UwPhz"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66AC8FE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731114777; cv=none; b=W+GCtrv4QzKfo47GYXXk3XomKlSvIg0K0TSNzB4Z7tIHpknVPRWP9kPpf6rRjI8bDCKCLTaZu2uXi9TiuqWPIhxyjaTTh5xMJHgd/CbFCVN8C1X3qwq2Ah2VIuX0yQ/VnKAObWIuCtpGRF2Se4Vz/Vd6zuBWZxZ+z/bwO5gMgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731114777; c=relaxed/simple;
	bh=1LIOUNfKTXWim4PdquFX/WgW9IMIdu285vhaA/dxY1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2f56/ZKLAbFilacJ8sqLFLbrPaMXrrTgSiEyGZKxOpJ0dZiEZUYf1iqkffJj0IAwlM2uCNJFYyrOUFgxFc8xP8TWZxOOEou+t2eZo+NLP8lfdSvyj8qFHC1r/0ZUtrnKu2j+/85Djte6AxXoPPEVXdVsHRTVHu24snKp4TCO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kj2UwPhz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eda47b7343so1935952a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731114774; x=1731719574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjjnvoPu26k+itkog+DckqTMvkk1gvltNz8j1gQtxg4=;
        b=kj2UwPhzDes1o1q74Sfz9HErOvCP6LUcT32YTmCis7ePsQ9dBBOTQsMf6O4tXiJG0F
         /kWpmKJLy82IS136PN5V0F3F11dqOV0Jp6BT3Y56F4ySnMH5YtF84RjFrOK9pAfNFoc+
         grXBpcFBbpkVCyZjzo5DJFfuHphycjoGOPEJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731114774; x=1731719574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjjnvoPu26k+itkog+DckqTMvkk1gvltNz8j1gQtxg4=;
        b=GJeYQOTQUdUIQJ1CLLN9JV6rJL4agxVKjRdQg1FHhiceDprM9JjtneY4B4OL8XYfTu
         L0JYHmdxqcbY+LFa208D227pXZPtmkqZbh/sCKcbWWPRwYGpNG3q7kBW0DQ17Tbe/uqT
         JPchbxMgMJ3MYNXLiQDtA628OFEPiekrpAWRrZevhmLIuiUB5sEV5WPlA/2mDDoQSOVU
         f1UBr7hEjZ+B3Vd0ylmG7JU9FsiRQKVMeMQSueBXwCd7d9R3L3SfWQTkAhPO1SrKMFKb
         O0gj2sg13Ewp+3cYxoPdH9XKt/O7NSZzcbs0bRXC4Bg+BClBh62lJ26Y5W7wrheIzTJ6
         S5dw==
X-Forwarded-Encrypted: i=1; AJvYcCVGxDo48Slf9mE7opz5E+vRAf9BLGFdf6a0LBuUXW2QZv0Rv4Oc/o91gETLTwoRvJaojYuIS1BKxBaCslA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2p8uvHfSvPKpaJxHX3jrqsCO+mQPMhBKtbDIgsLqPBo2Q7E9
	lzoqWp48Q72gJFMIu+dg3mgtSGz+oQ65/ebcYGlP7o22+AigrSfb7CP6ORnGsw==
X-Google-Smtp-Source: AGHT+IF56VUPmJuf5awejR+JuIWM33kJ0nQDhTu1z/918O+Vhmwaenovb5z259WTupYgKmJeNvkdvQ==
X-Received: by 2002:a17:90b:5307:b0:2e2:d7db:41fc with SMTP id 98e67ed59e1d1-2e9b1720246mr7217860a91.10.1731114774218;
        Fri, 08 Nov 2024 17:12:54 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:eeab:613e:a460:41fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9bd621ae7sm524877a91.0.2024.11.08.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:12:53 -0800 (PST)
Date: Sat, 9 Nov 2024 10:12:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Liu Shixin <liushixin2@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix NULL pointer in comp_algorithm_show()
Message-ID: <20241109011249.GA549125@google.com>
References: <20241108100147.3776123-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108100147.3776123-1-liushixin2@huawei.com>

On (24/11/08 18:01), Liu Shixin wrote:
> LTP reported a NULL pointer dereference as followed:
> 
>  CPU: 7 UID: 0 PID: 5995 Comm: cat Kdump: loaded Not tainted 6.12.0-rc6+ #3
>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __pi_strcmp+0x24/0x140
>  lr : zcomp_available_show+0x60/0x100 [zram]
>  sp : ffff800088b93b90
>  x29: ffff800088b93b90 x28: 0000000000000001 x27: 0000000000400cc0
>  x26: 0000000000000ffe x25: ffff80007b3e2388 x24: 0000000000000000
>  x23: ffff80007b3e2390 x22: ffff0004041a9000 x21: ffff80007b3e2900
>  x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000000000 x10: ffff80007b3e2900 x9 : ffff80007b3cb280
>  x8 : 0101010101010101 x7 : 0000000000000000 x6 : 0000000000000000
>  x5 : 0000000000000040 x4 : 0000000000000000 x3 : 00656c722d6f7a6c
>  x2 : 0000000000000000 x1 : ffff80007b3e2900 x0 : 0000000000000000
>  Call trace:
>   __pi_strcmp+0x24/0x140
>   comp_algorithm_show+0x40/0x70 [zram]
>   dev_attr_show+0x28/0x80
>   sysfs_kf_seq_show+0x90/0x140
>   kernfs_seq_show+0x34/0x48
>   seq_read_iter+0x1d4/0x4e8
>   kernfs_fop_read_iter+0x40/0x58
>   new_sync_read+0x9c/0x168
>   vfs_read+0x1a8/0x1f8
>   ksys_read+0x74/0x108
>   __arm64_sys_read+0x24/0x38
>   invoke_syscall+0x50/0x120
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x38/0x138
>   el0t_64_sync_handler+0xc0/0xc8
>   el0t_64_sync+0x188/0x190

The explanation below is more than enough, I think this stack trace
doesn't really show anything new or interesting.

> The zram->comp_algs[ZRAM_PRIMARY_COMP] can be NULL in zram_add() if
> comp_algorithm_set() has not been called. User can access the zram device
> by sysfs after device_add_disk(), so there is a time window to trigger
> the NULL pointer dereference. Move it ahead device_add_disk() to make sure
> when user can access the zram device, it is ready. comp_algorithm_set() is
> protected by zram->init_lock in other places and no such problem.
> 
> Fixes: 7ac07a26dea7 ("zram: preparation for multi-zcomp support")

So I think this fixes something much older, probably around e46b8a030d76d
time (2014).

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

