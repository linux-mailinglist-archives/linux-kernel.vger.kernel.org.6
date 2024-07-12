Return-Path: <linux-kernel+bounces-250133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C4792F48F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C151C230F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FA10A1F;
	Fri, 12 Jul 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GNsN50BY"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA83624
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720757275; cv=none; b=Ame29mh1n3EDxOlWki9QJ/Ag2Cdy0H3YXKXYF/Ug167iiiWUVYPPc73+yzl2cyJaPHneOqd4h4Phlsr3ejBiV0NssXLc8b4WAO7qi36e9kHUvKrJyO0Z+cEw8tG0gytaM98Y1F00mmwPvt8u9fbofOQoSyMUc7iYegDqxvfqXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720757275; c=relaxed/simple;
	bh=PxNSId08MowSn7NbIH1MTWzw7VtL/T5CdLx9bZ4Yh2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=becp8C/WMWYMx5uCWeT3QQC/yJ79Ma84WNpJ4ffVvteeK/o8oH+0NjHi1xr7KnWPdRa5l9vZ33NDZEW7waF+PCLR7OAmlPOe8JEaqF/3TC+OSk45ES7bzd6IsG6ff86ZUZ1xtH+schdfl2zIxugei2lVoLryN5OgOMxUHKrswto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GNsN50BY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: youling.tang@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720757270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TOSIiB7JBkoX6UYTsCWNWgwPw31kFf6GF1CBwDwIcs=;
	b=GNsN50BYHXwWGBt8kZd+CM5ek+PCAwvMPbEI2STz1zorGzI1WJe0eKCMqesmbFfMOsnI1X
	AZz+tx0XDywc42v+skMmnWqPzTQb6oQOBF9OG6hQF/xlkvI/r9BJo/1xvczJurC6gucOPq
	Xm48egQTTLZJ4ER/kBPFiGcA84CVjgw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
Date: Fri, 12 Jul 2024 00:07:32 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
Message-ID: <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
References: <20240712032554.444823-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712032554.444823-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
> to error handle the return value to avoid triggering NULL pointer
> dereference BUG.
> 
> The issue was triggered for discussion [1],
> Link [1]: https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6

I see no explanation for why this is the correct fix, and I doubt it is.
What's the real reason for the NULL lru_list_one, and why doesn't this
come up on other filesystems?

