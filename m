Return-Path: <linux-kernel+bounces-252967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E3931AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B21D1C217A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A865139D00;
	Mon, 15 Jul 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9QY4RYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCF8120A;
	Mon, 15 Jul 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070643; cv=none; b=tULWUKN5Q+WuOSaM7Tlfqx05brdiwrPXkILXGPAQWf/OQ/wGgfJJwULeHJGrqCnKfeP94g67kI+jX1vNJtXnJV0ziANk0ntQu5wkvuVBd2GlB40C6PPOw39/SKQ/B9LH8UIN8A6jgZBLSEdJ7hLSFu7Yxvn/NYUOkjxTc1FYstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070643; c=relaxed/simple;
	bh=90dN1i/RdIaAfX4f5m/aBEH2BBi6U95fhiT1/0tgZfk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=An6tg7+rridCpEXk0CQ1ZCzO4+SJZrygwX0QdLyXEoUzuGh9Jg8Q7Hjd9cTT3LaYS9vf+nmzllU5EOWQqeV9UgdCLU6LkVePCK1qsMCrac0qqFEaqYMcoUqCvqG0Zrn7ajJgHKEFpe8Wvz13rBMlYh3MbzxGOXFdK8V5XD5p2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9QY4RYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F62C32782;
	Mon, 15 Jul 2024 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721070642;
	bh=90dN1i/RdIaAfX4f5m/aBEH2BBi6U95fhiT1/0tgZfk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=m9QY4RYoPm9esneh9990iAT+gB5JatNPV7zSpAbttHTI1b0nF6OvwI9leLgL+sqWW
	 DEFi08Jyw7v9WYpL1yvieLvro8uZHh243dqRpZdcJcLpKgoYbfSN3IVdDlvWbQiGo9
	 p3hFXpEwy+cbnFwbvZU6g7FdeY3xWbU6FLFnnf2jnXEL1NahWAkHQHJA7judK3C2eQ
	 OWui90fxBsnaN1AIx5lhO1XJbg1y/fGC5NSFA0GOVnN1Gbwdbld/MNMEpntO57DouS
	 EJVKOsWZrzYvUfIMA2rcDXXlDdjIWCTgiZHZtx0tbXhdVsqbe91h7cGD77d6OHglgu
	 58k/530JQSzaw==
Message-ID: <91c750b79c9d2b2ae70f07177546a214.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240711-th1520-clk-v3-2-6ff17bb318fb@tenstorrent.com>
References: <20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com> <20240711-th1520-clk-v3-2-6ff17bb318fb@tenstorrent.com>
Subject: Re: [PATCH v3 2/7] clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Yangtao Li <frank.li@vivo.com>
Date: Mon, 15 Jul 2024 12:10:40 -0700
User-Agent: alot/0.10

Quoting Drew Fustini (2024-07-11 09:56:20)
> Add support for the AP sub-system clock controller in the T-Head TH1520.
> This include CPU, DPU, GMAC and TEE PLLs.
>=20
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs=
/TH1520%20System%20User%20Manual.pdf
> Co-developed-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main=
/docs
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---

Applied to clk-next

