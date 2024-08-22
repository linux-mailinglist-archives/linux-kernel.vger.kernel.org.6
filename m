Return-Path: <linux-kernel+bounces-297470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AE695B8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA181F23F27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E641CC163;
	Thu, 22 Aug 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ANlYYTXE"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265A1CBEB7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337719; cv=none; b=PRBDzraeiyPrs3kgs0mA8Phy/Hk/QjXth0tQzQarVG5raB9LM33GkIr4Bi30KWuXhjPX9402tVezsHdE5zrYYV7Q65q0q3Pq7yDhgI5rqgujYeCjzgHAqg+1dda71gVRAW69Lcu58Uwad6BuyKJiqlvM3XY1I+eZKVCjbJsDKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337719; c=relaxed/simple;
	bh=ptLs5g5e/JUM1gOCymPwGtZ0IdU0gKrAfvUz+8jHheg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYEfiRFwN9F1XP0SDXcBHwX7y71R+qGnMABHJp2NbEAQRy30W4aYSfQAB11354Wow89HoEPvfFkOR0ITnzBZLnnZxHuOm4zt/iQxPq19e5/ZPR9TG8ks36WeFmoYLrvlNCSIjtCI8d9/DdlJ/lewCl8YPo+2H/vbFCnv+Hcd+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ANlYYTXE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a868b8bb0feso117772266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724337716; x=1724942516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzfI12lPAEdIwAVUn60sI7mH7ScZBleiZFKu+KbAatM=;
        b=ANlYYTXEsizTk8jlyhsekfWgrRtwU+uveje54KtNSsP4K1B/oI9jA+wmIGDT+FSZ+f
         EPIbMMx3l93ApJF6fImdZhrdc10oGrqPLYbJ00wTd1GcbwvfmPIqzhWe8qtDdPbmw8sW
         HCIJcSpU1wRSrFF4R3YjRzI7w9KK3gfql0B6+k2IPXsZ0cc42AV+8CgubYKzDTZJ/hM/
         4vUDRDHlt9AykC02+5IMvA1VrEkW6Q5mcjmm3I8AbAUNhvwzYTtNTVPJyE/uawgEJnLI
         tlE5yQBye/Wk3KFIto5q/0xSecuY0MUmCEyCZkCLY4NPx7WyBogG66IJvNEpfSRt2n3+
         2u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337716; x=1724942516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzfI12lPAEdIwAVUn60sI7mH7ScZBleiZFKu+KbAatM=;
        b=nfbms/OLlOW6zX8WJHSzJ2nmuwnOstfGBa7HO9UcGMI2uuKk7JBgCvC5fE8KZZIxcD
         bvneGC8lHtYIYw/P9pqJMgpX9yfD2YYOLE/9hAy3/dIL2A7BCQqyR0mTlu4DrVrpQhq2
         5ohO/a+7IkVIAIC/EehTcAq3SKUfJGBpxnuqC1sr8AJX/b3ZPVyt/rxoRGe4LqAuzihT
         GCAuPVhNCPVMi+h0UAv1Q+7jeNJ7M9cFldJ3UHiqbf+NjRsJ4YQ0eUGefgt8axZKa0sG
         khQVXvVV9IfiIrrq7HTmwOP5zck4uQO8ClDfMN0WMArXZsu0I00bCB6Xs0en/gKItg1E
         zOBg==
X-Forwarded-Encrypted: i=1; AJvYcCWGiFMg1c41DF6oDyL36A57yd/kK5NRvklsT5WTfhp5Vro25S1b+wnL3FbM36LH5a4dpinbLyivaHUi45w=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbPaI6VcIbEmyRof2Dc+JGgPODZBfqMzDyaLBDg0WqhyY6iWz
	ogQAUukGF/dVzpFbld9/CMFMKDTQQXU3bceGTBuRcwnoB8ZcRlbK7mtf6t2io+8=
X-Google-Smtp-Source: AGHT+IHTlS6w9fLXd3mb3oowbdQAzsn39f9qBsGu9V/lFQAGRbnlHpS8/b9XHFJjUClmPvIbEw644g==
X-Received: by 2002:a17:907:6e8e:b0:a86:7d93:79b9 with SMTP id a640c23a62f3a-a867d937a60mr352367366b.65.1724337716270;
        Thu, 22 Aug 2024 07:41:56 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f437d5fsm129140066b.99.2024.08.22.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:41:55 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:41:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v11 00/11] Introduce RVU representors
Message-ID: <ZsdOMryDpkGLnjuh@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822132031.29494-1-gakula@marvell.com>

Thu, Aug 22, 2024 at 03:20:20PM CEST, gakula@marvell.com wrote:
>This series adds representor support for each rvu devices.
>When switchdev mode is enabled, representor netdev is registered
>for each rvu device. In implementation of representor model, 
>one NIX HW LF with multiple SQ and RQ is reserved, where each
>RQ and SQ of the LF are mapped to a representor. A loopback channel
>is reserved to support packet path between representors and VFs.
>CN10K silicon supports 2 types of MACs, RPM and SDP. This
>patch set adds representor support for both RPM and SDP MAC
>interfaces.
>
>- Patch 1: Refactors and exports the shared service functions.
>- Patch 2: Implements basic representor driver.
>- Patch 3: Add devlink support to create representor netdevs that
>  can be used to manage VFs.
>- Patch 4: Implements basec netdev_ndo_ops.
>- Patch 5: Installs tcam rules to route packets between representor and
>	   VFs.
>- Patch 6: Enables fetching VF stats via representor interface
>- Patch 7: Adds support to sync link state between representors and VFs .
>- Patch 8: Enables configuring VF MTU via representor netdevs.
>- Patch 9: Add representors for sdp MAC.
>- Patch 10: Add devlink port support.

What is the fastpath? Where do you offload any configuration that
actually ensures VF<->physical_port and VF<->VF traffic? There should be
some bridge/tc/route offload.

Or, what I fear, do you use some implicit mac-based steering? If yes,
you should not. In switchdev mode, if user does not configure
representors to forward packets, there is no packet forwarding.


