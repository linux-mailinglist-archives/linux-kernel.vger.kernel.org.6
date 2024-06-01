Return-Path: <linux-kernel+bounces-197729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555848D6E84
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D78289D00
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB781134A8;
	Sat,  1 Jun 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3zEMGNS"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55773D8E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224153; cv=none; b=XC0eG8SJSfisAwW5oAdKN7Bq74peATi+e1F6fcMSt0wB5cj6FIWkCr9wre52AD+X1vaxjlvmSR6kziEI0MJ4ICqq19T5eXi+NnqHsmzfhOUB1dLVKPnCdfnjR0BOGyHscW2fVqP4ZAH2zta34KqvAEFOoLDKm5thmeok6oAfriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224153; c=relaxed/simple;
	bh=zjiBAS8Uiy1EkJEUIUZb4M0oIoEWM4PLw4NoJgqQuBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU2NGpxgjY0RD+9RjtwXTKVHocgLJcCyj54XKgH4HZ+GXg0CVMesfpzY4Cf4V+LoSmjoV4BnxEvi4IfohM80lV+YYqsOWAfAMFaCfJWyUcSKg2xK9nBxKaRp2aCFuQR6hksIT9mrRNlWMlC7oLjUhkDOKsrasM7zCFLxfW9ELEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3zEMGNS; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJubcso589KiLIJnUZuMBuVe5VacFLyisMc2Ijiw/lg=;
	b=Q3zEMGNSsuXYI7HIzD4DjUwY2P91IcLpkC9RNUoz6DvDUXelHgf3hWoKTaMr7W6Z7Gy0AI
	k+8vv/M4f71DX1vLOwlPfaYWxMkRxBdxDiqkoIVyVHu04fDqsvNDehxB9tgHgk72uZNYlf
	mgfRV84K5VBjl47fjCZc8uCuCz0/FTk=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:42:26 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] mm: memcg: introduce memcontrol-v1.c
Message-ID: <wzdqwjtlabf4w5tpjmkcg5xkdw3wngvth3pcx6gbug56vlvlvq@bgswx33kuaml>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-2-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:20:53PM GMT, Roman Gushchin wrote:
> This patch introduces the mm/memcontrol-v1.c source file which will be used for
> all legacy (cgroup v1) memory cgroup code. It also introduces mm/memcontrol-v1.h
> to keep declarations shared between mm/memcontrol.c and mm/memcontrol-v1.c.
> 
> As of now, let's compile it if CONFIG_MEMCG is set, similar to mm/memcontrol.c.
> Later on it can be switched to use a separate config option, so that the legacy
> code won't be compiled if not required.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

