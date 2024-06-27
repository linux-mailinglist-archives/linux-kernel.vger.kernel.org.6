Return-Path: <linux-kernel+bounces-232738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D9291ADCF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D06F1F233D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD519A296;
	Thu, 27 Jun 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqguWVlD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13297433B3;
	Thu, 27 Jun 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508678; cv=none; b=gLxCNOPfq46+OK1L2Er6j4PffUDAzJqa9D3l4M7qQfhAE+mdWAKY2BFM6UPLaWVd5UKzPGCYAkhuk1ksGIBJz543DpobQ0B7Fg2oyzckIZPqaiFzoAdNFWSmKMaw7DEq33SFwAF8kAuIZnnvr/yXrZYRT+vtrCMT6IHAAbJPjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508678; c=relaxed/simple;
	bh=ND+kxnj03hKFg+c77/LHGw3ycswbF4qk9fiMKZV+Z4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMObLxEx9Xz/7FTQWj5TjowMK/fMKsKe7yaTj8tKtnuaHiUVkMG4npCJu3Wui8YALlqDvlCe7J50Q+dhO6Ydgs+W5TufTYhgCpQwqd7LBq741ZoHaWyOza5KymSy3YDKmKD3FTqWmtlLiS7qihfU/euBTf6tnFNtal1CnNJvaig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqguWVlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B169EC4AF0A;
	Thu, 27 Jun 2024 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508677;
	bh=ND+kxnj03hKFg+c77/LHGw3ycswbF4qk9fiMKZV+Z4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YqguWVlDtOzpjNpDhA49SzxWALisxIhQeiH5+aTOs7dYzj021HpDd8mGPRmg/ir9R
	 4FtFIrGGoXePtNB8BIZMr7F/s28ejQEevjSTaG0AghDu8XLO/714NcEs+lh6hmLIZh
	 gTKuPNBeCJcgLL5U/E6Ifk9RKtn/25PZdL5LbQYicTQD9ypGiSy7fh+6h2fom+DZm0
	 Vjv7NFFg0ZX9BG2+aOnunpBcix0eVHRmNeTyRZAxKM1DcBCqc2vsdDxgImkOKPDuWy
	 MZclf43+7Ge7mjUC4Pqmons2g8S8YVm0DEX5ATTzSE29Ue+5cO5yCBbGGpx0iVnU8c
	 LtUfJn78T1nfg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdb9526e2so1918063e87.0;
        Thu, 27 Jun 2024 10:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc1c1bmYilNbPnglI6l80DiYMTRo1A9sGNRSMFDrfazxbYmN+H29WCp1fwBZLC8/ymsVBmSg9Jnkz3DlAmbSVmr8rzRJNAaIGKum5YCVCURjdvCfjZCwrFjJR8nkqG2wari7O547LD4w==
X-Gm-Message-State: AOJu0YzV9NQPx9pBw+grLMosvInOVbuela4DpJxz/8JvcRPnDAqVwo+d
	7hYb4vf8DBqelvDLTvwzX4OdsNlcGF0xv7dzolE+C1MoluxsMUqcrzB0oNrIKgdNPT65GCVYva1
	H9G1fBHr/x/Pv6Ei5m0TH4hI9jQ==
X-Google-Smtp-Source: AGHT+IF3OE5lw0/7L/P34B6XjIm/Q/MdeaYkB0SxYii0IOeonTKc+sIEbiWY8aflzadLR2ehqIJmgbysOpo4ylgcOcs=
X-Received: by 2002:a05:6512:2314:b0:52b:9223:be33 with SMTP id
 2adb3069b0e04-52e7038b63bmr787238e87.16.1719508676080; Thu, 27 Jun 2024
 10:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626202533.2182846-1-Frank.Li@nxp.com> <20240626202533.2182846-8-Frank.Li@nxp.com>
In-Reply-To: <20240626202533.2182846-8-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 27 Jun 2024 11:17:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJDOgGWqggWXE-_jv6oQW9nekxU-4Fui+2JFZ6DWUqLtg@mail.gmail.com>
Message-ID: <CAL_JsqJDOgGWqggWXE-_jv6oQW9nekxU-4Fui+2JFZ6DWUqLtg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] arm64: dts: layerscaple: add #dma-cells for qdma
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:26=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add #dma-cells for qdma to fix below warning.
>         dma-controller@8380000: '#dma-cells' is a required property
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
>  3 files changed, 3 insertions(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

