Return-Path: <linux-kernel+bounces-323037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245799736D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DED21F27A60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3363118E77F;
	Tue, 10 Sep 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mVkGBIdI"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B613E02D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970106; cv=none; b=u0ub4ubUfc5VeMmeD8DWtwyHuljJAzdeH3Fls33TiLvymgrrHd3QTaGI8D56CFUfmJ3r5afIsBYPyF+BBFpUiibBNKhVQnisgPgX0sfH6EjOq+x3eGFpXcYmpegkIAynONO/dCQXG/mTbJS4/JK0+zMJNxcdJNPMVr898OK9weI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970106; c=relaxed/simple;
	bh=t+WeGmpmfUC1iHYFNyU4I8lqZvOG7A4ZbvY10Nw7F2I=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=G3wPEH19O+eIH+nrtNJCYqeXBU/klWrv70t4YSHNMsj1mKY1Czknut+wsX4lG308pEfaXAfTkOi8IJx8vpJYcfWHJCHpEwxv7QKQMjplN8DipP/mn0UDY4lWFX2ZvW1zm3QQ0KZV46MsF5nUxdEisUuUZHcqg9C3Jx/kfJSKwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mVkGBIdI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240910120820euoutp01b725d0ce3a39eb993ddce9042b8da2af~z4Kl-nibf1654916549euoutp01m
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:08:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240910120820euoutp01b725d0ce3a39eb993ddce9042b8da2af~z4Kl-nibf1654916549euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725970100;
	bh=pyaoVhs/4U8W+zYxoeTwH0/3CWGjP6XdFRI7IuTH0BA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mVkGBIdIA4XmiYVRcTWRrJ4CwuHb6TdDks52CX9LQI52BlfP8dJcGLXadqT7Xc23F
	 QA+WvjO9t+Y6k4j1tLZavJgZlNAgtKoMBjrozSUuH32CE8QkGyGMVB/uVLUY5crbzP
	 Su29FWCcAnZZY7IT5JL2jhuF8EZDjpOVviG8Qkkw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240910120820eucas1p1cb22099eb498d527babe17b21ec6b775~z4Kl1F8kn2580925809eucas1p1t;
	Tue, 10 Sep 2024 12:08:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 75.8C.09624.4B630E66; Tue, 10
	Sep 2024 13:08:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240910120820eucas1p2f477a72fc9b02e7038487cea82b8fc28~z4KlVpASb0745507455eucas1p2i;
	Tue, 10 Sep 2024 12:08:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240910120820eusmtrp1fa13b8608e9d68d9ed02d386fb4fd2bc~z4KlVAXwv0384103841eusmtrp1Y;
	Tue, 10 Sep 2024 12:08:20 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-1f-66e036b4f6f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.38.19096.3B630E66; Tue, 10
	Sep 2024 13:08:19 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910120819eusmtip2fd65d761c5c2b01054fd8e8d4c632ef2~z4KlHadKc2614426144eusmtip2M;
	Tue, 10 Sep 2024 12:08:19 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 10 Sep 2024 13:08:19 +0100
