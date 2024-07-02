Return-Path: <linux-kernel+bounces-237908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E0923FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A5628B679
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEF31B581A;
	Tue,  2 Jul 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6vyxznK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E97BA2D;
	Tue,  2 Jul 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928609; cv=none; b=tA24OSHcfSkxrldpMKg8lwLdnRiKxusdLDfEI+V1IoeAyU2LWYGcQrk1Y72GX4vrkmlteDZZ6NrA87ziQG6Rc3XzyOb7hSE5vwWuKUqq2gufaT/u8pfGHl0CZNWSVB/7BVG3mX1Nio4iX+wolfDcrJ15he7gh/PRMar7rHbpPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928609; c=relaxed/simple;
	bh=YhsMssFJDXrX892qPYU5K329bOcf9SGQcewUbDKTez4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K67HuJC30egL7msdIqSzGKgQO0M3nmApj+/s1g1L6zsEwbqJ4gk9sRcQR+uDQ1DienkAHjeaH1/3jXR8uoAsrEN6s9tJDbwm1vQKzvNqhmDCmoW0cOhEaJApQH1UR3z0TIqWhALKI/sk90badU1okX0k8yh5NoDYiXEcKMwAm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6vyxznK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7628C116B1;
	Tue,  2 Jul 2024 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928609;
	bh=YhsMssFJDXrX892qPYU5K329bOcf9SGQcewUbDKTez4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p6vyxznKDmXEvIwOvvZy6fKYE+Vr2dd687XqrzrcYarEyW2Fr6IHd37BGnXTExjka
	 Orj9Hx4OpuRhUmh2lkZz4N/zheCptJZk4T2R8Op1cmPZdz5l0ImlsjE9xnyvy3lFHN
	 2LrYuSo1oJMuT/Z1gR0/N66UKgYOPwe5b0gBY2VuzKEb01KmOCgIVtwgFAWc6Oh16Z
	 WyZNlTOYohrIHhLZmKRNTFD78yjxt9hzxtYLvh4C3BGuZ9oUzd5+8ESFgylmV3cqk9
	 Xzm81wd2hZB8tcwiNcS7WQF3DihZkThsrVlgQjLEZQPaTi7JkGJJq+KKT6sBdW0yxE
	 4ariQt91sFEVg==
Date: Tue, 2 Jul 2024 06:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>, Subbaraya Sundeep Bhatta
 <sbhatta@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 06/10] octeontx2-pf: Get VF
 stats via representor
Message-ID: <20240702065647.4b3b59f3@kernel.org>
In-Reply-To: <CH0PR18MB43395FC444126B30525846DDCDDC2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
	<20240628133517.8591-7-gakula@marvell.com>
	<20240701201333.317a7129@kernel.org>
	<CH0PR18MB43395FC444126B30525846DDCDDC2@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 06:41:51 +0000 Geethasowjanya Akula wrote:
> >> Adds support to export VF port statistics via representor netdev.
> >> Defines new mbox "NIX_LF_STATS" to fetch VF hw stats.  
> >
> >These count all traffic passing to the VF? Both from the representor and directly
> >via forwarding rules?  
> Yes, it provide both the stats. 

Could you implement IFLA_OFFLOAD_XSTATS_CPU_HIT as well, to indicate
how much of the traffic wasn't offloaded?

