Return-Path: <linux-kernel+bounces-264204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E4F93E02A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59401C21129
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A76218309B;
	Sat, 27 Jul 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fh7XIP5F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSOrf3vy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710F41746
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722097958; cv=fail; b=E2eHo2tTe1DqPUv4NQUb+QRDgg7dU74wFdSHhOcUYRwi2pmElcNFTXPR/zQ1/YJ5ngc+1fK5nnO9OCdZJ1bPRp+pJBOnfuKrGRTVV0Nkd57dwCkuj+aX3q9Lxpm0GBX6iT6JMCjlSN67H0cNHqNnI0y4OS1blf7aTfV3ADOWR1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722097958; c=relaxed/simple;
	bh=1K8zbDOeQG4QmBERrgYO+uCUcD8HNeHFMKLhVje6SEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8XFkqMVstAvvCION45aVsvxnvbQWi1AfOHtaEjfoKDty6mSuiA62POvT8sF6/4OEXXU8wh5Q8MqMhyeTtTwauDYUc1t7B9AkeLQ1fjPSfoJfdUKW0U0dGkMjh9mvJPPEAXXfM+K9DpLuli4WITqElIxz93yprZbz8wjo01qnoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fh7XIP5F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSOrf3vy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R6UENA013463;
	Sat, 27 Jul 2024 16:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=0mc17ldSnZ7Kxw1
	FoANDvyBLxMxlK6wAq4IBSAcLixY=; b=fh7XIP5F5jktxP/PbIDHdIqqF0zKfPF
	ix9gkui+5ZNTK785Woq6bkXNpwK37bRtmskvXxpoPtNnqbOLRHEReytWpsofALzF
	VLWChPq227Tf/cNgsAx1bOkYRROmEeX47nIhaeSyQlqFdXItBKvczMvkkHLrT5Ro
	nyr3osipJFnEV0auFoDrXEjvk8zYvLGTgQ23EQF64klbGAO00ObV2F6zid8RSdeL
	M3stc4pf3MIKRSspTKGAszaQmfuR+w8oN5rpsd60p83Jt67PF5L7KExmZ+IdhOoY
	hsPwDet4RxeYPJeVyyjN5KNMqxjbpi/Sp9rYMolKKCn92jZKdSdtSzw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8ge2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:31:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RGJC5u021152;
	Sat, 27 Jul 2024 16:31:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb6w48y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seD2Pvzmgpo/y7yQ21iFjBD7+aMZ2KajAkhXsdIa8uneYtcFHQuFOo1M02unawVTbfAoThAvcgtS3enoxaKHBWImtjX0P6vF9PLvJUgdkYNqHulEQ1UH+jt9r0nLTR9ssFHMvRZszlp4Bi/xkJw4Ns7jClNlv9lKdxtHoPRCI/MM3LZjr1XAbSEYFUg/Uy+lfxD8gtYMsWIwSMms5eiIEFOQop9K791wGmE5VHp4GI5ZlD5mK71qrDUEJjbtnrVFFmYhosVvpLwTipBkrqViAHoCU9ZpMVD5UNq2zsfIxXTrZ89sHz22c0BHP9OLr7mZtYmFhdZfbn/5DMNeYj67Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mc17ldSnZ7Kxw1FoANDvyBLxMxlK6wAq4IBSAcLixY=;
 b=kdW7ONThDcknaFz8ZVmOOQ6tZLjgPulM6xz7BfIt95cigUCbemrsnm7IGQUzGHryGtB1+WuMoK85ssCdFE2pbHKaVut1pcooDf3cNrG87zI6H3fXF31kwPtt8NeVw63VaeDjK3Aw0F6Wv54ksVqRcS4FYjmhPNUkWiNBl43bBsecEyGmRHN5dMGIFYtUwbdc246QbcQCyXkEiV/c1bnlJaRiLOgHTO8KIAdOYOoyTxoPl7TwnoUGfcPEOjKJQSab/7gRiql+Gbj/GH9Me8Xl8sUJ2OsbFsg/wFn9dJOarCtmtR74hV6n3ha0DoAo9SvzPTbgY79e/rI/zxdNzenbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mc17ldSnZ7Kxw1FoANDvyBLxMxlK6wAq4IBSAcLixY=;
 b=HSOrf3vyDe5GIE4pQ42lCGFetHaSOzT8kXAA7RbjJdjWXiwahcW1swCsVmQ4QPbsKqlrNrKXPmbBMg663Dhvm9em1ilCCUiqXecCrbGjyp0DkTnKO86K1spakzRM3qo37YNFYVKYLm4RpKlDv+vX2w/ZxiFaNBkjaak21pxYwF4=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by PH0PR10MB4453.namprd10.prod.outlook.com (2603:10b6:510:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Sat, 27 Jul
 2024 16:31:28 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%6]) with mapi id 15.20.7807.009; Sat, 27 Jul 2024
 16:31:28 +0000
