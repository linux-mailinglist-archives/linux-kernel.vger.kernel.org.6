Return-Path: <linux-kernel+bounces-226221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F24913BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F77281ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166918132C;
	Sun, 23 Jun 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EmJ0eceb"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF11CD25
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719152453; cv=none; b=bDiJGANfYk5cG6FBW9r1F2DOwUBEeEVFw0ygWSIokVaMJ8VEweKT117Kqg3/fwe2IchOzoRFNLjtHrTgqEcDyW6FYPA+FGyXuuexnHWad46EjlrL+hjtwH5adkWUp1uhD8PXAiqkQ1gV0op/Roc1gY3u0kb/tI3TtvMkQDT5VdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719152453; c=relaxed/simple;
	bh=ex5J8+Ae4iKsctF67hjjsap2kCyEmeUnBRJV9qGdnPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DD8aUF66NMljprK44IB9Ixe8dn32/HlPVT877M1sPllh2PIXcwaZHwdd8oq+/oJG4DCeNIvQ0qhSLUHKNyT98izpk+nfUavPJupmGx4rKtBNnamBFyVZrMSXLBZM3N/+NWEgY1rKQFTGM2kN+wnoIxEbwErpzMt96+C9rhWv7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EmJ0eceb; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ardb@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719152446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+bDjx0y+iP8Abxe/MnYhrrwchlPmdfzSW+YmImXYM8=;
	b=EmJ0eceb+4SR/sfCaTjF5gjhjGE87dlsEX4jKGfRq46lSlOErZVX300SafdPleR1el+/SP
	MRZkfF5Dk+C9KDpsR6/WIs8bvsgNulcn4GDZry2Cf/lYbhALXf4w5sJPanCYAPpbouHE82
	5E+8IiJ18XqS0xUo1vsXbq6Rgi44H9c=
X-Envelope-To: yuzenghui@huawei.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: will@kernel.org
X-Envelope-To: wanghaibin.wang@huawei.com
X-Envelope-To: zenghui.yu@linux.dev
Message-ID: <19f05d6a-7b96-472a-919d-56292596e8bb@linux.dev>
Date: Sun, 23 Jun 2024 22:20:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: Clear the initial ID map correctly before
 remapping
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 wanghaibin.wang@huawei.com
References: <20240621092809.162-1-yuzenghui@huawei.com>
 <CAMj1kXEH0ohn57DUrCu6S-AJW=B9CyrpMwyabpjBpD9tD4VV=A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <CAMj1kXEH0ohn57DUrCu6S-AJW=B9CyrpMwyabpjBpD9tD4VV=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/21 17:52, Ard Biesheuvel wrote:
> On Fri, 21 Jun 2024 at 11:28, Zenghui Yu <yuzenghui@huawei.com> wrote:
> >
> > In the attempt to clear and recreate the initial ID map for LPA2, we
> > wrongly use 'start - end' as the map size and make the memset() almost a
> > nop.
> >
> > Fix it by passing the correct map size.
> >
> > Fixes: 9684ec186f8f ("arm64: Enable LPA2 at boot if supported by the system")
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> >
> > Found by code inspection (don't have the appropriate HW to test it).
> >
> 
> Good catch!
> 
> Even though memset() takes an unsigned size_t, the zeroing path in
> arm64's memset.S does a signed compare on the provided size, and will
> zero at most 63 bytes if the size has the sign bit set. So in the end,
> it does not clear anything.

Yup! It took me a while to figure out why memset() with a VERY large
size doesn't corrupt the memory. ;-)

> Note that in this particular case, that
> doesn't actually matter - the memory is reused immediately to create
> another copy of the ID map, and any unused regions containing garbage
> will just be ignored.

Agreed. I can fold it into the commit message if Will/Catalin ask for a
respin. And it looks like an alternate "fix" would be just removing the
memset().

> Nonetheless,
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks!

Zenghui

