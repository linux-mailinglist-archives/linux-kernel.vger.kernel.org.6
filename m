Return-Path: <linux-kernel+bounces-344083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 446A898A3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16990B250A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F418E75A;
	Mon, 30 Sep 2024 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mcP+hWd4"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877541A84
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701740; cv=none; b=an4YF2cj1JQ0+0Uj1+KGA9y2WmlQJuUMbM3jwH8EkRb6wiV/D0mKoUy+GqkxYhENbWsYkKF/7iMlzUknmajwmsYYnuNYV6SWaSqxPegEsdEjDepPzQ0e6Cz0jfS3WoFVcNm7DPt6kW4SjoC+5bfuD4pYz959G2KC+TLHX8K2s88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701740; c=relaxed/simple;
	bh=6OvQQredr/2DQBzxjPX/B69u7Sc/lc4ewOYedWGQ/GU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XnoMzwjDMO5SkR8Cjst09aTN6PFw27B/sAJrJRI9ju+q+yXuqw0L0VQ4CdU4fQX7cQEPrJYAvHue5FLRolJm4vbj2qQroy6nyateA7zFxtGd02pk3Otmb5mwRjC6vJ0tx71FtPJHfJOB0J1uOuWzTrwYkUn3NnUFKLLoEKgkCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mcP+hWd4; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727701735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zUQVcSOHhsfSHhtGOt3w2cLaGP+Wuat/18ZjUxGtBk=;
	b=mcP+hWd4/7Y2nGIzSgzPjEBSv/03AlZhVhSUs98P/YPyNyilHiUCMH+rGrclGHzDxHumdW
	XElU/ds2L5xAKuj3PHXJngXFeSGbyHzVz/txFTBRlEi/Kj2fq2g38KEQJEHin7sGmuJqM/
	PX7ueOL/ZS4cx+OM3pQbTdS36hftUpY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] w1: Use kfree_sensitive() instead of memset(0) and
 kfree()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <581388A8-4FC3-4FC0-9D5B-9F13DCB90073@linux.dev>
Date: Mon, 30 Sep 2024 15:08:42 +0200
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <466B1286-FF37-46D1-BBD9-FCE3CC1252B6@linux.dev>
References: <20240930114404.80910-2-thorsten.blum@linux.dev>
 <fc0c13df-a0a6-4cf7-badc-c08a9a7054f6@kernel.org>
 <581388A8-4FC3-4FC0-9D5B-9F13DCB90073@linux.dev>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 30. Sep 2024, at 14:15, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> On 30. Sep 2024, at 13:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 30/09/2024 13:44, Thorsten Blum wrote:
>>> Use kfree_sensitive() to simplify w1_unref_slave() and remove the
>>> following Coccinelle/coccicheck warning reported by
>>> kfree_sensitive.cocci:
>>> 
>>> WARNING opportunity for kfree_sensitive/kvfree_sensitive
>> 
>> So are you fixing coccinelle just to hide the warning or actually fixing
>> issue? Why this structure should be zeroed?
> 
> No issue, just a refactoring (+zeroing out) to silence the warning. The
> structure probably doesn't need to be zeroed out, but why is it done
> for DEBUG builds?
> 
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>> Please note: this change assumes that #ifdef DEBUG is no longer needed
>>> and we should always zero out the memory.
>> 
>> But why are you assuming that? Your patch is not equivalent and I do not
>> see any explanation in commit msg why is that.

Sorry, just ignore this patch for now. I misread the code and mixed
things up.

Thanks,
Thorsten

