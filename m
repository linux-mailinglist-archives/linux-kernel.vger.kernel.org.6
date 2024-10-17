Return-Path: <linux-kernel+bounces-369388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B359A1CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B321C2700E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267E1D2F6E;
	Thu, 17 Oct 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVAOZJQc"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB781C1AB1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152605; cv=none; b=IZgCuaEikI93XgeLXXiumbs1iPtP44+FZNuovJvM1rOhX/NQM4c9TjC0bUf3f5eZ/O/bRTlrixVzAhlVnMm3xDODp1H6iw7ZJ87nfvJjxU5FWX1R8ooLxRnOXhwN6+4BX/8PmS7AomWZT/zRNLfRiW5T43ltoUjTkE2J427TcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152605; c=relaxed/simple;
	bh=n8c5tm6n2wtjd6JrCMcUul2FDzsI/PMwtNrX3yN5czk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVwG42J/bmdzdiAl7I4brI9Byd7Ivs2X704uA0UOCf4zb4NvrqWeeVs/DWjaMtfw6UihyrV6R1T5oXWxM//izfMgl757VIK+OzUkqwpLvQ+O31wr7sYt6Oq3TmUYXBTLgtsq3s4viXaKL5c6zPJPovemlbWHZZFbSfmB02kHRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVAOZJQc; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fb56d2fb2so237208241.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152601; x=1729757401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8c5tm6n2wtjd6JrCMcUul2FDzsI/PMwtNrX3yN5czk=;
        b=RVAOZJQcGxHdP3AX922xcT2u5eN4QpbGn0pDmwqYtMGcsCs3jmoQGfTChiWjWkJdtr
         tO89GVG5IM5oZiEDzwbus9QgdwvwT7HF7OA1ELJ6JhRdbq6uJUDSRJk6dRijcXtHYaz8
         9MyEixduc0ONPg5qmNLWw8Efkwlo7QRko3bMHRylGoEPhFhMC4x1xYIlkwObKjajVpsq
         CZdaTfZDXrPVRBMduhF7LDOZEmbUOmSa7Q0ASpsYpKErSFHj4Abq/iYLdKUE+Fgp5pRv
         gnL+gLgvsnyFvXWecLMRatHVBmSTxjiH44gYwCzG+26vyrYPEaUhV89DR7RtxPswBer8
         6/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152601; x=1729757401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8c5tm6n2wtjd6JrCMcUul2FDzsI/PMwtNrX3yN5czk=;
        b=Mb4UlVowaJvOuX0UASVq5HU/zTO4+4FJN1bz3+sjzS2ZiKLznmwQB9W8G/oZvMlI/F
         q5B/DHgdijAW0dOfi5CetjSjytmWB4HI8IPnWLuukAepR5WPfRmH+7w+aoARcaI+g5NB
         8c7g9fNaT5DfJWz+lAGBeBMBeoX/zbl+y3HSjMWI44hbYpO+vzmmDsZJmEnNKrC3qpFL
         MnoMps914ubJeOmnsbvD6cH9t2hF2b6Ouved+KYNOp8SgA4YVHGc/YEpUGb7GYApq9WP
         Wc8MVsePgnus6aPJJI0QjVufNmu4Tmxsasl5mOw25rUnkrMMPO418GcjScebwyZA1sjP
         EpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCUDEIHeuZtskJXDQHh+JoLb+RwWqYvOFF4fxg05KGwgPo2qRM2DeXgyjwcCauJgEvEJ1vcQvZ//TDHc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFh+IgdzOjeHa2yNRASTWqJPu1YBSNWI4hbOQDUS9FAZZffTtm
	MSApXgCY7VFaB5ycEYwQbdYbjJvrZFhnoDWFKtt0GWg1W93JXS7z2hJ/Rd3SRi7m5V5kMTgUgzx
	jyYAcYPRorOOWGYvnFqpSSqvBDe0=
X-Google-Smtp-Source: AGHT+IGTUtrvSTVPF7UC5Y2BiQUaC3VS/XZL2v9NMKQB4jPDSExZQ2AU04U5a7BbGXBYtBk7rmGLfoW4IAtl9cGzgTA=
X-Received: by 2002:a05:6102:54a5:b0:4a5:6f41:211d with SMTP id
 ada2fe7eead31-4a5b5a6fddcmr6397469137.24.1729152601057; Thu, 17 Oct 2024
 01:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017074346.35284-1-21cnbao@gmail.com> <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
 <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
In-Reply-To: <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 17 Oct 2024 21:09:48 +1300
Message-ID: <CAGsJ_4yLK3sCeJNdZRKxD2tSdMVFRBp9eq-1mAMu7UT=gqpA_Q@mail.gmail.com>
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org, 
	huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:00=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/10/17 15:58, Gao Xiang wrote:
> > Hi Barry,
> >
> > On 2024/10/17 15:43, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> When a folio has never been zero-filled, mark it as mappedtodisk
> >> to allow other software components to recognize and utilize the
> >> flag.
> >>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >
> > Thanks for this!
> >
> > It looks good to me as an improvement as long as PG_mappedtodisk
> > is long-term lived and useful to users.
> >
> > Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>

thanks!

> BTW, I wonder if iomap supports this since uncompressed EROFS
> relies on iomap paths...

In the core layer, I only see fs/buffer.c's block_read_full_folio()
and fs/mpage.c's mpage_readahead() and mpage_readahead()
supporting this. I haven't found any code in iomap that sets the
flag.

I guess erofs doesn't call the above functions for non-compressed
files?

>
> Thanks,
> Gao Xiang

Barry

