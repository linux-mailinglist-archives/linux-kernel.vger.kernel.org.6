Return-Path: <linux-kernel+bounces-353763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD091993249
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1F1F23372
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488BE1DB365;
	Mon,  7 Oct 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="rpATpm6a"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6C1DB551
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316632; cv=none; b=DItUC7ILlQEUEgHlET73OUsdZLCYmLm68Dcr/rB8fceTKYGAnAM4611/xjTKNpf5nt+61CSeDfSLtrth4aVAEzQ/9xBG/zu0bRV4CkEVXJHdaXIoIK1sKZ0dCzMHDsnRyGiShFT1odBrmRTE8hNcxAsQdQQ3M3THmQ6hdVumDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316632; c=relaxed/simple;
	bh=nBVCAnk8Hwj11FeyRJprgB1zO01uAKSCpAsH0AuQt3c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mepi2KbLLRsqyumUVnl8HbOB1XBhBf/Rt+MXdt3ds0t3+qmeyJokTDeU3Jut3FnsrACjkSMTeofEDaML2clDUlRsO67+bfWJrSHNC7QlJmxCspOOWHClVZiSWvdTPEO0KHbhpTbKfklg5uPXp3bXhXvE1b4m3d3WnYrFuZKBVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=rpATpm6a; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1728316623;
	bh=nBVCAnk8Hwj11FeyRJprgB1zO01uAKSCpAsH0AuQt3c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rpATpm6au7a9MVZBaI4VjyAZt15la1hz6X4tH3c0trwZitMxOKtscQJt5E5xbBkPC
	 5sVIHZCFovqZ0KTeu9see/JM4LwWtWe1afmwD7SmqmkncTfl8HgPhcSV2V9bwM6eFe
	 +gbyLDM87RN1c0J4Z9PjN4lvgOJZhMyMtQoCneeg=
Received: by gentwo.org (Postfix, from userid 1003)
	id E575E4026D; Mon,  7 Oct 2024 08:57:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E3ED940264;
	Mon,  7 Oct 2024 08:57:03 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:57:03 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: "yuan.gao" <yuan.gao@ucloud.cn>
cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: =?ISO-8859-15?Q?Re=3A_=5BPATCH=5D_mm=2Fslub=3A_Avoid_list_corru?=
 =?ISO-8859-15?Q?ption_when_removing_a_slab_from_the_full_?=
 =?ISO-8859-15?Q?list=A0_=A0?=
In-Reply-To: <20241006044755.79634-1-yuan.gao@ucloud.cn>
Message-ID: <1f785dc2-15c1-930c-4f10-6210fca38f37@gentwo.org>
References: <20241006044755.79634-1-yuan.gao@ucloud.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 6 Oct 2024, yuan.gao wrote:

> If allocated object failed in alloc_consistency_checks, all objects of
> the slab will be marked as used, and then the slab will be removed from
> the partial list.

Yea so the intend is to isolate the corrupted slab page. There could be
more corrupted data on the page.

> When an object belonging to the slab got freed later, the remove_full()
> function is called. Because the slab is neither on the partial list nor
> on the full list, it eventually lead to a list corruption.

Right. The full list is used in the debug case.

> So we need to add the slab to full list in this case.

That would mean to put the slab with corrupted memory back in circulation.

I guess we would need some check to avoid handling list operations on a
slab page that was removed from the lists because of metadata corruption.

