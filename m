Return-Path: <linux-kernel+bounces-272616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686C945EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF6A282C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4781E4858;
	Fri,  2 Aug 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zabbadoz.net header.i=@zabbadoz.net header.b="EUHccVw+"
Received: from mx-01.divo.sbone.de (legacy1.sbone.de [80.151.10.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D91C2322;
	Fri,  2 Aug 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.10.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607057; cv=none; b=aI3L+ey84RDqjNvJqGyl43tAfVOtX8wK2Ak8G/+gDPIUjW0mYL+bX8CQDT41j/ZVsmODFCwhvgmHpEQUai0W9h0WtHaoJJn0PK8CFUW4nYm4Wm4rTsmZu0NmfwjqjqxG6pmkb27rsEuhVZI20B+4ETof11EssK1zVBjHgoE52SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607057; c=relaxed/simple;
	bh=5/XgeH9emBTwZkd45Z8QA3mktVHCHuE+a9qlMXeEXBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jQVhPxKD/Q0EixYw6CsLfY1QFon9FDwbPtIn7reRyAyoPUWytsdj5zqaQZmQwpKeQRzLvUVMa2aonxrVOnlQKUGQbvZxkIbgYiyglsu4iFdf3gwpn2UhyeD9nPeKAL+1/Nh7vPmkPwcwH9kzD/11iUO1Lht1f7SPgLUXWCGVxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.zabbadoz.net; spf=pass smtp.mailfrom=lists.zabbadoz.net; dkim=pass (4096-bit key) header.d=zabbadoz.net header.i=@zabbadoz.net header.b=EUHccVw+; arc=none smtp.client-ip=80.151.10.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.zabbadoz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lists.zabbadoz.net
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mx-01.divo.sbone.de (Postfix) with ESMTPS id 65DCDA64808;
	Fri, 02 Aug 2024 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zabbadoz.net;
	s=20240622; t=1722607048;
	bh=5/XgeH9emBTwZkd45Z8QA3mktVHCHuE+a9qlMXeEXBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=EUHccVw+gbRvI7Eo3mXMj2CB1z2h70vg0e87xOmxqyzcvYMkTG4nF4TzIQqBX2+hW
	 mJxwoj6nwr8/W4p1FMTDek3E9pPKr7sdex1jVBN5Z6FBneOUTIXkjffqAj5H1kB3PX
	 N3wFIxBqltfWfxD5WVLOW/en0BphZABfJhoScNbusu0B4nOQGbAcl1JNdXMubItRVY
	 s81d8q6VA51mtbm9zBI9TxPI5dm3zJy8XiypUucCDIa05ZA5b/G6e6kE8Hb3CMIfZm
	 Gca1V6ppNuqO10j96SVjkn5dwmH86F5WzB6n6BlmUpXo74vgKegnXNZCZrVTS0rzhT
	 NXv/9aupkZVFKv/pcgV5OfE8QG6J1y1p4z5jJIIV76E8v6B/6eNDzy0WJ0qOxC+nKW
	 69WLIOnf/RtStqK2SSIl5LmcgwZURR0I+C6jVR6IzdB+Jk4tRwohkXSzK2r/8COQ7N
	 b7TIv5ZOOy23SwiRmQnDkSonhKFMPP7ACI4YhZ0KO/Kb4ZLK28tk39CQpjJJjTVWuj
	 M3+pzIk0Dil4LyJnqrbM+WIKEBUjqsaHoG4caW8ZHP1jA8M4Ndi2Uv0/O702gQC0DK
	 TMNydQrZkGyxCWjQRadOsWoHKaLy8GbtbjY0HEY5YrTg84YWAM53U1K5Q72Ak5NtYm
	 zKlrvHUgggJF6GzDPx7GbEP8=
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id 8AFBA2D029D8;
	Fri,  2 Aug 2024 13:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id xhqxyI7DanWY; Fri,  2 Aug 2024 13:57:28 +0000 (UTC)
Received: from strong-iwl0.sbone.de (strong-iwl0.sbone.de [IPv6:fde9:577b:c1a9:4902:b66b:fcff:fef3:e3d2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id D13072D029D2;
	Fri,  2 Aug 2024 13:57:27 +0000 (UTC)
Date: Fri, 2 Aug 2024 13:57:26 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
To: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
    devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/2 RESEND] Add DTS for NanoPi R2S Plus
In-Reply-To: =?UTF-8?Q?=3C20240802100447=2EGB18509=40=D0=B2=D0=B5=D1=82=D0=B5=D1=80?=
 =?UTF-8?Q?=D0=B0=D0=BD=2Esu=3E?=
Message-ID: <4q216op8-0p0r-n053-383o-3rpqq8s37p4p@yvfgf.mnoonqbm.arg>
References: =?UTF-8?Q?=3C22bbec28-41c1-4f36-b776-6e091bf118d9=40kernel=2Eorg=3E_=3C?=
 =?UTF-8?Q?20240801175736=2E16591-1-jin=40mediatomb=2Ecc=3E_=3C756p9487-?=
 =?UTF-8?Q?56pr-88p2-6o79-7oron3q8462n=40yvfgf=2Emnoonqbm=2Earg=3E_=3C20?=
 =?UTF-8?Q?240802100447=2EGB18509=40=D0=B2=D0=B5=D1=82=D0=B5=D1=80=D0=B0?=
 =?UTF-8?Q?=D0=BD=2Esu=3E?=
X-OpenPGP-Key-Id: 0x14003F198FEFA3E77207EE8D2B58B8F83CCF1842
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 2 Aug 2024, Sergey 'Jin' Bostandzhyan wrote:

> Hi,
>
> On Fri, Aug 02, 2024 at 09:46:40AM +0000, Bjoern A. Zeeb wrote:
>>> I noticed, that a DTS for the R2S Plus is not yet available, while the
>>> R2S is already there. The only difference is, that the Plus version has an
>>> eMMC, so we can reuse the R2S definitions and only add an eMMC block, which
>>> I copied from the DTS in the friendlyarm/uboot-rockchip repo.
>>
>> The original has a
>> 	// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>
>> please don't lose the OR MIT as other projects outside Linux do use the
>> same dts files;  and the original r2s file also preserved it.
>
> Uhm... I am confused now, I copy-pasted the emmc block from this file:
> https://github.com/friendlyarm/uboot-rockchip/blob/nanopi4-v2017.09/arch/arm/dts/rk3328-nanopi-r2.dts#L7
>
> The header does not have the "OR MIT" in there, it's just
> "SPDX-License-Identifier:     GPL-2.0+" which is what I also copied
> over, together with the (c) part.
>
> The source which I was using is described in the commit message:
>
> The eMMC configuration for the DTS has been extracted and copied from
> rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/uboot-rockchip
> repository.
>
> Maybe you looked at a different branch? Shall I still add the "OR
> MIT" or leave it as in the original file which I copied it from?

That explains also why there's no sdmmc_ext/sdio bits...

See here for more:
https://github.com/friendlyarm/kernel-rockchip/blob/nanopi-r2-v6.1.y/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2-rev24.dts

My current believe is that rockchip/rk3328.dtsi needs the additional
 	sdmmc_ext: mmc@ff5f0000

block and the vendor setting for rk3328-nanopi-r2s-plus.dts
needs like:
        aliases {
                mmc0 = &sdmmc;
                mmc1 = &sdmmcext;
                mmc2 = &emmc;
        };

and also need

+&emmc {
+&sdmmc {
+&sdmmc_ext {
+&sdmmc0ext_clk {
+&sdmmc0ext_cmd {
+&sdmmc0ext_bus4 {
+&sdio_pwrseq {

but I don't do Linux a lot so I don't know the current state of art for
6.11 for each of the values there (I assume some need tweaking and
cleanup).

/bz

-- 
Bjoern A. Zeeb                                                     r15:7

