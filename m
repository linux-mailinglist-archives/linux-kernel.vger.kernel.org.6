Return-Path: <linux-kernel+bounces-206515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0864B900ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C38B24C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB9196DA5;
	Fri,  7 Jun 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhU9Pq7Z"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576A19AD67
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779226; cv=none; b=Zm4unv8DudXnCG4mCAhQwD82oigQWPMeZSwGZwQRu1qhRBxo0bsBzoWSe4FwVh8xedSWMHtyfQkZIoDo69saPszUN+HSgw3jny5N2dTJXfOLW9J7Juus0q9dYdpcNzeMkv5E7J6y8ibweO7WyLXbxHClxoc/VvUvUDI4te0W6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779226; c=relaxed/simple;
	bh=VAX/ztojjkCHkP0gK/TmXqLCAGs9o6IO4ixKqPLACgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9kScW34Q7YOHs7VciQ6YDCbmRcXgYnW8uyZOsi2SL3Vk3peG8F78D0XIFTwqvKcD1qDYYd0gLhl0CxF7VvHAIprMweJuoJrPU2uRm9IFzG7ghTnvdJkcKvgzkvnodMmeYSjAgqe2c6DE4P413dT6S4FoiyPGMz4A3Jbfj1ASi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhU9Pq7Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f62fae8c3cso21204255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717779224; x=1718384024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zKL5J0VS9IMV1OYvnpO3g/QFuooLWpL5+qjChKIyVA=;
        b=fhU9Pq7ZIbedzbjvCB7dIeANjaU4Zuaaq+7wCS71beGgvDIAxXIzOv4pFadevGrqhJ
         /k/1lk/f3F2rhk/IrRpUEIpaUUaHJqYBl4X9uCcWM1HbPkC5TF8JtVxvlsBJ5cpASOWt
         f5sBS60h3+3j2Yd1wLaweuWOlYHGgBd/hOeZ8/RnbvbfW3zeaTDYqHo1t1yIWSzSZUu7
         nT2dIcYfk4cuFMw5ukAhPAg+Bo7qvKKfMWbKndXD53dxfM/lI4nFTKo/UMpM0YCs3vdY
         O9uXPOOWFvcW+0youqgWLGAg+yPoG5Quuoew5mVgPjScWvpeEvZoZujlNRyGsrZ7bKAE
         9geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717779224; x=1718384024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zKL5J0VS9IMV1OYvnpO3g/QFuooLWpL5+qjChKIyVA=;
        b=BNDnP+q8u/je9Q81/hrb8KNmmjr1nWt4albbBb8qEBvuXvWhLnICAlfhZcKdfNwsE4
         87zQ5Q/tdyIUraJu1vxk1kE7P/9irVQsXJqRgBo7fYGmv5Gcbv+DU8YWqiTNnfBsJvey
         kb4mOvI0i32+ehatxqK837oQRnOAelP8FFrhcs8kTJ2B7DXTkLwf3UxH8rgx87am27qW
         GBF4yfEgDk9arYLr55bTJIpfQkxRy1vXjT8i4rdz1YU/VTmXTjjztwK+uRskD1gs/fn2
         SQOigY2hmfV7pLe0wkngWkcg8nxhCJXJzFLhiBC+pSo4wZiaHO8R0dKZNY1jG0pOJVNK
         bCSQ==
X-Gm-Message-State: AOJu0YyXl7BgExo9UTtbIGrOulaqPGoUJ50BKmb3M859wWfoHpxfX3xU
	FRSjgb8lMCcMkMf5VzZHqvOsA3ZrlIVE8+TFOkM1xUkUCJsb+8me
X-Google-Smtp-Source: AGHT+IGsmMGjA1+K5drhyhoucNo7maEUdMsejhDg/QWE1pdSdSn2EN3Rsv6sx1JBL3Z2KZp8HZDkdg==
X-Received: by 2002:a17:903:32d0:b0:1f2:f954:d6a3 with SMTP id d9443c01a7336-1f6d02c06f0mr40489625ad.5.1717779224488;
        Fri, 07 Jun 2024 09:53:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7eda24sm36618155ad.244.2024.06.07.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:53:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 7 Jun 2024 06:53:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Tim Van Patten <timvp@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, druth@chromium.org,
	Tim Van Patten <timvp@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Prevent delayed work UAF kernel panic
Message-ID: <ZmM7FovMyez71TcC@slm.duckdns.org>
References: <20240607104610.1.I6c23f4fdb786f7200f6f1255af57b4e9621bcc66@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607104610.1.I6c23f4fdb786f7200f6f1255af57b4e9621bcc66@changeid>

Hello,

On Fri, Jun 07, 2024 at 10:46:11AM -0600, Tim Van Patten wrote:
...
> Commit 33e3f0a3358b ("workqueue: Add a new flag to spot the potential
> UAF error")added the flag __WQ_DESTROYING to help avoid this. However,
> this solution still allows work to be queued if it's from the same
> workqueue, even if the workqueue has been fully destroyed, which is
> possible with queue_delayed_work().
> 
> 1. queue_delayed_work()
> 2. destroy_workqueue()
> 3. [delayed work timer expires]: delayed_work_timer_fn()
> 
> To prevent kernel panics, check if the pwq and pwq->pool pointers are
> valid before derefencing them, and discard the work if they're not.

Nothing guarantees that they'd stay NULL after wq destruction, right?

> Discarding all work once __WQ_DESTROYING has been set (including from
> the same workqueue) causes breakage, so we must check the pointers
> directly.

There's only so much protection we can offer for buggy code and I'd much
prefer an approach where the overhead is in the destruction path rather than
the queueing path.

Thanks.

-- 
tejun

