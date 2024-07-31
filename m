Return-Path: <linux-kernel+bounces-268739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D6942890
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABB51C2295F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9E1A7F69;
	Wed, 31 Jul 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lGc4/kKJ"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0454757
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412897; cv=none; b=LSzEC5GvOx3gTwsQ6YyFV3excDbrXohh/ircqPFEu5OsuakPP3jUnQcp8kPEZv5jzhBHEfl3kgYeQV15e1Pp/UKZHbp6+Xe3CWj5nqG6ymIzcgridVnYUjAg87BTYMPBVivfgK3krCA2UNmc9tQ/p5KXzFBw3LoxwQa1nORQ/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412897; c=relaxed/simple;
	bh=cSTSZT/kH157fpoPsCGRgiokeVXODoXfumPWJ2zc1JY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=TBf7tPa9L//nR/ZD99WBbXor0ekjiHoF8x8hxrszbnDvwnS6u5EMOxsnPZW2jkCvpnfgTGuOximsF8pLYOJXNGfuE3JBmwzxeETV/Y6cPacc+bMfxAqiHJn2IpxZH46wvXRiK8C1A+ezTFuL2z9as2cHrelMIkQ2H2uOtH0BBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lGc4/kKJ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240731080132epoutp036751a484336e3e817cd81b7b1b343e0b~nPWZ9j9o50598305983epoutp039
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:01:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240731080132epoutp036751a484336e3e817cd81b7b1b343e0b~nPWZ9j9o50598305983epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722412892;
	bh=eyiRbQBggQ5UA3DxveNReqJ4PBECIWEtyM45wz6b49w=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lGc4/kKJqXEq978v5mBXfwoIJF6lmrxHBZacpv+lWWrJyuFG8J9/pnWrQdHLsK1A+
	 9fY8DfICE/Qwvsw15dw8gb5jzPj511xkFAQnUqhbwka5ItkuM4Ac0pEPVX5gcaglOd
	 P+DVIo2nqAFBEFcOZ4U+5HMj0zVUxBviOcvyEM/g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240731080132epcas1p36f3be940e0e0f9ef510e371849da58e2~nPWZ3KGRY2372423724epcas1p3I;
	Wed, 31 Jul 2024 08:01:32 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.243]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WYl0r0mNPz4x9Pq; Wed, 31 Jul
	2024 08:01:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.31.09725.35FE9A66; Wed, 31 Jul 2024 17:01:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240731080123epcas1p24e4a27e6c8d958a7e1ed1893c2ad67b7~nPWRPexV_3171231712epcas1p2s;
	Wed, 31 Jul 2024 08:01:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731080123epsmtrp238b46f436023577450be0dabd5d8725d~nPWROu0Zd1961819618epsmtrp2g;
	Wed, 31 Jul 2024 08:01:23 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff700000025fd-0e-66a9ef53bcb7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.32.08456.35FE9A66; Wed, 31 Jul 2024 17:01:23 +0900 (KST)
