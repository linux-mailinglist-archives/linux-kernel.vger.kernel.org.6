Return-Path: <linux-kernel+bounces-400856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4313E9C1341
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F2FB21CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C4440C;
	Fri,  8 Nov 2024 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FQnlI17G"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3E1FDD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026307; cv=none; b=D/675/Tmj9zqtIaTQQPuL0eg8oNXOsfsIMD8MT/rq27Xg0YJxMfoSHa0unycPrllzHWgpjiCpja5bapAvJVYVAMGdtNwJRE8fr4VRDgGI0vdzpz1j3wHw6aHwPj1HHSqeHrTJZKXq2nt0+QNmy2nSXAQe7DMgw3sEhO7brutDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026307; c=relaxed/simple;
	bh=4n7khrBuMUtQBYvCABf9ZpMqgcGzS/P9GFvR2WXFNcU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CM7MekdpQ1SR+DB2rSiA6yiosEz8iozB4jvDnvYgTWpq5ck5HKfba7R3jnOvDW4jqJ6xd8Tb1Zyl1g9ox/TkGLbvFiICwgdNlgnlaDevAsDI7TM6xqCWS4snKE9294m8LLgT2Q30J6VvpXbij6DnPJqPvaDjqko3ObK2CdrQZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FQnlI17G; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([92.33.209.142])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A80bux11371923
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 7 Nov 2024 16:37:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A80bux11371923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731026279;
	bh=AIgENd9MH02dSondeIPZ91aDzNiaV51cCAN68ptAAPU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FQnlI17GxNduYpAt7tZ4xcCW3aRGzlga6LmSeNwjqa+qU+yp2FR8Eea1MXqbziCCj
	 lLRzUPdbOIRnVrAyZ/rI5FbkQ/TiuWwcgOpMogbzpnKEpB8ZYVF+wH1kYTdmkSO4NR
	 Dq9RxF/L7PLyoBuY/JWhpgrWKgy2/B8kkePINb4NPIwDuJnblmJJkuYqo/8U7AZ7EA
	 ibDGEiPBUx10jUO8zOgAdGgByKSOxosp+QS35Ta4JF01NN2yYQjo5ASCixNJ1E3DSQ
	 gP0+WZUQaOeTH7ejeae7Wbax7lMz6Khga6W5xdwJjyv/tdHWZF5fQupjKBusD/4oSv
	 ACO/Jz7w1ambA==
Date: Fri, 08 Nov 2024 01:37:50 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <5a42aca9-ff38-4fb5-8eb2-a43262c8c630@intel.com>
References: <20241107233000.2742619-1-sohil.mehta@intel.com> <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com> <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com> <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com> <5a42aca9-ff38-4fb5-8eb2-a43262c8c630@intel.com>
Message-ID: <3732DC33-8959-494F-9A47-2ADD74C7E2DC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 1:35:59 AM GMT+01:00, Sohil Mehta <sohil=2Emehta@intel=
=2Ecom> wrote:
>On 11/7/2024 3:49 PM, H=2E Peter Anvin wrote:
>>>> -	if (c->x86 =3D=3D 6)
>>>> -		set_cpu_cap(c, X86_FEATURE_P3);
>>>
>>=20
>> Be careful - these bits are used in module strings and so modutils need=
 to understand them=2E
>
>Sorry, I didn't understand this properly=2E How do I figure out whether
>these bits are used elsewhere? Can you please provide a pointer?
>
>Sohil

Look at the modutils sources=2E

