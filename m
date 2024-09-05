Return-Path: <linux-kernel+bounces-317558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE58C96DFED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDF28EABD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC93D1A01DD;
	Thu,  5 Sep 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cd65cSWt"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DA1A01C9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554211; cv=none; b=TdAKwNDF5DXFwlmBSGkxNyNdJu3b2+11O+MvzO9QKrLDfXiYI2m40Bh9N2+/AFSlPNuM/QFEfQ0ZEUJyessuDCGm1g9HAjsG7l/AtTHzafMu6xbsWjy4TNmr972aLIkNy0F7plEZ7Sufa/CFqf6AWftbHnKhuSViL3Ywt2N4qN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554211; c=relaxed/simple;
	bh=/uIdgTP9I/UbggGRruZryQ3OJdDdZAUyxdzLzcEeZjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTtMESXBwJ/9DWTrDkwVjadaz0kyk/oDHit+hId1yYY+H/oSWmxbJwJW6PScBXUtg3objliwaDjOfrSguOZPmFu2o5rpBulcehUp1HyxoNEvqH6/hCHzurLW+atrI+NZ+BWd6Zx8q6nghiOWmGq4eTEcDPYnYsc5OXVETw4mqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cd65cSWt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 336DF20012;
	Thu,  5 Sep 2024 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725554206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZPWg81TQVepbnRrJjZUDDDTRgMUgeM9ZeCBY0ZWpPk=;
	b=Cd65cSWtqy37uBkfY8G0npUNOL4FRm2rt7lkGrRdXz+8TqEJDlLmt0mptPBzjTv0rT6ZOf
	+XyAAq2qDLpXgaPzeKi3aUN+b6v3TD7Ojj8xKC6huAQCaC/eRjRY8KCX7nFyD/yecWxgAd
	R1D5KuufA0kNt84kj1bNTwx/rcB78UKnJVu2hwnhSwVNogF5hc3sAVTY9Gmivh2Q21hAEB
	gRXlQCX0I+gLkFEbrujphI38JQlX7zX5p3uCilrHtyMKZl5KDQiuTPPymhqN8PZgJZDr5h
	SmuiEMFNicBCPw9H/MuBCa25NLtuOLmOx27ATEIZ95+OQt+KODBpu1z6v0AQDw==
Date: Thu, 5 Sep 2024 18:36:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Introduce initial AMD I3C HCI driver support
Message-ID: <172555419210.906626.5175587207944036259.b4-ty@bootlin.com>
References: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 29 Aug 2024 14:47:07 +0530, Shyam Sundar S K wrote:
> The AMD SoC includes an I3C IP block as part of the Fusion Controller Hub
> (FCH). This series introduces the initial driver support to enable the I3C
> IP block on AMD's latest processors.
> 
> Currently, the code is closely tied to dt-bindings. This initial set aims
> to decouple some of these bindings by adding the MIPI ID, allowing the
> current driver to support ACPI-enabled x86 systems.
> 
> [...]

Applied, thanks!

[1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C Support List
      https://git.kernel.org/abelloni/c/8d2e56ef83ce
[2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only after i3c hci v1.1
      https://git.kernel.org/abelloni/c/039b23609ff2
[3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
      https://git.kernel.org/abelloni/c/014089329953
[4/6] i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
      https://git.kernel.org/abelloni/c/216201b3d7df
[5/6] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
      https://git.kernel.org/abelloni/c/46d4daa517e9
[6/6] i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold
      https://git.kernel.org/abelloni/c/ced86959d28c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

