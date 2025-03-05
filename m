Return-Path: <linux-kernel+bounces-546956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09486A50123
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA163ABBE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA324A048;
	Wed,  5 Mar 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOvluREM"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67D241115;
	Wed,  5 Mar 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182989; cv=none; b=TnN8tHrR1QUn4Sa8/Y05+ODpMvfSB7kVxHKsS7RSB6YWViHukZks7qEHZjEg/96jTKnpQvZaZzbQT0F1oi3dZXXWkXcLUNUJ+FMsrW82HTdn2RQCs2ifMbRNVw16RWTTvmmH/gnN5+7nzjS29WnFElA42bnox1cEyDaMasHryr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182989; c=relaxed/simple;
	bh=7tKVO1/yFtKo8AxMa+9eBPIXNrWvUam3daAFVJ/GPxo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AgMv1YR46MEg9uboXYLvxWIB1HZx4YvsqaLpVkvjNeH2INTPX4KZVW3qazaQDeyuPWWABcKS1/pTOjxqf4FK05s/zBMt3sTLQsLmAyQOayBTdKvg3VSb1Jga2rarVVpGKI1TdCquf3EwMfzaBIbU86DLvu8xHLlxJuo3Q57gdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOvluREM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf4cebb04dso173813066b.0;
        Wed, 05 Mar 2025 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741182986; x=1741787786; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tKVO1/yFtKo8AxMa+9eBPIXNrWvUam3daAFVJ/GPxo=;
        b=OOvluREM3cpYCuCH4n0CMdx2pew5SdU1oLPkTJsJVokuHeBAQoqK+jN8YJv3RttHHO
         mEu/w6mTsrSsHhXiijPUnU/vthNt6eX/0xUKmKH1EhomF44mn3/OwyplssqtPcugJ5xB
         szFZpZcJbMyHGUyNnoj7n21O/PphwrA1T7DzPgXFJSeFWkWIEC+m2zyORjoJSfA2AXsK
         bhXGvBTmISFHE596PELNwCMoKwura6RrlZejDEHFP16YTVh78majSee6EfkRYv+0fpcv
         Uog91gou1OTIxkb7sXZjeVuGikFPEspeu+L1djE++CSoDCEoh3L1+ftUMus6BVbjFQc9
         KTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182986; x=1741787786;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tKVO1/yFtKo8AxMa+9eBPIXNrWvUam3daAFVJ/GPxo=;
        b=tHSbz63TFc+Y+/9XLcNwb7PEGTikudp2IhStRZNx2E4G8XG+2ODjNsPsxIfyKkDPBF
         4I+UPVL9NR6p8q77Qf6aCxbvjKizAPAlQ83nCfUlL/KC9/z/JgXmUg8n1eyXuEWjBCqO
         7vXXedheozC5jQfd22x7XAVgNkkkDLWZTOAuAdEqava6Frh0cty49RXFDTI87v86q8+y
         O5BW2CgNZmM2dzHm35dCZSa0AcFsPs7HMTKcZyuUtsIlG40203uJjKYqzbAFPMVvMKkx
         opD0IRSW49zAt36eurEqp2EtJum2+jzkS3s7ri7+WHpnNGfCtQ0n3d7z5RGJhxK+5pyh
         2K0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS61B3EW7Fb1oIH/h9pkU7i/sEjfEY4OG9dnMfsHkPHmQg6cPXegD8kNx/XPxpFdIZVkTOQS5jSzDC@vger.kernel.org, AJvYcCWNlcbrg21GTe5fQPA1MAldTzWDtm+sNWfPAtHJbGxxcF8jwfJBerX3f3Mk6jHem3rEUwrkpGYTsW/XKGoF@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFSPb2s9Gv8GG+OQXpfm3kwrWyeIl+dJmAwSpIaMBfQ3keCNc
	W9Nr6PktaHPYxaN95oS9qhlAHd3Y0NY9Avi89/9kdmvldMwt42ap
X-Gm-Gg: ASbGncvd5KzymqEVSQUR73kK7mkGxW54igfmXug0saUF296RQaE2y6KDoLo8ctxkhKt
	Qct0PtgzDkEwpOsAwzbXFpoUMFxcYXa6AW4oS/RaLZZ9WwkrdWowA8iPabBMLP2TN2CJNjoI5jT
	lxgxqWZslkiTP3C0bBLDW1e+R+99cZQEogkTG4QbQMHskrCE1cp1MxdT36pW1gQamuR61D5A/9o
	AvBU7eZxNbJsWSCqk8eVsArZxngifXExi3lnmSKTlaqhNzn3ZTxQOWTTXobjEvg1+uJdozDUW4x
	iGJIHLy8+FV3u3hO4wOmY5WwJvxvtHWhS2rJJqy+CaDQ4GFQj6RSYmMhmPGGJ9kJU6tWUayzc5i
	OeOdOyHTfqRKAAT5Ir6LFcsdVhg==
X-Google-Smtp-Source: AGHT+IFPKwZUivV9o2egwM9HtqA1X+Wqp5ZNIRNxx/29F/9iRwcSuupsGjgksk9DPk6Csl6LQmklyQ==
X-Received: by 2002:a17:907:7216:b0:abf:6951:4bc2 with SMTP id a640c23a62f3a-ac1f0edc6b9mr612346766b.7.1741182985565;
        Wed, 05 Mar 2025 05:56:25 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7663b935sm550196266b.150.2025.03.05.05.56.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:56:25 -0800 (PST)
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
In-Reply-To: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
Date: Wed, 5 Mar 2025 14:56:12 +0100
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
Message-Id: <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
5 mar 2025, o godz. 03:30:
>=20
>>=20
>=20
> I only see the HDMI connector from your dri/state ; so it appears the =
DP driver hasn't been successfully
> initialized=EF=BC=88I think kernel dmesg can tell that=EF=BC=89.=20
> Have you enabled CONFIG_ROCKCHIP_DW_DP ? This is needed.
>=20


Andy,

Do you mean CONFIG_ROCKCHIP_DW_DP or CONFIG_DRM_DW_DP ?

If CONFIG_DRM_DW_DP - then yes - i have it: =
https://github.com/warpme/minimyth2/blob/2e267842b1033bbc4c2c5d80c1756a142=
e347cc5/script/kernel/linux-6.14/files/linux-6.14-arm64-armv8.config#L5024=


Kernel dmesg: https://termbin.com/uiup




