Return-Path: <linux-kernel+bounces-255711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C9D9343FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DCF1C21A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2A187561;
	Wed, 17 Jul 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmkrLPFY"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C4364CD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252094; cv=none; b=Uajc5d3SLIk0maDN/5NAnaf7Ebg+GyjsswCP+xpzCYsO9x2B3txXvxfDJYfQ2dsj84HDDDYNaDmSqUADBb/TQ2+Xp9QxiJzcOZ8C7rnKIYMQQHO6lhQzMhgZXnZD/p9aa9JJII0DbEYxz8sxd+r/mjzx6fRBSi/xuRLw2Mk4cvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252094; c=relaxed/simple;
	bh=649VWAh8YGtfAt5yzHXNlQ2+FQzk9LOyClnWIDMymFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjmHRbu5hpJE5777nK6VgWgqA3bdxrIICgzXJhmm12FH+ThSykP671JbgPWsa2OVU5YasJwJTBwfgMxSHfqdiyhMPt9cTGCBLwyoHL+LPzdQURxgT4/wvpjIQJgXxfuu8iw+miUPDm6i+hBR3Pfq/mNuDqA3hW2p2ujwuSOIzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmkrLPFY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb50bcabd1so98003a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721252092; x=1721856892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAXXCI6WHcx1m1BcCsl4njyF8RDu8jjh5cq8AdZnVns=;
        b=XmkrLPFYzbBXAlVv0U5EQ9kL3Kuxqx2iwrq8e7wbrYsMKYuLK37587j5LXJNNDqv7u
         iglM13DQOx4o9kSmpaWdzMiXDp8fmSXqUjW5qO5dJq0fF7jc+j7IMBqa42L3lM+Tw3rq
         W2CEfBJWr9m2DnB3ECMxmFco7OKPVVPPSGTtjiJZR8tCYum1njhWwl6lOSWJSf9YXNiY
         hndGUgK7e0Q/IzT724K85W/4LMw+PLGfxqlc/gQoZ8SpZlk3NDdz+rlciKK6b0ftXPqa
         IBv4qGALaEQaIDsCpGX8zEGXspYH9i30C8GqRBPG4GCmEtQv5frZcVa8aud5YdiwVGqm
         3OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252092; x=1721856892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAXXCI6WHcx1m1BcCsl4njyF8RDu8jjh5cq8AdZnVns=;
        b=eT0HBljhoFmbj3b/eOdt1IQk0rV7xtblL9/zqUVQrEyifIwuo9qa9vRzur4dzPYVqH
         4ujN4ljJDOs6b6L8hTyqDa7Hen8ThNxEobFtG31LQ7NXLN3mp/7RNvult0UEVAg1BgUr
         7sIzS6V9RBthNNyoQMpgEdm4YSlaCIMQeMdjg26SBIzZoe4q9CT8Muwm8f6Z8zTw5fQ5
         ZyIoNYSSm1/reqzcEvwsg+CTuyGWeHnQNG43tifgabKgyCMhNwCEW+W8YEfaxxWmkyP+
         RMgFrS/D0onWgMNF3j3rkxl1nHp1Tcb9hPf3zuA0SeYQ6aWaQG+choYnenwR8yOX6U86
         t3WA==
X-Forwarded-Encrypted: i=1; AJvYcCVu0Lv9ZzI/jc3+j1VevLapnBlM2N5ouhyNDrauH+RRlQoh7iXpaTcD208Nho66F4CS77Mo/q/vCUCBFS3Y/QckWGhdp7NffmM+NSny
X-Gm-Message-State: AOJu0YzxKy1hA18y+JkO0UmVCkqy3jxHVUGTAtAW25GoW/vucmzQS0nU
	j773Oqkf+sW4Fdp8ZHfkaaXbKYfKJvOo5MmyJLdUkTZB0iy2UQPp
X-Google-Smtp-Source: AGHT+IFgXG8EeaWU2aJM4yuD8KKiNmZiebJa0YGRkJdO4tJ9uDuOwrah+OMxNTvNk/brZPIVIXME5w==
X-Received: by 2002:a17:90a:7883:b0:2c9:6f91:fc43 with SMTP id 98e67ed59e1d1-2cb5246a3bemr2350535a91.3.1721252092460;
        Wed, 17 Jul 2024 14:34:52 -0700 (PDT)
Received: from five231003 ([2405:201:c006:312d:10a7:17cd:a14d:ce65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb601e4b6bsm420232a91.38.2024.07.17.14.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:34:52 -0700 (PDT)
Date: Thu, 18 Jul 2024 03:04:15 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Do device node auto cleanup in drivers/soc/ti/
Message-ID: <Zpg41yZRHPv9w0Lg@five231003>
References: <20240707055341.3656-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240707055341.3656-1-five231003@gmail.com>

On Sun, Jul 07, 2024 at 10:44:15AM +0530, Kousik Sanagavarapu wrote:
> Do "struct device_node" auto cleanup in soc/ti/.  This patch series takes
> care of all the cases where this is possible.
> 
> Thanks Jonathan for the review on the previous round.
> 
> v2:
> 
> 	https://lore.kernel.org/linux-arm-kernel/20240703065710.13786-1-five231003@gmail.com/
> 
> Changes since v2:
> - Split v2 1/3 into v3 1/4 and v3 2/4.  The memory setup code is
>   seperated out of the pruss_probe() function and put into 1/4 and the
>   actual conversion to auto cleanup is done in 2/4.
> - Replace dev_err() with dev_err_probe() in the code paths touched.
> 
> v1:
> 
> 	https://lore.kernel.org/linux-arm-kernel/20240510071432.62913-1-five231003@gmail.com/
> 
> Changes since v1:
> - Refactor code so that it the scope of the pointers touched is reduced,
>   making the code look more clean.
> - The above also the side-effect of fixing the errors that clang emitted
>   (but my local version of gcc didn't) for PATCH 2/3 during v1.
> 
> Kousik Sanagavarapu (4):
>   soc: ti: pruss: factor out memories setup
>   soc: ti: pruss: do device_node auto cleanup
>   soc: ti: knav_qmss_queue: do device_node auto cleanup
>   soc: ti: pm33xx: do device_node auto cleanup
> 
>  drivers/soc/ti/knav_qmss_queue.c | 100 +++++++++---------
>  drivers/soc/ti/pm33xx.c          |  52 ++++-----
>  drivers/soc/ti/pruss.c           | 176 ++++++++++++++-----------------
>  3 files changed, 155 insertions(+), 173 deletions(-)

Ping

