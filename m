Return-Path: <linux-kernel+bounces-199078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0EA8D81DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E702B1C217CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C81272DB;
	Mon,  3 Jun 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="tZPl3dxq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1885634
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416453; cv=none; b=jE/r28e97QIIx/ismSXtQCsK/0KgJ+oFxU4B6enUmwVA642krPuNsgz4LVEpjKpbdR2FMrjC4r/Fq8v2l1ZkB7qf7M81Sx3XffCbUk1nrIjSwclShDVpFy7B+dhQrwcCSpoKRpx0qTSkrrK12hivfD+ifdi+F3HaUmsJEqvb7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416453; c=relaxed/simple;
	bh=Y3gF7BbKcqa4JwB0PvnAnvWiJxHmYd92raETWsFFdRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZMnpBMznJ5DkoBNAtXAvFOvMNZclmvxsRIAU6QCd8nU/t2MeAkaz0PT31Ddo1tsAXP3wZnurMxXKzcGjBlDKH+k798O4KZ0lDVclBH8iMmX7kW998AA7sQBmDNt/8BVRRZ4eZblWzIdZV85HuGpA54nx0fK1hagnJydvJYCnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=tZPl3dxq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4213b94b7e7so5944835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717416451; x=1718021251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N43+9H6E0yFDxtyEp5leqtS2IT5bU0sKoqZhcVUnDjg=;
        b=tZPl3dxqYf9d3vwn+V7fPEZEbncNj6gj9Z+Su3MetWZlqYyp/kN//gENoi5IkVapeo
         6LsBVU7+0mgOLKMEc2vnXNr4C5T6eXTxiGCP4v1ZWOyoNDoAZtG+3fv4y4qmgJxtWubH
         +tCAuB2MnzRyffwwlO4ERu2XgWhQoUAg5Y7bF01qHsp+Xl0VPCRhJTtqO8S7MD7nXRw0
         NyxMNJPiBOe6ij25a7+UXsmjEjhB763e2YdLrzqSM7Ye5l6SDhyeVVo8ZwMiGgZqFKau
         AmaNv1jkO7g0OSUt2RmWtz1boULWDZMeF8TQuWN0BlPuhXhuDx7BLK4PcPwvgfSME4X6
         p2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717416451; x=1718021251;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N43+9H6E0yFDxtyEp5leqtS2IT5bU0sKoqZhcVUnDjg=;
        b=lIVtU1TUEkOtH6HiUEDpTisJv5K+aOXAejj3nQD5J2SiXV2vG68VFJ+A7NrlsUpQps
         m+MOT1zuCb0XEsb+13d57uRhu4oCuzv+TNXdnHhjvtHTTXRmxMQttW/AZltIV7oo2au/
         2XsgliPVhRI8gCsQq1N8p7Rv7cQ8ms2sgDiysewvJlPC5oKDa5IMq2eWM0gsuurTRGEC
         gIegymBRuLjCBrZItS5QeNeP6FEynNXvxtNkxXrHyBeK/k9PawWCBRpSKqChaUa8Kwpw
         lhGFyIj4AXG78uqBgS6ZETDCgOTA1pvGMHbXIP1iIyR5CgGS23wRoNJ6Z3FGTl4c0D36
         RPxw==
X-Forwarded-Encrypted: i=1; AJvYcCWp6wnIm+aHuSa0uixSTmmfcofUEtlDRm+jBWTVlHkNkiPUUdWcjysks5UDXvkreb09xIBGsICs5M9G7A0IAa+Q3AAOsWItLjs3jsEY
X-Gm-Message-State: AOJu0YxqpmyYvL02dl7h3548FXuPu9pD50ubpq8ZHVw9kXpPAe4aPGZ3
	hi485hCsVCT+jdCnJRiKQrMVbFUKmfNc2zLtGwRSl3LkQQRvXHLcsSWraOl2f7o=
X-Google-Smtp-Source: AGHT+IEtb1E9CA27ySEC8+JzZdUXyME6wqrjg4eprqNL3aHZhI5qpOxKKzkltHbM4Nklg291mS+POA==
X-Received: by 2002:a05:600c:1e27:b0:41b:8041:53c2 with SMTP id 5b1f17b1804b1-4212ddb68d0mr81757385e9.15.1717416450440;
        Mon, 03 Jun 2024 05:07:30 -0700 (PDT)
Received: from localhost ([165.225.194.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213837673csm70127375e9.31.2024.06.03.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:07:30 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,  Andreas Hindborg
 <a.hindborg@samsung.com>,  Keith Busch <kbusch@kernel.org>,
  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] null_blk: fix validation of block size
In-Reply-To: <d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com> (John Garry's
	message of "Sun, 2 Jun 2024 11:57:03 +0100")
References: <20240601202351.691952-1-nmi@metaspace.dk>
	<d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com>
Date: Mon, 03 Jun 2024 14:03:34 +0200
Message-ID: <87frtumdwp.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Garry <john.g.garry@oracle.com> writes:

> On 01/06/2024 21:23, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> Block size should be between 512
>
>
>>and 4096
>
> Or PAGE_SIZE?

Right =F0=9F=91=8D

>
>  and be a power of 2. The current
>> check does not validate this, so update the check.
>> Without this patch, null_blk would Oops due to a null pointer deref when
>> loaded with bs=3D1536 [1].
>> Link:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/87wmn8mocd.fsf@m=
etaspace.dk/__;!!ACWV5N9M2RV99hQ!OWXI3DGxeIAWvKfM5oVSiA5fTWmiRvUctIdVrcBcKn=
O_HF-vgkarVfd27jkvQ1-JjNgX5IFIvBWcsUttvg$
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>   drivers/block/null_blk/main.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main=
.c
>> index eb023d267369..6a26888c52bb 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1823,8 +1823,10 @@ static int null_validate_conf(struct nullb_device=
 *dev)
>>   		dev->queue_mode =3D NULL_Q_MQ;
>>   	}
>>   -	dev->blocksize =3D round_down(dev->blocksize, 512);
>> -	dev->blocksize =3D clamp_t(unsigned int, dev->blocksize, 512, 4096);
>> +	if ((dev->blocksize < 512 || dev->blocksize > 4096) ||
>> +	    ((dev->blocksize & (dev->blocksize - 1)) !=3D 0)) {
>> +		return -EINVAL;
>> +	}
>
> Looks like blk_validate_block_size(), modulo PAGE_SIZE check

Cool, I will use that instead.


BR Andreas

