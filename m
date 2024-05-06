Return-Path: <linux-kernel+bounces-170067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2C8BD179
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595791C21CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A565155380;
	Mon,  6 May 2024 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V35oBW5t"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157B13DDC1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008837; cv=none; b=hlN27gwbMFzDzZJnNudssCACRZ5NPZyJG9mswS5yeb+B2B99IYkApSRl1WNTTumHKBIP0jE0WFfSi2fPvCupnsIprJAiB8qpTLEDtJ3ACARE5P5kb7tud+KiKMKUtQ5hyPvO6m6ZX8J8jNHBmOM69iEl+313sAFKq8r4ZjWEXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008837; c=relaxed/simple;
	bh=BapJg+2LI+ANgEUnvNkNxdLMzL3lAUyjiHwonn5Rezk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYgGLr1KSn6UburFqkDbN+nOBYaOOL1pSokF1BUqTTh4JgUoYY/YeUZMZMHU7ToyhQ9FzhalFfXJ7E85vo9jF9Lf22or6uIDJpGhmpFa2U6hhqyh/DvRSbGSiwGid2A3aDDzR4lkONmIJrChd6KTqHbqhpQZ7QjS7h0DATht2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V35oBW5t; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lbJi3sRsQv4/3F92ud7PDqyZNpJ7gOb4bwceJKBgBgs=; b=V35oBW5tMGA1DOU1+QCyQ0jnlM
	LEmTzB2AtdH6YFIWRz+PJuvOh/6vNoiTRdZZHqxWPB5G1Z/8OjF3FyDgWzsHazm+lP+BcZPmXGPuv
	vkaF/hdyUt+jPsup1BCFlwj9Lg316gqV0cVY3+hFMtz2udAxwK/MO0eIvV2sxKUCplYiObqFA0skE
	54abL650PLu0dUJgv3o9x6SLSitLubZ2M8l8UKKsePpKk6VZIJmMdpC9Udd+WhkBxVYFq4y6cNPh0
	Lx9rtOF0TalfRjN+v+wM7gZqrvItb9qZZ/ZlMvrz1e7MIDQQIXEsxAKj3sM8kRzFCbd/pgtf7uRa0
	i0OZkB1Q==;
Received: from [2600:381:229a:b4a5:8543:7865:e9d3:dc68]
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s408j-00000001kWa-1qWX;
	Mon, 06 May 2024 15:20:30 +0000
Message-ID: <4138c586-8a56-4328-b7dc-bbfc7850e238@infradead.org>
Date: Mon, 6 May 2024 08:20:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] most: fix current kernel-doc warnings
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Christian Gromm <christian.gromm@microchip.com>
Cc: linux-kernel@vger.kernel.org
References: <20240504-most-kdoc-v1-1-378c468ccd85@quicinc.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240504-most-kdoc-v1-1-378c468ccd85@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/4/24 6:25 PM, Jeff Johnson wrote:
> Follow up on the prior work [1] from Randy Dunlap and fix the current
> set of W=1 kernel-doc warnings in drivers/most/:
> 
> drivers/most/most_snd.c:58: warning: Excess struct member 'opened' description in 'channel'
> drivers/most/most_usb.c:69: warning: Function parameter or struct member 'dev' not described in 'most_dci_obj'
> drivers/most/most_usb.c:69: warning: Excess struct member 'kobj' description in 'most_dci_obj'
> drivers/most/most_usb.c:122: warning: Function parameter or struct member 'dev' not described in 'most_dev'
> drivers/most/most_usb.c:122: warning: Function parameter or struct member 'clear_work' not described in 'most_dev'
> drivers/most/most_usb.c:122: warning: Function parameter or struct member 'on_netinfo' not described in 'most_dev'
> drivers/most/most_usb.c:650: warning: Function parameter or struct member 'on_netinfo' not described in 'hdm_request_netinfo'
> 
> Link: https://lore.kernel.org/r/20230113063947.23174-1-rdunlap@infradead.org [1]
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/most/most_snd.c | 1 -
>  drivers/most/most_usb.c | 6 +++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)


