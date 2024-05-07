Return-Path: <linux-kernel+bounces-170625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CF8BD9DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CB0283AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39A3FB2F;
	Tue,  7 May 2024 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ptdX8RKN"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EBB642
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053857; cv=none; b=FVeWRXuaLdLXOhCtXC5Axk9WJHtg8pAOCqys6Z+se0Zkxjh5u1Au7E5me/ppk8ptPafi5rmoU7z9QMwAGc5xEx7U+kItktXX0CYLniz+tPj9eXWqxdhq4rECBhPhbJG6UZNnuWdN+WcLCp+PW/m0Mo1hFQEErYwhgB7rZ+NuFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053857; c=relaxed/simple;
	bh=xBh2sNvnxivKaTg/6xMQ1vH+J1//OY69+3MunvpWfkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI7hwkTzcoDFxvdEfSNIS9nyLcVvugpFeN8yRAr3W+EQtgAj5z0UCffbWDKnP2VaPT/Lio090Jxeg+5CuaFlUe7uZghJ4MXitOw0i/VwQE5/1a5o+p7r8raRDkqdA85WKTOFJxXj47FlXGrv790ovIjoAJRzOv2CtQDswJX2WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptdX8RKN; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7f3faea0ce0so688562241.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 20:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715053855; x=1715658655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBh2sNvnxivKaTg/6xMQ1vH+J1//OY69+3MunvpWfkA=;
        b=ptdX8RKNsIEtA2+LJdEg4nHx0cwyCZYK+cmEbhfm0FtlT70eXHBH2twdTrjV5sI+7O
         UB0fP0lHQ5yJzo0DAa1vp2aQOKwGQXH+PftaSUicSChyTBeoJV4HPgrAC1TqpPcx6PAP
         VAUkaneqcQB39U0eQV1BykayNazyFYa0tz9rkfDLI2fihdi1N6wVwR0wmdo9blF4LSUk
         XpBO0YtUVJSOx13ulYV+dGghUoXfQczugh/corf+KVurVTQqF+JAKGSf/Z5BR0vQe8K5
         jbjyqD0Q+1FLtPcr9OhYjheK4bdqX8kTjyfm9gtHUY3G1YyyTFzpSO7PRx35fV+AitQG
         ZVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715053855; x=1715658655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBh2sNvnxivKaTg/6xMQ1vH+J1//OY69+3MunvpWfkA=;
        b=U0++E3AcSE1wBWSPsWQn68vCM7PAaDCL8BVEbGVDfmw/Y55GwFhrrgqjOECzEUXUlE
         S7EFwIgL091uDo7E+Du65pYc5r1aborIext7pzGhq0G51pq41FvoFldezsnsO7q95e8E
         LwWhJH2/TBtDjHX0fH5V1ArKE4hW4JoeSv0uIfN2EzZQQ0lL1IZRDssEz98tPsBth/E4
         4VFoBzXFciJvznLo+BFSDiOEkClud/lBip1/XXwxoA2nrYMHdA8PvJSAU4cdIU8t6sku
         QCUTw1AFxu+9aU4FETH3nbK9yu9mxlMTfNrgFJLvfJvmj1oRvP1Zi+9xGOJS46UYdI/D
         ry6A==
X-Forwarded-Encrypted: i=1; AJvYcCWb3+EpkD6FSyX5lhlxDJ53Tm67VmLK01J+FcaqjseOhw0PXNYN5St/3X8EtE9VWDkLuYEYTDbaXYMSxkSVR0MuEqmhN06n583uSu3H
X-Gm-Message-State: AOJu0YzHGGHjWL5bu6gNbOFN674kCc2A50//MUMECutzYII47fB/dRwL
	5It/BIkvDC6iO5EketkgnXJ7pXq5BX+7FYFnYoUik6M7/77KP+xQKB63PnAeRtNdP871bLvOL5P
	fgzZ7ue5iwud3Pog8Dly2YYzF6CyzTrCXUrZX
X-Google-Smtp-Source: AGHT+IFb85IXhA5rUrJO0F2AvjpnYaPXIbrqw6PUpjJNLcgK3c9NShQZyPtn7iG7PO0YAoBSgrPP6/195qfMiOM9fxA=
X-Received: by 2002:a05:6102:244e:b0:47f:1f49:45d1 with SMTP id
 g14-20020a056102244e00b0047f1f4945d1mr4094840vss.17.1715053855075; Mon, 06
 May 2024 20:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com>
In-Reply-To: <20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 6 May 2024 20:50:43 -0700
Message-ID: <CAFhGd8oUjT3G7hvweWTtd3RLdQMBSjjVS6iHModQPf5VqU039w@mail.gmail.com>
Subject: Re: [PATCH] block/ioctl: use overflow helper for blkpg_partition fields
To: Jens Axboe <axboe@kernel.dk>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:10=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
..
>
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang; It being re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
>
> Let's use check_add_overflow to check for overflow between p.start and
> p.length, as this method won't trigger a UBSAN splat.

Whoops, I got this wrong. The third argument is where the result of
the summation is stored. In an effort not to use a throwaway variable
during testing I just used the address of p.start, this is clearly
wrong. I've changed my approach in [v2].

[v2]: https://lore.kernel.org/all/20240507-b4-sio-block-ioctl-v2-1-e11113ae=
b10f@google.com/


Thanks
Justin

