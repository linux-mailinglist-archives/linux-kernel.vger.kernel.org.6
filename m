Return-Path: <linux-kernel+bounces-561133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC35A60DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96271188EC61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97BA1F1523;
	Fri, 14 Mar 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMxkM3Qg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B601EEA2C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945960; cv=none; b=KyjM74oZaS7tUsTE7E4kpdn9a6/pUMP6xVfbfQNy7V82Vr8ODx/DIk5+I2eht9VarxtAYbEyOk5ZaPL5dWkttRvjbIhaB70N/mAUdmT2m/IHUNoG0/0DYvU+Z8TSm4uBlA94TBEcdK+EZYcNtlcTiAUz8UpSAgQVaxvHSG75kJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945960; c=relaxed/simple;
	bh=K/5asd/53euBM6bC34RrAlVW7qDAdZITZLPvtilAXu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL12DED4yCStzhS7NSqUZqlD5HJ6c+f9h6jjNlgZlvUxnBiFqzgQ7DxZKYK800oYL7QqikZIMPmzva3fjD1Bs9cUjCDdV3DG2ygfL2dqPRd7Wa0yrVNyciIIMCGzZ/OljT6/FBguMJ5xvwWbWX6pHyjIcOSwI1JTjZIP3MSg3fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMxkM3Qg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549644ae382so2153534e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741945956; x=1742550756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/5asd/53euBM6bC34RrAlVW7qDAdZITZLPvtilAXu4=;
        b=pMxkM3QgcstITlmoCwQEx/39fwvFggu+847HtwSSyC4GtmMwypqRwd3wf4VgKjJ1Zl
         nSA9hLzvysEBQ3EW2huyUlYdbnUaF0/6ST6rErSJiOv0DA/xUtqmrauUuvXUGKOrc6d5
         ktgvbaMg/ugTLXuipZ+i/RICM64PZhxIZ79t2VCNJBDjdLsE2no7RHgy5r4VtnZYp5UT
         YYoJXfTiHA8alMleHBadNB6bddJSWs2q0OJiLnpqQtZ4e03khEH44G/gr4eJV/PRCwUa
         vKRK9PKCaon2R/xQWw82ZZNQWUcyLeLjfwZMPEMl0KC4lcZtlGi6IT+SAb4ser/+cqkt
         hBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945956; x=1742550756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/5asd/53euBM6bC34RrAlVW7qDAdZITZLPvtilAXu4=;
        b=UREXxp+b0rj/p6aBJSkSiRVY3tvEEU97YBVeIHF0hjuOBHgpASr5lall8iJ5gG85Hc
         7d3bemtnHJkMVxCj07+8XbjHcSKK/IuDP+fstxvMhOoDICgw02CnuZaOK7L6osdw7TFg
         yjJrW74itkLFX52DjFnp82X3wKIA6VidmKkuXlBOtlBFe/I329cwSc8TYq4Ifaylmcyd
         EnO/c05enXm/tpt7LIa0UsYcZu1+q85KZnGb3X5ns9doYaeBiXuBsEMSHvimVd7sRb+/
         0wPxLCaP8cDXLRhBPcem1z+CidSJLQjSilUovmVNE7pWErIYA8k6elknVB23j71NajrL
         c7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZBnV0Hi+Lun6J+R7iLxoHpHfZwLfBWFf1OeoGsF1PqAVt0Y5OXevIpTdaQMz/yJBYAZLlYyDPn6mT/oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0LJe9IHUe2isZ9Dpkgwpk2Aq9oRUrmUjfVb/DFo5Wm/iF2dy
	0guse3iBnDaxudYsvnhgD5ZeZEbwBpMMoCuXu0MNMvfHQ4YcXm+PEENiEjd+VQVK4HQicWTgabv
	DHLidMYTj8/bK5dASkkhqbPqH8UGSVDcr18oHKw==
X-Gm-Gg: ASbGncu3Qf6Fo6CzU8pajkl0kvZddGpquKhJ5fxVqYJIm0iHqZNPk01Xf4veZzxRyqM
	Sw3X8ZrjVC5xS5jDMiorXelA4MttW7chvzzQ2/7wj9kc3/yQrpFz1RsrLVCblF0/pXzq0AOcQXv
	Z8j49j1RkuHQmv8OHcg19qZpbuOZBDL9o2SA==
X-Google-Smtp-Source: AGHT+IE4lxhMdTrTNBei0n9rc34kAsgDuahn1/eTB9cagoZJUZxd98PK8/buazwt90bkSBJ617Y69C7NrOlBT+UFM+0=
X-Received: by 2002:a05:6512:3ba4:b0:549:b13a:5d7f with SMTP id
 2adb3069b0e04-549c39905d3mr580715e87.41.1741945956413; Fri, 14 Mar 2025
 02:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740823241.git.hns@goldelico.com>
In-Reply-To: <cover.1740823241.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 10:52:25 +0100
X-Gm-Features: AQ5f1Jpd9Gi4dE97J63cl_3Sj9zWgf9B4pm3B3hxaUcyuam3AtBeRqgiMrcUtRM
Message-ID: <CACRpkdYe5R6aAaeCAW2_cCA2k+m_kpPJGwZvgq_0Num9U04VrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] pinctrl: ingenic: add support for x1600 SoC and
 MII and I2S for jz4730
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
	Andreas Kemnade <andreas@kemnade.info>, Paul Boddie <paul@boddie.org.uk>, 
	Tim Bysun <tim.bysun@ingenic.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, letux-kernel@openphoenux.org, 
	kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 11:01=E2=80=AFAM H. Nikolaus Schaller <hns@goldelico=
.com> wrote:

> PATCH V3 2025-03-01 11:00:41:
> Fix some nits reported by Conor and Paul during their review and add
> their acked/reviewed-by.

Patches applied, sorry for taking so long!

Yours,
Linus Walleij

