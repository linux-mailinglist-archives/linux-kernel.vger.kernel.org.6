Return-Path: <linux-kernel+bounces-185308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB478CB34D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068D4282C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6F3F8C7;
	Tue, 21 May 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N7iluzI5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449E23775
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314863; cv=none; b=OAU0OBSbfOBcc/rea5Rza3yAjU0GY51co2qGyjFg6qg8LbEsSooW6/jzhWHM11v/tVx7bblEh/Gjcff8AE5EtHeiKjuSF8U7mqiCcKtRbGvQdJYGFpaHWCt2pqD3Lpwttwd30S2sKvVJpxmE+SfDpHGUDwQy/PNg5odFkm9BSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314863; c=relaxed/simple;
	bh=hKvqSaKigwC2kOJTZpuzetKFHumzoF4Vh0lRuiCiWp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKygb6g4RZuSYRXBqKoRGzkxK+MDU9yCyM2aQecEVahi/2QoZUaLQ88tKbBIHXbCYJi6VnmGL2M5wquPjneH5I70VFX1oogEstYk4861hDkBfWkZZyKotz3V7nKOmCeGN00GahMGvKmdK3OTAeQP5es0LZzejyZH2Z6nvbAocug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=N7iluzI5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-575070cff74so1396401a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1716314860; x=1716919660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSHHqF9+86a45LMERrG9B7L07T4eSiePeVoVM2YlIps=;
        b=N7iluzI5BB1YB40BlEH13P2pb+3KYe+o4br2uu4ha4oNsdOC7zUcp3LwMzCybf3EpH
         3FpJHxB/2IdAW/511FWbiQQfqrUMejg+atSeGaL8734PSpJjVsq8nbtvqB8J8rDsnDy7
         qS0iiyjyb1vUUYGlT0oD7EbOvVY5MTYNUZ8dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314860; x=1716919660;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSHHqF9+86a45LMERrG9B7L07T4eSiePeVoVM2YlIps=;
        b=nd1+WHFnWZFl1rx/p2cyrOzO4kizMc2IqJC8A1htWtqa4R54ALCTGuw+VIj7Thb/SE
         rV1B2CpQCsGHrXJl+eUe5+MCJ14NyjidGuY2IzXhZkOM9VImJEYVLW5dGHj6W7hAxsau
         GSBJuBlkWeIzkYkIXuGoOQ+cN78CLx4+QLmCnuU+9lY0EtLGzVs+X/0nrDxidVj+5NHu
         Dy8I6PiTVhzU5yNSAsthJbnRg/aAMZ9yH86/YwoFTfBWqcjQy64EP9CwZqkjhqsMtKYL
         3XFfzslMhkXhE6LUTQokXAEGFubUSoevEHVHu4HfxkHHZ5NofRmU8ys4r2hExhAJqFFc
         HHlw==
X-Gm-Message-State: AOJu0YwLuM71oo4MefKAGD9AR7vDVTSyBIIV7MYEkuIj65B6LF8I8eGC
	HYlNB6xqAa7uzkyLjeWhOiaqHO34oowRGO6P/2Fu1BmjuhD9DFw7KAERelRwlW4=
X-Google-Smtp-Source: AGHT+IFRKXct57H1SoEiiz3mRXHTN9XDhZ0JE7tJW8JJy+JXMmTBDEISGYZ5N+PBopuxsq318R4L+g==
X-Received: by 2002:aa7:ce06:0:b0:575:96a:5ccc with SMTP id 4fb4d7f45d1cf-575096a5d0emr10470410a12.3.1716314859880;
        Tue, 21 May 2024 11:07:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea6586sm17028153a12.14.2024.05.21.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:07:39 -0700 (PDT)
Date: Tue, 21 May 2024 20:07:37 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jason Gunthorpe <jgg@nvidia.com>, Ofir Bitton <obitton@habana.ai>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Change habanalabs maintainer and git
 repo path
Message-ID: <Zkzi6WS90yHna7Lk@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
	linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jason Gunthorpe <jgg@nvidia.com>, Ofir Bitton <obitton@habana.ai>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
References: <20240515162222.12958-1-ogabbay@kernel.org>
 <20240515162222.12958-2-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515162222.12958-2-ogabbay@kernel.org>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, May 15, 2024 at 07:22:21PM +0300, Oded Gabbay wrote:
> Because I left habana, Ofir Bitton is now the habanalabs driver
> maintainer.
> 
> The git repo also changed location to the Habana GitHub website.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'm assuming Ofir will include this in the first pr for drm.git.
-Sima

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index abd4dbe2c653..5bd45a919aff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9431,11 +9431,11 @@ S:	Maintained
>  F:	block/partitions/efi.*
>  
>  HABANALABS PCI DRIVER
> -M:	Oded Gabbay <ogabbay@kernel.org>
> +M:	Ofir Bitton <obitton@habana.ai>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  C:	irc://irc.oftc.net/dri-devel
> -T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
> +T:	git https://github.com/HabanaAI/drivers.accel.habanalabs.kernel.git
>  F:	Documentation/ABI/testing/debugfs-driver-habanalabs
>  F:	Documentation/ABI/testing/sysfs-driver-habanalabs
>  F:	drivers/accel/habanalabs/
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

