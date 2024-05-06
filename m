Return-Path: <linux-kernel+bounces-169361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F48BC797
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA9E281081
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830E4CB58;
	Mon,  6 May 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gj4XwNQE"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D014CB4B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976994; cv=none; b=N+/UCsMCCN1XP/ux66N8c0tSuHrQl6x7emplprsNqyI6eryWyEjfKol1jrxK6A930P4pfbx1KaU/IW/kO5Rvtv9SUVNFqtwC24kCiTG/lqgY3esSD5eZDjveYltaiqe5iQaa4eRcXF+m9bOoDaAtVTBrV5O55OIL2HSCzu9isak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976994; c=relaxed/simple;
	bh=w0Dlte53WJRCIvtxzCyGs12oGYGUL4gGyOsmoReVfEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAG+9OStVQeoHtF8dID2Kdb50GVybTE/f43pp1sJsvHEkOS+Ajkup1q7pMc6wLa/eBtK7Tsek/4qBTRUwjbn9DtH3aoCeb2IPJywcPs/c9ZEXxENZtyXQDLGZUpriNQeOJx7zyGWFQ+zyir3yoOqkV7+udv7375cXo2shvoYXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gj4XwNQE; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1398772276.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714976992; x=1715581792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxr7JrisHMydcKRiJtSDqGEYBkrpK+VSNsF4Ji3kjUo=;
        b=Gj4XwNQE+QYONCCwTUHsfCVmvRlRc8wCHf/IVUkPeYEe47zhnQMfBNUQ7+0uua9D2d
         3ZqF67V5ChvmMV6EbG1lUZ5ICRAUXmAi+W3e//GOrie8OljUtqTX8PI480mPxtcjzkLE
         qeI2UKjFwkJBu88pVrq8x7KHYN04EW7GYOFADFlO2nz+ktqyCe1Duq1ll2zkWmDiIMvh
         g7+FJYSuGV8orw0Vzufea++AGgGDi3bDyUa96HwSxzEuX5xC39/3rSKy8JylIon/SYh3
         VZjH/ytGgjPIX5N7XHW6Ol7qYymH/XGVGNmVaH+D1fHXoAvtGPeSZBeR5e+p2pE1fPaj
         F4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714976992; x=1715581792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxr7JrisHMydcKRiJtSDqGEYBkrpK+VSNsF4Ji3kjUo=;
        b=gdU1MNAKgSVfdi/qJTib/eZhXdfYMxTSPRyZMTyN/vlsZAfg4Y69QfIf1/hPefxTTX
         DLaPQawPd6khWu7VZTjZPHyynOqXwbbeQyhn+vsuZLzBRX9EbgBmj4bMI8Euh7F27Y0L
         UcIwQSSSSOLdZWHBW86/xryEQt2+WZ7J5mLufza9rxTkJQzRb0wMJmIYHQ1rxKeJG6kr
         xC7cJ5ThOLsOglxQ+crnNZdKDEvOxU1JfE/7G3dTA9WqocLz9kzNFAiCEPYUlpizvDGR
         TMUpLAp2XEd8ZL/YLc/zGnazxs0grf4/qsqV7emTkgeKqpWHCenb8AkPkLwFB/d46CYG
         pXNw==
X-Forwarded-Encrypted: i=1; AJvYcCWQCEm82Vv+3+BY8CL5c7/z5kO66CMqC0o3Z/r7yacPawiI6MuzQR2qry6yGdyJlVsOMBYxwQSHWMuZwkywcwk8D7VPNZ12jejunCKI
X-Gm-Message-State: AOJu0Yxfl9Ug3fumgpNhaY0GATw4Sh9bQb/juPgfo+JUFbXv+wfqK29u
	qW1G+TJvo6NJBDEy4fmAWZZFD+THhz0myeQhiDRIFqrM4OcpPIoobbOWYmsrO4NuURNGDab4TiE
	NHV/29V06OybINNxBLwwTO6uHPAapAhgTs69ukQ==
X-Google-Smtp-Source: AGHT+IEW+Hz8JBmVo7SC235dDlRuUcsYwIn39CM402hXKIdN+c6eBtHohjS4CULU0pQZO6QvmBfh/4rgh2WLtQ/eV1U=
X-Received: by 2002:a25:2fc2:0:b0:de4:673f:da17 with SMTP id
 v185-20020a252fc2000000b00de4673fda17mr8576741ybv.22.1714976991283; Sun, 05
 May 2024 23:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-4-johan+linaro@kernel.org> <CACRpkdYXfZwBdLSTTPbruD9qynOPuQBOZjCwA_6eE+1MUBCkgA@mail.gmail.com>
 <ZjSksM07OlgpE3yO@hovoldconsulting.com>
In-Reply-To: <ZjSksM07OlgpE3yO@hovoldconsulting.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:29:40 +0200
Message-ID: <CACRpkdYZWixc1E3=Y2j0etuDS7vNY3QcqK2Qiac_KPorr7s0Ug@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: HID: i2c-hid: elan: add
 'no-reset-on-power-off' property
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 10:47=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:

> > If the above holds true, the driver can then just check for the open dr=
ain flag
> > in the reset-gpios phandle, and if that is set, conclude that it should=
 not
> > actively drive the line low in the poweroff state.
>
> That is an alternative I considered but rejected as just knowing that
> the gpio is open-drain is not necessarily sufficient, for example, if
> the reset line is pulled to always-on rail while power to the device can
> be cut.
>
> Perhaps no one would ever construct hardware like that, but it does not
> seem like the hardware property I'm trying to encode necessarily follows
> from having an open-drain reset line.
>
> And then the OS should probably not make assumptions like that either,
> especially since getting it wrong can potentially lead to damaged
> hardware.

OK it's a fair point.

I was worried about over-specification of behaviour, as that always
leads to contradictions.

+  no-reset-on-power-off:
+    type: boolean
+    description:
+      Reset line is wired so that it can be left deasserted when the power
+      supply is off.

To be nitpicky: *should* be left deasserted rather than *can* be left
deasserted, right? If the behaviour is desirable but not strictly
required.

Yours,
Linus Walleij

