Return-Path: <linux-kernel+bounces-384046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC6B9B2398
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DEC1F21435
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C949188906;
	Mon, 28 Oct 2024 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIMg49Y6"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF959157E9F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730087110; cv=none; b=td85vTL3H3xmgen0UtzmMWC7mXy/doPozVhWUI4YzVCaBnoK1PMKWfOrbPLJBjnyVL0ECNdjBVFLDWbj/c8ely6Dl+46WokcaLCOcD9ENw6Kk9Fxt2/cfQg1RZXK6Jh1DN3aN/ItZZQ26n7iQJS8O6iQ7inUmdGhW6iF3YsLUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730087110; c=relaxed/simple;
	bh=3OjgEwYHR+IMwy6P3gKj0pPGfXd5Fa2u7CCfndqSe9c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OV0Q9ZD/1x7AU6t/mOuFaPl1i4BezkjFxSP2tp/sazGmuOhbyJ81IsXaB4OMhsismAXW+4RAv791P23t/1kvVKdiH9BMaCAu/VTac8jCM0rJDplYhuB0IAuYGsXjp+hvUNnNTtt7k3/AXxUiYgQKsWLyVAXHzRMfDcG6TN7TN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIMg49Y6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e681bc315so2580220b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730087107; x=1730691907; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SBe5aS+44FsgeWkrDDWZbGKgu33QWTjE5Z3OiByZNqA=;
        b=WIMg49Y6P9az61qygMt+Na30x1abokbzRkiEguuKaovVWKCjpPgmG5k3uPLebc2gx2
         NFIzVQCQJFfD3JvXTDHddY5wwFAzXX0QwLcdod5V1L5VoGIMdgpW5YTehZ20BTlw5N9D
         jWZ/6J9uMJMnHfZOrzbjTEw14Ml5P+WlpmeIR2sNt2fe++nR0OlzwnPiVg/WpptNfSJP
         ssvXHUYXx2xNy7PZxAllLnHEAfmjll5/fCUnS0PK8qyRiDX69jSneY/5Q7oSBGmcJuYB
         mtovMz5jTsTq+bTmx51aJz7LiRjV+JTS8pb4OmYojNswThaE16S9mguG8iHBtXBGErn3
         b0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730087107; x=1730691907;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBe5aS+44FsgeWkrDDWZbGKgu33QWTjE5Z3OiByZNqA=;
        b=i/dDsvHi176ZTa5Qar2F60kAfV+cmlTDu98LHJeuiAWFfi6EOaVWQUKu/7f2CuPLK8
         cVknTmGBfeFL4Df3E5vA/bLr/kM8p6b6EMY1m8xZwTwobJJqPGzz5o2ikea/3LslV7ic
         qQjBNvDww56IOIQq2tT8Hl58Yp8ugpMML+vJ8fuJBjLNaeb3K5PhOPmWFVOZ4KuE82+W
         Z95jOF4wSc9ya8nxQZ50w9SNJEj4q1+ulY4AhQtwnp9ZqlCP7XuGAHkmRFVYd1uJJI3D
         GaB+GuYfTHw1XtOBjpffRYuQBWooOUx+EfEQhFnykJerOGu0Nbo4h/n2gbvfVUncR/nm
         R6KA==
X-Forwarded-Encrypted: i=1; AJvYcCXGoxfl5mQ7ENnfQWNMRUSju0yU4gJ0hirMmtWkxp5FmTx3oFphQ3xV7fDegzTfwQbhtvf2NtiQkGw80Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHNX4HIAl0rqSxYL6vNXrQmOrktcszcsH4WcYL9SJMS6Iglwa
	JtFHInxwFj3zKF0kyolULzlQQy+hzyRslgfHVw/CiVDRx3ACMkOg54HgQQ==
X-Google-Smtp-Source: AGHT+IHikqwwIGdrqzMja/5LLlC97wlhEbRkjlCYndUFINes0Clw7nkOmZY01tjIWb/SSvH3GnTqVw==
X-Received: by 2002:a05:6a00:1a88:b0:71e:4dc5:259a with SMTP id d2e1a72fcca58-72062fb3c72mr9690869b3a.7.1730087106916;
        Sun, 27 Oct 2024 20:45:06 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e468sm4768150b3a.21.2024.10.27.20.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:45:06 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Rob Herring <robh@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use str_enabled_disabled() helper function
In-Reply-To: <20241027222219.1173-2-thorsten.blum@linux.dev>
Date: Mon, 28 Oct 2024 09:10:03 +0530
Message-ID: <87h68wnbe4.fsf@gmail.com>
References: <20241027222219.1173-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Thorsten Blum <thorsten.blum@linux.dev> writes:

> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
>

Looks like now a days LKP also reports this - e.g. [1] "opportunity for str_enabled_disabled(enable)" 

[1]: https://lore.kernel.org/all/202410071601.TFpXoqgW-lkp@intel.com/

I see more such oppotunities for later improvements in arch/powerpc/
root-> git grep "\"enabled\" : \"disabled\"" arch/powerpc/
arch/powerpc/kernel/secure_boot.c:      pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
arch/powerpc/kernel/secure_boot.c:      pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
arch/powerpc/platforms/powermac/setup.c:                                        "enabled" : "disabled");
arch/powerpc/sysdev/mpic.c:             flags & HT_MSI_FLAGS_ENABLE ? "enabled" : "disabled", addr);

> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/kernel/secure_boot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

For this patch it looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
> index 9e0efb657f39..3a28795b4ed8 100644
> --- a/arch/powerpc/kernel/secure_boot.c
> +++ b/arch/powerpc/kernel/secure_boot.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/types.h>
>  #include <linux/of.h>
> +#include <linux/string_choices.h>
>  #include <asm/secure_boot.h>
>  
>  static struct device_node *get_ppc_fw_sb_node(void)
> @@ -38,7 +39,7 @@ bool is_ppc_secureboot_enabled(void)
>  	of_node_put(node);
>  
>  out:
> -	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
> +	pr_info("Secure boot mode %s\n", str_enabled_disabled(enabled));
>  
>  	return enabled;
>  }
> @@ -62,7 +63,7 @@ bool is_ppc_trustedboot_enabled(void)
>  	of_node_put(node);
>  
>  out:
> -	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
> +	pr_info("Trusted boot mode %s\n", str_enabled_disabled(enabled));
>  
>  	return enabled;
>  }
> -- 
> 2.47.0

