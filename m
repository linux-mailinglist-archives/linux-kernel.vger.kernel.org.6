Return-Path: <linux-kernel+bounces-323156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73D9738A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2212864E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B575191F94;
	Tue, 10 Sep 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHcAaJRW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7E137772
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974963; cv=none; b=t0hfw/EVV0JhJBJew3oVUx4RlrCUX9CgE49YbSoYpm0nsN2gETYCJ+mVxINOGelLBgXYXPeMHGGGJMInNl4si/vWRJlmjYlSYzgWU0b8ENz44a8n0aXQlWg3cC8jEr4iK8s/Sz/tBh5RFhE6LHnY2y1X9KTAznwgESt/3OPXSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974963; c=relaxed/simple;
	bh=yfTc6oxpd+Mt+p18VAYXcuhQze32Z41xBhz/NewZGsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LILsMgqWVyoUdvuc3zT9MpFRNEqPuYU9xxXF8w5m31z5mOyjpaZBRV5B3GlQ9fjE/St9s2t6E7JYprcNgXo8Bp3bazqjI/DTdszywiqp/mK1ve8XdtzaQZQducoNG+1ZMIUAjpMLfrXe7DM2KrG13x3VSlsiG6SY49gsNeQQ4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHcAaJRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D0C4CEC3;
	Tue, 10 Sep 2024 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725974963;
	bh=yfTc6oxpd+Mt+p18VAYXcuhQze32Z41xBhz/NewZGsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHcAaJRWOUGEdqWKky0WxlBtwVlBuQ4xRlKQg3XW/F56aFVNmtFwB0FQoyoTfcVhc
	 bNMgw93N7sGKydI3ORmARKZVAeFZSx9f1euMvNZxdrv3UIni7Qip+d2ps0Tgaj7XSk
	 xy3TgGFs5xdsI8v1EyyQNP1wG0VNzBPsqR89lIvW8Uv/Sjwzzs/b3YFnVQZijJfA5a
	 zrBe5rVqFPs/Sk0mXY+/WHlkYUvqjr1qP72vOMDifVNp4VRE9f/H2h351DfaUfWdj7
	 kEvH+sdp6ZmvQpql1pb/DQDPfGCK9mmRYY89wx/US+4zer5VLu8CiZcslHQ7hPbIm7
	 mgU97oyquwMeQ==
Date: Tue, 10 Sep 2024 16:26:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Drop unused set_pte_safe()
Message-ID: <ZuBJArZ2kNxen1_z@kernel.org>
References: <20240910090409.374424-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910090409.374424-1-anshuman.khandual@arm.com>

On Tue, Sep 10, 2024 at 02:34:09PM +0530, Anshuman Khandual wrote:
> All set_pte_safe() usage have been dropped after the commit eccd906484d1
> ("x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page")
> This just drops now unused helper set_pte_safe().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/pgtable.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..aeabbf0db7c8 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1058,12 +1058,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>   * same value. Otherwise, use the typical "set" helpers and flush the
>   * TLB.
>   */
> -#define set_pte_safe(ptep, pte) \
> -({ \
> -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> -	set_pte(ptep, pte); \
> -})
> -
>  #define set_pmd_safe(pmdp, pmd) \
>  ({ \
>  	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.

