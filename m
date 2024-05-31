Return-Path: <linux-kernel+bounces-197299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B028D68FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10FB1F26A29
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A7A7E0F0;
	Fri, 31 May 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hVxI+mdJ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9403C08A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180241; cv=none; b=MrncNsvscWoM5OQpXswA24kCyyHbOfziOv9Eo4zFGUsnC3lHtbD/3gpipRanLQYMhi6IRc63rm1ZYJSgXKYfM6uFOl6X3XXE/ogD7/NZ4qN4/GaTdbmPrImMe6VG+mX3a1HZ4KTKwJT/4P1ObdyqAQaCdIzTUzKNy59sY46i0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180241; c=relaxed/simple;
	bh=YT/aQN35TGh8Chsjf5M28KpRij/hRyTR74fXiC+CKQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH/giJf0JldxR9AvSOk2zzEjmU6HiopkPDAPgmlnyvsPkMAKGeOy/aXagBaBBuCWNkvUmMa/V1CWAVZWX5CXXCxrb9fPWsW5oIf7rRRClHnGhUJ/EESRcU6Lkgaya/dlc03Lw2ROslN3JQXQxdpewFbBIaURo3FN7thaiXieRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hVxI+mdJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7024791a950so669191b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717180239; x=1717785039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKzaRn43o/9ro5kVoZpov9f7l9ZGcLQ6ga/P6WrvCMw=;
        b=hVxI+mdJ1JIHQavwKz0L9E3mr8D6Y24GZINoIG2f+HjNFD2oOo5KY+JwTC9U2I8Rwc
         6KvUoKgH4SpFXFJnRcwhvFB5Ikwp38pMSgf/zPfWJTO2cBNPggJ5qy6rxr50BWUEot1q
         NLlANUMtvCChSPin2ae+wVyWC1PdZJYt7n+Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717180239; x=1717785039;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKzaRn43o/9ro5kVoZpov9f7l9ZGcLQ6ga/P6WrvCMw=;
        b=ovNGf9T3NjMTG7eoJ5WtTPvW0oIgaTk39D9lAjD9GuHCEXnKiQukgo8wCrEKACOH7O
         /Dg5Eg7bcKLSgEqIteto4M7vUePEQBojZv1B0L0Y+vL8GyxIcqafDefUq60vqBpEAGNx
         h88t2rgNAbGoNzP/Sb2mLpRNXxsHuWrZozuYKvyRIWi/VcGXp364NeIRkt2Dlu/cdyc9
         c+6CcPuSve0zH6+JY8tZsijEPIfbRA3z/hZLnBJijhgyeoJ+PdEEA4DGnXGKMmO5roRw
         v/psyXwHytn36fT+cwu072Nceu3cghiIIJF4fL4xUqc2MqIf6SIN9A1desHUFlihHd9t
         4T7w==
X-Gm-Message-State: AOJu0Yw29m+m5AD4++FONxel6nfvv/XqJYOKyTgGGL8LQcXWuilPC6md
	wV4/LO5Cc625ZTG4aa4PcDnzHHp/m9CDC7axKKKKFdafzKv1pI/5F4qnN0QgcZs=
X-Google-Smtp-Source: AGHT+IHDAof3GghhU3bST8irgoZ82PH9+1MMNRPtS18E3V7MNmIpQbpjcgm+hwpgfDuo91V5+iaOPA==
X-Received: by 2002:a05:6a20:ce4b:b0:1af:58f8:1190 with SMTP id adf61e73a8af0-1b26f12a98bmr3112042637.12.1717180239224;
        Fri, 31 May 2024 11:30:39 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b055dcsm1721722b3a.172.2024.05.31.11.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 11:30:38 -0700 (PDT)
Date: Fri, 31 May 2024 11:30:36 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <ZloXTJmCJlvh2AGP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240530171128.35bd0ee2@kernel.org>
 <ZlkWnXirc-NhQERA@LQ3V64L9R2>
 <Zlki09qJi4h4l5xS@LQ3V64L9R2>
 <20240530182630.55139604@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530182630.55139604@kernel.org>

On Thu, May 30, 2024 at 06:26:30PM -0700, Jakub Kicinski wrote:
> On Thu, 30 May 2024 18:07:31 -0700 Joe Damato wrote:
> > Unless I am missing something, I think mlx5e_fold_sw_stats64 would
> > need code similar to mlx5e_stats_grp_sw_update_stats_qos and then
> > rtnl would account for htb stats.
> 
> Hm, I think you're right. I'm just surprised this could have gone
> unnoticed for so long.
> 
> > That said: since it seems the htb numbers are not included right
> > now, I was proposing adding that in later both to rtnl and
> > netdev-genl together, hoping that would keep the proposed
> > simpler/easier to get accepted.
> 
> SGTM.

Cool, so based on that it seems like I just need to figure out the
correct implementation for base and tx stats that is correct and
that will be accepted.

Hoping to hear back from them soon as I'd personally love to have
this API available on our systems.

