Return-Path: <linux-kernel+bounces-250396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF7F92F754
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072CF1C21E40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90014D2B2;
	Fri, 12 Jul 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lzNWrdPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3F13E41A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774485; cv=none; b=qZzQDb4WW0yjkN/axYob+rz178XTG9i3f7BmlWrKalqWQ/Zo0PGGt99Cf1HlFPONCbvT+yRF89Z6zF46W6Y8IzHkN0ErMcLzlBmNxzCEZREgMVzTt0f3bB1F0ZBf7o+RW0e89BW2oW8+V/B7UfYx4cTctDa5hqs+Zq9pf3+dNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774485; c=relaxed/simple;
	bh=KBF1tbOWGnT1tf80E0eOFPpWPxkx+z9V0AzaHMrmLKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2k4m2SedPZI9y0xBbeMJr2lSeW74j5v4EGRmBj1EzVZXcG54/JUU16R8GN68D7Eh3v2ULb5AzwpUE9JEsbzpJQht7G1LpKRvptGvYGk3XiiYK0SaChLO9+dk9hw6aEx7sstqF4aNEW8Qt9+Qi+LxI+U4wFFLaoWN+8X6IeWtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lzNWrdPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF83FC4AF0B;
	Fri, 12 Jul 2024 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720774485;
	bh=KBF1tbOWGnT1tf80E0eOFPpWPxkx+z9V0AzaHMrmLKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzNWrdPFcsNcDn32Kx9K26QKyltPBG1z5fLwk8BH542fx7TjLWHG7JdkhOeHyG+d/
	 kJhsUWugSFcwBhGr8gmBztqkUpZCfQ1X7h2HaHOR9+ESrLmojbO197iOISepk2AAmI
	 /x+FqXfBu/n+OED9Mny4LHI+5Kk8bJQHbgzbUBCo=
Date: Fri, 12 Jul 2024 10:54:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Message-ID: <2024071232-kindling-either-de2c@gregkh>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
 <2024071026-squirt-trustful-5845@gregkh>
 <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071053-mahogany-cavalier-6692@gregkh>
 <MW4PR18MB524491EEA2A628469595FE47A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071012-backpedal-punctured-5d7b@gregkh>
 <SJ0PR18MB52467C544972534F6DECDC48A6A62@SJ0PR18MB5246.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB52467C544972534F6DECDC48A6A62@SJ0PR18MB5246.namprd18.prod.outlook.com>

On Fri, Jul 12, 2024 at 08:44:22AM +0000, Vamsi Krishna Attunuru wrote:
> 
> >> >> >>
> >> >> >> +config MARVELL_CN10K_DPI
> >> >> >> +	tristate "Octeon CN10K DPI driver"
> >> >> >> +	depends on ARM64 && PCI
> >> >> >
> >> >> >Why does ARM64 matter here?  I don't see any dependency required
> >of it.
> >> >> >
> >> >> Thanks, Greg, for your time. This DPI device is an on-chip PCIe
> >> >> device and only present on Marvell's CN10K platforms(which are
> >> >> 64-bit ARM SoC
> >> >processors), so added those dependency.
> >> >
> >> >Then perhaps keep the ARM64 and add a COMPILE_TEST option as well so
> >> >that we can build this as part of normal testing?
> >> >
> >> >So that would be:
> >> >	depends on PCI && (ARM64 || COMPILE_TEST) right?
> >> >
> >> Yes, it makes sense to add. Can I send this fix as next version now so
> >> that it will show up in next release, please suggest.
> >
> >Send it as a follow-on patch on top of my tree, doing what Arnd suggested.
> 
> Hi Greg, I submitted the follow-on patch on top of your char-misc-testing.
> Please let me know if there is any additional action required on my part.

Just now applied, this crossed in the email ether.

greg k-h