Date: Sat, 27 Jul 2024 17:31:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
References: <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
 <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
 <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|PH0PR10MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbd3f97-3b72-4008-5b7c-08dcae5990ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yMV6lhknD6CAnj589qow++8JhUjoRVh9KnnHxH1KjT2C9oIQbdTpnLaS2Dp9?=
 =?us-ascii?Q?ynJ/dII3hhOkh0hlO3yNPNZ3rEK7spocGdP9Bgx/0h6TjifAoo33UW6df37m?=
 =?us-ascii?Q?xoC1keb+KHB80syM/Rij7ZhX3cZCuYhCYh4kJK420OUcKeH+obD2z+gGtxnP?=
 =?us-ascii?Q?j+Yo60uCjsG3nU4lwGw4885vOPSNgc3r+H3Y+HDmKSW1DitSpqOPQ8eXvQfJ?=
 =?us-ascii?Q?PLmrpL8NHJJzmKFYE1+vM+7CsqxNo2nr2I5vUUH27ewBvqqaOuyxUuY6XvxO?=
 =?us-ascii?Q?rkb+xOHJ/fBJrDXKFDw86Xq00c7/DpQxeBMEEpoKrp1/a3mMTJq/BlZ2Xlaa?=
 =?us-ascii?Q?A6Nnv6lyvc/TXpil1d4YUPSyVTM3GJ4Id+GXYfocldNb/nwNp94ITgYBS+W7?=
 =?us-ascii?Q?yFaG2xfzXskDY/I/caWy1jty7Ne6QyBOCTcrQ7DMGalsxgBUoQTw0fC45LhW?=
 =?us-ascii?Q?n/k0e4dl4GsTpaaqw/uWYHC62931RqVCMdqRoVMRqK9j4U/HVGmrC6LbpIY9?=
 =?us-ascii?Q?wD4fIgfY+GjNJhOxR7FxbiWY02hUdUL5gQsVyQqa6U7OXzejniLo09RMIGVF?=
 =?us-ascii?Q?tqE+TOAacPAZXCzQT+BB8Tlgip3Rn2oXhjyvlsbwZNGUUb5BmwMFQbz5tfsS?=
 =?us-ascii?Q?9NTDwceLm0sTpUu8UBcoQMzWOMd6wEABm4zO9DZ3G99X+W9spapobO9Q9hfC?=
 =?us-ascii?Q?cFpgFInMgfoUWpNmW/5nEfm49AJwWyhO4Jl/JHLv36DCQxlnDul/ak+Pz/4V?=
 =?us-ascii?Q?I+M+CF4touwaUuoYt+YYG/4W4TxDluZVL6lyjKYbR2mcKVAxoZK/ts8IEVMs?=
 =?us-ascii?Q?aq1H5HkOn7LQGXhsNn1ehKukIs82eE9CPB2C6j3/8wHwSU7/fjQA3gNIiHe3?=
 =?us-ascii?Q?nIU1JHRdea7RKzH7XD35Qr8LsMyV5vGmMUrjajx30WHwQiyajd48JC3CNnpB?=
 =?us-ascii?Q?Ff+b7oLJpHbMSDNXrUoMBiSijiZG+RONOHl6plnKCua/3ASX6EfawEfhb1Ea?=
 =?us-ascii?Q?IHZvdlJ14CzP3C9vioIs9ybJUJGdY2rVo4fLwyvGeLXHTjcv7VLJ5Ji54E0J?=
 =?us-ascii?Q?8WX5MOUmWP2ZyrcQcLYNQMyXXExyL1t/mlJqx7Cq44mU2QW0S/GX7TgICwnC?=
 =?us-ascii?Q?yjRQ+zYtMcX4aihWVMF8iAtuicXhpVNA+65divNG0phxLNcPFc364bfCj4Z8?=
 =?us-ascii?Q?wxWXxx5Ie/vRqeYONtSUDbQbqwfk17zLw1C1PrBfZyOgHJimTjuD5nME3SaG?=
 =?us-ascii?Q?L0CpZXqDjxyKUlvi6vIyUmIAvJafXgv2EszDA3A2GGuwCKC5DgkgiNOw4YMs?=
 =?us-ascii?Q?xmRPMSGvgspOn8bOyFKnsI5Xh1GshGy5C4NeOCxId6JdNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqPmy59xV9JdfK1SiYxzuiulvjELj+2AXyde0hAvgsR8avtxS3s/Pp7EgqKf?=
 =?us-ascii?Q?be2RTbynaCPINfSqRMM0isroD3Sekhh+C8DpohDRWFjK4Rryxw5U3tn8lcZV?=
 =?us-ascii?Q?BAFXl551/4Fa71T2yTbc3awPIqfVWV1qMkZnLJ6O9i4AJdnoQjv8cIU9ixHW?=
 =?us-ascii?Q?6iNOQl4M9MVtBUwwKZuSjh2YIwDtSDNC+rX9W+Lmf2u0oZGJDX9pnQ97hhlL?=
 =?us-ascii?Q?2W+1aQAFZaD1S9DVW3nh2hZWk9Q77wol04SFVaQ2RIFUyeX1ydLk9ioIAyi/?=
 =?us-ascii?Q?Lell155xila2LLh/fBFt63hC8E1swOwpYDK5B5lTDx/eCuMTJq+a7cqXQvvY?=
 =?us-ascii?Q?emjCTQepfdWzeLcxMSODl0zquEN9O+PFekMUM/CiO9lRg8wWKUYBlR0PT68H?=
 =?us-ascii?Q?FTr72gpl7RDM1BtmgGzPAgQdjns2mPhF5fFye0/32kt+nY/KPMPbHDf79Xvn?=
 =?us-ascii?Q?8S5aRcfkPoFPyPrzSVnC79CEEoOVMszAuFOz1bami/sl9BOgV29djLI8CsBN?=
 =?us-ascii?Q?1jW4QT8CJCXsXYRc02EG5iGpgsqn7GB1UuMsu7Khr8Dj014jDY577oKjtDk1?=
 =?us-ascii?Q?F2UpaaEeudNOE3fJG8dL1Gjh/Ak5eghOl2X0AxMQHWy8SFGv6AyI8s3JtTZv?=
 =?us-ascii?Q?hApQgi0Rqn6tSj1gevX/WFGGrGNtS+ChVcVI0MfvqkDEA4rgMgRlk2bopYX2?=
 =?us-ascii?Q?k9B0Y/Ir7dA9EmoinVfMvn8HVbA/T1/x/JlKMWQpJvoxdzacxAHe37SNqOL0?=
 =?us-ascii?Q?k0H+Ys/gRqlgFZAlo/ewNE4jYqvQ5SOf/1b4Wmuwd507jvmV1n6XNXz1wXpx?=
 =?us-ascii?Q?mVzjDc1uVIngFkXvDepNlQXi0TgDT1X3mFY6dW885WoD80wvGQ9dJzycG39n?=
 =?us-ascii?Q?dpeC8hG76TaEO0NBT0+5j/+PryJ4IQZuto4iQu5qoMXLZj4JW6bprume3Y0T?=
 =?us-ascii?Q?zyCO9DJhE6rLcYFckFyfQyOCNW78f3kLtZFxT40qUTlOaBfixs4hM0FOCQlp?=
 =?us-ascii?Q?SZNbFypmMbPsQUsJE5QrpPbj+m7mhmb00lpapdYyOEti+cvyEAtEJ+gKReOJ?=
 =?us-ascii?Q?XnaLlV/4hJ/0evzV5bVXRtXy0xfiefLirgHMWnqmIaGau1E/+rmgPMjq/SYL?=
 =?us-ascii?Q?4OfAgAvT7ICOk7oLLAKJkhAplRbIS4kXa7vl95y7aSzxm37R2Ly75TgBMf13?=
 =?us-ascii?Q?iSDAZGsT+YGrFP+cDfiI7dkRLZWr2m6QLh2CyqFv6iVkmhjc5LzZv+C0Q0ls?=
 =?us-ascii?Q?LCGpekYNHn26EVWGd4WROOTGqMx726dZeJtIoraKhaTZHbn+0cQTHrPg/wQp?=
 =?us-ascii?Q?v4BnmyFBECFM+dI9RDKf9MZ0PkD6wtH+rT4WeZVBcoBXtZj6T/Q/pjQkorY0?=
 =?us-ascii?Q?jgJtUnoMAyetFkp+beANxz4BDib1UuMkkbhACvaeVco0cL39DrI3XPyLQ3Ua?=
 =?us-ascii?Q?+nkU9OaQF/NGO9UAHWFF/ddLykVxapSCnWaQkamf40aOj4fj3RqGqVoQXpon?=
 =?us-ascii?Q?kdPIDnym3UaNR09BtyUUwe+b7GDBCp5zbygIL3djuC3p0BB55lTZ9qNcGJjl?=
 =?us-ascii?Q?sBvky1zoef/s6mGefV2SYp+jRQflDYyBj8DG5YbJabMMCr8jtzvKCGj7QIcF?=
 =?us-ascii?Q?hGvdWHQGDZzF/J35cSil3dutum6ORtg3JFR+1f4+HJsJ44KM+wMoNXGUfx5o?=
 =?us-ascii?Q?FFyIvg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SZcOqegJOxv/BuoXomvJIinYKYpBg29A/qR8e3JAbnMajb6E5d2BmOTm/T0ftS45Pa5ajLqPYL4qsgUPJBIntq70Bs6GsqcLc9T4wdUBn5tC3j5bTEWHz+cUWUKp6lWWfcQB3dzvcnWfKGw6zCJhMR5r5E//WnA80fIQJvqgGcB8yjDwEXf2DdOMpmIfbzq8WzuQSl1vzLEDrhMk7medl7cQaZ/OfW0h79BLGJUSV/ekmbFlRX/JIMgyxs2uHR+jIacBMGlmDl/eFO1UgfAiFSsLJxK9GGQumu/QiDbJfEudm9+MSIYnCFQpBgxXTkFoFQyr/xJUYtgqk9ZLH7evwRMi/azBilTPF0WqGyzwupMXpxsa5Y/ht8RChcrXx2hUyzri278NMokvUjUHhGEnvoaGgoGizxfeSEbNZkBtxv2fEmk9SmDIRwDD6GgOFjpRndKxUv4oXlmuO923KaH5lUWonZzuaHS1sq4y3TgN9Zm7MLnLApJK1E28zggZ3IsX2jRtwBrHtz7EyTz0V/d4dNWYxb7t2GqtF2S0unQ8TGGA6kDpG+kqrCOL5j9YY1erSl5QNyCEFyfkiarm4XfeIHLWQJGT5aNNwUrbiCu0ad4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbd3f97-3b72-4008-5b7c-08dcae5990ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 16:31:28.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IbX5hLQgJslR0j9YyaZr+g7HbARo8ldBaFvG5U7WsvsNvLIQTTsSt345B18o5dyZPtd8VFcjggHehInZpmhWAwrn4t/mgfh2ZMJ91X7Vc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270112
