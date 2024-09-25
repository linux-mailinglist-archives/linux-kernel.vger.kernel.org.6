Return-Path: <linux-kernel+bounces-338265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F998559C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293B91F24CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969015AAB8;
	Wed, 25 Sep 2024 08:37:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF81552E0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253466; cv=none; b=jcL75fQJvnMFZ7aP3Cahx1Y1P1Bo8GltYzzYfD4xeVQWuxVlS6ly5uuolnjnG6JLSoNmOkhFVog1v8WBzDSZNCJ70b8FWR2udS6+FySNuZk10D9kV2NcPlLMtoY7XaJ7q4R2p/jTiDSzVkNrdE7l9unw63aPCrCwutZj5zMeOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253466; c=relaxed/simple;
	bh=bstWjkqidV3y9eeyZS8tuwMw8WT0PE6N6cokNJ4yF2Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j4TgJ+pA86D6tWa8nujBbyaIoAiDhDN7gUMZZgbN7qpKtL7LqBmmQKWd/CkhKT88N5pyU6fshK8o5TTY2NdwsWisd111TUxuy0hiUnzcut6VeWvqKz/7B9YNIQJSq0HUFglbwJr1nWLlGVqtpxI34xjN8bmDI79WF/rxWlAWVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5eac7b4e7b1911efa216b1d71e6e1362-20240925
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:94188f28-3202-418b-8f0c-6070742375e2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a046b15fc850bccb80cba159b71a5529,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 5eac7b4e7b1911efa216b1d71e6e1362-20240925
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 256147864; Wed, 25 Sep 2024 16:37:16 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 49FAAB803C9B;
	Wed, 25 Sep 2024 16:37:16 +0800 (CST)
X-ns-mid: postfix-66F3CBBC-266130561
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id 6D5FDB803C9B;
	Wed, 25 Sep 2024 08:37:14 +0000 (UTC)
Subject: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function isolate_lru_folios
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240814091825.27262-1-liuye@kylinos.cn>
 <20240924172205.5068e86430873b09b75f8538@linux-foundation.org>
From: liuye <liuye@kylinos.cn>
Message-ID: <565bae19-889e-57df-42ff-70728cfb818c@kylinos.cn>
Date: Wed, 25 Sep 2024 16:37:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240924172205.5068e86430873b09b75f8538@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2024/9/25 =E4=B8=8A=E5=8D=888:22, Andrew Morton wrote:
> On Wed, 14 Aug 2024 17:18:25 +0800 liuye <liuye@kylinos.cn> wrote:
>=20
>> @@ -1669,10 +1670,12 @@ static unsigned long isolate_lru_folios(unsign=
ed long nr_to_scan,
>>  		nr_pages =3D folio_nr_pages(folio);
>>  		total_scan +=3D nr_pages;
>> =20
>> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
>> -				skip_cma(folio, sc)) {
>> +		/* Using max_nr_skipped to prevent hard LOCKUP*/
>> +		if ((max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED) &&
>> +			(folio_zonenum(folio) > sc->reclaim_idx || skip_cma(folio, sc))) {
>>  			nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>>  			move_to =3D &folios_skipped;
>> +			max_nr_skipped++;
>>  			goto move;
>=20
> This hunk is not applicable to current mainline.
>=20

Please see the PATCH v2 in link [1], and the related discussion in link [=
2].
Then please explain why it is not applicable,thank you.

[1]:https://lore.kernel.org/all/20240919021443.9170-1-liuye@kylinos.cn/
[2]:https://lore.kernel.org/all/e878653e-d380-81c2-90a8-fd2d1d4e7287@kyli=
nos.cn/

Thanks,
liuye

