Return-Path: <linux-kernel+bounces-353783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0E99329E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0138E1F239D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574D1DA2EB;
	Mon,  7 Oct 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="IsWojIfZ"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51F1D54E9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317423; cv=none; b=qP1IpgTLSB15nTlg1fqtyyNeKhWr4Ec2fxUcD27y0z8dLeFr/HZM2qZ6oVaiBpacXOFZtJX4RPuZGKQH/QMAXNFPt/UPYM8tXKT71QTLFQtRIan01Kocf7/CbQU03Tc7l9btatq5vA0DTbjr3x4Vu0b0MEcuy6Z/TKzs42Xe+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317423; c=relaxed/simple;
	bh=eExNazOhskV8Uvc8HH++Glv06Zz7Hodk6/32xJvZsWA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UfGx/sBcQTCOvwBAldkWTl2tasrJOuJar3HCBnr3CPVZ6ZRqv1xLXfc6m62KjcuSweHMhTegd2jK6vFU7ShYeD8eE9iDC+kXmf6NFJ5NIk63XrJFXt+FRjfhtr+/ha2Be30e3+ii0COgphn2nkrWAoVABrjssryq+d44lqWk2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=IsWojIfZ; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1728316815;
	bh=eExNazOhskV8Uvc8HH++Glv06Zz7Hodk6/32xJvZsWA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IsWojIfZdzry04bEasa0qDTfAFXQo9Potsx65xsZz4dvlE1K50AZq/+g5PWXZaoUv
	 ukUkP5mNn7XYtwkNUHkOSZNJmc2WDp4NzT3hOhuENfltqFKOdGyHC/bNrq9cXjPXWr
	 nXJcPTBnN+rNj6wf0Ve5ywmefhYci/uZjtjI+1GY=
Received: by gentwo.org (Postfix, from userid 1003)
	id 2F76340473; Mon,  7 Oct 2024 09:00:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2E25340264;
	Mon,  7 Oct 2024 09:00:15 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:00:15 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc: Vlastimil Babka <vbabka@suse.cz>, "yuan.gao" <yuan.gao@ucloud.cn>, 
    penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, roman.gushchin@linux.dev, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slub: Avoid list corruption when removing a slab
 from the full list
In-Reply-To: <CAB=+i9T4nGJAQGpYSbAvyyfgceLmO6ih=gS7bPpvCdMMetTurw@mail.gmail.com>
Message-ID: <916bea8e-0e79-c561-f8e8-b3c7fa026161@gentwo.org>
References: <20241007091850.16959-1-yuan.gao@ucloud.cn> <b304fe39-4fcc-4b2b-a95f-1bb476c94a01@suse.cz> <CAB=+i9T4nGJAQGpYSbAvyyfgceLmO6ih=gS7bPpvCdMMetTurw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Oct 2024, Hyeonggon Yoo wrote:

> > Is it possible to determine which commit introduced this issue, for a
> > stable cc?
>
> By code inspection I suspect it's around when SLUB's first introduced in 2007,
> more specifically commit 643b113849d8 ("slub: enable tracking of full slabs").
> Even v2.6 kernels do not seem to handle this case correctly.

Yes this is an error that was there in the beginning. Its a rare
condition that only occurs when debugging is enabled so its difficult to
trigger IRL.

> > Also in addition to what Hyeonggon proposed, we should perhaps mark
> > these consistency-failed slabs in a way that further freeing of objects
> > in them will also don't actually free anything, and thus not move the
> > slab back from full to partial list for further reuse.
>
> Yeah I was thinking of that too.
>

Right. Stop any processing on the slab page with metadata corruption.

