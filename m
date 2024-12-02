Return-Path: <linux-kernel+bounces-428124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E149F9E0A73
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FFE28206D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD31DBB21;
	Mon,  2 Dec 2024 17:53:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B11D90B9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161992; cv=none; b=TrCBdbXeC7MtAOhtfnacjz9+Q91RrWYaVzqeBhUbyavMq+TO2KHbAZiGihXDJBm2/X8oEeapdfffn0z2wwhTUmm7EBA4pcTCQeIkX1UgSaoFAWwrSJ3GdOnrUs8GY0vpQ148E6jqn5AB4emmPRsCfSc61KfPLG7SEO/CjhMnHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161992; c=relaxed/simple;
	bh=/OI2o0n14BRB/w14rZ33Mw/DpGu4ZM3ISwZfoXqBX9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXoxtv8yly7r9ob9bQj0r301JQpFEXnRmKh+delD7OrQF3FnDh1mCrNmpR1q5Ck5rLLnU2XCKkHGOap7h9sCDnKVw8T/Z7IXvxvpYEdHslv5vPB8kaiATEq8hOcZNUmqv2Hpjs2OOm8OBZkuihvzIUO+jRBzTN1d1RpTHEEP62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCDD81007;
	Mon,  2 Dec 2024 09:53:37 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6C073F5A1;
	Mon,  2 Dec 2024 09:53:07 -0800 (PST)
Date: Mon, 2 Dec 2024 17:53:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Vitaly Chikunov <vt@altlinux.org>, Will Deacon <will@kernel.org>,
	james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, oliver.upton@linux.dev
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <Z030AVd1_uURWsgL@J2N7QTR9R3>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ser6t6fs.wl-maz@kernel.org>

On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> On Mon, 02 Dec 2024 15:59:40 +0000,
> Vitaly Chikunov <vt@altlinux.org> wrote:
> > 
> > Marc,
> > 
> > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > >
> > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > 
> > No, host is 6.6.60.
> 
> Right. I wouldn't be surprised if:
> 
> - this v6.6 kernel doesn't hide the MPAM feature as it should (and
>   that's proably something we should backport)

Looks like v6.6.60 is missing:

  6685f5d572c22e10 ("KVM: arm64: Disable MPAM visibility by default and ignore VMM writes")

... which is a fix for:

  011e5f5bf529f8ec (" arm64/cpufeature: Add remaining feature bits in ID_AA64PFR0 register")

... which unintentionally exposed ID_AA64PFR0.MPAM to guests, and *is*
in v6.6.60.

Mark.

> - you get a nastygram in the host log telling you that the guest has
>   executed something it shouldn't (you'll get the encoding of the
>   instruction)
> 
> Can you confirm these two things?
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

