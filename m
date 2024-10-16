Return-Path: <linux-kernel+bounces-368571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F229A117E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BC02882DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB9212F13;
	Wed, 16 Oct 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3/wqtte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A26212F14;
	Wed, 16 Oct 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103190; cv=none; b=cGTpFK7ebDdxfGugm3t+v7HkOtKe53fxB04y3/r4OVZly9qtas1lgtoQ9EjqNa/FEjZXz5XcDWZsQ2HWq1/p7pz7tpGPjWvr5lRKxHG8kzHPo1vT2XZySSEeLDnJYKmG/JvN2nLah3GAhM+fWUlXlxS8ZZ+vBCWGkwCPi3JNtv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103190; c=relaxed/simple;
	bh=INU+T9bFBSys8He2fk2CHETpwsOLJTvd4X6kZLoVSFg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Uzr580TXUwECPPn0Y75Rz6jqS7srG28qLEIUXlwCJz0OA7HP/VX4QzSLnwcTHiGVZMwVsrECNjIkAEScxX6R0oZvsm/sreGMbWfPcVlMmK31ClweBx92tP7vAwaJLhcRJoLAd3C61wSAFz9sgtRImsKiS5etGC4AYlccwGK9nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3/wqtte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B85C4CEC5;
	Wed, 16 Oct 2024 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729103189;
	bh=INU+T9bFBSys8He2fk2CHETpwsOLJTvd4X6kZLoVSFg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=p3/wqtte+CbBQGIHDTZi/CKOCnicH6DXXAIR13AF8XcQ1kR1lo27/EK9BtItMTsxS
	 mJSsRaMJ01cmExzsYaNPNNFWvQTX9EsQlAdUAmBYDNhVI4kHhTby6ZoYy9uZ+rrc0k
	 o4WYTWmtOVWVfnqJYj0FGTZoiBLljyiN4tnwfygjlJAQ23nZzjNe3JE8luVfU1H5kr
	 5o0uyhJiLsrIr/NN2M3PCGB7LfKx2INJkhZp8mTW4iGxqorqXxJhJvv0YnakINGQ61
	 3LruaYfHn8dp5yTkgdj3jqIN6c5/1Av9Y3+oQSOOYITgU/motAd8b20yLjb1z1jQcb
	 WN1mrAfF6hBBw==
Message-ID: <64b271b946f944fea6994f85a57cda2e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240906082511.2963890-4-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de> <20240906082511.2963890-4-heiko@sntech.de>
Subject: Re: [PATCH v4 3/5] clk: clk-gpio: use dev_err_probe for gpio-get failure
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 16 Oct 2024 11:26:27 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-09-06 01:25:09)
> This is a real driver and dev_err_probe will hide the distinction between
> EPROBE_DEFER and other errors automatically, so there is no need to
> open-code this.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next

