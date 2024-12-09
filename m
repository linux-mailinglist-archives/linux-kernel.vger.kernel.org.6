Return-Path: <linux-kernel+bounces-437133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387729E8F80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9094B1632E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAC621766B;
	Mon,  9 Dec 2024 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnwRUM1F"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB6217645
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738102; cv=none; b=TpVlkTR4X1uXYK9K1vwgm/7iaz//Vr2eEdNukYBbaeM1FbiqNLA98LDYxeDMphPXc6P/VvyN1TDqCCIIAJll0JKqWfUOgNJFTtq5wyJYHim3NomRzoW9pTdwQmU9XD9+P5LNnkyk219vphYCkBxWkuw1KhjTe9maWAM2Y084jVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738102; c=relaxed/simple;
	bh=OB9He6hF6I8ijcVioJl0rUXSdngnWa1nHdHHNLYHYmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQzv2BHkU2l/DJ9iZjZ2nphDG8YusfUphTO4MiaClORb7nOZvYMJFCAHeZFhfb6V3HYOWcBLtKsEUX1Mw3hG5SSXSRyiHqQ4AFJskVDcDEE/qaKuVUQVjIuSq0jkdYv4akRZq5XenkOqV9iTVGaC/DuWp/rcpNMW6pymUQwM+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnwRUM1F; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434fe0a8cceso2145005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738099; x=1734342899; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OB9He6hF6I8ijcVioJl0rUXSdngnWa1nHdHHNLYHYmA=;
        b=xnwRUM1FRkB2XhnWL+E63aLQhp5DLVmz59F34CEHCDeUmylZkRolCBVymiXCHvqxsy
         GwuO7r4PlnkcFw9K/bMO0zooXuGHo7eX0DM7L9xdAhsmQJGKXwbxOfefga/5BvHk37bm
         UeBQ7n1PwVCDIwgzzIJGxIsI2Cl3iQzCJjUmlbm/bd63oftSMlUfin3kI13hnWXuZ5QY
         99+oiwOUOjekTnprPoZpeAf/mMf2euM4AIjLFTbA1ElaMNWYqtLh4ThuQK6uLw8qZf0w
         FYNqce6Nko47cgSo155YFy9uZxkI8wtA261tfsw5NmeomPZcyvvPoPY2hk5S7ef6nR3w
         4Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738099; x=1734342899;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB9He6hF6I8ijcVioJl0rUXSdngnWa1nHdHHNLYHYmA=;
        b=oJmTr1qUMf64Ptfd5DPWD2sVTpk2AXKF55a7m2OLCZQ1PlBO0dllZ2mevOzaOD9bft
         zEdBdjPYx/THKGdfwiVhJZz5Nt/Hhjrl1BST1jgfvVpXsefHKdxFYmX7GGLX/Ai1QB0x
         s318j6jKXID2TX5K9KEudiGp5OdZbtDhX/+zfcIOUzq++Q3anTHaJ8AbGOs3jzJ7d4Y3
         P5RM4jsP90oQzQODEyCgFiOZphHaM9Zxwc4YiEZWTk+6VjD1LsQGT6kNdFi7rZjchwY7
         q4eiXfRmn78BfMWJ9VleHWjjeAsfvBhy/GyRrUJZcJybKGq1293NR9Y3lCLnHV2Fdqvm
         CY2w==
X-Forwarded-Encrypted: i=1; AJvYcCXpx9bmuUW0mbJ6GUrsQMOO6wEjGcdouYVg93WDjZI1F72rF7VPmMyUSIE1UxCmQ8N0eioUHUb+xZW6wAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKBTJT6mIQhYfyFGiHgEiBiYKfs11HXqV9fjIOAozUi+RuONJ
	KX+wmx7vq/W8VtNODX7WzsYDKmSU0oK9NpjPVRqvBXnJOtGELwT8B18Ev5t8PAM=
X-Gm-Gg: ASbGncsv1LjyQnsCuJmVR12/fPPQ+/HUlRgeujc/9q0rSQtAUtL+mUV1UtAz4GSedNB
	hGn4Gp4ifc9eLjQm4Xhp6slFBELjxQKWAiGy9UWFWgI1+qSp88Gnf+rrpMtX6vYy6p9+7PiIq6w
	5KSjx9pXBoKOVobRwarLmhId1c0nhBR+ORtUOuSg4QTCFIDQx0JChObTQAbeitocQhfcQxtrM/m
	voke9NYkodnX38LJDzoivXriqipN9i6tf3HxnfwF98F2yHDLRolWg==
X-Google-Smtp-Source: AGHT+IF0aY320LKmbb9VsSh4Bu/wLdBuFlAilYWTSx5YOCp9lTexIQIbfl6KTwoZqY9Q3xeWbQxuNA==
X-Received: by 2002:a05:600c:3783:b0:434:f5c0:3288 with SMTP id 5b1f17b1804b1-434f5c03c29mr28643785e9.29.1733738099338;
        Mon, 09 Dec 2024 01:54:59 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f3c96ca2sm52326465e9.24.2024.12.09.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:54:58 -0800 (PST)
Message-ID: <bbc6654e3ce7d28c4a98e25db270615b07a42c01.camel@linaro.org>
Subject: Re: [PATCH v3 5/8] phy: exynos5-usbdrd: gs101: ensure power is
 gated to SS phy in phy_exit()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,  Alim Akhtar
 <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, Roy
 Luo <royluo@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 09:54:57 +0000
In-Reply-To: <Z1W9xuCrn40uPWbr@vaman>
References: 
	<20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
	 <20241205-gs101-phy-lanes-orientation-phy-v3-5-32f721bed219@linaro.org>
	 <2024120528-poker-thinness-6cfb@gregkh> <Z1W9xuCrn40uPWbr@vaman>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vinod,

On Sun, 2024-12-08 at 21:09 +0530, Vinod Koul wrote:
> On 05-12-24, 09:04, Greg KH wrote:
> > On Thu, Dec 05, 2024 at 07:33:16AM +0000, Andr=C3=A9 Draszik wrote:
> > > We currently don't gate the power to the SS phy in phy_exit().
> > >=20
> > > Shuffle the code slightly to ensure the power is gated to the SS phy =
as
> > > well.
> > >=20
> > > Fixes: 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 =
combo phy (HS & SS)")
> > > CC: stable@vger.kernel.org=C2=A0# 6.11+
> >=20
> > Why is a patch 5/8 a stable thing?=C2=A0 If this is such an important b=
ugfix,
> > it should be sent separately as a 1/1 patch, right?
>=20
> Correct, one should move fixes to top of the series..

Thanks Vinod, and sorry for that - separated out as per Greg's
request here:
https://lore.kernel.org/all/20241205-gs101-usb-phy-fix-v4-1-0278809fb810@li=
naro.org/

Cheers,
Andre'


