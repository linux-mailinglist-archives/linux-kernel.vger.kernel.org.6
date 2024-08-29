Return-Path: <linux-kernel+bounces-307398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12DC964D01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE9F1F22565
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81511B78E7;
	Thu, 29 Aug 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KVnIGIqd"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7C1B1D61
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953265; cv=none; b=TIX/ihQSFMBbqqxF9RWUYQOs9lt6B7FFdV0TNLsLpcYybPu7yx044o+KGABo2iDMeGF0Y1nzl4zvpvZZTdef6i954Us5vXt1xTpCbVVqPUxOuntCdAj5lYUpKSe18vZxU9dnBlyHKXM7QTG5Lk9I8qns2+5MlxrAWZVgDX0Yr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953265; c=relaxed/simple;
	bh=d1+09F1VqLgUq9L71D0Wm+o4VDHFGEIhQd2Cm2ahZoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F70lwaTC0b8oUz1Iy5oTZ1P0PVvKOmeM1yY6ao7BKkVEl/dQMziqtmhk/Qw9+kPytx264lYPep0nhVb2zCKFbElI6WHK4Jx8XT8rWyExDmX9m/a7sjj635oZpK0vsc/BCu16cUnBkFB12AMZ/SzNXp+hHhts+iHRxaCB1DfU+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KVnIGIqd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 391953F297
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724953260;
	bh=8VpfNl507a5cAmG1gfcOvi2W78oizIQn/0rbtUVSxZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KVnIGIqdqwEGIP2JVO+nduEaY/1V76OdcgrQSiF9uPT02hkTJRDHkph/8eUbUPXp/
	 LyT94l1ktgRTIiPkoEh6XGOPBFftkP27+TuGRluw7yL9ZoB7lo56rcIh2peRCOkllv
	 K8EHE+q+OEsiScJWQfhQHwEiuJQNkoPVg7czwg+POZyPlogNya2nQNuMztPvh4JKDf
	 grJ+WumtO9tuvXUBA6M8oNFi6PWOmmF+OSvhbXU8UULpiH0/R/c7SW1bgRG5OMfFNb
	 030XYhBaAzu8x1SwEdhrP2aqdxCLSbiylfeJsMVkwlYJTGCT7+VBlX5KYa/m1gjHXA
	 TmioEhzwlQc8w==
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4fcf8ce00f5so306430e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724953259; x=1725558059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VpfNl507a5cAmG1gfcOvi2W78oizIQn/0rbtUVSxZU=;
        b=jNavtS3y1uoHH/05OHRCEEivNbg0CzEzAUAN8updMyacRCCfWUlGgH0PcmguvwvGo2
         aPxxjMKqiKjO1X471SdsU3FRD2w7DkrTJek/4ANE8xkin9Qdfl+BcYT1P16PDibTS7XE
         iTBe2q4Ze5gjiWkqAfDu9RaqCRwgm5oLhIefq2v7pDUpseK2UcbhWuqXxhrVGheSyWF8
         neoFDaTKGuusm5zfp2rnHYopqv/EmVwPLQhii7iRIro0fBEfp6LaNNAGWnVBFuVV6lQt
         UI6c0APRRMbOzRZGHKRDK2FvKs4ee/MabuoSiz5WOtC0m4OKUrn8aGu6e1+00jOgkLkx
         bA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXik6J7F/5g4hbhekjQwtyO1pRm930MlOJvPcDpOt6CsprsOyqBgftmLV2yJguw0aXn3WWnFgB4oHC7th4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKKAIEIUU4rQik84JCAnGXlYXdEOYtye6ZJshHUVLc8cpY5Jd
	z7wmwftu2MTqIDyxaCgqY/pQier32E/PRGIMqof/hYquoBFxLCM5X4HjRjNl0AJu7rGuK6FB0TZ
	zncjwBohs+b4ZkLSjbbSpgVHY2xWvuJvLWXuxipelOLO3T15FyuZoYOJa6DYpshY+/ZP/TasDCx
	gsqhWjnNzkavqjUW4Oi5SlUcIDCsrmi73UQZhG7VC0T3zv7D6Wl0BI
X-Received: by 2002:a05:6122:328f:b0:4f5:14f9:e12c with SMTP id 71dfb90a1353d-4fff16ee678mr4117632e0c.13.1724953259204;
        Thu, 29 Aug 2024 10:40:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ1F0/j9yBCneYHZtBosxIXUnU0cLksZ3j6oOroUSkhdzOBFMRXvz12hqx9HP3b8FOqnWVlBkvowzAt67z/LI=
X-Received: by 2002:a05:6122:328f:b0:4f5:14f9:e12c with SMTP id
 71dfb90a1353d-4fff16ee678mr4117611e0c.13.1724953258888; Thu, 29 Aug 2024
 10:40:58 -0700 (PDT)
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
 <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com> <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com>
In-Reply-To: <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Aug 2024 19:40:48 +0200
Message-ID: <CAEivzxd1NtpY_GNnN2=bzwoejn7uUK6Quj_f0_LnnJTBxkE8zQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:05=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 29 Aug 2024 at 16:39, Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
>
> > So, your point is to set uid/gid to -1 for FUSE_{READ,WRITE,LOOKUP,RELE=
ASE,...}?
>
> Yes.  Not sure what will happen with those servers that check
> permissions based on these values, but my guess is it's still better
> than sending the unmapped value.

That's an interesting and a bit unexpected proposal. I have not
considered that option before,
because it feels like a bit of a radical change in the fuse protocol semant=
ic,
while I was trying to be extremely careful and not make a revolution
in stable fuse protocol and code ;-)

We even have old commit:
c9582eb0ff7 ("fuse: Fail all requests with invalid uids or gids")
https://github.com/torvalds/linux/commit/c9582eb0ff7d2b560be60eafab29183882=
cdc82b

At the same time, if *you* propose that, I can't find a single word
against that. :)

You idea also solves problem with ->rename operation:
https://lore.kernel.org/all/20240815092429.103356-10-aleksandr.mikhalitsyn@=
canonical.com/

because if we just reuse existing fuse header fields and remap values
in them then we don't need
any extension for FUSE_RENAME2.

Let's think about it a bit more and if you confirm that we want to go
this way, then I'll rework my patches.

Kind regards,
Alex

>
> Thanks,
> Miklos

