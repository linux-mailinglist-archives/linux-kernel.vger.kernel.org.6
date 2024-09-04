Return-Path: <linux-kernel+bounces-315342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8596C14D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258C91F2939E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08F1DC053;
	Wed,  4 Sep 2024 14:53:08 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8F1EB44;
	Wed,  4 Sep 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461587; cv=none; b=P2sB2vm4/Y1SmGvZBeatCDkH967vnq/+PnAXBM12ddNPestPmEaHunjAFRETnD2GGXQOdNeUKuABGe/mVh3PtY66tR/OHXhv9d+dR4/7WBihgVyuJ3c/TN3VgJlpLHeDurBfDOdCZC1OFFCGTSEeNdkI31t5SaZ3foobnic1EGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461587; c=relaxed/simple;
	bh=bS3cyxTkIotmDr5nHPJT0xy5QK/kYKsT/AREDDDATsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR33gMRx5uxq/2woErn0ZchYFsIY/Ag9ivWku2AZ5+WhE/1S0bWrQ4ftN1nF5i1njYb/QLgAFNhTzH8XhSapkonLaDMnxtvcAzZJ/f5u0T2c/kh2LPonP4dhPPuCWg30Xoldd/AHys8hWJblk5xOicKxmWKgQJRaaJ9jsGu2jbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so8643798e87.3;
        Wed, 04 Sep 2024 07:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461582; x=1726066382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRIsPL92HswU9zfh6e8X+nP5hCYe1ZQzHxllYIYwBAU=;
        b=ZejBQMnimCwgZeA8GrjWAMwTG6MBkqWA1fMeoWdYlHGeq2f1iwXhAjtG87sYMXuwah
         dMoynWGc6k+RWnUnpvDmn3tSndAt1sovK5yXUREX0Trj6V38Rxcrl0wDtImN0ywltrXx
         xxPhKWhCZEm31F5U37MnYr4UTxNJHdJ9vRRQr/UXAWbTawyJgv8h6hQIHMNHkk98HAYm
         9yA3gvhW+xeeetOTRx1NuJgYM9GMz8Ssi5Yn/yfPvTfoS3mCXFAkYcZd3H+meBb31KUd
         Kytq70Z7Q/n0ebktpelokRvJf/oIK0ERmtB+Y1tjMAm126chG6Y+D7v3RwCFXiMyi6nn
         C2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPvNytzrT+eLu6EujS+EZJlPL7UyMooH17NStYYDAntVGjBBNoWPkttm/ua3bbFVScLjieVtCuF+o6YI68@vger.kernel.org, AJvYcCVbEKQ62rzhw3cx5TyqY3Ssj7tcpN4VwqxtGdt19fq/qHwKVZY/7p37Xc9b7BQAa/smXaDYzOXtnWVd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5SJN6xYD3XVZMAVzQFgDTeltSs9KiImczVOR5QiNSCYEyw0h
	kSaxXRMkWe9QGT7jIGq3zqCJJhVihtZPeryq8MMfLXNr3LERaY790Tez0AgU
X-Google-Smtp-Source: AGHT+IE10YQbPy/s4HvRIyb+zaN4Xw+MV90eExiYe+ssdJ+dCRa3SoikFBz4ungbOkb2iMIjTi4KEA==
X-Received: by 2002:a05:6512:3f11:b0:533:4652:983a with SMTP id 2adb3069b0e04-53546b49f56mr13826097e87.35.1725461582184;
        Wed, 04 Sep 2024 07:53:02 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827a6bsm2364773e87.169.2024.09.04.07.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:53:01 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f4f2868621so72180311fa.0;
        Wed, 04 Sep 2024 07:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzMD/BvkGJ371MRZyuXg1XKbj9XFD4zRto90hE2rQZ+yC59jYTiuUdaQhiZ0mqcH3G3XttCIfjKWx2@vger.kernel.org, AJvYcCXSzCbbcrfDgvv4rzaLmUe1TqpRAw3NU6JiJLpjOujIwnSJQlwH1J1hGqLRo9CeRJS+DlXDZ/auxSpt75eJ@vger.kernel.org
X-Received: by 2002:a05:651c:1a0a:b0:2f3:f4d1:1132 with SMTP id
 38308e7fff4ca-2f6290bb1e0mr72319961fa.33.1725461581630; Wed, 04 Sep 2024
 07:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
In-Reply-To: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 4 Sep 2024 22:52:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v65qZweU+iB+3BBkkcHhQ-aPWUCcPLWqvPdXHCOtOXhqfA@mail.gmail.com>
Message-ID: <CAGb2v65qZweU+iB+3BBkkcHhQ-aPWUCcPLWqvPdXHCOtOXhqfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix regulators and assign them on NanoPi NEO Plus2
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 28, 2024 at 5:01=E2=80=AFAM Kry=C5=A1tof =C4=8Cern=C3=BD <cleve=
rline1mc@gmail.com> wrote:
>
> Many thanks for your feedback, especially from Andr=C3=A9 Przywara,
> I learned a lot from you and your kind words motivated me to do a follow-=
up.
> Regulators should correspond to reality (schematics).
> Proper regulators were added for pio and r_pio.
> Added missing regulator for mmc2.
>
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
> ---
> Kry=C5=A1tof =C4=8Cern=C3=BD (3):
>       Fix NanoPi NEO Plus2 regulators
>       Use regulators for pio on NanoPi NEO Plus2
>       Add vqmmc-supply on NanoPi NEO Plus2

I just realized that all your patch subjects are missing the proper prefixe=
s.
Can you check the history of the file you changed to see what is usually
used and send a revised version?

Thanks
ChenYu

>
>  .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   | 38 ++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)
> ---
> base-commit: 6f923748057a4f6aa187e0d5b22990d633a48d12
> change-id: 20240827-nanopi-neo-plus2-regfix-b60116ce12ca
>
> Best regards,
> --
> Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
>

