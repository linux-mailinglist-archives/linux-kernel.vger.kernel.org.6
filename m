Return-Path: <linux-kernel+bounces-544945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B9A4E6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D33424A57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970C27EC83;
	Tue,  4 Mar 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Oa72sakP"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752C24EA94
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105394; cv=fail; b=DBewy1ckThbNoED67W/dqAdMG4N0Cfz1NqYzc87OHyXhxqHB0z2tMNjcKN0QSdVpH3L430zjkN2oxEEYnlqwSFe20hxDrmz+Dhet9OO2Xf8lDc94BskpTtgVWK9exaO6nD88rNSzp31JIlq5orKY9TXynhvC9LuG/WSThG9ZPEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105394; c=relaxed/simple;
	bh=MBkp/v5Porpnnw5MibfjjX23zJNdZfMxVW3kAqL3NwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdWohImyU4Htx8CREJCbiE4p1akRNMSLT0SqNuiNd7IKD0IkLgY3nUQoSP0IstS97GIZbS1fOgS7PLhRDpzGrdbdFsUrzwPMAAkYe1anKt7EKWMSqsEX5NLOKHhDsg0zPuPQVHHp5JLwGmEygY30hzqBH5hBeInUUc9HgWrZxdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oa72sakP reason="signature verification failed"; arc=none smtp.client-ip=148.251.105.195; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 2D5C140CECAC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:23:11 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gqd34f0zG2VW
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:19:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 928294273D; Tue,  4 Mar 2025 19:19:07 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oa72sakP
X-Envelope-From: <linux-kernel+bounces-541495-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oa72sakP
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id C7309424F8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:09:33 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 7C636305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:09:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC82F172390
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520C1F4196;
	Mon,  3 Mar 2025 11:07:04 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20D1F3BB2;
	Mon,  3 Mar 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000021; cv=none; b=iYzNrNI85YeHp4eMYclL7MwA0Ognw0izjVYlkh5ok12F9JFmzSLfihkKP7crecBbRkZ9MRkg4jiJX83yLND3f/iL+DnVn8o7xEvFhs8Eq+mWwa2RIb7PGKHSgGB0jpgeJ5bEhRHcHdVkLCCfbLy3TCc2P/qnD2UWwgy2G2ho0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000021; c=relaxed/simple;
	bh=b3+Xdqb81IiwLAoh7b8p9zmgG4Hhtw3o80AXe+lcmaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0ajQ49HucuctWmv7h+hsoBeWjLeqYbIgq4XnMAN2WP8LBnldFMvp8z1OXtXcBusLlcxtf+Igs5X/PiCe9/gOgY6aQ/BG+XXnF+6u+JIqUsqShebdfOrsMAb5EPCkbaRmgxlyDbuvJE1jVGMfB72G4lliXaMCXHsaQWLizvOkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oa72sakP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000018;
	bh=b3+Xdqb81IiwLAoh7b8p9zmgG4Hhtw3o80AXe+lcmaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oa72sakPA+mY6MuNMvym/Ulzf+1mMz2H2MhjVi4CmH7uXN8cEhwtxBa6zF8cEKwwu
	 L04nLgulUTfSEmz9eQc8BAz95oJUYoD83IJq901oUwch4eRe+gVKtPb2/F0DMPaCtN
	 Porxm168SjeUtFnJDHn1OP1+G/r4lj8/D9iw8cwL76A2Ov5UEGrMlaV8JYvZFosigE
	 r0v252gRC7hhqm+pFQjJM8ZbAnNxKsaafwsIQfhE+2m0Ykucry/ZU0CWSkRzekk1CV
	 DptyICCuMskSCb4/o2YH8oYlOusbWsnC9IsX5hCAoH2SL0GiTK3Tn/KmoiMlXPvqHZ
	 APcWLj3q5oq1g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A549617E0E91;
	Mon,  3 Mar 2025 12:06:56 +0100 (CET)
Message-ID: <d9b64bb7-d4b1-4817-8d14-14ebabf40e88@collabora.com>
Date: Mon, 3 Mar 2025 12:06:54 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] ASoC: mediatek: mt6359-accdet: Always set
 micbias1 to 2.8V
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
 <20250302-mt6359-accdet-dts-v2-15-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-15-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gqd34f0zG2VW
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710129.01841@yve5WmzzWDUYYmNXm7dUjw
X-ITU-MailScanner-SpamCheck: not spam

Il 02/03/25 17:30, N=C3=ADcolas F. R. A. Prado ha scritto:
> The driver currently reads a mediatek,mic-vol property from DT to
> determine the micbias1 setting to configure in hardware. Since there ar=
e
> no current users of the property and the default value (2.8V) is known
> to work on multiple boards, remove the code handling this property and
> instead always configure the micbias1 to 2.8V. The property can be
> properly introduced in the binding in the future if it really turns out
> that different boards need different configurations.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>




