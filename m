Return-Path: <linux-kernel+bounces-569294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F346A6A10C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AC28A6EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450A209F4E;
	Thu, 20 Mar 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHv5Fe/Z"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3501DF248
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458687; cv=none; b=MPVh2cbcTqIrMF3OpYHYMfqW9FzihTFDG37hbb8hEg5D1zbxnrXmDMwjfHK/cO2cyIk9ozYAEZ13criBm9iTkd5EDoyIlp34FbgUCvoIO//opSlbeifOqxiixw8UtUI4rWzlOLNDufsYeNsuJZmTLUNuBFRlzkkKSd1iVLfeF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458687; c=relaxed/simple;
	bh=h4z+dIBpmf2izwGwuMDiHo+OLqgnEXNtCiW0C4T7hwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KquNpDX65eVezOJxnLHsjyyfl0jMMtEOQCDpqj/nWC+NUyO4W85EnmrnigTpfXX2dv2sv1UPGyHkQ4rlcvv+N5VqUyp6MRnVPIknQUM8hHoppv4dCqpobKLnIbdX8lN7++b4j8m0746JgxFhtKx4qtaRxe+bBzKCk9QnnPNER7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHv5Fe/Z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-394780e98easo246206f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458684; x=1743063484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjVQ5SOz+jm8u6D48pQ2cGM9HKLDE1RuGZARc2eKPlQ=;
        b=dHv5Fe/ZlyM+qyPLLzlCs1xvB/L9ozUhyHjvHEaTchBwVPJ0jWxlU6pJgwMMBCSp78
         yZlSMnaHkaXjoh+xd1S+HNnGguC46FEOI9NZjtkMt+rlvejQ2MZhfVLOepC9j68m6UMU
         cDUl7bJOr/HSRjY3pXvP3Ir6CRP/gIqbFonqOlFOer0HixPgVS+9QW6nRt4Elylfu+Kq
         jzX/BRGwaO3+6sba8+r+A3r4iaQvdSf9SclgkHBSY3Ouc35JAUhM61Bu06J5xZrxuTk9
         GZs2IsMv5zpkBDLDqFx70A75KdQkVU/xraB0lUlxKqtB+xTUi4r1+xjD5vbvGGpE1iwF
         7kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458684; x=1743063484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjVQ5SOz+jm8u6D48pQ2cGM9HKLDE1RuGZARc2eKPlQ=;
        b=jzX1l5Ukbba/CRcycNS/d5AhNvbej6fmvLBTcGI/zHcUI2Jn2CSAp0cGHSC5QQ0j96
         xv/ehdT1Xq8ih8iZY4IZlHzl3H77YgKcvqNRyFPugJWtdPNk2laBX+fpbEt5iV7eJFo2
         KUFfsR9wavPBoAF5otNHGIICwn/vYyMY8fiaGy2FkI8vnAF78xOoq3tgTugwggiOgrzZ
         sek0e2dqfMBlpNAoYZuNYtN/wKuFDoTNQMRv6VtKmjm4+Ab95TVgynLka1SCYkSXt+jW
         hRfWbaI0dEigbGVKQr+B2mEVPK4/M/CizQqWrmuxu8jjcZLYehLgWcIQvhAPIK/IzuWp
         8gjg==
X-Forwarded-Encrypted: i=1; AJvYcCVUL83dXcpAHG1nP2LhqGo9+JkdIf1r7McJBnSODF/enHqQgYsT2Ui6pkUw4TS/N6S/Uyzmdk1fjY6qv+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6+KUi90aZokfHS9NoO3EshhzL5xE1JktQ2Tij8mX5A2eY+s+
	7acJm5QCz4cKS+ldSgDsn7KVPX0nXgmQXcg/3oLdYEdwBKknTgMK
X-Gm-Gg: ASbGnctMek0iR1H+GspmNfvoAaaHjuk/6EMj2Mx1yv3XcgcrX9feXgK4WS3gU9EmLIL
	n5deJov/hGcGuJDXPAdoNzwtU9XKjipjygG5JTqdW2LZgYsURlL8mzL/3754W8DV5IX9a4Rqvdt
	Qqmg5QJcalbzL1H9VHL0pZkX+R9hySwhSOaNYMCfqNuJvFqg4R2pgKArJdFrfXiXq3tvpz6cwXk
	sNV3iF1rJjxilH7VbBV2mOihXotNg2N4LdKQYA4rvEDGuAMuHOtoV37L4LIXfLsCpZq5NeLK6Xm
	i42rMEIU9a8PMsbhNaTTtRyb4Q++R3y3Ul5raX5ztraKRach7LTZmnEhgeUW
X-Google-Smtp-Source: AGHT+IGgIm07Ipnj4FQkYOCqmmroZDk4enzX0nHBxCLPbW6TYwFUSSA2fsm9mL6oryT4dBL9wlwrHw==
X-Received: by 2002:a5d:64a8:0:b0:391:1806:e23d with SMTP id ffacd0b85a97d-399739bc113mr4512519f8f.6.1742458683554;
        Thu, 20 Mar 2025 01:18:03 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm23245424f8f.62.2025.03.20.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:18:02 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:18:00 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Michael Rubin <matchstick@neverthere.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/20] Removing typedef for gpib_board
Message-ID: <Z9vPOKAFv3Jw5l1r@egonzo>
References: <20250319215924.19387-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319215924.19387-1-matchstick@neverthere.org>

