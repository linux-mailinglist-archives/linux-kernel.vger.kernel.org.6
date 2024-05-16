Return-Path: <linux-kernel+bounces-181582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA5D8C7DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B19282D62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A25158201;
	Thu, 16 May 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=franken-peeters.be header.i=@franken-peeters.be header.b="1LKw1Jze"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7AF157E9E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893920; cv=none; b=MM5iPltOxt4GHiOcZmJFCemRSpMq3Yo5eUL3lewJF4A43pqt+Uoont8E+36t4Eyv2D/sDLt8aN6Gf6cR5+ZyZSv9diQo78xCr9GF7Yr/6oa4Ba+14pjtlqJ+rig1Xw7n/wKrvptFDYgvTpYaEC++Dn1j/zYMTA4xtU9R2/rbwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893920; c=relaxed/simple;
	bh=obqdqVwbBsHvvAadtY0OXNbvhRT40zmjIJh2iWnmyx4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=S1K4y9a1reIxKtCPqilA3jeMP3IecnUvSCFMo0s86I3gZUfZdbV0fqqF14evmM4xOLKh8zuSgAqGrVM+5MBNou9sPcrENYi4juih3eHEFq5BisYH56/yTjz0kJuz06IKP+KXvoLOhE+NzvOL7d+COAVLgn9skBKS+6YrblES0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=franken-peeters.be; spf=pass smtp.mailfrom=franken-peeters.be; dkim=pass (2048-bit key) header.d=franken-peeters.be header.i=@franken-peeters.be header.b=1LKw1Jze; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=franken-peeters.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=franken-peeters.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=franken-peeters.be;
	s=protonmail2; t=1715893913; x=1716153113;
	bh=d4j2OtGA6Vp0Lt9eyDtzX/aZext1Y5uousK6juRLCrY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=1LKw1JzeqfQqkzdnHPc02Dm77/8yccgoDhaffBhZyN0NqYCL9yLn+HQQjdr+eROXd
	 lEmqWcPjlcrtcSF8eWlZ5bw7kMcnY6ThathI8HA3X3On4jnCtiHpkgHQ9Z2Nu+C9L3
	 XGf6N7BAnSLbNEvMgqGVaMmLo/nGIfWmr2Ke/PPZ2fI/1MYNEa23zHND8w5bjB4MwL
	 JnrrgoyvYjY99PzxutogeJS3gzu9hdun9esexWQZtpnx/Z8pqtkf/Xy3Obw4rhgWBL
	 0scTY1m5tL7vLv3kAgZMUwJPlejH9JQT/CrfzgBM9+if/jA6l30JZya3cSf1AQXHpM
	 DJ92ChVwnw8DQ==
Date: Thu, 16 May 2024 21:11:46 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Wouter Franken <wouter@franken-peeters.be>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: move ci_ulpi_init after the phy initialization
Message-ID: <ecb8d3e8-d525-4a2d-a868-803202c16296@franken-peeters.be>
Feedback-ID: 87808963:user:proton
X-Pm-Message-ID: f9e38adc63416260f2281549bc731935d9ca77cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello all,

On 4/25/24 21:40, Marek Szyprowski wrote:
> Dear All,
>
> On 02.04.2024 08:23, Michael Grzeschik wrote:
>> The function ci_usb_phy_init is already handling the
>> hw_phymode_configure path which is also only possible after we have
>> a valid phy. So we move the ci_ulpi_init after the phy initialization
>> to be really sure to be able to communicate with the ulpi phy.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> This patch landed in linux-next some time ago as commit 22ffd399e6e7
> ("usb: chipidea: move ci_ulpi_init after the phy initialization").
> Unfortunately it breaks host USB operation on DragonBoard410c
> (arch/arm64/boot/dts/qcom/apq8016-sbc.dts). There is no error nor
> warning in the kernel log besides the information about deferred probe
> on the chipidea controller:
>
> platform ci_hdrc.0: deferred probe pending: (reason unknown)
>
> Tomorrow I will try to investigate which operation during driver probe
> triggers it. If there is anything else to check that might help fixing
> this issue, let me know.

I have the same problem on sony yuga=20
(arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts):
it breaks USB operation and shows the same message in the kernel log.

I have analyzed this issue and came to the following conclusion:

>> ---
>>    drivers/usb/chipidea/core.c | 8 ++++----
>>    drivers/usb/chipidea/ulpi.c | 5 -----
>>    2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
>> index 835bf2428dc6e..bada13f704b62 100644
>> --- a/drivers/usb/chipidea/core.c
>> +++ b/drivers/usb/chipidea/core.c
>> @@ -1084,10 +1084,6 @@ static int ci_hdrc_probe(struct platform_device *=
pdev)
>>    =09=09return -ENODEV;
>>    =09}
>>   =20
>> -=09ret =3D ci_ulpi_init(ci);
>> -=09if (ret)
>> -=09=09return ret;
>> -

This ci_ulpi_init(...) call eventually calls probe(..) on the USB phy=20
when the ulpi driver
registers all its child nodes. A couple lines later devm_phy_get(..) is=20
called
to get the initialized phy device. Due to the move of the=20
ci_ulpi_init(..) the phy
is not probed and the devm_phy_get(..) call fails with EPROBE_DEFER.=20
This results
in a deadlock.

I don't understand the complete train of thought behind this patch to=20
propose a fix
but hopefully my investigation can help to solve the issue.

>>    =09if (ci->platdata->phy) {
>>    =09=09ci->phy =3D ci->platdata->phy;
>>    =09} else if (ci->platdata->usb_phy) {
>> @@ -1142,6 +1138,10 @@ static int ci_hdrc_probe(struct platform_device *=
pdev)
>>    =09=09goto ulpi_exit;
>>    =09}
>>   =20
>> +=09ret =3D ci_ulpi_init(ci);
>> +=09if (ret)
>> +=09=09return ret;
>> +
>>    =09ci->hw_bank.phys =3D res->start;
>>   =20
>>    =09ci->irq =3D platform_get_irq(pdev, 0);
>> diff --git a/drivers/usb/chipidea/ulpi.c b/drivers/usb/chipidea/ulpi.c
>> index dfec07e8ae1d2..89fb51e2c3ded 100644
>> --- a/drivers/usb/chipidea/ulpi.c
>> +++ b/drivers/usb/chipidea/ulpi.c
>> @@ -68,11 +68,6 @@ int ci_ulpi_init(struct ci_hdrc *ci)
>>    =09if (ci->platdata->phy_mode !=3D USBPHY_INTERFACE_MODE_ULPI)
>>    =09=09return 0;
>>   =20
>> -=09/*
>> -=09 * Set PORTSC correctly so we can read/write ULPI registers for
>> -=09 * identification purposes
>> -=09 */
>> -=09hw_phymode_configure(ci);
>>   =20
>>    =09ci->ulpi_ops.read =3D ci_ulpi_read;
>>    =09ci->ulpi_ops.write =3D ci_ulpi_write;
>>
>> ---
>> base-commit: 5bab5dc780c9ed0c69fc2f828015532acf4a7848
>> change-id: 20240328-chipidea-phy-misc-b3f2bc814784
>>
>> Best regards,
> Best regards

Best regards
--
Wouter Franken



