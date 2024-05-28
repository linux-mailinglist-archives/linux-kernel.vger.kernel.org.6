Return-Path: <linux-kernel+bounces-192735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6644B8D216E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E561C2382D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F6172BA4;
	Tue, 28 May 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="cxsWPc6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1wE11MA"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6A171E7F;
	Tue, 28 May 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913001; cv=none; b=WZnbUfYPXe5n9Ur1V5cDaVbtFgb4pjy+Ocig/s4JRnGpYytR9Hl+M6DN7RottICypEoKC8ZB5SZqx/x0klHNLqoKxZwAAC1x+IE5NGw6ob+HAtAwnYFdrf+N9+Pg+rvrQJlyNmdLACG0ruw/SCsJRTIzstOgjgp5uVHO+NsDcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913001; c=relaxed/simple;
	bh=S10rG6mlr+NDn0HsHECqbGz8o1H4jH3VB+W8t8GEaUo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EbizizVeZHBddOgkBFYfdZT13/+F2vzahVYqqgQoRsdLodEqBgzGvIzUErIBAF5hY5xo/ecB1GYu0I6xjwh/G+apihh0exbj/X5tLvmaEKbKQ4rftjFxgWLWhL+8afwLPtFtvb/Ikq5IEVaUiLGMmoxgNyltxP0x00/SmkNEqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=cxsWPc6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1wE11MA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 78DD51140102;
	Tue, 28 May 2024 12:16:38 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 28 May 2024 12:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716912998;
	 x=1716999398; bh=lDIKV5b9lJEhOkbgV2SZ046ruGjEWbYwtHAeMzm8oo0=; b=
	cxsWPc6cm/Fs7mtvbOuStenoMkrKc5M3WR3TyAjN9Yd6B7cJgWAcELHVpK1PTtd/
	OnIFW+pTTGBsMyhs07A+hDBG2GCh2Mp/mcDpjBVH/stfxCpf1rtF3VICZi3Zfsk+
	OJ7xF6pNa19gFKhnCDiUXXWoxjOg5P1oZSYihHWaD9DH6gWQY6nfPpL8aDk1y3qK
	+kk6yDEMZT0qZ5W5d3snjCf/EYUAZ5GSvHnLm7Go320MAgazoT3Nv4PmjjSowJVH
	DgAIXa0zTHypMbm6TcW/u7zzjz4LHFMDFHhCD7HegItuR48A3G6rmizRhDTwS0b1
	cEBEXRuvgNDiZMfGSMtvSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716912998; x=
	1716999398; bh=lDIKV5b9lJEhOkbgV2SZ046ruGjEWbYwtHAeMzm8oo0=; b=H
	1wE11MAo/Av7Et3LS7H1DDtoYuH/f4YUC+C5eagsXPYcWlZBc7A+Hy+O24pX68S+
	O9oUdB9A68gXIXt0w5OIEOUXpQgh6V0iUT0JP8HERbaon8i87vRfSRpmPYSYAz25
	gwZTJkiM74dyUfQEaEG9SOQuYq7d3zsTeAxPbA2nFA9RZxhjC4LK+nYHnsu5t3fi
	NJXYAfa3EpV4byDaNFf+ROq9loMEomnm34wVEkEuI478Al9AiYu7W/JqGGqZjoOl
	h1iLLSzzMmZbFzeDe2HfHbItItcMKP4fT8ZjgjQEj7bPf6u/LMvH+ZSxBTO29ndS
	Xpa8iW8zc44l32dFHfahQ==
