Return-Path: <linux-kernel+bounces-177322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76C8C3CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF581F21A34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59136146D5C;
	Mon, 13 May 2024 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnKN0h5K"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54913146D51;
	Mon, 13 May 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587687; cv=none; b=K5aI5Be6Aj9UPX2uayaGIVMvnviZDeE2mlZ77EOzFcY8zHYYfCqDbsIg086APDs9PPWhBClmXh/RajEbM/Ms74WQyjq7xJwIEMwY3NOFsOOi4Ap3L60oYgyKwZPvfyr05Ul0CxRE93dom9/vE7GH/505HDVKzVlGEk2yPLbc6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587687; c=relaxed/simple;
	bh=Xn16BsD6Y1EZP5PWKG9VaDuAa6DEy5hYkxpQIqRBs/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g3e/h3sAo4FTFVN3gT00QHHf0pkdyzAspvIxqdHveepfh2oeiB7mDc6X9VAM/KqHiMbSMQeYWRIOT4XAKmC0RP35mOI8u2kvmrkQ4XxPL8HbCMe3YA9IUbtMCZGEd914A2TrxgTeny2AvDI2A4wGi+0H4gQm3nrrrR3CTRzQtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnKN0h5K; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44390e328so3820542b3a.2;
        Mon, 13 May 2024 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587685; x=1716192485; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYA+EdDKS7MiEavbl+qcIdKZoLUzS6M2HzJbOxe6W2A=;
        b=lnKN0h5KToDaxhwHfjaJUDNBuvL5jKy84+8lughda9b86Lv0Oo4lu33j7VMiQF/QXL
         WN/iY6Q1rz5AWBUspkyjxKc7FH0UqdkK9d6Gfk7Kb2jHj/3R7PSKotxTHtSkZnlKuxY7
         O1Hyt6T2s1ngHjEboVlo8h/dJBM6FhYuOlalK5lIPjGP8s77Co54qXmv74+6fcZDLZcF
         fRekj+wD+l3TLzEg0jPg2afXnZY4VV8dqGyxu24nKvsX0zZea7O99ScFnAKmTr89oxY7
         wOPzAH4KWnrHdR76bbGwLQkCcrgOhzXR/NlqNWh3yQ3SEPBlwAVyWKTd1ZpZO9AeOD3Y
         +WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587685; x=1716192485;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYA+EdDKS7MiEavbl+qcIdKZoLUzS6M2HzJbOxe6W2A=;
        b=YN5B8wTMBXh2SypFCSOFMSc+JO+rMRso1yrQpsfRIfpKnM0+SRdcc8zW+Tf8uJep24
         3eLwzuLAkoncqixmobh010OrgWfcogn2/zIogSYgTPkhDyvyVDzeK4EmLDnc37Ete/4u
         sJ6wztwC4wu2S1o7/xSHGF9VD/Y8KVlG1k7z7rJiFzd3mZcg606LJ1IS21rvlU22DeCU
         F3thbhXIaYiDCH4GQ6hfrr5n304UWK9hkZgKNS8lHkwqwYuQwuiBDicd9GF+RM1sUffr
         h8511Aiy6L4J8O+iWssW6uVUf5UYSTMWzcfxi4tWiI0RA5uMivvQW8Bby+4Umhwa/DI7
         5PHg==
X-Forwarded-Encrypted: i=1; AJvYcCWxlZFZbNk6AR9bajFNF2pzVWy4sYGpBqM5n0/BMdFVSr5fOptgFr7zTgMBDoS8WAiPh7TSkqqZcMWe9F+c6lA1OAJSBSjFAE9WTpY=
X-Gm-Message-State: AOJu0Yz5ER0CmYtsDpLDv66FxMmWrTBmgshMpGzQein7lw8EltTpZg+N
	468BrpLv7Pic6A0EnGhM35XwVdvl8mBA49xfVZHCMnrk3wBlPpQv
