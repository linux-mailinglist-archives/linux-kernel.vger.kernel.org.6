Return-Path: <linux-kernel+bounces-263461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172793D665
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF14B21690
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC8178397;
	Fri, 26 Jul 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i+IgIvZW"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2112E4A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008826; cv=none; b=MsXlRUY6EkIAYUuE+pL1ARjC5NGg8bCYz9tb6YUj+jKMOPFM+CR8hiDUHcEuWd/6Z9q1ND6oeJfyruZZd0ts58mQUlJA1JN5IM4Uc5nrT2JsQJ0aBLhL1GVcIP/le74jadI1TrnBrtVmnwGXIG0K40oMdoS0shyASZsRPfg7n2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008826; c=relaxed/simple;
	bh=AUGoJfW9I5BO0z9IpSZGRjKwZBVmROlvbKu/wNyeWRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYhXGHzBMmJL/2cUytdZmx7nL+mJfORqXMJJ7RfH+kJPKQhdgNQPs4ZqyHPt0pV+29MBN3oqKT9ln3bdyFDsNLp0N7RM2I2qVXIZkHZNCeTlsN2ItOQrMIRbyGIURa1KvVfK2tYR0teisOgO5AdqVhD3Z/zmJO2xDA1AmaTZI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i+IgIvZW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Jul 2024 08:46:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722008822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaTFp+0mxeLoNEiix+ZWdffU29+TDb8EWzJkPAoeWKc=;
	b=i+IgIvZWG0ZD89UQ/dRTG03f0kpvqvNrFV0P4CLPyp5BfGQ2EXRocAVx/XXNXcfUQKdNL0
	bJ3sS4vgTRJtTz8npHctWqaPph7+uHn8o51ku2n3DR0s5IoI7/ntAaB9T92CDsAux5kQmG
	MaP3Ymk9ewOwY/MVcsk34H/PZEsYr10=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Greg Thelen <gthelen@google.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
Message-ID: <dhq4sgkuyix6le66i6usodzs6pqyturvl7awmzuyfzpgbqg5x7@xxocuq2wmbvd>
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CABdmKX2Hsd7i_Erc2_n8FQqY90mMgX24hkVe+z=y9tCk7sUL6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2Hsd7i_Erc2_n8FQqY90mMgX24hkVe+z=y9tCk7sUL6g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi T.J.

On Thu, Jul 25, 2024 at 04:12:12PM GMT, T.J. Mercier wrote:
> On Mon, Jul 22, 2024 at 3:53 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Linux kernel does not expose memory.current on the root memcg and there
> > are applications which have to traverse all the top level memcgs to
> > calculate the total memory charged in the system. This is more expensive
> > (directory traversal and multiple open and reads) and is racy on a busy
> > machine. As the kernel already have the needed information i.e. root's
> > memory.current, why not expose that?
> >
> > However root's memory.current will have a different semantics than the
> > non-root's memory.current as the kernel skips the charging for root, so
> > maybe it is better to have a different named interface for the root.
> > Something like memory.children_usage only for root memcg.
> >
> > Now there is still a question that why the kernel does not expose
> > memory.current for the root. The historical reason was that the memcg
> > charging was expensice and to provide the users to bypass the memcg
> > charging by letting them run in the root. However do we still want to
> > have this exception today? What is stopping us to start charging the
> > root memcg as well. Of course the root will not have limits but the
> > allocations will go through memcg charging and then the memory.current
> > of root and non-root will have the same semantics.
> >
> > This is an RFC to start a discussion on memcg charging for root.
> 
> Hi Shakeel,
> 
> Since the root already has a page_counter I'm not opposed to this new
> file as it doesn't increase the page_counter depth for children.
> However I don't currently have any use-cases for it that wouldn't be
> met by memory.stat in the root.

I think difference would be getting a single number versus accumulating
different fields in memory.stat to get that number (memory used by
root's children) which might be a bit error prone.

> 
> As far as charging, I've only ever seen kthreads and init in the root.
> You have workloads that run there?

No workloads in root. The charging is only to make the semanctics of
root's memory.current same as its descendants.

Thanks,
Shakeel

