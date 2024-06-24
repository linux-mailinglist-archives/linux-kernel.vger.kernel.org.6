Return-Path: <linux-kernel+bounces-227746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C591562B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5934D1F21666
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1D19F482;
	Mon, 24 Jun 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m09CcqNY"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA4182B2;
	Mon, 24 Jun 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252206; cv=none; b=RM+a//4BYsS0hpAu4g5vDtH5V/bBHJuIUhnlt9Ue/+EICKQ9YVjuSq6vYxwhnKd5Olk+wtAFFuJJzJ0l5qtL1z9SvcI+hgLNWcgYZahgR+AF6lM6Mw0H0DF1/E4O3bweu941wuxvq8OdVY66uFUDT3HN113Vq2xqurIgJtbjGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252206; c=relaxed/simple;
	bh=asm52OWDftS+lyFr+LMKyFJAkBcFCq2hCyMjZAWHKIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4lFtyFVNz4c7+RuRUOPl/GbR9rfH2iZe7EQuaKezcgpX1u4Za/4dEBy9AyzbjcCMz6D+lX4mNTyd86m5TgICc8C2TC3RrgT1g5c5+KsIP/yMRmwRQwj49UW7H2ytcjmm/4zaoxYChLiDmwAruhYr9s9eU7RyhKFDcdlIv9PHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m09CcqNY; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4421cbba106so32618231cf.2;
        Mon, 24 Jun 2024 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252204; x=1719857004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pUaocMSsxJ5LjjEsnYP7jxj3QfqcMM8ZONVfrm8rtQ=;
        b=m09CcqNYsjUyz7H9BFlAW5xpr/3s6M5D9s6CqoRhR24FnACIchqQqDr1rdo4S8Xo20
         NnpOumunlOTalTlL9xNinR/A5/ckAUA7CkwKuBOpA1vU+vrLpXHFcoLCXyc6V7ufBfod
         chKL+VQM+fRgt/R5pN/leM/s5L+ejFJlsqkZhsbJevXeL/bUVwrykuSLCXIWCny1odSG
         yVDBWD5PDHjekg0hGYgNUggaIUrVKSaCn/8NisEsLlLW6riFcxMdpiHf1mGsc6jTOHV9
         p9XOC6tbnuyg03iVdlwia/yIB+E/nLvIib6TbPe2tSbiBCaV2dpxsUhZ/DPpp1zZ5tQJ
         WCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252204; x=1719857004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pUaocMSsxJ5LjjEsnYP7jxj3QfqcMM8ZONVfrm8rtQ=;
        b=TxjrL3w7twaJ8xAF1vjo464lSCsdcOvTQwCKGlBJKPNL//eaHsFkhEslqpqY2uANd6
         0JMIjSgYRGqK7WwsU689HM46AM+R8r36uO+3cHoWMzhVcQR7gBK7xE0dmXBoi9v2uOwK
         FsowZgLjT7bQAVFopSihzMNOVXTQQ9UZbf/OO97O0V2lYfqv+fNki9rt1JqsliDBIa1l
         udkjKzBDoHWK3TgYWqJzltuO2HtC1CEiXG/ERA4haE26HJ0iUQoGKW+o1afuVbUjCgt2
         0iZbRCCDXcrv5fc6rgwMhbv0jg8njOFSMuXEqmDHqlsFfC6ECjDx+A2q+WIdqBJw//NF
         JwQw==
X-Forwarded-Encrypted: i=1; AJvYcCWNb5L+b4+3u+3Y5T/YiipoisaVPHsVWY61uGHGHE6QNvDFnA4+kUGA7q6dASDBNGjnoSxg/bo8mlL9rimZZjoyG5/xx4NdTvvr+FMOhz+zLaxddOLrSXeedrI8CMX6HYOac4HDlvZ56A==
X-Gm-Message-State: AOJu0Yx4iVohA3Ja9XVmF6ieJCPws07PBPVwwjb7nD6sHWeZIkARPpsw
	khwT3P/Mlc5Vy3nX0kuiBMEkHYas1HoB9aq02CPlQSmDvPbigsnB5Sv5cEPU4EDjX7Hbf8l1J8A
	71GbQ6BQjAT5NuiOTgtEPy3xeNpY=
X-Google-Smtp-Source: AGHT+IFO8I58PN4h1470uYhz00UihsCRoEeapPW6BWGVinHzOdAIibcD2ehHGZtef6GQQE0Ko3zTuBjLkhxyvplJDvE=
X-Received: by 2002:a05:622a:553:b0:441:57ec:61e4 with SMTP id
 d75a77b69052e-444d9388193mr65550061cf.47.1719252203930; Mon, 24 Jun 2024
 11:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
 <ba9d41461f5d56947d7851473637722b@manjaro.org> <CABjd4YziNk1NJb6p+AxAVK0CR7igE3-6h-sN4MEWwyoW2qaKfw@mail.gmail.com>
In-Reply-To: <CABjd4YziNk1NJb6p+AxAVK0CR7igE3-6h-sN4MEWwyoW2qaKfw@mail.gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 24 Jun 2024 22:03:12 +0400
Message-ID: <CABjd4YzWc6GPkDAbVGLaBCHBX26m97Mf1YVKriMVJYX8iy0LYQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Delete the SoC variant dtsi for RK3399Pro
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 9:59=E2=80=AFPM Alexey Charkov <alchark@gmail.com> =
wrote:
>
> On Mon, Jun 24, 2024 at 9:55=E2=80=AFPM Dragan Simic <dsimic@manjaro.org>=
 wrote:
> >
> > Hello all,
> >
> > Just checking, are there any comments on this patch?  Is there somethin=
g
> > more I can do to have it accepted?
>
> Hi Dragan,
>
> Heiko has already applied it quietly a couple of days ago [1], and
> also merged the v5 thermal and OPP code that I rebased on top of this
> patch of yours.

Oops, that was about a different patch, sorry. But still thanks a lot
to Heiko and Dragan :)

Best regards,
Alexey

