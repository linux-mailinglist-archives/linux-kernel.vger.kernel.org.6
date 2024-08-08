Return-Path: <linux-kernel+bounces-279768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D194C1A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA801F216FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2418FC6E;
	Thu,  8 Aug 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GWvqPz4o"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F618F2E2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131713; cv=none; b=B0/7KaGMRB4tfaWxWtZd5MNwgl5VfLBjSwbzZ6xgp1kvJX+i7DXJNyrnHku0La6yft90jPgjfSV6dbPYe/f0BdEjCPNWpE1bTMJ6EuHyFk5Ffcgl5dtrvg+h1wnpnsxGEjJrbQKwQQ4UW86SiH81sOs4ws7lxUYnq6JiEQeUbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131713; c=relaxed/simple;
	bh=rtTExVLo+hS1OIsTwFv1tJj9WvfWJPNeZdFtX0fWwiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8iE1FHVmS4wR9iD6PjrJQ7VjYdvv/YF2UlZfCQPXzuE9fiCIMBQ1Zbwz1pY8a/5OqAysI9tRUDBNU0+gJoh6NwohJjfdrQJY3cwWb7TIEfLbPfBaRCZkilzuTohj7TbWf7LlEDZf8AzRJN03g2RWX1CLnjzAJGNrBM0KmQP5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GWvqPz4o; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so1786028a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723131710; x=1723736510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23S22PmsuwkhNMTYFfJHzLRvP5wA2dHLTYMLULxZMKw=;
        b=GWvqPz4oWtT3iUuZt5zk/Ks8QgK7DDy9u0xxE1jypDqs3FtTN39Z35jf7R7a0vxo7j
         1wrFWfoBL1uJDVTlnQ9VwLFCQF4+g17vUtQeb0Mjc3S8cshkL0CRVEWg0WkIa5jOL9Ov
         K8xzV55sKmDw3udJqiij3Hhko8Ku9mbz3pW72uQ/Tn5OFOUc2K426l4ljcozqbHYd+kj
         O1/zuCO5v+dxAAYT5Cuko/McywdLDd5qn9UYe/UnZcd41EjrJzIFZPCTGiFF2IEBK8oQ
         +yBGBciPAJUXJAI3SFejONqIJ6Q6GB8ppgtHhXtEJwwxouDIB995JS6ayHVUHfviwhoz
         xx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131710; x=1723736510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23S22PmsuwkhNMTYFfJHzLRvP5wA2dHLTYMLULxZMKw=;
        b=XONz+u1AVuEiEatFgGtkujFYxZykavo+OVT0lbnYc3PR3QbxV+U941ZHRSd7iNopJA
         xpkMF4LhX5opitStNYYK6U9lfLI50Crlne0uC6qZNcCir6Qh6ZmnoZXFOpF2yxUgY/5J
         e+X654bpbFKK/ogqD5vkbhB5k2ZTtct4CMEczlALLKjSKzvGyKrbp1pMYJImwFUu6Jx9
         weADfh76gUKnQskzUdih3SfTG6yvgAWJehWeC0wuiC5yHC7M/95vzeGiN4yF1Nyh6KxR
         IB4w6cjq92gb9zb/TIwFNNPx3Tdi5JHKJCNSF7IJJpsDNEsyAoXVXc2aGn0ykaOan03U
         pDqw==
X-Forwarded-Encrypted: i=1; AJvYcCW6+Ze/k+VVtLo/yPPwYJbTRHOd7t2n8JvzTbkUHVb5lzALj9B1qyITLk2GF76TBHnjne11KTfnX5DYHf8ljDBllVS45/2CvBP0QZj5
X-Gm-Message-State: AOJu0YxqehkuYMdtZPrMYY84MMhViw2bg7McNXqBZAhxtaO5F6zYOcyH
	nrw2vqW12BrVA/Pv+AxGYeTkeXPvi0HCS3+CultbyuiMq6OxHLKnez/Atj6Glts=
X-Google-Smtp-Source: AGHT+IHWpAvpASeq/K/z3dnXxa1G0aOGOC0Q73UdhcllZot9CEE7t1yteFz5RcP3R3SA5p8jx/ojsg==
X-Received: by 2002:a05:6402:1cc1:b0:5a0:d5f2:1be with SMTP id 4fb4d7f45d1cf-5bbb3c109f6mr1665835a12.8.1723131709692;
        Thu, 08 Aug 2024 08:41:49 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf8e52sm740454a12.4.2024.08.08.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:41:48 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:41:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v10 01/11] octeontx2-pf: Refactoring RVU driver
Message-ID: <ZrTnK78ITIGU-7qj@nanopsycho.orion>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805131815.7588-2-gakula@marvell.com>

Mon, Aug 05, 2024 at 03:18:05PM CEST, gakula@marvell.com wrote:
>Refactoring and export list of shared functions such that
>they can be used by both RVU NIC and representor driver.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>---
> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
> .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 --
> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  47 ++--
> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
> .../marvell/octeontx2/af/rvu_struct.h         |  26 ++
> .../marvell/octeontx2/af/rvu_switch.c         |   2 +-
> .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
> .../marvell/octeontx2/nic/otx2_common.h       |  43 ++--
> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 240 +++++++++++-------
> .../marvell/octeontx2/nic/otx2_txrx.c         |  17 +-
> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   7 +-
> 17 files changed, 266 insertions(+), 178 deletions(-)

How can anyone review this?

If you need to refactor the code in preparation for a feature, you can
do in in a separate patchset sent before the feature appears. This patch
should be split into X patches. One logical change per patch.

