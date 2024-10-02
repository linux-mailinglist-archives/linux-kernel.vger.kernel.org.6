Return-Path: <linux-kernel+bounces-347670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632498DA0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9654A1C22C41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585851D131D;
	Wed,  2 Oct 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhJI0BdJ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE91D130F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878383; cv=none; b=h3REmatVLZNk0KgCHFcFsZdYHQh3iAu+JGnBCu6m7p00bpv5+dMLkiDrvoc26zogOVgysW+Zf0QsZwWvxdlWlhfH6nX4nAe7IPTRSpZtPfh/0xsw6ywpp/tqrwtXSlffJkwYRYZbSpVUreQ/nSU8AD5wyz8gs+/g7zV5ZcmwTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878383; c=relaxed/simple;
	bh=/MwprdMA2CplfBjH2zCn7WBpr5tpPa87QKFYlk20vb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj4Uhi5x+pGSQ4+jLJtJvJf8O+ijs20oXfSYUuXELNL5KaiMtvSSbx0c+Iew+VQWuaTUpqSFgtrMoyi3cs1ANJWiRABhUbvArvI9GKQko5OQ6F2OCbwCOSRAa2Sve3WAG1afiKfLt1BCOyQkB2wlmg7UV91FeEO6aKvC/cC3yQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hhJI0BdJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso32496241fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727878380; x=1728483180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MwprdMA2CplfBjH2zCn7WBpr5tpPa87QKFYlk20vb4=;
        b=hhJI0BdJWh2kfrHGRlr45j7lCdLwefeDK0jH7a9C8rlqZM9GeFcJUW2H/Bu6RxweXS
         Vkq2AXO1jhA0vu79wkm1oK/DTVvpP/jZMly0oomtoBZFJ1M8RJ5bwsWEY8DXOumpsZGS
         qyzPrTrktDgcWdv3yrQELLssqYjEziyerkHZ6U8rxKUwh0om4Zj3Jm8HgwLe7JgJm7wN
         yanbGskJ8rjeWi7uot5GBSMPCbYEid0N8PHg7E05tuIhV/bc8Krg98rwJwdoKinZzCRZ
         vLJndRNzO8IwFkWn9eWpGIOZi3VyN2RFzri6Jd/2FG/Dn/aOUw1dhzdJvuSLxi2nvrYm
         YjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878380; x=1728483180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MwprdMA2CplfBjH2zCn7WBpr5tpPa87QKFYlk20vb4=;
        b=TkJfEZnXfK8JtEVK19FA97kqMqBKRjRaHn6OKl9zmloyyYxdkJheadaPOdHZefTdag
         hkxkARAfXi1aauiPvd/01d0hblKe/zAW/WZAfTUT7IUXcZ6BB0zvT4OSFJe68EnV5Zgi
         U/sAT6rnBrUu8GfxmUOfLStc0evlTUxrhTxgyDgPxn9VFOUg5z8V5iwPhTTu4pJxt7VD
         2fej8jzcru/UaGIGv/XMtbKg1qPoStZl0bJegJB3tLDgP2mWWIBkf6SLn3KJ6CZPqND1
         hPzRq3heHP2xWpBYzIbMN/N2Ifs7w3O51/TDCn7AzogBsRnfEEVziQLIcB7/CLqSkigF
         qO5g==
X-Forwarded-Encrypted: i=1; AJvYcCX/nQZ2AgL+AEauameu5/myA5m9wNo2MamoAMHRz1S6Y5qX+R7d4F5V82XJ2jt6yUo0wb26jkTNj5HqtXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2HZGEWkEVqAN1PPs2W2KTZueXVAlVhRREsx4owWIG1sZw7bV
	0ZZ3PS6+mVKauFs3IBNy0Rpw/x8Zb7rUibgElHgTvbek+O2m+0fUQ9QcfhiYvEu6X1Y47+iPHmZ
	N88zoa2dJ3eCgzaBReoZsbLy3liXHBLbxvG90xQ==
X-Google-Smtp-Source: AGHT+IGl17gRjgNnOMS/iAMQMN4J8biS0TRxU905QubH8vQVNaxcsist3JF9+CzeIGPLsDpKZ+I+rdokSFbiRj+qXpo=
X-Received: by 2002:a05:651c:210e:b0:2fa:d386:c8a4 with SMTP id
 38308e7fff4ca-2fae103c83emr21489031fa.12.1727878380034; Wed, 02 Oct 2024
 07:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-pinctrl-rockchip-error-modulo-4-v1-1-4addb4e5732a@cherry.de>
In-Reply-To: <20241002-pinctrl-rockchip-error-modulo-4-v1-1-4addb4e5732a@cherry.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 16:12:41 +0200
Message-ID: <CACRpkdY1weM7+iRas0-7ZiWkf2YwH1CrejjWbH0L0soawrhCcA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rockchip: improve error message for incorrect
 rockchip,pins property
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:03=E2=80=AFPM Quentin Schulz <foss+kernel@0leil.ne=
t> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> If one improperly writes a rockchip,pins property, the pinctrl driver
> basically just states that one in the myriad of pinctrl nodes is
> improper but does not tell you which one.
>
> Instead, let's print the full name of the Device Tree node that is
> improper as well as provide more context on what the expected content
> is.
>
> Note that this should be rather unnecessary if one reads the output of
> the dtbs_check as it would be highlighted as an error.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Patch applied!
2 hours! Record time!
But Heiko was there to ACK it so why not :)

Yours,
Linus Walleij

