Return-Path: <linux-kernel+bounces-417272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB959D51D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B97BB27832
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABC17333A;
	Thu, 21 Nov 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGCAoz6/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC591428F3;
	Thu, 21 Nov 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210298; cv=none; b=cG/hy5QlsXPU+xpBa7UZ6zm7npbnyK61szKZdiMdkqmdqLBfnOV3nmnDi1rWTQDFW+KJjV1DYdaf02h654eTyVBnd6AKgQHKF+Mlhyb29c+I5+NyvKzT8vNx7NgGtuwVGzNnPXBvjNDn7h+KBzeOveSuzcecFaZzoKi3aygoNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210298; c=relaxed/simple;
	bh=qvnKnejMHTt5yQjnfmJSaKX0kWb1lHoEU3Q8HwZUXYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P6HU28JwWYtp0cZ3N+XIyEd2Jyhq4+aYrsVxCqHSipCsyRM/FdFLhmH4li4GZ+GkmOOa2vnJbbi9gafTJ9nlSiAi8UqHkLl8N/QD/2GgtJvkvPZNAV5NMtd6C2H8GqOVOdTgvgOhAcnuneNyvXyUKYn2yhLgNkh66LEsxL01rJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGCAoz6/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732210296; x=1763746296;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qvnKnejMHTt5yQjnfmJSaKX0kWb1lHoEU3Q8HwZUXYE=;
  b=EGCAoz6/FdZ11Q/kiRw6TucD9kDtCro7QDWnmn47D0HgFf+5bbjdh6/9
   hNs6/Z+O5OqxhscVILYi0ypVCYK3IJ3/qQhtFeLkUyH9fLig4wj28aEew
   3Dp3ZYPz3hzPq99F4YWdaPti+q3fkVVbANGgmg841g4bEZKDYJiXuiGUK
   G64eMEqEwgp+lTAqpQTYksGRFpO4cl02tN1X6zy1LmK9gqBqgR3Hr728c
   +AceIyE1iCc3rzp43RFNqWMw0+BelnWp583iGR9OR2IbLhx3gymhnH+Nv
   I/LoANYlSWs+L05siZK+drBiswnvixLeaH3KThDTnDGgmuK1b0/xQjoon
   A==;
X-CSE-ConnectionGUID: 6bAiZD+fRayhS0gpvfEPZw==
X-CSE-MsgGUID: 0+f59z67RRiYT6EMtC638Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32486067"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32486067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 09:31:36 -0800
X-CSE-ConnectionGUID: xvsWEZUFSnau9J5nV7lMhQ==
X-CSE-MsgGUID: q7YBespHRLeLcfwhh6GUbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90740290"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 09:31:35 -0800
Message-ID: <5fb45a8da68f2a694acc781b8a6ff7d4c95f423c.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: rm .*.cmd when make
 clean
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2024 09:31:35 -0800
In-Reply-To: <20241115073221.6176-1-zhujun2@cmss.chinamobile.com>
References: <20241115073221.6176-1-zhujun2@cmss.chinamobile.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 23:32 -0800, Zhu Jun wrote:
> rm .*.cmd when make clean
>=20
I don't see .cmd files by running make, how did you get those files?

I have

#ls

Build         include                  isst-config.c  isst-core-mbox.c
isst-core-tpmi.c  isst-daemon.o   isst.h
hfi-events.c  intel-speed-select       isst-config.o  isst-core-mbox.o
isst-core-tpmi.o  isst-display.c  Makefile
hfi-events.o  intel-speed-select-in.o  isst-core.c    isst-core.o    =20
isst-daemon.c     isst-display.o


Thanks,
Srinivas

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> =C2=A0tools/power/x86/intel-speed-select/Makefile | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/power/x86/intel-speed-select/Makefile
> b/tools/power/x86/intel-speed-select/Makefile
> index 7221f2f55e8b..b58185cc97d2 100644
> --- a/tools/power/x86/intel-speed-select/Makefile
> +++ b/tools/power/x86/intel-speed-select/Makefile
> @@ -47,7 +47,7 @@ $(OUTPUT)intel-speed-select: $(ISST_IN)
> =C2=A0clean:
> =C2=A0	rm -f $(ALL_PROGRAMS)
> =C2=A0	rm -rf $(OUTPUT)include/linux/isst_if.h
> -	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d'
> -delete
> +	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d'
> -delete -o -name '\.*.cmd' -delete
> =C2=A0
> =C2=A0install: $(ALL_PROGRAMS)
> =C2=A0	install -d -m 755 $(DESTDIR)$(bindir);		\


