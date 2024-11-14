Return-Path: <linux-kernel+bounces-409922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F579C936B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D81F21DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E901ABEC6;
	Thu, 14 Nov 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7KQRvrx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189A2905;
	Thu, 14 Nov 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617398; cv=none; b=tD0834/P6FhRVgsAq0ejBtIJONMXf5IIfm5Ck8owRA2PVgGzS4FfgbOvFesb8s1QEK5D0yhdIsbile15qBY0Irf41gjQOZQ9iORxNNEozVqXOlR7JB7q1EOyluohHK1hr9kpC3h8iNgWY5ZFaBUWAdnzrXxoKabGZPGzymAg8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617398; c=relaxed/simple;
	bh=LV1jvtTHD8oxGY+aU4BBAkGkf2mCrU6ddbJAshVW4WI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=slohnlVcL0z0LdAUIJCvWhCS4bsQL+myOsXAEr8WcD35AR/YaTEMHskDkVuHkbQ+j3jd4f+xMUfHFPwLUYR0nKS+l9j06rFrC6le1AiD+BXBbSl3lo5DD7HNpCxTDRc/3Q0Yk6uNminKA33ZbegWAc2cxP3Rcl49y/QdInOIP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7KQRvrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D7EC4CECD;
	Thu, 14 Nov 2024 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731617397;
	bh=LV1jvtTHD8oxGY+aU4BBAkGkf2mCrU6ddbJAshVW4WI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s7KQRvrxJbDXzUcNc/yAgTA7zsF4XqV3s5UdCB+75Iaxeg8f3wEFSqYuOc4wsEjD9
	 H2thBG93YEBPb+H6reIqGRidZzHL2THLV5hGhPK04g9mesXT9pv7iGdlFx66RuyT84
	 FTeDDdtmV27dMoLEzgplNflEqjNC/VM+vdEWMMwk1184uHI8yBJ5NzinrB8URc0ZN6
	 n2SRAvaTio0G4MYMjeW0m3/zLv/7Za0hrtxKVUk6G5/GvkPv+8YgE0NLAaK5CbMYCS
	 xBZCJNC6uD+UQ/bFjqSNWQf2Pt3X6TZl3BMRxUZue/RyQn3wC9RXU3vBoHN4USCCqg
	 vGLIgsv0rQOjQ==
Message-ID: <4d2c2fa787da390add0a4509b9d3ae6b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240910044024.120009-2-sergio.paracuellos@gmail.com>
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com> <20240910044024.120009-2-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH 1/3] clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, tsbogend@alpha.franken.de, yangshiji66@outlook.com, linux-kernel@vger.kernel.org
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>, linux-clk@vger.kernel.org
Date: Thu, 14 Nov 2024 12:49:55 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Sergio Paracuellos (2024-09-09 21:40:22)
> Clock plan for Ralink SoC RT3883 needs an extra 'periph' clock to properly
> set some peripherals that has this clock as their parent. When this driver
> was mainlined we could not find any active users of this SoC so we cannot
> perform any real tests for it. Now, one user of a Belkin f9k1109 version 1
> device which uses this SoC appear and reported some issues in openWRT:
> - https://github.com/openwrt/openwrt/issues/16054
> The peripherals that are wrong are 'uart', 'i2c', 'i2s' and 'uartlite' wh=
ich
> has a not defined 'periph' clock as parent. Hence, introduce it to have a
> properly working clock plan for this SoC.
>=20
> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS =
SoCs")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Applied to clk-next

