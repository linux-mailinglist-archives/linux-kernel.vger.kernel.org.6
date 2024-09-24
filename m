Return-Path: <linux-kernel+bounces-336638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BB5983D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA699283DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43AD77111;
	Tue, 24 Sep 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdrwcHEb"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9411B85FA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160663; cv=none; b=KWqCVizumrXeER1AebKnLARmkVJlvtCCgRKlChq1ZmXff1cGGah/ukVChXA5vAC/WPOC0EbnLrE3AgWktjrgUpDu3IZ4MCS+6hmqTMgLumC1487eYjEzeB5FjgcNJ9GDuM6wHIP58SKmtjXhfA0u9EBY6pbuIbYHbNwxY65XpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160663; c=relaxed/simple;
	bh=LpsqiJvMgPeFGUk+BZZEvqNyd7oNQvz6Lh1UHfN/Jdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMFaX6XqwDZrrg3FQCxYsCt4QXgFQZp1THEZNXdEtn8Dn/QTf/rHQi3DG8mG1brDg7j+t1eaLw0iol53ZdSZGKy4kQgL/BAMPd8i1BHdaEcgnengH0cJ5bpV8u5GZ7j/uIWCtukZDTgqEl21dM9LuNk4wrqZJkqTZiZXF566RvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UdrwcHEb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-208e0a021cfso25737205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727160661; x=1727765461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/4TVrZGAPYYZ9jgK0SoUaboMFGCpBKiH3t0JiBxkdE=;
        b=UdrwcHEbdf618KJiMNMrIGqYphlbDhR9+dV3iUpzKuq+OdtdTXARO577wptxGjIXEa
         2PgX30ITBo6mU52q0nKCYEO7FjXCurWnadY0QoRN69jMhBblbilGLk0ebz23qXwjkU5R
         d4pxHnwcfptku4iRn2bbaQ0a5ylT/1yhGwp6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727160661; x=1727765461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/4TVrZGAPYYZ9jgK0SoUaboMFGCpBKiH3t0JiBxkdE=;
        b=XZZM8JeMkgTDyyYtjvwc6U5ZiLi25qR155ZCac4gKnT866csbqybEwfMheWPHtsZVQ
         noa4bU+DBPjFxJhJSDbgz1K3NMUDRoiOg//4BueGOivM+Fyc67EkDuQfsvWkaeObkO88
         ldm3adxY0Zg3PD2IRIZzEEkamHkgDY6EwRzoNT7T9MT9q3DkDabKaYkaYdD/5VGl1Slk
         gCPv/P3366dw33A0z1M3VdPR+lAqBuaUkYAiw2wD+HcJnYhuzJqr2R8mC2trPubb1JMw
         bRwXMG/f582vw49mKSLpQP1+gxrirr4qlvrpOKgO3jSRoqIDEd4TC/RTtfbdFN/6smLn
         Nbmg==
X-Forwarded-Encrypted: i=1; AJvYcCXMsXTXWilGSGq8TmMzHcwUd1OelShzXJSGrTnsLnq4AjyyqpXmjkMUAVZDyDR8YPUEdyYfNpVtamdrbfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5jmVcuesTX37WZlTk7KZr2Y3gnOLVSMlyeYNYPMxULmpWLU1
	0+y6ChwtDqIaohgXPvMUE42avrVlF+IoiwXVbhDkm1NxPnAQy2mYOOf69hlZCA==
X-Google-Smtp-Source: AGHT+IHL8eRo0RSvvbNDTCkEkAe7y/UEEpovG0ZqtEloktAHurr+zf+J8pOugx0pBfpmpOm/9jfvfA==
X-Received: by 2002:a17:903:41c9:b0:201:f1eb:bf98 with SMTP id d9443c01a7336-208d840ace4mr182071705ad.54.1727160661152;
        Mon, 23 Sep 2024 23:51:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1818a88sm4874115ad.210.2024.09.23.23.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:51:00 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:50:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924065056.GP38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
 <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
 <20240924054951.GM38742@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924054951.GM38742@google.com>

On (24/09/24 14:49), Sergey Senozhatsky wrote:
> On (24/09/24 07:21), Christophe JAILLET wrote:
> [..]
> > > kfree_const() will not work if zram is built as a module. It works
> > > only for .rodata for kernel image. [1]
> > > 
> > > 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> > > 
> > 
> > If so, then it is likely that it is not correctly used elsewhere.
> > 
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/dax/kmem.c#L289
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/firmware/arm_scmi/bus.c#L341
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/input/touchscreen/chipone_icn8505.c#L379

OK there are too many users of kfree_const() in drivers/ so
un-exporting it is not an option, that was a silly idea.  We
probably need to walk through them and make sure that they
don't kfree_const() modules' .rodata

