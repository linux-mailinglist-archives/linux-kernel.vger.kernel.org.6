Return-Path: <linux-kernel+bounces-256804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0550E93708E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360401C21E00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3414600C;
	Thu, 18 Jul 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eGD9EUXe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589201386BF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340466; cv=none; b=BIjxUKJmo0x9dPMEvSIBv2dKc5CALBD8LKgHi6Yxjj5FPx3l/nZzs4mk0vc1Tu2DvoCzx0o409UXinMALsU81u6/gmJorZUs+ja4ua4BMT1tKKm8sRUIV1744v0aaIjTWSGOkZnu7x4MGpsbTIkqjoD8a6YCSTZYkDVlp/FVu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340466; c=relaxed/simple;
	bh=gzGiI2wvuZEYnzUMFQ5wGfxZiwKRMQdKAglWmCVvamQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlQEk3Srm7wVNzsva34yfvJUu/r+SyPt5zNObUxnYeENcWHApdSj/Vt9rFvYGd4j/B/MoHOmxgLMRXrPkRXra74ybL6V114dh+ygc5T/61LBghPJ2KWE73sIFlxy1e7b7qre+qGx5Uk2btmvbQIPPLTmFX6qUqVyl6zezyLMG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eGD9EUXe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721340462;
	bh=gzGiI2wvuZEYnzUMFQ5wGfxZiwKRMQdKAglWmCVvamQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGD9EUXebDntpI1lVGMqIM9QrrH1deaoVIzxKhENmh3W17tvtAp1fnPoZZb0wr7Jl
	 7YDULidHqHeCU81e9AeYM5KVRmH7I57A+lUTHzegyr9GxRtMtkVGYBuGzXUJQ4rnhk
	 mWfXIo1erYGSpQ5quJzjentVLKjx4JMq12TJr7JzN0thSKkKbdgt/WEtV8MMDdnyXq
	 ird2tawtKmt2g3Ln2LOA9TUW1AXBEiaXxaXxGolYjC6Gvf0LlTk3hlgGW2oG0v7OD0
	 ftz4bilWCdLC0EMfX4fd0dTfqazOT0++DZDBPDE3P11sfoSv+AUsCJVf+RcPL6gG9k
	 Ab8CCBZTWz9iQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6BA5B3780520;
	Thu, 18 Jul 2024 22:07:40 +0000 (UTC)
Date: Thu, 18 Jul 2024 18:07:38 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] nvmem: mtk-efuse: Only register socinfo device if
 needed cells are there
Message-ID: <05dd24ec-d084-4708-a241-b4714391118a@notapiano>
References: <20240708-mtk-socinfo-no-data-probe-err-v2-1-7ae252acbcc2@collabora.com>
 <a1914f2b-93f2-4de4-9c4b-2e1f6b39cf3a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1914f2b-93f2-4de4-9c4b-2e1f6b39cf3a@collabora.com>

On Wed, Jul 10, 2024 at 11:31:11AM +0200, AngeloGioacchino Del Regno wrote:
> Il 08/07/24 21:43, Nícolas F. R. A. Prado ha scritto:
> > Not every efuse region has cells storing SoC information. Only register
> > an socinfo device if the required cells are present.
> > 
> > This prevents the pointless process of creating an socinfo device,
> > probing it with the socinfo driver only to ultimately error out like so
> > 
> >    mtk-socinfo mtk-socinfo.0.auto: error -ENOENT: Failed to get socinfo data
> >    mtk-socinfo mtk-socinfo.0.auto: probe with driver mtk-socinfo failed with error -2
> > 
> > This issue is observed on the mt8183-kukui-jacuzzi-juniper-sku16
> > platform, which has two efuse regions, but only one of them contains the
> > SoC data.
> > 
> 
> I think that we should rather remove or disable the first eFuse region, as
> even though that is enabled:
> 
>  - This is the only SoC having two regions
>    - I'm not even sure that the region at 0x8000000 is really efuse
>    - Not even referenced in datasheets....
>  - It's unused, as in, it's not exposing any information and no declared cells
> 
> Don't misunderstand me, this is not an invalid change, but I rather prefer
> to resolve this by disabling that (effectively unused!) node, avoiding to
> add more lines to this driver that would be useless after fixing that small
> single thing.

I'm not confident that we can say that that efuse is not exposing any
information. Indeed there are no cells so it's not used by any other driver, but
the efuse contents are still exposed to userspace if CONFIG_NVMEM_SYSFS is
enabled.

I dumped it on one of the mt8183-kukui-jacuzzi-juniper-sku16 units:

  $ ls -l /sys/bus/nvmem/devices/
  total 0
  lrwxrwxrwx    1 root     root             0 Jul 18 21:43 mmtd0 -> ../../../devices/platform/soc/11010000.spi/spi_master/spi1/spi1.0/mtd/mtd0/mtd0
  lrwxrwxrwx    1 root     root             0 Jul 18 21:43 nvmem0 -> ../../../devices/platform/soc/8000000.efuse/nvmem0
  lrwxrwxrwx    1 root     root             0 Jul 18 21:43 nvmem1 -> ../../../devices/platform/soc/11f10000.efuse/nvmem1
  
  $ hexdump -C /sys/bus/nvmem/devices/nvmem0/nvmem
  00000000  88 07 00 00 00 8a 00 00  00 ca 00 00 00 00 00 00  |................|
  00000010

I power cycled the unit and ran this again and it still showed the same
contents. I also ran the same on a different unit of the same model and it
showed the same contents. Of course this doesn't prove anything, but given that
the contents seem to be constant across reboots and even different units, it
does look like it could be an efuse to me. :)

As to whether the contents are useful at all, or if there are
userspace applications making use of it I have no clue. But if in doubt,
shouldn't we keep it around?

Thanks,
Nícolas

