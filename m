Return-Path: <linux-kernel+bounces-548464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8426A54532
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF73A7909
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF1207E13;
	Thu,  6 Mar 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfWAor/D"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91601207A23;
	Thu,  6 Mar 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250537; cv=none; b=IvqMmnSLh3DzZtby2PUbsMx+RE0440FcCRz8eb1PzHQ1Y9MScmn2CqoHvj5JpdviAiPakqNe+YaQeOgPQInbLU5plkNyzTCDEwkeVNiBxT+0lYXo5gQRoMvAYpK3VPK5hAfy0JOQ56zcB+gtgHFucLanNVzFRslwdOnVS+VkmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250537; c=relaxed/simple;
	bh=WE8HEXPDHlP3/Ze6vBhaSEBaCZ2xj3Huz/M2ft6sExY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Gkp5wvvdymjnRZdTsN5fEbIROJzup/nP5EW6uBw5QN4MzZMii0eix6ORUPUan24pzjfZuW2ZgTJnuos4HN6WRL8UgT2YtsQWcc7bkEifaB2bjY0NZDATmI2sN1OGRFqeA79u1Y6Lx4uCbxic+2P5/59QUFyOv1rWOcoMaf4eC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfWAor/D; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4f5cc3172so554024a12.0;
        Thu, 06 Mar 2025 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741250534; x=1741855334; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE8HEXPDHlP3/Ze6vBhaSEBaCZ2xj3Huz/M2ft6sExY=;
        b=jfWAor/DYnp++Rvcef+MpDhPFKXsxoaHt+rbME3LNGyFtQyzxPFX+0/4lewisMF8Oj
         7LZBj32Hayhyr+P95FOcvdO8Lpaku6+MU3IPh5r3TqxuSoYl1DdkHaHrS4OsuqEq5fTG
         /cYUUA7bHvkRAUTDLovRoOLMPJSrgBoJLhA2A3HT+Q2deeSMF6RW28gM6vDCv6Bud5Zf
         vAP6e+tCtUA47iiFPWsnmCMSYNWGWjSAscKPoxdDdFjPAsdCSnC5I0GHMdUdT0ZGj/8b
         AHu6dnwNGiA9TjwPc+cQHNZc4dYDuHb18ULlR12GgDaAzuUg/d3lt8RsQFRg5512aHs8
         yF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741250534; x=1741855334;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE8HEXPDHlP3/Ze6vBhaSEBaCZ2xj3Huz/M2ft6sExY=;
        b=X9X/gu8SW46oZREmcOkbGXL8iWMxYt3MICA4ur8O2bEUP01yBQx2ytTAqML7ig7CQ1
         r/xUdNggTWRAqXAs3MozTJ6JPYZsF3/SrHkQPcoAeOH+vLodCO8VggU2o6qUN0AXRkCq
         AymRlnyqvekmCYVCWLvbbA1FYYf69MUo2jG/MIeRab/CSxcbHgf7CxYF89Ux+NCtEX7X
         XsVIpVDRvoD4HZ1/mbk2xltAb9BEmPuiWsMu5mcZp97KUAbvIRb9z6Ftxi9oKpQIYBVY
         bgQ/CqDA5HCen6ktKmno+/BPMQAzouELF39Orw3gleYXD3LDjQdtG0XYsZT3Ik/03aC6
         UgOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdqkaUGxu4cj6E1zUiGEcuhZDW4QprkjCInRaxDB7CMUstz9r8slbIfbK86ro+YwHMmuTNbm+WQEYF@vger.kernel.org, AJvYcCXkmlFbYBDzoc7jJ9zO8JBdv5bO8E5HN6kxH23B9uVHJbh2qInmlz3KP3pE76+I4E15wLIpl9Jly7QcrPjD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyia0WynAYplZn3E3j0Z2h5GBZAlGmr4LEYycmR7OeCFd+Z1Y31
	ItazQrxAZQUvmRUf7RoAsxtd74MivVal5Ie/PtceDg/WBnq0uexIFV3glw==
X-Gm-Gg: ASbGnctcs9icsWZEz4c+wRkP9YWivVk/BA1VFyF9pqQGf11p5KsHIA8UxsF/QRc7RhY
	evvD814ygJHIGoouG7cyLpw7A5CYcEhqTYrUQoLCIz6Y2/5ypPb3jciauAqxwIRZR+GtZsYISuq
	8dVyk70K1EdpcqtvGmjpB7QGyE7M4hzJ81al3xsxo9LGgFps3HVmEITCm3I/MwXt8gOAKYqxpm/
	l9sil71b6kui507OmCeogeOgbHgsOMngVwb/k1sZ+mxHPxOx+Cgp2T9ZQRWJu6kbZhUcVKEvMZh
	JwJyv6l/dvwkwLt7F//AMNlXxg3GLmldqX1kYCooUayHA+3HeFPx8MWHLVTky5C6SgokHYDJcfs
	AqiPfjMGF6IInTmxiqADf+cWNfg==
X-Google-Smtp-Source: AGHT+IH7rJ0bI5uRIzIqrHdOqVbIP+Y1Jj/C4uRWsNFMJDfrRYE/cGnXxp+rRBuh8BWvmklTgurn9A==
X-Received: by 2002:a05:6402:2157:b0:5e5:b9b1:8117 with SMTP id 4fb4d7f45d1cf-5e5b9b18547mr3313222a12.18.1741250533408;
        Thu, 06 Mar 2025 00:42:13 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a5f7sm587786a12.58.2025.03.06.00.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2025 00:42:13 -0800 (PST)
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
In-Reply-To: <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
Date: Thu, 6 Mar 2025 09:42:00 +0100
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
Message-Id: <44213B17-FE14-4FB8-8319-1E31BBF6EAA0@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
 <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
 <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
6 mar 2025, o godz. 01:59:
>=20
>=20
>=20
>=20
> Both of the two config options should be enabled.
> andy@Pro480:~/WorkSpace/linux-next$ rg DW_DP .config
> 4044:CONFIG_ROCKCHIP_DW_DP=3Dy

here i=E2=80=99m a bit lost=E2=80=A6.
greping on full kernel sources (with applied =
https://patchwork.kernel.org/project/linux-rockchip/list/?series=3D936784)=
 gives me no single appearance of ROCKCHIP_DW_DP=E2=80=A6
Do i miss something?



