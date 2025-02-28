Return-Path: <linux-kernel+bounces-539110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC99FA4A10A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756C73B46AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF521F09B0;
	Fri, 28 Feb 2025 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DZIk7HQs"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45511C07F3;
	Fri, 28 Feb 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765617; cv=none; b=iRFVwnKCqVo3Xo4zQPQXy6m5RptZ1WZyTEZeG0l3RAei7OQFP+bFPa0GewEcSFXV7h3BrsqUkz3+DwGSvA6dUJXAJttUJyNkKcFscZOLgCRB14lDkrEdVgNCd7GbPdX97emDZEdpe/GMaX0heCx4XPH7bT37uds0wX9zRnmDvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765617; c=relaxed/simple;
	bh=sTnsqvuknnrk7PfyI85T2uYsvkVUA1Bx/ewBwy69kWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGbylTFKra8fqeJ5t4w1iv2SDUWIT2lN6A7iWbliXNTtNmcWq8ejeIp20fkxWcG84Ml0evMEW2+AvVPu0cYBI2TwAxlMFb5Jcw0YQP9GUJx+Lc4oY9FdPUmOFBlr/OF8bsSLFSOK0O1778r/4zTk6g55H9bHskt2bax62Ps3rKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DZIk7HQs; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B39B225CD6;
	Fri, 28 Feb 2025 19:00:12 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNSjyzCdGSLb; Fri, 28 Feb 2025 19:00:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740765606; bh=sTnsqvuknnrk7PfyI85T2uYsvkVUA1Bx/ewBwy69kWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DZIk7HQsgnCdt7LmeYKxxyx0jrWWanw19QAHpdgf6BvsEtGCfLss75KAX5Kbxjfb/
	 Mr7aKa8fBVFX1IZv4ZPSWoalLZXuJk8b6jJOLba5zd0N6959C/yhYGQIiDRy7SoeKd
	 TWoQQGkjPvFawBwsRkU/5IvLO0qpVcUoGNKJM7G1KdqexI/7UK3MXkCxOxOr0L/knb
	 xdYo6piOJedRv08JolbgcJhNxB6fT1iLmo8gMJS3pCq60+JWmJ+YY6F1dZYaIgbNet
	 6/d3FiSnuRVDMLj1GKdl8xjMpoJ92E2rh9sheo2pDnEDVSRk28/53DoyXysap6u1dN
	 QXdx2qnY8B4YA==
Date: Fri, 28 Feb 2025 17:59:42 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Diederik de Haas" <didi.debian@cknow.org>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Heiko Stuebner" <heiko@sntech.de>,
	"Dragan Simic" <dsimic@manjaro.org>,
	"Johan Jonker" <jbx6244@gmail.com>,
	"Wenhao Cui" <lasstp5011@gmail.com>,
	"Yuteng Zhong" <zonyitoo@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove undocumented sdmmc property
 from lubancat-1
Message-ID: <Z8H5jjE24cZb4IBQ@pie.lan>
References: <20250228163117.47318-2-ziyao@disroot.org>
 <D848JET5TDL6.2L4ZQR0YHYQU6@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D848JET5TDL6.2L4ZQR0YHYQU6@cknow.org>

On Fri, Feb 28, 2025 at 05:55:47PM +0100, Diederik de Haas wrote:
> On Fri Feb 28, 2025 at 5:31 PM CET, Yao Zi wrote:
> > Property "supports-cd" isn't documented anywhere and is unnecessary for
> 
> s/supports-cd/supports-sd/ ?

Oops, yes, it's a typo.

As it's a trival patch, could it be fixed on merging? Or should I send
another version?

> Cheers,
>   Diederik

Thanks,
Yao Zi

> > mainline driver to function. It seems a property used by downstream
> > kernel was brought into mainline.
> >
> > This should be reported by dtbs_check, but mmc-controller-common.yaml
> > defaults additionalProperties to true thus allows it. Remove the
> > property to clean the devicetree up and avoid possible confusion.
> >
> > Fixes: 8d94da58de53 ("arm64: dts: rockchip: Add EmbedFire LubanCat 1")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>

