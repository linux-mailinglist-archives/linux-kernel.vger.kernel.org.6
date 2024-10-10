Return-Path: <linux-kernel+bounces-358084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A9997A11
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AAEA1C21ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76342AF07;
	Thu, 10 Oct 2024 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjRkX4Pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7610A12;
	Thu, 10 Oct 2024 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523193; cv=none; b=vAq9tXQeT9KB/xnxW/eAHgS1yPxXG6Cr/IeRpUV73vTPNWzm4VtlP5QOp70rWpgLd+buNP8dcm/B0tNwFsxBBgCJJn2RGRXpZescPISwvWQVT0CHACsZNdKazet0YcF/sN04QLc6ieKvOduwC+d/Vf4PqZ22o1FaA8J+vW6LBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523193; c=relaxed/simple;
	bh=7ibvhYnSJAiJ1OcmrnINL7GDYanGl1DLHCB1INahv/A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=W6OGohgyvR4V/vnDM0nlphSO9uatkB3LGuzaVpxLLtMtS+QYiZRsh3SmZWG6dfkAdiP9I51J5DevY5EY+I+XLagjea73e6XOx/PtVYSVmvEesi1WD4Bv5rznGNowhl9KAJE8qWB/hlxNo7SyEsyzHgSVDSdEe22ez4ltZOU+hqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjRkX4Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF97C4CEC3;
	Thu, 10 Oct 2024 01:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728523192;
	bh=7ibvhYnSJAiJ1OcmrnINL7GDYanGl1DLHCB1INahv/A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AjRkX4PjjfFZclO+CFvJVDc5m6DClxClhPEQH6SRQGwuYLhqFK+ctVX0w1SC4j9Tq
	 vP/Q//avbQ9B2z3oN5771b3ZtIWpe0VirMbhlS7QCSDGr0tmZNK0bg9fuyba+eEdWY
	 wQwnTQiPHnIfTR3mMn/9+3P2GrOkU12r9uHkTDbJNBTdyRZrXpBi9VodVEgEt/X5nv
	 tg+XENVSxgGZs+23SuQask9NJQCMpwhCfoZTWoVhhUWvBrm5kWaT0yGEetZt6Tgo4p
	 u5+ZalNRUF2aEELw7FOG6hxwXxa3wKN802kL4J48ki/V+G/N+Xh8YP7ej397eJgALW
	 kxTkC18g0yd0A==
Message-ID: <a007bf2fd2bf676348570882a70534cc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913191037.2690-7-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com> <20240913191037.2690-7-hpausten@protonmail.com>
Subject: Re: [PATCH v2 6/6] clk: clocking-wizard: move dynamic reconfig setup behind flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Wed, 09 Oct 2024 18:19:50 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-09-13 12:11:42)
> Xilinx clocking wizard IP core's dynamic reconfiguration support is
> optionally enabled at build time. Use the new boolean devicetree
> property to indicate whether the hardware supports this feature or not.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---

Applied to clk-next

