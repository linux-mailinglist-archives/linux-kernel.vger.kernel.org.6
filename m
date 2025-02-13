Return-Path: <linux-kernel+bounces-513559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B741A34BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A783A429F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56F201259;
	Thu, 13 Feb 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOYdXXCK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237A28A2B3;
	Thu, 13 Feb 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467273; cv=none; b=K6cf2MEnxYf49DbY4c6pqn04521ce3twmmBDrI5LknlxfJUEDW40J42Itl8ivJQOZExmGR5DtYzA+hfDYZMgaStjW+us2Cy6L7YAHtZvxo5QNVYItIGby5ADZW1VBuCbBh1hk0VJLhVhvlN0xvlKBHv0lBRv82sG3KX0B7ltNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467273; c=relaxed/simple;
	bh=eMshZW4KePYkk+4RrbIpDw0C64HURR3dv+a1VPbleHY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V2n/PQXgYLVAMzhGVABQ4TSr5fBI2a+WnNkLXr0cSSDtAUYS1og1l9ouAkZX2jR/uPndPComzJpe9fKIq/E0KTGACruZyCpoklnMZkJFsvd+JmIuTpXcC/L4k8pyaPnMhCqEqGzvdQTt+Ym/r9afMO+LLiD6sK4ZppYXdXcaYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOYdXXCK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so969670a12.0;
        Thu, 13 Feb 2025 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739467270; x=1740072070; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L8X4e7idHOInm1E1NvmDqFmI3f3xIs3AaNrbgOvVqo=;
        b=UOYdXXCKSGfICywCvZwhdWYNUmymgu6k25DPBYpwekgdwu5P4vCfsUUnahZ2f66RPf
         c/vGpZUq134GdapHfQF+UE/N6h7d2hfWDdMLJY9cMJs4Rruc581mQulKLDeWD4SjYgUC
         wlVt84nANMtd7oyHQUqDMjZ3RARLWPQyLh1fYoARoOvKK+JcYjySr9hq+cWXicWps4k/
         LmSZJYf+Yr4f6XpgEnbJeoaj+0KdUWH+OEihbV3qe/cGuISmOOn0VkIWtiRjezvPPQG0
         Yn4tiNR+HzXbaBzUEmpsc05T0Xmwfv5pxss1c5tdub9sLqxMPMQE3CQ911Fvx/w+qKcp
         Tniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467270; x=1740072070;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L8X4e7idHOInm1E1NvmDqFmI3f3xIs3AaNrbgOvVqo=;
        b=AwOuIAEieefp7lQUUedAEo36ZUmjT7ZfWvU1zL4g3YwP2xXcsr3n9LJYhBxzTGA/db
         CIDPqiyj3Liw6lHQd0GkWbWGYn3KBDOVK4Ns+WS7sbahEQkwtWuHO3bg/roUPksjPweT
         CWHSHIznm+M4RU4cpVY0TjN4YPc4Slsi/cnbbyPJCAzzOJH2tpzyQ7r9uyFhtebjDw/u
         5SjxcJiioy8dFKQhlPM7U9iPA9kJLrOLCru2iOcXw3ylB97xfFr+k9v7DlqWryv/AuRo
         yYS4EMEAVSCfhRUEBM7xALV2XqT4bRQglcXaJVKONjSt+zU0HV+4CXZjwh4liGJZvNnX
         cbtg==
X-Forwarded-Encrypted: i=1; AJvYcCVM66Ltp8L7f6KzhRbeUkSBNT3ED/JOo1DmI5ZwLqYSv4Nb7YF9EcpGMtNiVRUNYG2iuh/TGn//aFlp6Q0D@vger.kernel.org, AJvYcCVoAgiZhdGyk2Yfic8kpGViI+78oya1d2Fk+d+6GkACEaxeiqBITTez1+D9bDlBSRhP/v+SkbT35GA9@vger.kernel.org
X-Gm-Message-State: AOJu0YyjMu7GGeGzlW8T6FUX12YICH4OgKjJ7J1IHnpvKPlSUBQcrTMY
	SaDcYADiNzoFblO4LjgVsO50Oow5CqqUSpz1dae1XrBoiVMvewDQ
