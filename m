Return-Path: <linux-kernel+bounces-362055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9199B064
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81071F22943
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E184DF5;
	Sat, 12 Oct 2024 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IloCHsnA"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315891773A;
	Sat, 12 Oct 2024 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702903; cv=none; b=OyZUKuHdlxMfV2+nKGweNtzowEenQaphCwFH35yvynLPZr9hDlYOGMC3FDcAIaFNZoiM3i5i6Tk1tFP2v11atQY7K5oGeLOd3ZVfeH9Ovj3wsX0YBEzfs4ixf7UkIWVu10l6Z6AGg4HsPAoTrGekrm1QbMN++4eF11dtFrUltIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702903; c=relaxed/simple;
	bh=OTDgu8jhVl1DFdHGtT4yhTF5TaSSF0DlH9QNL+bb4dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKX0dozEphiZE2SSXQY599sadg3nojcJcJb0ifZCUREJLk6Z21J9Ucje6tYkCb4qC2L34WXM8gcYMa3TuziJmL+x0Y1eiceS95K0bnY5DiOuvlaZTE4R9O3bhSgbO+uC+LSUhc1c/4sYizA58/dcoRUOBfo4ZTB6DzvG1oJoUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IloCHsnA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398996acbeso3041141e87.1;
        Fri, 11 Oct 2024 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728702900; x=1729307700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxL9nvKGuwRSk+ewXCIf1iRkcw07YPNnh2XwkpZ6saA=;
        b=IloCHsnANFWOBRFclVBj65MBdOBBK0sHCIHEMltB4TL+EBvY+T+JHzfTfqFrLQEEee
         YEJxWKDV302/905w95Jv8B28SkK9pJWUA9F7reU40U0GVbDBy20Z3Pa3wUY7GSURZ9j0
         1SQt+lI5DbkNMvO6iY5T3uOha3dHYsCqBkNb0ldI10hPjTgFKYdgmDtCmXjOCjdvh9Rk
         qL5t4r4Yw3IqsLMw1BGx8zPH5r60KQLdOvIyM81CB7M5CsX3+63dInNtG2Ilx7jem7si
         JMj/b0OrWhMBfO4DD7Oc8Y/MfkRag972/8iCZOAkl2RX0R53z5bK+Cd6UarN+kLO8Gl9
         TYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728702900; x=1729307700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxL9nvKGuwRSk+ewXCIf1iRkcw07YPNnh2XwkpZ6saA=;
        b=sWXw+d+FBaY1hiW/cVrD8lSbW3ca2xJfPwyaETNViApe4Wq/7TLmm0ceA5XmPYlzP3
         uIEbnYK2WOe2EEiIc7SQutxv+bQj3tLrCOeuK6gMu+O329z20UVi6Rkj9/mX3Ftk/lFK
         3MeT5hc1fNscD9Tsb75EQ2WXE74xk+TKfqCdYEZ6WDGh1A1P2NiqtKcaHhcDEQgsGeZa
         4ZWdweF7xyPh3uTjWjIORORO8loSVl+Qm2MbD28hqAHy+v33s8qVZxBzLRsYQWsFo6MK
         SiUh2J2gwwr/6FRViu5ZfapDpFX8hgb2GSpdKQSiM/XDFx65SnwyWAkJxbqWL8dDikgd
         HQdw==
X-Forwarded-Encrypted: i=1; AJvYcCWg2pDm7Z7oH3ugiqUtISONxv+Yb6DJ9yadQPQZh9eRwvQ5lvnr1I2rBcl4laQp+oN7POt+j3quuBOOTCkG@vger.kernel.org, AJvYcCWgQccCUJUHfrEsAYMJzDW2O2LvgqM80aqRwmq1FzpIl+unhYfi/HsYMO+kblpp0oa5G5mWB3OmCUBd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6UbxL8QyFLG4reoS3bx0arnrsjLIpaOViZRbeLQmuIh6Ge4T
	1SPu+JPlzaqihXilsbRUIpP2uinlc1BPg10e+tKTimqmJ9egGQQBw5PQt4utgDQUmdiLPIJsidp
	pglnZHPK7+dEFWDGuvD8dQbfdCEA=
X-Google-Smtp-Source: AGHT+IEvRnxuDVwrSJxR02cOsGUYh33KaNUsbLik74VahkvohMz1+I0s509Yr79jtgYy+sbIRXHpuW1sL4xfx4ecVx4=
X-Received: by 2002:a05:6512:2398:b0:539:e7f8:7bf1 with SMTP id
 2adb3069b0e04-539e7f87d5amr61469e87.2.1728702900040; Fri, 11 Oct 2024
 20:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012025221.1728438-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241012025221.1728438-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 12 Oct 2024 00:14:48 -0300
Message-ID: <CAOMZO5AB+onb-zc6oW-N=TTkJa=tNMXEekXGvwBFTNdAqabM+g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: correct sdhc ipg clk
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:43=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> -                               clocks =3D <&clk IMX8MP_CLK_DUMMY>,
> +                               clocks =3D <&clk IMX8MP_CLK_IPG_ROOT>,

This looks good and aligns with the imx8mm/mn/mq dtsi files:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

