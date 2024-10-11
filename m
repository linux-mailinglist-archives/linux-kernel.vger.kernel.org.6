Return-Path: <linux-kernel+bounces-361429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B099A813
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E13B21474
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92945188CB1;
	Fri, 11 Oct 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKp+XNi0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87542194AEC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661338; cv=none; b=jpDv2nAmux/gteV7nenvnh0Xzwk9dGRwDTU5/nuLXVK5MEZ6pWAm5bQnBWKYhPrm3JuKmEV6MqPEPOu0hqx2kmlFYaLCC+HLv++rb1BsF3wY9rv3KOJmVuTWU9wPkx/TpIrKLnWFphkI3tKIO9mxktZdDDAk9Cp7iBv6hEqw1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661338; c=relaxed/simple;
	bh=FTB9gGHrl3Jgo0ca2thxV5WEisBt66Y4CiZP+f9CMcA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pJsJ+sEflSFr+m5itBzxMl2cAdjD3iB/8IKbxEdmI2g4oMLjWuwOS22H3E6XT+Lkw9P7b3kUQdmBn8fsdZB3vtIjOl/MJJZKLVWmGjEW9OTaRtTMuY3F938AHFamkjueOUdaRBqpy+bdSqXahW3Z6401g142HMzqagmvSE0Y7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sKp+XNi0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b7259be6fso23415525ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728661336; x=1729266136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FTB9gGHrl3Jgo0ca2thxV5WEisBt66Y4CiZP+f9CMcA=;
        b=sKp+XNi0BNljQwl4hJt1qpUhGymq25wIhI21H5QnPkIY8EgwgY7RFKJZ03WHCeNlaN
         t51Z2r3pK/ESS8vavXHHz4BkSXpViHKcFJDMPtEHCFhtqZHkgxxkshzwrra+wx6YID41
         6GMXqNgE1BLTxcm7KTS4yV60G3TgqkCQde0Oqciiw7Ne/UVGeFJr26cbDLItFB1qxdSq
         gvNZMSLYhuXFjQRiLr8rTZpoNuuh2UO3KUd1fR/Q1opQtNmh7jcBxvXQtohc9Gg3QZ/8
         IyhF9MDtOCEbaxPAOg2/bsj+4COOXFqiatd4yrAoMrpFdFQosVHSPqYZdRRxObFe1C0m
         KPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661336; x=1729266136;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTB9gGHrl3Jgo0ca2thxV5WEisBt66Y4CiZP+f9CMcA=;
        b=ouwLNVOuGBfKUv9OrWl/7n1VNqW+OuGrPj/APbwjPjOUcLgvcYp/OI0dUUriQgW879
         uFfKmCkKEt1ptVyEJMixcxS68nOyhSsXySFCgc2fJfxxuDlIzggtRreCV/rksQrOXi1u
         uZP0FlV53vz3tTiyShcbGubAleKfPauHE3NFfW0WSK01M6OwG0Q/jojQCDY9xQQGOJLt
         NsG2qHYhvzDd/5oe0jb0CZ/JWUvQ6mL7J2AT4zyd4acKb9wpNBYkBIyS70FZFY46DfNI
         706OSZyNe9YG6+x54TMBlnY8Q0S+UTglMFxK7eVVlgJLwSa1ZqsWiBTR2IHA05vn08f1
         iggw==
X-Forwarded-Encrypted: i=1; AJvYcCUWiRtn2VOhZYhxyIqyVfaK/yCMrX7HEkIhjGq2oEZhyJFFcnMo2ECCGFTMwhcKmRhRFQOJD2I/nKq74AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFSRpccIge1n9ZFqmqbS1p3GC6tP29z+UHkFOcSOL9XdSPX50
	urbt2Q5v+1uO3YLB6LdTjLa6Z9yyn17W6U4hkPMZMig4CRNjgo0fnv9gBIezNQ==
X-Google-Smtp-Source: AGHT+IHp+vfQ0g8KOlGcVVFt/8dwQEWB4fGW+orH2uW909xVMHZ0L705DG0vqVSgL8WCAKaDo4xSUw==
X-Received: by 2002:a17:903:1c7:b0:20b:5046:354 with SMTP id d9443c01a7336-20ca16c2c0amr34930705ad.55.1728661335888;
        Fri, 11 Oct 2024 08:42:15 -0700 (PDT)
Received: from [127.0.0.1] ([36.255.17.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bada634sm24786675ad.5.2024.10.11.08.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 08:42:15 -0700 (PDT)
Date: Fri, 11 Oct 2024 21:12:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>
CC: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com,
 dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_3/8=5D_dt-bindings=3A_PCI=3A_qc?=
 =?US-ASCII?Q?om=2Cpcie-x1e80100=3A_Add_=27global=27_interrupt?=
User-Agent: K-9 Mail for Android
In-Reply-To: <eyxkgcmgv5mejjifzsevkzm2yqdknilizrvhwryd745pkfalgk@kau4lq4cd7g3>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com> <20241011104142.1181773-4-quic_qianyu@quicinc.com> <eyxkgcmgv5mejjifzsevkzm2yqdknilizrvhwryd745pkfalgk@kau4lq4cd7g3>
Message-ID: <4802B12B-BAC1-4E99-BDFE-A2340F4A8F24@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 11, 2024 8:03:58 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel=
=2Eorg> wrote:
>On Fri, Oct 11, 2024 at 03:41:37AM -0700, Qiang Yu wrote:
>> Document 'global' SPI interrupt along with the existing MSI interrupts =
so
>> that QCOM PCIe RC driver can make use of it to get events such as PCIe
>> link specific events, safety events, etc=2E
>
>Describe the hardware, not what the driver will do=2E
>
>>=20
>> Though adding a new interrupt will break the ABI, it is required to
>> accurately describe the hardware=2E
>
>That's poor reason=2E Hardware was described and missing optional piece
>(because according to your description above everything was working
>fine) is not needed to break ABI=2E
>

Hardware was described but not completely=2E 'global' IRQ let's the contro=
ller driver to handle PCIe link specific events like Link up, Link down etc=
=2E=2E=2E They improve user experience like the driver can use those interr=
upts to start bus enumeration on its own=2E So breaking the ABI for good in=
 this case=2E

>Sorry, if your driver changes the ABI for this poor reason=2E
>

Is the above reasoning sufficient?=20

- Mani

>NAK=2E
>
>Best regards,
>Krzysztof
>

=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

