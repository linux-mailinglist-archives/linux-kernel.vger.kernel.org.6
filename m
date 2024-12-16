Return-Path: <linux-kernel+bounces-447969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE649F3961
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC71C1883F17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4A20767A;
	Mon, 16 Dec 2024 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HQ3tOE49"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93F1E87B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375374; cv=none; b=jByFUEco0pSYirFBZdNs5i36SAxHrJa8J0zlFDjg1529NZcSspE0hu6cNAdygpMfsCPXig2uulGj5eSXIvdZK1dJuUU+8OIh3sfG8tUcpOZjPLdXAReRV1vqVkdbrDSELuFTZgTVl1Vh/G40iLzDwQW/6/iXafa9HvGdxTz1lnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375374; c=relaxed/simple;
	bh=OCunimfgWVWBE+cXrh17vA0J8Ytw06qEwOuZhJO01xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEZTQ95BewFPrb5ApIRdQ1pMMQX0jdJnzEGLPWxYPAaEllIIy9rr4HIP9wulPT/5s2m8+jyW+o012Y2GLmk4VuExNPhzpmpFFEat81yyxNqkKkMnxrY85uERidTAZV82GIpOzIN+UCdlHcyBMsSbh3tm8PtegtWELwcjksGZAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HQ3tOE49; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OCunimfgWVWBE+cXrh17vA0J8Ytw06qEwOuZhJO01xg=; b=HQ3tOE49gyd9nWokJa7O777Tu2
	1cof+uz2nBLfGZpDoS4ZzNlkeA+L4qo/XEQ1MR1Sa8+oCCDv0kDDlDaS/T6FH/Z4NKIyGo5u1KKNr
	IAysNDMVVjWZ7wYQyTMEeZ7oKcdfMnJbxGwFkKIRiMR8og9uFULBKsqSjOBgZQsnHCOVCkinEVrFx
	FMh4aGRDtlakwp90NFE9KgIU4wxcpGhFWl+voqWkkMCnMgK8E1YqFsyCxX61CZNFtnnWX4ltVO+rI
	s3AWt/HmcESefk+dZpTeqWsvMc3LBWXCk4HtyjjfxfYbO1lLxvLsIYTpHC4JAKPhnwtfUIdP65Edw
	jUfL1jmg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNGGH-00000001D5m-0WTK;
	Mon, 16 Dec 2024 18:56:09 +0000
Date: Mon, 16 Dec 2024 18:56:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: linux-mm@kvack.org, mgorman@techsingularity.net, david@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: alloc_pages_bulk_noprof: drop page_list argument
Message-ID: <Z2B3yMiYLwoc6VJB@casper.infradead.org>
References: <20241216184504.19406-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216184504.19406-1-luizcap@redhat.com>

On Mon, Dec 16, 2024 at 01:45:04PM -0500, Luiz Capitulino wrote:
> The commit 387ba26fb1cb added __alloc_pages_bulk() along with the page_list
> argument. The next commit 0f87d9d30f21 added the array-based argument. As
> it turns out, the page_list argument has no users in the current tree (if it
> ever had any). Dropping it allows for a slight simplification and eliminates
> some unnecessary checks, now that page_array is required.

Maybe just fix up Mel's patch:

https://lore.kernel.org/linux-mm/20231025093254.xvomlctwhcuerzky@techsingularity.net/

