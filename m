Return-Path: <linux-kernel+bounces-226359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2E913D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBCB1C2110F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E81836ED;
	Sun, 23 Jun 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU3Wxznl"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C061822F5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165246; cv=none; b=EwS+NcGW4JrgS1MMTQGLJ6s5YuHgRPAl2af2RIPPDjb5MCVYZAf/cCpogdfGIh1QcH9lgO4RpnO1tH81U9mgICPKNkZlLn6h3wRd+YRgrh4Mixg4d7Zv+i8K0uk46rTnl/l2kWHtG3uptZJsMGg3Q/tc+RcYnqrPBII9TGWadOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165246; c=relaxed/simple;
	bh=9DxX8i8QUC2u3KUw1rAinLr206VgomsM3i58xY857lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuUFcdlw1N8mqozdFXQ3gxWMU+Vv2+q5B8w8tv/MBJJZRkYSHD40S7fRH1/F7O4MIeUoq3GhR4URZe8WeaNPquaZi5I10DIZk5I0PI7L0U1hfmgzfubXKzBZ9LoLwhq+90LmC1CIt4WGbNNFLpTbjdlgcbyHBeIdZPDkRIZen+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU3Wxznl; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375af3538f2so15406805ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165244; x=1719770044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol/brqLUSGHQQ/mBHwJxdgd6srh9Hoz6NAQYQiPMCNY=;
        b=PU3Wxznlvh9MNzjtG/6LWOyo/G4VQ0W2dhYThBCiBk6ffFqWTcJLLvsstM4ZzGSHZP
         dKwzc/slJ7BH2PJJ9U2dmYdQEQ4JSAxaaIxRqbNxmibhGGb/9C9JvsRNxZWvxgwUcXhA
         4omfckgdDd6SVtHiTz1R6VY4hufxq7mJbIOIjocbWEywkEH3IzKa1cvClW7V53oHqJmG
         YfmCWnDduUqbPlu9Otgul/PF+WDpoZ+4yps94iXVtbuy04TErBUqWHw36QXh+L8HtOrk
         vdP3tyeQnwIMPZPQxDSw5DtQNCTAIuR2/tGKkSQ9TrsRvosa/4Nc590ANSn7WLOxU5Bz
         //YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165244; x=1719770044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol/brqLUSGHQQ/mBHwJxdgd6srh9Hoz6NAQYQiPMCNY=;
        b=cFDoW0Alr7d4cwpLiCu7i9VfVAA01i9qWL+CB6J4IIkRaS164vxheyhIz95LTuoFrE
         vcDvEHcGi7vonp3drfOLMmUlMIjzkKMs0rIqpjlKkFs+Qh1QXFsE89Ajn1PZ22YsKIx5
         /iXySrNtN15aYxWeXrFxSoU66cfrLZGYt9wGT0omE0TvyDuqf/GuPATllzaAJk21Yviv
         hQTGhOJcp8EhaH4HqMz6nmxsTdPTYyDM/AyVoK4NI4vEe+ZRbj8OG4mZ+Z7rcF+D++dS
         j4HOMJPLos24CJVbnpuZ/GCwmx4mdFG7ue4kgEm4X3477bXHLcxMX1slHZXubGIQm+xP
         Pp2g==
X-Gm-Message-State: AOJu0YycovkGdLFSt4zuhOqCq8qc0NadQ0bAVD1p5I/QoxAKI3e0AELa
	zrSw8nXW2AwmHkb82xtDa3HXnpnWFNigX9MQ6pG61SuM6kH7FqbE
X-Google-Smtp-Source: AGHT+IEz5f6GwOBvm1xtFyYk56UOOVOTbBZh/j/4s9NnX4Zcn7Anlg2D7T+Ox9F0wb/Q+ZeaB/hXrQ==
X-Received: by 2002:a05:6e02:12ec:b0:376:26f4:d050 with SMTP id e9e14a558f8ab-3763f5c00d6mr36436995ab.12.1719165244099;
        Sun, 23 Jun 2024 10:54:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f2c8csm47874045ad.50.2024.06.23.10.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:54:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 23 Jun 2024 07:54:02 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] sched_ext: Make scx_bpf_cpuperf_set() @cpu arg signed
Message-ID: <ZnhhOi9BdC6CNFeo@slm.duckdns.org>
References: <20240623081036.51867-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623081036.51867-1-void@manifault.com>

On Sun, Jun 23, 2024 at 03:10:36AM -0500, David Vernet wrote:
> The scx_bpf_cpuperf_set() kfunc allows a BPF program to set the relative
> performance target of a specified CPU. Commit d86adb4fc065 ("sched_ext: Add
> cpuperf support") defined the @cpu argument to be unsigned. Let's update it
> to be signed to match the norm for the rest of ext.c and the kernel.
> 
> Note that the kfunc declaration of scx_bpf_cpuperf_set() in the
> common.bpf.h header in tools/sched_ext already listed the cpu as signed, so
> this also fixes the build for tools/sched_ext and the sched_ext selftests
> due to kfunc declarations now being emitted in vmlinux.h based on BTF (thus
> causing the compiler to error due to observing conflicting types).
> 
> Fixes: d86adb4fc065 ("sched_ext: Add cpuperf support")
> Signed-off-by: David Vernet <void@manifault.com>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

