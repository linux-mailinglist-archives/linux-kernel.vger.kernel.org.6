Return-Path: <linux-kernel+bounces-336298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D897F1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D321282823
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2FB7441A;
	Mon, 23 Sep 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA75cdYs"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302243AA4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727124644; cv=none; b=mAM5x8gDjWwSGl24ulDqUTOdmGhOiZ0QKaRO+PVKxNehdGRWb6XMAwNVU0EMxTLettXm+MWSKphpLn23gub6wBmJex+WLuf2CPwsSoHREgf+wGyyUvObs0y3PHW02OrTDpwSiHy/Zoa/SrtbCGEwdN0lKQN2DrNXY+yx66NqhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727124644; c=relaxed/simple;
	bh=aHbt63hyzq3mXjhQceAm6Fx3PJ09r9aifCQR9uAl9tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ4fRIV+VPc1sZd50QpSOMsT8FvOpmWWs6z0iFqnI0SgZUW4VsKhEofYapzwRvGL7CPcaVLsSMXL//d+4FLl+1iVoiQsQmT3dPRh53zehYthjUUnQFMQmJX7gG/vClUS55UfajJnkLh7Pda1K12T35kpXsxMonHxxpcSzXzFTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA75cdYs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37747c1d928so2538216f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727124641; x=1727729441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9bY1v2U6O2aGMUnM6Dm5z5jTVC5ivj9gng5bvcyVRI=;
        b=aA75cdYsM68W99fSNAB5/9KMt66bGCY/2u5h74Xn2GEXjcoVZ8x0vnGBPHm6Cqkgzv
         xtEtf0lrhd74s+cQy67RPqTFaizicvHpcCMZzYcpffEmzZv7ARrKynk07NSjL8yMUZAi
         C2w07+xg2ZPGZHB08kvR5yAiELd/ISMkFB1U4ZjiS+lePJME0J8ZYWmmw7C3vGaWxMLZ
         eLbWbnmH0BMSqbdkHhfIQgoTRel1g8RyI9lzzgpO6Iz7vWz2xrtVja4cuqEsI5NR3ei5
         KnTq6nWbyyGsymQ/1GdZink05E5yaqu5mKOrAoSEsidt+nI+IehBXRtnci59ZVvD/Cac
         EBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727124641; x=1727729441;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9bY1v2U6O2aGMUnM6Dm5z5jTVC5ivj9gng5bvcyVRI=;
        b=hrLQIzZNObEWWV+eypwg4f19psZVWt3kI6eaeD/TbJEjLKeznxMbXcKB/m1bVV/zAY
         xbXGIOnJYVItNlG0WpaaUw94MlS73VPxlGniCsOhfCSPqtli7N26yYAf4HcRgBwf9Fsf
         BZjop0Cyubz9zjLmbe8IPfKKN7tQicLfpV20khKcG0Fxjd1WR38g3rh6ggow2kKGipV2
         0xslK3LQpgTHNtdRb35/KVtPeD1McQVl1CyrIVLEiOACU5po5oY+8mVpCW7149Bg30nq
         MLPcKh5EsuuejUKLuGmDcZMnd95gQLEe28GpEfYvqQpt2BUN2S9TcACkQfh1xj/+evBE
         xI6Q==
X-Gm-Message-State: AOJu0YxIhP+i6eG7uUK/4hWZQjDbUJFcAqHfAw/wyEfjd8yPy/tGRyaQ
	tw6hYoUn5jNdIk6f5BsR3PkXLRht10N7zP0y/MO4hrd4XmnG3JxT
X-Google-Smtp-Source: AGHT+IGg4wOLC/UAvUPyM/ZyTVaD/b7SE3abUGO9wXw53MtyY6asxbHyU+G7VpgLaiOY+qpBJ4XihQ==
X-Received: by 2002:a5d:6903:0:b0:368:3b1f:fe40 with SMTP id ffacd0b85a97d-37a42277fb7mr6356003f8f.20.1727124640654;
        Mon, 23 Sep 2024 13:50:40 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800067sm25365790f8f.77.2024.09.23.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 13:50:40 -0700 (PDT)
Date: Mon, 23 Sep 2024 23:50:39 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <ZvHUn1Q2R8FumZ20@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>

Hi Stuart,

On 24-08-22 15:28, Stuart Hayes wrote:
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/base/base.h           |  4 +++
>  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
>  include/linux/device/driver.h |  2 ++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 0b53593372d7..aa5a2bd3f2b8 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -10,6 +10,7 @@
>   * shared outside of the drivers/base/ directory.

This change landed in linux-next and I have problem with shutdown on
ARM Allwinner A64 device. Device usually hangs at shutdown.
git bisect pointed to "driver core: shut down devices asynchronously"
as a first bad commit.

I've tried to debug the problem and this is what I see:

1) device 'mmc_host mmc0' processed in device_shutdown. For this device
async_schedule_domain is called (cookie 264, for example).

2) after that 'mmcblk mmc0:aaaa' is processed. For this device
async_schedule_domain is called (cookie 296, for example).

3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
parent->p->shutdown_after is updated from 263 to 296.

4) After sometime shutdown_one_device_async is called for 264
(mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
code calls first async_synchronize_cookie_domain for 297.

264 can't finish, because it waits for 297. shutdown process can't continue.

The problem is always with a MMC host controller.

-- 
Best regards,
Andrey Skvortsov

