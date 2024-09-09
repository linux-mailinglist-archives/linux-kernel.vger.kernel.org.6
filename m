Return-Path: <linux-kernel+bounces-320902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA84D9711CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71E71C22882
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74041B1D53;
	Mon,  9 Sep 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIaxZeQF"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB081B1518
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870153; cv=none; b=ljwBp2ie7fCCSfgPc0jHqaYe13M9Nz3P9jhzqiLaH13Iyl7zGz+bLkyAOxalHk8rZ52mZTs00zNh9YHjBdyuLgF5N7PcpIlN08QP/5tbyoD/K5arPjGcFG/lc3h1qbimwz4XzB1wcGto2kGTQWx3vRd4FYBFeqZD9yCaYygmogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870153; c=relaxed/simple;
	bh=/V4qydBMPSM+qqoS9VDNLqSWBi+vTk7nzssfgDPjPqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4sA7qqb4XouZYB9IttwpeHDbwlZIo/aVCufHHvxi+ikqfGluQDI0nLv4uFxZBK6gHxehqlegjmfENct4/EPDxpPTi9KG+EWO2wj3xVDDt0dXn8eznBKtEc9S3i/Zp69s6SXKVT8rEuvbw7fdNcm0UJW45YIL4VnVgvADDsGINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIaxZeQF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8fa2ca5b1so2877219a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725870151; x=1726474951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEQByQyfl9VluO8qkndWzBDGLo0rdEsiighFqw9cCSA=;
        b=eIaxZeQFw+hvh7hL8p6Dy1cHwjxauvtIKjEvlrtla3Vhv2d+mwR8A+bq+dQ9jQw8BQ
         uvvLtQBQ5hMh87ui/93q7ah0RA+CwCL8A6cR2K35XoWTe/L7BbfdjuOBltSTAX3YyIXl
         lNOLnFu8fnEJS8+s2HGgRbuSPFyRu1NrniqV+zYBW1EZmI9yr8ybew8UcIV6p2CnD86C
         n6fDrCGiqL+tmvPm2hIPg9MHKTK0tAMRb6CkP11LE2ciatb2TaPFHerhc2ILfyANJ+vY
         O1zpW0eFYx7ORE0+1Ucs3l5d84DYGjikCmLBXiXHFKVjsbi3ga/hIBFbgippTkgzn6Aj
         9JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870151; x=1726474951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEQByQyfl9VluO8qkndWzBDGLo0rdEsiighFqw9cCSA=;
        b=GAWdZzbu0viX6lhLJUCDJjaSCL43hv8W1C8y7W7aXZTXFzcaDqqq36Ogr2IdylAR5B
         XSnmYblqBjaeyHD03uG4dtamwfSY/THSxa69MWi3p/CvSclwqST8KnX+O3hIDJD6OVA7
         8yAeVNxQBC+MoQ7mzvelwvX5w8oaLhpq+AuX0bT0Na9kBLBkDW9E/fcLuy/FAj28ZkJy
         lNs3qVa6VqZZ3HQo0h8fFM92/G4vfMvZ4ZBi1jngeeN9lnFUqnGGm2adcUBCgyy21TG4
         LD256J3t+LszO8uyCzBtL1MYq54F25yObowDo+s8UKDC1tYwnsSFh43XMEr922h5mbG4
         dKJw==
X-Forwarded-Encrypted: i=1; AJvYcCUOZV8WNAWPKOQRFXMu4+QZJBA/gyPN6MpGJvuEIDQ4eq0+Q7LKOlYuYrCjZNUA7t+OHcwNlI8jLQSu5dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw45oi1chq7vAOeKfy4KUHH5j7m5ABEj8d5uqP2Dfu2uNZojPw
	UR7l8e9Xjh3aeLHp+RgSfXkJaM+dwS8KcBXa0LsaHgvxN4ITKPPeb5s77MEIw4sqP6pFh8JKxkK
	6uUXCnzGe9is1MfzwE21+lUH5Ke4=
X-Google-Smtp-Source: AGHT+IGML/D1MIgs1YGLWvOaVA6MYQFn23lROBT43rj2X5ygBWRPiknmmT+ZUwXrrBaeIW24taAdh6UmxIhRwyC6wy0=
X-Received: by 2002:a17:90b:2707:b0:2d8:89ad:a67e with SMTP id
 98e67ed59e1d1-2dad4dde298mr11600582a91.1.1725870150876; Mon, 09 Sep 2024
 01:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903013625.1658825-1-linchengming884@gmail.com>
 <20240903013625.1658825-3-linchengming884@gmail.com> <20240906170439.286e6c55@xps-13>
In-Reply-To: <20240906170439.286e6c55@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 9 Sep 2024 16:20:09 +0800
Message-ID: <CAAyq3SbOR2-_RGEk7dfgU1Lgu3mgKqdmUkmhGw3eS9cTroo27Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mtd: spinand: macronix: Flag parts needing
 explicit plane select
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=88=
6=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Cheng Ming,
>
> linchengming884@gmail.com wrote on Tue,  3 Sep 2024 09:36:25 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Macronix serial NAND flash with a two-plane structure requires
> > insertion of the Plane Select bit into the column address during
> > the write_to_cache operation.
> >
> > Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of
> > the Plane Select bit into the column address is required during
> > the read_from_cache operation.
>
> I tried to apply this patch but it conflicts with the spi-nand
> continuous read series changes in the macronix driver. Would you mind
> rebasing and fixing the conflicts (it's just handling correctly the
> new flags)?

Sure, I will rebase the patches and resolve the conflicts.

>
> If you do that early next week I'll merge them right away (please
> resend the two patches).
>
> Thanks and sorry for the inconvenience!
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

