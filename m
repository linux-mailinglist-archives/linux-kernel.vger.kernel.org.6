Return-Path: <linux-kernel+bounces-515727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4070AA36833
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED08F1725F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA541FC100;
	Fri, 14 Feb 2025 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akpQF6NY"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BA1953A9;
	Fri, 14 Feb 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571665; cv=none; b=oG3iwyJexfyKDdafrtkXE+p6UT5voiOb12G6gT4o39Qc/sxyxJFdXdbB2UH8Fh/bXtqifcaaKYRD9vXKx4U+4mNPzEe87gRiO+VbR6SbZwm4NrUs4mQgCh50O+wENSr2bArmEoeCZSmNTjvWsK66lYlmIGsH7BGrH3XSQSR2r1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571665; c=relaxed/simple;
	bh=P/RRMN7AF8IFICtHDY7oRoDtgj4lkWR22FjVtVNQ/OU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WkNZ1UFfbJ9Xl6WLsH5Y73OEUDrIMjUVCatiOklm0MQixv/SOafVi/83GYa+9yET9PDXlnaYJI9U3/Dynmal84IgsYXuCr7FvBoqWBclD7dwOBdeb6I768d6ZQpyeevdRgOtjQlR/fn4tePnOItjCIigJXrb3MXSJRIGceXwJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akpQF6NY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5dab3f372aso2017306276.1;
        Fri, 14 Feb 2025 14:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739571662; x=1740176462; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBPGRdyN7h2fkoOnWWbLDJG7PIvR+TIVzq4NHRIF6Pg=;
        b=akpQF6NYbM2TCt3ibAzflnO/1FplmtG7iNVZ1k+w/HQXLEjQjIhgTqFGZkHyXzLi4r
         cFa4gz7zdhcXhrztUW59A3XZIcZJyceehGZBBSPzTddug+xiD4KB4Qq5SY4cJnTYaMoX
         stAgO0FpQEsvEp/Rs2LtwEwX92jJsWXL0plPVHNr2yypPZyHWRrCn8o9R8uXr/WjqQKw
         /3u/Ubot6kdws8OqqTBMV2KiQdf5NNH4qmg9x5Htu7JMGreccAyZ0+AdKP9HtGZ+FAEu
         FjCL0Lu2LSjY0fMGtF/NAukINmRgHhpk1GN/U8GBRxuEqiQE9OxOcVcCL+ddOQ24UBEN
         pBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739571662; x=1740176462;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HBPGRdyN7h2fkoOnWWbLDJG7PIvR+TIVzq4NHRIF6Pg=;
        b=FxGsMT4SPeNLOHiSmq9c0PY2bNvOcqZx+Rgdw/uIn6M7zVwNtpRdE4AFcuDY/Ly7Jh
         gMNdT+vN/6EiW/X1cHJC6knTZQlUCkKbvkr2DuQCnv6AXCwp7Sxi8UF5vWLToUXf18Db
         /2uZW5GWFgdrCPBRmwlQSeKh3HkE4GaWSEGFlIFaEUTJijUugD+rzGqe9dEKy67OUBJp
         iab8lbMTS9GdxwmfnYaijfEcFGxNl4Ndfo5ThXSHY5d+haEiGkPFp3fjFCugUS1rr8Za
         nPm+Luh1mRFUyZrnmkatcVrQP8LJpGJakJGoBySxNceztNat7sksfJgnfk/1nKpSuP9k
         HtEg==
X-Forwarded-Encrypted: i=1; AJvYcCV9qJLoWVCm44ykdcSwIV7FUKXSGKwTIiTpQBP8Ov9LM78voEK0YP9//lqRSu+wkyYQ5pr23H1FzPQLM6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnS8xYN0WndqDdKEOtylTFpVFuPVpGzZAVNxBjrXUYhsros3EI
	OG1aPVbKlEWammgdONl+FHUnAwoHyWlVHld3gIHVlxzeLPhemB80
X-Gm-Gg: ASbGncvKHlwmiCmOEt6hsDkJdVq94QIIAv3h1pc78Q3sJ2ZlNrWWb0h+31PKXEEflLI
	gTlP7aOVaRjfeqdjb5YOznDgByzz6esDe5r+4hnFxHOLM4LZDyB2E7DduzcTvKrbGb6wuzgqBmW
	2BIoP0spN/aW0NtxJbyfGeMFB3O1aDOjj91aF0npJ9ozcCbhe5wsEG3GpvgTp2rooE+/W2K+oCR
	rFg4CV5/qiukccqlvtnfwQfLPPc2Jm13oqK5Ze5m2GCF/gASeo/qU7lsd/iQ0G5OIgP8CFtWMO+
	RXkw9ds=
X-Google-Smtp-Source: AGHT+IElibYHHLBXYhijveLyI6yk8PVx1RQ0B3R7NKp/2QB4o9FD4fvD7SIBkkCd8p8FAHR63jarbA==
X-Received: by 2002:a05:6902:3483:b0:e58:b99:6a5b with SMTP id 3f1490d57ef6-e5dc980afebmr815410276.8.1739571662537;
        Fri, 14 Feb 2025 14:21:02 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dadeca97bsm1237760276.32.2025.02.14.14.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 14:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 17:21:00 -0500