On Wed, Mar 19, 2025 at 09:59:04PM +0000, Michael Rubin wrote:
> staging: gpib: Removing typedef for gpib_board
> 
> Adhering to Linux code style.
> 
> In general, a pointer, or a struct that has elements that can reasonably be
> directly accessed should never be a typedef.
> 
> * Patch 1: struct typing for gpib_board
> 
>   Introduces struct gpib_board replacing gpib_board_t
> 
> * Patch 2 - Patch 18
> 
>   Adopting "struct gpib_board" as opposed to "gpib_board_t" for each
>   subsystem in gpib.
> 
>   *  staging: gpib: agilent_82350b: struct gpib_board
>   *  staging: gpib: agilent_82357a: struct gpib_board
>   *  staging: gpib: cb7210: struct gpib_board
>   *  staging: gpib: cec_gpib: struct gpib_board
>   *  staging: gpib: common: struct gpib_board
>   *  staging: gpib: eastwood: struct gpib_board
>   *  staging: gpib: fmh_gpib: struct gpib_board
>   *  staging: gpib: gpio: struct gpib_board
>   *  staging: gpib: hp2335: struct gpib_board
>   *  staging: gpib: hp_82341: struct gpib_board
>   *  staging: gpib: ines: struct gpib_board
>   *  staging: gpib: lpvo_usb_gpib: struct gpib_board
>   *  staging: gpib: nec7210 struct gpib_board
>   *  staging: gpib: ni_usb_gpib: struct gpib_board
>   *  staging: gpib: pc2: struct gpib_board
>   *  staging: gpib: tms9914: struct gpib_board
>   *  staging: gpib: tnt4882: struct gpib_board
> 
> * Patch 19: staging: gpib: struct typing for gpib_gboard_t
> 
>   Adopting "struct gbip_board" as opposed to "gpib_board_t" for include files.
> 
> * Patch 20: staging: gpib: Removing typedef for gpib_board
> 
>   Removing typedef for gpib_board_t
> 
> Michael Rubin (20):
>   staging: gpib: struct typing for gpib_board
>   staging: gpib: agilent_82350b: struct gpib_board
>   staging: gpib: agilent_82357a: struct gpib_board
>   staging: gpib: cb7210: struct gpib_board
>   staging: gpib: cec_gpib: struct gpib_board
>   staging: gpib: common: struct gpib_board
>   staging: gpib: eastwood: struct gpib_board
>   staging: gpib: fmh_gpib: struct gpib_board
>   staging: gpib: gpio: struct gpib_board
>   staging: gpib: hp2335: struct gpib_board
>   staging: gpib: hp_82341: struct gpib_board
>   staging: gpib: ines: struct gpib_board
>   staging: gpib: lpvo_usb_gpib: struct gpib_board
>   staging: gpib: nec7210 struct gpib_board
>   staging: gpib: ni_usb_gpib: struct gpib_board
>   staging: gpib: pc2: struct gpib_board
>   staging: gpib: tms9914: struct gpib_board
>   staging: gpib: tnt4882: struct gpib_board
>   staging: gpib: struct typing for gpib_gboard_t
>   staging: gpib: Removing typedef for gpib_board
> 
>  .../gpib/agilent_82350b/agilent_82350b.c      |  99 +++++----
>  .../gpib/agilent_82357a/agilent_82357a.c      |  85 ++++----
>  drivers/staging/gpib/cb7210/cb7210.c          | 107 +++++-----
>  drivers/staging/gpib/cec/cec_gpib.c           |  59 +++---
>  drivers/staging/gpib/common/gpib_os.c         | 196 +++++++++---------
>  drivers/staging/gpib/common/iblib.c           |  50 ++---
>  drivers/staging/gpib/common/ibsys.h           |  14 +-
>  drivers/staging/gpib/eastwood/fluke_gpib.c    |  93 +++++----
>  drivers/staging/gpib/fmh_gpib/fmh_gpib.c      | 122 +++++------
>  drivers/staging/gpib/gpio/gpib_bitbang.c      |  72 +++----
>  drivers/staging/gpib/hp_82335/hp82335.c       |  56 ++---
>  drivers/staging/gpib/hp_82341/hp_82341.c      |  68 +++---
>  drivers/staging/gpib/include/gpibP.h          |  10 +-
>  drivers/staging/gpib/include/gpib_proto.h     |  58 +++---
>  drivers/staging/gpib/include/gpib_types.h     |  58 +++---
>  drivers/staging/gpib/include/nec7210.h        |  58 +++---
>  drivers/staging/gpib/include/tms9914.h        |  52 ++---
>  drivers/staging/gpib/ines/ines.h              |  54 ++---
>  drivers/staging/gpib/ines/ines_gpib.c         | 111 +++++-----
>  .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        |  66 +++---
>  drivers/staging/gpib/nec7210/nec7210.c        |  76 +++----
>  drivers/staging/gpib/ni_usb/ni_usb_gpib.c     |  70 +++----
>  drivers/staging/gpib/pc2/pc2_gpib.c           |  68 +++---
>  drivers/staging/gpib/tms9914/tms9914.c        |  66 +++---
>  drivers/staging/gpib/tnt4882/tnt4882_gpib.c   | 100 ++++-----
>  25 files changed, 947 insertions(+), 921 deletions(-)
> 
> -- 
> 2.43.0
> 
Acked-By: Dave Penkler <dpenkler@gmail.com>

