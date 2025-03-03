Return-Path: <linux-kernel+bounces-542508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA20A4CAAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936533B7416
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BF7218AA5;
	Mon,  3 Mar 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="aleLwJo1"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA07214A8F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024073; cv=none; b=c4QWNxS7PS/Ol2xl519i2L1nlQ8yTbOSWZqIsNOG2kyCObI/IDfJmhyhDHWk7QursrDu0xuqmPOFGMKG6/B16w+baC9RyInPdY9G53u4K6H8vtwAZbJkPHPy5m3rheVk/fotp8LZ4EQNRfUbAlVYVOvxODLM8B1EqGAichx0rus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024073; c=relaxed/simple;
	bh=FiY2u3I0Pn5QWdXrH/UVFOT449MBOOEniXOmPNiVtSM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rfZ/Z9Kurf/HVD6IAXg2gIg3de8LqMm0iKn8rFd7jGxf/4kLTQmY6W54PXRndoaD6ZU2zShbKSyjKjTSVhNejfYlxUy4OiS9em/ePgVzhfRk2t8aJbWEW/XI2730jfKpJfDaGBGSzJwrrWWWMUME+2FJ7YJLu4kP9HVRGDuQTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=aleLwJo1; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1741023575;
	bh=FiY2u3I0Pn5QWdXrH/UVFOT449MBOOEniXOmPNiVtSM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=aleLwJo10drgxiQ8VelxmBmtSUDjoYcsjlrw6+qC2RIGoWqcD6WQx0khgwFHRp6O1
	 ErIsghXIVgcf7gycpWmO+SYJOofkK4Hr+8/oePSe32M8E0qa4G9QUB1Owa4XVrBpBa
	 GWgO/g9QxyYmRgd2796+ILlhX36WhVMbCp43P9mo=
Received: by gentwo.org (Postfix, from userid 1003)
	id 928C5401E6; Mon,  3 Mar 2025 09:39:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 9193A401E4;
	Mon,  3 Mar 2025 09:39:35 -0800 (PST)
Date: Mon, 3 Mar 2025 09:39:35 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Lilith Gkini <lilithpgkini@gmail.com>
cc: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, harry.yoo@oracle.com
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
In-Reply-To: <Z8XbomV9WCabATIM@Arch>
Message-ID: <71ae6abc-d900-d5a2-84cf-8480a518e29b@gentwo.org>
References: <Z8Sc4DEIVs-lDV1J@Arch> <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz> <Z8XbomV9WCabATIM@Arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

In Mon, 3 Mar 2025, Lilith Gkini wrote:

> Alright, If you want to be more technical it's
> `1 (true), otherwise 0 (false).`
> Its just easier to communicate with the true or false concepts, but in C
> we usually don't use bools cause its just 1s or 0s.

Its not about "technicalities". Please use the bool return type as
provided for kernel code.

Compare f.e.


static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
{
#ifdef CONFIG_SLUB_CPU_PARTIAL
        return !kmem_cache_debug(s);
#else
        return false;
#endif
}


