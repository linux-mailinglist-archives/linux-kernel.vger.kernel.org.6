Return-Path: <linux-kernel+bounces-511998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6366CA33290
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4703A89C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45A20408E;
	Wed, 12 Feb 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WmxmVfbf"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949B203704
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399324; cv=none; b=l6bzhPPRMk6aWFN8I6F3YpKLzBPwRc0v3cBVAqMfInt2JNLooNEhirLQYQ2Ofka6dHFPI7sRwxwAuO2zhUZOkuvdK9NLTPQZf4BIUBFxIUbm4+oe0i1wyYjxXuPTm+/2EKf5Mkk+bNnrEC9o5vGHHJBLti7jMQ6yDbGhm613dSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399324; c=relaxed/simple;
	bh=8febaM/GGXzDc+Y+Kc9TY1ej+8QKvxOvC8LTylKrnHM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J43GWlCZl/2xoBoxS5yQXl3ocvm8SuePUYL7K6imKO8dlr6aqlSN1fuwuXzPK6Dt8XZkt9igiMcqotSh8Sb6gNvhcda9iBTcDmUrv9TvF/EKg4ntcw1Z+mqzzo6J9zMMN7pqV+wwNwUvRfSWcPcY8Z1lhOPEQUC9xCSj+TVqGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WmxmVfbf; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739399310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vGAzcBV6SusYZSOoty7cC3Cdm+q713JRVhMRrbwVIA=;
	b=WmxmVfbfqTlhv0dTw/dTNw/BfigNpqJF7RxYqxCbUE/mQuheKTIo23+VV5rq89Oz/ysQl8
	eY6gmkgMt/GDdMPcCFV2FkuR/jSW3MwHoCBFJKqedf9URI3Qdg17WoFWK2kO31SXgXFwuu
	hXCaGq+5g0a9y1m0ZnBmLumrvK0mWjA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] scsi: hpsa: Use min() to simplify code
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <7a39a882-4f00-483e-942d-36a7cff53954@acm.org>
Date: Wed, 12 Feb 2025 23:28:17 +0100
Cc: Don Brace <don.brace@microchip.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 storagedev@microchip.com,
 linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <561C9EC8-8F5B-4415-B7B7-CBE2AB99A094@linux.dev>
References: <20250212115557.111263-2-thorsten.blum@linux.dev>
 <7a39a882-4f00-483e-942d-36a7cff53954@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Migadu-Flow: FLOW_OUT

On 12. Feb 2025, at 19:48, Bart Van Assche wrote:
> On 2/12/25 3:55 AM, Thorsten Blum wrote:
>> Use min() to simplify the host_store_hp_ssd_smart_path_status() and
>> host_store_raid_offload_debug() functions.
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> From Documentation/process/deprecated.rst:
> 
> <quote>
> strncpy() on NUL-terminated strings
> -----------------------------------
> Use of strncpy() does not guarantee that the destination buffer will
> be NUL terminated. This can lead to various linear read overflows and
> other misbehavior due to the missing termination. It also NUL-pads
> the destination buffer if the source contents are shorter than the
> destination buffer size, which may be a needless performance penalty
> for callers using only NUL-terminated strings.
> 
> When the destination is required to be NUL-terminated, the replacement is
> strscpy(), though care must be given to any cases where the return value
> of strncpy() was used, since strscpy() does not return a pointer to the
> destination, but rather a count of non-NUL bytes copied (or negative
> errno when it truncates). Any cases still needing NUL-padding should
> instead use strscpy_pad().
> 
> If a caller is using non-NUL-terminated strings, strtomem() should be
> used, and the destinations should be marked with the `__nonstring
> <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
> attribute to avoid future compiler warnings. For cases still needing
> NUL-padding, strtomem_pad() can be used.
> </quote>
> 
> Instead of only changing the calculation of 'len', please change the
> strncpy() calls into strscpy() calls.

Thank you for the suggestion.

I just sent a new patch [1] essentially replacing this one.

Best,
Thorsten

[1] https://lore.kernel.org/r/20250212222214.86110-2-thorsten.blum@linux.dev/

