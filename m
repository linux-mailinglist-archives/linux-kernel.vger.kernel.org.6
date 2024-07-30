Return-Path: <linux-kernel+bounces-267980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F770941EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B6A2827D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C0D188008;
	Tue, 30 Jul 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q1r4uMXc"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C41A76C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361611; cv=none; b=VprdmSh4YPkFgpcOXCd4lkx+WXoKUPS7bSsTkGS+mGu0l2LRvyjCDYIjFEfWMY+Gv7kzvyBeXUbcLt88hfCoS7N1BfbKcmciljISmo4EX6HPTAL+7F05eIs6dAp0LgKQ/i72ju29Gi1Z6t31YIhOqWuSCMen7/uUNARMZ+Myk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361611; c=relaxed/simple;
	bh=KhltE2uwTR5I1ruE1O/m4LkEh0gZn3py6elfWt1S1+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxSZUsJS6aUoHDgexEN/+ZVI8552H3Wvkw/mnXWlLgU5f5Fn5ddhxZ+P2wGukkw8s/4qkDRUvMHDUpS4TlAuIVNxxyuC1BHhUJp+IXFIN+7u9XZLpOxHbqxZQ52+ruMDTZncjZAW/mfeoAk60PCSiNnvDBAKZVaLj6B+7wIHVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q1r4uMXc; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b34fb4c-abde-47e8-984b-3ea55d4475a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722361606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1PkLT7Wa1W5BhecQMpMGwCc4qguu8cW9tK12igjtDs=;
	b=Q1r4uMXcLcLpHMCejh7/3AzUWmCg7wLrpVz2oRWHPiNbeU8KyE+NPBYmCu84FnWjsFZTBo
	pDt9FOiKbHnox38QpWbXF/F3tre3DF6dX5oHzBYA+IDbSMloAuTNyaJLeDvBUbgmMx2Pa1
	WBDSZ9LxYWGoIg7ywOdmOdevoYYdI40=
Date: Wed, 31 Jul 2024 01:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] drm/loongson: Introduce component framework
 support
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
 <20240728152858.346211-2-sui.jingfeng@linux.dev>
 <6dbe975a-59eb-4d4b-9fea-b930fa44e4ec@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <6dbe975a-59eb-4d4b-9fea-b930fa44e4ec@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/7/29 14:40, Markus Elfring wrote:
> …
>> +++ b/drivers/gpu/drm/loongson/loongson_drv.h
>> @@ -0,0 +1,108 @@
> …
>> +#ifndef __LOONGSON_DRV_H__
>> +#define __LOONGSON_DRV_H__
> …
>
> I suggest to omit leading underscores from such identifiers.
> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier


I suggest add this rules to the checkpatch.pl script,

It's more safe to follow *after* your suggestion is accepted.

After all, the checkpatch.pl is de-facto standard.

checkpatch.pl is happy about my patch for now.


> Regards,
> Markus

-- 
Best regards,
Sui


