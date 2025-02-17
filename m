Return-Path: <linux-kernel+bounces-517672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A551FA3843D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CF5188611D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9821B91D;
	Mon, 17 Feb 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4vPYzpR"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1721B1B4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797928; cv=none; b=f6io/6DoN9rfr8y7S6q+rhqDfkpCyD8BNNXvSCDSC4D90oEVEWSj2yQwKiKqmRzDqMwnVeZSzD1dAgOepSD1Eib/7WCsv0Ocn9wG9bDAnBeRmCwY/lPGV8MOG1o/BaOiKlz/CKmu96KwDtu1k1n0W+HBKTwAJoNhWAOrYq+6wpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797928; c=relaxed/simple;
	bh=MRAFcY9ayAng/g+VDNI+8agAhkl6MiiLqZ85TtSKkcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu8zDDxwo2JNJuFgUdMmIN7UWWpgktbWYdEyesuR5FhbHlT91iJHWTq3D/j+n/WsZqEwDTvY4RKMNvkP73MYshAMQZmBOrxg01gKm2THywLQDMfx0u/KkykGDEHvB+57IP2IWTr+l7KL3G9QCux1EHFGgK6OXTI8eOlNEl9WLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4vPYzpR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so6488615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739797925; x=1740402725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbv6tZxsXHhtGn9KFBS5fucmEZ2CZu7fW3YyX0NKPZI=;
        b=P4vPYzpRcyJUAiZpIAmVqN3xVsfZCpjijIZ72SVZCjey5SN5STX8gX/I94bhtrDmMY
         7aMlL9igyXmu9wQn7M+xfmZ/M5OGfSi7RaqTvFTIkstXiyB7qPbriCg+JQPJ7EZMgF1l
         cMLHOqUe+w8N+91SeCfvIA6ZDnR8yRWwVfP9/bNvYm9LsjCnkQWM+cwNjXMajs3gz0ip
         1BYXCQUO/K5cmF5v2YgEg4kozbd83BXmQ58Oc1Yl9bLXuMMjcHeg0MKTE7jvdI3lazER
         yRoFHZ6gLle7WYjwUaxlq0SwEPvX0RLADlmSx83GiyUuAWssbTvOokN50yp1zN2Fwslj
         W2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797925; x=1740402725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbv6tZxsXHhtGn9KFBS5fucmEZ2CZu7fW3YyX0NKPZI=;
        b=C9hl6HZHLQBVMx+E5lViuI1Vt17ya4sLgezV/BY3Quwr9HMH75UqQviGzuxzmiGmVN
         imr0ExyE1ONfOEXi1LcIfDtWs3qBucWTI+6E8NkKtcPUryVRPVLCDj2RSJS6UZ1mCysc
         9hnUYQA6unOt0m1aRXVyh2TwS3NYHfBEfpkAKCurBU7Yw41MNCams2fCRXjOOCK7aROI
         HwgMgGUoQT48EiNeh0BagpCLVtINkzb75wT0KEnUFZfgLDJf/EiDBiUmyJceFeLoxNuV
         a3WmWAZP3tINFBq8TPQg3mPrKUSmMxgsm5y1bUOKx5jWQbOcyjk7SG/hAszKyAxtbJYR
         y2xw==
X-Forwarded-Encrypted: i=1; AJvYcCU7add/Icrd2OWi87Wfc0qqq26tcIFFPaHllSm77kMvKakxeW9Evi9Plqb01lW+4QSkhDP7EEJcU+6K2c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMN4CfAwHX5Zflas9ipz5KU3z7+zZpyD+sjHV6r3rschabO21z
	YNv3pMFHT/7v2xyNK01K0MFNYq/0IqjgUehVwjp3K7JDLqGNBAE27KSQGA==
X-Gm-Gg: ASbGnctyrcGbWgJfav8dRSZGUr7PCtFj6Tl9w6NUZB4uDe8ZHC9bmjQR6Sq6dlwyyhe
	4m3XEghr08jDeY9158PQQtUeWDDZH5PkFlKR3/kzbqcSiptWT/UV8dBQjxeDgyiQ72KJNj6s7mq
	ZicKZBLVWa4Se2P+iT+/qi2XGSXCE4AyeleOEr+6mtRUfnCoQuIy3NPb0/TOvovG4S+JkkJT+qq
	9OwNTESS0/qRBw4QvlM+dn4ug4DkG044IAaEJgupZGPd09u0Gpbo6fGF5AVF/orTRB0EhLQ5Kni
	2TMHSMzsIdOamLxi3NcammAXIUhhV70d1W40M+yZbbteu2r8iCnwjA==
X-Google-Smtp-Source: AGHT+IGI8Y+1gHpNEIL5sYVZymnBYx2kGRoduPMaxMSQCJyc4mjJ84MG14TVAegnNK2lJjDu/Lbf2Q==
X-Received: by 2002:a5d:59a7:0:b0:38f:3224:6615 with SMTP id ffacd0b85a97d-38f33f374bcmr8372027f8f.7.1739797924909;
        Mon, 17 Feb 2025 05:12:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm12639181f8f.91.2025.02.17.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:12:04 -0800 (PST)
Date: Mon, 17 Feb 2025 13:12:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Carlos
 Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-riscv@lists.infradead.org
Subject: Re: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x'
 is never less than zero.
Message-ID: <20250217131203.2657cc4b@pumpkin>
In-Reply-To: <a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
References: <202502171326.j4Xd3I0j-lkp@intel.com>
	<20250217092445.GA29568@lst.de>
	<a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 13:06:49 +0100
Alexandre Ghiti <alex@ghiti.fr> wrote:

> Hi Christoph,
>=20
> On 17/02/2025 10:24, Christoph Hellwig wrote:
> > On Mon, Feb 17, 2025 at 01:53:08PM +0800, kernel test robot wrote: =20
> >> New smatch warnings:
> >> fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is neve=
r less than zero. =20
> > Looks like this is an issue in the riscv virt_to_page implementation
> > which also shows up in various other places.  Any chance this could get
> > fixed in the riscv code? =20
>=20
>=20
> To me, the only test that could give rise to this warning is the last=20
> part of:
>=20
> #define is_linear_mapping(x) \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((x) >=3D PAGE_OFFSET && (!IS=
_ENABLED(CONFIG_64BIT) || (x) <=20
> PAGE_OFFSET + KERN_VIRT_SIZE))
>=20
> But given that the config is a 32-bit config, it should not be evaluated=
=20
> at all.
>=20
> Could that be a false-positive and then an issue in smatch?

Why is smatch even looking.
The equivalent check in gcc has been moved to -W2 because of all false posi=
tives.

	David

