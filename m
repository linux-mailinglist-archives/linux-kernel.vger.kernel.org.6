Return-Path: <linux-kernel+bounces-368278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3959A0D94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C4F1C22652
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390F020C479;
	Wed, 16 Oct 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nmvdSpEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4715665D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091070; cv=none; b=uVVySq5YPspn3pGOrZ2Ryi44r5+E0MpncxYJZF6uNZTc4AgytRPEUqhgbFmtsIyg4Z4GfTT2Bs+lyfjoNvWJHlybPnqWAnFnIrqDlSV7o/3zSnH7OlSLELhS50w/KTUUp0TxPAY1rGcUpsEljLz+sPnsBTmmkRVqOBgeXQUgzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091070; c=relaxed/simple;
	bh=qnAffNY28nDMi5a95OYOsa1fgfsUTu23VCQwq4h3Bck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEHFedhzlTdLPA2tvjS2DZjKXsbpTYxbIA54PI3zwqcE0skNZD3ND64LOoPpB8RV9/kq05nOfbewuLwyd0yxWRxy1W03jXEvSSv7fPPSHgGHh76F+nTnbgEHXkcTOYJB7gDvaR3eKTDeGWGOfD8tu3k+2wJj1ibZE1RRnxIwLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nmvdSpEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4CDC4CEC7;
	Wed, 16 Oct 2024 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729091070;
	bh=qnAffNY28nDMi5a95OYOsa1fgfsUTu23VCQwq4h3Bck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmvdSpEFPa3zDqw9SIf/L64RSEaxNibrBy2VT8JHWWAtPu0pTJ2SFyeXAvyRekQQ8
	 TnHgeYx8cE4m2K2v2mV11mNgTCCY+V69NP8uRMk76RVtUT9xh389jGUpBSt39Q11fe
	 5ozSQ4Asm60AMDhzDV8yPJRkAxBH1vc8xwxvkgS8=
Date: Wed, 16 Oct 2024 17:04:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 30/57] drivers/base: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <2024101626-reattach-spiny-98dd@gregkh>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-30-ryan.roberts@arm.com>
 <43395dc5-51e1-417b-8a0a-7b8482a24411@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43395dc5-51e1-417b-8a0a-7b8482a24411@arm.com>

On Wed, Oct 16, 2024 at 03:45:48PM +0100, Ryan Roberts wrote:
> + Greg Kroah-Hartman
> 
> This was a rather tricky series to get the recipients correct for and my script
> did not realize that "supporter" was a pseudonym for "maintainer" so you were
> missed off the original post. Appologies!

"supporter" is actually a much stronger "signal" than "maintainer"
according to the MAINTAINERS file:
		Supported:   Someone is actually paid to look after this.
		Maintained:  Someone actually looks after it.

> More context in cover letter:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

Ick, good luck!

greg k-h

