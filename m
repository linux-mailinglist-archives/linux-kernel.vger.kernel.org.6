Return-Path: <linux-kernel+bounces-336556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40594983C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AABE1C225FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638140879;
	Tue, 24 Sep 2024 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqbzKSGI"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3D328DB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155071; cv=none; b=uwlUPV2hM1ZkFv/BX29QphRgzo5PIII/Ut4N6FH8ssuveSJCW2OuMsjxOMe2Wp2qyi+sfUwMG6cOKuuIxMt89hBP+1AAPzxIlj0E9v/qKozm7TwO5ZWjBfXJfZX9WfnQfsoppCY6xQRT1k1b1skM7ap0QfjtGn1sQHXidVITjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155071; c=relaxed/simple;
	bh=NQSzcpbUty+aQ2mlAjS+hKqynQT1RDt1zJcw6ePLCc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PatL5kJoBywcpbp7Cp7zApnRrdLE5dhYHOUP/1TQMx0U8iqyv6IX6Okii5TVpryiokHw1FPnwPVCtCMlUTxKj5ZlMIJgckd7KCVXrA9fQEpPlL/xfsRCPg30lhz8oVy0gXUjcZsMdAz2u7EYOzWStshSUaAYhbpuxMrAGLcvkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KqbzKSGI; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3391950a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727155069; x=1727759869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olQ3O4gKirGG0b4vMRuGYF6zh1nzrDG/7ktwTtv0X/o=;
        b=KqbzKSGIrurcX4692su1gcDTXQqR2X2Grc+5R5tkX75DA5gHW9JpTiLnRvVu6TVO6j
         HXnyktnYUM3Iw64Udp/MlJ1DTs9mSPUFltZd8VDawAxf3mA4PKBHUgtk75HzVCVPD2A3
         pTIRMyFOxeDtwqPI+u5a6GW7pL91VxxxYK//I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727155069; x=1727759869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olQ3O4gKirGG0b4vMRuGYF6zh1nzrDG/7ktwTtv0X/o=;
        b=k8uv1rMRJr6mk37ZhkmpfEuvwrNuNpkFGqboUeFQUR/DyrT72F4MNq2LI2uDmk3Hm6
         EBAA6l33V+FUAt77cskCdCA1i91ehh+yhEgNIyvo1z+/drdUCFTIEtUEuM9yAPlrXA8E
         +s36TyBDYNdMt4yxHuC1SIgPDIqkLgCnTa3cJOTBPzmNn4UaOG2kysyEu+zgheX6ke+Q
         q0rCAm+gtq/tQ+Ayn8LRfBWqnSR8EsGhI7r0wmy7Ei7nljPZryzfQGywYHpUsDsfwuFw
         pHSSwYjHk8g7cCVwdhvfo/C6cavOmgVNHSW02jMdvh7V4ulbHOes30A0zF/7kb8nk+yO
         1cPw==
X-Forwarded-Encrypted: i=1; AJvYcCXHOHIf9TQ7SebWwkw1kTJ1BZjrAceHp9MLL4I54WscaiCD0dgVALIYdg6Plb0EZf7RP9ED7tvsa+sBZc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwM/XEqb01BexbMUlJTi6Ftf6TrTGDuI2kFa6zPmwNZ1Xj2L07
	HS80TRcsC8SYvfOscJjVJiXS6DD/zgTkbwzdarT/nGx/RDweL+8S1MFDB/rvFA==
X-Google-Smtp-Source: AGHT+IEl6WuB09CMGZFE0WBd+3Iy0PO9zjGepxVS7ZujAMPm2xHZENZLwXzoRIG6NJnwuAzO0xiwwA==
X-Received: by 2002:a05:6a21:e8f:b0:1cf:6b93:568d with SMTP id adf61e73a8af0-1d30a917855mr19506172637.12.1727155069473;
        Mon, 23 Sep 2024 22:17:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc84480esm447992b3a.73.2024.09.23.22.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:17:49 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:17:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924051745.GK38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924014241.GH38742@google.com>

On (24/09/24 10:42), Sergey Senozhatsky wrote:
> On (24/09/23 19:48), Andrey Skvortsov wrote:
> > When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
> > default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
> > so we need to make sure that we don't attempt to kfree() the
> > statically defined compressor name.
> > 
> > This is detected by KASAN.
> > 
> > ==================================================================
> >   Call trace:
> >    kfree+0x60/0x3a0
> >    zram_destroy_comps+0x98/0x198 [zram]
> >    zram_reset_device+0x22c/0x4a8 [zram]
> >    reset_store+0x1bc/0x2d8 [zram]
> >    dev_attr_store+0x44/0x80
> >    sysfs_kf_write+0xfc/0x188
> >    kernfs_fop_write_iter+0x28c/0x428
> >    vfs_write+0x4dc/0x9b8
> >    ksys_write+0x100/0x1f8
> >    __arm64_sys_write+0x74/0xb8
> >    invoke_syscall+0xd8/0x260
> >    el0_svc_common.constprop.0+0xb4/0x240
> >    do_el0_svc+0x48/0x68
> >    el0_svc+0x40/0xc8
> >    el0t_64_sync_handler+0x120/0x130
> >    el0t_64_sync+0x190/0x198
> > ==================================================================
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Fixes: 684826f8271a ("zram: free secondary algorithms names")
> > Cc: <stable@vger.kernel.org>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

As a minor side note, I'd still prefer to drop that backtrace from
the commit message - we know that reset_store() is called from sysfs
write, there is nothing new (nor important) in that call trace.

