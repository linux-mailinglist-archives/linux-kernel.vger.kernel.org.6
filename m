Return-Path: <linux-kernel+bounces-536963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C69A4865A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FA3A8E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB7E1DE2AA;
	Thu, 27 Feb 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC6bXiBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143891B4F0B;
	Thu, 27 Feb 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676504; cv=none; b=EFo3uEI65qbaaHNC4XeNC7dWECqKJvgHOC+7btqMJNZoyi6OL3O+vbqDSMQTFOAIuk3n1xleuTFWctaNYoKQTJhnFQdg2t4QE/+26uv2IsTKOgBUyTMxCwSY18lhpaysFmBsyN3JUW4RMjXyhxGHRYg+Zxq9p3i60iAOSrFFBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676504; c=relaxed/simple;
	bh=mk/mubO5LSKwfY0cYtZcfLEJxgXni56oyX5lS8pUi5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhqoKKelgWxQHKT29zxxUDKAOWt2/CT2v5NNGLebyr4eIULuvsdDbCKtyK0NmVofsCg1usVTZEHWvloV6FrZSkCVcfryrjGpx1TMhlx4skMTXAkshhsejMvlgT5Oh4zyAbxxxz0LJ1RkkwT+mNNkRfTjA65bINeRaEQp5iMk6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC6bXiBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078C9C4CEDD;
	Thu, 27 Feb 2025 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740676503;
	bh=mk/mubO5LSKwfY0cYtZcfLEJxgXni56oyX5lS8pUi5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gC6bXiBWzvbGXtelMxi86GmfaIgANbAHdg/8mTwHMDZWCxoMJP3mPx9HVVqnEEnU7
	 8/h0ftM+uiHUfhiduzNc23uueBB752KaJaOncgeGUOj0UG1jQw+4xV/KirDZh2uYaR
	 WMP/eqy5mVejKIETlUvXpp9+QZEq44T8QfkMdBGBwPQ0aYjediN+N7Vn6ZlXce9C27
	 Rggxtba/vDc+W4+v/VBvNPmOgm5QeL4TOMRGlM8/jC1Sgy1oOXsf5ljznsOMPhgf6v
	 rx5EJ16so8a8ra2agwKc4Jk/V8EVWn1YE3h4A7URXcGWZu7tc1VHR7J+Db+6JUjdNm
	 KLuRFjyWU/AqA==
Date: Thu, 27 Feb 2025 17:14:57 +0000
From: Will Deacon <will@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 06/10] perf: arm_pmuv3: Add support for ARM Rainier PMU
Message-ID: <20250227171456.GA25617@willie-the-truck>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <20250221180349.1413089-7-vincenzo.frascino@arm.com>
 <Z8A6FttvudR6rjzk@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8A6FttvudR6rjzk@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 27, 2025 at 10:10:30AM +0000, Sudeep Holla wrote:
> 
> On Fri, Feb 21, 2025 at 06:03:45PM +0000, Vincenzo Frascino wrote:
> > Add support for the ARM Rainier CPU core PMU.
> >
> 
> I can't take this through Arm SoC as the DTS and dt-bindings changes
> are kept separate from the driver changes in their pull request to Linus.
> 
> I need to keep the bindings(05/10) and the DTS(07/10) together to avoid
> DTC warnings.
> 
> So the 2 options I see are:
> Defer this driver change until the bindings last upstream.
> OR
> Just take the perf driver change without the binding via perf tree
> 
> For now, I will take all other patches except this.

Works for me. I'll pick up the driver patch.

Will

