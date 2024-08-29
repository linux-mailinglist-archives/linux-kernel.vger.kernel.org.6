Return-Path: <linux-kernel+bounces-307506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE836964E46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DC21F2272C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9441B81DF;
	Thu, 29 Aug 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KQQQFF89"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3541B0120
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957950; cv=none; b=T8t//vPbblCur2kEakw/akTWuYIt2N2fTbnOxkuRMiS7OiOWNc16IO2zrzjehahB7oOuM0UBFoHblpevf0Fni+NHk3+bndnQH1plaj6jIlBI1kxDUE2mN4180/ba0hIJcXLiAI9Kzxy8x/769E6k0YyDDk4czUagBWJCDJ3GqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957950; c=relaxed/simple;
	bh=8944gwBBDCIPhxVQl1VCWvslS12wnEJH+5faN1eQ4s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7nfraTisEPhRyMWOZ1WMGjGRNxG/S3+TJY1UcLzssAtFA5vzYiMQ1UbwooL7it42rftUDr5A4cc92luCAEK6DdRIf7UkV5AbR8ZmWWyfmzM53NPiP/lczn7NW32fidMnA4INumawEFvI64rbQMdHVQTbV/spvlCwmYOput6u8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KQQQFF89; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8696e9bd24so132391466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724957947; x=1725562747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PRZBUt1W8DCJ1jHrr+gnsMYGeF53sTiXJ23wwVYpYOg=;
        b=KQQQFF89WUQ5UNMw3Fgn+Fp5Tqp5R+moQ1r4dSTEGjLnR527XcdNW9RV1vGaRSJ2xl
         LPITw4fSJXvxbODV+QPd3DOW7qS0VWdzXDfRQrI1h8uPvqvqEDx3jgkO1MbGFrlv7eAk
         IFBaWZwzIaiBEPaFFNkpx58XM3KwQAs2JP8D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957947; x=1725562747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRZBUt1W8DCJ1jHrr+gnsMYGeF53sTiXJ23wwVYpYOg=;
        b=a7FoPUDgwmINsTELAiNFLDU/KKdDUWRetkaRERCZi0XlTGOMYHTNX1igUki5MBC3Jh
         W+/iXuoZOGFxS2lCJKU8UdL28r2ea+qfpJBL1cVi1ms8EZgWvu16Tu02izgduKBtiIqF
         oMtPVL28TuHZO+gMSVujBNFoWYAcJlWAVyyQmjBieVuEkCejjrkVgMZiUo0elmB+e3ui
         nHJ1y+sKfy6SvkAPH+/50cP4QJGaJyUdrYeZ7Pz0QmkjsNSmYzhj0mH4i+LtJHqUa590
         bwdDUWb+NNSIXZE5cUQgTjIvaB1xvrzzsZcznjSgezlemov6F+OGzE8CcWh79LwnyHdA
         l8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXnjGlFo2B6wK16fO81YMCCivdqHDo9jtCXjaM4bA8Vhg/+AGFtVgnoheY4nbmU8kWUduhxSFYt9QVmm+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwymHJb+Kw9ZuCkrhcX/cm5Wb1zCbBDXihjLrlfjisife73xtyA
	Y/1Sll/cgKHdbjxlYKB/AEZhCw3yabM+Vzgp1wrUdYUuTU3Fo4GEt1jdUHgEeHRC5ecDHeheSz+
	MyYNNtKpxuEGg/NFdLeJRhZYKlT8PWipMB1G2UQ==
X-Google-Smtp-Source: AGHT+IE1lSs8AeBnJcwLSsDPcuMKigE0iJFh6T8NMjRqEvSK/A7qrA5InXsUBFZKfmJ/zOeVCOtgTcZxcnE5fm4gz4w=
X-Received: by 2002:a17:907:9708:b0:a80:7ce0:8b2a with SMTP id
 a640c23a62f3a-a897f84d44cmr302438566b.19.1724957947326; Thu, 29 Aug 2024
 11:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
 <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
 <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com> <CAEivzxd1NtpY_GNnN2=bzwoejn7uUK6Quj_f0_LnnJTBxkE8zQ@mail.gmail.com>
In-Reply-To: <CAEivzxd1NtpY_GNnN2=bzwoejn7uUK6Quj_f0_LnnJTBxkE8zQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 20:58:55 +0200
Message-ID: <CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: Christian Brauner <brauner@kernel.org>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 19:41, Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:

> Let's think about it a bit more and if you confirm that we want to go
> this way, then I'll rework my patches.

And ACK from Christian would be good.

I don't see why this would be a radical change: idmapping changes the
meaning of fsuid/fsgid, so we now can't send those to the server in
the non-create case.  The only thing that changes is that an "invalid
ID" value is introduced into the protocol.  Probably makes sense to
explicitly define this valiue in <uapi/linux/fuse.h>.

Thanks,
Miklos

