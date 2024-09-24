Return-Path: <linux-kernel+bounces-336569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6102983C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EBB280CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B653363;
	Tue, 24 Sep 2024 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjnUQH0Y"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1331FB4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156997; cv=none; b=TgGrykAz/cY/kJQiTudbBbDk5OeETlCPtPKLvi4AkQULeRKAvnLAK9OHzw0nwfhDcQ9q7M3yRcT/wg77TxYWk3l5tYDFBw0sUG8OJsFOw7Xqryyk5DL7MomNwJwXIC46Ts+BX2ms2ai1p3QYx3Q1O4eBO8FT7QSa8b5xJy6nBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156997; c=relaxed/simple;
	bh=IHmyCsJ2ptNJcZq7+QBTYiUWHkb8vQGS0wBc7LRNcFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aij4HzmouK6F4MLpt+CF2tV6PuNlay1yXkM035TyBT/vxNg3MIpoOxVP3twlXIiAmpVPTKCweHXat2QUejzzDr/feN5WMAIcf05steY5YArIeWulcEp3GB0i+9MJW51Ybn8acBboku8i3z8vXle6mKgGLdgrZ8zhC+E5ir2oA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fjnUQH0Y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2059204f448so43508445ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727156995; x=1727761795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYI2lNzS3mPSYH5DJezr946Q6mbRGtoEfc4GBWwmg4g=;
        b=fjnUQH0Y6rY97jlRNyjrf7zetMrRNW71V/i/5nupwKjEUgIv8rJ1pTXwMdKOvHnXYq
         /E2zlBLl6r3STz6pcIcTxnPbrtEX0pw+afPYbeO72SFNXOg7/VmtSyD7msYqCcNpt3TB
         0DZZ6bFxHc7/r2QGTMR/8S1LklLwtIp6hsk5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156995; x=1727761795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYI2lNzS3mPSYH5DJezr946Q6mbRGtoEfc4GBWwmg4g=;
        b=Ub6aW6e4Gaq5UdysSz8hckF5UIk2qz6FnO0diaMVSJULoOXmve5igizkvsxpCSUVEu
         qjH3UTGYpyQ947QE1+TtinnUUgVugUrFq42vkcF5XB+3bCDG1DM3JdgIiZ5UZmWMJlTh
         NjOCgrkdeu65con7hYd5oSCiR21PEYKJsFejOAn1pz4miIhM46ewUc1VbFNCgehXaoxJ
         ULTVx3B4Bc9SnWnJhVZ+3dUQUjmyC0+vj0x3n5uzYpVOijQAFIQVoKYPV5f10bEv1LTk
         wQZo2/fvsLtAUyOeu9uOV9OUOwglcY0dkYeRCWKolLEaXM7NC9VqbsNE23N4qrwOioyh
         NAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv8m73DgVchMR8hhlaPso5eg75HPJednFI2fHroIMbQz3Jim2+GXX61NOEthltQW25bm93gTYZCkt6BPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3b6C1febWYD2XGAejSdmwR7u+hw7Z7g3Jelg91V3GVK0ZvwJ
	/MHDQMwNS9MOdzG2ObjO9XqoXGjtOUYfygJAP3W2P9vHq0sZwxm/URkVNRJb2g==
X-Google-Smtp-Source: AGHT+IHztI+J2ZvVRtkiLGXrytJk7K2WqX3n6bQgX5YRfGcO/PyT6VvUsBkFbUTVymLI3nql0+SBSg==
X-Received: by 2002:a17:903:32c4:b0:1fd:9c2d:2f27 with SMTP id d9443c01a7336-208d982b24cmr230022655ad.24.1727156995523;
        Mon, 23 Sep 2024 22:49:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e070dsm4062615ad.9.2024.09.23.22.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:49:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:49:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924054951.GM38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
 <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>

On (24/09/24 07:21), Christophe JAILLET wrote:
[..]
> > kfree_const() will not work if zram is built as a module. It works
> > only for .rodata for kernel image. [1]
> > 
> > 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> > 
> 
> If so, then it is likely that it is not correctly used elsewhere.
> 
> https://elixir.bootlin.com/linux/v6.11/source/drivers/dax/kmem.c#L289
> https://elixir.bootlin.com/linux/v6.11/source/drivers/firmware/arm_scmi/bus.c#L341
> https://elixir.bootlin.com/linux/v6.11/source/drivers/input/touchscreen/chipone_icn8505.c#L379

icn8505_probe_acpi() uses kfree_const(subsys)...

subsys is returned from acpi_get_subsystem_id() which only
does
		sub = kstrdup(obj->string.pointer, GFP_KERNEL);

However, if acpi_get_subsystem_id() returns an error then
icn8505_probe_acpi() does

		subsys = "unknown";

and I suspect that kfree_const(subsys) can, in fact, explode?