X-Proofpoint-GUID: XbmteTyitR_WIAkxOZ87XKrnqiY86uR6
X-Proofpoint-ORIG-GUID: XbmteTyitR_WIAkxOZ87XKrnqiY86uR6

On Sat, Jul 27, 2024 at 09:38:54AM GMT, Jens Axboe wrote:
> On 7/27/24 9:30 AM, Jens Axboe wrote:
> > On 7/26/24 4:48 PM, Linus Torvalds wrote:
> >> I didn't even look at what the issue was with the
> >> bio_for_each_segment() expansion, in the hope that Jens will make that
> >> one look better.
> >
> > I did take a quick look, pretty obviously bvec_iter_bvec() which makes
> > it horrible, which came from Kent's immutable work quite a while ago.
> > Not sure yet what to do about it, will spend some time on this next
> > week.
>
> Maybe something like this, totally untested...
>
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index f41c7f0ef91e..9ccccddadde2 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -130,12 +130,15 @@ struct bvec_iter_all {
>  	(mp_bvec_iter_page((bvec), (iter)) +			\
>  	 mp_bvec_iter_page_idx((bvec), (iter)))
>
> -#define bvec_iter_bvec(bvec, iter)				\
> -((struct bio_vec) {						\
> -	.bv_page	= bvec_iter_page((bvec), (iter)),	\
> -	.bv_len		= bvec_iter_len((bvec), (iter)),	\
> -	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
> -})
> +static inline struct bio_vec bvec_iter_bvec(struct bio_vec *bv,
> +					    struct bvec_iter iter)
> +{
> +	return (struct bio_vec) {
> +		.bv_page	= bvec_iter_page(bv, iter),
> +		.bv_len		= bvec_iter_len(bv, iter),
> +		.bv_offset	= bvec_iter_offset(bv, iter)
> +	};
> +}
>
>  static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  		struct bvec_iter *iter, unsigned bytes)
>
> --
> Jens Axboe
>

