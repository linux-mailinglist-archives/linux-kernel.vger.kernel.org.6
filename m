Return-Path: <linux-kernel+bounces-440494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4829EBF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A062847D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB71F1937;
	Tue, 10 Dec 2024 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qnbA+GWZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174F1AAA2F;
	Tue, 10 Dec 2024 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872167; cv=none; b=I+r8iC2mkm8+qNM8BaY/i/Ztw6jcUKdC0DD4lpaUhGCifddEvOJuDhy2MszcmnBx2Ri2oGZKZs3YVizqERBbkuuhw5T4qDJ88+5kdsXJLYBD2iY0d++Fp5dfr2iv1WA7kzEbEHN07zrBBnd0qDk3vY8XrgMkrAoVMeOkPBP+b20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872167; c=relaxed/simple;
	bh=NBkLuPZICKLNwg7DivKanww+HiXGCWs1s7kCNckO1hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9KR70FKgQUpsuiwPGTui6b2CUCka8A46kFpQ/L7fN0a4au5JJvYAkHVkd/M0VhUlul1ynnCd77zcMkyHxgX35SdEe2wiyGSg0ETqWMgZmPNEwSzPLeElaXzRpvcuB93pbWeTEinnTs+ALrVs8ZRVJdb0xUZQgYBF59Bb8FoIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qnbA+GWZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WbsUv2uSUD6IdLlUiwGe9UBfCIFkso55xH3tnUJICTk=; b=qnbA+GWZqDmQmtnEbp1wOfXfHH
	pcMnTWVPMbmvNcTfsE2f5MuCJ3dgfqz+B8U379AMx4Y20MfXo1GMEY8LN5qpWX4C4kPOy+WZimTvW
	MtvfBXRoXlIQYZ0p1y/81CD4wwrDty/fKRZ9a7DBkU1tQov4BN1UpkDzaxwJWogNK3Y+38mjFvqMw
	VYVeyXC//lnGcdzqCkxOwGIkjrR/u9krKlx25+tt2O4IBqAIX+E5NDDJF9ZXW6oAwo635lLwxUXnT
	J8lNtS5ohd7eTI3XB+5kJIU6NpITTL+9VqA++HW78eN1x0G1xrb/konDNe4q9inch0FALGCg0lgmw
	JW35Zeng==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tL9Lu-0007Hr-QO; Wed, 11 Dec 2024 00:09:14 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, s.hauer@pengutronix.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, derek.foreman@collabora.com,
 detlev.casanova@collabora.com, Andy Yan <andy.yan@rock-chips.com>
Subject:
 Re: [PATCH v5 04/18] drm/rockchip: vop2: Fix the windows switch between
 different layers
Date: Wed, 11 Dec 2024 00:09:13 +0100
Message-ID: <5109751.mvXUDI8C0e@phil>
In-Reply-To: <20241209122943.2781431-8-andyshrk@163.com>
References:
 <20241209122943.2781431-1-andyshrk@163.com>
 <20241209122943.2781431-8-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andy,

Am Montag, 9. Dezember 2024, 13:29:17 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Every layer of vop2 should bind a window, and we also need to make
> sure that this window is not used by other layer.
> 
> 0x5 is a reserved layer sel value on rk3568, but it will select
> Cluster3 on rk3588, configure unused layers to 0x5  will lead
> alpha blending error on rk3588.
> 
> When we bind a window from layerM to layerN, we move the old window
> on layerN to layerM.
> 
> Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
> Tested-by: Derek Foreman <derek.foreman@collabora.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

> +		/*
> +		 * Find the win bind to this layer in old state
> +		 */
> +		for (i = 0; i < vop2->data->win_size; i++) {
> +			old_win = &vop2->win[i];
> +			layer_sel_id = (layer_sel >> (4 * (plane->state->normalized_zpos + ofs))) & 0xf;

checkpatch is unhappy about the length of this line (104 characters).
Could you please restructure it (helper var or line break)
so that it gets below the 100 character mark please?

Thanks a lot
Heiko



