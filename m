Return-Path: <linux-kernel+bounces-319171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7B96F8E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21710B24A65
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C51D31AA;
	Fri,  6 Sep 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeyTQCKP"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760971D2F53
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638336; cv=none; b=KCVT+FQx63ztWgLGwhKLP6ko8PouXQXr4UYGP6AUqUhvS5EwJl7ALo8wqDA6ChGXo+CBxfwcPQYnp2UA36vRPsc3KlfQRawTdB1soWln3Dy+gvDNKymGDXTfiTy5e5O2fmWObAstLofmmMVoXCqjdNP/lKH3ndInoR79x7vG6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638336; c=relaxed/simple;
	bh=BkBnq8mCYswULg3UnuBHVuyOVLf+1JP2qRJpgPT1EGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5u3K9GJK4MZLOvFeFMW7rh1DPgIvXOZgsSm20LoyWIjdxVSTgB9gFElgFindFCjaLNcVFfb9/Z4rV8i7j+uwgMTcUNKTmOtr7dreqkiuMJU88OspA1gVS8QM9c9ZRNJkpSP9fmLvjDrDA3kZthXXLpGu7NFYQlYSLcA1S1UtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeyTQCKP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso30813531fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725638333; x=1726243133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkBnq8mCYswULg3UnuBHVuyOVLf+1JP2qRJpgPT1EGI=;
        b=EeyTQCKP1cLi7JdM6bXv8ZD97rEMvi/Fwf5kUO69O8izGFkNzstlA5apeA3MaLbOBn
         6qm+0iet/y60p8wxgLZwmN4GpR7Oy35DVyoK4D6nu2Ey/AjBnlNYm8unQZMdOfUjfEcy
         5/3/CKkuPDK+i59bHMMqP74q4nVRuHkHdR26rc+JNM+aTtszid0bmtfjBOrx1iFVYUUZ
         cPEZBxH028x9mCnAJ6RmJhedFsY+n/qTQMo3nITS9ETl5cz7S+h2uK+FyBec7/l8IQnh
         KxzRfknqpPVUDLTJQqD8ZN2z0amGwtXy3mHZRDUbHNwPIV1BD17jbXYqJip9UPJK/rln
         uAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638333; x=1726243133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkBnq8mCYswULg3UnuBHVuyOVLf+1JP2qRJpgPT1EGI=;
        b=n0oqW1lYTf1LsfoxkLQzDctEASDQvW0WJixxeXX+Umm8btAuebGYUUEJNZNC0ybjWG
         t+k03jBmGbNNHIojqJ3P0FH+ClLsjvyMBm5i1PvIR4CbGj7yr3PvvY2yCvmNAWggTwtY
         fj4Ncp01g5HoP5MwJUBrMqJXuucc+15p4306p5nV+lMjHT3wxnFG3KwCX5Or6gQ3YxGB
         a++T5NVC2IGiEpVcQW+K8tZK1iBsYZX2YTSkpl4vv6vJwETj543/WCVm+Gq44T9QH8In
         Sxx05rM6WBXAka1DyV7dUpXASvvpbQv1eGEWEHOwpKjeadvmCW00DUOneg0ULR9cWfLU
         OCDg==
X-Gm-Message-State: AOJu0Yzs+rxTRxTP3Y3tyOukK2D9unnWTchlkrKHZD9zJnFHuWEYnoBx
	aa0smlwmL612Ple2S75cajtiTseDKatFgUzPT1qCOGf10K2ZDQE/0/Jhp9pZGkBHpJW2hhaRP+c
	mWEmPBHS/VvpC1hWtXlPTr3TK13g=
X-Google-Smtp-Source: AGHT+IELSS3bZ4hLfoiN6Bml8bncyscvpkAlgKf97dNuUKWoVA/xzJn1XTNOg2ZS7PaKeAw4pxcrbYUjFq0bijemQkE=
X-Received: by 2002:a05:651c:4cb:b0:2f6:c683:553d with SMTP id
 38308e7fff4ca-2f6c6835665mr58864291fa.15.1725638332154; Fri, 06 Sep 2024
 08:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905122020.872466-6-ubizjak@gmail.com> <20240906151021.736425-1-miquel.raynal@bootlin.com>
In-Reply-To: <20240906151021.736425-1-miquel.raynal@bootlin.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 6 Sep 2024 17:58:39 +0200
Message-ID: <CAFULd4ZwEcv-KZSpoQznMvd2wZBqAvqvr_JzK7fboR_Ec6721g@mail.gmail.com>
Subject: Re: [PATCH 05/18] mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:10=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> On Thu, 2024-09-05 at 12:17:13 UTC, Uros Bizjak wrote:
> > Usage of pseudo-random functions requires inclusion of
> > <linux/prandom.h> header instead of <linux/random.h>.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: linux-mtd@lists.infradead.org
>
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git =
mtd/next, thanks.

Miquel, is it possible to just ACK the patch for now? The series
touches many parts of the kernel, so I guess it is best to harvest
Acked-by:s in this stage of development and commit all the patches
some time after the merge window. This will avoid merge conflicts with
the series.

Thanks,
Uros.