I tried this patch, doesn't seem to make a huge difference, going from
3,958,564 bytes with longest line of 82 kB to 3,943,824 bytes with a
longest line of 77kB.

It seems that the .bv_len = ... expansion is what's doing it, so I tried
patching mp_bvec_iter_len() as well to do a silly ?: thing (sorry), which
takes us down to 3,880,309 with longest line of 20kB.

This is starting to feel like whack-a-mole isn't it? I looked at the next
longest line, which originates from include/linux/pid_namespace.h believe
it or not where some compiler cleverness + a loop is resulting in _another_
combinatorial explosion.

Whacking that gets us down to 3,860,780 with longest line of 16kB and
(credit to Willy for telling me about the make <file basename>.i thing):

	awk '{print length}' mm/compaction.i | sort -n

Tells me we have... 18 lines >10k remaining in that file.

Obviously dropping from 82 kB to 16 kB max size is handy but I think all
this points to the need for a fundamental fix for this (I vote for
fundamental simplification of core min()/max() macros, keep something
complicated around for true const cases, e.g. MIN()/MAX()).

Patch attached including Jens's change + mine.

----8<----
From 4303ddf7bd7c892f89c37d9b2cc4102860d8ef97 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sat, 27 Jul 2024 17:25:03 +0100
Subject: [PATCH] Various attempts at whack-a-mole.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/bvec.h          | 26 +++++++++++++++++---------
 include/linux/pid_namespace.h |  8 ++++++--
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f41c7f0ef91e..567522aec2f9 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -101,9 +101,14 @@ struct bvec_iter_all {
 #define mp_bvec_iter_page(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_page)

-#define mp_bvec_iter_len(bvec, iter)				\
-	min((iter).bi_size,					\
-	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
+static inline unsigned mp_bvec_iter_len(const struct bio_vec *bvec,
+					struct bvec_iter iter)
+{
+	unsigned remains = __bvec_iter_bvec(bvec, iter)->bv_len -
+		iter.bi_bvec_done;
+
+	return remains < iter.bi_size ? remains : iter.bi_size;
+}

 #define mp_bvec_iter_offset(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
@@ -130,12 +135,15 @@ struct bvec_iter_all {
 	(mp_bvec_iter_page((bvec), (iter)) +			\
 	 mp_bvec_iter_page_idx((bvec), (iter)))

-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
+static inline struct bio_vec bvec_iter_bvec(struct bio_vec *bv,
+                                           struct bvec_iter iter)
+{
+       return (struct bio_vec) {
+               .bv_page        = bvec_iter_page(bv, iter),
+               .bv_len         = bvec_iter_len(bv, iter),
+               .bv_offset      = bvec_iter_offset(bv, iter)
+       };
+}

 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f9f9931e02d6..0c9642acc670 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -60,8 +60,12 @@ static inline int pidns_memfd_noexec_scope(struct pid_namespace *ns)
 {
 	int scope = MEMFD_NOEXEC_SCOPE_EXEC;

-	for (; ns; ns = ns->parent)
-		scope = max(scope, READ_ONCE(ns->memfd_noexec_scope));
+	for (; ns; ns = ns->parent) {
+		int ns_scope = READ_ONCE(ns->memfd_noexec_scope);
+
+		if (ns_scope > scope)
+			scope = ns_scope;
+	}

 	return scope;
 }
--
2.45.2

