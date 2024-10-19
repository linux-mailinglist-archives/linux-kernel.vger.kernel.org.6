Return-Path: <linux-kernel+bounces-372648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF49A4B70
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C56B22D41
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8FF1D7994;
	Sat, 19 Oct 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU8mA0dy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB728EF;
	Sat, 19 Oct 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317695; cv=none; b=RDyk7ggpj2lbQVKX2HemrmYII0NU52ROZUPRXpqVJfsHqbYEN0p9cKo0JUyW3BTLlJsXPhawGu96uTIgljp3NWNiWqH5K/iiVTHEpgvnsxm5bK4bmF8BedgQJkuUEmQJzj2bgjnBBo/NV85YxJo+Coh4Pie0Q874MEvpE+NBS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317695; c=relaxed/simple;
	bh=+Fnqmn6BOqKAZ8dtvHzU7eGaxF36LgiOVums7PQkoCk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NPkJYl7c1pQMKZ7lQgHoFhPNx3gtjphqwBX8kfdatu1xy/XBYUujRPCbned7Mw55YZT1DNz75cJbt+YcX1r2UlBZXSiCMdhEUvhXdtDsTX/07zXrlFTjBX5PPu4p9+R1LfZi7Ae3aUPHw2R/Cpk71fPZfYJqeuS1Tmsg8evQoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU8mA0dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24962C4CEC5;
	Sat, 19 Oct 2024 06:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729317695;
	bh=+Fnqmn6BOqKAZ8dtvHzU7eGaxF36LgiOVums7PQkoCk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WU8mA0dycis5BqRUdQ++nWW3OcFmBpMlJR+DaH+tEC4SviJ0LEFw/QWKtTxKjXAdd
	 q24nSw7hPOkFL6IEHtpFRk1+ucVc93Hum5KvJ3BzN/ri4emOhVeksvaQU/DUdcPDpQ
	 YZye4SHzCfvd/C5d1o2RHXxLY7VL+FQCYOzyw8WB+1VvqxtRMk3STd6SxG8PMXmEDH
	 n/2ZDeG9h/71xFAfXWWPHoJJ4qeybNmk2SsaKlhYU+DhOZ1PlWfvBgkAiIanPuqy33
	 R9az8D0Tmm29OhCmmArNlJaRuqgwyOLbHQ/5uP5hNU85RR5N4I92IYaKFm8Ls/LNRK
	 SfnmM+3CD9mFA==
Message-ID: <26a9c9278d66511238e11eac619db9fa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ab1fa4c9-6b4d-41a4-b337-ce9d7f5052ec@tuxon.dev>
References: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com> <a20e6927d38aed4e5b1cb1f49346ca29.sboyd@kernel.org> <ab1fa4c9-6b4d-41a4-b337-ce9d7f5052ec@tuxon.dev>
Subject: Re: [PATCH 0/4] clk: lan966x: add support for lan969x SoC clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Daniel Machon <daniel.machon@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>, claudiu beznea <claudiu.beznea@tuxon.dev>
Date: Fri, 18 Oct 2024 23:01:32 -0700
User-Agent: alot/0.10

Quoting claudiu beznea (2024-10-18 01:34:16)
>=20
>=20
> On 18.10.2024 01:59, Stephen Boyd wrote:
> > Quoting Daniel Machon (2024-09-16 02:49:18)
> >> Add support for the lan969x SoC clock driver in the existing lan966x
> >> driver. The lan969x clock controller contains 3 PLLs - cpu_clk, ddr_clk
> >> and sys_clk which generates and supplies the clock to various
> >> peripherals within the SoC.
> >>
> >> Patch #1 adds compatible strings for lan969x SKU's in the dt-bindings
> >>
> >> Patch #2 makes the clk_names var const char * const
> >>
> >> Patch #3 prepares the lan966x driver for lan969x, by adding private
> >>          match data.
> >>
> >> Patch #4 adds support for lan969x
> >>
> >> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> >>
> >> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> >=20
> > Am I supposed to pick up microchip clk patches myself this time?
>=20
> It's on my track. I already have it on my local queue for a while. Sorry
> for not mentioning it yet. I need to run some tests.
>=20

Cool. Thanks for taking care of it!