X-Google-Smtp-Source: AGHT+IGm/ZCF7QOgaS2UkgqBbnLTnbvnPKP4mgl/j5xFDi65vgFgpXq6hphS4oyOzrmf/APRYhnL7g==
X-Received: by 2002:a05:6a21:398a:b0:1af:fb2c:fac9 with SMTP id adf61e73a8af0-1affb2cfbe9mr1528307637.20.1715587685524;
        Mon, 13 May 2024 01:08:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665a6sm6817168b3a.2.2024.05.13.01.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:08:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 14E10184885CF; Mon, 13 May 2024 15:08:03 +0700 (WIB)
Date: Mon, 13 May 2024 15:08:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	sound-open-firmware@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mete <yurnerolinux@yandex.com>
Subject: Fwd: Garbled sound at start of a playback after some inactivity on
 said channel with DP/HDMI on RDNA devices
Message-ID: <ZkHKYocpP-abFwLB@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ZjYnqrlC4VYcUrU"
Content-Disposition: inline


--1ZjYnqrlC4VYcUrU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Mete <yurnerolinux@yandex.com> reported on Bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=3D218823) garbled sound on AMD
Rembrandt devices. He wrote:

> As it is written like there, when said channels wakes up from a suspend s=
tate (inactivity) issue occurs as described. While i've applied noted worka=
round in there as a temp solution now, Nvidia gpus doesn't seem to suffer f=
rom it so that makes it a hw specific issue.
>=20
>=20
> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3953
>=20
> Basic system info:
>=20
>=20
>   Device-1: AMD Navi 31 [Radeon RX 7900 XT/7900 XTX/7900M]
>     vendor: Sapphire PULSE driver: amdgpu v: kernel arch: RDNA-3 bus-ID: =
03:00.0
>   Device-2: AMD Raphael vendor: Gigabyte driver: amdgpu v: kernel
>     arch: RDNA-2 bus-ID: 12:00.0 temp: 39.0 C
>   Display: wayland server: X.org v: 1.21.1.13 with: Xwayland v: 23.2.6
>     compositor: kwin_wayland driver: X: loaded: amdgpu
>     unloaded: modesetting,radeon dri: radeonsi gpu: amdgpu,amdgpu
>     resolution: 2560x1440
>   API: EGL v: 1.5 drivers: radeonsi,swrast platforms:
>     active: gbm,wayland,x11,surfaceless,device inactive: N/A
>   API: OpenGL v: 4.6 compat-v: 4.5 vendor: amd mesa v: 24.0.6-arch1.2
>     glx-v: 1.4 direct-render: yes renderer: AMD Radeon RX 7900 XTX (radeo=
nsi
>     navi31 LLVM 17.0.6 DRM 3.57 6.8.9-arch1-2)
>   API: Vulkan v: 1.3.279 drivers: radv surfaces: xcb,xlib,wayland devices=
: 2
> Audio:
>   Device-1: AMD Navi 31 HDMI/DP Audio driver: snd_hda_intel v: kernel
>     bus-ID: 03:00.1
>   Device-2: AMD Rembrandt Radeon High Definition Audio driver: snd_hda_in=
tel
>     v: kernel bus-ID: 12:00.1
>   Device-3: AMD Family 17h/19h HD Audio vendor: Gigabyte
>     driver: snd_hda_intel v: kernel bus-ID: 12:00.6
>   API: ALSA v: k6.8.9-arch1-2 status: kernel-api
>   Server-1: PipeWire v: 1.0.5 status: active
>=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--1ZjYnqrlC4VYcUrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkHKXgAKCRD2uYlJVVFO
o35PAQDSrCz6kVUuWtodtSItFVvfxvBw8OPisRLj3O/PQXaYxQEA4KC49psV96Wy
eC7rjpSJ/sNnLEkCtOje1AYkI2vOrwY=
=u0zA
-----END PGP SIGNATURE-----

--1ZjYnqrlC4VYcUrU--

