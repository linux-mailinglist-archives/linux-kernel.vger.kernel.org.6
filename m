Return-Path: <linux-kernel+bounces-556867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29937A5CFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC31189DD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2056025E82F;
	Tue, 11 Mar 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IYROV393"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F4263F39
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722311; cv=none; b=lvD3rxfsvlwvIp8/16ApqZDZAOgZ/3oteZSxUL00JvUoqepCQ/9a/qUdyeTxjzGx1BNiIRfoxWgZHYgmQKaRhFt3zHVf0koLoCfLSdxa6kLmvOIqUG1TtRE4ZklZByrQTn6KE1pJP/vrZX8m61V0YuySP8GHYZ1Ly5SMPdR1AL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722311; c=relaxed/simple;
	bh=2QZ5+1hf2x2oRIQkI4em1zNoU9lY+dMrOoGs/Ctv6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcVeLef6Dmxo6r5lXoJa1/kv+HfnH4VEh7u9NVk/Xc5GXYpUnpIOiSx4k8mk4TBoHceqL07u4H/3hi96X7ADrF7USPNgnHLv8MdHtj81vHpjq8jQaj2EbzXjns2yk0h5XcsXdr7FNjQfikBvrI6CqQwxOw2A2vx6FmdRyGvDHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IYROV393; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741722307;
	bh=2QZ5+1hf2x2oRIQkI4em1zNoU9lY+dMrOoGs/Ctv6KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYROV39306iQpZ4v7jOCgFeyCc1GFXFQBy2yLxFlWEoez5cAFOULJHrEJOqbF8HA6
	 ALAt8IwHH+o484vtVn9kZHKGKT4KTARY1Z6dboZQZq96T6uq8CYG7NN9WriNMC1Qvn
	 7+dGXWWxSWhKGdYWo2TjKez8ESCpXdIg17CgPb218DJ/cdOGYMSKHIjN+ATD+kbzae
	 mPXhpaQDycGyvmrraSBljBoX5HfmVmlHqNwTyBtCoaY6Pmqa/8xBWC72+dd57eHVdB
	 ohi0C3fp9QKn+41M/S1ICKIYBygzEAQSA3v8RkhptaHkQwQ+e5Si7nce8unz9A2kkp
	 S6nUGrf/paXsA==
Received: from notapiano (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A80C817E1540;
	Tue, 11 Mar 2025 20:45:05 +0100 (CET)
Date: Tue, 11 Mar 2025 16:45:03 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
	daniels@collabora.com, airlied@gmail.com, simona.vetter@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: defconfig: mediatek: enable PHY drivers
Message-ID: <717b84da-f307-41e9-9dc3-67ea653cac5f@notapiano>
References: <20250311061703.16850-1-vignesh.raman@collabora.com>
 <dc659e19-c1ae-42d8-84c9-0d2aafa81fe2@kernel.org>
 <daa0733c-14e3-44df-8374-33aba6662813@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daa0733c-14e3-44df-8374-33aba6662813@collabora.com>

On Tue, Mar 11, 2025 at 05:26:37PM +0530, Vignesh Raman wrote:
> Hi Krzysztof,
> 
> On 11/03/25 12:54, Krzysztof Kozlowski wrote:
> > On 11/03/2025 07:16, Vignesh Raman wrote:
> > > The mediatek display driver fails to probe on mt8173 and mt8183 in
> > > v6.14-rc4, with the following errors:
> > 
> > Which boards?
> 
> These are the boards,
> https://lava.pages.collabora.com/docs/boards/chromebooks/boards/hana/
> https://lava.pages.collabora.com/docs/boards/chromebooks/boards/jacuzzi/

You can use the Devicetree name to identify them in a way that's meaningful for
the kernel:

mt8173-elm-hana
mt8183-kukui-jacuzzi-juniper-sku16

Thanks,
Nícolas

