Return-Path: <linux-kernel+bounces-537425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A342A48BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053423B5605
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC7224249;
	Thu, 27 Feb 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY1b0VZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB562777F6;
	Thu, 27 Feb 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695553; cv=none; b=IKrZTb+Yhy1ntEbbwrXj1guz/vbGlmOli8CvCH3I+igLjGJAUOdLFbc0oqsIuOKmHLD/ZzB2oanTAZ9LDuaZ3YDpndxfR4Z/J+QrPkkYRLFASUAdERcZs3AnEB2PEdZclG4qtXTP17zwpUjcbVIWR58xgCQrzOKd4UQbApGFdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695553; c=relaxed/simple;
	bh=u+q9YCLatUCSCnJTmJIom0ghzOsPFelG4Neix4m21bM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=BP7S+sHS7fmQGxCd16yKtz1+qBV0VdhBh+x0QkeMy3PP4UT1Pda131h5MhqueR/icSaZaQFcBgQ1r5rfNd/dE1o47ma8lFMB/cvsc9eaHWpHGmURGdIhQSlyNW6QN6ASIET8EaGnQazjZQqnRpf8CqHF7sdnabcKg2vuxvrzqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY1b0VZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE30CC4CEDD;
	Thu, 27 Feb 2025 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740695553;
	bh=u+q9YCLatUCSCnJTmJIom0ghzOsPFelG4Neix4m21bM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tY1b0VZONdhUTZ6kvJSq7QYwzREZg9If7wG5eVNbQhp3klRGixOPyr741z0txj+QH
	 Tn609WFuQLIGXzuOaVfC7oMMZPJSjrcOL+qaK+nE0O9N0G5nFuroM2QLR4e9CP/dRG
	 qhhEKTEZ/34jKWyoNMkZOj53yp3kj3id00VC+HM+Lk8ougOfgCZ9NKX4lWHJPhhIsX
	 ++1kZPp0nRIiKrRX58yn4KF/pt40YRukq2gtopfkeuHqycVp+JaXxvPbMLXPJqa7xZ
	 WRx3vvCA5JG0ehy4ciZBMrkJql4LPQmj9Q7ZFTm5snYGMXp2sQkHlm2pbciY/R2c4D
	 Ls8a+NeuawLOQ==
Message-ID: <3d27fad06ffc669d8d3661464a8f8c99.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250221075058.14180-3-friday.yang@mediatek.com>
References: <20250221075058.14180-1-friday.yang@mediatek.com> <20250221075058.14180-3-friday.yang@mediatek.com>
Subject: Re: [PATCH v4 2/2] clk: mediatek: Add SMI LARBs reset for MT8188
From: Stephen Boyd <sboyd@kernel.org>
Cc: Friday Yang <friday.yang@mediatek.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Friday Yang <friday.yang@mediatek.com>, Garmin Chang <garmin.chang@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Date: Thu, 27 Feb 2025 14:32:31 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Friday Yang (2025-02-20 23:50:54)
> SMI LARBs require reset functions when MTCMOS powers on or off.
> Add reset platform data for SMI LARBs in the image, camera and IPE
> subsystems.
>=20
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---

Applied to clk-next

