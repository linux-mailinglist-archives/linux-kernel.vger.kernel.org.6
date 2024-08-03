Return-Path: <linux-kernel+bounces-273511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C141946A18
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45285B212A9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5B1509AC;
	Sat,  3 Aug 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pZgrmZ/F"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3198C8F3
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722695703; cv=none; b=f9bCKvzg86M7afTYBUi/pUoUbDmdY7xKAgXFgUcYUf0Li3V1Jnl9i/hVMaJdfCA4Ts4uOHlfhEzcNMsiPojDAtAuMjtuyAN+8Ld4qvlA3JVqeBWCBvWeKrVqZXdcHs7h+V2KOztPdFfcJFf6FZV85aAXdo9jMjnOnTuROggJkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722695703; c=relaxed/simple;
	bh=5pFFzSTcujJdisegGS8FWdXFpF2D46MNMhS2XZUFveE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvVjtHhyJ4McS6KTfw7Y3zlsuFU4tFfaHM4XP9y6yh6oFQrgmKHHx5eby7hCopJqUtL3+M9hxITCBItzYuHKqBdSv0Nom6ZYhx2MoBKQWKGa2Tapvi0rtg3PoycJUzl1gDSjs1j/g7w6NZbuJpP17ILDhzCant1piE3+EQEiF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pZgrmZ/F; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722695700;
	bh=5pFFzSTcujJdisegGS8FWdXFpF2D46MNMhS2XZUFveE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZgrmZ/FnfVa0pBoimKJdixtWO2F255W1Rwof4O6C0HD7pOnvBp7v/sC12kvjaS1i
	 ycnSd5+ygRrmaY0fX7u/7l+HYPCRT1eWYyCj0cTEowuTi//t8WrgEkEbalTSnTWdpN
	 aSnONEUJuVLxK9xJS6XcGb1dK57ZU+ozgCIrgZaQ6ZsqcUCThCQWiTVMM6C4cchtHh
	 Pj+mEE1rzqrjmlf95e4MFnOepQXk07/zRlhmV/SnE+rw905vwCdOhtL7J8/gendJhh
	 x4LGKvXAfKWac13InTa9zmNtZoT+hxC6YC01MDOt+D9rYTDpKChVXQ6JJoXByZhjpi
	 GTwgYtUHAA3CQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06CFF3781480;
	Sat,  3 Aug 2024 14:34:57 +0000 (UTC)
Date: Sat, 3 Aug 2024 10:34:55 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: William-tw Lin <william-tw.lin@mediatek.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] nvmem: mtk-efuse: Only register socinfo device if
 needed cells are there
Message-ID: <f52d33ec-a003-48f8-b74d-080b9b29eb67@notapiano>
References: <20240708-mtk-socinfo-no-data-probe-err-v2-1-7ae252acbcc2@collabora.com>
 <a1914f2b-93f2-4de4-9c4b-2e1f6b39cf3a@collabora.com>
 <05dd24ec-d084-4708-a241-b4714391118a@notapiano>
 <e1e1b618-b505-482a-b556-99c6d42fd581@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1e1b618-b505-482a-b556-99c6d42fd581@collabora.com>

On Fri, Jul 19, 2024 at 11:29:03AM +0200, AngeloGioacchino Del Regno wrote:
> Il 19/07/24 00:07, Nícolas F. R. A. Prado ha scritto:
> > On Wed, Jul 10, 2024 at 11:31:11AM +0200, AngeloGioacchino Del Regno wrote:
> > > Il 08/07/24 21:43, Nícolas F. R. A. Prado ha scritto:
> > > > Not every efuse region has cells storing SoC information. Only register
> > > > an socinfo device if the required cells are present.
> > > > 
> > > > This prevents the pointless process of creating an socinfo device,
> > > > probing it with the socinfo driver only to ultimately error out like so
> > > > 
> > > >     mtk-socinfo mtk-socinfo.0.auto: error -ENOENT: Failed to get socinfo data
> > > >     mtk-socinfo mtk-socinfo.0.auto: probe with driver mtk-socinfo failed with error -2
> > > > 
> > > > This issue is observed on the mt8183-kukui-jacuzzi-juniper-sku16
> > > > platform, which has two efuse regions, but only one of them contains the
> > > > SoC data.
> > > > 
> > > 
> > > I think that we should rather remove or disable the first eFuse region, as
> > > even though that is enabled:
> > > 
> > >   - This is the only SoC having two regions
> > >     - I'm not even sure that the region at 0x8000000 is really efuse
> > >     - Not even referenced in datasheets....
> > >   - It's unused, as in, it's not exposing any information and no declared cells
> > > 
> > > Don't misunderstand me, this is not an invalid change, but I rather prefer
> > > to resolve this by disabling that (effectively unused!) node, avoiding to
> > > add more lines to this driver that would be useless after fixing that small
> > > single thing.
> > 
> > I'm not confident that we can say that that efuse is not exposing any
> > information. Indeed there are no cells so it's not used by any other driver, but
> > the efuse contents are still exposed to userspace if CONFIG_NVMEM_SYSFS is
> > enabled.
> > 
> > I dumped it on one of the mt8183-kukui-jacuzzi-juniper-sku16 units:
> > 
> >    $ ls -l /sys/bus/nvmem/devices/
> >    total 0
> >    lrwxrwxrwx    1 root     root             0 Jul 18 21:43 mmtd0 -> ../../../devices/platform/soc/11010000.spi/spi_master/spi1/spi1.0/mtd/mtd0/mtd0
> >    lrwxrwxrwx    1 root     root             0 Jul 18 21:43 nvmem0 -> ../../../devices/platform/soc/8000000.efuse/nvmem0
> >    lrwxrwxrwx    1 root     root             0 Jul 18 21:43 nvmem1 -> ../../../devices/platform/soc/11f10000.efuse/nvmem1
> >    $ hexdump -C /sys/bus/nvmem/devices/nvmem0/nvmem
> >    00000000  88 07 00 00 00 8a 00 00  00 ca 00 00 00 00 00 00  |................|
> >    00000010
> > 
> > I power cycled the unit and ran this again and it still showed the same
> > contents. I also ran the same on a different unit of the same model and it
> > showed the same contents. Of course this doesn't prove anything, but given that
> > the contents seem to be constant across reboots and even different units, it
> > does look like it could be an efuse to me. :)
> > 
> > As to whether the contents are useful at all, or if there are
> > userspace applications making use of it I have no clue. But if in doubt,
> > shouldn't we keep it around?
> 
> (Added William-tw Lin from MediaTek to the loop)
> 
> I'll say yes only if MediaTek (please!) says that this region has useful
> information, and only if MediaTek actually tells us what those fuses are.
> 
> The reason is that sometimes when SoCs have multiple efuse regions, one contains
> uncalibrated data for factory calibration (etc etc), one contains data that derives
> from the uncalibrated regions and that is supposed to be used by the OS.
> 
> If we got the uncalibrated data that is *not* for OS usage in the MT8183 DT, then
> we can as well just remove it.
> 
> Besides, I have no concern about any userspace application using that.

No reply, so I've sent v3.

Thanks,
Nícolas

