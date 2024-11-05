Return-Path: <linux-kernel+bounces-395781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C149BC2DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C601F2257B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC312943F;
	Tue,  5 Nov 2024 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uD/fBj5W"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1218641
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771773; cv=none; b=rxwwL6Nr/iqKv7vqQ1mZtLDi5sS9BbQiN1EgJP/sWGK3tNt5irKwOXbEVKvbwvvd7zevGlWX2zH58ad69ZqsCYyfOQMdlDFMgPOZBaFyv1eDAkl11Bun0yfpf23hdae0Qs95jczKEmvE1mdGxKid7OjzQo2LKAh5ANfzIQ2hFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771773; c=relaxed/simple;
	bh=CK78IhNPGQQ6DoOWdBCDvh55jozl0vItdMo8y5D5U6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAl8QOlh1odsbnKh3pJaWhqStlO7HadLZSfXvdkj5hk06dPDsAsFYzIglcVOW8MTe/viCTciliPVL9oFrA0xaNdO6zmaeexu90ZU9Vyhi4TLHIS5dDV5Xmapf3rP1NwSEyJYmQlaJkpqQcgsVkEj9mbRFBx5PrJPRsV3SWgpPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uD/fBj5W; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 Nov 2024 17:55:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730771765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ynilCnkI72Wptbd9knjb2x8bDuE0N5pLnbO7dKEnNA=;
	b=uD/fBj5WpHLwCIORWAlFJqD4BYOVPqHX8O1mZS2HBi7QunzKb1kwkXaCMildUG8CQNPesZ
	tN/BZhfx1oQqOh00/xslKKq+QkAhObG6GRGhO9GOpN2BmMU/FwybhXCMa77I0OjBxlcHEP
	aA+UjNYZJfrQyZRh1qDM3Oqhy/vUc4g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, roman.gushchin@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: fix quoted strings spliting across lines
Message-ID: <ecb7gw2ypw7fordtxy4qpn2gcpzyviykzi3ub4xdisabudhdpv@5bkixrmojmul>
References: <20241104222737.298130-1-kerensun@google.com>
 <20241104222737.298130-2-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104222737.298130-2-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 02:27:34PM -0800, Keren Sun wrote:
> This patch fixes quoted strings splitting across lines in
> pr_warn_once() by putting them into one line.
> 
> Signed-off-by: Keren Sun <kerensun@google.com>

Other patches seems fine but personally I don't like this patch. I
would prefer a multi line string over a very long single line of string.


