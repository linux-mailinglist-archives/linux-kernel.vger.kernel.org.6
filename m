Return-Path: <linux-kernel+bounces-529555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C1A427CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E6516A134
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068A25A321;
	Mon, 24 Feb 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+yhHi3s"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CA3DBB6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414184; cv=none; b=VpXSxkqqDpPGllwg9E97M+U6Zp+UHsH2JIleHIhHmMdFcNvurd6WamAdtt5Wq1VR+CmsA3FOYLww+gPQ/jC2c4qBigwmIyw/GBkDw5YD7RkJdPn5cH+E/AxXZNbMiPMFgRcGT+b1tY7sJhBujg67BqdvL7PEDaqwrjOMx3PxPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414184; c=relaxed/simple;
	bh=OPT6qQsNtzyNIGY8raE9TrOAutuaFnPvwjknhDTd0i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM/o0KQMDYp06pmkawqnmiQDAfmJ9p0jR47UuRuYOU5RMUyqN3bjPt1KWhgVLaXrJPy39NEhpzY4+dzlnhhMOjgjOuCy144WdKxbwwjYlH2keKktld9yCvUvMU1wORE2DQM5WC7CM4/cQi2aSmkPErVhOlKS/2MTIUxlQXd0/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+yhHi3s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-222e8d07dc6so19939955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740414181; x=1741018981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HW8mIRa9V/90F96aEndp8VPY5eTy4hb9hqr/gPpaTU=;
        b=d+yhHi3sVPaWGuGepFrNVgwKjpEqddc6l8fs8dBFkfTTQqexEm6MIjyYE2xxKUI1cH
         yWxttjx2gAx1W7hCumuKmstEGBTSo9thz6UM0y86vYQhOR7cLFW7m9Ijt3QTd0a8fH3/
         aiW3X64HmTBWbhDOh2hUEdx5LzNHNhTXeTmkObqveOKgkx0KF0Ej9pH1iHLI57awuQIt
         pShDWByCoaALBmvYsAluioAn3ePOXGI3PfV/zfAvbqZ/ZjAeFc4rubz6QQ07HL0Bdt4C
         LsJpjcC8WaKXyz5j7UdZGIyUe0JZWUBoO2gAj22yRIMG5cHMpFur0PbRUYPMnjow4iTJ
         GS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414181; x=1741018981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HW8mIRa9V/90F96aEndp8VPY5eTy4hb9hqr/gPpaTU=;
        b=qfOt/DwELGBBTfaN5Hf5qCciLyZ9yQzKlwv9qA0HhGR4i3ufM5uvdIsKcqD0+18C2Z
         IPIFRvpIy881CnZg660C7TSgRe/RnS7tNF4s2ghDwsQjQm5W4/r1bOegTxsxGR3T8yF0
         2HxZCdAzKfmDhmnzHPDsJzahwM9ZwarnmJy1FW2rpp8qX+JC1YmIsYLKtVcwesZFB1ZX
         zb8ACqNonio8spPznx0NlX1BufLmNxyFCIHKlt0uAIf125gsGK8uUA2d8qFAJnWqd0UP
         zeFup2pWHeHljtRftXDN69IM5ge6RYjSGiafhXxaWh+F723V6+pvPp1I13XKYsxXJU1d
         ZXSA==
X-Forwarded-Encrypted: i=1; AJvYcCX28Z5eyZwXqOTVSWCCDtPkdz5vtRRHbHENGjiImdKVDWVMmtyVwFgcIl3G4Kj9pBbPuL2xVACkuAtsCHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3NySYARjyDs9NpEnnv75h7FqmasssgOzXVOb2w0a5+oj/LUW
	VFkNCEAWxxWX/Y/5kK2AhjvAOe0wExJDTScLGohFlNoWFy4YqysdO6jyr8AY/64=
X-Gm-Gg: ASbGncvigyoNv+NNlxq2no7RqXD8URKi3e4luW/U6y+bdadyemwR+URdXaYuEiLmrrJ
	k/Reen7pvcbCRZ0ta+9jbgt0UZJGLOYpgYlqaM70CU4Hp87LXoxp4C0HJO9XvhlOezKFHjh+aDg
	xd96AmOF1y0WkdYLyE3JubK1yUDJjuNURYCBfI10dCZ8oE8xhduAu9YAeuJUEX6gbgvGKwQe3wj
	+aJADgZnORk0ZP/CEztcxSxZ6sLHKGLnjbOi7LONRWeLmyTsxcyYSdjyMBvVCctPx5N4Ih+PWGf
	4A5Kw0Ou+VHzd5m73Lt+NE0IAMBc
X-Google-Smtp-Source: AGHT+IFDFplnMA6+/8FYcZqB6DS/ssdWReuVVNZtjllJgj6vqL14f/4j3jgX+FcwDSzN/kuF2IhjYg==
X-Received: by 2002:a17:902:e549:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-2218c3d0815mr271291165ad.2.1740414181558;
        Mon, 24 Feb 2025 08:23:01 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:b170:307:9f3b:9744])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7328619e138sm14385748b3a.66.2025.02.24.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:23:00 -0800 (PST)
Date: Mon, 24 Feb 2025 09:22:58 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	kernel test robot <lkp@intel.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] remoteproc: omap: add comment for is_iomem
Message-ID: <Z7yc4vxYkTMhSWni@p14s>
References: <20250217075858.616737-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217075858.616737-1-peng.fan@oss.nxp.com>

On Mon, Feb 17, 2025 at 03:58:58PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Address warning: "Function parameter or struct member 'is_iomem' not
> described in 'omap_rproc_da_to_va'" with adding comment for is_iomem.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502161648.WZWrFV7I-lkp@intel.com/
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 1 +
>  1 file changed, 1 insertion(+)
>

Applied - thanks,
Mathieu

> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 5f463937cbbf..9c7182b3b038 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -724,6 +724,7 @@ static int omap_rproc_stop(struct rproc *rproc)
>   * @rproc: remote processor to apply the address translation for
>   * @da: device address to translate
>   * @len: length of the memory buffer
> + * @is_iomem: pointer filled in to indicate if @da is iomapped memory
>   *
>   * Custom function implementing the rproc .da_to_va ops to provide address
>   * translation (device address to kernel virtual address) for internal RAMs
> -- 
> 2.37.1
> 

