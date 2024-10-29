Return-Path: <linux-kernel+bounces-386410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3A9B431B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8D2283874
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970E202630;
	Tue, 29 Oct 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="mMdmV75C"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03E1D7994;
	Tue, 29 Oct 2024 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186891; cv=none; b=VcHg5j+vGPK8atE1qHVHsDuz5Gtq/NNJpcdptS/XrEn0JHNjlVlwwx/GKC4jHhl7uRF9N2nIW/kpxc9z9FpaH5KdtLwPF365Tl40XSmDaNFSekp6TrcLYIEcPjbkH+eezNcXFf+UoSu4GSiDa9cJ2sAOQ2hBfsDCxnbYYIHbYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186891; c=relaxed/simple;
	bh=Yzxop2L77+KWklUFpNEehjWzOsFs0+Hmq86r7axLw+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2YYVd3mgDbHaM+TwxeJiLXeDeW2K2RmOxCGwp68q8i6wKmOHcLYwU8alT1+LD77ZACEy8NhEB+NgGN/9opiBasz8nimuJaiwBcuqq7aKobF31VAS5GO+aSYkpMHfI+W0UxgNIHcWOUYjILKVrh9hlevEDENyzs6iM6zwSdGuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=mMdmV75C; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 103DF1F994;
	Tue, 29 Oct 2024 08:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1730186887;
	bh=mA5XxeKvU7TmfDLIa3NriSYNjVYlBgpHYfJmSINY+qI=;
	h=Received:From:To:Subject;
	b=mMdmV75C8XCAC+MpB5S34JYy2/oky1g5p9DE0svE3FKLHq32iqQR+qGgD8+5SQPCh
	 LWFmryUxxx1C95sfIzEMu8EKosPvhuJCiEMKwrT1Dz6yGN5sI6M2TI3EieyEPHUJbf
	 DXWKRINsGcjJuVWrDoBQHk/GELYqFkimUVAb6/S3Pgx+mLVwe8YMke96esC0VplxGB
	 kw9TjhcZwCC0MmIbf7rYu2rqyFU69seEhzgCxGpVB6FjuXXt8t4XP5HfGFRY1sJWAv
	 L8QbhqJG2c9sLxLyOl6RtIDifWgYq1GMp30ejkLd4g3zrXwxXSMg9vfgrerzUoUgeK
	 maUGQo3PXWwmA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 697597F95F; Tue, 29 Oct 2024 08:28:06 +0100 (CET)
Date: Tue, 29 Oct 2024 08:28:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <ZyCOhkM4PXTLiFRm@gaggiata.pivistrello.it>
References: <20241028105413.146510-1-francesco@dolcini.it>
 <20241028105413.146510-2-francesco@dolcini.it>
 <j3a76pyolo66bcqemeo4o3gwzfnftcfjc6grg3v33u7ipztwiq@donxxbveypjk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j3a76pyolo66bcqemeo4o3gwzfnftcfjc6grg3v33u7ipztwiq@donxxbveypjk>

Hello Krzysztof,

On Tue, Oct 29, 2024 at 08:08:09AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Oct 28, 2024 at 11:54:12AM +0100, Francesco Dolcini wrote:
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> > 
> > Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> > host controller. The controller supports software configuration
> > through PCIe registers, such as controlling the PWRONx polarity
> > via the USB control register (E0h).
> > 
> > Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

...

> > +  ti,tusb7320-pwron-active-high:
> 
> Drop tusb7320. There is never device name in property name, because it
> is redundant and makes it completely not-reusable.

Whoops :/

Rob already wrote this in the previous version and I forgot about it.

Thanks!


