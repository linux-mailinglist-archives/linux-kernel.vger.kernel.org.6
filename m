Return-Path: <linux-kernel+bounces-408034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B99C7943
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B6A1F25AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587D1DFE06;
	Wed, 13 Nov 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRS6yRTO"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4D1494CC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516604; cv=none; b=YzVXbgEmCXdBGIf6zCTp3JKEv3gjcT8nOgXYQ8TAk70k7R0i7a1vBVqA7I0Iw19Jq3embCAPEbzORs9+FCL0LsXjlaesgo/Fhs5QsnERl3UUUBDa2YWJy5/SuWgpId0i4QOHVW2TLJnH1+/SNTLVGspfLdQy6ctiVmp9UFuPPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516604; c=relaxed/simple;
	bh=EZya+FJMrje5mV8wSDU3bo/PA6cVGmfWmw2e1OFYPnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTMthDjIl3jl5x1D+EkDlN9yybdVFlLRLNPrlEzKIVSI2I/bo4JLtj6Vofh3wKmoGYs36ySC0gbreLk3/CQR6W0EH+AJZTK6QTX53ltosrTKXM9/CkpRxw+omfcjJ6jVvDxcCrekViiCqrqjUBJZfzedYevcqGSokcwmjUnZt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRS6yRTO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so5818591b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731516602; x=1732121402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVxECdTcqAbi+Rrk8wDv8FKnY/+NvKNnZGAccXEI/84=;
        b=VRS6yRTOKKKmkCPADA6N48gQitMwWjVbjugs+dRErpfGetHEIuyCbZWnzXchAPFonW
         8N69dhIa2qg3NsoLXFEIueFUE+f0rGCf6oQfdrxLFZp5mgoHWp6ALMU4lcAsLQYgfgK0
         NHFW6M9BUMaz9fM1IW5ROhBMYckR6cRAi7Q7Sb6LxTyB5j065FEMlX4Ob8emLazEtmnn
         BaYfsYSSKY7lcO5QNx8uR1Wy0YC04aj6hMADtH16CydD/1/WLtc5Vp1xelS5sJuI9TOp
         wyXI5u+O6l2OSeRPkNCdLW7ML4oDYw3sqxbHMZUrkvjLT/rlLxRA+M99/6D3odn+PWYx
         8ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516602; x=1732121402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVxECdTcqAbi+Rrk8wDv8FKnY/+NvKNnZGAccXEI/84=;
        b=ORZwp8+G1CU8d4GVhbZF4fCUJzAc1eWvo8Tmoh/6W7o9I+bRbd5kIlPj+HqDJsU4Jy
         Ue/nINj8aOxVkFhpTN5tr5EIJjxlq2hX2lZ4kPpaE5awmNveyEUOTyKE/bvyXhVfD1BU
         M9IM9ocFCIjhYLd4EYMO60eGFKlhngcod8HMTX9pVAfyRXVO/w/vAyeSh0Dj2CCezmIU
         dhTXmuSkWjSeDWnwARJIubbJonkJcRoE/xfSJWTt0mPygNtNcBK4dHkbOKQ33DJQpyLo
         bv3c5aPYM/6ZCmyFx4Pex2Jln2WIeIvKcOgs0v5COZtHsumWC8uBSkpP64mgfwZ/BeN+
         3CVA==
X-Forwarded-Encrypted: i=1; AJvYcCX9qDZnz6B+a8K6TRAgdLbVXmadKXI918cTA4B7VrmAb3f2myqqzR2BXC+nZ67mbCEZK6sPHPD9+AM7n2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mgNwR83Al4an/GU7l9xfEZJ0ncDFOv5QDB1ClIiwf5MkJlU4
	7UIpnRM2HV6fn2DoIXH0hMJYN4iDf7QDuIjIszpWPA8oD38jUDwOFA374TYdye+MSsDy1JtfjqJ
	g
X-Google-Smtp-Source: AGHT+IEJlVgaPrBBscQLqLbr/yoapzGNIccPwbYP5hzO2WPEIQAkd9edjzqTVN9xB76kHN3i3HKHAA==
X-Received: by 2002:a05:6a00:1744:b0:71d:f64d:ec60 with SMTP id d2e1a72fcca58-72413297242mr29057380b3a.7.1731516602100;
        Wed, 13 Nov 2024 08:50:02 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:fd79:a2fb:87a9:f18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bb0dsm13912298b3a.120.2024.11.13.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:50:01 -0800 (PST)
Date: Wed, 13 Nov 2024 09:49:58 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: anish kumar <yesanishhere@gmail.com>
Cc: andersson@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [RESEND PATCH V6 1/3] Documentation: remoteproc: update
 introduction section
Message-ID: <ZzTYtn5jple+dbMU@p14s>
References: <20241106051016.89113-1-yesanishhere@gmail.com>
 <20241106051016.89113-2-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106051016.89113-2-yesanishhere@gmail.com>

On Tue, Nov 05, 2024 at 09:10:14PM -0800, anish kumar wrote:
> Update the intrduction section to add key components
> provided by remote processor framework.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/staging/remoteproc.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
> index 348ee7e508ac..eeebbeca71de 100644
> --- a/Documentation/staging/remoteproc.rst
> +++ b/Documentation/staging/remoteproc.rst
> @@ -29,6 +29,23 @@ remoteproc will add those devices. This makes it possible to reuse the
>  existing virtio drivers with remote processor backends at a minimal development
>  cost.
>  
> +The primary purpose of the remoteproc framework is to download firmware
> +for remote processors and manage their lifecycle. The framework consists
> +of several key components:
> +
> +- **Character Driver**: Provides userspace access to control the remote
> +  processor.
> +- **ELF Utility**: Offers functions for handling ELF files and managing
> +  resources requested by the remote processor.
> +- **Remoteproc Core**: Manages firmware downloads and recovery actions
> +  in case of a remote processor crash.
> +- **Coredump**: Provides facilities for coredumping and tracing from
> +  the remote processor in the event of a crash.
> +- **Userspace Interaction**: Uses sysfs and debugfs to manage the
> +  lifecycle and status of the remote processor.
> +- **Virtio Support**: Facilitates interaction with the virtio and
> +  rpmsg bus.

Some of the above is either inaccurate or incomplete.  It would be fairly time
consuming for me to point out where the problems are, especially since I don't
see a lot of value in adding this section.

> +
>  User API
>  ========
>  
> -- 
> 2.39.3 (Apple Git-146)
> 

