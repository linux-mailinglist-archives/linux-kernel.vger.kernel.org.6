Return-Path: <linux-kernel+bounces-360120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B29994B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940C31F244F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C71E4121;
	Thu, 10 Oct 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yhs7w8LH"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B21BDA83
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597145; cv=none; b=FqaGyWEf4ko8DtwgatHOlE/8YlaFjk2w9MNQok3g0T5IonqKsBUwVVIJXHiW7Cl6emdRnvp/lqv/8SWcXtZiXQcOdjrbHHnjWokNV7yhTjeyl081A4hlsNhS0p24jzZcYMnCQwgQ4bmpkjsmJB8IIRYyPwB7WgsuTtLIvc0o3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597145; c=relaxed/simple;
	bh=WAu2X9b0jDIlw7lYMLRAf5KhZ1VHRSFcIumgJWzFBlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGc9LKcm4ZEwFplSEHRBf4MHA9HbCmMGZN0RvskA5Ge8pZbBDLMYxTHGetBJBSoYGARPxORb1+44GXFUTMcFs/KWP0GX2ZATsYtSlhwQr/7vHrvTSyIRpQzo125JjReUMu8LXrW3HispEDWTDU/4sCBZpgmxwYaiYWitpSwzmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yhs7w8LH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 10 Oct 2024 17:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728597141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfqRvVZ7yaWX6z/yUFY6whDPAJmAFk8EJGLq8dpIsG4=;
	b=Yhs7w8LHaV0FMh8DpReGx9AO6f9vFweuZwSL271vuzWFXxcit+UbjByTA37i68GmvdaXjj
	7vUAGFWrUHNhByeKUPLCfZ6Dqi7bME22e60nbRAu64178SPd88AJqYelWC8DbAwc5zvnwq
	iWNHOSJfWchZK/78Jm1kSdmIdd84ZmU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] bcachefs: Fix bitwise math on 32 bit systems
Message-ID: <wmdklwq2z6z2ssrwq3z4inxtgzvq3dwk2l3a4yxln3gillcfcq@eeitm7jievjw>
References: <78e06425-2c26-4977-97eb-577ce8268d2a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e06425-2c26-4977-97eb-577ce8268d2a@stanley.mountain>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 10, 2024 at 09:35:53PM GMT, Dan Carpenter wrote:
> The ~0UL needs to be ~0ULL for this mask and shift to work correctly on
> 32 bit systems.
> 
> Fixes: bad8626ae088 ("bcachefs: CONFIG_BCACHEFS_INJECT_TRANSACTION_RESTARTS")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks! Applied.

