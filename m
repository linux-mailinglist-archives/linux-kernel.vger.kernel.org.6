Return-Path: <linux-kernel+bounces-236777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923BD91E6F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA941F237F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238DC16EB6F;
	Mon,  1 Jul 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPPbpng5"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75C16E88E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856414; cv=none; b=Dm3vodHQblqxnGJnVkMloVwwunzjQceGEgi/7LLMqwpesuypIlpc1aMsfPODvKvsPOjxfIMcr2bwepckXi7tjeWluXDU9nHh37PreQKSVWxtqyDgPhzDnj1IaTQiWbR6qsHdiB+topJ1TV2U/EbPEN9y1G7WHshc85Od+A8AI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856414; c=relaxed/simple;
	bh=Ki0a0rivdegP6ZdVVTYc0h2LYoF539DYEwq99jWRT4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOeWP7U5vIcnrmieigzEucp5AWwbrFbYYfD8h4v8hRjrC4mzI1n3/h0y6+bieFA/CeoI21843Aaql/IRdffRliOPJRerUNEqnofYO8I8qb9dl1gGNnFoSUudntRiO3OAixJLVXLDVulDmiGmdyeIY5Mrx8Z/xKN3p+8lGgnvTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPPbpng5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c92d00059eso2035091a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719856412; x=1720461212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6F5DAOoLaB1FuZ5x0v5JU7nd1VPYyeV/NmL4hws5Es=;
        b=UPPbpng52r/zk8wRH2dDLEbZLGURNpR03CF0p8s+7pCfT7g8jugsLPZCD5EUpSgHuc
         Bo/xsaNWVPHxU5q1lpot37SOzh3EaPg9OkDlVJ/2a/Hd6NuTOS8DBu7NAEoFCM3prjoB
         mp74vBdUdMPJLVCH7X/D+eWf2DA/laP6HhuU+KSAyrVlZpx6HEwcRkTGnqVTOsCX1yGy
         g7h+ZaSNlDV5xPfOVC4lusWDuxdfpMCMADioizeWfUCj4nH3O0/PiecMeRWrMJk4ZoXh
         COCDBSkaLfNCcxxB31tdiPfudLXkmFZN1oAj3pvDiVeWbZiTlCbBxwLlvRWC6xUrDuhc
         lI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719856412; x=1720461212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6F5DAOoLaB1FuZ5x0v5JU7nd1VPYyeV/NmL4hws5Es=;
        b=IWpL6Rwa0rYK7g+NnJoC80Me1ZjiUBbOxW3YVieN9zJlPCW+POumx2lH6vgS13ki5x
         nI0G1cAqh5ottTjnpuON0ouuADs2lryQAnBmgoSVV3ULvCOHbcG7LXoy4cEyI/X511wG
         rHAmBgbpu0/9KqDpGvHh+PZkHyQq6o2Ph44KaLVg1nSPFappAseTTTcZJIvkFEvW+G92
         8OvNjScbpR5YcuBgvHlfVvcYBCRnYi506jWSJxIvPG5xVYOEtEYxckUeaosIjtDO6BxA
         rZdAAcnoS0gxv2iy6ENjGo2lbVxZcCG/rZ7Mu2VgbTqWbML0128RrtuNl1AQu3s4XEeo
         E0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeWlUgQC9R6mlgH/fLm9OLPzYPmT9PeM8ryD08LmZZRPuJ3rfdgZ1lCouQI7Zpr3ZMouUR4Y8F27X8+sRXdp8ei0pKJ0sdz9jF0xBf
X-Gm-Message-State: AOJu0YzC7F0VNvUj6bxwEpzS2EyV0uk1tjFN2VZEpUNGshHFkYu587T5
	wfCCY586Pgi8EdUxhVwM75qExeYlbDnX193WP6NC2lSNYdTkCq7wv5pw1A==
X-Google-Smtp-Source: AGHT+IEk2bezpirCnkoJ1+8233fAVectjRnOukFTtCY28y/UBJedEQdoVXAxD0BjbYRmDBAV95yLQQ==
X-Received: by 2002:a17:90a:7445:b0:2c3:213b:d0b1 with SMTP id 98e67ed59e1d1-2c93d729f7cmr3296331a91.5.1719856412341;
        Mon, 01 Jul 2024 10:53:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce778f1sm7052721a91.33.2024.07.01.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:53:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 07:53:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Documentation: Remove
 mentions of scx_bpf_switch_all
Message-ID: <ZoLtGmBw6kcNtmts@slm.duckdns.org>
References: <20240701123022.68700-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701123022.68700-1-aboorvad@linux.ibm.com>

Hello,

On Mon, Jul 01, 2024 at 06:00:22PM +0530, Aboorva Devarajan wrote:
...
> +sched_ext is used only when the BPF scheduler is loaded and running. To use
> +sched_ext, a task can invoke ``sched_setscheduler`` with the ``SCHED_EXT``
> +policy constant.

I wonder whether the last sentence is a bit confusing given that tasks can
be on SCX without setting SCHED_EXT.

> +When the BPF scheduler is not loaded, tasks with the ``SCHED_EXT`` policy are
> +treated as ``SCHED_NORMAL`` and scheduled by CFS. ``SCHED_NORMAL`` tasks
> +continue to be scheduled by CFS.
> +
> +When the BPF scheduler is loaded, all tasks with the ``SCHED_EXT`` policy are
> +switched to sched_ext. By default, if the ``struct ops->flag`` is not set to
> +``SCX_OPS_SWITCH_PARTIAL``, ``SCHED_EXT``, ``SCHED_NORMAL``, and lower class
> +tasks are scheduled by sched_ext. In this case, all ``SCHED_NORMAL``,
> +``SCHED_BATCH``, ``SCHED_IDLE``, and ``SCHED_EXT`` tasks are scheduled by
> +sched_ext.

How about something like:

When the BPF scheduler is loaded and ``SCX_OPS_SWITCH_PARTIAL`` is not set
in ops->flags, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE``, and
``SCHED_EXT`` tasks are scheduled by sched_ext.

> +However, if the ``struct ops->flag`` is set to``SCX_OPS_SWITCH_PARTIAL``,
> +only tasks with the policy set to ``SCHED_EXT`` are scheduled by sched_ext.

And update this paragraph in a similar fashion?

Thanks.

-- 
tejun

