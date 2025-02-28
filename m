Return-Path: <linux-kernel+bounces-539442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D657DA4A44A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D3A188F9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313A1AF0C0;
	Fri, 28 Feb 2025 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6qJbMN0"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61223F396;
	Fri, 28 Feb 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774650; cv=none; b=UlIfwvPy4OOJrJvzJnMWn2S5pvAPEXuzBY6nbpACndtejRxV/181ggRmlEoNaGiHqRFH9hTGxYkIutKJJyuc+G9KdDGFEVhvzYCDHqLhGqYLyCtl5M1G6CLN5hfZYc9e+a4VG0rZi9s02d+d18EVYVV0f17QL53SLZQ2EVDYKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774650; c=relaxed/simple;
	bh=kXgIwUFfcnXRTfKL18xxHQyr5xsRYovfLqKmpOqaIBU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uaZwkzGd2qbPrvZkPOy7hn0yNzbtTm+hQOb4XQPnQAkJMl0/2AVunTsVXbZpJTSnqm7bbpytWMjyzW18ngFMrkkaGyJOti7cI2uKGPrf/L766JSBWGsTRBNGxrh6sAdSCHJYk4yXgjPUXnXXG7FTCts3umfCGELry1Qm+4Xs030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6qJbMN0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so3752256a12.0;
        Fri, 28 Feb 2025 12:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740774647; x=1741379447; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXgIwUFfcnXRTfKL18xxHQyr5xsRYovfLqKmpOqaIBU=;
        b=Z6qJbMN0JUbdkC4hRcegbP5c5uJm7A0pYP4/9gMG6bLGpmAcSkgqAo8uLh8oP8T/jt
         MK/ryjQz9DsJjsn2MDlMPId+OHNGWEKZqabq21OKtWiBKdLbWMR2RU8TX8p/QeVyb2rK
         QxsO/JmGOOIAliv7pVfiCFMh+RLldgeP7r0R9vlFIJfJl3Q0Nf5GkEalZD2FOF6MLwAg
         gKVU9G40lxc/hgT4TuK+XZG7/E/e3MKv+O8llp9T1zplpdSxCmraR+CHsIT4OFiz0POp
         B/wbbQJo7qrRWiDVA8OuXbpus+59Rjn9cc0iQAwCLj6n0hUNuW4s4zzI7hyI1QiBeP9i
         F0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740774647; x=1741379447;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXgIwUFfcnXRTfKL18xxHQyr5xsRYovfLqKmpOqaIBU=;
        b=Eo1ojlow0q6Tk5cx1qpk+nZTcrtpm9riTBQGxLh4plm3o56AKY82ucbIt6dYyt9nxs
         gZi+pTdjbwmkVd9APbd2/S4W+qpeBn56tZKtIX5/ImVU9bC3a0fezSasPn9lTuWHSely
         /mhHTX9ptR3b7UGjwfaiotiZjfS+b43Uk8IZiZ4T9RcRzzuzKs4o4D/Wb5FvBR7k28P8
         S1cQrIh6IO5P2Ucy2C852RN6g52538J+zzPwD8ofHfrW+jl0NfUn9Dh4dsRE+6wid6g/
         NCY/JeaIisXoWycIyA4O+y6/C+8agIyRkmPX8U7GxtnFMNiV68AGFHr3z6QHJEd2t3C5
         STwA==
X-Forwarded-Encrypted: i=1; AJvYcCWoB9zHtqSPutTRCUV1aFtC90fQw0pkdzvOKYC/mYaceOPE8r61Q4WDv9jqiE+felwH+Y/6VBvc9pkrk5G9@vger.kernel.org, AJvYcCXx6CnQfsGRFROr8P2Q8DXVLwY/GpGIWiYhRdI1j++2iFwRT9/AYtz5VAdHO5V995gr+E1u25I6PDUv@vger.kernel.org
X-Gm-Message-State: AOJu0YxgM1Bz28KVokIQjn+UzxFMqOV79B96sSwCD1ZHfclDTg8pNfNb
	ISWkVzDz0Uvubuq9F7EvFnTdZwcn/Bz3xylnHgi+zcQszh/v03bS
X-Gm-Gg: ASbGncvH56RD2UMG6SBLrlND8AEMdtGxLz9jC7Ad+/NKlzctnEj9uaImnSS+IaKoPDW
	JJB+ZYdoFfllP2+QU+Npat/OgGFSxu3bo2E/tkMFMUKmM9Usu0LdQn+4IyZbZdTw8FSW1E0iPJq
	wdVzOPWw3KlCczzPEhtJVxH6hEmLSd1NxxImXK3EZd8nUGtrTk9lusLsbxteFx2THzh8fCuGZHF
	m3kaA4GwKvfxKdvuqfzp+ZBpawFkJN0DM5InrX2G6zng4M1zjZZdncdOwCq49/6qgkg17EMGUIj
	1RyE1mIP4sTReRbNr47X0/acjdVbg2nQwXi1w7GN6BulbDawuTTZsJrDtgnvHHOpXAIxxMsYoG6
	8E2zAQQ8=
X-Google-Smtp-Source: AGHT+IG2W1DgzC5HFOlMxfquiHOJsjopf4V1IKQfO3ADcRZT8QfnlN9j9L7rrPBIsVSyavnVTfhblA==
X-Received: by 2002:a17:907:9716:b0:abe:e1b3:78d with SMTP id a640c23a62f3a-abf261fba01mr544156566b.8.1740774646893;
        Fri, 28 Feb 2025 12:30:46 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf508f2288sm890766b.2.2025.02.28.12.30.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2025 12:30:46 -0800 (PST)
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
In-Reply-To: <20250223113036.74252-1-andyshrk@163.com>
Date: Fri, 28 Feb 2025 21:30:33 +0100
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
Message-Id: <AC3DE87B-64B1-4C34-8E1B-3900E2C53AA3@gmail.com>
References: <20250223113036.74252-1-andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
23 lut 2025, o godz. 12:30:
>=20
> From: Andy Yan <andy.yan@rock-chips.com>
>=20
>=20
> There are two DW DPTX based DisplayPort Controller on rk3588 which
> are compliant with the DisplayPort Specification Version 1.4 with
> the following features:
>=20
> * DisplayPort 1.4a
> * Main Link: 1/2/4 lanes
> * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> * AUX channel 1Mbps
> * Single Stream Transport(SST)
> * Multistream Transport (MST)
> *=EF=81=AEType-C support (alternate mode)
> * HDCP 2.2, HDCP 1.3
> * Supports up to 8/10 bits per color component
> * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> * Pixel clock up to 594MHz
> * I2S, SPDIF audio interface
>=20
> The current version of this patch series only supports basic display =
outputs.
> I conducted tests in 1080p and 4K@60 YCbCr4:2:0 modes; the ALT/Type-C =
mode
> hasn't been tested yet, but I suspect it will likely work. HDCP and =
audio
> features remain unimplemented. For RK3588, it's only support SST, =
while in
> the upcoming RK3576, it can support MST output.
>=20

Andy,

Is tis series enough to get usbc1/dp1 working as video output ?
(assuming i will add necessary code in dt)=20

rock5-itx has second hdmi port using usbc1/dp1 lanes 2,3 to ra620 =
dp->hdmi converter

is it worth to play with this or it is too early?
=20

