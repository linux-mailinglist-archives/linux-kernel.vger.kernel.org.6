Return-Path: <linux-kernel+bounces-281392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83F94D666
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13201C21A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980214B96C;
	Fri,  9 Aug 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="grUHYDTd"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED332F41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228792; cv=none; b=d4jval5h5NISNBWQm0KiXpjNRcjFVW7dcMWqUFC/K1nRscDzcgzG/u4hpvGXDulQ1AosASDY0Ptnn2oMxRqA0CEJUt9A91zfCjGP5F52Aie9mFtbS21tZPJ/aTLQ+3guZBVahscAabiDkQlF6dYen/dDrwgN8C3cIzMWbDNaWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228792; c=relaxed/simple;
	bh=gcCVPAbo1n/pJKPDXPuBaSVUEHJEs8Ta7McoBWUfgFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7NH9rkBw8u33PdFfHK5Fyvu/Q8t6wQ20K426BJZO+J/d+miSmYDTr1zPJ3f7HGq9WeKxeLrYuL+J45plOyJMvb9g12i+5tNkm8aSIp4zBIYXlbuN2X9a1TeQbCoGHHIAkfNJPMKIunccxkGJkwJabzlf/2zsUc7R+4gMv0kfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=grUHYDTd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4565E0002;
	Fri,  9 Aug 2024 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723228782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q5afJNAYFs7MIsWDfSymukcg4XFnkrqTZxpLlWq/n4=;
	b=grUHYDTd9AUhIzOjQHZQ3TS9VJ3LbqKVd2KPyrVbVBsLPRbvXMMPX3nHxKYiyCmtVFP24r
	vJ8Qa3enR0KGGzZe+uYwpwiRUUqW3GlMQtdxbPePkNrHYuEu3lHzotNaJtzuL++sGxBPdH
	4NS/crMOEUVUALM0qdbLc2kh0Bk96XzEsUKDFJHmU8c/FCf1Mz2xzZ5p7Wcc9ZsqvxsR/D
	LRgwCSg6290Yzhc2zudGGfZYeqY57g/7V3L8fhXWcVf6Yc6/EaTHJHfQJPlfngBFQyaym2
	fKoPes0mNMtLLNKM9j+34kl9+q1hbygWl0VZ1dxfjwVqmz9iwibIP4JE+q9dqg==
Date: Fri, 9 Aug 2024 20:39:40 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RESEND v3 1/6] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to
 the I3C Support List
Message-ID: <20240809183940461e3838@mail.local>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
 <e94efd42-bc3f-4003-8ad8-2da6500f0f13@linux.intel.com>
 <ZrYlNOjFQE9dHsVV@smile.fi.intel.com>
 <c6ef0253-9f32-46d6-a658-295e39c926b2@amd.com>
 <ZrY8UOIsud8-NM_F@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrY8UOIsud8-NM_F@smile.fi.intel.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 09/08/2024 18:57:04+0300, Andy Shevchenko wrote:
> > Please refer to the MIPI HCI I3C DisCo specification
> > (https://members.mipi.org/wg/All-Members/document/previewpdf/89465)
> > section 5.4. The ASL looks the same in case of AMD.
> > 
> > MSFT says that they want to use MIPI0100 as mentioned in the
> > specification.
> 
> MIPI doesn't know how to assign the ACPI ID correctly. But again, what I put in
> the above is the correct way of approaching.
> 
> > What would you advise?
> 
> Since my intuition and experience tells me that the two devices even based on
> the same IP are not the same (see word 'quirk' or '.driver_data' or alike in
> the kernel sources) the generic ID may not be used for the specific vendor
> unless it's _the only_ vendor for the certain IP.

Just to be clear, the HCI defines the register interface to the IP but
not the IP itself, this is just like the various USB and SD HCIs. So we
will definitively see quirks as implementers will interpret the
interface differently (and so I agree with everything that was said ;) )

> 
> So, please do as I suggested above. And file a error report (and correction
> proposal) to the MIPI, so in "5.1 I3C Host Controller ACPI Hardware ID (_HID)"
> they should use _CID instead of _HID and add some text like
> "Each vendor should dedicate it's own _HID for the platform in question. The
> same _HID as _CID may be used if and only if vendor guarantees that there 100%
> compatibility with MIPI as described in this and other related documents."
> 
> I.o.w. do you 100% guarantee that MIPI HCI I3C DisCo covers all necessary
> properties that you need for _your_ hardware? If not, use my approach, if yes,
> use the same _HID *and* _CID.
> 
> Microsoft should know this as well and much better than MIPI.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