Received: from manjaecho04 (unknown [10.89.15.251]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240731080123epsmtip187b1a235fe05c76c71c1c3ddb0a70503~nPWREgpxT2680926809epsmtip1y;
	Wed, 31 Jul 2024 08:01:23 +0000 (GMT)
From: "Manjae Cho" <manjae.cho@samsung.com>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
In-Reply-To: <2024073112-securely-usage-0d8e@gregkh>
Subject: RE: [PATCH] Improve MAR register definition and usage for rtl8723
Date: Wed, 31 Jul 2024 17:01:23 +0900
Message-ID: <001101dae31f$d5ef44d0$81cdce70$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIO4y/bC0DcafDS3Wluz7dnMpOAvgGFAy1LAsCGdEsCiCp1ZAHAn5XEsWQGCDA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmgW7w+5VpBgsW6Fk0L17PZnF51xw2
	iyOfUx2YPfbPXcPu8WLzTEaPz5vkApijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgPYoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrM
	CvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzvqycwlqwV77izpnLLA2MNyW6GDk5JARMJF6fP8fW
	xcjFISSwg1Hi98n1zBDOJ0aJo3dOMkE43xglfq78wQrTsvDvaaiWvYwSbYe/QLW8YJSY8mAf
	E0gVm4C2xP5tL5hBbBEBHYmOMydYQGxmAWeJtV2L2UFsTqBJD3deBrOFBbwkJl9aBjSVg4NF
	QFViz7U0kDCvgKVE8/JVrBC2oMTJmU+gxshLbH87hxniIAWJn0+XsUKs8pNY8+MnM0SNiMTs
	zjaw2yQE3rJLbH60C+oDF4lbVxczQdjCEq+Ob2GHsKUkPr/bywZhF0ss/bOJBcKukXjaOgPK
	Npb4ee4TM8idzAKaEut36UPs4pN497WHFSQsIcAr0dEmBFGtInF+1QYmiLCURMNBQ4iwh8SJ
	zn9MExgVZyF5bBaSx2YheWAWwq4FjCyrGMVSC4pz01OLDQuM4XGdnJ+7iRGcArXMdzBOe/tB
	7xAjEwfjIUYJDmYlEV6hkyvThHhTEiurUovy44tKc1KLDzGaAkN6IrOUaHI+MAnnlcQbmlga
	mJgZmVgYWxqbKYnznrlSliokkJ5YkpqdmlqQWgTTx8TBKdXAlLXpZubS97uO6s7Yuy5Baf5q
	+arYQ3elw/yvfDuV5RdQMvtDtDOvW/oRRpNJDC8ZHx0wC0pZ4Hx1/YuSf58uxN3btC2kJzfP
	4v5tq69L6t9YOb23z15z2njiObHDR5n/Z9pOvMq9furPfLc/e2TVG/zf3H6aeGfa4Qy2mTwr
	H39+xLXzsFZdgrv7Hest7+6XPz77bf/Xj5Hhk7yiXYuKWeOedmrlx77+KFTBFPhidTHnA8YZ
	tx4vurCj8FLLImWdBY533v3doRkzRXrTae32hkUvAx/vzNnF0Phn35vuih8b/e6VrHo1f4X+
	OYkHsT80D+2V6jGuLT5VFexhIrynoa3KWeVm3fZ8EdeDQSyvvuUqsRRnJBpqMRcVJwIAec21
	DwoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnG7w+5VpBgu/SVo0L17PZnF51xw2
	iyOfUx2YPfbPXcPu8WLzTEaPz5vkApijuGxSUnMyy1KL9O0SuDK+rJzCWrBXvuLOmcssDYw3
	JboYOTkkBEwkFv49zdbFyMUhJLCbUeLC1FdsEAkpifttTcxdjBxAtrDE4cPFEDXPGCUar19j
	B6lhE9CW2L/tBTOILSKgI9Fx5gQLiM0s4CqxefpqJoiGXiaJPVvPgA3lBNr2cOdlsGZhAS+J
	yZeWsYEsYBFQldhzLQ0kzCtgKdG8fBUrhC0ocXLmExaQEmYBPYm2jYwQ4+Ultr+dwwxxpoLE
	z6fLWCFO8JNY8+MnM0SNiMTszjbmCYzCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCU
	l1quV5yYW1yal66XnJ+7iREcC1paOxj3rPqgd4iRiYPxEKMEB7OSCK/QyZVpQrwpiZVVqUX5
	8UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTAl9ZpnyQmout2tr3g6J2Xi
	GTNXx9Nzzn7sPM5cJ751t6RjasQXxl2HZ3o6Wqzcy69/YeVi55hHuzQ1HB7f5uVKC41+r3Yh
	PGzFjE8xsSEqU275rF5lMiti+wEx/6Xnn/xI3R65Okx5U4TKBQXmKuk5l/4ds8v33jL9+JpH
	JZbnAl9+vfTL8r6KlfyMzPz4GuMp2psjRM1sUv53vyr85rDUi2/Sp5cbN9j8vXd1J/vEnfq+
	brGSawze5zFVXZ1QqyXQoDhfwtjnCXNYSffW3ryiyYLCAg6yzKF3up/MjLSZl/FzwYIXb9qC
	95y/P/fXzN8PedN/XI3Q3bL90GeOeQvcODedPrOb9WdmZuE7g9q9SizFGYmGWsxFxYkAUoff
	5/QCAAA=
X-CMS-MailID: 20240731080123epcas1p24e4a27e6c8d958a7e1ed1893c2ad67b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19
References: <CGME20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19@epcas1p4.samsung.com>
	<20240730155054.411059-1-manjae.cho@samsung.com>
	<2024073109-abridge-yapping-3db3@gregkh>
	<000001dae316$92e619b0$b8b24d10$@samsung.com>
	<2024073112-securely-usage-0d8e@gregkh>

> On Wed, Jul 31, 2024 at 03:55:05PM +0900, Manjae Cho wrote:
> > > On Wed, Jul 31, 2024 at 12:50:54AM +0900, Manjae Cho wrote:
> > > > This patch improves the usage of the MAR register by updating the
> > > > relevant macro definitions and ensuring consistent usage across
> > > > the codebase.
> > > >
> > > > Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> > > >
> > > > ---
> > > >  drivers/staging/rtl8723bs/hal/sdio_halinit.c    | 4 ++--
> > > >  drivers/staging/rtl8723bs/include/hal_com_reg.h | 3 +++
> > > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > > b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > > index c9cd6578f7f8..9493562c1619 100644
> > > > --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > > +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > > @@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter
> > > *padapter)
> > > >  	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
> > > >
> > > >  	/*  Accept all multicast address */
> > > > -	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
> > > > -	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
> > > > +	rtw_write32(padapter, MAR0, 0xFFFFFFFF);
> > > > +	rtw_write32(padapter, MAR4, 0xFFFFFFFF);
> > > >
> > > >  	/*  Accept all data frames */
> > > >  	value16 = 0xFFFF;
> > > > diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > > b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > > index 9a02ae69d7a4..baf326d53a46 100644
> > > > --- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > > +++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > > @@ -151,6 +151,9 @@
> > > >  #define REG_BSSID
0x0618
> > > >  #define REG_MAR
> > 0x0620
> > > >
> > > > +#define MAR0						REG_MAR
> > > 	/* Multicast Address Register, Offset 0x0620-0x0623 */
> > >
> > > Why redefine this value again?  What is wrong with using it as
> "REG_MAR"?
> > > Is this fixing anything or making anything more consistent somewhere?
> > > It's only used in one place that I can see.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Dear Greg,
> >
> > Thank you for your feedback. I appreciate your point about the current
> > usage of REG_MAR. While it's true that it's only used in one place
> > currently, I believe there's value in making this change for the
> following reasons:
> >
> >  - Consistency: Other similar registers in the codebase use this
pattern.
> > For example, we have IDR0 and IDR4 for MACID registers. Adding MAR0
> > and MAR4 brings consistency to our register naming convention.
> >
> >  - Clarity: The +4 offset in "REG_MAR + 4" isn't immediately clear
> > without context. MAR4 makes it explicit that we're dealing with the
> > next 4 bytes of the Multicast Address Register.
> >
> >  - If we need to use these registers elsewhere in the future, having
> > clear, specific names will make the code more readable.
> 
> You aren't going to use them elsewhere, worry about this then, not now.
> 
> > However, I understand if you feel this change doesn't provide enough
> > benefit to justify inclusion. If you prefer, I could modify the patch
> > to keep the REG_MAR usage but add comments for clarity:
> >
> >     /* Multicast Address Register */
> >     rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);     /* Offset 0x0620-
> 0x0623
> > */
> >     rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF); /* Offset
> > 0x0624-0x0627 */
> 
> That seems a lot more sane and simpler.
> 
> thanks,
> 
> greg k-h

Dear Greg,

Thank you for your guidance. I appreciate your perspective on keeping the
code simple and addressing current needs rather than potential future uses.

I agree that adding comments for clarity is a more straightforward approach.
I'll revise the patch accordingly

I'll submit this updated patch shortly. Thank you again for your time and
feedback.

Thank you
Best Regards

Manjae Cho




