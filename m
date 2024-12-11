Return-Path: <linux-kernel+bounces-442207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99039ED94F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CF8282405
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB51C4A20;
	Wed, 11 Dec 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U1h6E/oK"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961E1D88D3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954740; cv=none; b=r6dWWKQGRgo/rjJ0IVw8/j6OrVMH3I6un7tU0AOEy/d3TwDI+6S74Y2LPr3iRe+X6U6CQ7UFnlychZN7gWTBFwBMOhruP5PRxYYQqdfo3KvxKbtVBWGCPAsL3xRSOP9tTCdWpgnDBG7QnN1TcEQOP7LeHGrfNxO8Vbt2yZHhPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954740; c=relaxed/simple;
	bh=EM6RN1Y8fkV2+aD2fnXXYb+/aGWtN4RVenYfbRsp9UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyc2L3qnUOzZ6e92zhvT5z0AUJy8j9nLqICz0gI0pkAAI9y0v6utbdS3wVwszzhhYnzKrpLu6m0EDPGG2MlBhRzv3IYo8pWGa1itfN7fNJuiyEHxd7xt5l5qN65Cvb865bMFKTBwqrAPfGwj8VFEMIuKj6G+haOTuXG7JdY9roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U1h6E/oK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 14:05:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733954735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVgcEuCnW7ND1Ke1KnD/NQ5ObPzdolVfXNZnx8wq/xk=;
	b=U1h6E/oKYfOvkpzKYmiAIz7NbTTiJfsV7+9Z4bDhou7RmNWpAltHNBj8GnkSLbTYy2+BoJ
	E6QP2JRnUqTnPuS5ouOBDG5YW5QJDsgFMl498fEFnRHRvxY5cJizW3LhrLkaFJu4kYBmx6
	VzsSeAAYGLO7TdGFLdF3qJIuyyKk8ok=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, sj@kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [v3 PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Message-ID: <mi54ropabzamou2aluq6qzyxjmxrml7i7xpdpzsikhgm4gawhd@fyx7ig6s7rvm>
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
 <20241211203951.764733-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211203951.764733-2-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 12:39:49PM -0800, Joshua Hahn wrote:
> This patch isolates the check for whether memcg accounts hugetlb.
> This condition can only be true if the memcg mount option
> memory_hugetlb_accounting is on, which includes hugetlb usage
> in memory.current.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

