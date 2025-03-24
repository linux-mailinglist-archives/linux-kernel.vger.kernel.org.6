Return-Path: <linux-kernel+bounces-573307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C1A6D580
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FC63B1445
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094A25C6EA;
	Mon, 24 Mar 2025 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6BjXIa3"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E625C71A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802823; cv=none; b=XxzNuagbSUyFCjF9SUJL2zJhp1stAiSEuTH5/vCiZF3QkxaWhDEdNBSqEiCz0a7rE6n6o1+ZUFVA2tkyJeP27QR/hVqWGi7rq4OwCNW9H5/0k8ca1oRNuSut3V+LATlrj5k8/4UU+SO3N5j3TS5Oc12MW9pm6rPDc4wolt/DwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802823; c=relaxed/simple;
	bh=1wYOaUvH2+wGNYkwE9FMO2ObsGp/j2F2VQglfrqeSwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ7o42QqQQPHaSa46PivpXtdpLk2tsiRp0NTOH64iBJPngZy2B0EKLUIUdeKDQb2J8Zuz93RIsM/9MP0+SU+yayMdLYjAwAtUu9G8vVMggPJbHsAawSV1O4MmpmqCkmwZqsjwpar0dDzeMAZbC1efCwkJzlYsXLIk+dfJCa+kXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J6BjXIa3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a59so43102501fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802820; x=1743407620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wYOaUvH2+wGNYkwE9FMO2ObsGp/j2F2VQglfrqeSwY=;
        b=J6BjXIa3ZKFWJ6ecAZWraYCqhddWJoKDbn7NVjR5XoONJW0FvaylDeVROdTQhA2wBa
         ZHRCHg3SdbE7ZQRCmsVq1rGPjLMyklU0Wk0+plPrcDuX4+IpwaHrldm7PECy5HLcT8F3
         Wtw4w8x5qnUZJnv1FXJVkBk3knyY/we1vj9c5+ey9lUfwFuPtlNGZLcqNsSxCRUzk0co
         9dpkj4v7B1pMKs0AJCptXvdPpAJImMkuF2LjAdKa2KzPURXCpuzQlcIvVcvG3xfAzc5/
         UuazW8QAaPe75UCAxSKnCv7KNu/dg7SKMXAKpEyQVGLZBk0oMxLBPm9DPc24pZsWkUg2
         feUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802820; x=1743407620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wYOaUvH2+wGNYkwE9FMO2ObsGp/j2F2VQglfrqeSwY=;
        b=VczsjaBE+hiittyhBB1SVQDNOGjitbAwT60t9LRwv2rzErBaZ0XtsziPkMj7Xqmamy
         RX7wiUWnW7Mh9k+Cd+Ez1miy2IJg/ywnVgLnON6iazbYcAvhSSwZSJcZ9bBxz5sObime
         a17QGjxZgMV+fpUcQ1AqRW65AkJlI+HbiBHSWoOAVcj0MSoLpzvOudYYNNr9kxeWBiVS
         SZ8ovi68INP3iGXiQ35H5a0Pt/9J/eU2mtu6ezg8QsNVr0OuNF5W9LMkorvmHeH189NM
         2uFnXp/ZZn63EMHVohNhAuvwpQAFfnHxl0zRiP1fIssEY+cLyb6JWmNI1Ip1rt867odz
         r4pg==
X-Forwarded-Encrypted: i=1; AJvYcCUeYL3M47jEBB1duPvEhji+x21DY++eiyFIPyj+A2IPzkzdirGjgr/g9VfYh11JpHPHHGNvoeiiPXBXhT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEw22ALO2hk/+LECWCKevLqkVhe8nr61jf3iIl5JlA3svxZixK
	siTfKEECkL03WCjAJjOh0t3qfQxrX0mIsUCjopZtzikGKZgqesavzOPRKp0ws3UFebjyB1+mhU8
	3JeLgTyAeDO0waZkGy1JzA3+a80xTZka8MjP1Cg==
X-Gm-Gg: ASbGncuRbnAYppfH/KO779JOtJeullO8A0VcSmr+lTKhxfg598ZVvkpnt47zo4UNTdt
	zjYoDuPM0bErlKh5maM5BZqlzgnwK0ImKl5HUXj3aYh7R5Ir7rqUUjSQ+PoZNmv03uWk0NdpThL
	8N9V1Pv+iw/5qtfNTQlCmks5cHp9zagOrX5Q==
X-Google-Smtp-Source: AGHT+IGCsf6gs4boVKvi872tdBJFNBLIE72SzFHUnHiJ2uqF225HOjiewrQhZXAtHdFlZf9qfC6RwySnYBdeijJWt7I=
X-Received: by 2002:a05:6512:ea5:b0:545:3037:a73a with SMTP id
 2adb3069b0e04-54ad64850e7mr3708934e87.13.1742802819820; Mon, 24 Mar 2025
 00:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322035307.4811-1-ot_chhao.chang@mediatek.com> <20250322035307.4811-2-ot_chhao.chang@mediatek.com>
In-Reply-To: <20250322035307.4811-2-ot_chhao.chang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Mar 2025 08:53:28 +0100
X-Gm-Features: AQ5f1JrIT3jjMlJn7-UFm0QREZvmNoSOiORkmH7amKsqv7WDxLgWsH1QR8-hb0M
Message-ID: <CACRpkdZT1GYsZjeRHQqWJmuw5jg-kz7x+53_u8_Y3goyu=uRGw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] pinctrl: mediatek: Add EINT support for multiple addresses
To: Hao Chang <ot_chhao.chang@mediatek.com>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, Axe Yang <axe.yang@mediatek.com>, 
	Qingliang Li <qingliang.li@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>, 
	Chunhui Li <chunhui.li@mediatek.com>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 4:53=E2=80=AFAM Hao Chang <ot_chhao.chang@mediatek.=
com> wrote:

> For flexible routing, eint will be divided into 5 bases,
> and it will obtain the operation address through the pins array.
>
> Signed-off-by: Hao Chang <ot_chhao.chang@mediatek.com>
> Signed-off-by: Qingliang Li <qingliang.li@mediatek.com>

Patch applied as the last pinctrl patch for v6.15!

Thanks for respinning this, I think it will make things easier.

Yours,
Linus Walleij

