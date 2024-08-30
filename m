Return-Path: <linux-kernel+bounces-308896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39E966364
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A039284F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8CD191F65;
	Fri, 30 Aug 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gBs1Lhfs"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E318EFDE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025766; cv=none; b=SwIENmQiKJzdYVrOGrbB1prmzP+OgeugzS9ysI0i6NUi30i8I3vwCf/uPO0Ly8671s6kCg2xIpJN7f7zJtT9t1gZbYyVdX0UZrJCeW6kmPpEteva6DhNcmgb/HsItzN7k6NYANdOFItM4Hj/EH2LyrYl1FX0aaUhlLN5P0GW+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025766; c=relaxed/simple;
	bh=WhYAWmuPfLB9PmCrki5QGrdb0P+ECZUwzsPzbKY/HTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=or9FvsspTHbvMQZMLqStScHNXEypa62ZVzdggYatuUMSerkGC+KxFbQcU/zrV2pHy8T8liz+NV/3uTcd1GbcqCh+nK1Uf4TNQB2ZZp1pLJph6LzRgDt0abq79e2u3yvKqwiqYg6vBVxZM+LHxf4KAJO8dFqtdgkTZhcCXwf93kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gBs1Lhfs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so1919531e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725025763; x=1725630563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhYAWmuPfLB9PmCrki5QGrdb0P+ECZUwzsPzbKY/HTc=;
        b=gBs1LhfshF/wrp8ofKgQFC6bLyjONGrzAVAMfh9VaUKC2OfSLT02K0BKHsLKcTT3lt
         QWJrc3qrVCkvHtYpW6+ZckR7fn81kL5GKfnlGAWyMd6Bip5jJ7UR5L94aAsH+zSp5yBu
         4kma/0wEjUpHipHkaMO6UKQSbOeQ/dPUECmbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025763; x=1725630563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhYAWmuPfLB9PmCrki5QGrdb0P+ECZUwzsPzbKY/HTc=;
        b=WZ9Z32IQbBuWDL1JjobVLGi9oy4LV4CescSZqzzx8yvC/6fPOLVJK8a2Uh3vrnUkc7
         IuWxdzfjVrsxSJUkPbSU3psdKfSW2g7dkJ6YY8ZcgIptNsoELPrwAm5WBWDJXEvuSLLd
         nSGad9+pLVm7y+LjbX/JFgaO8lJ5aeoCA/FM2Atvj34Elqfd5Azrw3FI74sFLL46X5Uu
         o3StLRvDMa0kLbiidCCwFH89DkNFxbzVHnLyfW+9GUr+dIcuMosPzQTN8zdmulG6v3ex
         IBBbi0akSR5T40C1axlvHCuXQRRcAsyn0FUHdk/ccURH7bC8FKnYev3iTWG+4QyypZLC
         QDtA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7DFouXBGWoZ6oFRHGUVN7pLd7u9/B8GnDhAFmP2SkpUYy7M8f468tDznuG2yGwGJM016G6ZNKsprp7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFcOo6XiwUcVPjV5ikXV9FrYAjrRcse/STqKvU/PxkXQK3Kw5
	CCBcNqvR1MxFt5Hu1GQj9N2mJof66aEXVGwLzfhi8F2Zn/xnKLBtA9HPLt2C4/8kuTaWNrZpO3y
	0A4xybG9OLwaxmpjwsO6OnxCnP8gFQSjA4Iak+SZagS5AOVW1
X-Google-Smtp-Source: AGHT+IEYlE1kO529OqCb/ytUCO+2Rn5C5BH7HWGq3NbEl9O6Qe0vW+2kBduHAZgJUDbzAqocL3b6DkJF0W+5GkYMnGU=
X-Received: by 2002:a05:6512:b0e:b0:52e:be1f:bf7f with SMTP id
 2adb3069b0e04-53546b2dfc1mr1557562e87.27.1725025762474; Fri, 30 Aug 2024
 06:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
 <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
 <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com>
 <CAEivzxd1NtpY_GNnN2=bzwoejn7uUK6Quj_f0_LnnJTBxkE8zQ@mail.gmail.com>
 <CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com> <20240830-quantenphysik-kraulen-6ca8cfcaed70@brauner>
In-Reply-To: <20240830-quantenphysik-kraulen-6ca8cfcaed70@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Aug 2024 15:49:11 +0200
Message-ID: <CAJfpegvFdGWuBnJzM9R_R1vrZbVE=8CcnEq4ZLmR5V6iR0vROg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, mszeredi@redhat.com, 
	stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 12:57, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 08:58:55PM GMT, Miklos Szeredi wrote:
> > On Thu, 29 Aug 2024 at 19:41, Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > > Let's think about it a bit more and if you confirm that we want to go
> > > this way, then I'll rework my patches.
> >
> > And ACK from Christian would be good.
>
> Yeah, that all sounds good to me. I think Alex just followed the
> cephfs precedent.

Okay, so please drop this patchset from your tree, then I'll have a
chance to review when Alex resends it.

Thanks,
Miklos

