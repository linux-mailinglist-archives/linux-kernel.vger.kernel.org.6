Return-Path: <linux-kernel+bounces-327226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF4977295
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DEF1F23CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B81C0DC2;
	Thu, 12 Sep 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Brc6dx0Y"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8D18BBBA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171998; cv=none; b=uv/Dt95fs311d7CBHtzN8MVoFD8EgSLW2oiRODjIPzTIAZrRJB51KxhkTA64GUePhyA3yqfD7wgQ9nq94X8ExEmzjDsdA6wZFpZTVO+AOC7XKpalTz04w822n9h/ohbhlpPqCqMD+PSReDBKgP+eaO/cG4uLlO8VTNpIPkD62vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171998; c=relaxed/simple;
	bh=6okTQsa8rgzwLl9EMROLD96VdwwjEKOOEENsTmnsbU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe0wzkCFNWbX0GrW9luf1iT+CTmu47622XQq3df2m8RWkkSA9gNJ+HduUdb/zgNAnE1WhdCOTZEpZjk7vODZ1uFjfIZI6k61/hr6xSeiAuG1jL2AhNyCrtqJ2RS95zlMCZvc/8KjfKomUIiVNzte/Wm0wSREXJqKjI0MR69BqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Brc6dx0Y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374d29ad870so132349f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726171993; x=1726776793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6/HJTiMeQZOHmvpm6Ii84I2SgNaOByjP7wc4AbEy0aE=;
        b=Brc6dx0YkMq+Ouv/wOIlleLJ8BFxel9lH0N2+EmGIt4NlM0Li/bgSLNRJ5eUA9EygT
         /Co3MNZ2czLAuijy0JuObF8xlE3nhglgHHiFeWVAwCewqqydQ5yc5u2B1R1eUVfn+v76
         ZJ+4fm9dppUVrqDerkLgYY6bTI5lDBJ9vx59QDORh9kci9EdXoZi4/nN/THzp8cSMAv9
         JqJwh9d/PgDevv60tH6dYuLpAP3EQCSMJ2e83GZHoowM6O84lSyA8nyMdSsNWTHF1a6T
         4TUCeMuWn9wdZSTnLNeJSyMpIAkgoFSaJZtIuOPRqdtvh7vEBbNjW9kpBCJk0kvfJd2n
         IufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726171993; x=1726776793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/HJTiMeQZOHmvpm6Ii84I2SgNaOByjP7wc4AbEy0aE=;
        b=a6pt4rFvlS6EwUpKcnnf3265auGbVIdghMHvQFCLtzY1YV9+0cSCLmfiDIwL4fasQi
         pengUOYXS77jiyXMxQW9PbHxmB2XMLv6HOlgEJhWM4PTFPNZJyZxcsgby5hdE1e1hZtQ
         bPWTDGXVfT5ww9TortGlP9978yr1eKRr2jczTM1ShV9oXxWu92dgG1/VR7xl8U/CgENm
         fYLKMhsdo3k6a3xyRy4eHLzDtqBrI/Q/aW4F/ApOjh341DakDihMVvn92wYB3wuyQ4Dq
         x5EepQYJhwt3Zd3cskHGqDgFvuC6Igl2Ek2wt9klp1ZuXCTSK71EWuO72DmkLx5JfPe5
         MfTg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ24gcOwLbwyrXIPH73fTUoZgiSNfA4EpWHy++qPq6ErJckFe0jWLHrIVlBzajfLWbeRMLjxIhX8Zpjvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegogXyXRVvd51TYlDHNKY/ZeDQLmWjjyP8lkIbtni39OADP7E
	92kl1M7xyYhqh4HZD2W3FxJDowYmk1ekd5p+O5cKa6JhE2xOgaSxNilRwDW45E0=
X-Google-Smtp-Source: AGHT+IFuESW6u6fBWF/+LEDQ2JIBb+AK4uD5H903pPBCcN1b1sjbV/Ut3OwzKvhomN0NC4gqB+byJA==
X-Received: by 2002:adf:e80d:0:b0:368:3751:de3 with SMTP id ffacd0b85a97d-378d61f1f9emr189043f8f.31.1726171992398;
        Thu, 12 Sep 2024 13:13:12 -0700 (PDT)
