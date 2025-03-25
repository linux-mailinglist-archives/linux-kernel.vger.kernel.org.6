Return-Path: <linux-kernel+bounces-574643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D36A6E7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3700216B436
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3CC14386D;
	Tue, 25 Mar 2025 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w/z1pPlJ"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C114293
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742866439; cv=none; b=SaZU2cctgMV3vH9lQU0MFD1D2Rqge5Zrp3t0gNX1zI7qjdnsw6KBMlX+/nWp+P76aGnwSJWJM6/Awk1N4e16TkYXAVDTbcIxOYGFrA9rLKgQ61UgHIX0ZDJP84Iu74An9EO3DbI3pK2/FRnGDyxK3ZM8UqCkFel3q0pBFWMPWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742866439; c=relaxed/simple;
	bh=ntUEVsSD2dBd9PjmRGgfmtLZCpmt6tlv84fv+DULk4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG4ULm+W7f5knIIYMZHxtmdnvn/ISMv5LL2eaZgAyFfNbonBklokpcJSDwpGPot6wfl7316U7q5Jp3toAF+wqM6t10hOPsZykDWAsPvdeymB6MrALvgbg35nekEPhTn6ewh+/nigLcZ2Geciw6+1ZTHtE5TNVQTtBhP7Qv4l1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w/z1pPlJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f20cfb0-3257-430f-8660-016f10f86c7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742866424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntUEVsSD2dBd9PjmRGgfmtLZCpmt6tlv84fv+DULk4U=;
	b=w/z1pPlJa12AAbZ8a+Kn3gV/PMDAmNirV+LZ+cEdqwIzaL8C9NQ0potDTdCsmiyhxtU49c
	yuzfEdWRdWg7Ze04Xgaljc97jHxTYBP6FX+7VNzSU6f80+l6Oafsma+FwC6Eo2ytq+NYek
	wY7ugz+0KewGtQYKYcsTUv5EY+FoauA=
Date: Tue, 25 Mar 2025 09:33:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] workqueue: Fix incorrect error return value in
 apply_workqueue_attrs_locked
To: Markus Elfring <Markus.Elfring@web.de>, Ye Liu <liuye@kylinos.cn>,
 kernel-janitors@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>
References: <20250324090748.753195-1-ye.liu@linux.dev>
 <32e08068-164b-4642-aedb-3c7a1658406f@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <32e08068-164b-4642-aedb-3c7a1658406f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/25 00:10, Markus Elfring 写道:
> …
>> This patch ensures …
> See also:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14#n94

Thanks for your feedback. I'll update the description accordingly and submit
a revised patch. Do you have any other suggestions for this patch?
Is it worth submitting?                                                     

Thanks，
Ye Liu


> Regards,
> Markus

