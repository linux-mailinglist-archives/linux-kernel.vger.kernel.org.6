Return-Path: <linux-kernel+bounces-339486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7044A9865C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E89281D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C1983CDA;
	Wed, 25 Sep 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GZqjFCp9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F26088F;
	Wed, 25 Sep 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285980; cv=none; b=BTjA1V2eoaekwm3GynTM1zXSWtXgJe4cABYqGOlxneij/DlNaNYIS5oee5b264+VoGLhv40GazbYbYTSZNKrtvaZoiojCuy8sA35XrxHw3TK55NvUG60CLJf5BanZKgd2L58r0EvtAvo8vuvMPvJhtlR8CZBK3l8I5vkkJ9r7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285980; c=relaxed/simple;
	bh=IduDi2DMCrhnVCRod2FzWEZYqeb95C3KZFHPZWBjPRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hT59uSoTLuAePeQcfHaQ1l5OwODVYgjlji+8flyOOv9Zk65Jqy4PQnXrnaW92Wqc0jEuaCu8Ywnzux63Y6WBT0cMja6D6uzpq/FMZS7LNcqwJkPQO8kBDWYY+AQ73a50IcOjgKoVbYI3lTYT79eNPFS/Kr+9jokP2wp0FlzEf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GZqjFCp9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2068acc8b98so480655ad.3;
        Wed, 25 Sep 2024 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727285978; x=1727890778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk90OIfhTnQ67I6KDPiF6eWhTkqB4aikJ1+T8tujX9k=;
        b=GZqjFCp9L+Gllgmo4kkFTSdI8h+XM8KuPsBGFpLeFKDgfPlenW+DQEo7tpqhL24BgH
         GV8FEHBVc/m6sWRx2hUT3M37XPd31sJWt+exXhencJdyJ5sQFn44pA7y9gg/FLJkyc7j
         a4UObBeXvTvPdEtZeg+Tb09mjF62Dbh90Ss2KwHQgkWOjmWFDpc+7HwxzeFg5W0jLuCU
         fxsAtGhxyd2hXEVDIRc0CZkfl0PDInM/RitRBgkprtawf/Rhn+KrEMyWMeQtNAvqlSaS
         YvAhhQUBjmF2r8L0iDYeWF82qphWWSZchf2/V2ZTkcuOi+lSR2pxitui7+po66MrcSkt
         Rn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285978; x=1727890778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zk90OIfhTnQ67I6KDPiF6eWhTkqB4aikJ1+T8tujX9k=;
        b=qn37hBIwuwp6aT3KZ096THyqZQ6D5/z+rbY81ZsUNLLdtIn/YvLC+lU8/ql4rWpLUi
         k5ymzf9WTHFQiPDtpR38CLrNPDWKXEiHsBn+Asbsyn1T/gvZF5U7uKO+q9lA89/xQf5x
         zl6pTEONCJkL5vgLdh8JbCK3fDLPBIkaCuzNR2Qp4EkJDvVf+A/qg4gBVTFaa3sRYjEK
         /qkFa2cgcT0TnoQPP3Xp5B5DEIpMfPw4nvQmG6gJConOqe6x+i2AE19mcVhUSM3VK2Jc
         aRWL7GKi6k+riWOY2uttD0RTLuv/FswZr0eb4068e/SkS8YBfjB+DuV3cXZvpJ63Q1yL
         6dGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeOuXA1esNIIBiMxuTaQlqkzjEqT1HUE4y5jeKOciHCuGflzAEcVp3sI+Hguh8NaCAGDj+3BXKdy1gik/O@vger.kernel.org, AJvYcCVuZNkc+fnjCpxbxmNhKGoEPGaDZ5qe5G6DTag81p2xNRoTuHIeP0I3GWGCDnVkWPbdJHksmqn9XH7r@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr33kZA7cyJa+x8+73wAFJiO1eln6GZmLjxOJvZqvm8EhRhmGe
	/mBnkLX0A2CZiUwhMC8PZLPH+86yAr8FFsfmu3zdHE8egpocIjEOS9rzy9vsYyKiA+dzI7QRwRK
	+Z5hXKoFOESvHY/8dxJ3M0+KrhBL2dIj3
X-Google-Smtp-Source: AGHT+IGlo7PesYg/KmXOi3FOf4+bYxd/B53oypv1/h4B/VNyZnzpGsokuxWkiGSd8uA4GxMVmbbAbsgjOt75o/HZAEQ=
X-Received: by 2002:a17:903:234a:b0:205:6f2d:adf7 with SMTP id
 d9443c01a7336-20afc488b1emr40050045ad.21.1727285977974; Wed, 25 Sep 2024
 10:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
 <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-10-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-10-0b20ed4f0571@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:39:27 +0200
Message-ID: <CAFBinCDjf7TxwMMxv9+w+Ob6RZZ8hjU0iQvUGHXLtAhvBDm8vA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] ARM: dts: amlogic: meson8b-ec100: add missing
 clocks property in sound card
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:08=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Since [1], sound card must have the corresponding clocks property,
> add it to the EC100 DT, and fix:
> meson8b-ec100.dtb: sound: 'anyOf' conditional failed, one must be fixed:
>         'clocks' is a required property
>         '#clock-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
>
> [1] ASoC: dt-bindings: amlogic,gx-sound-card: document clocks property
>       commit: f189c972f86b00318cf2547b62e461cb98374e34
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

