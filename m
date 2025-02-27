Return-Path: <linux-kernel+bounces-535715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF8A47657
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97333B1A46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BE22068A;
	Thu, 27 Feb 2025 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LWRisCae"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522F21B9E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640193; cv=none; b=GY8TvSgVaE8W/mqzgaznVCUREPAd7MLI9VItb7JSJkKC9Ya/11ml7ggAPplZrgxhsLmrfzwEiMtW9D7/uvrhWFtbzE5sssEWhunhEi35Dimdb7DHBR/S08xmwCVHI8M3asF9U1P0wFzPrrCLSJxAWSonpaaUGvUY/9E6KlEMrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640193; c=relaxed/simple;
	bh=g0mhJjTKUFtQV4MJaV9p7dJy/oKu2TujY6P28xN5oDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQqIZbqpgk2lhtbwZVYaeIxzhkXGKTiMo5IRhv+3Y97Yo0eHG6Bzoyd9iUcNxklWlnCqQFRnh9vMKy5Vl5aJ2EI/tvwIDRaG2BfkdTMBWFuPNTE61dYTysrEeF8x2FKSOTvQCuYZZt8CrnNgKTD27/CrHfUre3kA+45QgzJFXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LWRisCae; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 07:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740640188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgki+CUv8IlgeSjJZuJEm/5IGcmTpjTZa6ciVHLcVNo=;
	b=LWRisCaer7VoLGPu70KAFsml1TLS3Tg0n/tl4mkm4NlK7fSW27kEVmOaQdQ0MJ7r43+ImI
	CD6mgZReq7KGC9E6N3BsGz7ZhTDzNFHavc1oZDNTBBCfMgljuXyPcOyqQFttDlGkRNFpH1
	NmGfCnowV90hLPI/Famq92mhkt6l4y4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 14/19] zsmalloc: introduce new object mapping API
Message-ID: <Z8APt1NGMm6XgrJh@google.com>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
 <20250227043618.88380-15-senozhatsky@chromium.org>
 <Z7_8koiBRTfQ81bb@google.com>
 <4zyr3n2h275zrzgseyvhani2m3avsonobqpg7xzumsnm5rzum2@b7c2xenjkidz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4zyr3n2h275zrzgseyvhani2m3avsonobqpg7xzumsnm5rzum2@b7c2xenjkidz>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 03:54:19PM +0900, Sergey Senozhatsky wrote:
> On (25/02/27 05:48), Yosry Ahmed wrote:
> > > The old API will stay around until the remaining users switch
> > > to the new one.  After that we'll also remove zsmalloc per-CPU
> > > buffer and CPU hotplug handling.
> > > 
> > > The split of map(RO) and map(WO) into read_{begin/end}/write is
> > > suggested by Yosry Ahmed.
> > > 
> > > Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > 
> > I see my Reviewed-by was removed at some point. Did something change in
> > this patch (do I need to review it again) or was it just lost?
> 
> No, nothing has changed.  I am actually not sure why it's not there
> anymore... Sorry.

No worries, I am just glad I don't have to review it again :P

