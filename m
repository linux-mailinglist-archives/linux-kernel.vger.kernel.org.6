Return-Path: <linux-kernel+bounces-259551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821B93983F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A802823E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72BB13AD2A;
	Tue, 23 Jul 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="BoBP8GEq"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69714136E3E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701501; cv=none; b=SzRPeaG8A8D1Cu5L1j/0GqD1v+kSD4AuDDttBsws2K7D49iWp1S9kiBdxDb9h5g37AtzrIYMwb3nrULmVXEgw1mvmHgAhQcZiMgFl+M2HSRfg+g2gDcyAykeK9Sy5yf20CPPvX0C/6+xabJVY32xna+NwITFKcVMMn0ShrkiSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701501; c=relaxed/simple;
	bh=bbMUkaxns8AHvRh8jYe2Eawi/NqWsk6vaShfYeAGqmI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=orjKx9FCDfnBVB0GYBd4iMlZ3oT8icObVGYNk5wb4BhMnv/5yAAulDznC6we0J8N/H+Vrs7r/C8OKJC7SJmlGkUSEyAkfyYo16VRz17gF7kU/1fI2YtxdQBXkM3VerSao0iey+vLjDx4fD3w/XIqJTrhxNhsn8j2LGM4eiuPvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=BoBP8GEq; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d9dbbaa731so2321517b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1721701498; x=1722306298; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbMUkaxns8AHvRh8jYe2Eawi/NqWsk6vaShfYeAGqmI=;
        b=BoBP8GEq7h4mF1jvQADuA+2S+VkAjXrIBPtaRjVJTYlrbsB3gd7Kdfw8GgiYqz75C3
         GPMzifm3tmH4wUtC3O3f0hTPMDyif+ZiJNLFZmfp0udVE3+Q71kyD5mqAsRVGrHVwruE
         Y+Gvn2mTJ32GgxOKIUM1tO2NcsQiPaDVWwu68Uoh/IJ9PtqNJKGrVyoydiX627rM/8VR
         ihWyabkdNQX7Q88coU4e++gLPoF6KJ65ppC/Qq8tyNwViTDBsed/AcVWoMxRMw3HyH4x
         v19n/AouTtmjkKW253t2mnn1wL7CurnEW1lIgLZnPG0RHP+vbmF7lZCO5PFStCJ0cMMo
         q3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721701498; x=1722306298;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbMUkaxns8AHvRh8jYe2Eawi/NqWsk6vaShfYeAGqmI=;
        b=Bxr9zzvfA8hswcp6mAZRagcvEXUiZ+U3YKiD9wWiKs6Vk6Vs4gJn2ofShi+bjMWm4Z
         9vBV/Do3YP/l8XvR0L7gk/Kn6x8P9x4zvCOC5sr/PceQd0kFK9H0vZquTBnsP1eQP6HO
         gBLPD+a4H16otS+oPnQzrCEznW+EnIRp1JXSCHiCpjgiEtxcYPqnfnMWCyBWm22s5nao
         eOlf9Z0jLzgFeMb5C7Q3wUdAb0J21uOGt1oMOms5OQVn10os/FIk+9Y0rWYkED7NNaQt
         mqGhVm6Ns3IjrzBdxlWG7Nqh06ma7Pjm/U+eJz7YTxtesPFIOQDaHKCipsJDhDZnPeXx
         52Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWriEFLIUuM/z9oDz72kcA87iwQJDxmlyc33z1X6gnKIl3tAA16zT3Ddhay1ohkOSUrLs5WIzs5Ya5jpPmcATT1c8S+J/+gj8s9NpwQ
X-Gm-Message-State: AOJu0YwI2w+1xsoVRQ0adCkJ/2xAmD4JwooAP1JZSRm6DJo4KalNNKu+
	/dURERNnu98d8HOK97DDCxZIyavWFLD+g+YzcblQcNhn2eScHfz/45JPgLt8m5M=
X-Google-Smtp-Source: AGHT+IGKV0Jr707W/PYg3CdIghKKq9m4koiy0RQBiYd5g1IyKHEH5K5usjE4xPPwdEHv17Qb9PHfzg==
X-Received: by 2002:a05:6808:14d3:b0:3da:a0a5:a254 with SMTP id 5614622812f47-3dae97c892emr7610424b6e.20.1721701497775;
        Mon, 22 Jul 2024 19:24:57 -0700 (PDT)
Received: from smtpclient.apple (vps-bd302c4a.vps.ovh.ca. [2402:1f00:8000:800::34b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a1a7b45af2sm2637967a12.3.2024.07.22.19.24.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2024 19:24:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v3 0/2] scsi discard fix
From: Li Feng <fengli@smartx.com>
In-Reply-To: <55d9f47b-5833-4e3c-9e56-f56a30083607@kernel.dk>
Date: Tue, 23 Jul 2024 10:24:36 +0800
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA41FB3C-D3DF-4219-B027-5E5A69D92F07@smartx.com>
References: <20240718080751.313102-1-fengli@smartx.com>
 <c1b47037-4754-459f-9e8f-ae4debd3fcf2@kernel.dk>
 <yq1o76pdltx.fsf@ca-mkp.ca.oracle.com>
 <55d9f47b-5833-4e3c-9e56-f56a30083607@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3731.300.101.1.3)

Hi Jens and Martin,

Thank you.=20
I was worried that you were too busy and forgot about these two patches.

> 2024=E5=B9=B47=E6=9C=8823=E6=97=A5 08:37=EF=BC=8CJens Axboe =
<axboe@kernel.dk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 7/22/24 5:55 PM, Martin K. Petersen wrote:
>>=20
>> Jens,
>>=20
>>> They can, but is there some dependency that means they should go
>>> through the block tree? Would seem more logical that Martin picked
>>> them up.
>>=20
>> I'll get to them. Busy with a couple of hardware-related regressions
>> right now.
>=20
> All good, just wanted to ensure they weren't waiting on me, as the
> cover letter seemed to indicate.
>=20
> Thanks!
>=20
> --=20
> Jens Axboe
>=20
>=20


