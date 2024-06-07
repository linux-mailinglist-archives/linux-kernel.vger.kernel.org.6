Return-Path: <linux-kernel+bounces-206732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850CF900D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F661F2654F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608BE153BC3;
	Fri,  7 Jun 2024 20:42:50 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AE18C3B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792970; cv=none; b=OJdVayP+V2lM4wt9dQPPNjWdv428Js/ngFC1t4t1sUui8wO73gDdEBm5Zp36yz+JtctDohhJ9XuQ1rJD4FFvqlrDcM4GlIV+0Ehi7ma+ytJtFlIcyvcm3qYmyCpnilwdtph5z3JtLoVBPs1Qc/AQeSis20MFj0ceY2S9N0L/oZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792970; c=relaxed/simple;
	bh=rKwNsYkcH32FE5tPOVCFY2WYufIOJl0S8l3yEoiAcJs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URyUrrhItOT7juQ6AAcMcmxlLmfh4uf3RKVhWrQJQnkrUTROjnOIUaqk+qQKWKMQVPWPy/DuRy2tA3idV3D1G2QQ2zmPiw2uvNHV8DXD4ZaFmEAApbTm0ORdjUUplAuFB+WBUsc18cj8BLA8odLz5IvVhUREf0enpABsCndVm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 7b043260-250e-11ef-ab0a-005056bdd08f;
	Fri, 07 Jun 2024 23:42:39 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Jun 2024 23:42:38 +0300
To: =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge <Jorge.SanjuanGarcia@duagon.com>
Cc: "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jth@kernel.org" <jth@kernel.org>,
	=?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier <josejavier.rodriguez@duagon.com>
Subject: Re: [PATCH RESEND] mcb: mcb-pci: detect IO mapped devices before
 requesting resources
Message-ID: <ZmNwvsngNZhEGNfv@surfacebook.localdomain>
References: <20240523103430.423340-1-jorge.sanjuangarcia@duagon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523103430.423340-1-jorge.sanjuangarcia@duagon.com>

Thu, May 23, 2024 at 10:35:03AM +0000, Sanjuán García, Jorge kirjoitti:
> If the memory region is requested with devm_request_mem_region()
> for an IO mapped device it will return an error and mcb-pci will
> incorrectly report it with EBUSY code.
> 
> Make sure we identify if the reosure is IO mapped and fail early
> with a correct ENOTSUPP code.

No, ENOTSUPP is incorrect code in this case. Have you run checkpatch?
Please, submit a patch to change this error code to one from the POSIX range.

-- 
With Best Regards,
Andy Shevchenko



