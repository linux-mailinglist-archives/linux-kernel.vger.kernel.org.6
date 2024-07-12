Return-Path: <linux-kernel+bounces-250268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BC92F5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015C1B212B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA713D633;
	Fri, 12 Jul 2024 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="bz+HyEPu"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7A79CC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767617; cv=none; b=RJ0CZ9HFKNiRKkTJPl5zKVk1ajYxrKZb+Xn+eteTty7ADEgcwYh/MW9W17OSOvSxT4Sf4MXm771GBicB2uN3zyZ5wbe/ar6Bf9tEzcSlLyjy39+kyrVJ3upHVcPYB/664UQx/jlOOIpCodEMitsqhuxEo9kajLy4rWrbWu4Q4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767617; c=relaxed/simple;
	bh=jCpNPan1yvg4qm2JnvhWu+glmK8+IOzpGqlGEfGS4YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6zfP//yjP1/4qZa+5Rf5gC1UetNgu+kt90Wqkvn8qGBIA38ji3zPyf76lkw4yLqRF+8UdQlBDfTeNDzmNEHl/WGjZ2mBW9vhU+kY4twbDulFDiCwdolaCbsCsb4Yi/QKvdAAEqV/nJchXz/Us3VwiWOjC3VK/i6WLpu8023tkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=bz+HyEPu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso1377864b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1720767614; x=1721372414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLOzcQxtgY1Ls90A6FAg8y/fu34jSjZXLr8QOaNq1HA=;
        b=bz+HyEPuB8+Xgg7u15sQ2CE5zpu2SUN5hA8R76AFr7PsWS4MeJedVTEaKdA98pUWO6
         x1A4oAZpLw+HkoJkvc5Z4Qyz4+PiyiLbd/2uXhSTOwZ830FiRrv5kbVChAFCzITbppLw
         AEagWpi+sfuBmYm6zrmxIdJDC7LDG7yXgvv5QwuZCAs9+5Fu+Fh4aOPqnBnC5K7J5Lri
         kggFApolr8ReO5TWQ92OS6ZH0owsCTibeqIDJW5Kg2Ng+uSJyo+RgJ6aA1sAmCS8D7aX
         Xpui1MwIf+odYcQOnlLDr9bwVasLN04KLhIr4QwzM6tZbhZ92BfQZVFWVp1h8EWrX6c4
         qQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720767614; x=1721372414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLOzcQxtgY1Ls90A6FAg8y/fu34jSjZXLr8QOaNq1HA=;
        b=ZXRCB0Zty0BgCHP349WF1jAewBcoHWZQvhZnNsVVjo2lR+3S4Bt0h7J705pAbFCicc
         F+gykpj8j2CgmY0Kfkaebxx2GwyhA+6oT8b5eJJ5Kbtv3/xp8xO0CNrtUtaMB/U7idyR
         UwhG/d7C9pUnQDIrA/q338t1uXgb8Zwuu8tVgDsbURpaQPN5n6Y+0g0jgxzn1FBY2Ie3
         /nQ98LqfHJgqmWg8QXi1Ic5h5u5iY6qLqnDWLP4JyJSdsgWxhnNr6jPkntZC4EHcHreD
         ggpqvgOtgR5hnd9B7oaZDb7Oy86BwAe+YCNvsJfLH+H1Dqty8jLitSTMFumuKkFr79St
         jQBw==
X-Forwarded-Encrypted: i=1; AJvYcCV40BfN0eQecFPC+MI7IKaWQSp9KNDDevnOWuSVnxHymfWObWfM9/mkICBD3Y7pfRUv0xOzq4OSmIt68zsWGW0vUZvKt6MTqhAN5yxe
X-Gm-Message-State: AOJu0YwH7q43dEurgGcnBtGY/nY1fte//30XjXzguQA3B7lYp05l9fF7
	eXvN+NuNnjtLDdf/s08nE5SGukCQucf4tzGXgik1ETyWTVJy8dUSYR3huMQ1b4U=
X-Google-Smtp-Source: AGHT+IEmtd2yYJQoSBljsfSkChXU1mvTmqPJM7r+lNBjAP2ChBh/asoRVWE33A8FNfPrF2wpvJGaeA==
X-Received: by 2002:a05:6a00:1a91:b0:706:5a51:7be4 with SMTP id d2e1a72fcca58-70b4367b361mr12565830b3a.29.1720767614523;
        Fri, 12 Jul 2024 00:00:14 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:c949:fd63:7988:f01f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4396780dsm6739762b3a.111.2024.07.12.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 00:00:14 -0700 (PDT)
Date: Fri, 12 Jul 2024 00:00:12 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	ARM <linux-arm-kernel@lists.infradead.org>,
	Drew Fustini <drew@pdp7.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Yangtao Li <frank.li@vivo.com>
Subject: Re: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <ZpDUfIspyPL2wbLA@x1>
References: <20240712095825.6e1224d9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712095825.6e1224d9@canb.auug.org.au>

On Fri, Jul 12, 2024 at 09:58:25AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the clk tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   480d9a6083f4 ("MAINTAINERS: thead: add git tree")
> 
> from the arm-soc tree and commit:
> 
>   1037885b309c ("dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS controller")
> 
> from the clk tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc MAINTAINERS
> index 44cff47c2594,04eb5587ffa7..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -19382,8 -19322,9 +19382,10 @@@ M:	Guo Ren <guoren@kernel.org
>   M:	Fu Wei <wefu@redhat.com>
>   L:	linux-riscv@lists.infradead.org
>   S:	Maintained
>  +T:	git https://github.com/pdp7/linux.git
> + F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
>   F:	arch/riscv/boot/dts/thead/
> + F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>   
>   RNBD BLOCK DRIVERS
>   M:	Md. Haris Iqbal <haris.iqbal@ionos.com>

Thank you for fixing this up. The resolution looks good to me.

Drew

