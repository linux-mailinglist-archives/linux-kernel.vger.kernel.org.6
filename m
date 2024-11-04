Return-Path: <linux-kernel+bounces-394496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 582879BB00F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE31C22221
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248D1AE877;
	Mon,  4 Nov 2024 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IqugJYrU"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FD1ADFEC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713463; cv=none; b=ZLOaMP8ZUjyxPzE26NA2tlByiQkJHJGL+Lc+I5/nDqHSCngPKPtp/1GcNW2W6OQEu1FfWhsnWgnYnJNMg6uNprb4r4+4P4r22jBgSWNZO+/TLR7sEcbsjgJXE9iK/eyBmRIJd9gUYjZ1GU45lF1zP7i/cySooTQj8eU8A9RW9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713463; c=relaxed/simple;
	bh=ejo04jRH998N3C1mTdgvVnP8uP/HM6Ud4EVyMTANRqk=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=O3vmD3hss5o6A2DjYill4hd4SupJ/2iV/U3jH/3edNct2Cdi8TyS4ZA1odcgou3royB2YXg4psB47Lyqsr87dg2LBoVG8Nu5g0DjOi6guGf32QtHMu1kATVUV2vHAzlduggZjCcBNvzVA16NGXy/6ByDH+I0dG5+YuNK9vVOnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IqugJYrU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241104094413epoutp0339d973fc16070fe41ca46866133a9c93~Eurd37kZK3127631276epoutp03Z
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:44:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241104094413epoutp0339d973fc16070fe41ca46866133a9c93~Eurd37kZK3127631276epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730713454;
	bh=M1miNIYhG1QwHyjzF59FHi1H9PWcn1lSEkKONcArFuM=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=IqugJYrULbVBD4BViH/D0rDpt6i01zWETZxKEuw06Yd0qHYV1wva0N6+723iEQIl5
	 HQO7Ck+04yTd/48tUhevPFYnFi6y9AutoAN2vwyOvtZe/ijKD6k9dUa37EQB8I/KCZ
	 Goi/niBEYBJrbkaBPZRFZ3tcTCSUgQ0qCN71mv8w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20241104094413epcas2p49f76cf369e11007548f4389b88cc4f3d~EurddPD2G0277502775epcas2p4K;
	Mon,  4 Nov 2024 09:44:13 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xhml06wgmz4x9Q1; Mon,  4 Nov
	2024 09:44:12 +0000 (GMT)
X-AuditID: b6c32a47-aefff70000002630-90-6728976c1761
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.2E.09776.C6798276; Mon,  4 Nov 2024 18:44:12 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid forcing direct write to
 use buffered IO on inline_data inode
Reply-To: jinsu1.lee@samsung.com
Sender: =?UTF-8?B?7J207KeE7IiY?= <jinsu1.lee@samsung.com>
From: =?UTF-8?B?7J207KeE7IiY?= <jinsu1.lee@samsung.com>
To: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
CC: "chao@kernel.org" <chao@kernel.org>, "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?7J207KeE7IiY?=
	<jinsu1.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241104094412epcms2p13f82502b0ff6167ff30eb76c6dda41de@epcms2p1>
