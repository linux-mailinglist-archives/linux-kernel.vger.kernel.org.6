Return-Path: <linux-kernel+bounces-301062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F695EBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EAD1F211B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0FD1494A3;
	Mon, 26 Aug 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qb1d1u+0"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC3143734
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660792; cv=none; b=drGI5tHv+Nin9iblgRGkC7FOL56A35rCybXFbXfUW2xlfJIn1pEGhPHQNwZ6DQRospASvcMkB2yvJkJKcMpUZL/T8I17DyH0pgzmxtHflYVscDWY9srRBw7DLlAGF6cGmKgZeuwn71bLVe0nRhC047+17rIopyK+ooVA4lvMyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660792; c=relaxed/simple;
	bh=g/4SfK3zwgSyniSBAB47/iW5R2FXbqs/l+E2+gnvjf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsLeo3aRcK7sIWfPb3OjeJ7pOFpnyT0oCGK/AInEvJisIUPs8KbnZ714vNWimzafev1FU4wQIBmPfenEVs2iOSD70uwBEYmnWYSAvyWRaPIM8zop/Hv0Yj8qyr1mmsDnC9bO2CeN48RPHgxhNDS2QdRx+CCRdfgwe501jJHtRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qb1d1u+0; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5344ab30508so333912e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724660788; x=1725265588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/4SfK3zwgSyniSBAB47/iW5R2FXbqs/l+E2+gnvjf4=;
        b=qb1d1u+0THGngf3LEGFin2qpn/4WIlrJX3evtVEnrhyNcJ5sZSO4kmYwR7G2QY6rSU
         l3jEcdZIvwm+gHSzGK+nhT67LwBBApKx/WXt78/2Pj5cOMe4AsP6jtARgR05cPuR8FEE
         3TmfmyKRxsDSDziLcujkSgMGc3j4EJ+/GaDugTjhX1716RYrOMDBk/xMPnrVUCRB+ORY
         mrcpnekUko/fb4QNGcltzugPzb7uZ/oUMGjW7INnb/3Lj5Xl3RJyxgEbbhChWkuGd89D
         Gi8kLtKFaQcNdzP5xcouJaXOcPKlm16Fah02zqMAtFNaP/a2JdIu7/mYNEx64QlBb2zh
         +jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660788; x=1725265588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/4SfK3zwgSyniSBAB47/iW5R2FXbqs/l+E2+gnvjf4=;
        b=ljgU6G5HX3CRFCp6xA1ZBGv0lV83jadDY/qZzuGNZtOnS6t6x7SD1bw6yVFqf6j31n
         tQpRrB/dHbBZMW2BcwNPpPrYsCRWdwY2B9YtfUFjGMaoC904ZMedqEWKjmYOTQStwPQO
         B0RJizp57E/vDh9cjg7yBIkaeO+w6lTz2MY6YW4vHvzufB1/gr0264YuZVgsV/SLmjnf
         BxDlo63tt1qKgBk7FoaF6qpBS4vmBy8y7uU09633tPJ/rgg9GjIELrU0FQ1AApvYQS/6
         FxZt63sUNT37FuejpEoutEGaPATvV+M4WR+69gQFT3G8D60/BYttnP9gbrLspFwbQXu5
         /SDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIk9C83s/RlkgAs1KlAT+/6iPAaUhKu1nWqT8MbsQV4rbRaR7l+8iYaMcbGuLdGLHxAwVPXC+KrL/EOOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf976oMg+AG7H4FccmiHbnstTw/caiFclvWL4OKE07floqC7sL
	8VJQOW0CsmkyXMOtmnCFFziB+JYRylpqskxSzsOkUq7f22kZGH6zLcdctJds++8Dxeao5caUKTN
	tMTM5kv0Mmw+PYeNpB3jwwU9u9Au30nFGiXwoiQ==
X-Google-Smtp-Source: AGHT+IGZ3mW9OrSPkBF7fGwchIoi8dyRSCL+VNwhQlZAYO9KF7VH9a0Gite//Z/t1UQPTKKPBi2DPsrj9/5oyYz5b80=
X-Received: by 2002:a05:6512:1251:b0:533:15:2b23 with SMTP id
 2adb3069b0e04-5343871eaedmr2756503e87.31.1724660788087; Mon, 26 Aug 2024
 01:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521152602.1097764-1-patrick.rudolph@9elements.com> <20240521152602.1097764-2-patrick.rudolph@9elements.com>
In-Reply-To: <20240521152602.1097764-2-patrick.rudolph@9elements.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:26:17 +0200
Message-ID: <CACRpkdY=prhC=H3u0qEhQZ1MpQAjMLB+KrQgHNjAX4PWMyAEHQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: cy8c95x0: Use regmap ranges
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: naresh.solanki@9elements.com, andy.shevchenko@gmail.com, 
	broonie@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:26=E2=80=AFPM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> Instead of implementing a custom register paging mechanism in
> the driver use the existing regmap ranges feature.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

I didn't end up applying this patch set (I don't know why, perhaps just
forgot it).

Could you revisit it, look into Andys further comments,
rebase on v6.11-rc1 and resend?

Yours,
Linus Walleij

