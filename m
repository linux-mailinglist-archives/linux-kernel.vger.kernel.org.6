Return-Path: <linux-kernel+bounces-256730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB393529C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF9F1C20D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C76C1442FF;
	Thu, 18 Jul 2024 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6dzLEk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78C770E5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336540; cv=none; b=ih/oXVeGKO24Q43cz97OQneIu5IejUelbh0CQf8XQ50MfSlIxSMhkiF06PQWjtw5GsDpFJIHcPi4FORfhgy1t5lBmgQsryxs52FxkaG7iX1dIEwLIYYYhlSWhoDUt+X5fOC4Xj+tAbVAx34kc4dMIUTbG/vOxSm7B5He1P+1HQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336540; c=relaxed/simple;
	bh=etln5i+KCjKXeiB4Ai0inUgrjSIg3MBG9s2YE267C/g=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IQYNI8y3Rsq8+aXXeT/4XwjA+ZUHWSNYtHYzK/cU8jPETJ5QTVBxiYmMAk7w3OZhkcvAlmKVIcx0Aawd3QNOJTEXBjMiJyYzez/MXBkesgwmk58WJ41g/RocQQTBgqe21B3V1z2Jnhmy6gvaQHqGsd4pYAGWJAzU8uFiySfnUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6dzLEk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCFBC116B1;
	Thu, 18 Jul 2024 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721336540;
	bh=etln5i+KCjKXeiB4Ai0inUgrjSIg3MBG9s2YE267C/g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=B6dzLEk9fzW4cVPkQHBA1j9ell0gg44uGRdPFSW/xrBk5bE8nlD2WmwUQhpy5PecP
	 FcWxX1thkhKi0Hda4ZEsmZVmKIn+dtAZZB7Uyo5rjpena53TgvpLVuSbt69Otfv09Y
	 BxO1tUySrvanCEzBtMrtMJapDPNA8CltLkbGHdYs1mmaeRInzTRvVh2Lhe3I0JgWQP
	 eK4q/GmE8uGy/1VmcYsdVZl6fbctMo7HoID84l8E50EdQLDjXyXVHyPoAihcg6WWNS
	 yPrUisr+g/q34d7xW/JZsEDHkNzlM/EZ88xU2c7RxGtCeS6C15yj5MzJG4F1b4Cgw+
	 pAvkHcH5pUsVg==
Message-ID: <d3ab76bb91e425b4bb6bf5d1d63e691d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240522-topic-spmi_multi_master_irqfix-v2-1-7ec92a862b9f@linaro.org>
References: <20240522-topic-spmi_multi_master_irqfix-v2-1-7ec92a862b9f@linaro.org>
Subject: Re: [PATCH v2] spmi: pmic-arb: Pass the correct of_node to irq_domain_add_tree
From: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 18 Jul 2024 14:02:18 -0700
User-Agent: alot/0.10

Quoting Konrad Dybcio (2024-05-22 11:08:17)
> Currently, irqchips for all of the subnodes (which represent a given
> bus master) point to the parent wrapper node. This is no bueno, as
> no interrupts arrive, ever (because nothing references that node).
>=20
> Fix that by passing a reference to the respective master's of_node.
>=20
> Worth noting, this is a NOP for devices with only a single master
> described.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Applied to spmi-next