Date: Mon, 04 Nov 2024 18:44:12 +0900
X-CMS-MailID: 20241104094412epcms2p13f82502b0ff6167ff30eb76c6dda41de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmuW7OdI10g7bzRhanp55lsniyfhaz
	xbWmiawWlxa5W1zeNYfNgdVj06pONo/dCz4zefRtWcXo8XmTXABLVLZNRmpiSmqRQmpecn5K
	Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBaJYWyxJxSoFBAYnGxkr6dTVF+
	aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xvcbd9gKjklUzDv1gL2B
	catwFyMHh4SAiUTbW7MuRi4OIYEdjBKvZrWwgcR5BQQl/u4AKuHkEBYolDjxrJsFxBYSUJCY
	2rKJDSJuKXFx6T9WkHI2AXOJG73eIGERgXCJ+ct3sIOMZBY4xSjRuOsUK0hCQoBXYkb7UxYI
	W1pi+/KtjBC2hsSPZb3MELaoxM3Vb9lh7PfH5kPViEi03jsLVSMo8eDnbqi4pMTOloVQ8XyJ
	h+cfsYIslhBoYZQ4PWcKVJG+xLY/s8EW8wr4Smx72s4EYrMIqEqc2TEP6iAXiTXbesDizALy
	EtvfzmEGeYxZQFNi/S59SFApSxy5xQJRwSfRcfgvO8xbO+Y9YYKwVSRWz90HdY6UxJwVk6Au
	8JC4NvUeGyQIAyVeb7vHNoFRYRYioGch2TsLYe8CRuZVjGKpBcW56anFRgXG8KhNzs/dxAhO
	f1ruOxhnvP2gd4iRiYPxEKMEB7OSCO+8VPV0Id6UxMqq1KL8+KLSnNTiQ4ymQB9PZJYSTc4H
	JuC8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqYls1h8f3AfIR7
	1yXxns3zjDQbLh6JvrNx+cwvf+7ebDwtGz67QS/02IyPazWcPjt36uq18nVbWCj8c2/XcUpU
	VOl9njn137Tfv4T1qxpkKhZN13+ly6Aaf/D+9mCuE2U/bP8s1dbfmcPR6HAtek6cuon0dmHN
	SVdfzDmY7WbI88f7uNiRbdNFfCNYQ4zV1169tuLjge//b1akCCvru8e/C6tZKRO6nO9SxSE+
	/eal6XMzv9f9mD8t1rbS/+TJxY/WbNSJFpzd8fHfCsY2lytBTXwyBYeSzSInNphN4VQPsFyX
	nHj000KF1IcfbTIFH+x76vekW8gpMl5CRyhy1h/R9pgrmyc/jE8oj4p4sXKbEktxRqKhFnNR
	cSIA4S5uuAgEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104094412epcms2p13f82502b0ff6167ff30eb76c6dda41de
References: <CGME20241104094412epcms2p13f82502b0ff6167ff30eb76c6dda41de@epcms2p1>

>>> Jinsu Lee reported a performance regression issue, after commit
>> 
>>> 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
>> 
>>> inode"), we forced direct write to use buffered IO on inline_data
>> 
>>> inode, it will cause performace regression due to memory copy
>> 
>>> and data flush.
>> 
>> 
>>> It's fine to not force direct write to use buffered IO, as it
>> 
>>> can convert inline inode before committing direct write IO.
>> 
>> 
>>>> Fixes: 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data inode")
>> 
>>> Reported-by: Jinsu Lee <jinsu1.lee@samsung.com>
>> 
>>> Closes: https://lore.kernel.org/linux-f2fs-devel/af03dd2c-e361-4f80-b2fd-39440766cf6e@kernel.org
>> 
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>> 
>>> ---
>> 
>>> fs/f2fs/file.c | 6 +++++-
>> 
>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> 
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> 
>>> index 0e7a0195eca8..377a10b81bf3 100644
>> 
>>> --- a/fs/f2fs/file.c
>> 
>>> +++ b/fs/f2fs/file.c
>> 
>>> @@ -883,7 +883,11 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
>> 
>>>                  return true;
>> 
>>>          if (f2fs_compressed_file(inode))
>> 
>>>                  return true;
>> 
>>> -        if (f2fs_has_inline_data(inode))
>> 
>>> +        /*
>> 
>>> +         * only force direct read to use buffered IO, for direct write,
>> 
>>> +         * it expects inline data conversion before committing IO.
>> 
>>> +         */
>> 
>>> +        if (f2fs_has_inline_data(inode) && rw == READ)
>> 
>> 
>> Chao Yu,
>> 
>> The fio direct performance problem I reported did not improve when reflecting this commit.
>> 
>> Rather, it has been improved when reflecting your commit below.
>> 
>> 
>> The previous commit seems to be mistitled as read and the following commit appears to be the final version.
>> 
>> The reason for the improvement with the commit below is that there is no "m_may_create" condition
>> 
>> when performing "io_submit" directly, so performance regression issue may occur.
>> 
>> 
>> I wonder if "rw == READ" should be additionally reflected.
>
> Alright, thanks for your feedback.
>
> I thought you have bisected this performance issue to commit
> 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data inode"),
> so I sent this patch for comments.
>
> Can you please apply both below dio fixes, and help to check final
> performance?
>
> https://lore.kernel.org/linux-f2fs-devel/20241104015016.228963-1-chao@kernel.org
> https://lore.kernel.org/linux-f2fs-devel/20241104013551.218037-1-chao@kernel.org
>
> Thanks,

Chao Yu,
After reflecting the following two commits, the fio DIO seq write operates with normal performance.

https://lore.kernel.org/linux-f2fs-devel/20241104015016.228963-1-chao@kernel.org
https://lore.kernel.org/linux-f2fs-devel/20241104013551.218037-1-chao@kernel.org

However, Antutu Apk's "AI READ" performance has more than tripled compared to before patch reflection, so it seems necessary to check if there is any problem with DIO performance.