Date: Tue, 10 Sep 2024 13:52:31 +0200
From: Joel Granados <j.granados@samsung.com>
To: Wen Yang <wen.yang@linux.dev>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3] sysctl: simplify the min/max boundary check
Message-ID: <20240910115231.xnjgwyiwfvdvqgud@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905134818.4104-1-wen.yang@linux.dev>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7pbzB6kGZyeJmfx+vAnRouGiQ0s
	Fv+3tbBbnOnOtbi8aw6bxY0JTxkt3q+5z+rA7jG74SKLx6ZVnWweCxumMnu833eVzePzJjmP
	KYfaWQLYorhsUlJzMstSi/TtErgyPj5TL7jMWfH+6U3WBsZ+ji5GTg4JAROJIxNfsnUxcnEI
	CaxglLh+9jGU84VRovPNAxaQKiGBz4wSRy8KwHScPHqPFaJoOaPEyyczoDqAit5cvgflbGaU
	ePH1E3MXIwcHi4CqxLklFSDdbAI6Euff3GEGsUUEFCXm7l3EBFLPLPCcUeLtto2MIPXCAl4S
	B79XgdTwCjhIdK89xAxhC0qcnPkE7CJmoDkLdn9iAylnFpCWWP4P7B1OAXOJ9T0fmSAOVZT4
	uvgeC4RdK3Fqyy2wVRICLzgk7i36AlXkInHi21qoImGJV8e3sEPYMhKnJ/ewQDRMZpTY/+8D
	O4SzmlFiWeNXqG5riZYrT6A6HCWu9RxmB7lIQoBP4sZbQYhD+SQmbZvODBHmlehoE4KoVpNY
	fe8NywRG5VlIXpuF5LVZCK8tYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhyTv87
	/mkH49xXH/UOMTJxMB5ilOBgVhLh7be7lybEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVI
	ID2xJDU7NbUgtQgmy8TBKdXAZJ1t/JK7Y28i+4XP/1bb3FO3ulx34IzdnpO3u2YlTurj3NDw
	8Lz+ZoGXM7/brf9gUjhhSVCPRufuDYxPbYUilP55/3jdUPNE8PSl9ZHbHA/f/Vt4al7SOY0c
	tQenPCVffDVKLBTi7piw4UJLhq/eGg+x2EkW9mE9x78stRIq6XaIWzR1rn6/BcPjTUwv5Eur
	rzQXGWYZ7vs6+YXe1KMCZoyFd7I8/VvlBHzdI08on99+h81jS4pLcIf6EfN0ltvzDkXzLvDQ
	95TP2szeIjGzo3JRyxrFxvhz4eeciizO8c6/zf6vRGqZMY/40pmite1xMifXfS7qX/Ug+W38
	A3FD1iAe7Q5JBQ7/41+ONdxWYinOSDTUYi4qTgQAyXoGCagDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xe7qbzR6kGXx4ZGPx+vAnRouGiQ0s
	Fv+3tbBbnOnOtbi8aw6bxY0JTxkt3q+5z+rA7jG74SKLx6ZVnWweCxumMnu833eVzePzJjmP
	KYfaWQLYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
	EvQyPj5TL7jMWfH+6U3WBsZ+ji5GTg4JAROJk0fvsXYxcnEICSxllPi4vpUZIiEjsfHLVVYI
	W1jiz7UuNoiij4wSDd3vmSGczUDO670sXYwcHCwCqhLnllSANLAJ6Eicf3MHbJCIgKLE3L2L
	mEDqmQWeM0q83baREaReWMBL4uD3KpAaXgEHie61h6BmdjFKfNq5iBkiIShxcuYTFhCbGWjo
	gt2f2EB6mQWkJZb/A/uAU8BcYn3PRyaIQxUlvi6+xwJh10p8/vuMcQKj8Cwkk2YhmTQLYdIC
	RuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZG37djPLTsYV776qHeIkYmD8RCjBAezkghv
	v929NCHelMTKqtSi/Pii0pzU4kOMpsCQmMgsJZqcD4z9vJJ4QzMDU0MTM0sDU0szYyVxXrYr
	59OEBNITS1KzU1MLUotg+pg4OKUamHRz3hUdu7Jkh6nl3SMLa2PC9vfutZ8tUs1YvfNjzpyk
	tDpZvbggMdWkjVycbhYcqZurhbbL/n/ZsrX8SN2Zei0+k3lmwTw7bp6tsbM5qcdWwrA3nSVq
	0n77jUFXFnbnHC/8/+vMhDfChtu2NJ+3i7z01eOev0yHI8OpObNf3nh//Z3YmshXx+YpnHCp
	sNzz9e+1vsVLdrcw/FqWpCDl4xn9eU2WxoQZAgoMfJrvXxabnd1ltKJ3u0hXzJHimPMidUtE
	2aRmsO7Yx5zBGlHZlMpnwfT4+Vs2DtNfO1rO69WuOlF13vclO//6nWW/Ned+/CVe4FE6odhx
	1+m5XJZsEUI36w5oHXHeFdnqqmKZr8RSnJFoqMVcVJwIAOaQTVpFAwAA
X-CMS-MailID: 20240910120820eucas1p2f477a72fc9b02e7038487cea82b8fc28
X-Msg-Generator: CA
X-RootMTR: 20240905134850eucas1p1bf3a6a630f795a6a708db302afa1a3ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240905134850eucas1p1bf3a6a630f795a6a708db302afa1a3ee
References: <CGME20240905134850eucas1p1bf3a6a630f795a6a708db302afa1a3ee@eucas1p1.samsung.com>
	<20240905134818.4104-1-wen.yang@linux.dev>

On Thu, Sep 05, 2024 at 09:48:18PM +0800, Wen Yang wrote:
> The do_proc_dointvec_minmax_conv_param structure provides the minimum and
> maximum values for doing range checking for the proc_dointvec_minmax()
> handler, while the do_proc_douintvec_minmax_conv_param structure also
> provides these min/max values for doing range checking for the
> proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.
> 
> To avoid duplicate code, a new proc_minmax_conv_param structure has been
> introduced to replace both do_proc_dointvec_minmax_conv_param and
> do_proc_douintvec_minmax_conv_param mentioned above.
> 
> This also prepares for the removal of sysctl_vals and sysctl_long_vals.
> 
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-kernel@vger.kernel.org
Thx for the remind. Its a bit to late to include this for 6.12. Will put it in
sysctl-testing setting it up for 6.13 (or whatever the next version will be).

Best

-- 

Joel Granados

