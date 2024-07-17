Return-Path: <linux-kernel+bounces-255234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F38933DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD991F212D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E37180A6E;
	Wed, 17 Jul 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZFxwgq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5522E651
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223698; cv=none; b=hpyOOB4Xg5F3gdJuYFTWjD23hLuTCmj7Iboa4RLVd5p5rFhlCdcvsSyRvu5vCqiUPyWLS/m/+nc9JPQ2KCnwHA5+Ia7z+WK6KfVbns+9OZRL0zdtpSObtEcSv8Q0gzdT2247x1zH5V7mj07gPgmhUWE85P6XTCfLdJTogp59MV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223698; c=relaxed/simple;
	bh=DhFAFincECZnQ6N49VF4grcrX0gUzdPQUKGTG1ehRj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+2mi9d8Tjc+UzsA0SFb4AhKvKc6FCBwzCmiD1bpMmUGCTSMzsMNB+EaElnMz/sTrERmKRRqNIPCAtEaesafFj61nxXiyFtUNzFheXJDO9QS11rVd4agKUPfMPu43v9gDxpK/FYZkpN2d/N0+m/HDZKBB8yY45j/GXNd5QXr/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZFxwgq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87893C32782;
	Wed, 17 Jul 2024 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721223697;
	bh=DhFAFincECZnQ6N49VF4grcrX0gUzdPQUKGTG1ehRj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZFxwgq95Ibm8DxAIz0dpK6HySb7NzNCCqxllNt22nUm8ds/1y6iZxG+wriUrwTpd
	 BrATBfTZcE3O7wwDjF7QORaBBVm2UXafuBtVNArSZRJaOm+L4wpeTW+KdQs1spCU6V
	 boFFngYIvYS4fDNTY2IuXaFcqn6qrP0VRPK0iZcqIdVKtw2cXZXmHtpqD3nbG5WfPz
	 omItYCB7ZfwdOEI8zASBWU1LBmL3qAKUrTQBmcEUMhS9ZWiEcLnw4Opak5aBSia7gP
	 FZdZBHIorXa0v2gHnx4bUSWpopkSf8jNCQWsAHcpGc0YD43INl1qjm32y9uxwkVCuw
	 +XAbtQQEp3q3Q==
Date: Wed, 17 Jul 2024 06:41:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Message-ID: <20240717134135.GA24892@thelio-3990X>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
 <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
 <SJ0PR18MB524672A30BAE8A7163FABECCA6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <024d85a1-6a4e-4552-a5dd-adebfb195be8@app.fastmail.com>
 <SJ0PR18MB52463B1A7393F36673548989A6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR18MB52463B1A7393F36673548989A6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>

On Wed, Jul 17, 2024 at 12:17:08PM +0000, Vamsi Krishna Attunuru wrote:
> 
> 
> >-----Original Message-----
> >From: Arnd Bergmann <arnd@arndb.de>
> >Sent: Wednesday, July 17, 2024 5:20 PM
> >To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
> ><gregkh@linuxfoundation.org>
> >Cc: linux-kernel@vger.kernel.org; Nathan Chancellor <nathan@kernel.org>;
> >Jeff Johnson <quic_jjohnson@quicinc.com>
> >Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve
> >compilation issues on 32-bit ARM
> >
> >On Wed, Jul 17, 2024, at 13: 45, Vamsi Krishna Attunuru wrote: > > Neither of
> >them worked in our case, HW folks also confirmed that only > 64bit access
> >work correctly. > I will just include the header that address the compilation
> >
> >On Wed, Jul 17, 2024, at 13:45, Vamsi Krishna Attunuru wrote:
> >>
> >> Neither of them worked in our case, HW folks also confirmed that only
> >> 64bit access work correctly.
> >> I will just include the header that address the compilation errors
> >> with ARCH=arm, anyways nobody will use this driver on 32-bit kernel.
> >
> >Please just use a Kconfig dependency then. If the device requires 64-bit
> >register access, then the driver should not use the fallback.
> 
> Ack, since it needs to skip compilation on 32-bit platforms, can you please
> confirm below change is suffice or not.
> 
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -588,7 +588,7 @@ config NSM
>  config MARVELL_CN10K_DPI
>         tristate "Octeon CN10K DPI driver"
>         depends on PCI
> -       depends on ARCH_THUNDER || COMPILE_TEST
> +       depends on (ARCH_THUNDER || COMPILE_TEST) && 64BIT

I think it would be a little clearer written as

  depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)

because ARCH_THUNDER can only be defined when 64BIT is set. Regardless
though, that should resolve the issue.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan

