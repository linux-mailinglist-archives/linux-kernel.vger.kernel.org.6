Return-Path: <linux-kernel+bounces-424782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68989DB951
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EED7B20CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34C1AC43E;
	Thu, 28 Nov 2024 14:12:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5C1AA1FE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803142; cv=none; b=YxcFfOP45iO+n25rmaFb5su4GCaRyKqJRObT/a96E6XNMFI4Tv7rFeZjv+WA6Wmnw6eUtU6J4FvGazS/2/jph7crOkcynbigyp93S1fVMvzvo7GmtBa5UIx+gTnso2kB23jyZRMWysbpWfEAVS5+Eq35qVPrdTKPqMYJaAESdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803142; c=relaxed/simple;
	bh=/+B3zck2itj1fo0CzrwluXDWIUHDfX2vbhSmQIpdouA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbxP8mPH+1EJHvPcfYWOJrPOUWxtRZ3/ewWr3TmISyP1EIopOGSsMFgbHALGkNxR1V9NX4i/WDo8H6+XID99qH0fc0XVLBRWP2Sjzqkv11anNIIOE2EzgjmndM5OxF9qXeiTvYc2yofWk4giv64lesLFzMvEM0YMIbJqNgHyeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02414C4CECE;
	Thu, 28 Nov 2024 14:12:20 +0000 (UTC)
Date: Thu, 28 Nov 2024 14:12:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
Message-ID: <Z0h6Qtleb-znhX3u@arm.com>
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap>
 <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>

On Wed, Nov 27, 2024 at 05:21:37PM -0800, Yang Shi wrote:
> > > diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> > > index 87b3f1a25535..ef303a2262c5 100644
> > > --- a/arch/arm64/mm/copypage.c
> > > +++ b/arch/arm64/mm/copypage.c
> > > @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct page *from)
> > >    	if (!system_supports_mte())
> > >    		return;
> > > -	if (folio_test_hugetlb(src) &&
> > > -	    folio_test_hugetlb_mte_tagged(src)) {
> > > -		if (!folio_try_hugetlb_mte_tagging(dst))
> > > +	if (folio_test_hugetlb(src)) {
> > > +		if (!folio_test_hugetlb_mte_tagged(src) ||
> > > +		    !folio_try_hugetlb_mte_tagging(dst))
> > >    			return;
> > >    		/*
> > I wonder why we had a 'return' here originally rather than a
> > WARN_ON_ONCE() as we do further down for the page case. Do you seen any
> > issue with the hunk below? Destination should be a new folio and not
> > tagged yet:
> 
> Yes, I did see problem. Because we copy tags for all sub pages then set
> folio mte tagged when copying the data for the first subpage. The warning
> will be triggered when we copy the second subpage.

Ah, good point, copy_highpage() will be called multiple times for each
subpage but we only do the copying once for the folio.

Now, I wonder whether we should actually defer the tag copying until
copy_page() is called on the head page. This way we can keep the warning
for consistency with the non-compound page case:

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 87b3f1a25535..a86c897017df 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -30,11 +30,13 @@ void copy_highpage(struct page *to, struct page *from)
 	if (!system_supports_mte())
 		return;
 
-	if (folio_test_hugetlb(src) &&
-	    folio_test_hugetlb_mte_tagged(src)) {
-		if (!folio_try_hugetlb_mte_tagging(dst))
+	if (folio_test_hugetlb(src)) {
+		if (!folio_test_hugetlb_mte_tagged(src) ||
+		    from != folio_page(src, 0))
 			return;
 
+		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
+
 		/*
 		 * Populate tags for all subpages.
 		 *

-- 
Catalin

