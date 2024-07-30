Return-Path: <linux-kernel+bounces-267575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0061941304
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174AFB26557
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DC519F49B;
	Tue, 30 Jul 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oyIKrgLR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8F19EED5;
	Tue, 30 Jul 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345654; cv=none; b=KBDS+ZUH6+uphPqOgrlsINSX1Zb2Ev68HjZnSp8LCzM8de1fKWELIFcDZ+XMjuU+QLF+avNOTUkcN6R2lRDyl2zbXvlVlcb1of9yFPkv/4qg4/E0QG6xQ1F5HJtBenV7VVU7W4Di57q3vdLf4qoa/db31ObMCskZnicXqDdmzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345654; c=relaxed/simple;
	bh=eXaI/4FwsIpMMOSXo9miQuvnjamSIypwnH2R9aE0zu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9RFwveTDtruOv4+/07HDzk5Dza1r6lLc7Rwm7/vgmOODTba6876XkrXJLvwvEZStsvMP0Jp5UNYLFCIEm590UCt3k3jPUbpZWsY4z/TPLdSmytdAfCcyhrwW4PIOqxqxeiD4rU879rPojd7od1xqz5J7Jk6vkcI1fR1WoI73nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oyIKrgLR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722345650;
	bh=eXaI/4FwsIpMMOSXo9miQuvnjamSIypwnH2R9aE0zu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyIKrgLR1b61z1jp1U8LKQ+bZZe3UCz2uWQm94URXzu4zoq+R9wvNZP5BRiXWXwVw
	 Efsgz/NSbmMmINLLF8Bk3bBM2tA4AlfCLgXudpsrGd4sUrnJxWybYUAqq4gWHWf1sN
	 u+Ov361y5CTxk8f3zV57dG7TUhdABz23Gtb4O+POaikg22Q36674DQClbLbuiqk5Va
	 lV7simRNIRhppRx6kXW8b4SLdOge9q9fYTn3AtNRgbSgz7yZjshLRB1kEX1v6NuSF2
	 AreCuWMCZ30/+Wav1R4erGt2sWgHpKS11zYxMIILl9lEHihD45MaGGyi9s6gfrchgm
	 4fnlYZpk9tINg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 478E43781188;
	Tue, 30 Jul 2024 13:20:48 +0000 (UTC)
Date: Tue, 30 Jul 2024 09:20:46 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Moudy Ho <moudy.ho@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8195: Add SCP phandle to MDP3
 DMA controller
Message-ID: <9820b8cb-2443-4085-a18a-264da51e0a08@notapiano>
References: <20240606-mt8195-dma-scp-node-err-v2-1-e14702e9d3f2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606-mt8195-dma-scp-node-err-v2-1-e14702e9d3f2@collabora.com>

On Thu, Jun 06, 2024 at 05:12:04PM -0400, Nícolas F. R. A. Prado wrote:
> While the MDP3 DMA controller can look for the SCP node based on
> compatible, it's best practice to supply the MDP3 node with a phandle to
> the SCP since that allows supporting dual core SCP as well. Besides,
> relying on the compatible search causes an error to be printed, since
> the phandle is tried first:
> 
>   mtk-mdp3 14001000.dma-controller: can't get SCP node
> 
> Add the missing phandle to follow the best practice and get rid of the
> error.
> 
> Fixes: 5710462a116c ("arm64: dts: mediatek: mt8195: add MDP3 nodes")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Hi Angelo,

I already asked in another patch, but in case that was missed: It seems this
patch was missed. Do you want me to resend it?

Thanks,
Nícolas

