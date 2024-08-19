Return-Path: <linux-kernel+bounces-292912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8F957662
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1DF1C23764
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860611591F3;
	Mon, 19 Aug 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exXdrsJD"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894151BDE6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102142; cv=none; b=YYJhA3kfH0YdpSWRWRDJ8pnklNehzuMkbmMOx/zK05FIhiHXnOnA45GKilvdhtH1iJpN5mAtrCB1KeHDKGw+HYZyPNe/q807jvzvNqewUX7QyywyHLDykW9WXdFE6Vo04imRRa9XlSCXXrI4D9TKjwdQbgwldWN023N5CiXtDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102142; c=relaxed/simple;
	bh=Fd/61eUJ6PW49pjpCN8AQxHPxW9eOdpS8BxaJpAM3k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRnkIWX6REOVMYdznXx3eYW2xUrPiWM+yW+Yd+pMd4pgsEGhGSCb6ygIv5WvdACzj0oYphI1/mB6WSU9BCpxQ8f8ECUMLHvjIpLWvNPdZqfj9pdiO1OK6UtWJXu9kNkvv0H+sH8Ln5mZXBzGNzbMzBpi70FHG1E15ZTbdTzNxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exXdrsJD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so2788305a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724102141; x=1724706941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zOwgzGSmJ7KgtSbVJyuU4FvpFfZcQaxz7K5MetwfQk=;
        b=exXdrsJDvzB75dhWhip3Bz+npGuQzjOzSuoJh98vhXHuD/zKIGR16LatwduP4tC74d
         ekfRGLSVxUoKTg+Is6OjVxQ6s6OWeUTonX+rpUSPclvQSi1OG2H9sMGW8XOCWKV2ojqu
         XyELZ7KOmfRHKOYRlXf81PTDcNbwUOO2UGahFTdwoIaigqgPZIB0AFUIILtarC89kRbv
         Ir95hMdbMUN+wG/Y1ph9+HarT6r6N2RraG6J0rxi360kLSiPOE3940ypdToFXGLKENHZ
         GGvYp6RntTZT0UJNo7+pAz5tyb4iPMdAtbYNZbbHYaT9T6guw/Id2DvWvZK+kI0+7LON
         XAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102141; x=1724706941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zOwgzGSmJ7KgtSbVJyuU4FvpFfZcQaxz7K5MetwfQk=;
        b=B810lJT3FyXxPL+BLQMnZeO1OlgMxZ2RTOyxAG4aw2C2ULY6xtXtNltsB+btHN1RvV
         aIzzkZdzKuGH71fiBt++pwKeCESEh0kJZb01tptNX6yLGG99rMiQS+nxp86oLi8DzlCx
         n4l8meoq72CJ4TBaVoNUcvBIZkAnrqpLjR9+GQ0mMUxAlAikEm2JMDY7R6jPe4P4sIU2
         tCaZnlE819YxRYs0klkPec+y5Ss4pcDQXcnMDdCjCJbkxAIUzsaw+1Mh3l0xlSQhGhNw
         wC5m3UxtmokXjbMFjhU3qr5VBJ+XwEvrUSQg453741XzyLzmSAzPKPPsB6iItpCGy73U
         M23Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYTcZKw/RUAb3/n2bbQ4X1QWRQ7R8+81I8tZsHRS9pwZdzcYTInkjyyhoB2/WmVnTtyLWa/bslDEmcRWFxaOOuFJWJ+slWamCaf2Gi
X-Gm-Message-State: AOJu0Yw1SSwHxc8+jbFl4i3JOc2rJRgCD/6FKjv2p5E0ukq5AyxR3P9s
	vwDjgawGe9pHIZh8tyzvDc5s51qE1euHNKMWVr8tlECkOU3hq/hY6sNhcA==
X-Google-Smtp-Source: AGHT+IHA83RQh+1PtRX7Ljera7DNxEvbkB2ifkVfdWD0TTs5sDDDVw91akpJT15rqLRQwNaxsAMzkg==
X-Received: by 2002:a17:90a:d98f:b0:2cd:27be:8218 with SMTP id 98e67ed59e1d1-2d3dfc378b0mr11448925a91.8.1724102140519;
        Mon, 19 Aug 2024 14:15:40 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3bdaf8d1esm10907073a91.53.2024.08.19.14.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:15:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Aug 2024 11:15:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <ZsO1-gCkeGuskOnT@slm.duckdns.org>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>

Hello,

On Fri, Aug 16, 2024 at 02:45:20AM +0000, Matthew Brost wrote:
> > Tejun, how do you plan to handle this?  Would it be possible to
> > drop current series from your tree so that Matthew can send an
> > updated version (with all the fixes squashed)?
> 
> Tejun, yes let me know how to move forward with this as it is highly
> desired for Intel Xe team to get this into 6.12.

Can you just send a fixup patch?

Thanks.

-- 
tejun

