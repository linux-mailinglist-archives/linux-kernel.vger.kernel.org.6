Return-Path: <linux-kernel+bounces-214727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C214F908939
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB34F1C26862
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43C194AC2;
	Fri, 14 Jun 2024 10:02:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB5194153;
	Fri, 14 Jun 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359330; cv=none; b=bB6j4x5qZlTG0TtxCHXf22llBfHgyRNF2kmVWb06qIqQkEafp0M4vDN1MjhwL1B5Lg7RIFcSDuGTaEPwlaiU7quE9lELYQY7FTZku0ap7XxYfpQuxxXbRkKmX8Fsnt9SNAE2Bkj9fSjmYT7lLtnty11bnNEsnPyzdWejB46gc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359330; c=relaxed/simple;
	bh=h+C+mpAk7vxV3inJhnDBH59Xi0o0Ki586l+o5iTAv6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XM8cTblLiJxsHKPoht3jTutdi9K5s6dtXmTAC9WkhdT4lleRmu+8EwE/4cqIodg4ZbsqdmFKyWqf6kV7zbk1oBKnd1XT15L6wHz4XTEN7wRzBZPjHFdESlhz46/uyf0bfE/squedK7yxpNU/Mxv//9R8SaP9f9l3bIdAPmx+baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9E52DA7;
	Fri, 14 Jun 2024 03:02:32 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90973F5A1;
	Fri, 14 Jun 2024 03:02:05 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:01:56 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>, Philippe Simons <simons.philippe@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Ryan
 Walklin <ryan@testtoast.com>, Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 2/5] regulator: axp20x: AXP717: fix LDO supply rails
 and off-by-ones
Message-ID: <20240614110156.230f5109@donnerap.manchester.arm.com>
In-Reply-To: <20240614081224.GD2561462@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
	<20240418000736.24338-3-andre.przywara@arm.com>
	<f685b49a-36b1-46c9-a0a3-734bca8bd968@arm.com>
	<20240614081224.GD2561462@google.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 09:12:24 +0100
Lee Jones <lee@kernel.org> wrote:

Hi Lee,

> On Wed, 12 Jun 2024, Andre Przywara wrote:
> 
> > Hi Broonie,
> > 
> > On 18/04/2024 01:07, Andre Przywara wrote:  
> > > The X-Powers AXP717 PMIC has separate input supply pins for each group
> > > of LDOs, so they are not all using the same DCDC1 input, as described
> > > currently.
> > > 
> > > Replace the "supply" member of each LDO description with the respective
> > > group supply name, so that the supply dependencies can be correctly
> > > described in the devicetree.
> > > 
> > > Also fix two off-by-ones in the regulator macros, after some double
> > > checking the numbers against the datasheet. This uncovered a bug in the
> > > datasheet: add a comment to document this.
> > > 
> > > Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> > 
> > Can you please take (at least) this one patch as a fix for 6.10? Applies
> > cleanly on top of v6.10-rc3. The changes are not super-critical, but worth
> > fixing nevertheless.  
> 
> FWIW, I have no idea what's going on with this set now.
> 
> Once all of the necessary patches have been expedited, please gather
> together what's left and I'll take them via MFD.

Yes, we dropped the ball on this one a bit, apologies.
Broonie just took 2/5, so I will resend 3/5-5/5 as a new series, targeting
6.11.

Cheers,
Andre.

