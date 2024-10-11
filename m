Return-Path: <linux-kernel+bounces-361909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79799AEC9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35FD1F24741
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B351D3590;
	Fri, 11 Oct 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3MjWWBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3B322E;
	Fri, 11 Oct 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686960; cv=none; b=JwE0w5lhFZrg5HtlEqvxUITnppxtxBZn/kTzWTj0RvgVgO2M1xeE2zIBlKy1wXb7suBxAxoTcw8RGgAKPrdl8d6OnZCLwhpL799oTE5r+LV1LrlZVojpQ+WDua0anqrKGg/AJJw8qFvaogayK1xMK/cW2xWSQV/ha+id+a0V/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686960; c=relaxed/simple;
	bh=1WNF0fRlz/1r11qBAmarLwLtOYAESLGa74QT7B0fetU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oy4RkldsoX5A4U37m6VvphCz9fO3q9qbVd8HMCZsPXL30VQfr21YKfSIes++EilIgqpCp5k26+vSyHmE5zvBYonthnkfZxSZdSJN3nbyjDOADDKvdhaUVIc4MopfThRQgcKJB1fIbDuZGBgbRUALEo26sayoxanGlrudxG1bpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3MjWWBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599EFC4CEC3;
	Fri, 11 Oct 2024 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728686959;
	bh=1WNF0fRlz/1r11qBAmarLwLtOYAESLGa74QT7B0fetU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q3MjWWBRHUCEgTwXGR0cHlCf6qnxOMF2bVgk+RjWK44saPwubR7xcjUYacAoSmO4h
	 IvNbiX2IxA0g9R8Kdm8cSlVlcLySYZp+5HZvVUDP01vW5clote8HGPJHw45wUc0j6h
	 t7FR6zLtATdkagig2VlWZm3IRICrFtOqmf0FSxWf3R2NH06jDW6A4YQ5dZ8x1US5d9
	 m9/j72du2iN7itF7iWXpaP1I9Yhm24PvswX1wvmWnpHqWbtU2WJyTv+blq7t5ou0f/
	 7mKCSWIIkzFURfydM65zhlGGHAapnN8kFnRSKk1flC6a1F7txZos3k+vJJA2o8F9BR
	 hJZ8FTo7+CuhQ==
Date: Fri, 11 Oct 2024 15:49:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 aleksander.lobakin@intel.com, johannes.berg@intel.com,
 kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
Message-ID: <20241011154918.477cd612@kernel.org>
In-Reply-To: <20241009132302.2902-1-yajun.deng@linux.dev>
References: <20241009132302.2902-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 21:23:02 +0800 Yajun Deng wrote:
> The vlan_qos member is used to save the vlan qos, but we only save the
> priority. Also, we will get the priority in vlan netlink and proc.
> So we can just save the vlan priority using vlan_prio.
> 
> Defined VLAN_PRIO_MAX to limit the vlan priority to a maximum of 7.
> For flexibility, we introduced vlan_dev_get_egress_priority helper
> function.

The motivation is not clear, you don't explain how you tested, and
haven't added any selftests.
-- 
pw-bot: cr

