Return-Path: <linux-kernel+bounces-553375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBBA58846
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC62B3ACC56
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465FC21D3EE;
	Sun,  9 Mar 2025 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYbgS9NA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184751E1DF1;
	Sun,  9 Mar 2025 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741553653; cv=none; b=s5yNb10iWSHMU+t4pq9npLDIWiMbs6lk7Tf3OB0C8DD8uxsQLYGWR1ERnjEZ9gyCYSA/swjumlEis/tSCz2K1CT11qleC8v56GzyVjXSlUb39hMohlieGycs1+DJrwKpRknyjpw2mKdkUaPYZ4/BDXcmPd4Y59oxMg6qH1HwRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741553653; c=relaxed/simple;
	bh=2pHGt52ZxKJ8a4yondRjxqtl2xsq5mdkeTiSZHQgLak=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iqBb7EqZj32K//PQ/opP6vYDUSYwz1u/DkYEaL2EJ90IFXzQsF6S3HIOz/qsmqZRpTs0Kp6BuIosJwquBpdkwBfrveVHa2vHY2tQ1HdONhVc0oZfQgBvxzQHIe4q7skII/u8qIlDG9GrHIw+X+c72euH8scaUKu8JEJZLw2voqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYbgS9NA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac27cb35309so169317566b.2;
        Sun, 09 Mar 2025 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741553650; x=1742158450; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSm+onMEHwFJZpJzuOCRbpMFcD/0+q6u6nZOZEP268Y=;
        b=SYbgS9NAm+Lry17J5opy1CYAJo85iomZzOICkwIvV+Rhk4k+FrNej+tz8vpLbb8VE7
         gUJADVCVvrxHXasIYe1CWsfMzLpaxPNkVSqXikac77L1dZ+apP2bqebPwg8azsQ2qJ2T
         2SlzAs/sxptVVY96o0ipTd9xl7i5ZCmqZgdZdXk0s9dBdFK45g7tcWirIoWv8htr07Ej
         Y9NMZsAnW8sdniqC91CpPFGClEqzYbfu8OkK+nVdHa4KsukYGwRiA3Km1uQiQVvtw6oI
         5HhRYjG5wfDKY7Vdj1Fq2x+NprXBQKTXK9tf5r375RHky3p9ZD7R3kbNdpRpQ6j4ypqp
         EqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741553650; x=1742158450;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSm+onMEHwFJZpJzuOCRbpMFcD/0+q6u6nZOZEP268Y=;
        b=dnysEI+PlKukbQ/+Q+h4uCfNI59/bQlXs9rXWXUpay5n4/FUXO0UwQpg3YEc6w62f5
         B5h3M99dn5j4U2YznotsTYb+GHV+QKCrGMfTf/k2VM6kQTtvhsxVdUQ8uE2dPBpJCzal
         tYlm0PMcbTqfaaukivk7qxbR/q+dQUvMo7krPwvh4l1/JyrUUkzmTKb6FXq52COPtCXm
         EOYs1tN8+s2TTcAL1XNbnOLHR83imnDBndkrg4Y5Pj7/dxfO5b5DsWViHRT9uukjwMQ9
         Vg8bkrg/nfy1ZAvK7HalWEQTlq8BOgAGYQpqx6C7/z5HmWsvzyL40XUxho6jnktA4WP9
         a5lw==
X-Forwarded-Encrypted: i=1; AJvYcCVIT3zjeYErM16/vxm8sfBqh3n+bALweUHuaqOFMprFXOzUWS1gC5Yp5vpcI5pvgYmYDjcQVaNlQOKIkMtM@vger.kernel.org, AJvYcCWQwBftERQatgJBafcmCToBhEquuCiSiBQNUTxB6/nMucQ8jGGliNRLdNaJIrHPlaoJvd1eVwBwupa2@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXUpv6QQ7hjsGx34sGbaPhI3InwgE1dMn4qkBu+HbPy/5JZ1N
	HcZhvxMo6IED6WT8eatpQMXQlRbaGsxygcUP937LzJPcs/Nw1jIa
