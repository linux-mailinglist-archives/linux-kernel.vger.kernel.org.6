Return-Path: <linux-kernel+bounces-227634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B739154CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC7C283898
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E0D19E809;
	Mon, 24 Jun 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkl8d41X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511C1428F1;
	Mon, 24 Jun 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247790; cv=none; b=h+KARC7TxBa6Sw9Q2rWXpnj8wMoS5/TQZbt54CBV/DSksMPr04g/b78AwPYCpt3gF2I1oKpR/QmqGPrAZgVm0zV0LUCR4a7GJueNf02qdsBQssJkP9217aIg5JbbJY3CZGrByzh94gTRPT0tNXs5zeV0LqMySo3usiDV5vD4vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247790; c=relaxed/simple;
	bh=+Bra0RkgrfLsP5dCznByNggwiEedk6z502yzyiYly4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfX9sCGhW5sL96znPBwyCrmiwZ/6tr//W0Q8QCqfh0YfJdFYW/SyJCEDRsWIApLDOnFsBdaj9JJIAyIe5Nz/rV7miZUl5vJ+nI/UUGA7JkphABVMaYAT7TD+PL/AaX4w21UOVDbG0ZZm7hzgZ9XPWYc5no4Y+QSsn5yd58ii5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkl8d41X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB4C32789;
	Mon, 24 Jun 2024 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247789;
	bh=+Bra0RkgrfLsP5dCznByNggwiEedk6z502yzyiYly4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kkl8d41XOwb9BjhSgBGRLCQCfLDAuvg3Hm7CYMeIkzBdAjG2iBgyElxV2L1yM2Wnq
	 Kb+kNk4vAq3PSuTpYYD/3167N53SPw8w9/DMSgFKotWWUVz2P0vBQD7qnf2/uEQ+ZL
	 +Gi62HzRYlm5czV6AsqqaMZONPbhJPQB/NkgKnlXiwDwuyu+uz/ghMobcGFzfVmifh
	 NoUIvxEbXLoChAnbhwkYh82L/hj/pzPT88Lx4cHafYT5MooH1haDbmA2U+bvhKcBw0
	 9PXjebkliKQgNRUm32rNjDDBZDBCs6Z7qwspM9HcOn1LGiw2ToJwsq3znNXA2WV7FV
	 HeGuOa3GyraBw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd8897c73so3270263e87.2;
        Mon, 24 Jun 2024 09:49:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJvjF7l0Usexly4goPofcZ/WB8Chn6GiKJX+EUvfyQypuIZnwCW2YprOcAKd7Ob5NpGQhFcrxQmC3pP7GYzGSZedGQry9X2JPWrnmrEJznUd2tQg23YTgRQvTj56Y7Ld5od2Vw6843Jw==
X-Gm-Message-State: AOJu0YxLQ3vHuExA1gT1E04X58x0EykFfQvsaOOdAUnEaws86yK6r8Q4
	iB21bHvt2O0lctBruuOL7ZoM9JYmxVhgbsOVOmVGXrUpt8L5M+DSx5TDXTQCd8j2vLVj6jWqltD
	CQ5YghhKomcIPjKD5o/SW2eqWXw==
X-Google-Smtp-Source: AGHT+IG0pBeW8ebE64VNR8DbL8ZdFf3AuTbc+Rvh/5EBZWs+PPolPm48g7EKW1XADebn7CulWGPww1Kogwh3acIjYUs=
X-Received: by 2002:a19:7518:0:b0:52c:da8c:fdf3 with SMTP id
 2adb3069b0e04-52ce183503emr2724071e87.17.1719247788246; Mon, 24 Jun 2024
 09:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531193115.3814887-1-robh@kernel.org> <CACPK8Xes5vp+3YpQ3L5ix=LaDv7oWtqGFVc8moQf4D+o3rnLjg@mail.gmail.com>
 <8dabf3d1-2d23-4adc-a804-2b7aa5fe16e9@kernel.org>
In-Reply-To: <8dabf3d1-2d23-4adc-a804-2b7aa5fe16e9@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Jun 2024 10:49:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+L6tKw+OzYVHSyou3eW5s7OChEbwqPe=qtQkRW=B+y-w@mail.gmail.com>
Message-ID: <CAL_Jsq+L6tKw+OzYVHSyou3eW5s7OChEbwqPe=qtQkRW=B+y-w@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 10:47=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 24/06/2024 03:55, Joel Stanley wrote:
> > On Sat, 1 Jun 2024 at 05:01, Rob Herring (Arm) <robh@kernel.org> wrote:
> >>
> >> The standard node name for I2C buses is 'i2c'.
> >
> > Unfortunately this can't be merged, as it will break userspace. There
> > is a lot of code out there that looks up devices based on the device
> > tree node path:
> >
> > https://github.com/openbmc/phosphor-state-manager/blob/3c1351cc2b631788=
76ef68f4107c9804d2e17dcc/meson.options#L140
>
> Eh, thanks for sharing.
>
> That's totally stupid user-space. The sysfs path to /sys/devices, or
> some grep by compatible, would be fine, but iterating over firmware/DT
> is just wrong.

Agreed, but Greg (and maybe it is actually documented somewhere) will
tell you that /sys/devices or /sys/bus/ paths are not ABI. /sys/class
is the ABI path.

Rob

