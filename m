Return-Path: <linux-kernel+bounces-250008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4154892F2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB6428360C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93323624;
	Fri, 12 Jul 2024 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fcJRjWMW"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB0804
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742649; cv=none; b=DuWqoCTl4RTXpKFH7GUHE++zdKJ/IbATcOfwU6I8F4y7yXQV6DAYYi/fkdjQ00kCNWmsLEhD5wVYU6X1fCwhjaK/E9hJ6pi1h7uvAE4WRBgunRhRSENm9i5mZ+x/kO9Iyj3As1xSuoedqLdmr7sohBQ4eCJ+07Ub5G0b5AWKu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742649; c=relaxed/simple;
	bh=jYDWG2Rccc9ppOjbT7ur995CyzIfZJTFU2E/CNxS6+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd+Jk3RkOUZFQQsvczFdZKiWN/iN9BJ510rJ5La7y7cbSup5fYB1h7+wxgS3cT0Gbr2l8AJjHmtBPQAgmvfTAcViyzElAWy+WXwnVTGHRg5HN4CZFBMVhtv996RNWe2+fRnczwyUxbOc3ig5GxHWaCJXax24t38l45BBm4O+eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fcJRjWMW; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: youling.tang@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720742643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpmF92RZAvQ03CCdChNzGq2NVsojJt2MFtSgcPMbVSI=;
	b=fcJRjWMWIo2M49WUPcJKl0JZesnUa0m+46U6b4WRe3KR9vP36YGcpR40f7e8JpuPyPEhPy
	m/MwfkcAfKxvnqpX14T/QlnptvqQORM+H+qKWnWgn3SL0dlHaJIXQhSYmy7Yy58h4ocmsT
	yQqRm+XGxQfcGc/qI/7qB+j/BBK2SKs=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
Date: Thu, 11 Jul 2024 20:03:59 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Mark bch_inode_info as SLAB_ACCOUNT
Message-ID: <m5jemgkisszzs564ikvo6q6qr73tadanvoyyqstthzyamzsr3n@33quhsmhaxhz>
References: <20240703070955.104163-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703070955.104163-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 03, 2024 at 03:09:55PM GMT, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> After commit 230e9fc28604 ("slab: add SLAB_ACCOUNT flag"), we need to mark
> the inode cache as SLAB_ACCOUNT, similar to commit 5d097056c9a0 ("kmemcg:
> account for certain kmem allocations to memcg")
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

Turns out this was never tested with memcg enabled (!).

I'm reverting it, please feel free to send me a fixed version.