X-Gm-Gg: ASbGncsZt2/pX0JlkSLQwj8rf0WrBt79iFbNJeL43YvhXfdCJWw55lUrS3jXOq1aRtO
	b380cY7GcM9bKh9GgCXWVt+6eCusPDi1L2YBh5BxxBKaqzZKKBrGXFKIrX55SzrX5XBTWBk66l7
	CZQYh8g9pC46k1khnC1Cj8KneVF3+TOq2Hm3lllfFBwu2+XgAYeZnBprJU7me1/tGGSgYn8Pz1F
	KapQpsd0qQlZNRYEhY1IO6RBSN0BzGAkv++eVP4dCq0lUsu3xeWVaMrTeHIEE244NNsO7spbzzF
	ofx5+p1yJd/7zCBi9MMn2IEgBRARRWnzCzckHNqSKbpPJCQ6nFzvG38ha7okC/IuR2ZCEFPt
X-Google-Smtp-Source: AGHT+IErHbsUtfgzkzhuHG33dvhjaZL2J0Jo8G6oOoESna+1j7QGmuOo4G7y0Y6m+8a3iiqQL9uH6g==
X-Received: by 2002:a05:6402:3553:b0:5d9:82bc:ad06 with SMTP id 4fb4d7f45d1cf-5deadd7b8b8mr7475158a12.3.1739467269631;
        Thu, 13 Feb 2025 09:21:09 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d349esm1490025a12.33.2025.02.13.09.21.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 09:21:09 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v6 00/14] Add eDP support for RK3588
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <D7RH63Z1VBBD.1AIOQJIWPZIXS@cknow.org>
Date: Thu, 13 Feb 2025 18:20:57 +0100
Cc: Damon Ding <damon.ding@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Algea Cao <algea.cao@rock-chips.com>,
 Robert Foss <rfoss@kernel.org>,
 devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 sebastian.reichel@collabora.com,
 dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com,
 kever.yang@rock-chips.com,
 dmitry.baryshkov@linaro.org,
 vkoul@kernel.org,
 andy.yan@rock-chips.com,
 krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <59278550-BD6E-454C-AB31-084E13C19409@gmail.com>
References: <20250123100747.1841357-1-damon.ding@rock-chips.com>
 <5044FFCB-B325-40D0-BA82-03AF64EAF029@gmail.com>
 <D7RH63Z1VBBD.1AIOQJIWPZIXS@cknow.org>
To: Diederik de Haas <didi.debian@cknow.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Diederik de Haas =
<didi.debian@cknow.org> w dniu 13 lut 2025, o godz. 17:56:
>=20
> On Thu Feb 13, 2025 at 3:54 PM CET, Piotr Oniszczuk wrote:
>>=20
>>=20
>=20
> I don't know if it's relevant, but while HDMI0 got enabled for quite a
> few devices in 6.13, it did NOT get enabled for Rock 5 ITX.
> I made a local patch (which does the same thing as was done for Rock =
5B)
> but I have no idea if it actually works (I don't have the board).
>=20
> Maybe you need that for eDP to work?
>=20
> Cheers,
>  Diederik
> <0001-arm64-dts-rockchip-Enable-HDMI0-on-ROCK-5-ITX.patch>

Diederik,
Thx for looking on this.

Im afraid patch will not make hdmi0 working as rock5 itx board has hdmi0 =
designed to use 3588 eDP1 + eDP->HDMI converter (in-house developed =
rk620 chip).

I suspect we need:=20
-enable eDP1 support (hope Damon code can do this easily)
-map eDP to port0 in vop2 (port1 should be mapped to eDP/HDMI tx1)
-set typeC1/eDP1 mux to eDP1
Then maybe we should have hdmi0 working?

Im curious a bit about vop port mappings: maybe we can go with generic =
approach like:

eDP/HDMI tx0 -> port0  =20
eDP/HDMI tx1 -> port1  =20
typeC0/eDP0 -> port2 (+ exception for for rock5 itx: typeC1/eDP1 -> =
port2)



   =20

=20=

