Return-Path: <linux-kernel+bounces-568910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE8A69BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F1416AE64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562121C18D;
	Wed, 19 Mar 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CfVkohDr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3337E1;
	Wed, 19 Mar 2025 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422977; cv=none; b=tFsEVR6gYAnFr4hJ7JinLyi/Uz2TV+sCTFyuxfHsd19YjWQXgpqTMS2AZpqRlOPN2L8VlitDBTS2wpHuCdtN88fDFSCg6LoC58QE/ZXwSA/X8TB1TySAg1Ivfgmkk1FQFLSeinfCXOuaDpGgAzaAANAl0nWR4FChJN5qmVCLQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422977; c=relaxed/simple;
	bh=6i/IMvmJXpNfYZNxh94Px/7NI1YzpwfMWjPNfjccPHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh1JjKMRN9FGje1eX7XIItHgjHYoSwNBH4TsFZtcPrVgUlObL7UW3w8JVhi0ocPJozISPBmjua/mVdVVXF2gfxBn63PLi/8t6ZJHGvm1dfIk65GxdqunBNsTPBJ/zdQ9XMfcBMZCfar6fpvgyw164yqVFnWAptZuMysYY21aKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CfVkohDr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224341bbc1dso1043315ad.3;
        Wed, 19 Mar 2025 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742422975; x=1743027775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4wEEUuOXU/4c78WOKPAs88Y7ud2TxrGsHh+sX8lWUM=;
        b=CfVkohDry25zrZJ8/pGwMFaV9Q2vuaoJgDDjzHjaofjj89tFViTZ9CnJSyIPb860dj
         9pPP3gDwAz7zq6F5M6l7Ue0dPDQnFASmivd7K52fgyL08Q4H07mRghTkgYB2dWZDH/My
         urQVQn2EDOnLHJ2qivH/5kDjCSOLo7wkvRhJ7yB0FxZa7B/8fcyINT32S6s0Shbxc5Li
         9TwoVAfFNGe4BnWL4Uq8RCtitXfV1oK5KCjSRuZ70dgPArpw/eLUdW6r74pgjG0kQm6T
         waAbSw8vThAvPyhpQEd+PRJhih+wMs0Hg3B+FOF8GLcRbq0mXEgzWs9fMk70hYFbiVAR
         j2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422975; x=1743027775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4wEEUuOXU/4c78WOKPAs88Y7ud2TxrGsHh+sX8lWUM=;
        b=k1RIMh58FPFR3VKwKoYhreP/mUrdP7rIkvUOZwJWmeOQpUVsu++xW6DbCL8krZSoFF
         a3v8e0NmbVfVGeWGbLEVGoyyxI1y+nKCKkUDLp0NTdW1pI0PDCHMHlkNRsNk1ao9RroO
         nhFwdQuwkvCGIj5x+zIrppj4BaYJlj0Pmys1lWtVa4BvZWaefcXmHn/sC9jOJwCA75Oj
         NWIRnyBX3prEo645GDVFfFH6exzdQtQnTNd8b6uJHoQtVhUKSQHa/eFK4sUbb+Vc6K7p
         33AGXavY8heG6kehdOx0KsWIle+Fgx/t3lHFHpSheYqTOofTMOXfX7dHqJjZ/Lk4IcyE
         GWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUad/ai4vA56+h/9UuzvWXNGEm/6t0w4S87G6WNaeb3/H1TOvSE3GiyHiWSrYVwXIvpVrVQO0BBx4psLyu1@vger.kernel.org, AJvYcCW4DB0iUU9b3CsXXovCboGu8lcucKsgzT6EDREFoz3rbjYLVX491+urGEW4dKuAteiiTkcbZu4prNa1@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNg42e6G6lB9v/mIhoFp4X+U027x5GIrzxo/BbkBkY2rxCF8W
	bmS+Zmkva3KfVKWGPY+5wmSYW4KRfNbPQuc2dRBZVRH3Pr6hQSvCzJtW1VDlQsdZkOd/PBo2woD
	KuRe4c/hLfl2hW5LO6pD8SRs9ams=
X-Gm-Gg: ASbGncsFv1hbohUwbRo1EWDkELNoLFgLvx0j3J52xIuNwPdM4sQSPn6zS27LJ4msth2
	cizTdzvOYiZ2x1IJ4mesbDribunSbJFgr/g7VPRh3O6vLXNPjEshkoUlIqRYtZPwMZPWhvMCAk0
	HG4ykeHOH2QgLnwNAYGa5SEw27eyO/44b8E0V9fZCe51RgNdiSFmERy43i77U=
X-Google-Smtp-Source: AGHT+IHnrwxeln/RnbLA2XRvBCju7XzJvLA6h2ZrJXAkHwZQxFkrUVqTHCcEQJIqR6TUDRWTL3skUv6t2g4Q+MafzCQ=
X-Received: by 2002:a17:902:ecc4:b0:224:249f:9723 with SMTP id
 d9443c01a7336-22649a67f83mr47754205ad.51.1742422975243; Wed, 19 Mar 2025
 15:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net> <20250314-ugoos-am3-v2-1-422104b0cec5@posteo.net>
In-Reply-To: <20250314-ugoos-am3-v2-1-422104b0cec5@posteo.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 19 Mar 2025 23:22:44 +0100
X-Gm-Features: AQ5f1JoWIv58AbGKUJz6nPSYBcTrHvuaOG-LcZ2pVsz1-w1fQQqOt643bLXrSYM
Message-ID: <CAFBinCA8Sk8rKt7zZBEgCdRh4J_fktapo56RtVJOC4myCJ1qeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: Add Ugoos AM3
To: j.ne@posteo.net
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:11=E2=80=AFAM J. Neusch=C3=A4fer via B4 Relay
<devnull+j.ne.posteo.net@kernel.org> wrote:
>
> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>
> The Ugoos AM3 is a small set-top box based on the Amlogic S912 SoC.
>
>   https://ugoos.com/ugoos-am3-16g
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

