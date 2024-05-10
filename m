Return-Path: <linux-kernel+bounces-175454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50548C1FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BE71C21889
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A313BACD;
	Fri, 10 May 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JE8i56y+"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08F7E56B
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330441; cv=none; b=AWPMj5kGbevsuN1KH36zUsxE5sxtWUb6sva1X8edQ8dwZDIYQ2+9QjNhzMXKZa9vSvLacalu00KK+labEAxO/IbMqixQCHmMgrZ+qsp1XCw3Exa1u0FAgYC95x5mcfPQCVllYfnDsWzPtEc2jD230BVmBrXzoPQvOH7dMIrOLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330441; c=relaxed/simple;
	bh=JPMH+mm4lMiMXt4zL+tM57v/I78L4rUVEq6LC3xXP64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpvYdBbe6W/AyGKIVUGHT/P9lPdFbGRxYGqOYuGvJogv4DHh+UPgDdR31S5uyuclFHHZBxBS3UuR2mwjnzj6gnJd/qr+VrQWhHLKor91HyLb+tSFkwN/KubPe11Cyw4iHh0gaANAxpEJxkwo+bhwIAyvxi/M4Uv3zdL017U+BMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JE8i56y+; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23ee34c33ceso1061482fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715330439; x=1715935239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZomfWJD3t0+7BUAA8nVU6dC0xByk+g2aWDPY0LtdD8=;
        b=JE8i56y+DZ10s4THXa5PQB0cDoyvDghUg7b1x+vH0Itq9Ai29ECFF6JtnTxl0btbk/
         S/MIaEEYG+Pwxqflk+LmkQ6s91lDuXshHa+f/SsrgTU0FVU2ukYiZUYVPuJZyg6mBRcX
         aJiHY49RKJsw8/JWy/BMCzFn2oJJ8Qcu1liug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330439; x=1715935239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZomfWJD3t0+7BUAA8nVU6dC0xByk+g2aWDPY0LtdD8=;
        b=mI0RoHyGazh1A2TpyCHwTIuQQjyRg+UIda26Bw8iBP/JMhYzls6CVUgHZl6ELCJu3p
         Mbbk2fMFElxqj2TDiboMaXoOUCgTtQS8yjmrwPPudYIupidDLpdukebSsy1/tRWWOQGT
         SHCTcxlINYavbI+M6BqvVMjwrhRgEiqy6Q12JZmtzp9587He72yjrOG7VfviYXeMXHM0
         N50MUsQuh8irjbTVvTmrJ+2DUHeR+Y/KH5V+sBaxcrOsVjdAAs69FAk88H/niWfupU5e
         ERNQ7OCZtuDAQaZbO7HA1RL7aASk6hA8Dxbi8zxGlBX8HvuK1zUTIiGWfqDJosqvzDzc
         R4rw==
X-Forwarded-Encrypted: i=1; AJvYcCUjVG2ZoX9u9oyNaYNh5yrpu73p1cy7WHfX+XCLtEFkWzongC8yDwCaoqdlf66JojaNZvpa7EDqTJLoXa+HkFr8AEKU0EASvcMGvWua
X-Gm-Message-State: AOJu0YwGMHbvPZECPnDLoQUbG7tl0u+RkIHobtjO1tSCPfHrC05daNDR
	3V5Jfo1qksDO6POWC+MOItB8Wz0G5DVGi5ysjkoS1/HehbLoRbsJZCGfqjloUA==
X-Google-Smtp-Source: AGHT+IGjXZlYHqz/IqO+Uf2rD0hKlsdFl0CNwe7KKovq2KKzmPdZdYnhVD45lL16TlHcC/EZJvrPMA==
X-Received: by 2002:a05:6870:730d:b0:23e:6f11:85f9 with SMTP id 586e51a60fabf-24172c2fac6mr2287281fac.33.1715330439147;
        Fri, 10 May 2024 01:40:39 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66600sm2556666b3a.11.2024.05.10.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:40:38 -0700 (PDT)
Date: Fri, 10 May 2024 17:40:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv3 00/19] zram: convert to custom compression API and
 allow algorithms tuning
Message-ID: <20240510084034.GD950946@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <ZjzFB2CzCh1NKlfw@infradead.org>
 <20240510051509.GI8623@google.com>
 <Zj3PXKcpqUPuFJRu@gondor.apana.org.au>
 <20240510080827.GB950946@google.com>
 <Zj3W7OK9kDpneKXR@gondor.apana.org.au>
 <20240510082850.GC950946@google.com>
 <Zj3bFngCxSbO2I4a@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3bFngCxSbO2I4a@gondor.apana.org.au>

On (24/05/10 16:30), Herbert Xu wrote:
> On Fri, May 10, 2024 at 05:28:50PM +0900, Sergey Senozhatsky wrote:
> >
> > OK.  I guess for drivers' params support (dictionaries handling etc.)
> > we take take some code from this series.  You mentioned acomp, does this
> > mean setparam is for async compression only?
> 
> It would be for both acomp and scomp.  I have no intention to
> add it to the legacy comp interface.

Alright, I'll wait for the patches and then will take a look
at how to use them in zram and how I can help with the drivers
(if needed).

