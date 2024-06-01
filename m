Return-Path: <linux-kernel+bounces-197732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C48D6E87
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB6C1F263D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADC12E78;
	Sat,  1 Jun 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JnrmL+Cu"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0213ACC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224248; cv=none; b=mJDIe79F41ere9Y+dq27YgV1s8j+hnAFixRs7RvVLjgfF92y80aH5CcogkiSK+Wvhl07g1qjKVgibFoZM2qwLQTbBSYx8MCsGwTxblUYRxjK/hkZjImC6E2fjo5Xx2e3y4vgeeHa2awsakUeRhF7SdmtbY8iPDUUYkpkZwuqDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224248; c=relaxed/simple;
	bh=ovDwxi3tcz3pJoMynXB6B3gNsYX0DbhrzvDG3ymZAQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apgtbFasi1j9Xfq1DHkfDwjhpnz4nUTw00R7vu3FB3DqobUxZLv5hKitojJoh1WwpfOGrYk3RPJPrT1aRyYU12CkIyjOE/tctLEkgINH7zepakKJ3eXJQfjheFdtXbHmoikjjWNFLTa54wNtKlIJqLJHvv5PiAOgYXERki/K5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JnrmL+Cu; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VIg2mNBQDjdMf0q35Z+ZSPuRtiXctWkRo8tF9MZYgY=;
	b=JnrmL+CuFdYq514T7WX6OQe2nXZR3DRfBmrOvqv5tszp4fDPFmzQETUg1HzLWpDNzD7knp
	MB53gtoVapBsrFQtWNirdAWi+NDzUUp3E8D9/eJR0UZH/gUZCugxekY3nRtB4IUgbm7Cf5
	ct2YELDI5KIT7gxwIPi8u0fJnA1vZ18=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:44:01 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/14] mm: memcg: move charge migration code to
 memcontrol-v1.c
Message-ID: <uikaahfbzjx5oeyz6rtwlurq43nhtna2e4fd3asjfykl3ytw2q@lex4hu7wxlwu>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-5-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:20:56PM GMT, Roman Gushchin wrote:
> Unlike the legacy cgroup v1 memory controller, cgroup v2 memory
> controller doesn't support moving charged pages between cgroups.
> 
> It's a fairly large and complicated code which created a number
> of problems in the past. Let's move this code into memcontrol-v1.c.
> It shaves off 1k lines from memcontrol.c. It's also another step
> towards making the legacy memory controller code optionally compiled.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

