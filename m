Return-Path: <linux-kernel+bounces-174194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62A8C0B85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3515A2841BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0298662E;
	Thu,  9 May 2024 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KKH2leG1"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26DE624
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236224; cv=none; b=T18N9DYM5CP+7zv3xotNnYSwJvxWC/yMJfV/P6of7mSB3pAT6mqRUhPjBaWOp4uDXdIhfYz4Kj9J4Y2bKAJr4G1vZH0sBcAY7noKYv9Y6iFqf+8u3yWhCo86NnTom3/0UkJzulCi+XzTCQJWWpSZpbRgOMy1yd3wjsi0bK9rYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236224; c=relaxed/simple;
	bh=n0yLBLsCcWZoXT34oLNGOKh5OKX0+BXthBYvmA190hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaPoCFLVWRweTQrbHW4kY/GnoP+GIei5ZCCnDHgEQ9TmBPsFeupP8C6HY3A4yIQVdeZhm668ntzw9AHF6QfGknG9xpIrGUy/4cYsn9TlpH31XdbFnwWondn6R6hCMU6gjBJhmz4sDgZE38ychvkw/pI1L8U9x2isEDrLw+6KGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KKH2leG1; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f0307322d5so301387a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715236222; x=1715841022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qoYQ9U2MlC2IsyOoGY5lXnwSMtPZXtV4EZE56MKyN8=;
        b=KKH2leG1H5mAm1P/La2bBB872AjGrZ/gxtz0Rd3W3tUxRz5vU3LV++FX/CDputlPQe
         YPCltQRmlNaEBkGl/12VcgxEGfvA/NHPw5FnNKfVyiRMb3wfPZH/Yu3BDqOVMB02Krco
         NMZvr5HhAzoFQU9ENuxvq3lYX/hEOiEvfBP9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715236222; x=1715841022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qoYQ9U2MlC2IsyOoGY5lXnwSMtPZXtV4EZE56MKyN8=;
        b=nDmjlgZjUaSOj3ahzCpw0fwjuu96z7E4a9RHvvEZtQuSyzBGrz4UO3cFcC9xg4ib5E
         an3SxzEkzxHAfR/cuS2TLNZP1KbIp/Ia739X3siZ8GfEYbe9p9JarQLYrqScrqvNaHfe
         GBjFbngXh+20Quzo+aqIlUplrPkvzZ2g1nLCbTOCtshViTxnzCbAdMDLl54kCa4J2qoq
         4xvLZGtUpdVaz4GYzZWmwwICMCwVcJHRjccj8YmXuUfhyRZYbQOfr0r4zY3c/F74oJdc
         be4Y06tcypmVPojG/V9r6OdNy9qyL0fvxIZXT39YNKz88D76zYmnluLGLh6ggFrW2IVb
         eEUA==
X-Forwarded-Encrypted: i=1; AJvYcCWMMkyMsPb120NF7jq5DNi1BkJHkmyVuMIDvw7CxMtoOKMk0HZ0Hn2SwV+3HxjkzgvlLuoWsZpsu1sTrYk6WGU1lIdO/cE4nACZdvb6
X-Gm-Message-State: AOJu0YxI18qzcowyyuOBCESBmRIikbDP4dQ+FBIkMmLYlpLaGi+XcEJ+
	zFN9amgBPR0DaS3jfa6UdoWlOMNsc37gkLVHoZr0dFn7boUiMwQZsfmQbmu/Lmc=
X-Google-Smtp-Source: AGHT+IFDgooGY0GwBc2iJimptTybd/gNtDtCFUTE5EpIKrrUwbabTOKQRU++5xWg2GQ02FIt7hW1VA==
X-Received: by 2002:a05:6358:890:b0:186:2ac7:316c with SMTP id e5c5f4694b2df-192d35776c9mr580862955d.20.1715236222043;
        Wed, 08 May 2024 23:30:22 -0700 (PDT)
Received: from ubuntu (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634119041b2sm484067a12.94.2024.05.08.23.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:30:21 -0700 (PDT)
Date: Thu, 9 May 2024 06:30:18 +0000
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjxtejIZmJCwLgKC@ubuntu>
References: <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <20240508175638.7b391b7b@kernel.org>
 <ZjwtoH1K1o0F5k+N@ubuntu>
 <20240508190839.16ec4003@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508190839.16ec4003@kernel.org>

On Wed, May 08, 2024 at 07:08:39PM -0700, Jakub Kicinski wrote:
> On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
> > If I'm following that right and understanding mlx5 (two things I am
> > unlikely to do simultaneously), that sounds to me like:
> > 
> > - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
> >   priv->channels.params.num_channels (instead of priv->stats_nch),
> 
> Yes, tho, not sure whether the "if i < ...num_channels" is even
> necessary, as core already checks against real_num_rx_queues.
> 
> >   and when
> >   summing mlx5e_sq_stats in the latter function, it's up to
> >   priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
> > 
> > - mlx5e_get_base_stats accumulates and outputs stats for everything from
> >   priv->channels.params.num_channels to priv->stats_nch, and
> 
> I'm not sure num_channels gets set to 0 when device is down so possibly
> from "0 if down else ...num_channels" to stats_nch.

Yea, you were right:

  if (priv->channels.num == 0)
          i = 0;
  else
          i = priv->channels.params.num_channels;
  
  for (; i < priv->stats_nch; i++) {

Seems to be working now when I adjust the queue count and the test is
passing as I adjust the queue count up or down. Cool.

Adding TCs to the NIC triggers the test to fail, so there's still some bug
in how I'm accumulating stats from the hw TCs.

