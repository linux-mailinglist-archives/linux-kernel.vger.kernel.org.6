Return-Path: <linux-kernel+bounces-570709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A713A6B3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BCA19C305E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1C1E8348;
	Fri, 21 Mar 2025 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX+BSGAu"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6E1DF27C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532183; cv=none; b=coR1L1jsCt4Aep//idG0/MVVw9PjTOzHL2eShRWl6iP88BocEtnDT2dZlKU7YbNppLCDsv+cZ5kSo2e6xM4sZbADLR2RFNwft0BeMRdTpVuR4t/zOO441aN/ed3nXSnsoTegSvvp/0ZglGEnV5pcPUZ3HXh05xphOVfJ5VOc/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532183; c=relaxed/simple;
	bh=/J/l2xndIYzwBh3TqfFRxLFB3IOJWbXnrMRVsBmO9EQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GB7DOWB49GOE1RAcUtl4XNQZ1qTyVx5YDzGJND2hkA79HdWz37VeMqEraHwKDIdk2IVItlH1qOGcdZaAxQUV/TBlW/RpRezwtaWevqrIkoy5rH05Wjb5CeU/TGeNwVOq7QO0JnKhQCwxpJf0+rG7aOiu5xaAvqxoZFae3afL5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IX+BSGAu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso32181915ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742532180; x=1743136980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jaHeJ6qSwJ3u/x/VdsUMlK82s8mbA82yyCP5yyeo3Fc=;
        b=IX+BSGAuyK0faO/55sbuhOf5a6TMPLuOcU+ylFUZ5MObFrKbh/NGSgkYoGdnyxwJvU
         LVpSpPw/G4qLGhrSDXcl1sCkjaqGkiasx3V10nryp0ohrgpWKTN2UdwYkbzE6ntLbbfh
         PU+lRYeIaft0Inp7UFL5Mozo+xuA3LJr9FBvDJpZb63FMi3ac0vb0W7L0g+jqG5ckwyD
         NMyTnQWaVyXmA2ClNVbqeevl/1TyxKHJKQjLsPBAsvaD9NX1zHK2Qa26Tzw+7g30C0OV
         0zWH3nrblffaRxQZUP0HKUmFRIc6lJO6GsrmkzayA0p/VUXL7jGniXSeFLNBfJ2+sbhf
         xyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742532180; x=1743136980;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaHeJ6qSwJ3u/x/VdsUMlK82s8mbA82yyCP5yyeo3Fc=;
        b=B5ZIvzeyEtA2YIAIRbfVNIQgLsqKZ2o+LXEwXM+2ezwebffu2MMbj/A4WgFuK5vQV+
         vljwVJwryzfqNXWOWq3FGYyGF98MrOJlbNdKpdafsKdGtEYJU3Vpmo11vuHzibqpozYW
         cpc8fFLohfL2FFzoL73m6DTFlHKq3A6AJqbbzbJ3uxvkCdS8PpV4sqv6GxsihfpWH9TT
         0T9YVgF4pBoYzO98MGWF9JAqtZUHhoyWQM+f+4NCnIHNFfWepf6BA9SPdcIRwv0vHKUi
         Yqqkn+X03xJb3C2bz8C5+Z66xF/sMeNbZJRc5ED+U+hvKclslKKpwY3+dgz2W3T8Be2Y
         /RYw==
X-Forwarded-Encrypted: i=1; AJvYcCUS2dlU0yRg315fQIUJBE6HAPPEvl7v21fxTnUbUlZDZKjwU6G1WSTmPuIbADcHOKLUPfN0k/8RgclaT8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvc2Vw3DYmAM4C4j5YYKIPeSyGVrq2AU7wQQ/1FQv9qb4PVZWP
	Rz+FLIdHQopNGZ2cL1KIdcrsntASdZPfo8TCkG6qeXbJNXESIsOrF1fPxRAMew==
