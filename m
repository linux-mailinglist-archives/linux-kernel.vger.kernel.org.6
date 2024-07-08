Return-Path: <linux-kernel+bounces-244824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C692A9EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631981F2286D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF614D6FC;
	Mon,  8 Jul 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4psoOl1p"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C814B97B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467681; cv=none; b=H6w9ZQVKlqa/fLoo1PP5IevB7eU6NcO/9G5M6285p6ebYFCa+R0ixgkzDyGosrOe4+ndZP68ZRWdp82DVyc/gF/FNYPI7ZeIleib9SLdEQzGmhHRcVrdWQaBl/OeSZbcs5PXdePWU5kybNeHJDiryq+AKE4+BQTI71z6kXgi4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467681; c=relaxed/simple;
	bh=dOch4uHVwbdqhpbBV02MHHp9f3drQ4HsNxri8gTA2+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f86Od3jLo0lE/NQCJk7MJOpYGUrDdXMnXd6Txn9p8PhU6IY7ve8KvODzRExXjEAbJS1ejzEojka3bb/eVy3hym0ap8mAiQy7rzAycM88yQVquqobtbFq3GI3A4C1iVqvGPFetNLK3tMDlMk79p9XRQ/vK32qbnulri1J83dy2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4psoOl1p; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720467677;
	bh=dOch4uHVwbdqhpbBV02MHHp9f3drQ4HsNxri8gTA2+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4psoOl1pmK2PjRg2Yhg6judHKiY5A5m4nLsOe9zY58Y3C/syatG5SCwMXB6RQ3uvM
	 lmgEXXcXBsWBhM/vmMloatC5WI5vqDX9+dDtq/GxjwNvhcxHfI7Ah7lr6AB8AhzPSP
	 K75lTFKgxYPjcVdOINjCzMFdFR+gfzg5OoS3j6bu2EKhlrl5LsA1WAvpYcQqlJRlyl
	 J/2ySoNymxM3VaKtdId92aeeonAmIC8OXeogoyj7CQzmJM4qd2OU/DL6xF2Dgks1V5
	 sZFyhpGq71ep/BTjn9aYOB/9u3UlTKZXoMr84W5bXsktvdrlfHd0s/CToP0/oPSuGK
	 DFv7OMe13+xPA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2CAD0378042B;
	Mon,  8 Jul 2024 19:41:14 +0000 (UTC)
Date: Mon, 8 Jul 2024 15:41:13 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] nvmem: mtk-efuse: Only register socinfo device if needed
 cells are there
Message-ID: <09652279-4148-4db2-b4d9-ef2393f1b0b8@notapiano>
References: <20240708-mtk-socinfo-no-data-probe-err-v1-1-fb2acd3a47bf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-mtk-socinfo-no-data-probe-err-v1-1-fb2acd3a47bf@collabora.com>

On Mon, Jul 08, 2024 at 03:35:42PM -0400, Nícolas F. R. A. Prado wrote:
> Not every efuse region has cells storing SoC information. Only register
> an socinfo device if the required cells are present.
> 
> This prevents the pointless process of creating an socinfo device,
> probing it with the socinfo driver only to ultimately error out like so
> 
>   mtk-socinfo mtk-socinfo.0.auto: error -ENOENT: Failed to get socinfo data
>   mtk-socinfo mtk-socinfo.0.auto: probe with driver mtk-socinfo failed with error -2
> 
> This issue is observed on the mt8183-kukui-jacuzzi-juniper-sku16
> platform, which has two efuse regions, but only one of them contains the
> SoC data.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Sorry, there's an include missing in this patch. I'll send v2 with it added
right away.

Thanks,
Nícolas