Received: from localhost (200-158-197-118.dsl.telesp.net.br. [200.158.197.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af44f91sm17798075ad.63.2024.09.12.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:13:11 -0700 (PDT)
Date: Thu, 12 Sep 2024 17:13:08 -0300
From: "Ricardo B. Marliere" <ricardo.marliere@suse.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: gregkh@linuxfoundation.org, skhan@linuxfoundation.org, 
	rbmarliere@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Use new initialization api for tasklet
Message-ID: <wpmjgqvxzzowc36wtwxlht23pvvuzdpijhtkiojlayr66cktxp@dnj2ss4fu6x7>
References: <20240912172231.369566-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912172231.369566-1-abhishektamboli9@gmail.com>

Hi Abhishek,

On 12 Sep 24 22:52, Abhishek Tamboli wrote:
> Use the new api DECLARE_TASKLET instead of DECLARE_TASKLET_OLD
> introduced in commit 12cc923f1ccc ("tasklet: Introduce new
> initialization API").
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  drivers/staging/octeon/ethernet-tx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
> index bbf33b88bb7c..ae1bac99b461 100644
> --- a/drivers/staging/octeon/ethernet-tx.c
> +++ b/drivers/staging/octeon/ethernet-tx.c
> @@ -40,8 +40,8 @@
>  #define GET_SKBUFF_QOS(skb) 0
>  #endif
>  
> -static void cvm_oct_tx_do_cleanup(unsigned long arg);
> -static DECLARE_TASKLET_OLD(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
> +static void cvm_oct_tx_do_cleanup(struct tasklet_struct clean);
> +static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);

This fails to compile for me:

In file included from ./include/linux/kernel_stat.h:8,
                 from ./include/linux/cgroup.h:25,
                 from ./include/net/netprio_cgroup.h:11,
                 from ./include/linux/netdevice.h:42,
                 from drivers/staging/octeon/ethernet-tx.c:10:
drivers/staging/octeon/ethernet-tx.c:44:52: error: initialization of ‘void (*)(struct tasklet_struct *)’ from incompatible pointer type ‘void (*)(struct tasklet_struct)’ [-Wincompatible-pointer-types]
   44 | static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
      |                                                    ^~~~~~~~~~~~~~~~~~~~~
./include/linux/interrupt.h:665:21: note: in definition of macro ‘DECLARE_TASKLET’
  665 |         .callback = _callback,                          \
      |                     ^~~~~~~~~
drivers/staging/octeon/ethernet-tx.c:44:52: note: (near initialization for ‘cvm_oct_tx_cleanup_tasklet.<anonymous>.callback’)
   44 | static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
      |                                                    ^~~~~~~~~~~~~~~~~~~~~
./include/linux/interrupt.h:665:21: note: in definition of macro ‘DECLARE_TASKLET’
  665 |         .callback = _callback,                          \
      |                     ^~~~~~~~~
  CC      mm/memfd.o
  CC      fs/proc/fd.o
  CC      fs/jbd2/transaction.o
  CC      drivers/firmware/efi/libstub/gop.o
make[5]: *** [scripts/Makefile.build:244: drivers/staging/octeon/ethernet-tx.o] Error 1
make[4]: *** [scripts/Makefile.build:485: drivers/staging/octeon] Error 2
make[3]: *** [scripts/Makefile.build:485: drivers/staging] Error 2


>  
>  /* Maximum number of SKBs to try to free per xmit packet. */
>  #define MAX_SKB_TO_FREE (MAX_OUT_QUEUE_DEPTH * 2)
> @@ -670,7 +670,7 @@ void cvm_oct_tx_shutdown_dev(struct net_device *dev)
>  	}
>  }
>  
> -static void cvm_oct_tx_do_cleanup(unsigned long arg)
> +static void cvm_oct_tx_do_cleanup(struct tasklet_struct clean)
>  {
>  	int port;
>  
> -- 
> 2.34.1
> 

