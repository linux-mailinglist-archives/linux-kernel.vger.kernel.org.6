Return-Path: <linux-kernel+bounces-179437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43038C5FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB272871D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFE3BB25;
	Wed, 15 May 2024 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaiqBTXV"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68577F7F2;
	Wed, 15 May 2024 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748795; cv=none; b=aEwyTefGN4ajaxKFJu6QTJVWFn5M/2EWUNBojmOAU7KjID5K3Nvxmgld8BJ90fYgD8LaVBv3V9n+clj5bffDc4Si7ZWgze6smyoDqkHypVdaWVYaEK//MS4TvR5xqn6lsE5ztTS6FINWw9BpiDDJ3tp5xNT2Ovhie8o1DIJ3bdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748795; c=relaxed/simple;
	bh=qPls4b+1xeuUeDRk+txLZyx8e0JGp6v+slpeddj2bgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCXEB4BJpZq2OKkVxI9WZmCQ/LUyjQufAByi1uPpWBEJxYk58Jfv28eJKLTRAwIRqBMoEQFBuNQ5hvC43+V8YJvTLGZWMJYtejOLRqpLPCyPD0hN4XqIg18/2lN3+jwTPIlIYTlmc1wvo6fRdJS15qJfJGekIf9IQVWuJ9rccOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaiqBTXV; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7f16ec9798cso1574361241.3;
        Tue, 14 May 2024 21:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715748793; x=1716353593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aesBuOS+4Ftj63tZwTxdkb2ZpDV/W4tpYUDHgmuprMI=;
        b=BaiqBTXV5Z0GntaxSPiIl8BdEP331lZfkoa/F9cPDE8JxpjVAL6uoC4a1JBo60SIcI
         ZAg8FGXdYyn3hb4vYyfUoOy+p3O8gKfU0IyrVM0EzgR9jQSAvSjoHIIqKailWkgsGY//
         q86OY2my25eILgHfkqVAnsioAEgEBDcbPa0ZiGXPcWjySoAhHs4WoUw/9CuAf+wkKzVu
         P2EkEY1DlXqT8JDGornzm1Skerv/alqsjJ6Vpf+XUAWtcqZKIthZbUNBZxBQE88IADYB
         fJsMncBkrGQ+F+LvhBJKbwFmCEMZ5Txyq3GKztTngENtRxrYD/CegiV1PAtLKUm7QQZ3
         pj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748793; x=1716353593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aesBuOS+4Ftj63tZwTxdkb2ZpDV/W4tpYUDHgmuprMI=;
        b=SIGeoHDNZfNhXfxzfhZnmir++JeVfldoEcex3KGqfijZr00RN/ZueJCRc9QUBDjabQ
         396VVTcL6o1iQZmhRORk0ssRn0n0gIWhKUGy+ZP3jMnVZCWs6gca80yrfMK60TMhyys5
         Ocp4BVakykfUkK8tTAcvb/xbFhul/FYL7/Aqiup3Zz2q1Wi5gpPgBRd4atygZQ+mbZic
         052hh0pSPM+Ph3SZc3gD69ytQz3UzrlqorqTY3wkwzW0pn4mkyw2+Z14Q1bGP6eIbhJi
         q+32iUfFIgeQ55/Kmv3NNQLIWEvVwH1vRy7Y3X+ozgOJLkKl7D3Hweur/bJHhSR0p81X
         yJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXfMAMoYeWn845Bynz3baNGYMtvU7IwuxJhaYnFAMdtQ4eALDpg1WwtelAEJSvvRjesGisSYtq/DTmek/JY/AI5S3iSx7fNdmmZAUKSaY7l4Jin9+VkuxkBnpnE2Os1qIRqcSZYw/akvw==
X-Gm-Message-State: AOJu0Yz/74N+Ag9qPdE1XhOIZbeWB6VXTZP5tJaOx6Akbss8lgHdac9r
	JdO8cEm0TfhCjmXqukPrmEpFQRMQ7t6Yt7Bzon10xowWFM4ENGNmLbtQd5tmmhS1cCWs+XYHRUb
	VKBgif1fc8GRIF5GRDitBNOzjHaqLwc37Q6U=
X-Google-Smtp-Source: AGHT+IF2K1m0sHCmcxiXGK6ADeM63o/iTW26THXE/tTpqt+3SoPy7O/zfOt3/q5GgcYKxJwG1alNpwpjd/cBB4fDgWc=
X-Received: by 2002:a05:6102:3709:b0:47b:dc91:e69 with SMTP id
 ada2fe7eead31-48077e7b9a0mr12040050137.27.1715748791209; Tue, 14 May 2024
 21:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423150728.91527-1-sheharyaar48@gmail.com> <f60aac7f-dbba-4cba-8bb6-302b5c911b8c@linaro.org>
In-Reply-To: <f60aac7f-dbba-4cba-8bb6-302b5c911b8c@linaro.org>
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Date: Wed, 15 May 2024 10:23:00 +0530
Message-ID: <CAHTLo_=Gg-KN2zOtjOBCxQURq+Ap913Miph2FMhvkoV+GybFNA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vt8500: replace "uhci" nodename with generic
 name "usb"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:46=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/04/2024 17:07, Mohammad Shehar Yaar Tausif wrote:
> > Replace "uhci" nodenames with "usb" as it's generic and aligns with
> > the schema binding.
> >
> > Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> > ---
> >  arch/arm/boot/dts/vt8500/vt8500.dtsi | 2 +-
> >  arch/arm/boot/dts/vt8500/wm8505.dtsi | 2 +-
> >  arch/arm/boot/dts/vt8500/wm8650.dtsi | 2 +-
> >  arch/arm/boot/dts/vt8500/wm8750.dtsi | 4 ++--
> >  arch/arm/boot/dts/vt8500/wm8850.dtsi | 4 ++--
> >  5 files changed, 7 insertions(+), 7 deletions(-)
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

Hi,

Is there any further feedback or update for this ? This patch is not
yet merged but the related dt-binding patch that has been merged :
https://lore.kernel.org/all/20240423150550.91055-1-sheharyaar48@gmail.com/.
I understand that this is a trivial patch and the maintainers may be
busy with important work.

Regards,
Shehar