X-ME-Sender: <xms:ZQNWZo8T-c91nalFuQ4EfFz13Q9EjVAzQCDxJxLCKiF_5oPELlQ7fA>
    <xme:ZQNWZgvqaabOfGwt3HapFMSMvbOh2qJf9XWeGHqfA8L8poXlISx52-ZcvLB7XSw6X
    ywsOBQbAZPMbzElq20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    hihnughonhcuufgrnhgthhgvfdcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqne
    cuggftrfgrthhtvghrnhepheefgfevjeeivedvkefgfedtudfgtefgteeuleeiudffteei
    leehteeivedvfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:ZgNWZuDg4kbi15O_hI_6MKxSeWOBvk0m4WTngpteFPRd1G8o2CoyFg>
    <xmx:ZgNWZodrBtiwIVtrFPR6GzO0qPIKye1Wxfb7fbwpTRxOYAnZec6f0w>
    <xmx:ZgNWZtPWDi7HSCq2O_Apk2XTdiBy4hWFQxj5bbFVuWmuaEV4t1YLOA>
    <xmx:ZgNWZimmvXZ-nJq1vjZ5wTfrDu6V6KbM9kj6VKrbk282YAeOLB1viA>
    <xmx:ZgNWZkkkUL-XTeVwCrAv8IRwi4O7jQIeGXQZGEvPox-3AZw9T02yPWWq>
Feedback-ID: i1719461a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DBDBEC60097; Tue, 28 May 2024 12:16:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0322878-eb27-45e4-9545-136f5ade6a0e@app.fastmail.com>
In-Reply-To: <c971cfae-e7d5-fbde-f77b-1a936c6e1ee7@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240517224323.10045-1-lsanche@lyndeno.ca>
 <20240517224323.10045-4-lsanche@lyndeno.ca>
 <c971cfae-e7d5-fbde-f77b-1a936c6e1ee7@linux.intel.com>
Date: Tue, 28 May 2024 10:16:17 -0600
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Mario Limonciello" <mario.limonciello@amd.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Armin Wolf" <W_Armin@gmx.de>,
 srinivas.pandruvada@linux.intel.com, "kernel test robot" <lkp@intel.com>,
 "Hans de Goede" <hdegoede@redhat.com>, "Yijun Shen" <Yijun.Shen@dell.com>,
 "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Vegard Nossum" <vegard.nossum@oracle.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v7 3/3] platform/x86: dell-pc: Implement platform_profile
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024, at 3:39 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 17 May 2024, Lyndon Sanche wrote:
>
>> +#include <linux/platform_profile.h>
>> +#include <linux/slab.h>
>> +#include "dell-smbios.h"
>
> Add empty line between <> and "" includes.

Agreed.

>> +enum thermal_mode_bits {
>> +	DELL_BALANCED =3D BIT(0),
>> +	DELL_COOL_BOTTOM =3D BIT(1),
>> +	DELL_QUIET =3D BIT(2),
>> +	DELL_PERFORMANCE =3D BIT(3),
>
> A few nits still to address.
>
> Can you please align these so that the values align (IIRC, I asked thi=
s=20
> earlier but perhaps my request was too unclear):
>
> 	DELL_XX			=3D BIT(X),
> 	DELL_YYYYYYYYY		=3D BIT(Y),
>

I must have missed this, I will get this corrected.

>> +static int thermal_get_supported_modes(int *supported_bits)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int ret;
>> +
>> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAG=
EMENT);
>> +	if (ret) {
>> +		/* Thermal function not supported */
>> +		if (ret =3D=3D -ENXIO) {
>> +			*supported_bits =3D 0;
>> +			return 0;
>> +		} else {
>
> Drop else because the previous block ends into return.
>

Agreed.

>> +			return ret;
>> +		}
>> +	}
>
> Remove the outer if (ret) block and put the inner ones directly on the=20
> main level as two if () conditions.
>

Agreed.

>> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_=
mode) | state, 0, 0);
>> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAG=
EMENT);
>> +	return ret;
>
> Return directly on the previous line.
>

Agreed.

>> +	int ret;
>> +	int supported_modes;
>> +
>> +	/* If thermal commands not supported, exit without error */
>
> Fix grammar, you're perhaps missing "are".
>

Agreed.

>> +	if (!dell_smbios_class_is_supported(CLASS_INFO))
>> +		return 0;
>> +
>> +	/* If thermal modes not supported, exit without error */
>
> Ditto.
>
> --=20
>  i.

Thank you for your feedback. I will include this in the next patch serie=
s.

Thanks,

Lyndon

