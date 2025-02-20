Return-Path: <linux-kernel+bounces-523782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82AA3DB37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07AC189C9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DC1F8691;
	Thu, 20 Feb 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J0E0nXLx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B61F8BCD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057745; cv=none; b=Cd4ngkb8RJgTDHD8TP7vMGXin9Fe2e45+4RlczPleacMFmhmNaq7Gbn1fKIm1isf7lgNdwTYnCTVgZ81goYHElTLOy6RQDrVUTUH9f3lQQ9tha31SiCVP8qJq5XmYcjkuaLRw2mektrEbqJRHgQpCp8hQek8A16pyMh6I8pNF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057745; c=relaxed/simple;
	bh=gFDRPAZulNOHSJBDBjwclKNOYUTJihNdrhChS78Y4Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPIUa72vKNE9RpH6BWMQoOhY3BtEjkeeJCkJmeYlSWndIhDN+/ASG59IylgaKBYUADYo6D1T9BEpyTzePqGp+B0ptrW946N+9QDIQ0e5pKOGl9AaeOgzSYi2J9Y8SMZ9h8EwtdacKJiCZSmZ0D5M+wwRV8xNLHSReQVhbinQnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J0E0nXLx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gFDRPAZulNOHSJBDBjwclKNOYUTJihNdrhChS78Y4Zg=; b=J0E0nXLxkrXPpSqn7Z4ANpzSF3
	DZJGFyPGaLwyK7ubWNbny5cmeOXhJIRJ88xgzSg7k8h/rG/FjhosLCy6yY86l8eAwRwvmPqe3bSDq
	MTbtJofluAf1dfRQpva3c262JRoJVKsZiW/629TejDGpQOELJyGHzpze2AGNvg7WBteEFYOiWr8vA
	R0ItP0bhF53EYz2h5kwdkoEyCbk26V+yAHk97aodcKNe3+aCh+BkzGQx6SUMRmPbCVG6Baync7KVr
	RwIMvF8B5opKQDAunumF5DAumjyP86XzPW3PXWfVzmuqlRuasr/Nvi5hz2fx1tIPgtWFcCFw5jzcE
	E2jwPIqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl6VR-00000009htn-0JKe;
	Thu, 20 Feb 2025 13:22:21 +0000
Date: Thu, 20 Feb 2025 13:22:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Shengken.Lin@amlogic.com" <Shengken.Lin@amlogic.com>
Cc: akpm <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] mm: Remove redundant PageMemcgKmem(page) call
Message-ID: <Z7csjFF5dkj3aWGq@casper.infradead.org>
References: <20250212020627.3461237-1-shengken.lin@amlogic.com>
 <Z6wjYQUxIstEqJHC@casper.infradead.org>
 <202502201747552959016@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502201747552959016@amlogic.com>

On Thu, Feb 20, 2025 at 05:47:56PM +0800, Shengken.Lin@amlogic.com wrote:
> If it can save a function call, then adding PageMemcgKmem(page)
> in include/linux/memcontrol.h would make the code more consistent.

The code is fine the way it is.

