Return-Path: <linux-kernel+bounces-171726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C108BE7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02291F2906D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD316ABC8;
	Tue,  7 May 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JVu7CEfJ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2087165FB9
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097193; cv=none; b=oQ4/Ho9iiRygV/t+OqLxwroxviYR80M0VGLt/P46ZSFG6vk9GHwpRQlBDPX0aumlJ695h/ZdBfdtuqdDMRaBDgBQKUPl2lpcSD8el3Hz7HyB97FCFUJmmTaa07nN0DBfvFuM3SVsQtEq6Dy5Z0OQC11jMKMVC685yurS64rALi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097193; c=relaxed/simple;
	bh=qLWsgQtbBtvs94ItOt9M5e4lJPvBuWWvYvSfSarFvB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvd7iIT8czPNZiM3TqAqn5r/+gBFHKTSoCJXo8h25Vosk4+lfma7t32h52qSHj+ciDd28xLtyka3aHohm+2NR+4miSgatST0/Hof3l1LiiTBwaMZDxaGrfISZ9jNdEU/oWuDoFnpO8usIRrjZeFhmHg9b/wTYO5cgFCI77q9vV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JVu7CEfJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4551f2725so3188270b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715097190; x=1715701990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOHm2DakIrhZcNVck4viPIx9YeHbZbB/CZturHo1oZs=;
        b=JVu7CEfJFm5GfRrZcJwB3BV42NqlhBeL1vwr4jr5WkdtAXHyhQYn+ZEdqWkvXKI4ux
         0+ikDBFNCjIKzzbEHe0EopwcoZrE79MuBFrWcpa21yV30A5HH+QKY6v5KefYkXFYMBU6
         Ex7qOEdRVC7RmN/Kv+3uqfKkCjZVAShkHlS1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097190; x=1715701990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOHm2DakIrhZcNVck4viPIx9YeHbZbB/CZturHo1oZs=;
        b=VJY2tHJpw+NUUwVWKkj8jMN2H7rMNXQKcjO4PeP7gYtHm72nZPA1/2Rm7Aw6nTAlid
         0b4IRd8SPYxK09yZdTgY35xi3zta3vJ/bBv24CR9mjhRXNj6EitViyJdDR28SN6NaYfp
         fVLaIUbK3w1ciP434qmEG5vMIxFFh4t2HI43MRbUFio+4nv4GkkaP9suEq5WNClclvGJ
         Jiy8t2Y4lkU73UKrxV66PI48Oi4I/RaUm81VbHJ7IuoyrCH/jubSruRzFPbsxUuwuZ99
         a/aZNIGtNpTToWc6KZHpP/dLhHftjN++6SJm3MsUgVsId/cUuvGYpwxHwkA6WyS1N+Is
         /Gpw==
X-Gm-Message-State: AOJu0YxRZCTEy39Nfs5fMRAWuM9AbdZz4itZg/ajJ20kb3FdpIf9YlP1
	lH5uUaiTUdexzxa7kM+vFZNmTpelzPmaqBYSqd8gfYB+N4Z6Nc7DRogHxsZYK3Q=
X-Google-Smtp-Source: AGHT+IFVr4swRlKhpNWtKXte+NmZTl8T548Ki1zg8M51GULQ9pwbRExIpW7LVzMelr0rEGLFFcwCHw==
X-Received: by 2002:a05:6a21:3d87:b0:1a9:cd98:5cd7 with SMTP id adf61e73a8af0-1afc8db5bbcmr92325637.39.1715097190098;
        Tue, 07 May 2024 08:53:10 -0700 (PDT)
Received: from cache-sql13432 ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b001e28f7c4233sm10142992plc.236.2024.05.07.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:53:09 -0700 (PDT)
Date: Tue, 7 May 2024 15:53:07 +0000
From: Joe Damato <jdamato@fastly.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <20240507155307.GA39934@cache-sql13432>
References: <20240502212628.381069-1-jdamato@fastly.com>
 <20240502212628.381069-2-jdamato@fastly.com>
 <ZjpMW7KKdtfXv2dd@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpMW7KKdtfXv2dd@lzaremba-mobl.ger.corp.intel.com>

On Tue, May 07, 2024 at 05:44:27PM +0200, Larysa Zaremba wrote:
> On Thu, May 02, 2024 at 09:26:25PM +0000, Joe Damato wrote:
> > mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> > fails but does not increment a stat field when this occurs.
> > 
> > struct mlx4_en_rx_ring has a dropped field which is tabulated in
> > mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.
> > 
> > This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
> > dropped field for the -ENOMEM case.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > index 8328df8645d5..573ae10300c7 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
> >  
> >  	for (i = 0; i < priv->num_frags; i++, frags++) {
> >  		if (!frags->page) {
> > -			if (mlx4_alloc_page(priv, frags, gfp))
> > +			if (mlx4_alloc_page(priv, frags, gfp)) {
> > +				ring->dropped++;
> >  				return -ENOMEM;
> > +			}
> 
> Correct me if I'm wrong, but ring->dropped is added to rx_dropped stats in 
> mlx4_en_DUMP_ETH_STATS(). You have already established with Jakub that 
> allocation error does not mean dropped packet, but the counter contributes to 
> dropped packets stats.
> 
> Also, I do not think that using a `dropped` counter for something that does not 
> neccessarily result in a dropped packet is plain confusing.

Fair enough; I could add a new field called "alloc_fail" to
mlx4_en_rx_ring and increment that instead as it is, according to the
earlier thread, an alloc_fail as far as netdev-genl is concerned, I
think.

FWIW: I had spoken to Mellanox about this off list many weeks ago and
they had agreed at that time to this general approach. I haven't heard
from them in some time, but I am open to something else if that's the
blocker here.

