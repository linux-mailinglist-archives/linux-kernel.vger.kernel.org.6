Return-Path: <linux-kernel+bounces-335824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A897EB37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109DC1C215D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19001991AC;
	Mon, 23 Sep 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVxD6uWW"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887D1F93E;
	Mon, 23 Sep 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093006; cv=none; b=MrGY8ypEjRotJxBgJ7ny9naP7nMwobu0/LJTJNnMvhCQTueP51cdpppACfrkjwOTEl4Hv/3wFG9UsYdOgFK4xAgXB4DLcvSYxycGubznW3ApLOPSNg+7nZleaJnCrQcVrDkUsBwWyFfxenpzPzSsbQQe9j9oD87lh4BPJX4sxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093006; c=relaxed/simple;
	bh=D59OiNf9BhG00vuEBLNj/YD7ekAQ+eBV0cuBs/ceEEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4XQsFSOgcSKaaNvJr/Dt979iKso/cRL19BRr5P2OrRXxNuJevQM7c+Pg8gqcMO78NGHXXNn8HAT3wRZDNa4ExEBcZK+fXlNbC1C/P/iFmAkF0uvmkXvsP7oy5B4+A0hzSyDu83k+CzjOPnFRAzXHQ375cSQgzZlNhejQyyVKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVxD6uWW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so44358971fa.1;
        Mon, 23 Sep 2024 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093001; x=1727697801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfE7g7okfFlz3A1braftE8uJHKezq5Xofdkckgw6nkc=;
        b=EVxD6uWW9vAIuZlLpeQCzvI2HHKO0fB+jrkUMy5Qr7FDyeF8nG7n/kVmyyXZW8QjZe
         tDUx9ABYRrbFGklIjmm6nK+tL8rVMVGsWMnmBBakNWqQjxR8/u8QuBzwmqNxCiHiUuVN
         KUFVz+Li7jsX3lOuPcyujISKVx88V5wMjCLu8T2AkhxGOBBqBiNp45bf3kP0fyIwK8uP
         VMoC3A/7f0AlVj5huB1AuQa76E9nQMNsiwsO4YRx+1eH/EY161NjOpVypWDP3O2oTumt
         X3O2t6RdqqGl1t3bvs405IpZzFM8gIxJPtTwfMo7zlwu6GvM+d46Me6x6m4IHHOoPCYW
         QEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093001; x=1727697801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfE7g7okfFlz3A1braftE8uJHKezq5Xofdkckgw6nkc=;
        b=qZeZwbmHSb1QJZHyvGFU+1xEz0nPv+zKh++4125dg0pvP47F8tiRjLkVoJCEJoSRTr
         YF/qqvhJz+zL9qtd41z6BSMWCrxgbLRIObr5KdcaueZCPABb486yzO7T9klkbYspwwcU
         hlCEboVOkz6KM2r4LnQrxYzBv/cGklQvUbHTOLiRvd8txHhxlgLR+9AGwQZFY+KCbLC0
         fyvqWvXABUxYgYgaG0NfOwR8ytjeDXLaZhvQaIvsaZ517wZNI7woT7dDnR2m8CG3SvTZ
         5CbsZITW8I9ADHd3w0OEhM4caOrRPljN4DlbAnlStKQ9yDBKS2NhpFXgZ9gr5MhqB3Dk
         qN1w==
X-Forwarded-Encrypted: i=1; AJvYcCWOrgtKl6WjGTQBYCcw1Alpj/QeD5OvQgNqtFLFtGOD7KGfg1P1Jx6c4piwxALcRiaOlaiVSgVrzhGR@vger.kernel.org, AJvYcCWo4I34QihDZrFD/b9W7aRcII6ghJTWmoyVdWbTWXQJkoTBgZes4jub/bnhWTEOnxyidShJAIyoXXiAoAqF@vger.kernel.org
X-Gm-Message-State: AOJu0YxDe1bu0eAtSJxI7u4tWUvCvgg3M/K3VFcbrOQ0XNGAoqfgLihJ
	WM7St/Q2XTsGkH+BJESpFsQYzBHBQXdw+lNeu4vsLIozHlNies4tLoHhkx+JAV21MOHg42WvFIK
	DlVP7BUrLDzKW01NtTx7ox83zmM7HFA==
X-Google-Smtp-Source: AGHT+IEwu1mOw5vW3/uY5OHfjlqgcJrFDYsoSJK9w0OxsKHFyFcLvqe+moPZFsMuGuqDWneYME8rofTMqT5VmcMNOmU=
X-Received: by 2002:a05:6512:3d86:b0:533:3fc8:9ac0 with SMTP id
 2adb3069b0e04-536ac2f51d9mr5278526e87.34.1727093000284; Mon, 23 Sep 2024
 05:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912124825.2528984-1-lukma@denx.de> <20240912124825.2528984-2-lukma@denx.de>
 <CAOMZO5DJ4=ARZEcq+vbisA4kJBg+WFkH3G8-hYDkL82GQBEPBw@mail.gmail.com> <20240923114711.1c294b6b@wsk>
In-Reply-To: <20240923114711.1c294b6b@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Sep 2024 09:03:08 -0300
Message-ID: <CAOMZO5CqWRqg0YhyNKj0MW807i=kVahSDpVXibp3oDj7D91z4w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Sep 23, 2024 at 6:47=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> This file has the:
>         panel {
>                 compatible =3D "sii,43wvf1g";
>
> Whereas in those devices (i.e. btt3) - I don't know the names of the
> displays - manufacturer buys them according to the timing properties.
>
> Hence the question - how shall I proceed?
>
> IMHO the most straightforward way is to modify fsl,lcdif.yaml to
> not require "port" and "remote-endpoint" and instead add support for
> "display-timings" and "timingX"

Yes, that would be a good solution, thanks.

