Return-Path: <linux-kernel+bounces-210678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1988904735
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D9A1C23497
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DA155726;
	Tue, 11 Jun 2024 22:52:58 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665E15532C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146378; cv=none; b=HpN73S1jW0GCxdC2Bvu9mRdwc84l06MJjZ77JvTI9sGkQh+9HCOhU8/+LNzH9QhMleOOk2VSPw02+YTjqXn3rXd4wPUjXgpnSyAiAajVLmwiosdHXQNTMPtFbNX5ru/o8E4fea/1oHRyt+NgKD22pLf+Cp1QyiPAAQY6gcD/H1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146378; c=relaxed/simple;
	bh=SIT2jXM8IDEMsc9d2jfo+rlecAxKwI0P7aHxOSr5QnA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ofrFg/Ms4DZLUpJ3QrxMmslSHAAiuvVkCXP94tbKOq9jgTOhla2QghNfCX9gvgxOt2Dhygt1AJZNBUMxivmnJd98nLFXrs0wrUDlLJUTdHepvoQw+JJbJDAUbi4QaFNYMTGGhf2oXhnuLa4zjpgan/LCk30uj0HfMDfVywlPhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 41D2640B10; Tue, 11 Jun 2024 15:52:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 40D6A4093E;
	Tue, 11 Jun 2024 15:52:49 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:52:49 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Chengming Zhou <chengming.zhou@linux.dev>, 
    Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    zhouchengming@bytedance.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
In-Reply-To: <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>
Message-ID: <e93fc5a6-434f-376c-a819-353124da053d@linux.com>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev> <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev> <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org> <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jun 2024, Vlastimil Babka wrote:

> Even if some security people enable parts of slub debugging for security
> people it is my impression they would rather panic/reboot or have memory
> leaked than trying to salvage the slab page? (CC Kees)

In the past these resilience features have been used to allow the 
continued operation of a broken kernel.

So first the Kernel crashed with some obscure oops in the allocator due 
to metadata corruption.

One can then put a slub_debug option on the kernel command line which will 
result in detailed error reports on what caused the corruption. It will 
also activate resilience measures that will often allow the continued 
operation until a fix becomes available.

