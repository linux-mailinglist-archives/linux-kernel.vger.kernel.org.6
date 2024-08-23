Return-Path: <linux-kernel+bounces-298219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A988895C3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29801C231A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF54AEF6;
	Fri, 23 Aug 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JN034MPT"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D3383A1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724385366; cv=none; b=NP+cV+SOrNPqLaydxR0mIIsvQ83A/x//NK8sS4CVhfFXQz9EgnQ/U/qq/MLsko6y8Fp5CZTp20oLJYVfz2WCHFk86LtYZI6D3i4IRityMmY930PWkzdOhtky8WMUpBuIRF5qV438dAm/bvDFPAwqVFu/Zp0tIGwm/oDhI1LAoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724385366; c=relaxed/simple;
	bh=mIsEUyW4k8HB4WSZEdflm6tCGdhZrEsZbUddreQfyZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtU74/LwgOk0L8JYQQzoK+GO6oUIbM71obzv3ifJvEdSNgiYfpJRXmmBhutjgRhgXQPslHtGzOuysBWlwpLzFpISwEJlKQSBft+Yp+IEuRR511s5iJ/tFN8Hqb4TBYxz/NuHQKtZlDuSL3qu+2gPFbByTEKnOR6RoYf5ozK2C7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JN034MPT; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 23:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724385360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkEzWlxaq7zulouscVxlD9YgBdgJUj/+c8bwDtryew4=;
	b=JN034MPT0Lw4bDbaYGnG5cHw338KwmDsJNQX9bentglvZqNRb0tq97BmC7Z1a6VtjZAh3k
	nqJSfAzC5s6mO24yUPht46OEZiDdTJZ0rU2ZN3hZqxehhqVyoDdVm75NRn8gDHEJEqbkz/
	sQi92fo6IB7YhYiWORjkx1KOqcAitR4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Remove the handling of bch2_trans_iter_exit()
 in __bch2_bkey_get_iter()
Message-ID: <f2uohiy7zaaiv33r7xhofaprv6tk5mumvzzf7plvagdtavrini@3orfgcehid7q>
References: <20240823031955.202795-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823031955.202795-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 23, 2024 at 11:19:55AM GMT, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> - Reduces bkey_err() calls.
> - Avoid redundant calls to bch2_trans_iter_exit() in some functions.

no, a function that returns an error should clean up after itself

