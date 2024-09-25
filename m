Return-Path: <linux-kernel+bounces-338344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962B39856AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263711F2506F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FDD154C0E;
	Wed, 25 Sep 2024 09:53:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF36F2F2
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258025; cv=none; b=b7aFALFkvi/4wOPpMmcmm65xy4DSsDIcrjHW5fz0277ImbX3o9SE3GbZVKP9oq7egaLpU421hUXi/emDUQ5D8O35Q84Nhb30as8mAk7Y93GGLhtmrZygRatZjh2GDne/zPqZe7XgIaIZKY126QYVRNWzZPlt+Iw3xKQ1AfhgUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258025; c=relaxed/simple;
	bh=9QvPahs1AKyF7U9t8Hau0RqKY32xlm7hqix974PuZmw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZjP0gDZqKQSloXOMLSotXleOfv57a2wReAYmlJJHLQS1U6mzZg2nnH2Q8WfttVAd4H86LBNAf2guEgeeEJLjj+xnKM9yxZshxiRuGNZwUFB9iU3Uh9JIp7RZoXY4oc6dLQvXRV2O4ttnFxIH89/76fWDfqJmNAwUdTBd9Qibhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 033194067b2411efa216b1d71e6e1362-20240925
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:762292cf-c5a4-4c29-a9bf-8e4f5ca46732,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:dc23199cd3ea9806256a2ebe4be2ba54,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 033194067b2411efa216b1d71e6e1362-20240925
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1024422858; Wed, 25 Sep 2024 17:53:27 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 45207B80758A;
	Wed, 25 Sep 2024 17:53:27 +0800 (CST)
X-ns-mid: postfix-66F3DD97-234119772
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id A5A74B80758A;
	Wed, 25 Sep 2024 09:53:26 +0000 (UTC)
Subject: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function isolate_lru_folios
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240814091825.27262-1-liuye@kylinos.cn>
 <20240924172205.5068e86430873b09b75f8538@linux-foundation.org>
 <565bae19-889e-57df-42ff-70728cfb818c@kylinos.cn>
 <20240925022914.7c4033c9bb1206ad149ba69e@linux-foundation.org>
From: liuye <liuye@kylinos.cn>
Message-ID: <cafb20af-f152-9136-e762-901ce4dcf729@kylinos.cn>
Date: Wed, 25 Sep 2024 17:53:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240925022914.7c4033c9bb1206ad149ba69e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2024/9/25 =E4=B8=8B=E5=8D=885:29, Andrew Morton wrote:
> On Wed, 25 Sep 2024 16:37:14 +0800 liuye <liuye@kylinos.cn> wrote:
>=20
>>
>>
>> On 2024/9/25 =E4=B8=8A=E5=8D=888:22, Andrew Morton wrote:
>>> On Wed, 14 Aug 2024 17:18:25 +0800 liuye <liuye@kylinos.cn> wrote:
>>>
>>>> @@ -1669,10 +1670,12 @@ static unsigned long isolate_lru_folios(unsi=
gned long nr_to_scan,
>>>>  		nr_pages =3D folio_nr_pages(folio);
>>>>  		total_scan +=3D nr_pages;
>>>> =20
>>>> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
>>>> -				skip_cma(folio, sc)) {
>>>> +		/* Using max_nr_skipped to prevent hard LOCKUP*/
>>>> +		if ((max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED) &&
>>>> +			(folio_zonenum(folio) > sc->reclaim_idx || skip_cma(folio, sc)))=
 {
>>>>  			nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>>>>  			move_to =3D &folios_skipped;
>>>> +			max_nr_skipped++;
>>>>  			goto move;
>>>
>>> This hunk is not applicable to current mainline.
>>>
>>
>> Please see the PATCH v2 in link [1], and the related discussion in lin=
k [2].
>> Then please explain why it is not applicable,thank you.
>=20
> What I mean is that the patch doesn't apply.
>=20
> Current mainline has
>=20
> 		if (folio_zonenum(folio) > sc->reclaim_idx) {
> 			nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> 			move_to =3D &folios_skipped;
> 			goto move;
> 		}
>=20

PATCH v2 base on current mainline.

@@ -1650,9 +1651,12 @@ static unsigned long isolate_lru_folios(unsigned l=
ong nr_to_scan,
 		nr_pages =3D folio_nr_pages(folio);
 		total_scan +=3D nr_pages;
=20
-		if (folio_zonenum(folio) > sc->reclaim_idx) {
+		/* Using max_nr_skipped to prevent hard LOCKUP*/
+		if (max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED &&
+		    (folio_zonenum(folio) > sc->reclaim_idx)) {
 			nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
 			move_to =3D &folios_skipped;
+			max_nr_skipped++;
 			goto move;
 		}



