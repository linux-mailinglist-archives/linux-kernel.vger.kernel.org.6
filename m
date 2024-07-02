Return-Path: <linux-kernel+bounces-238113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B998F9243BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654321F26EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC01BD504;
	Tue,  2 Jul 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFb9NhbS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786715B104
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938429; cv=none; b=quE8NuNTZNMP4bBEFrExhvlZCrPYCtiOGhgBf//LwcxbGgeYug+ZYcJToq8JucxkZMMUnlo1bFxCQaSRBs7zH3Wb2lAU+I2OFQDkR5K+CajHxj/jaIpBNP3wZsl7vYFe7BUR4I2PUmkQZZRz7t5Yk019PrZlSuErWpEUp3CDLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938429; c=relaxed/simple;
	bh=pUq/fs0JzSK2pCWfzpPjtdL8GNoSx+UeqdHShO9oLtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSdLkd8WnUj4s7sbhR0YMAM7DCH9aYbcjXUb6uWRasnth/7nw4dHSiiQIPgtde9RLvXcwx15zZltabAtKxFAkOVQU18sufHgzkh7tk9DXYbB7s4+ci/m+q+RXEbUQMB6XTX/aKNrU9v72QE972OiRa4tY6bkVaMFnw5+yq9e4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFb9NhbS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6a837e9a3so19019465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719938427; x=1720543227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLjzpfOvERsnkj5AGhl4LZNfD233yRKm3p2HBwKY8aA=;
        b=BFb9NhbSs5YtgZXmud7kjEvDZOKqMgabRCOMHkTVT9Eao7/hOjZiCYiMnvRN0V7zS2
         9TxwykzWd3afVsKvsY9B7w1ArpKPTSspcA75v2KwNtzVsJLi29Q0cc/wfnfBJ0BNZo/+
         R5eqH8bcefBcsNuSLqjVFVOwYMe5J7iEIb7dMl7E3m/0fdPo0ra4n9wx9ivvcjBcV/1z
         M/GS+46PXWhoitZfVu6YN35pAp8TAVFl0+ygmFMJ9VbYwW7TNDY24MBXn8bf05J64nqt
         oC0AfUOrLshiLO+3tcUUWMR6VE8uRVy9bXalVXcC+2GK49beKeoKSDUi7E8d4RfXoa7o
         qn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719938427; x=1720543227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLjzpfOvERsnkj5AGhl4LZNfD233yRKm3p2HBwKY8aA=;
        b=VResNezeFxhfjYq2UUmjHM2sWztCUDkVPgmiDfae7W5zRkjYq7l9E/L4plgbBjiVu7
         AF81M/H4ZnVwupFKzHAzuwgh6f5mWx439LNz4IA2x9/zX+Y9PxaQS5qFTjeBNYjx80RC
         Ps8ZOR6LnMzetQsrnq5KVeu/MYzDD6E8YWDmegaZcXEJATa2HuASFZN8exeXDv/m/K31
         Rc0NMpY8zODhtaR6mDiPF+ffJ5JMjO28nfrsK9XPGpjHoYmN01jf8QkVlnjdj5Y8Mqgj
         qwLehqdW686Rq0RChbpN0QgxPXtHpt7+cqePTXl0JI6IAN0ONkc34IO3CLJiIiXz9rHb
         +YXg==
X-Forwarded-Encrypted: i=1; AJvYcCXxxCWn0o3QqlzaINDzJslChQwo8Kepd2LX2WxjqDzs9VH2GOPEvpVVbS51uFYJ2iPQBTFBWs+NZb6AfujI8VHp0RbLiSPlwQsQR5Lj
X-Gm-Message-State: AOJu0YzNaxlWFewyNb/ZWQy6t6F3T4WoIL/FAxvMD6t4y0oOq2zV9NmX
	xYySzqsCJxBhNbDZ9Wk6GCiL9EnQu6u0ZdvfiJbFQygjS26JDOUK
X-Google-Smtp-Source: AGHT+IEkU7pdSd0LWYWG0EDz+PuGtP68IbeqI3hs+bqlHz2DFPsYUBDvHBRg+U6hh7EqKFlSiz5UAQ==
X-Received: by 2002:a17:902:ea0f:b0:1fa:221e:aa9a with SMTP id d9443c01a7336-1fadbc85f98mr60272605ad.28.1719938427046;
        Tue, 02 Jul 2024 09:40:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b1esm86650705ad.140.2024.07.02.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:40:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 06:40:25 -1000
From: Tejun Heo <tj@kernel.org>
To: yi sun <sunyibuaa@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Yi Sun <yi.sun@unisoc.com>,
	jiangshanlai@gmail.com, jaegeuk@kernel.org, chao@kernel.org,
	ebiggers@google.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	Hao_hao.Wang@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH v2 1/2] workqueue: new struct io_work
Message-ID: <ZoQtef_6xfd4FAwe@slm.duckdns.org>
References: <20240701075138.1144575-1-yi.sun@unisoc.com>
 <20240701075138.1144575-2-yi.sun@unisoc.com>
 <ZoLoJ-uBo9qyAlMg@slm.duckdns.org>
 <ycmaxfuqpnj3vnmseikx7m7jkzsp2t2qtlncgub44xhxohs6du@hucdavhpcvpi>
 <CALpufv3bAsMey1DFb8HPbp8gPZWBU-6rrhvRWwVQsxXhPXOvdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpufv3bAsMey1DFb8HPbp8gPZWBU-6rrhvRWwVQsxXhPXOvdA@mail.gmail.com>

Hello,

On Tue, Jul 02, 2024 at 05:27:19PM +0800, yi sun wrote:
> Yes, adding the io priority attribute to work will bring huge benefits in the
> following scenarios:
> The system has huge IO pressure (these IOs may all be low-priority IOs),
> and a work (we hope to complete quickly) is also doing IO. If this work
> does not set IO priority, it will be blocked because it is difficult to get IO
> resources. And if this work sets a high IO priority and passes the IO priority
> to kworker, then this work will be completed quickly (as we expect).

As I wrote previously, you can still get trapped in a pretty bad priority
inversion whether from workqueue concurrency or queue depth exhaustion. I'm
sure that there's some spectrum of contention conditions that can be helped
with just setting ioprio, but it's a pretty partial solution.

Thanks.

-- 
tejun

