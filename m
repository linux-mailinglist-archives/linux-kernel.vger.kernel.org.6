Return-Path: <linux-kernel+bounces-192072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDE8D1805
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE45E28940E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54613D887;
	Tue, 28 May 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="muSwFo9x"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CDF9DA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890634; cv=none; b=fGj/4xdYwPSXs6qfBM8Vb6roti3vNDvP2zFQPiBb7prtSOylL8GK0M9VPXQXsEMf94kJwUF4Xb6+yLJF/vjkGYDG3gAJTt5kwP2DRdo4hzzlzl2YxnnPv0PXEbEtzHv12ZD6vrLFpUJq8Q/768GpkKNQwBHBGPm1+ZoQFSKkcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890634; c=relaxed/simple;
	bh=BrWcWsTqAV4gpOrjkMiIV3VNt4iF3Cy06e8mt/ZYCBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WBsEPozsvMQHL4JwS6ThxQeizVnfr6QA2JhUzH8DYHlcJzkDjWRcMhjXEFqHIzXvlliB7u3+lPqeqM80XjN2HE2tT+guedLsl0rCHut+X8WKoAofoCSdk2u/PRERzBti4YRZoD/UWdRyqqnqaWozpw/EPZkVj1FIBVuqK1b4UwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=muSwFo9x; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3vkqjShmVbfcAxEtVWL2j8Hci5pLGBTVlar7XdZHH0Y=; b=muSwFo9xnIVZK82AFfhTbeHPvZ
	2Pjtjzc29ioK5O4DlNZXIXuVCh1zZs5OPxszNAiktQ1SFMmjAXd4p4oMPF8afmIuD35HHB2fpAWhq
	jE+wV19X785cC32ycJ2vGctRMaLWorWFMoitfK4a3TYGS3ddAdRF9+aHV2AK39c1MCR4v4Jc2HHKE
	L+QluObx6e9gvMZLDECEzsUuEGVrQpzFCz5ce11B1aYq8bk8lxhW+3Slpwi3vDRBzYkNMCTv3NZaw
	74WuPAtMvo2qE1bRjgNKoir9oYWrI2ZB1XWsRXng2NDQycYpjNeBOtJNTLE5zV0Yq4Z+QpSfKJzqs
	5t3gRqBQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBtgL-000FNN-GX; Tue, 28 May 2024 12:03:49 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBtgK-000P2X-2B;
	Tue, 28 May 2024 12:03:48 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <e3aa72af-c824-4b71-a99d-c0b9294bfd8a@kernel.org> (Krzysztof
	Kozlowski's message of "Tue, 28 May 2024 08:53:26 +0200")
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
	<979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org>
	<87cypc38gu.fsf@geanix.com>
	<9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org>
	<87le3zoatn.fsf@geanix.com>
	<6c166ad5-8004-4bc4-9107-a47ba9a72161@kernel.org>
	<87ttijaglp.fsf@geanix.com>
	<c045f1a4-9ddf-4c53-a69b-22ceb68a1ce8@kernel.org>
	<87msobaes6.fsf@geanix.com> <87ikyzae7v.fsf@geanix.com>
	<e3aa72af-c824-4b71-a99d-c0b9294bfd8a@kernel.org>
Date: Tue, 28 May 2024 12:03:48 +0200
Message-ID: <87y17ul0cb.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 27/05/2024 09:47, Esben Haabendal wrote:
>> 
>> Ok, I seem to still be confused as to what you want from me. If you are
>> saying that the kernel is not supposed to care about out-of-tree DTS
>> (and thereby any bootloader provided DTB), I would like to bring your
>> attention to arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts in upstream:
>> 
>> &ifc {
>>         #address-cells = <2>;
>>         #size-cells = <1>;
>>         /* NOR Flash on board */
>>         ranges = <0x0 0x0 0x0 0x60000000 0x08000000>;
>>         status = "okay";
>> 
>>         nor@0,0 {
>>                 #address-cells = <1>;
>>                 #size-cells = <1>;
>>                 compatible = "cfi-flash";
>>                 reg = <0x0 0x0 0x8000000>;
>>                 big-endian;
>>                 bank-width = <2>;
>>                 device-width = <1>;
>>         };
>> };
>> 
>
> I don't understand why it took so many emails to answer that (my first)
> question...

Because I did not understand the question. Primarely because I was (and
is) surprised that out-of-tree DTS is not supported. I was convinced
that out-of-tree DTS was the right way for hardware which is not
commonly available.

> Sounds good, however you did not update the existing select.
> Drivers are not supposed to select user-visible symbols (leads to
> issues), so you need to change it to depends and update defconfigs.

Do you wan this split into multiple commits, or a single commit changing
the Kconfig to make FSL_IFC user-visible, and changing select of it to
DEPENDS, and updating the related defconfig(s)?

/Esben