X-Gm-Gg: ASbGnctR4I12gxqHKXcWDBq5DjkytLV8ynLAvdFFWlSn138YTsbiZjZkjT1usBvUMhJ
	xI1iDTR7HVAuTUEI66LCS85rfB6AwwPkbhJR+G+gRh05JP3qQ/4jP0J9XHWAkTA3vRbH33cm0PS
	rtQlHtnOMijIcgKWzYwTT5YAFm/xZMDBo1APk/os9I1kLZaMN++n0LGFmGJuzL8H5JLxd1z7ulv
	aPEyWvNcsLJvAsPlgxdGnExZfRoXoBiXLr2czaQJ0hkN2/Dc66jb9wKc9QENh5OAMPmcJx0HZr7
	OoJSAPNj6vYDvD2wqmb+ovDj0Q6/zDghVXrljKNUogju4932eOV38XJ0wAbiiT9TgE+eol29r0N
	IO/L3nPAUn9OUD55KyZoc/jcX+A==
X-Google-Smtp-Source: AGHT+IEkphpQpWmxa52E9NmJ7R2K15iVQw2MxsItmN3QV+4Fwm8dnR0PSWqP8wMiR4tkyT8ZY5e5Bg==
X-Received: by 2002:a17:906:240c:b0:ac2:6a7c:142e with SMTP id a640c23a62f3a-ac26a7c2295mr672419366b.44.1741553650157;
        Sun, 09 Mar 2025 13:54:10 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac278a7a7e7sm299767966b.47.2025.03.09.13.54.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Mar 2025 13:54:09 -0700 (PDT)
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
In-Reply-To: <545cc438.7e3.1956e13a3e2.Coremail.andyshrk@163.com>
Date: Sun, 9 Mar 2025 21:53:50 +0100
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
Message-Id: <AD2A56F9-B4FB-406B-BE7C-49BB5DFD3BAD@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
 <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
 <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
 <44213B17-FE14-4FB8-8319-1E31BBF6EAA0@gmail.com>
 <74c154b6.8c50.1956aa8c8d2.Coremail.andyshrk@163.com>
 <1573D5D6-AFED-4D92-8112-B0C6BB52D5FF@gmail.com>
 <46c0d239.a4f5.1956b619b97.Coremail.andyshrk@163.com>
 <252BB2E2-4BC5-4402-953D-F7B30EA5DE14@gmail.com>
 <326B91E9-FB91-43C3-B98B-3EF079F313C6@gmail.com>
 <545cc438.7e3.1956e13a3e2.Coremail.andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
7 mar 2025, o godz. 01:48:
>=20
>=20
> Hi Piotr,
> =E5=9C=A8 2025-03-06 22:28:08=EF=BC=8C"Piotr Oniszczuk" =
<piotr.oniszczuk@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>=20
>=20
> All dump information currently appears to be correct, so I'm =
temporarily unsure why
> there is no display on the monitor.
> Maybe try some plug and unplug for the DP cable, or try another cable =
or monitor?
>=20
> It seems that this board uses a DP to HDMI converter? Does this =
transmitter need a driver?
>=20
> I won't be at my computer over the next two or three days, so any =
further replies to your email
> might have to wait until next week.
>=20
>=20

Andy,
FYI:

I done test on mine rock5a with applied Naoki dp0 enablement in dts (and =
only in dts).
No any changes in dw dp driver (so i=E2=80=99m on vanilla  =
https://patchwork.kernel.org/project/linux-rockchip/cover/20250223113036.7=
4252-1-andyshrk@163.com/   )

on mine rock5a ra620 hdmi port works ok.
(I contacted also Radxa about ra620 and they confirmed: ra620 is just =
DP->HDMI converter. No any driver nor special programming/enablement is =
needed)

This tells me that dp0 (rock5a) works ok while dp1 (rock5itx) not.
i suspect issue is probably in =
https://patchwork.kernel.org/project/linux-rockchip/cover/20250223113036.7=
4252-1-andyshrk@163.com/ and is related to dp1 handling?

BTW: there seems to be issue with video modes handling on dp0 port:=20
-playing video 1920@1080@50 - ok
-playing then video1920@1080@59,64 hangs board=E2=80=A6.

hdmi0 works ok. video modes issue is only on dp0




