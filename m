Return-Path: <linux-kernel+bounces-176825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860448C3580
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDCD1F21364
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041219470;
	Sun, 12 May 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EP4NhPXr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70785DDB8
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502050; cv=none; b=NvepmTufeQ4aJwa12DcI+JvPijloiTKfRtLtmUqSyEuSLtduvBP+KmfHfWyPopiJq31sFQfoWdDdV67NY0BoJgdATBlHrpVmzQ8ZOhyJIdEq5XFMrgGIy/PxEMesUbO9ECFODbmj1LcTGRi0zxgp8ujvbPMssWkhxFc6brUj898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502050; c=relaxed/simple;
	bh=57aIvZSlXvHd2XNr6XUvBTj1SaQbsmoHThuid5rkxjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXWhmCfGHa+psgFNoI1oHejSHUav0TkNaIec8Yn+OaYGN7eGirCn9IAYbjpaU8RdtdwzVtKx1DtsSmEO/3xv23F03yNRhEkwaUu6IZ2VyqxQf+S7xltg6ow9o4ZndHU6J3lMLrEY0cgVcaUCAdv50BQd40OTqzkrKHLydJTaeUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EP4NhPXr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59ce1e8609so766656966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715502046; x=1716106846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aA2OPIGe9/26kCTNuDnbmS99Q0tmMHaLiwj2IVXEJuE=;
        b=EP4NhPXrgCh0Y+nCrC/A+xOYfqnHp3W77DPdncZCfvE/5ZlUzliAKU4SgrbH6uaU/f
         JvOclsTe9KLMxcpaV2B7wEum5yskQ3samvYxcydNV6OhJi2gRZUtnERhovVBk3QHPPdI
         fBdeGsrH93lAMjqtcP03S331ukgQ9M1AEWqrQBEBoPW8QXtDWrLoAeunquR+9X1MDkdI
         Vteh+s9fD+SDe5Y91NzIe78od3RSswcb8k9AZLM6H4xPg8W9fT1pds6U0AYgipQFpYgj
         2gq4xzsWEV3oWP4wP3ijrtxi095VJxjviTQbP9YWEBx0NMAqVQ7p1C+FhzcnyCYRBDx1
         zNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715502046; x=1716106846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA2OPIGe9/26kCTNuDnbmS99Q0tmMHaLiwj2IVXEJuE=;
        b=mkGeeulXouSW/OgHn+ogbjYO/eUokdiHzDvVXtpb6FWEZKMhOGptn1tbL+tpoMc+ck
         rXW7eF7kBi9ZaBVX0ZWy8BEQlZMd/b4FbCvNSXVJqZCJ0Yf90zHOKaLB1cjLr4J16SOk
         ZLwT2qbeZqeo6rcbBAyWHTiKmFnb8xK5exk65kkd7/ERj/bu3T+hgT/TWlKYD9baqJ6N
         dqBpAFSk8XqOXY1DNKGryAkCxABo4SwNk/vjKt7ei+BbbvqjW5/LW66c5cXjIpeT4ZOu
         DW1ajjuIdm56xzOCGpN4pOmXRLNkXld73YrNlB3eoEMx8xTTvDjbMl6PWFxGUzIX8XI4
         wkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyS2DI4dUJjlr7GjguQiJBNvPEBsLUxGP3rIvMCGO82h+tWZjg72HxtdLu2AONvEJQl6Wo0Wxr0WPdP9o1yRRCh/VjO9y4VYqzNY4t
X-Gm-Message-State: AOJu0Yy3sx1u3zvU3XXJa5aTiQmGOoJ6lVVXaAcWOo/kIxAPFP11sx8S
	liSyEA6NAshOlJwhYcfBxoKIb6NxiWMUYxmqxfDiHukjfZgQ0inerol6Q2j76Os=
X-Google-Smtp-Source: AGHT+IH8IAAcuq0uwpTf6fMx0D8wB462+TGmZE1W/D5t26zWbQkpZSc39eY03aIz5zXbSAbXfLd1/g==
X-Received: by 2002:a17:906:57d4:b0:a59:ba34:f047 with SMTP id a640c23a62f3a-a5a2d1de87dmr521612466b.22.1715502045535;
        Sun, 12 May 2024 01:20:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01399sm438058766b.172.2024.05.12.01.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 01:20:45 -0700 (PDT)
Date: Sun, 12 May 2024 11:20:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: Fix error handling in mlx5_init_one_light()
Message-ID: <38283c14-c8b2-4274-9e34-9d5951816a59@suswa.mountain>
References: <a2bb6a55-5415-4c15-bee9-9e63f4b6a339@moroto.mountain>
 <20240511142304.GH2347895@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511142304.GH2347895@kernel.org>

On Sat, May 11, 2024 at 03:23:04PM +0100, Simon Horman wrote:
> On Thu, May 09, 2024 at 02:00:18PM +0300, Dan Carpenter wrote:
> > If mlx5_query_hca_caps_light() fails then calling devl_unregister() or
> > devl_unlock() is a bug.  It's not registered and it's not locked.  That
> > will trigger a stack trace in this case because devl_unregister() checks
> > both those things at the start of the function.
> > 
> > If mlx5_devlink_params_register() fails then this code will call
> > devl_unregister() and devl_unlock() twice which will again lead to a
> > stack trace or possibly something worse as well.
> > 
> > Fixes: bf729988303a ("net/mlx5: Restore mistakenly dropped parts in register devlink flow")
> > Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Hi Dan,
> 
> I believe that after you posted this patch, a different fix for this was
> added to net as:
> 
> 3c453e8cc672 ("net/mlx5: Fix peer devlink set for SF representor devlink port")
> 

Ah good.  Plus that patch has been tested.

regards,
dan carpenter


