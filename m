Return-Path: <linux-kernel+bounces-543847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FFA4DA91
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861EB7A29EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56631FBC86;
	Tue,  4 Mar 2025 10:30:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4D1E5B64;
	Tue,  4 Mar 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084231; cv=none; b=j4DoEr55Eoe7PTDl28NhhIOf7VkGC2EFQXoInElnAjfjqrxk7/7oJCDNl+p1zPUi0x5iy+fKYf7nuXieCD7fOUvFgVo7klXvbRW9e2V0w6irwKitiYmnsQaOJlpdxadyjPS0P6s1dugLy0UZVF/i7CX0TAE2bq8lYYADmYMqBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084231; c=relaxed/simple;
	bh=sq87APQYN9gwp9sgEfBYcpg58sQEn2OeRob2+GyOL6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN6F30JkOnXewBhRUPBdJU+dfOfm7+z4R+CdIFTsa9VdhL3F+N8NCHIA7eijaD7CK343PsnCuABSjhgH9/mnCp8fdmnhuLubEwYBkE9XfBSdnZtFvM7ESAt1/yUd4Ehytj1l3V1zLVPtzQHZtGIYSHyMXwkAcaNZEDad/SDAcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B88D7FEC;
	Tue,  4 Mar 2025 02:30:42 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F18E3F5A1;
	Tue,  4 Mar 2025 02:30:26 -0800 (PST)
Date: Tue, 4 Mar 2025 10:30:24 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>, conor+dt@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2] arm64: dts: corstone1000: Add definitions for
 secondary CPU cores
Message-ID: <Z8bWQDVebIehuftS@bogus>
References: <Z8XSIx75B4mtcV48@bogus>
 <20250303170012.469576-1-hugues.kambampiana@arm.com>
 <174108287362.420865.6246087705407586774.b4-ty@arm.com>
 <f6c7feb3-e003-4bbc-8179-3a3df533d2d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6c7feb3-e003-4bbc-8179-3a3df533d2d5@kernel.org>

On Tue, Mar 04, 2025 at 11:12:57AM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2025 11:08, Sudeep Holla wrote:
> > On Mon, 03 Mar 2025 17:00:12 +0000, Hugues KAMBA MPIANA wrote:
> >> Add `cpu1`, `cpu2` and `cpu3` nodes to the Corstone1000 device tree to
> >> enable support for secondary CPU cores.
> >>
> >> This update facilitates symmetric multiprocessing (SMP) support on
> >> the Corstone1000 Fixed Virtual Platform (FVP), allowing the
> >> secondary cores to be properly initialised and utilised.
> >>
> >> [...]
> > 
> > Applied to sudeep.holla/linux (for-next/juno/updates), thanks!
> > 
> > [1/1] arm64: dts: corstone1000: Add definitions for secondary CPU cores
> >       https://git.kernel.org/sudeep.holla/c/21b9f56cec8f
> 
> Why? Nothing improved here comparing to v1.
> 
> Your comment are still valid and the patch is still not correct.
> 

It was not marked clearly or noted as change. I agree that is confusing.

However the following was added:

"Only FVP platform will have SMP support and hence the secondary cpu
definitions are not added to corstone1000.dtsi"

Hugues pinged me in private to explain why it is done in that way and I
asked him to add the reasoning in the commit message which he did but
failed to capture in the v1->v2 changelog. I mentioned it in private
again as he is new contributor to the kernel, I was less strict on him 😉.

--
Regards,
Sudeep

