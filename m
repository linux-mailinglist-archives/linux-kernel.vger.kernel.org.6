Return-Path: <linux-kernel+bounces-219051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE790C944
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB41C22F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015215ECE3;
	Tue, 18 Jun 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrR4+QWG"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F815ECC3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706180; cv=none; b=mK3SeYpWZMLvZj3oMAumyZ58epmAERZLaikJq58iyyzqFX/VBxZiAv7S9jWG3GXdfngaUUbfRKDTMfBh9uJxhltzeSBIRAlBhfpiYUO8pEq0anzvps0Jc7R7YKXS/arZUYLgbDAQO24XX9bbvL8HGNCv9/J9B6poHPtJIeCy+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706180; c=relaxed/simple;
	bh=ihV4mhCIBMNw0GbrSjpo4F1rbbfmrGIFerZHE45EcbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjrVDjWVlcyBQ82/nKEhpNnoOEbTjEIra2flxyVGU6CUe+VoK3zxEsUkqdcHKoCuSL6kK8sI+3rVFwNZqDLsoblPwwIq30Gck4Bv6jLEZE2zXKVAoI73V2Yu/OR2dzw3G/4Gy8pvrpxFFA2ezypPDubanz4CT5Eh0zkWqbRdkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrR4+QWG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec3c0dada3so909391fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718706177; x=1719310977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihV4mhCIBMNw0GbrSjpo4F1rbbfmrGIFerZHE45EcbQ=;
        b=qrR4+QWGX/V4Z0fooMKHUzG0SCAqQ377tFKzKAR9H65J1Atf8JlaTTSFZCG5thE3sn
         HbOSgCwep3q5RtM4FpXdQDsDvjDe5is8vnMOrjdeG70uSWmYFKqYyFDAEvSILpj6xybQ
         p1tX8LisknFalZE5MRQjQqzJeHvxBz2gI/jbSBW7fygf/jt1nLY51QO/y2l3pychT7g1
         zJGgfIXhwL7FNHYd8RZOnFWVZ01i3Ak3AIdV5brRLVznaT0xEoCQA++ZTkHsHqe6q43t
         LtrASAyP0OpxqM9ucFidIEshKABF2dOL+9X0hKnoaTDu9TDyI8bji27IsQBVfvjm/sOP
         PweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706177; x=1719310977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihV4mhCIBMNw0GbrSjpo4F1rbbfmrGIFerZHE45EcbQ=;
        b=SIRbWtV+Qk5Hg34fqO5rGtyiZBkAnxUttVEpcWfWI1Wh7yYu60axyALJpesOZjXrwS
         dCKgwzDcsEjScpW3IPP/zhDEdIkSf4pPf2av1DqGgVUc9H4SoUkEkDuRC17Caupr5vSM
         pTVuScXlOzgHTUB2sjMhb0zzVKCvSay4FD0N0QuOaLgt32/VAJ3Rs/C1HoWCRQlPlZdX
         2+h2Qxx5Cu5paXR8d0zmST7s+NKflQ05lDmU7y4SQAZe/mQGetaolZM8d8NKqLdZVFNv
         EZSntyrZa0Zl2q1lqOSrapNO5vcvamM2ci6Ylbd+PpzO1+eM8st0I1X8lHeUQXoFp1uk
         hPAA==
X-Forwarded-Encrypted: i=1; AJvYcCWdP27CPIPOonVLPfQDHw9M5XDduKJlt8KT2H+ovK7Mn20NTgO61rCDGnOnSNDXQPSovz26G8BNLdFhL+Fmf+xC47YJkL5gd0S9I1+n
X-Gm-Message-State: AOJu0YxToQ8JtvZY4Kvj7uqK5opx4KqDFigkKJP29yqLuCeKwjmwmE47
	Jxh1zmlxO0CiqfwPKznOrnc95+j2QU8PkbSPjr67Zuf1+TVe8cxQmOYkbkeC/r09u9D6YroqlEk
	dmbiIFcQrbbfdiAJ/eBYqvllTnmZAAbeTjX/0vQ==
X-Google-Smtp-Source: AGHT+IH022WCOLlxYlftggBORDsbGqRdC1MMvSHHgSlDUwRF2SFmVC/CN9nibvTBvxf4WniRU2b80Vh9i/HWSfVw6SQ=
X-Received: by 2002:a05:6512:4010:b0:52c:90a6:35f7 with SMTP id
 2adb3069b0e04-52ca6e9af3amr12476647e87.58.1718706176667; Tue, 18 Jun 2024
 03:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-md-arm64-drivers-clk-versatile-v1-1-6b8a5e5e00ef@quicinc.com>
In-Reply-To: <20240613-md-arm64-drivers-clk-versatile-v1-1-6b8a5e5e00ef@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 12:22:45 +0200
Message-ID: <CACRpkdYmG=M717a0gmOmz2EtZY-AcxO+_a9Pcaicwq_iVNr2Hg@mail.gmail.com>
Subject: Re: [PATCH] clk: vexpress-osc: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:55=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:

> With ARCH=3Darm64, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/versatile/c=
lk-vexpress-osc.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

