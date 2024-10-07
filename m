Return-Path: <linux-kernel+bounces-353269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CF992B64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FCD1C21E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA521D2F7E;
	Mon,  7 Oct 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XvgCYL3R"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017251D27B7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303440; cv=none; b=kHseC9120OJb3gMlovrY889i2Ae94p6MfSA7/NICPU0m/V7Xr4bOz2hIDvolheNWOlRKa0+WMeMowBN+rPZqFnRKEaooQx1GjQgCebgCEXc0qhr9SqhwNPfi0e+AZ/pt8AErvwms6gd/bVm6ImfcSeHOyyPtjyZzME606TZNyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303440; c=relaxed/simple;
	bh=behdNi8kaJJyMy790G2l7NT1ImzLJ4u8kTBVDXq7nZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCj27MRM/c9vYDjNeT+i8e1tlotiYRgKWJSw6GMPu6oj23Q/67LFwGgXMhWsm+vAkrfJAWHSsEcQQ4WYf0UFbaGl+GnuYMwtoFwVW43q//5iGHPquG5POUhsy7wOPAaUsQ6N8OEdE5PEFx8F2O7lwdizHPRPe4453nYZfWRVXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XvgCYL3R; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b1GIVNxvx5+F1w8uwFX+BMCBEvmeEUB2jrfqPiIRgmE=; b=XvgCYL3RuKZgyPLXt5ZWSTtREd
	IGUeTq7T8ekDDV09zJb8Qn2Qqt3G5QRycXl73nk49IWLIrosEi8HwO7B6yJOD58rQnaF/TgytmZDN
	fji2JIW7V3Ahzwdo1r2DObuNuB5ajyY7i4zFPhdo7o3vyRbWcqzkscrqVBlymR6wylV0EqVfimV90
	NyX+i+lue8XTMrVq+yhn3X+9ddLVhUfBTglWSgDOmjma7aIwhQheguZKx8ABPWFYfqQ7MuQ//gavA
	6MA3yOJ+U4zTLLAfTP6QJVK0nsqwf222Ffck6Uu19lWqasZTmhxGVZNTwoG3XEbqnnX04fy+nLSfL
	J1F4SWVw==;
Received: from [167.98.27.226] (helo=[10.35.6.109])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1sxmfe-00AAdC-5o; Mon, 07 Oct 2024 13:17:02 +0100
Message-ID: <37cfd941-f51d-44d8-8283-389ea8d53e69@codethink.co.uk>
Date: Mon, 7 Oct 2024 13:17:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 06/10/2024 11:44, Vladimir Kondratiev wrote:
>> I'm wondering how distro kernels will deal with that since some
>> platforms will need the ZONE_DMA32 and some others will break when
>> enabled as you have shown.
> 
> I agree platforms with no ZONE_DMA32 is non-portable,
> to address this I will add dependency on NONPORTABLE and re-submit
> shortly. Thanks for pointing that.

So the last time I got to looking at this, the SoC had no memory
in the 32bit space and all the on-chip IP blocks where all 64bit
DMA capable.

The only thing we didn't sort out was anything connected by the DW
PCIe core, but we think that could use an inbound  translation window.

However, software wise we didn't have the time to try and either
hack something into the kernel or write some form of IOMMU for the 
inbound translation unit. We just removed the warnings to get the
initial testing through.

>> Is there a way to make it optional at runtime instead?
> Unfortunately no, or at least I see no way to do so
> 
> Thanks, Vladimir
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

