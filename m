Return-Path: <linux-kernel+bounces-549086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D99DA54D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B954A3B215D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E611509BD;
	Thu,  6 Mar 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfNXRKyV"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15517CA64;
	Thu,  6 Mar 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270113; cv=none; b=cgbjNKHMp0U3d8Lc6THsRNdZHpmB4I0vn2SfhKfG0sdByPH/IcBdq65FD83o106WpKWwS4LqBxzXNoxGTguQVEM5hYokQzqw7xEtWH3Dzx/UkpfUCNANDhnmaNO08jnQinMVblKabL3GD7ktxkQ5LqwXoQ2b/j+8LaJkts0m+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270113; c=relaxed/simple;
	bh=kWV8ljageqb0izUaC+/nzAbBvrv81I+4eNjdwXRR/Fs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G3QSuSxvSTAAxblb80J+vgGAW1ULUzKBq31UTbOR4IZV2Vhon8MtPeh0gEz6cHR0g1hmqdnhPVxhA9LP0SREhi2sIIVmrkX9ZnPacNrT9BdrBYX7VAf/yEIkjCpzVPmpy1rJlbJNwYDKVeAn4pjr4mUzzUbY7luRSQ22RARbjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfNXRKyV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e539ea490dso988864a12.0;
        Thu, 06 Mar 2025 06:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741270110; x=1741874910; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWV8ljageqb0izUaC+/nzAbBvrv81I+4eNjdwXRR/Fs=;
        b=kfNXRKyVBzqghavRJ2mKMvpHonCN/nHXFLlVs60BJwRQl/LQDRoL559vzBoSVROKZQ
         kXmXc1ctFZ8of2RjqBdezeZu7JLOFfw6cyBGlrMWfWI0nHognKmwjCS+hOjoOa92crkp
         eV3QF98To5aNkyyK5XQNHCp/mywDqU3ocGJ+S0sI+RhacDW3gI1fCZGqe3nWRRKajdmw
         16HMxRyftcQM0+tgGm+eJrB2OW3sEt8A/luA6+sN0xtHOw+pe84XV4z9qB4DA5JkSQvx
         Jr96EWv3FTJZ+P3LNQh8qFTIQdv5vIV82E3m5TigdGjfyz8bB6wpWjU1f5vRybAi/WXw
         S53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270110; x=1741874910;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWV8ljageqb0izUaC+/nzAbBvrv81I+4eNjdwXRR/Fs=;
        b=j9WwgOHsWzKcfYA5B1pF/ef5r94itNldKEsY77VN2u0nFCKDVMC4ccFY+nhCh5VZ8D
         V4rh+JBciqIq1WrA9g+gEEB0rB2PJ5KmTsU9t9iJPKnEgzcIOcxbLpWt6YCJg+rMH3y8
         0J7Ag1duDso2W4MT3sJxc7rLh67rOMZhzZtArwS16slmSeEcQatwj6zj915zzJTzTJ2E
         raT+YCri6x5Ar+Th2n69eK+W9p64pqSPHrMutDU5gn56vpcTmxAfcAaVEbap8Y3Sij6S
         NlmNYw5r2cAhZSe6hnEB7qV+8SC26g3mzgFapt+xELYxtgMc8HakK7kdEYuh8JmVW1Dq
         XPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2R7wRjGSiqTWK2OY3s0wDVckCHdXEKdVkl1+sK3ft/L6sDiHItaMO1fpmO7A+onJeekgsB0bCi00Q@vger.kernel.org, AJvYcCXSEheWDo9I9UiIbjKC+Sfjgu8SN4lgPvZyzUrSHZCWUMLXxfFN82+wxDNjDJV0YLOr6v5E1vOxEik5dMBN@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+1FxSXIJq3UKIhz0R4iT85jADrk15qx1pMBRL49EuSEcapVW
	cVGl9lc/0RvHqCwm3ZIPTLsrkCpFwFXXgw4+ArRZB5GRWzzarRFF
X-Gm-Gg: ASbGncuUTJpSzijwt/+Lr/gV+hNLD7OLMmGA3d0qdQ/jOw1tj30Kuy4qkA/y2zTSgp5
	4IYmen2j6ckncJQ0FBm2ruGIDRN+5ZK+OaEhEgWwIdmXrdbpv0bBJ1LyiRiVlUN9R4yZsorz36t
	ghKfgiYsO2ZSX7fHqQPXyHiKGpBXOvWHHKPGE5OB1TSGkwcLRkiTSLyr0fd2Hvz9DyeTe+ZqeEg
	JlVh21xDzFc9ZjcRjjbLrUa7u5bM8C+VBmqWdhKZwWcYwHxw+W4kIx+pE6eA45mq7NF2iONGS85
	kQL0ss3czDA2ySgLTMLMwl8rLdjaA7ZuGzMeIlP3tRE1XxVpyNOLkamuI91HuQR6EDCHvF31YQH
	rCzo0vJ/O1Tlw7CuVqRT/y9vUxg==
X-Google-Smtp-Source: AGHT+IEjOK8tItru0CnDJMfpuW+YocWEOgCRwuy6WiSEato+NxCIl7mKq10KFt+G6Q2r3z6rTWjduA==
X-Received: by 2002:a05:6402:2186:b0:5e5:be7f:a1f6 with SMTP id 4fb4d7f45d1cf-5e5be7fa870mr8495205a12.1.1741270109496;
        Thu, 06 Mar 2025 06:08:29 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7475e9dsm989794a12.30.2025.03.06.06.08.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:08:28 -0800 (PST)
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
In-Reply-To: <46c0d239.a4f5.1956b619b97.Coremail.andyshrk@163.com>
Date: Thu, 6 Mar 2025 15:08:14 +0100
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
Message-Id: <252BB2E2-4BC5-4402-953D-F7B30EA5DE14@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
 <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
 <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
 <44213B17-FE14-4FB8-8319-1E31BBF6EAA0@gmail.com>
 <74c154b6.8c50.1956aa8c8d2.Coremail.andyshrk@163.com>
 <1573D5D6-AFED-4D92-8112-B0C6BB52D5FF@gmail.com>
 <46c0d239.a4f5.1956b619b97.Coremail.andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
6 mar 2025, o godz. 13:15:
>=20
> Hi Piotr,
>=20
>=20
>=20
> Then when you DP cable plugin, you can run command as bellow to see if =
the driver detects the HPD:
>=20
> # cat /sys/class/drm/card0-DP-1/status=20
> connected
> #=20
>=20


Andy,
Thx!

With above changes i=E2=80=99m getting =E2=80=9Econnected=E2=80=9D.
Also it looks crtc gets reasonable mode: =
https://gist.github.com/warpme/d6220e3cc502086a4c95f05bd9f9cf0c

Still black screen however... =20=

