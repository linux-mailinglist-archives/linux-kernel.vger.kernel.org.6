Return-Path: <linux-kernel+bounces-441125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD59EC9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D16D1667DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53051DF755;
	Wed, 11 Dec 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OiejW2qi"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374E236F98
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911697; cv=none; b=uqeaADJ1RBCiTqvTPUOR+uOHi2CRxKLRcaGuc/3Fg+hnQqQbt7Sgo+eZnabHdsUUuQKx4OoqlDkxSoUSDvLt0E5H9YfuWPMYzZPpHk1UVsumE8cs7sqFlmsOpJ+B1YoBd11Nc/X/3DVN37xWY3h1lhLU8WiqF1kAExucjVUlbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911697; c=relaxed/simple;
	bh=bqJUjrkI55mmiDYGdlE0rAGK2L5PYVFKaQq0z6N9hvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRV0rYn4YKwkVp7CB8i9axt9Vk8tuC0cv3GbHbtz2jWg3rk/gdA31xbANYQ43MJsWrUlo3/1+868H8V1VtBA4xhQP+Y1n8w7ZfabJ2/w+lqpAdVwH4j8Yv50tHeatRL5xBNNt1Wo+QYtQe5BVh2XM+UZQjcp1rDYFj8CLkEcaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OiejW2qi; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso371456a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733911695; x=1734516495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vI92TzbYXb83Ifwlj5p+PZoYU+BaLo97B2EHtHKRH8=;
        b=OiejW2qiL7YH7RWwK3LGZa8/Kb5kOTjYHskVadqgDCLeLUGOgRoM1wtFqCYXOzjoaZ
         lXUHs/voSUPH1tmVbdChyiPGvAIsKVAep6Lf8G7xHeJeGpeHCd/HM25VJzv4fVXWZm47
         PYN90TASVhdxK5pf51dMLCGnQ0iT9q0NdEC8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911695; x=1734516495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vI92TzbYXb83Ifwlj5p+PZoYU+BaLo97B2EHtHKRH8=;
        b=Y0LvLq3y5UZRAGuOAW+6DCz+zk5WyPFL3NNrlnrKtDFS7ePTkB54ieh1HhqXw4AVMK
         plS69q7KEfS929eE2Ryllu7IVT7tQdU9WxoLp4eU+dU7aga17PedxNHjX6dtz1c/Ocjj
         LbGLtuNYWjK4WEl2WlG0SGtwH2MhEj22zxCudEbE9FGUDENeDrsK+3HNtXtsNWdjy4Zq
         u71tc2Ff686IbOrKiNtqp8fTJOGgh3AOtqcprdeeJUcp1uocB5c77Hwkavry6gMN886y
         nIuOyaY7diSUyYBr1DWcEd2T4OHCgX0RziocmQZ4OaVgn9wOnUJrlZ663Zt2oZXPdL6W
         8+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWmhdd6mI44dcW1EwXnbmEhqBBTXVLyWqJN7wX5mkQfkz8a0cyD4HBih0kZON03GR4xiB8pZAGOgxTIelw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/21OLfuuup7rbVKitM2lkI5AfqOV07AOmwYJIXIXz98KaUkBK
	iO0f80wk6MLbgTI8+jwaMpwwJkK/MGWUF4zvqCCrqplymFzJTkwu24z74expKQ==
X-Gm-Gg: ASbGncu3iERBCn5eYx6XeRGOQONwYY4im/qZnfZPehzY2C/Z2okkcf59cmpWKjWxT9p
	J6QKK3S3YhS80DmhLqpO9jJ5fGfgsEaac4s0dDVi1wTcHJoRI/GAnGfvsxiM4YsFq4kH2QHz7Lq
	/+R3w1WV5lmw6Z4878xODILug2dglUx1Gg5QifZ5JLBYhR4Q8kVsKYetbBoPphMSYnGVsmjpsM+
	iG4jSsDgMbkBu0XC2mhZizbsVo6GZpFkVJxBtOxaUOpVPHkQBl49WXtgA==
X-Google-Smtp-Source: AGHT+IHSLi0X5Fvs2Z69ghKCEVQLK9DegAx2XqrIMEwoa3s/1ZFlmuvl7RgffwwihL7mRPnKBmKeCg==
X-Received: by 2002:a17:90b:1811:b0:2ef:9247:240e with SMTP id 98e67ed59e1d1-2f12881abb4mr3073526a91.18.1733911695104;
        Wed, 11 Dec 2024 02:08:15 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef85e30d12sm7601017a91.28.2024.12.11.02.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:08:14 -0800 (PST)
Date: Wed, 11 Dec 2024 19:08:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: use zram_read_from_zspool() in writeback
Message-ID: <20241211100810.GE2091455@google.com>
References: <20241211082534.2211057-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211082534.2211057-1-senozhatsky@chromium.org>

On (24/12/11 17:25), Sergey Senozhatsky wrote:
> We only can read pages from zspool in writeback, zram_read_page()
> is not really right in that context not only because it's a more
> generic function that handles ZRAM_WB pages, but also because it
> requires us to unlock slot between slot flag check and actual page
> read.  Use zram_read_from_zspool() instead and do slot flags check
> and page read under the same slot lock.


Andrew, sorry for the noise, please ignore this mini-series.  Let me
re-send it combined with v2 of `zram: split page type read/write handling`
series [1]

[1] https://lore.kernel.org/linux-kernel/20241210105420.1888790-1-senozhatsky@chromium.org

