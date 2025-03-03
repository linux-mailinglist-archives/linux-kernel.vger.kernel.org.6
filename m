Return-Path: <linux-kernel+bounces-542867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0BA4CEBE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6100216A960
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D628E2376E6;
	Mon,  3 Mar 2025 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scXsBnqs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBB1EEA2A;
	Mon,  3 Mar 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042128; cv=none; b=UnvFmg11Xj1ukWNRJcn/7ocQod+yHMotsoNGQr5NmU+jEpUITX/UyaJd4GA5If8i6oyLbMVAApxq/qPkIFCzV/hW3r2XcmHZJOE0iUw8IWoiOL31qgKcTZWkID6ciFXdZF0xG230LE9E52z+D/zGw9ct+tj84qwaST4/vyL+xVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042128; c=relaxed/simple;
	bh=Ha4sShBQdjNN36LSosL+pmUD94tJnQYvtnzVPSDiu1w=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=jq1D3Lcjr2e3Zd8DE3tpouQfH4SyFVFQH0eHR0SPl74Iuu25BB8R8TV4UekdF/2n0+aTjXCKdOYyidOPuf96kUg/CLdilNRHHyI1zr7hsd+D0krGFf/AjTvmmFWyr80jBJGV+ldikKuf7/2R5iV23pzeaIalhRT2UqLStq2BR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scXsBnqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6139C4CED6;
	Mon,  3 Mar 2025 22:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042127;
	bh=Ha4sShBQdjNN36LSosL+pmUD94tJnQYvtnzVPSDiu1w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=scXsBnqsOpmS0GR3fk40lCDl42BACMUoDHzBRKqLnn+pdqxl0YZKFWUHMLFfadeUI
	 QKkprtb6t8PAROg0L1arHmc3hXFhg3J8hU0NlwZUS/HJD4aoCTyBGo4PLGeuCogEv/
	 J5zYrF5TgEE2jGC48faQcQk0eEMwtsFT3zTA/SEfp3kqdH7B4C8ja3bABOgvf/HqHj
	 TZoO/6kQFiSSQynAnfE064Gwu7CVUB4T31ZTA9JxMxSwJe1PeJrB3t9cdTnbdIvghM
	 KoI0QX8njKqL70/9PvamlibVDDfhUOAqR+FFkfWm23/Qjo8jiyI4xDRSmxUQXkhHqZ
	 SI90QvQEl1IBQ==
Message-ID: <93b5004dacfe1151ca3abbb0fa31eaa6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250201-topic-ignore_unused_warn-v1-1-f29db78cea3a@oss.qualcomm.com>
References: <20250201-topic-ignore_unused_warn-v1-1-f29db78cea3a@oss.qualcomm.com>
Subject: Re: [PATCH] clk: Warn (and therefore taint the kernel) on clk_ignore_unused
From: Stephen Boyd <sboyd@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Date: Mon, 03 Mar 2025 14:48:45 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Konrad Dybcio (2025-02-01 08:52:30)
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>=20
> If any sort of ignore_unused is in place, it means one of:
>=20
> * power is going to waste
> * the platform description is incomplete (missing consumer-provider
>   relationships)
> * the platform description is just broken
>=20
> Many people will happily declare their job done when a platform
> magically happens to work as they make use of bootloader-enabled
> resources, which then leads to double or triple the amount of work
> of another person, as they attempt to reduce the unnecessary power
> drainage and/or ensure stabiility throughout a suspend-resume cycle.
>=20
> Issue a good ol' warning (and taint the kernel) to make such cases
> obvious and hopefully draw more attention to it. This way, it'll be
> easier to avoid effectively untested code or DT description getting
> merged into the kernel, or worse, going into production.
>=20
> The clock subsystem plays a crucial part in this quest, as even if
> the clock controllers themselves don't draw a lot of power when on
> (comparatively), improper description of clock requirements has been
> the #1 cause of incomplete/incorrect devicetree bindings in my
> experience.

What is a user supposed to do about this warning stack? We already print
a warning. I don't see us dumping the stack when a driver is unfinished
and doesn't implement runtime PM to save power.

