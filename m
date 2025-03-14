Return-Path: <linux-kernel+bounces-561310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3846A60FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424F31729F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375B1FA856;
	Fri, 14 Mar 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drFHfaDf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F621F1818
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951908; cv=none; b=gb1GHgvkocCPlTpvY2B7F8lMfkRh7jCsXtmzrl2o8em/7G2XwqCqmnd1G9zc5I81taKVg2zceS01o8K2MiWN3JiTT/3UCHUi8XD+knt9suws1t11Kqb9M0qW3YwrBlJDKC0xQthZ2BMPGljvVs/kr/usWnuz3OyGIPEVKn9fyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951908; c=relaxed/simple;
	bh=YgTxtawVTwqVrsIanp4JgigiPn9sO0G0cXdeTcArrgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPm3f+h0CvcQcQiB91YutgL2OBl3u5tFWOHK5UKggLcBZ4hODDk9jQnUokiMaKtsEuQhXwll7+JltvWrIGaHlvGdH2UqHwRjOczAnZL8evI2GHZ2y7nLmzg5VWDzyDzMcL9ippVcZLTprfgfo3HxbirsMatwP1Ki11IZVsiPjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drFHfaDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D1CC4CEE3;
	Fri, 14 Mar 2025 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741951908;
	bh=YgTxtawVTwqVrsIanp4JgigiPn9sO0G0cXdeTcArrgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drFHfaDfovZf9GOFxyy0AnpqYpfAaFkc0IL2UZ9ZetWEoaIY/veVHwSOY2zxe0Nmn
	 id/BsYalBwZE5wPD5lNAJb9rofUHb8FcbOH3C26LoaHt7QsmuY+zVRexeaBvTDAdr1
	 Hy09FVDAXlxbHOqyTgOTuBEcsyCFYU4I6m/oDKgS/wt7j0Jga5HscfjzeBI9ZkOjRN
	 nilFzqfaroEI/zXVH9+JJXEHmFBY+zUQ39ZwVWcoUFuE2P8LzeuiM4jL2+iADrj4M2
	 a39TxFUXv3CXfPY5kg7MYZOxYfaHdC6ANsw1j1UOlxF+24UTk7SrtlzxV0NCWDtskX
	 hXJoCoioAkE9Q==
Date: Fri, 14 Mar 2025 11:31:38 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	broonie@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64/sysreg: Enforce whole word match for
 open/close tokens
Message-ID: <20250314113137.GA8865@willie-the-truck>
References: <20250115162600.2153226-1-james.clark@linaro.org>
 <20250115162600.2153226-3-james.clark@linaro.org>
 <20250313215622.GA8101@willie-the-truck>
 <36968527640d231882444ba7065317fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36968527640d231882444ba7065317fe@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 14, 2025 at 07:40:36AM +0000, Marc Zyngier wrote:
> On 2025-03-13 21:56, Will Deacon wrote:
> > On Wed, Jan 15, 2025 at 04:25:56PM +0000, James Clark wrote:
> > > Opening and closing tokens can also match on words with common
> > > prefixes
> > > like "Endsysreg" vs "EndsysregFields". This could potentially make the
> > > script go wrong in weird ways so make it fall through to the fatal
> > > unhandled statement catcher if it doesn't fully match the current
> > > block.
> > > 
> > > Closing ones also get expect_fields(1) to ensure nothing other than
> > > whitespace follows.
> > > 
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > >  arch/arm64/tools/gen-sysreg.awk | 31 +++++++++++++++++--------------
> > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/arch/arm64/tools/gen-sysreg.awk
> > > b/arch/arm64/tools/gen-sysreg.awk
> > > index 1a2afc9fdd42..f2a1732cb1f6 100755
> > > --- a/arch/arm64/tools/gen-sysreg.awk
> > > +++ b/arch/arm64/tools/gen-sysreg.awk
> > > @@ -111,7 +111,7 @@ END {
> > >  /^$/ { next }
> > >  /^[\t ]*#/ { next }
> > > 
> > > -/^SysregFields/ && block_current() == "Root" {
> > > +$1 == "SysregFields" && block_current() == "Root" {
> > 
> > Stylistic nit, but could you just do:
> > 
> > 	/^SysregFields$/ && block_current() == "Root" {
> > 
> > instead? That way the diff is smaller (well, same number of lines) and
> > you avoid the ugly $1.
> 
> The code is trying to match the first field of a line such as:
> 
> SysregFields	ZCR_ELx
> 
> while you seem to try and match a SysregFields all alone on a line.
> 
> That being said, my perl-foo is sub-zero, so I may be very wrong myself.


Ah, and this is *awk* so $1 is the first field.

So my suggestion is totally broken and the original patch looks correct:

Acked-by: Will Deacon <will@kernel.org>

Will

