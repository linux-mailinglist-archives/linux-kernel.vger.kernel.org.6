Return-Path: <linux-kernel+bounces-182965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE38C924C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE05281FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617150297;
	Sat, 18 May 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STTZJUTP"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FA3FB88
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716065239; cv=none; b=Z9A8jv7NGa8XWL9VNwGodE3A8OxK3Ym7u1TkM44OC1AMU9gzvapwdaG4zsQzek645DHlhAjZ/8QZ7xyCUSYHS2WC67HpJFk4gn0mWTjQMiFtolMSEBq2exRInoBn55uFeTcIUAJfaiUwVdXrrVqO0CfkWAsr5rw1bHGB7Z7QZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716065239; c=relaxed/simple;
	bh=rznDBSToB52+bJsEeKmwW3jC08WdGdMMMEqdHJrwhgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftahRtCJ/dlb8c3VsQMva3U2GgaL9IdYkGkGcwTubt7Ch+KZi+1VXsoCD6pQn81uUiZHo329C3WQNXqaKlo5L8GH3UadcTe6QDqD2OLaj9Mb8fLfWcSL7b7LI/SFZIEUwQWhfZBqxA+abvlDRVCwSU94jNBJ86SphzEPGLCubBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STTZJUTP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f05b669b6cso40616435ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716065237; x=1716670037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dovlYWU9/q7musU7eTyJn+RHgfUBDCCZTTuGpTV+/mk=;
        b=STTZJUTP6PCP7mAIICbVQXC303mAScYr8CA3W3+hlDviHwwlNZwB2m2GfVMb7pAC6Z
         trcNs6/KJsZNmDWGeKj0N23u+pXu98EXmJ8zEjBltLhRfh/2Jg6mksZGE29K1ckVTk04
         mdhHaSynW7bb37VzDegtGBsP1fcQHlMbOeqLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716065237; x=1716670037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dovlYWU9/q7musU7eTyJn+RHgfUBDCCZTTuGpTV+/mk=;
        b=TNNFQOU+9trNSJFMLbOsWleZ8yk8JpeDcfJBpU+1dMQdaXK4ACP810Y/lc+mxU1peN
         WYat0Hd59GhrNmQXPCT0hOlVZsp10ANJRiE4TOOQO9mdqui2OrUweBE9ENWezdpNefwx
         rf48rBC9gYV2dK/GjrLB9F3WEpQhqmjc583ScYpNU1Goy2LMNjYGmR5xRW+ILuC+oS86
         XCytTHfnO6Yxam1olfMmkCaj7Ebb8A2974S+7IOqKFkarURYnk+aOn637B/wgbfwaSRa
         9MRLP+zLlvLa+/+2S460p6+pmo/aqxh0E0W5F2dZDxNH69Oe6FNjulqSDCErS6FGzCbG
         SBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsexZMLQBUzWzsDCGNnJLGMajWQVH/uKEfbrAD8C7nQk0kbfP1ubhOQENmDNeOodMFKCppgDlMpKZorpraHeINlDM+mKAbFn+vFuXx
X-Gm-Message-State: AOJu0YxlX2gUhxdLOFhwtfqa8ow0jf5egx0pLxDBwCvMxbnYwwuqQLeJ
	NM6LYkTU2ifhDBU0iz4qkDOEPnTOAg+tFSEUMO41eNUqQ5o2MaZ73wLrgrQk5w==
X-Google-Smtp-Source: AGHT+IErrX7eTGQo+WffbLOh7zp6AXgmIidyVMZyBccWvtdbFOD4aNfW4ejCnUVAVRtcGXuXKO/5ng==
X-Received: by 2002:a05:6a00:1a8f:b0:6ed:caf6:6e4b with SMTP id d2e1a72fcca58-6f4e02d3473mr27469433b3a.18.1716065236358;
        Sat, 18 May 2024 13:47:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f6704888c1sm7725286b3a.157.2024.05.18.13.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:47:15 -0700 (PDT)
Date: Sat, 18 May 2024 13:47:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-security-module@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without
 module decompression
Message-ID: <202405181346.901048F98@keescook>
References: <20240514224839.2526112-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514224839.2526112-1-swboyd@chromium.org>

On Tue, May 14, 2024 at 03:48:38PM -0700, Stephen Boyd wrote:
> If modules are built compressed, and LoadPin is enforcing by default, we
> must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
> Modules will fail to load without decompression built into the kernel
> because they'll be blocked by LoadPin. Add a depends on clause to
> prevent this combination.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  security/loadpin/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index 6724eaba3d36..8c22171088a7 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -14,6 +14,9 @@ config SECURITY_LOADPIN
>  config SECURITY_LOADPIN_ENFORCE
>  	bool "Enforce LoadPin at boot"
>  	depends on SECURITY_LOADPIN
> +	# Module compression breaks LoadPin unless modules are decompressed in
> +	# the kernel.
> +	depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
>  	help
>  	  If selected, LoadPin will enforce pinning at boot. If not
>  	  selected, it can be enabled at boot with the kernel parameter
> 

I've folded this change in, since loadpin also works in non-module
situations:

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 8c22171088a7..848f8b4a6019 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
 	depends on SECURITY_LOADPIN
 	# Module compression breaks LoadPin unless modules are decompressed in
 	# the kernel.
-	depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
+	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter

-- 
Kees Cook

