Return-Path: <linux-kernel+bounces-306133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AC9639BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA142285567
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0B73452;
	Thu, 29 Aug 2024 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hhbg0CGA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610DA955
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907922; cv=none; b=I1GjXJMl/7830eEKFtKA0KSpQZvux2WnpJHotg3tsOXA0mylIDE0CnpF/uvyOlJ5EMRDSy8/+WCiW5Ecl4pze81UP1sxAnmaxO0pGlgBgXmJ6J+PmPXJJ8WNvUyNvnXh5I65Vj0cnh+CS70jwiMHz+W2o5ZI1FvzJ4jfq9CWmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907922; c=relaxed/simple;
	bh=dzmxjCJcIg7wVud16eVJLp6puavhu521F3ruYBtz/ZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BewNfHPtnVFkwgIsr2d+YP15HG8iugoDcQtx8t9CpdvfKWMuXnLyZLH12Ki+iNTDhvKAnwZ2n3MrixeMYwBovcvcTEYgW/R6zb8+9/ggXLI0zdVYyHp3BExtbEkGiFGU1SNVvfrUaa4Uag+i19ccmbB7yKuUOZHAt/tbZnMl0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hhbg0CGA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T54gn2093143;
	Thu, 29 Aug 2024 00:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724907882;
	bh=oh+T8+2cjQsd8WEICvqGPQ5H2HR4Up7D0a50b0F/AIY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hhbg0CGAFor9eG1OPBwMoUospQGTu/i4XEs8TaHyzeNRZ41eEdvXwhZBxVOPYZ3e/
	 czcRAfIQoaLBcAcCKBlB6E04ayY4tE8uhlIUK0jNgfcp+Fud8wgQE24o8CMNMCLQ08
	 vuhyQxpZa1P7OePS24/IWMbfxyeGPdb4X0WQhG0o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T54gKi010814
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 00:04:42 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 00:04:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 00:04:42 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T54gKk028762;
	Thu, 29 Aug 2024 00:04:42 -0500
Date: Thu, 29 Aug 2024 00:04:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <bb@ti.com>, <d-gole@ti.com>,
        Jan Dakinevich
	<jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH] mfd: syscon: Set max_register_is_0 when syscon points to
 a single register
Message-ID: <20240829050442.77v54yjvq44ja2dd@cresting>
References: <20240828121008.3066002-1-nm@ti.com>
 <f72500a5-4514-4920-a7f0-3fc8e6874615@sirena.org.uk>
 <20240828133229.67bej3utpgrmzr3p@retired>
 <ce44b268-d138-445d-a149-e5348897d3c5@sirena.org.uk>
 <20240828144434.oydsgflsqy5vibxe@sapling>
 <efac0d73-9a33-4851-9f66-7dae5bfc515f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <efac0d73-9a33-4851-9f66-7dae5bfc515f@sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 21:26-20240828, Mark Brown wrote:
> On Wed, Aug 28, 2024 at 09:44:34AM -0500, Nishanth Menon wrote:
> 
> > This is a patch for syscon, not regmap. I am a bit confused as to what
> > objection beyond the "Fixes" usage (which I can drop
> > in a respin) you may have here, will appreciate if you are NAKing the
> > patch and on what rationale.
> 
> > I understand that regmap considers the max_register usage entirely
> > optional, but syscon does already use it (my patch doesn't introduce
> > it). I am just getting syscon to catchup to what regmap already
> > provides.
> 
> If you are absolutely confident that all syscon users know how big their
> regmap is then modulo the claim that it's a fix for an unrelated patch
> which doesn't change the behaviour for these regmaps at all then it's
> fine.

Thanks for clarifying - I understand now.. I will drop the fixes tag
and refresh the patch with appropriate wording - but, to the best of
my search[1] ("Absolutely confident" is a pretty strong terminology for
any patch ;)) there is expectation of max_registers being enforced..
based on what the driver does today.

[1] https://gist.github.com/nmenon/d537096d041fa553565fba7577d2cd24 ->
 the pattern seems relatively controlled problem that existing code
 as far as I can see doesn't seem to mis-behave.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

