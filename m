Return-Path: <linux-kernel+bounces-544220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7658A4DEF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94BC3AD11F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083A2040A9;
	Tue,  4 Mar 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvplTE3Z"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88971E9B28;
	Tue,  4 Mar 2025 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093989; cv=none; b=Gk7MhDCZBdeuWB06OT70uY71ijoPY+BwvKZT7u+z0ezD/niaMo27UXmsmt7n9ls7tz1qxdVkbsYg+tGXM3hU3DGjEkjWXgInh2uqS6Lee8VOysuy0vUiTSrltV4Obu0JXZQjm3I2pH4xacCJ4R053+rOZc7PAVGEdLDYlX+x+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093989; c=relaxed/simple;
	bh=9nIyrpqzNV/OSz0veM7DHdi0wUUDdJMwdBqkrgqty70=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Bqtwr2+kanNRz668lR76xcGllnh4MoooHyR74u6uA19bddiq+H2e51jqAiQCGvh6hcV5pEOxxOXb8mWRDKQwgFbjV3sVRQYyGhyz19M7341kIffkQoAIsU3MZtoFEpXM8b8+BXgDOlur6kfze3YX90AtxtybOv25QFwcWP2PiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvplTE3Z; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso6418867a12.0;
        Tue, 04 Mar 2025 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741093986; x=1741698786; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLbCdf5ydhGRwAPCjiKPFxPNXbtTOCnpAyz9+gFbv3Y=;
        b=OvplTE3ZSc11YZagaTiBQn5T0CHA4q0m6qRx1O1qkdVFwGwUTl9ljHvFuATim2gWRt
         FsSpq65Ol7CHiVmwtPEELAT3s25PglrUQ2B9yNEnLL6OSZYamjnJ2ABcR3RbLofiMbYR
         yGAdUIoPPMa4dP3Hh/JaEPcw8W6P0Y6Ct1ilpaXmMpfLh0JrpntXQ1vNxYITbe4wh6Ew
         L+H61g4FeC4VrOhc2QVX/LhLD+sDCAVCoXo6ziUA8V5qm/6Srip9zri04ig0Va69e3h0
         GQybH6uHAyo/6uaZK/Afpnc+4BzRWDz8hvYURSbHkVuSBynRxDs44Q+B6Lkx7G4EaU+A
         4aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093986; x=1741698786;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLbCdf5ydhGRwAPCjiKPFxPNXbtTOCnpAyz9+gFbv3Y=;
        b=EKY6/y+GgbzS91N5LMyhw3wclaBk29T+h+6WldtZIH4aIfUaK+2zga18NkLVx65yzx
         rmuWOI9Pdl1X50DnSMtLz/s4xN/aMKdZ3NJYxlCqfCP3wTv4CGPUkOZPiR7RGfGWlZL6
         uKyVXrLenYM6n8Px0LLq/ikrrP0Z0QDlUsaiQjFph33YLJmOhFva7wVtzGfNmETPCSd9
         9GvA4nQIlfGdoT+z2enelvS7iLkbH/XHgOgM3kv0t1FNu9Yrw+7Fan7VapXmDEPSVj2o
         8TwNe2rQ68/1X8M8SCIcKYZsaisWhLsoq61xvlli5+p3kq4BoRnOLV0sC3X4ak7xoWfy
         FZIw==
X-Forwarded-Encrypted: i=1; AJvYcCULW3wv80ZKevf0yazhb2UZNTbqdyi0ABRmN0t3IudiRTBeM7smk103rZKHIdx3fqZ0K8tAngG1ols3vQ9D@vger.kernel.org, AJvYcCX7vUwGbd4DLut1e7J4aa0oGeS28K8Hny6ADhnwzQpuyyc6aUkEfdaPfF9oX8+0ZqYAS7ljKUowtFCY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn3tJd/a1U/iXXXZq6gdISycZ46Y+hMtWbIzkwjXwuAPkQhBwE
	W4CHpIPrKIFIqvPUjRERPiZderhjGe4vFeXaAwh7tmZ6bfkK2oeRBgN2pQ==
X-Gm-Gg: ASbGncualbrGnPs1ey0Eqif+oF8I1A9ninXa9Oz5nT2iC9C9GRAKPUW0/P6gwNcPDiw
	c6HN42N83l5mR1oX9g+bI+/XM9gdVMTOFEuI49WbJzcBursxmp1+tm5W+O3WMmBGzopPY9kksZa
	TxNgFljyKw+SLaR0czKVtszhDlQtOMuOQ3w7Wgat3griOGVVT0eP4dz8pvKGHyTQHde6mtvIAir
	gBG71HIRXyUBfa6CR7SxjQoSncwbQzK84kkCc1fwpioaPl19vKXen6RW3aDBFRImF9JValMNWQl
	zsQACDexWMQumxUsjH+ejDlgdH5aPghwE6wkvcjjm7hys4zs42F4n8w+0FBy4RrYY1RZGqK0gp/
	+fvk7A/BqEl1r7ej8MbzqEbCLGw==
X-Google-Smtp-Source: AGHT+IFoaUg9Nkh97ooIflZaTgzJMVg2UFR+7WPJFlk7BUC+KoSF3yd0IR8of6FOHQwHK0CM0VOg2A==
X-Received: by 2002:a17:906:6a24:b0:ab7:6fa9:b0a9 with SMTP id a640c23a62f3a-abf25d94191mr2160998666b.11.1741093985833;
        Tue, 04 Mar 2025 05:13:05 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c2f408cdsm8118489a12.0.2025.03.04.05.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Mar 2025 05:13:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 0/6] Add support for RK3588 DisplayPort Controller
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
X-Priority: 3
In-Reply-To: <7b8767fc.3607.19551aa5f74.Coremail.andyshrk@163.com>
Date: Tue, 4 Mar 2025 14:12:50 +0100
Cc: heiko@sntech.de,
 neil.armstrong@linaro.org,
 sebastian.reichel@collabora.com,
 devicetree@vger.kernel.org,
 hjc@rock-chips.com,
 mripard@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 yubing.zhang@rock-chips.com,
 dri-devel@lists.freedesktop.org,
 Andy Yan <andy.yan@rock-chips.com>,
 krzk+dt@kernel.org,
 robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <047EECFC-7E55-44EC-896F-13FE04333E4D@gmail.com>
References: <20250223113036.74252-1-andyshrk@163.com>
 <AC3DE87B-64B1-4C34-8E1B-3900E2C53AA3@gmail.com>
 <7b8767fc.3607.19551aa5f74.Coremail.andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
1 mar 2025, o godz. 13:24:
>=20
>=20
> Hi Piotr,
>=20
>>=20
>> is it worth to play with this or it is too early?
>=20
> I think you could give it a try if it using the Standard DP=EF=BC=88non-=
ALT mode=EF=BC=89 port for output.=20
> Since I don't currently have a development board with DP1 output =
available, I haven't been
> able to test it yet. As for the Type-C Alternate Mode output, some =
patches are still required=20
> I'll  send it with V2 tomorrow or next week.
> Feel free to let me know if If you encounter any issues=E3=80=82
>=20

Andy,
I added dp1 enablement in rock5 itx like this: =
https://gist.github.com/warpme/bddf75912193f57724c49216d5d85d4a
Unfortunately it not works.
For /sys/kernel/debug/dri/0/state - pls see above link=E2=80=A6
I=E2=80=99m not sure: do i missed something in dt or rather issue issue  =
is in dp code...

FYI: schematic: =
https://dl.radxa.com/rock5/5itx/v1110/radxa_rock_5itx_v1110_schematic.pdf




