Return-Path: <linux-kernel+bounces-217718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284E90B358
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246F91F22514
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57001474BA;
	Mon, 17 Jun 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CEOPCv9C"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7B14532F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633863; cv=none; b=qn8yRTV4ub423hQ2ruxta6t7YAuSZZP4gO83ersVGySqo3/rXjisvRfo+GgqF7ZLxaV4vZYb3NXgjGh3ZvTFv9TTJJfdyoE0wNvkVwU6ES2UoZqD0p12CpJNkPJ2s6yxSVTtmpOfhWuABRbBgmFllfzPqb+BFdCpTXk0lWrkIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633863; c=relaxed/simple;
	bh=gJB3RcNBcE0/JpE/eNjRla9bs9uh4t4dRien+AQ6M84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwWONP39p6xJ7n48L5Kb5NEx/01lUoYbDaVJ6TRAgPbNp/eRaQp5Xf4m7zlPgphJx4/iGrbXr73rIqeEcKPZtpbpsk/LnwEZo/qYhHKnryHsO4VspU3oYpTMoYmrPcMljh0IGpe7xDPPPQoILTJ4eHv1xOBO49jKQCKCA+BB/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CEOPCv9C; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7960454db4fso264578085a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718633860; x=1719238660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJB3RcNBcE0/JpE/eNjRla9bs9uh4t4dRien+AQ6M84=;
        b=CEOPCv9CIojuITA3pObhkOe0s+8H6GZ+LmQgofJdIqT7KuDzDlHvQN1W+gAmg3clgr
         i7wSkPSkQel9Cotdgnrihmkvj7yxi5685vyiZTBZ8VzbCUuD7hhfJgd7CmxdJ7NbyApt
         Tve+MnzYU8oIGUaB4M4tftj7HXXWTVygpzYaJFMSmg4xdXLTc/p8WsziLJA/Q5gJNhLa
         UEPIrd/01vyT4EvW5Kjvk4WNSSYc5bjVosKsRTulsmGiem/MCnT2SgrzSxOvOvp7XGBw
         OkNsVpRcYwkPpcTNFJzqH8+xC7M2PikvBbWDXW3WZoOsFWfI5OXAAZFTDXfEXgGNTugM
         BH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633860; x=1719238660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJB3RcNBcE0/JpE/eNjRla9bs9uh4t4dRien+AQ6M84=;
        b=QKA3mWD0Hnbeg8CHuwfkreT8wGOk3bLZ+6U3qxoZRMucgaONbrIUNGGWWuhI40cRij
         2C6jXH8F33ITQFZmSX16POjvqPM2vnen3xlqMhgCE/YdgrPZtuiQHx1sZZBtBouG3rSb
         VKehVmG9jCuNiiMI05dmGUtVZic153s/NCpKHdqnKYBJ0r5vtKqKUmelvada4DNlMOYi
         N+vkQ1mI1VBWCSf2dqItcHdYwEupXnBbma8HFzRFMLlITbG7qKWJdjZoU+6MpPD5yGT8
         4NOFThv8bHDa29JmJW0kHDGpfa1bmv3+3JAZ7+kQ20bwt6zLg9HZLJY2o6/do5jrfFJr
         p8QA==
X-Gm-Message-State: AOJu0Yw3u4lcXupp3J4id/ySq9du4w1tiIKNg87nLsR/yipLiDD9F3zz
	tphB82/DAUi9QSUua4oDzIt2IHSgvVIl/7491HP7zvYZ+ELJrO4AlHNRpLLUFH8=
X-Google-Smtp-Source: AGHT+IEeVElDnFU6HjCerK8KBYMeNyuzItK5u6pJekKDgwB6IP+lwMt8s0nxNZxohhF7K6rO8Pl5rw==
X-Received: by 2002:a05:620a:248b:b0:795:59ca:5066 with SMTP id af79cd13be357-798d258e2e6mr1129033085a.53.1718633859951;
        Mon, 17 Jun 2024 07:17:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4420c5e8e4bsm45859201cf.39.2024.06.17.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:17:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDAw-008eAR-Pl;
	Mon, 17 Jun 2024 11:17:38 -0300
Date: Mon, 17 Jun 2024 11:17:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240617141738.GB791043@ziepe.ca>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-12-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613082208.1439968-12-oshpigelman@habana.ai>

On Thu, Jun 13, 2024 at 11:22:04AM +0300, Omer Shpigelman wrote:
> Add an RDMA driver of Gaudi ASICs family for AI scaling.
> The driver itself is agnostic to the ASIC in action, it operates according
> to the capabilities that were passed on device initialization.
> The device is initialized by the hbl_cn driver via auxiliary bus.
> The driver also supports QP resource tracking and port/device HW counters.

I'm glad to finally see this, I've been talking to habana folks a long
time now to get this worked out!

This will need to be split up more, like others have said. I'd post
the RDMA series assuming that the basic ethernet driver is merged. You
don't need to combine basic ethernet with rdma in the same series.

Jason