Message-Id: <D7SIOS9FABGO.1ZOTYZJ4PWMTA@gmail.com>
Cc: <platform-driver-x86@vger.kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Armin Wolf" <W_Armin@gmx.de>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Hans de Goede"
 <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 11/14] platform/x86: Split the alienware-wmi driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250207154610.13675-1-kuurtb@gmail.com>
 <20250207154610.13675-12-kuurtb@gmail.com>
 <Z6uBJ9AC5XgZTlJG@black.fi.intel.com> <D7PT98IDXMUV.G2F1LRF8BX7@gmail.com>
 <Z6ufIQADzILVMusc@smile.fi.intel.com>
In-Reply-To: <Z6ufIQADzILVMusc@smile.fi.intel.com>

Hi Andy,

On Tue Feb 11, 2025 at 2:04 PM -05, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 12:59:53PM -0500, Kurt Borja wrote:
>> On Tue Feb 11, 2025 at 11:56 AM -05, Andy Shevchenko wrote:
>> > On Fri, Feb 07, 2025 at 10:46:07AM -0500, Kurt Borja wrote:
>
> ...
>
>> >>  obj-$(CONFIG_ALIENWARE_WMI)		+=3D alienware-wmi.o
>> >>  alienware-wmi-objs			:=3D alienware-wmi-base.o
>> >> +alienware-wmi-y				+=3D alienware-wmi-legacy.o
>> >> +alienware-wmi-y				+=3D alienware-wmi-wmax.o
>> >
>> > Oh my... it's even inconsistent!
>>=20
>> Again, this is an already used pattern:
>
>> 	https://elixir.bootlin.com/linux/v6.14-rc2/source/drivers/platform/x86/=
dell/Makefile#L14
>>=20
>> I add configuration entries later. Is the order of the changes wrong? or
>> is it the entire approach? Do other modules here need a fix?
>
> Again, it doesn't mean it's correct.
>
> Maybe other modules also need that, I don't remember, but you may `git lo=
g
> --no-merges --author=3D"Andy" --grep objs` to see changes I made in the p=
ast.

Sorry!

Everything made more sense after reading the docs and checking your
commits.

I submitted a patch fixing this. Thank you for pointing it out!

>
> ...
>
>> >> +	if (!ret) {
>> >> +		if (out_data =3D=3D 0)
>> >> +			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
>> >> +		else if (out_data =3D=3D 1)
>> >> +			return sysfs_emit(buf, "disabled [s5] s5_s4\n");
>> >> +		else if (out_data =3D=3D 2)
>> >> +			return sysfs_emit(buf, "disabled s5 [s5_s4]\n");
>> >
>> > The whole code inherited same issues like redundant 'else'. Please, re=
factor.
>>=20
>> This is not my code, so a separate patch would be needed.
>
> Okay!
>
> ...
>
>> >> +	if (strcmp(buf, "disabled\n") =3D=3D 0)
>> >> +		args.arg =3D 0;
>> >> +	else if (strcmp(buf, "s5\n") =3D=3D 0)
>> >> +		args.arg =3D 1;
>> >> +	else
>> >> +		args.arg =3D 2;
>> >
>> > sysfs_match_string()
>>=20
>> Same as above.
>
> Same as above :-)
>
> ...
>
>> >> +	if ((code & WMAX_THERMAL_TABLE_MASK) =3D=3D WMAX_THERMAL_TABLE_USTT=
 &&
>> >> +	    (code & WMAX_THERMAL_MODE_MASK) <=3D THERMAL_MODE_USTT_LOW_POWE=
R)
>> >> +		return true;
>> >> +
>> >> +	return false;
>> >
>> > 	return ...
>> >
>> > but if you wish, this one is okay.
>>=20
>> This was done for readibility. Also this would require a different
>> patch.
>
> No need, I'm fine with the current approach, just to show the alternative=
s.
>
> ...
>
>> >> +	ret =3D wmax_thermal_information(priv->wdev, WMAX_OPERATION_SYS_DES=
CRIPTION,
>> >> +				       0, (u32 *) &sys_desc);
>> >
>> > How do you guarantee an alignment? Yes, it might be good for the speci=
fic
>> > hardware, but in general this is broken code.
>>=20
>> This is a good question. I'm not really sure how to fix this tho. Is it
>> fine to just pass a __packed struct? Also this would require another
>> patch.
>
> Usual approach here is to use one of get_unaligned_le32(), get_unaligned_=
be32()
> depending on the byte ordering.
>
>> >> +	if (ret < 0)
>> >> +		return ret;
>
> ...
>
>> >> +		set_bit(profile, choices);
>> >
>> > Do you need it to be atomic?
>>=20
>> I don't think so. `choices` belongs to this thread only.
>
> So, __set_bit() will suffice then.

For some reason I thought `set_bit` was the non-atomic one. This is good
to know.

>
> ...
>
>> >> +void __exit alienware_wmax_wmi_exit(void)
>> >> +{
>> >> +	wmi_driver_unregister(&alienware_wmax_wmi_driver);
>> >> +}
>> >
>> > Why not moving these boilerplate to ->probe() and use module_wmi_drive=
r()?
>>=20
>> This 3 files are a single module and it has two WMI drivers so this
>> can't be used.
>
> Can it be split to two separate modules then?

These two WMI drivers share a lot of features on old alienware models.
Hence why I decided to link them together. IMO this bit of boilerplate
is a fair tradeoff.

Thank you again for your feedback. I was completely unaware of some
things you pointed out. I will implement your suggestions soon.

--=20
 ~ Kurt