X-Gm-Gg: ASbGncvmyhPlcq4Ba6i1Uu6EmWfKiTL4KXty12mIiB083yS8V48ZCC0hSSwqti6a4sW
	fLw6CDDH9BPWANzWhi5HHplfwSLI655ooi/9N47kt5Uj2md+EgyjRqJPMdfiBGnmIPU7gwJCv6/
	fGYL+GkQAAPdY31izwGpAilHcjRGaSFBpOJ8Ndxy7PbkrjKAfns2N/ACDdAw2lmg5PEirhbVmgP
	eDg56be7AMRM22HFv+B5wOdE8FHJBuX3B82tiTppEB8fgWap42gV4vAH5duVPUPszkGP9iSrCj0
	/SjQFLdxwHjDP/5VGwH3Ylz27+IP4k1zpPXROQYJekz2
X-Google-Smtp-Source: AGHT+IFCZZBsBpT+JgPon/LLEbu72ysiHsPxVJfQnDNrm7RkPGl69Wa7QQ0PvDzg1cJp1vKd8UOSxQ==
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id d9443c01a7336-22780e38317mr26158175ad.51.1742532180528;
        Thu, 20 Mar 2025 21:43:00 -0700 (PDT)
Received: from ?IPv6:::1? ([2409:40f4:3109:f8b2:8000::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da38asm6929485ad.186.2025.03.20.21.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 21:43:00 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:12:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wei Fang <wei.fang@nxp.com>,
 devnull+manivannan.sadhasivam.linaro.org@kernel.org
CC: bartosz.golaszewski@linaro.org, bhelgaas@google.com, brgl@bgdev.pl,
 conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org,
 netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/5=5D_PCI/pwrctrl=3A_Skip_scanning_fo?=
 =?US-ASCII?Q?r_the_device_further_if_pwrctrl_device_is_created?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250321025940.2103854-1-wei.fang@nxp.com>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org> <20250321025940.2103854-1-wei.fang@nxp.com>
Message-ID: <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On March 21, 2025 8:29:40 AM GMT+05:30, Wei Fang <wei=2Efang@nxp=2Ecom> wr=
ote:
>@@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct pci_=
bus *bus, int devfn)
> 	struct pci_dev *dev;
> 	u32 l;
>=20
>-	pci_pwrctrl_create_device(bus, devfn);
>+	/*
>+	 * Create pwrctrl device (if required) for the PCI device to handle the
>+	 * power state=2E If the pwrctrl device is created, then skip scanning
>+	 * further as the pwrctrl core will rescan the bus after powering on
>+	 * the device=2E
>+	 */
>+	if (pci_pwrctrl_create_device(bus, devfn))
>+		return NULL;
>
>Hi Manivannan,
>
>The current patch logic is that if the pcie device node is found to have
>the "xxx-supply" property, the scan will be skipped, and then the pwrctrl
>driver will rescan and enable the regulators=2E However, after merging th=
is
>patch, there is a problem on our platform=2E The =2Eprobe() of our device
>driver will not be called=2E The reason is that CONFIG_PCI_PWRCTL_SLOT is
>not enabled at all in our configuration file, and the compatible string
>of the device is also not added to the pwrctrl driver=2E

Hmm=2E So I guess the controller driver itself is enabling the supplies I =
believe (which I failed to spot)=2E May I know what platforms are affected?

> I think other
>platforms should also have similar problems, which undoubtedly make these
>platforms be unstable=2E This patch has been applied, and I am not famili=
ar
>with this=2E Can you fix this problem? I mean that those platforms that d=
o
>not use pwrctrl can avoid skipping the scan=2E

Sure=2E It makes sense to add a check to see if the pwrctrl driver is enab=
led or not=2E If it is not enabled, then the pwrctrl device creation could =
be skipped=2E I'll send a patch once I'm infront of my computer=2E

But in the long run, we would like to move all platforms to use pwrctrl in=
stead of fiddling the power supplies in the controller driver (well that wa=
s the motivation to introduce it in the first place)=2E

Once you share the platform details, I'll try to migrate it to use pwrctrl=
=2E Also, please note that we are going to enable pwrctrl in ARM64 defconfi=
g very soon=2E So I'll try to fix the affected platforms before that happen=
s=2E

- Mani

=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

