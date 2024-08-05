Return-Path: <linux-kernel+bounces-274287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81073947618
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391501F214FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C4148FFA;
	Mon,  5 Aug 2024 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNj5FXnp"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4501E505
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843241; cv=none; b=lTYgyt+Ns+QiNLIp3xfvKmbnWGJuK+qzCWhZNYJTSRBGB9fzbzPtk7OGNUyBfBbRnNnWhyYMKCihsI/W22cidz7JH9G1jALL6zsG4mR3A550gTBBBY3KLdfQblwqd4JbkKA2hDATLad+yxHCQLDmjv3uXQNRSQzyGVyuwMIz9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843241; c=relaxed/simple;
	bh=MWXSGtBUuIsu9gfT7t1iecOSYsEkGOOPqiqXne1odrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSemJzy5Lr6ET8+BkTrHqAXJOCtZHA/GbXviNTaxpLpKMlYTbltIIcvEcrQCj1q5NA9AvC7OFUAysiPcTkSh6uCVsXEbuBCy1aYI3P2k9TBqneGU7IIQu25F8LcQnjmm6yYkHCYccDZNHuZUwn2l6vJbo8EHqJ30sryZhBePEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KNj5FXnp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01613acbso6440501e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722843238; x=1723448038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWXSGtBUuIsu9gfT7t1iecOSYsEkGOOPqiqXne1odrw=;
        b=KNj5FXnp0lxLbOy75LqM9XGxexoqH3Wvk9PLMIR5mB1SRzhNEP7UqPUZyq9rWpItyY
         7FWWicJDBAmSiVd3SGbxeKPKiYyJqC7Rb5M35Yu4eJK/Ol//uxjDW9B0UMHhtyP11Rm+
         sukNKPQaaBrAuTjqBrsKtQLs4BoNqkrbV+kLjG4gVwXa/IgKDnTgn5/y+hA3JSMSLsGR
         zzrfqIeTqfW1/wWtun1dyD5kg40bptYZN5ddILo2ioxuT28PYzaJ7xbi00RSyurnltNM
         JJ1+eIBf2G/sYu98lM5ul8U4hJd6pGuR8kFkSGFXT57/Y/o1wgelmeNarPCPQnNdlTfl
         whWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722843238; x=1723448038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWXSGtBUuIsu9gfT7t1iecOSYsEkGOOPqiqXne1odrw=;
        b=jicoGQIXCFOT11n8yggZTkQpjEzVzOo4GMDHHBAgHvSux7ls6e0aphhqIXSlhxBNlZ
         9myHmkpOMo3+GE1YsZIW/6vjxErkVq+pfykkKmah8oyJgetiEb37tSnjM+n5XnVwFRlV
         VUbjSqOqI92kSfiMBlpYT2fPKKChgiY1o9QzFFWQUbwNxtgp+mWfYryQtKShJQjxi5AX
         iba6jhffuEtfTrNFaoFabdpjm+L42O06Pq3vSZ+AYCnJhvo8dev4HFo2YNJmbE+95jeF
         RPUR+yGSGkW3j3hSrfX1mH3rOB9N2agkgD4PwuW9iQ6DbzQO6W5+Q/76gfvR7DMreHfH
         BOMg==
X-Forwarded-Encrypted: i=1; AJvYcCWKjFjNyrwZiA4UmpUR6LaeIIeDEgHZfsxBdohYQBQep9Wz1Pg5mRFYr4dGFA4FC3pIze6VfqUEqe4945C243jVBghavLPN9LnymwpJ
X-Gm-Message-State: AOJu0Yz2j28bN/Rcecd69BdH6aWCZpombAZ+imtSybyR+ZREegXvISRB
	PY6GVDLXHfBltHzU38K/eY4YIvMz5nnF8NNJqgadr0sjcyKsKvxnBwy/KVmo2WcUKeKfGplHTdT
	ZTVEsfDQZaswpVGj4514oCBW5k3iIj2AZZatr4g==
X-Google-Smtp-Source: AGHT+IEdbpiAw4D3jz5wmtP8HUpVreiNVjQLGM1ndm3P5ErzjoCL6e/1KFGffHd3JxxaAbWeOXHrUGQNbY5Y3T1OgE0=
X-Received: by 2002:a05:6512:3502:b0:52f:c281:72de with SMTP id
 2adb3069b0e04-530bb2bcec4mr3199166e87.15.1722843237853; Mon, 05 Aug 2024
 00:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716194008.3502068-1-tmaimon77@gmail.com> <20240716194008.3502068-2-tmaimon77@gmail.com>
In-Reply-To: <20240716194008.3502068-2-tmaimon77@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:33:46 +0200
Message-ID: <CACRpkdYKjbMNE_SUh+0rRY+m8XfYLN+VseixuspUgD+YMaNMCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pinctrl: npcm8xx: remove non-existent
 groups and functions
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 9:40=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com> =
wrote:

> Remove non-existent smb4den and lpcclk groups and functions from Nuvoton
> NPCM8XX Pin controller binding documentation.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

All 7 patches applied.

Yours,
Linus Walleij

