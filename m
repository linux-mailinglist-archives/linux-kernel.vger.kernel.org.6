Return-Path: <linux-kernel+bounces-447834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A59F37A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD5E164AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0481A2066E6;
	Mon, 16 Dec 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpw4yZVs"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BB2066D8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370531; cv=none; b=lPnQUgvFXMkcxFXA+uB2d+umxQc1SrGTkaux4GOfjWFCvZphnEl27DL+t17O7/m4m/j+ehY6bu2/ENThALJ2pXuwoWhFh27hDCXp1M6NwsjZviN1p/Ti9JrElpaB8q/PdHI1JzVLYauVvQlJ+1iKBuFGu5qUDVYtZaedMid9z8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370531; c=relaxed/simple;
	bh=WnpVBajfzmZCV34B8hmzi2AaNBqNVUMchRAMF36FKUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7SyXQis8EkntCTxTuzFEtyqKqtxVb1nG4sX1o8ZDdxdVSRSuieUE1ssniV4qRAMHmw1rxgZnXA6m3NRX0Esg8pzu5Wgf3v1nV9REbl123AqFEwtOq0Nrw8nsAjXOmTnM9h1oKUEnK1uPTOy9mo+mdfzOGp88yyKtajWK5YVYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpw4yZVs; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3eb98099-75da-4464-97d1-9e8538375e34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734370527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnpVBajfzmZCV34B8hmzi2AaNBqNVUMchRAMF36FKUY=;
	b=jpw4yZVs57KIzpEgNmhULeXOroVexIBVS5gbsRmOYICBGRn5q4mcG0Qu0QL3msOTwgn7ZJ
	z7eztt8maF+6up3OWSS30nBigsb6uD1D4p2QmqP0sY/bapRR/jCnkKDgkUuaZiA4NHqXxx
	ABwFJvwiuyxA/8RMPOnLlPh2hFfizR0=
Date: Mon, 16 Dec 2024 11:35:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] soundwire: intel_auxdevice: Don't disable IRQs before
 removing children
To: Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc: peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 sanyog.r.kale@intel.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20241212110221.1509163-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20241212110221.1509163-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/12/24 5:02 AM, Charles Keepax wrote:
> Currently the auxiliary device for the link disables IRQs before it
> calls sdw_bus_master_delete(). This has the side effect that
> none of the devices on the link can access their own registers whilst
> their remove functions run, because the IRQs are required for bus
> transactions to function. Obviously, devices should be able to access
> their own registers during disable to park the device suitably.

What does 'park the device suitably' mean really? That sounds scary. What happens if the manager abruptly ceases to operate and yanks the power? Does the device catch on fire? On a related note, the manager should *never* expect to find the device in a 'suitable' state but always proceed with complete re-initialization.

It would be good to expand on the issue, introducing new locks is one of those "no good deed goes unpunished" situations.

> It would appear the reason for the disabling of the IRQs is that the IRQ
> handler iterates through a linked list of all the links, once a link is
> removed the memory pointed at by this linked list is freed, but not
> removed from the linked_list itself. Add a list_del() for the linked
> list item, note whilst the list itself is contained in the intel_init
> portion of the code, the list remove needs to be attached to the
> auxiliary device for the link, since that owns the memory that the list
> points at. Locking is also required to ensure the IRQ handler runs
> before or after any additions/removals from the list.

that sounds very detailed but the initial reason for all this is still unclear.

