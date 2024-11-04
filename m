Return-Path: <linux-kernel+bounces-395110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1245C9BB8AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354571C23E42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A41BD014;
	Mon,  4 Nov 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpmUVtKy"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6B1BDABE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733161; cv=none; b=EQu9UVDxdiIr1e2Udjqj80fvq0YlAR9l7xY7y0ecrVEsc0mE2v6zKX6VCw0CgR9MvNEizPxQv2XuaEQOV5OvsXQQXdQDKcVKlFR6VR4XIjNT0+4/FCrF4T1w1F0IuGy1B6+5FF47vlDoI9yK23rBmXcQTt4yd/yHBF14eCKC2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733161; c=relaxed/simple;
	bh=qkGrV1uyjS9Cqhj5IWzafZBjQzq/m8MRer83C1OFZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZCb+zd0Qg1JaojLUzVP+thcd6Ic/9n+/7+AX0kcZTAWyuveTmhpOAmrzHoglACPjH2A57YpgTCtrL3Fmkmq24Qsf4Fm7kGmzY0oSN0nknjYj/N/x3TVO3drm05l2PjfMvppclXwtFWvLur15lXdIYIAf1utI30PnM1zZ/f+VAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UpmUVtKy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so3826455b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730733159; x=1731337959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JKuo9CTAykduP5fMt3ym5ibpLBBhoEvoUSqeN+sce8=;
        b=UpmUVtKyNKUmfAJKW13lSHgkHtyNOaFbf6h31ac5uLFdRgGuu+OMyIjEWmBlrr1tYZ
         bX18hs9oRwEjueRk043e0MDvW0NmQlOCDQweOebz53rUFf0sxrE66QKLK4T3/EWS1naU
         7JAuJDGSw7LHAO5rTA6RzP4KX8AaNNFb0q4DnoyoFKai4DZohEK8NtkjGL7R3JQpUp0j
         G5CFCWH7UFfChS5pkFqhoisOUYOabztlCDg4BQseMf/4k4evcgj0O+T5rNbHbJYb72r+
         UqTuaEBr3CCe4ARPkA0E3SuASQOiZrNLjr1D1nWR/8ebRI5uHbmPVJpCXMiNpFtbOHCv
         0Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733159; x=1731337959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JKuo9CTAykduP5fMt3ym5ibpLBBhoEvoUSqeN+sce8=;
        b=YQFpDjZhKOuPB/2S1qD7f/e6yXjVWzdmFyHOBAifvFPZADBIdGv8pj1AxwjVx+Zp0L
         zWe8cgqFP4nrGGcm9bSWRaLGO7vfyqG4BjPHN6E139Q3TKyzlLUujMOhlvjckxY1n25+
         ujcGS8Zk9XjJAMXOpIxOiYyEP00ylF6qdJVQidJJ5jW+8geIDhiaVmRm0ecA5KlFGv1F
         NEeu5QKKU8uo5PfazezGqcENUY+lZM4IgGhjEEqtDEVSPnubNGxnpcUhi/LdfsqTacXQ
         DtfAENO0bG8JdO5aCrKJ/z24IJE0x5kqBwoKgxhSEPnKMjz8RNKxzmnPag8fYFEned43
         2vMw==
X-Forwarded-Encrypted: i=1; AJvYcCU+mpYuW+CcPAtr3Da7dfnlvENXg0t+rOqPb99LpIaKmFnE3m3Su648jXBHB1+uEE9qnVaUOuw2j4GiPBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7RYw0KyObvJEdBlOjKAvX+PmL+Fgm0vTHae7UdRmshpJwGLtW
	wHxaV5Mt41+XJv8+tpK76FK+JWXDR2ru+oDVLqBlNAQWrjmlIYEtYIsqsfkIOw==
X-Google-Smtp-Source: AGHT+IEGoyeuH2l+G925Avh2F986QTf6nNmEZxSYqlhaBxmXN61/88Q3SSZ9ynilZvc+TeUuYfyKeQ==
X-Received: by 2002:a05:6a20:7f81:b0:1db:dfc8:9d8f with SMTP id adf61e73a8af0-1dbdfc89d96mr3916387637.44.1730733158828;
        Mon, 04 Nov 2024 07:12:38 -0800 (PST)
Received: from thinkpad ([2409:40f4:3049:1cc7:217b:63a:40ce:2e01])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452991f0sm7076953a12.13.2024.11.04.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:12:38 -0800 (PST)
Date: Mon, 4 Nov 2024 20:42:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Stefan Eichenberger <eichest@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241104151230.bxsdu4fcf6fssx4e@thinkpad>
References: <20241030103250.83640-1-eichest@gmail.com>
 <20241101193412.GA1317741@bhelgaas>
 <20241102120403.GF2260768@rocinante>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102120403.GF2260768@rocinante>

On Sat, Nov 02, 2024 at 09:04:03PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > Without this patch, suspend/resume will fail on i.MX6QDL devices if a
> > > PCIe device is connected. Upon resuming, the kernel will hang and
> > > display an error. Here's an example of the error encountered with the
> > > ath10k driver:
> > > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> > [...]
> > 
> > Richard and Lucas, does this look OK to you?  Since you're listed as
> > maintainers of pci-imx6.c, I'd like to have your ack before merging
> > this.
> 
> If things look fine here, then I would like to pick it up.
> 

LGTM, feel free to pick it up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

