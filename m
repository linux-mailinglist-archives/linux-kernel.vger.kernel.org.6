Return-Path: <linux-kernel+bounces-351863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE7F991700
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18E9283616
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51515278E;
	Sat,  5 Oct 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Pasi6hbx"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66487149DE8
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728134712; cv=none; b=MIWc9Mxx00it0oeCttJMNk5kNfQnABAtqFHcEPbO16hUuNxae1qzsgTw4Y2MQu2fdX4eJwViQ8HovB8UOPHbPNTGox3IUWFDk1fmzCoyTwDfcpJjm0Uta3hC/UZuxSyoC7hv4SysxlqXCl+7/V3EmOzPMtawvz+6a7tmi3OmtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728134712; c=relaxed/simple;
	bh=UZ0WT1zup6bzpDVkUOxOQBBUJRAsmTUz8Srgx16xk1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffUlftEfuibhNboSYtp94OBQGRUKWDadNImxnbxgYfBos4Wh2wQ82oU7wMo+cfBK5jHjD1H1woQnZ+4lYG5vp7uPvx5WHQz7WI7w6myyV4sVI6tuLCr+l3Uo8sllVx/KzY9SW6EjhJ/9fEOLWt8OWocbi+ypBwVl0kj+DRlvUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Pasi6hbx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728134681; x=1728739481; i=spasswolf@web.de;
	bh=UZ0WT1zup6bzpDVkUOxOQBBUJRAsmTUz8Srgx16xk1Y=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pasi6hbxOGpfJ/BLkc7K1yxvAo/mGtBF1p7XYhHcJWlTFE2RZhUqd9hYZDCluoYo
	 Va+ADVdGvW7yMHxeYuMVe2mDTfFAdq7CX3BeVIWCHICdFRBvwuhU59x393oiKyoI4
	 MCL99rFJDS0gEl8CMMiowecZczY8EQi+JXFRQzJxQDOwfbeqCPuU5kxTWdgUGmLBo
	 4EgeAk3oGae0cxv7LcrmtHqbZ/Wq2PW0nh4CrCgfxtsRX3zK8FdNJEilqyhD/hmC+
	 DVcb5xxx73/9Kae247nttWAsz+Yewc0iqRUzRlFq9ME8p8kdSnGYk4z4+KM5WF16l
	 tpgosxV8fD2zZMdp3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9ra-1tUd9v1yhe-00Y67G; Sat, 05
 Oct 2024 15:24:41 +0200
Message-ID: <2eefc57370d54b70e082edfe69bb98d17fa1b27f.camel@web.de>
Subject: Re: [PATCH hotfix 6.12] maple_tree: correct tree corruption on
 spanning store
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox	
 <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>,  Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, spasswolf@web.de
Date: Sat, 05 Oct 2024 15:24:39 +0200
In-Reply-To: <b7eaef5a-016e-46ae-b7e3-2bd16909110e@lucifer.local>
References: <20241005064114.42770-1-lorenzo.stoakes@oracle.com>
	 <b7eaef5a-016e-46ae-b7e3-2bd16909110e@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1R9atwRXp2JdRMlYLBjQIu32bmDqWLV+J2BTeyKKvOi95q/NqAx
 VDh0w/4Xbst9rvbB8qo+R9cn2ARGOoIJ+P0CTIzHfU2ubHywANZHHlJ+YRrKr0xxmvqCMzG
 zaUGK0FMM9mTWpyCVZ00bqocwxal/jDaH1jwcinrwAZEKuCSyKEGkZye1XywsKl/aj/8wvn
 LRmXpfb0GrBIpDNZEZZGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jO03+Qh/RXw=;c+TMpuYokjOJsqc+uI27DYC3++h
 o4HMHVzksNnTS7QeIzduaTxogRHSN81MJe7+y25T4il+Cqq3OxLQ58eMzXZOulmvljxnO6/+d
 J78G+EVG7Q+GyBbzhT7NbtvrxlPkBfSQHSCuwhPpQdmv2OnL6FoYaogVT4c2o+9tZCWohRyFW
 QXLwR3V8vS/GXPA5I78XlwkxE49d6dyblN6emxSgQ8jokydHjpBml18GoPIBUTub+aaMdriZI
 cXvJ4r9eHoj9bGtzC+RS+9fTrL1cTlvt6K/N2fI3QR/Yo5RtCQnaNNvvgZAQNobcOClENUVy2
 fBQiqCslMtCUcGVJJ1nezu70Xbv9Dxni5wb3Cb5YzhO+Oq4BO+/zn1DcjqfhPF9hQ6pJpkrTY
 Og9mEjvm24snys0JFzOa8yso8iBJhAbbvXpcVpsoJDp/3qHJ2Gas+azUqacvOs+bvlm5lQmmK
 n5PUr6KaHT9DGaumsB51Df3m9XBMh/mFXAsnw7rpWGTdUKLRSibueEv/v2nReyG7TvbVDvigb
 GUfnI6PU+8V+p/vhwxoOY7DycRDkLIrLIHgtTebSn/0VqFXuFjg26YILidf9wsbBK9K2dS0rP
 ronBpB72UB7X0r4hPkzvtjvpFCYw075mWuPD2xZlG6yeBZ4GbEPcU9QkdInVHzc+igqEaiEPg
 Tz8DesEMT6fQFSdUWoc5rOwbIr4Bxzj3gRrLE3GDk8Ml5yi948qZwnfQbI7ne0GdzRP5DbZEP
 ptm9jddWyBttxpHR0B+2tQiBRVufP5pv12juKsEfSu+nzD42uKRDRgm3B2FXxh26YoLIh6Xzi
 gbSvRXsKXlg/ZANWiZrbcOYQ==

Am Samstag, dem 05.10.2024 um 12:17 +0100 schrieb Lorenzo Stoakes:
> On Sat, Oct 05, 2024 at 07:41:14AM +0100, Lorenzo Stoakes wrote:
> > Writing a data range into a maple tree may involve overwriting a numbe=
r of
> > existing entries that span across more than one node. Doing so invokes=
 a
> > 'spanning' store.
> >
>
> [snip]
>
> Andrew - just to note that I have intentionally left stable off this, in
> order that wre can allow this to stabilise in the 6.12 release candidate=
s.
>
> Up until 6.12 this bug seemed much harder to hit, and as far as I'm awar=
e
> we've never had a bug report for it prior to this.

I still suspect that this could have been the same error:
https://lkml.org/lkml/2024/8/28/1558
When compiling the kernel without CONFIG_DEBUG_VM maple tree bug results i=
n an
unkillable task, and when trying to kill it first produced the rwsem warni=
ng
(and soon after took down the whole system).
But I couldn't reproduce it with the given reproducer, either.

Bert Karwatzki


