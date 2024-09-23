Return-Path: <linux-kernel+bounces-336092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0853397EF02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A27282BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF319EEBF;
	Mon, 23 Sep 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bf4b60Zb"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0419CC03
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108182; cv=none; b=g+O2X2LZhiegsUiOnQXA6mPcZJpKa8K+jYGP1D53bdZB7wYaGx9zzaW0uxeKfZrWonQ5QZM+MlyilOWLyvkooqGjGPpA2IJ7XN10dMu1l0ldEWKYGI4uyjSnJooZ9kxB3i5ALmr5vGmhGKzrclc6mIrLB8enVw6piyaivMZeEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108182; c=relaxed/simple;
	bh=Jgi9WZn3ocScTDIXMurCWzHK1+wuwKcb7pJ9lWRo+vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEtjVMJabN2AonHnLQpYyfxVw0r5klsIlx2H1mme4jxia9TRz1S1cm1AnDmCtFeRaVMO9ebnE4LvLwNE/FGIbUwcGIEI6HYMxdGaOHIvajNInf/R9w4lvgl7BLzm01VoM9Z4nuQjYHkt8OfQTmJ586DYLGw85Xhjz0EAgVEJXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bf4b60Zb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso2844128a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727108180; x=1727712980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3TDWYxveihy7Zr7fGwjiPX+G3CzpwHb+Ud3Z6ThKWQ=;
        b=bf4b60Zb54mV+ypBdlZZPgOJe6MThH1fSIk3ZkIFtWptDsRCxXEBWN+ibsPADi7oW4
         FUJMPuZQLpNqcwdshO//kx01eMNBX9tvtQ3DaFyODq36VAyV6JoVam9uATd4cD1h6eDx
         gv1L/0uZ4zn9lKTXCBSaQOxQRfEAFrhzKafeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108180; x=1727712980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3TDWYxveihy7Zr7fGwjiPX+G3CzpwHb+Ud3Z6ThKWQ=;
        b=QWdncij87gvaeLOih2U4HAntfBqx2qkzKD3prXDSymBdNlwEYaugWdOwxnnPdnq81n
         heN6o2XZzE7vND0cVdRaUJJP7vbN7kWBx1otno3zI/Yi7kzS1CTLHVEuzkWS3NaDv7r4
         2Gwq8mVVLGKJxq+FQ+6PO5jZ52VGyC6hYxCaoHc+tHI9TWLrhY2NjmVvLQZzsE1ldNeu
         Vcc315P40QslqflQK5JkyJ0//v+M8uLMELhJdCkjd9+/3pI17mL/TZhTOlpJhRV0GaJu
         y95FTIxkUVYf+wmbRO13+0ORUyeKONaSl/ZVKFWHZ+MvkFr7/ek+216aUk647qtjojlQ
         IOFg==
X-Forwarded-Encrypted: i=1; AJvYcCUV0AgLUp6AfeNb/4crblYTviMgW7X7FyFIZwl8h3FVSyhQxzGqvIZw/NDZMrU2qMWcL3n6FiYO8rbiZvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwbA6t4vz13SQa+1qKaOU6/d5D7LmgqCjX7EKjPAA8tTpMtix
	ww4pAiGNWC2s1sVwSakRLU7rzyfbNWZQhjIASxCNTtUDQqg7ZgDxvYAsQyvkTg==
X-Google-Smtp-Source: AGHT+IHVkQZwGgU1tvKl6k0F2v8TePIa8llrR7z9ZGmNXnGWkDebtWD+GohgUHbySm8F8jMBfv0+Cg==
X-Received: by 2002:a17:90a:c70d:b0:2dd:4f6b:6394 with SMTP id 98e67ed59e1d1-2dd80c7ecc7mr15271796a91.19.1727108180174;
        Mon, 23 Sep 2024 09:16:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef93b2fsm9619831a91.49.2024.09.23.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:16:19 -0700 (PDT)
Date: Tue, 24 Sep 2024 01:16:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] zram: don't free statically defined names
Message-ID: <20240923161615.GG38742@google.com>
References: <20240923161108.991709-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923161108.991709-1-andrej.skvortzov@gmail.com>

On (24/09/23 19:11), Andrey Skvortsov wrote:
> The change is similar to that is used in comp_algorithm_set.
> default_compressor is used for ZRAM_PRIMARY_COMP only, but if
> CONFIG_ZRAM_MULTI_COMP isn't set, then ZRAM_PRIMARY_COMP and
> ZRAM_SECONDARY_COMP are the same.
> 
> This is detected by KASAN.
> 
> ==================================================================
>  Call trace:
>   kfree+0x60/0x3a0
>   zram_destroy_comps+0x98/0x198 [zram]
>   zram_reset_device+0x22c/0x4a8 [zram]
>   reset_store+0x1bc/0x2d8 [zram]
>   dev_attr_store+0x44/0x80
>   sysfs_kf_write+0xfc/0x188
>   kernfs_fop_write_iter+0x28c/0x428
>   vfs_write+0x4dc/0x9b8
>   ksys_write+0x100/0x1f8
>   __arm64_sys_write+0x74/0xb8
>   invoke_syscall+0xd8/0x260
>   el0_svc_common.constprop.0+0xb4/0x240
>   do_el0_svc+0x48/0x68
>   el0_svc+0x40/0xc8
>   el0t_64_sync_handler+0x120/0x130
>   el0t_64_sync+0x190/0x198
> ==================================================================
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 684826f8271a ("zram: free secondary algorithms names")
> Cc: <stable@vger.kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

