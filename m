Return-Path: <linux-kernel+bounces-197717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D58D6E58
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3841F25D09
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5951134C4;
	Sat,  1 Jun 2024 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MogCg1sy"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABF12E55;
	Sat,  1 Jun 2024 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222591; cv=none; b=Sy1LtxjOkAUbGECxRM9HE1nn3olZ8Y0LaNlMUs+kDl7hQ9abLhH9MqvLZD+OKC5YJN04mkngWqjE+Ixvm8xvnV1H3bUP98ZCke34hR4HGVkwzHRtPuzUc/fxOiEja7O9M5kVWoyvTg372uYOXlciXzfZExyu7PCq9rv4CG5cKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222591; c=relaxed/simple;
	bh=rt2wx6NZb2NHXMBjUJJczmHoHOGfO0XkMtjoi+/dM58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhL9r70jDofinnEFSVJ01vBLt0gb93PTjCXYG4zfio2tnorncnmy2/46qKSVcq4oQibltkNdBspprLA9YLU8IRbgbNuOm7QT2+D2IyKmbsYu/tGP9TbUo8nmCgLLm8vwffC4wtfclVG4439s06N7+v6XXs3AN8stXLSyao5BxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MogCg1sy; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso23465551fa.0;
        Fri, 31 May 2024 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717222587; x=1717827387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z+zOfc3+Z4hyAcfzxNHQDfSITf3TFsblhocGpkJa60=;
        b=MogCg1syB2kZLCMBoFFqH6035Sm6AI0D7mQCvv47S9XHKRzPZ+GvYJ4pj4wR/3rmNn
         XscrrBVfo2q1r0vcYKxkRgylY4Cygu7SE98nNo4L/uzTc7zcKvKlM+SnujTSya1RBzpl
         THZBhB0RSZhr6TbFJDP5ZqdZXe1FtkGbb4dKu5abqgM91eRKelp0DLXccouZDI9tjmwO
         c0w1OxTL+KYjSRloespRB8ROeQRv/cNu62Tddl9qIeRPnlOOO15XcOZEJPQ8wQQ/hz6s
         vtndwMQ6Sj+gTYzWDFaagYlO0Fb46vicBi3oMgg8OXxgbqwTtaiLIfRo4D7ZOFqxjXUi
         AA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717222587; x=1717827387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z+zOfc3+Z4hyAcfzxNHQDfSITf3TFsblhocGpkJa60=;
        b=SjnYUnEte0Kfymb8kv2LxiNB09onsDB70AIdQIaUsxpPpEVYuvsw2yQh91vCum0ehF
         xLxOcFTVniei0rbpZvtqCnlZvMlVC+UZMtRhSst44MeRcy9S763faN+qp/J4/VEJTM3p
         zpup99QjRH5qFVlQ54Y9gm7qqC00s37Bl5jvjanPIM2GEoQTpLdipC8FGx+6tqQ60sPY
         pdWZm6knHZNR4Qn0xQn4cvG38g2yEmdjd31oVJirlelr1Pg+1fPrXOBsxlD+XC65ulm3
         dSEQ6v41lSAFEpTk1wm60o4Wx4iBohR/4c/K7l54/IAbWyRmGyWD0zOx1Y9pOUnc2mdJ
         1ZKg==
X-Forwarded-Encrypted: i=1; AJvYcCWsjosljrAwLr7COOBlvEcY1H+fBiWUmuhGwaIwnIkPBnDUdRETQgLvp0RVFB5bPk5yO/iXGJdc1uN59zmQcb3n37XbvjCbuf/7Jy4PRDmkhYNVwdchqh/mcRJdLKk3Cj2O4C7MgD9DF0cF1pscS0Sepsf9BOMafpoc5ZVkBD6U/4NbGDQJ
X-Gm-Message-State: AOJu0YyBfxJl6Cn1bSHM0wp17xQrGFVQxNY7LynGhACCZAgwuQIKopKW
	TqNPrRmnuUMLaS26LEzV9vEYF7Qn83DQvatAEHm7Xuaq8TRqDmp8J5UnFY6IuNJgyLYlAHVk1Ar
	8OSkufouO13ZloGoSrBKL5+8GUhA=
X-Google-Smtp-Source: AGHT+IHOk1mf1VFwpZSehjIBp3kE7bAhPh2O3oBk51nvzzMPb1RydE/V7nfJvxkHBEblll7CKgRRVH3DtO8HgCgHDcI=
X-Received: by 2002:a2e:93d7:0:b0:2ea:a382:67c9 with SMTP id
 38308e7fff4ca-2eaa3826e00mr1118361fa.15.1717222587067; Fri, 31 May 2024
 23:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530111205.1764-1-bavishimithil@gmail.com> <7845bb1c-47d5-41f6-bf08-bd7b357df02c@kernel.org>
In-Reply-To: <7845bb1c-47d5-41f6-bf08-bd7b357df02c@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Sat, 1 Jun 2024 11:46:14 +0530
Message-ID: <CAGzNGRn=e46yYrK3o8JhUmod4pGFFdEK31kUWUU4jn+JTgZjQg@mail.gmail.com>
Subject: Re: [PATCH v6] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: peter.ujfalusi@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please mention in the commit msg all changes (and explain why!) done
> during conversion (comparing to original binding). I am pretty sure I
> gave this feedback already.
I read that i'm supposed to add the changelog below the --- line, my
bad. I'll mention the changes in the commit message itself and that
too from v2 right?

-- 
Best Regards,
Mithil

