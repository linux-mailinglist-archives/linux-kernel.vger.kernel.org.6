Return-Path: <linux-kernel+bounces-544793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005CA4E567
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB8719C4B93
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D68C294EE0;
	Tue,  4 Mar 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F4T2dwhM"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E726036C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103318; cv=fail; b=Pih5Y6FYHtyKRiVuO4YC0BS7Bty0xXOHo8YMZwPsqiD3RdgNKkfYpsBzYHu2sAXoDop7uc7/xEyMoKeWXtiwBCKI7CRBjU6FUDPoYsaddnN7NFk+WgKEKY/zzits3f8wGr38T9hQNHh+fXoFn1oOdNsWU9gxj/PlrwIu71qoeVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103318; c=relaxed/simple;
	bh=OSJaI52yL64NN9H1ZhL3wMOqjSIqGPYVReqIJ1II8Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3ylgSfARwJzkXqzIFalToBI0Wrh5Lz7K4eB/Cs/+b9Gzu3aZdCFvHTt2kmRvNuuP/QijZz48n9xAu+Cmz5KQ+DRK2af3CLIeKxkLNFLkf/nx18Ffn8srI91Wo9OFpI5GDGLZU1kpeLAGp5Fs+8yr7gZJAPIND3tBw2TX0pmp0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F4T2dwhM reason="signature verification failed"; arc=none smtp.client-ip=148.251.105.195; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id A853B40CEC84
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:48:35 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=F4T2dwhM
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g6L5kZMzG1Td
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:47:06 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9D86F4272A; Tue,  4 Mar 2025 18:46:56 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F4T2dwhM
X-Envelope-From: <linux-kernel+bounces-541499-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F4T2dwhM
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 92E8241DDD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:14:04 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 297823063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:14:03 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2FE3A4078
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219841F540F;
	Mon,  3 Mar 2025 11:07:22 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F71EF0AA;
	Mon,  3 Mar 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000039; cv=none; b=kCoT874SFZCRpV9P/uNm+NrahUXoNj5YLqBmwJCAqQM3eBy4jGgt5vnYTxihtZ/QAwtQz/BI5b1C8jwxQK4uP9EbQ7nshYKScR5iHr+3hVEaTvNgYMAjnzChNVHfbh/7dWjxWOTSDQM1+MV6lHk9ewEHb+T/ydv1N9djAH43dUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000039; c=relaxed/simple;
	bh=ejDawKctgXUcBnB7UgkCPWZJM6BS3dCiGuUvJvku9u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAp7w1M7JNutg+n3DWFbDvm3GWYIgJgmkEO3nxQmjcgHXzGLPuT0fQ5LskjPccIOQCARZNXYeLl6p4DKwLYuKqvy8una4dHj/Ns+y+knPkH7dch5zkc+AApgN/H2B2eVUmVEqDN3SDg2UBO2aAzUqTxk0oqSc+KbuPD+SXQvYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F4T2dwhM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000035;
	bh=ejDawKctgXUcBnB7UgkCPWZJM6BS3dCiGuUvJvku9u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F4T2dwhM4ImI8g4gADFrhc0c41Rndv/7+C84FfLbybfSxzeomdZGxCLIpWAfTDXQv
	 ctxikbFCgLUdi/j+du1G8Bs93ePjsLN/BW4j1dppGJzja0h9+ooj3l0tDSwk1Em9HY
	 krUQH23+mnoSMZeMY0i7Gyz4NyZPLt4bnlPm64+B1Q6xeYoRmjOtpynrKKTXfIGUfG
	 e0dd0BJ52vqXD647mwTVOVayZW5QuGzZsHzPsgym9g6OhsVHC2vLrL5hUsP7WANoRN
	 kyJKaQ7fj4DMCQRmc3mepaZ24Z2i0+4I5lZftEho9Af7ynv2x5qJP0j2pT0DTZA+zV
	 i8GuQZ/sEvpvQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FC1F17E068F;
	Mon,  3 Mar 2025 12:07:14 +0100 (CET)
Message-ID: <d6056fa3-ad3f-4eda-8479-4548eddbdaa6@collabora.com>
Date: Mon, 3 Mar 2025 12:07:13 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/20] ASoC: mediatek: mt6359-accdet: Drop dead code
 for plugout-debounce
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-10-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-10-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g6L5kZMzG1Td
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708044.3932@3s3U3vnzImKW/KJMutXZrQ
X-ITU-MailScanner-SpamCheck: not spam

Il 02/03/25 17:30, N=C3=ADcolas F. R. A. Prado ha scritto:
> The mediatek,plugout-debounce property is undocumented in the binding
> and unhandled by the driver. Remove it.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>




