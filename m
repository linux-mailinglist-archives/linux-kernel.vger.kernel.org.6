Return-Path: <linux-kernel+bounces-369966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042879A2509
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F8F1F23415
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F71DE2D6;
	Thu, 17 Oct 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PL176z3O"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB31DDA24
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175509; cv=none; b=SRvCV+HG4r60XaNrwLpI4tZTXPXqh0H12Vpw/POweeaETyKKU9srtG81tnNRn8vQnfUyLgtC+ZLi4NIQ+wXQMhylrrlrdTvuFfYhsZRVjLXggZVplSeN/eJoV7+MrKAmzyVYeU344CTEPKPmntXUUcWHbgQe9bNXulLRos9c3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175509; c=relaxed/simple;
	bh=xBH5aVbK39yLoUvQn3PqzJ0XHiE2U8rtD20mZ6DpQ64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCdsaTFwAlpOTYTda+NvXHo/pu3ziiQIlPwy0wbMmo1xqoiTqUeVm/6NUL7OYfDfWMtT2v23o7QZVSlVogQKLWpsVK1PBCk6dy+zAB0CQ8zp24SrEuZTbOuiHOr+IljQViZw5SbQElVybKhgsQVBgwEl+b75iGOUzdl6oCCLDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PL176z3O; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729175505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD7KPBCrXNDX/3d9ghZ2BK2EsRa7ts6WN8DN8nkkoeI=;
	b=PL176z3OcHG8FNwQY8WBpYPRRBrbneF4jqumWVWNGF+bPS6Gl4z+rFfkJNLYBljjdhewA6
	hW0Er95E/QbtogUXWIQbRjC77jDJvJIATp17uMuyvsorPEsG/Wdyvkm9+vk5DahJoUuMXR
	KDTfapif/KdxeWPJu4E/gjh5hcWp27k=
Date: Thu, 17 Oct 2024 10:31:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
To: Christoph Hellwig <hch@lst.de>,
 syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 syzkaller-bugs@googlegroups.com
References: <670ebde5.050a0220.d9b66.0154.GAE@google.com>
 <20241016080240.GA30380@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241016080240.GA30380@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 04:02, Christoph Hellwig wrote:
> The problem is that the dma alloc/free tracing calls virt_to_phys
> on the allocated/free memory.  But that memory can be vmalloced as
> in this case.  I think we don't have weirdo allocators or pools any
> more that are neither in the direct kernel mapping or vmalloc, so
> we might be able to do an
> 
> 		if (is_vmalloc_addr())
> 			page_to_phys(vmalloc_to_page()))

Do we need offset_in_page?

> 		else
> 			virt_to_page()
> 
> here.  Or just switch to tracing the virtual address to always be
> on the safe side.
> 

Since this function returns a virtual address, I think that would be
fine.

--Sean

