Return-Path: <linux-kernel+bounces-305183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F706962AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AACB28197E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794019E7E7;
	Wed, 28 Aug 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qAg5yiO7"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451818950F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856314; cv=none; b=KFULVK9nQAJCdB9aszSHOtUNDq6S8b03T4GeJc5hMAsDwBRjqlVFlk8XsT5Cnx/U9kJoANCVdQmYfT5ls2fakD7LOOpO/efkI8nlTqAwLVyFhHe6VnPluw5wwf4DyDRmGP/lxsax1K2IFWB5m33f6MVKdQqByX66L94WY00AU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856314; c=relaxed/simple;
	bh=D08RVJVTEOtaKajTsY/JVTIYIyjHJrA/on5BgTmYXck=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUfdwRfAZ49w1psyprTAK5UQHRx2PugsUtxQqRrtKMyUqElZIjaAQZi1defwPIc9hDYzofuOJIbGql/srJTzdBkbqU6RVRHJHLWnJMmRsf0DyZoJlmjbDGu/0p/WUOM5MBfYQ2bQOf2ek9hmbV5tSSEk6Heg8Fy6YrFNrmvx6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qAg5yiO7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SEiY6v109709;
	Wed, 28 Aug 2024 09:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724856275;
	bh=aUrm7aKU6rJTEbmYz0DPEIq5CpO6UYunkMXEy01mW9k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qAg5yiO767p5Yrh5FL1j5u2ex16QTwVxkRaqO2WQ/mPDfAAlWzuqRy7Wkm1sADFdD
	 S3CN1lT24XAO8zeJl3cWLYgSod5UP1Exp4lYeMX8RZVdh1qFLZmSOVkc2ZIxpCg2GM
	 vg7aXCRZX89Kv4Lnk/d7jLjqHCv/oolfJ2uiVgyk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SEiYt6052329
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 09:44:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 09:44:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 09:44:34 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SEiYdB105480;
	Wed, 28 Aug 2024 09:44:34 -0500
Date: Wed, 28 Aug 2024 09:44:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <bb@ti.com>, <d-gole@ti.com>,
        Jan Dakinevich
	<jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH] mfd: syscon: Set max_register_is_0 when syscon points to
 a single register
Message-ID: <20240828144434.oydsgflsqy5vibxe@sapling>
References: <20240828121008.3066002-1-nm@ti.com>
 <f72500a5-4514-4920-a7f0-3fc8e6874615@sirena.org.uk>
 <20240828133229.67bej3utpgrmzr3p@retired>
 <ce44b268-d138-445d-a149-e5348897d3c5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce44b268-d138-445d-a149-e5348897d3c5@sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Mark,

On 15:27-20240828, Mark Brown wrote:
> On Wed, Aug 28, 2024 at 08:32:29AM -0500, Nishanth Menon wrote:
> > On 13:57-20240828, Mark Brown wrote:
> > > On Wed, Aug 28, 2024 at 07:10:08AM -0500, Nishanth Menon wrote:
> 
> > > > Fixes: 0ec74ad3c157 ("regmap: rework ->max_register handling")
> 
> > > In what sense is this a fix?
> 
> > The max_register was 0x0 was clearly a corner case. The fix done for
> > remap  should have cleaned up the users of max_register to maintain the
> > behavior. That is just my opinion.
> 
> No, apart from the fact that catching all possible regmap users would be
> rather hard it's entirely optional for regmaps to specify a maxium
> register.

Fair enough, I can drop the 'Fixes' tag.

[...]

> Like I say specifying a maximum register is entirely optional, not

I understand max_register is entirely optional as documented in
include/linux/regmap.h and I understand why max_register_is_0 exists -
the patch does NOT try to revert the valid feature in regmap.

> everyone wants that feature and if you don't use the debugfs interface
> or the flat cache it doesn't *super* matter.  With 0 as default it's
> always going to be awkward to describe a maximum register of 0 while
> allowing that to be optional, fortunately very few devices have a single
> register.

yeah, unfortunately I have to deal with a few of them :(


This is a patch for syscon, not regmap. I am a bit confused as to what
objection beyond the "Fixes" usage (which I can drop
in a respin) you may have here, will appreciate if you are NAKing the
patch and on what rationale.

I understand that regmap considers the max_register usage entirely
optional, but syscon does already use it (my patch doesn't introduce
it). I am just getting syscon to catchup to what regmap already
provides.

Side effect of leaving the current syscon code as is creating bad
results that should can be trivially caught (and could have saved me
a couple of hours of early morning head scratching today[1]). I think
the regmap checks are valuable, and should be consistent in usage by
syscon. And I think the checks are valuable for programmers from
mistakenly introducing bad code.

[1] Already pointed out in diffstat https://lore.kernel.org/all/20240828131601.6sxvnwpcsb36tz4m@eloquent/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

