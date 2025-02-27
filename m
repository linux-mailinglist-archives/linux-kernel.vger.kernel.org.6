Return-Path: <linux-kernel+bounces-537476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F6A48C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D48618907A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6104126AABA;
	Thu, 27 Feb 2025 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKtr77nN"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAE23E34E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697642; cv=none; b=pPkkflUfeTlhz1K7MynPt4lgVNkGUqptgBOR2fE/REwh9KPgqAXXnPWMKq/lqOSUu0iifitGbGVZ/UMomGT3uixTZooZyHV/BKdpPvqxOatOu/AqYqd4dlXGSjG7U67cS5EabXN1jwpM/yxJlgsQ3/mAAWZSv6IXmfojO838VYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697642; c=relaxed/simple;
	bh=vz1obdxJIIoDV20lR6JnE5eTn9ujKWpbRqwh9oeEfIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bkuund73z/Q3Gu4IAWGjtMXobuamdqefRr07+hVkaU2ilF+ZjK9jdAxNQPyfijSO/KkdxNxNU281nZTDw3/JB0HPiMYqzHSEnzcFFVzKBE+kP+2GQUL2r+NCHE0XkGmHgJ8yscLvhckvP9quZgkz+D9/zq+LXxcHF/VQYbW+m8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKtr77nN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307c13298eeso18512181fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740697639; x=1741302439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frw/Kxp/v2+PP+mGe/xu93cFHbH9YYmz+7s+Ghe+Vqk=;
        b=VKtr77nNb4ymvEhjFfpJCOJi/uffVf29PItT2KGqEbg1YLlQjbwC6hmRwZ/VBl5hNy
         /iCZDg4uJL7iD7oW26mwRqWrs2lGEaIm1VUDT009QupDuQaGUy+gVm8pyO5sKMUb4z1M
         IeIAdmU+42CWpD4EJQ8ssgsHO0V3WwlD0oh59BhFMOaF85rpHouAtr0J23mBdtx8Ly3o
         dYTvwwAUqX27UwdJJNIGDGifM32K7ZELdIzquK05iYZjaUz+Adx0hnMnKqJ+J7tUt6v/
         Sndl9voM3Do0/LQJMGqcuYCREo6sYW1tvICW2+wuZ1eG13RZPWdeBpYcSKly0+rsNtGj
         h5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697639; x=1741302439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frw/Kxp/v2+PP+mGe/xu93cFHbH9YYmz+7s+Ghe+Vqk=;
        b=rKUJscpWZ0k4jKEGCJShDMn5TBtpg5Yj4iBZA54ub7Y/uUyRbNKMppsVemHfQGQFFI
         muUejh4lWt1s/24DoHGrkB16VI6eUfWV1Mp3ab0oejUyjzkdKjVBd0rX9bILVRwabObL
         GEStrQbx/QJQ6Dfb2BzslpWY+E5SUVe9rabdUDc+JwgjObOT40/IljqM6ZgNPb3kozoH
         0ap3pa/4aAVu9qsVq/XZk4eSr0L5ZkY8uV7kY35bxa41jKTE5Xxd/C6y8Nn2UV1aHzNC
         2N3wwqOm7rQYoPZDH5SqwEwg6liNTZ6noI5Q1WMrxyMxAj8j1Eae0UAbFUwKW/WimwFd
         KDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtsfzEZ9AMxh6xtkJTHwxWUbsKcS3GWgmKyqv7NDiSo7jr86sIcWvsy/tXDEG67SVHq3xAmvTemlY+1vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIsLkIS8qK7BCBoU/adEVAMmJP/P22UL9Nof0fXif3H98e44fb
	rt1iIjDZrImSgLiLun65jn+sG+ke5vsHO8KipeUMJbaK8yr8vfVK7wmkgJ3m81LRG+RHKuXouuL
	UJHss5zXVRBSF0oCGouYlus2YuAjhboJr9jbcpA==
X-Gm-Gg: ASbGncvnbgm6D+6/jtYZz3mqD/HyjpkZBYUgFv9Ow3rgy+l4PA+X9al5UqPQHHV3UlC
	vyENMeNnziTSPZgqsTyIEkE6SFIDqUemmc9Had3yfnkmF5fv41lqXDTZwXRM4F44n5x7vkbZwKs
	RW2iS/Rig=
X-Google-Smtp-Source: AGHT+IFufz181XNYlSjaAjssVbP9sbOQz0B9cNRA45vok7xAon3DLgbajO4WEtqa7uIwsizRpA7u/lhxgF69lTQZ82w=
X-Received: by 2002:a05:651c:2105:b0:30a:2a8a:e4d0 with SMTP id
 38308e7fff4ca-30b90a8247cmr3926491fa.17.1740697639007; Thu, 27 Feb 2025
 15:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-amlogic-pinctrl-v5-0-282bc2516804@amlogic.com>
In-Reply-To: <20250212-amlogic-pinctrl-v5-0-282bc2516804@amlogic.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:07:07 +0100
X-Gm-Features: AQ5f1JqjsVFh7X8JQClBDzM8iluOtRQbPulUgXhGdh38CQTozMVRauwBZfmmZkc
Message-ID: <CACRpkdZg-9Zr3f7zG36x7jGvT46FRfRJ40khNZDdYb01-BGigw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Pinctrl: Add Amlogic pinctrl driver
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xianwei,

I applied patches 1, 2, 3 and 5 to the pinctrl tree on this
immutable branch:
https://web.git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.gi=
t/log/?h=3Dib-amlogic-a4

On Wed, Feb 12, 2025 at 6:24=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:

>       arm64: dts: amlogic: a4: add pinctrl node

Please funnel this patch through the SoC tree.

If there are dependencies, they can be pulled in from the immutable
branch.

Yours,
Linus Walleij

