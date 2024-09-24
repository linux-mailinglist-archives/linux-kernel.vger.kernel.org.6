Return-Path: <linux-kernel+bounces-337697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6178984DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581E41F241E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF7155A34;
	Tue, 24 Sep 2024 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3Ic/izS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC339155733;
	Tue, 24 Sep 2024 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216939; cv=none; b=DFINKHDDF5gQ3n4pakyiH2E8TP+Yn0nQK6k0yRPZbgsim+GSBHxI6pIZQ+JwIm1QwnSLuHHsZmv/RTQf6DThIPrM5PQTu7knyVLSV8NTouK/l/vroMXZHhwNnWBWBjQPgthuCKiLQKZqWDBUb8kGWXRHdcZtDfUVK4nw+ldTjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216939; c=relaxed/simple;
	bh=csW1xRX/CF25lbQVuhHQ4dXWOUVuHFooioDDiVh4nGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A121osuwHX5iOb+am//fitj9mSNnKNM+4Lb+KIzkK6FWLD/EnrJHfVByHTyO8kYh3klxa3imrIC3ERLI+NBX2Q594ks0Wo0RZbGQPvYbQdMY+eRVESeZVao3DF8mWg7KTXwyHAYU+kH27GDr8kYCdumv5c8AngntziPFwFpHOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3Ic/izS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D942C4CEC4;
	Tue, 24 Sep 2024 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727216938;
	bh=csW1xRX/CF25lbQVuhHQ4dXWOUVuHFooioDDiVh4nGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3Ic/izSQekLXk6i3LULFQ/fofpaFW4njkZPnfgTKvOiFAGUXWacxJMtiXZzuTl9u
	 j9gAUiXS2kjjYYuUcsRKdM2sfoYNYlUMCoevA+aAQnfkzfFkEaCbWDRcejmXrkF1C4
	 X7nh4BoJ73nBKkiWg/TjPmbHgSxFUH417ipdzUvOlHN795g9kouFogrXG1QoxlVIp4
	 2oC4jseVEq5YaZ8m15E+2Ek7HVMZuGqduiwt/CmeKQNeMlQtQ6Ej3C5YHgz9X1NBy1
	 Yu2TURioKwqoZGSIR8JiziJ3Igu+akPbP7ViHnZxZkhVhE37q0deNk88VgQel1HGYd
	 pLEfIrhuGfDqw==
Date: Tue, 24 Sep 2024 17:28:57 -0500
From: Rob Herring <robh@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>, linux@armlinux.org.uk
Cc: saravanak@google.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] amba: Add dev_is_amba() function and export it for
 modules
Message-ID: <20240924222857.GA404805-robh@kernel.org>
References: <20240923094249.80399-1-chentao@kylinos.cn>
 <20240923094249.80399-2-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923094249.80399-2-chentao@kylinos.cn>

On Mon, Sep 23, 2024 at 05:42:47PM +0800, Kunwu Chan wrote:
> Add dev_is_amba() function to determine
> whether the device is a AMBA device.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/amba/bus.c       | 6 ++++++
>  include/linux/amba/bus.h | 5 +++++
>  2 files changed, 11 insertions(+)

Russell, Can I get an ack for this to take it with patch #2.

Rob

