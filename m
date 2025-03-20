Return-Path: <linux-kernel+bounces-569290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82093A6A103
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DE78861E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBEC209689;
	Thu, 20 Mar 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaCwQ09r"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE61EBFFF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458608; cv=none; b=HBH6UgF6/2e2KQKMzNeHuxbgGiV2ga5cclAMflkzZAJp683tgSjuWbg8pLq/Jp9u5/AqyiKo0ocD25fq+pLyVJ7unyUq6SJZLpbvGNyACAH4QVHkOL4oNawm73s5AdMfARsQ/YKggT2SQF6aAGk8LWIf7nmtZrSG/pwwN7wLyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458608; c=relaxed/simple;
	bh=ZaxPu7VnsuF+LQquHXDhEfXNfIE4bjmFe7vB9NQGBcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtkREstnbqFZKPY0L4EHit87Drtz/61QJRiO2sy/PZkB9ZHUW8rYf3AV/ip3UpjPpkekfCRIFF3vL/rVtk6goBdlYCArep7wnt10D4KklMafGFz+94wKL3WEj8APpT6ZEwnBjvcemzslsfhkue9lOQBpSC0TiYmN+cid0G78OJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaCwQ09r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf257158fso2661295e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458604; x=1743063404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfxEvaLbHn08ch5Af9qE/losOCpYioxFAsYk01h6DAQ=;
        b=OaCwQ09rZEzfd0k4MXhcNlUPCCeicVwfiB0FmDB6DPxX3MW4nLjBiSE24068iRO/Ny
         Ans5LQry4gJW5MsBJsXCKxZ/5Pav3ww51mVxsoGVcvdMN8iv5bYjEsEP0hdPbCp0ftsa
         YSVO1erbjjKDwLiBmrivAsEy4du0KtT0UY2efSgEtqBSkMwV9LL5Gz/4LM7aKxC2oLqu
         dgB4m8tHpT9Bc7ja6q1PCXL54ERXzdqv2igNf9tmdY3N5kMQefCbrMgKpByTQnZk5B3F
         s+H4QN1gnJirGknx5RBTfUONw8ciToTyYKjdqQFsOJXQg4vZDKaLxuySo/EGpv3fBvhI
         dzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458604; x=1743063404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfxEvaLbHn08ch5Af9qE/losOCpYioxFAsYk01h6DAQ=;
        b=V2XdCCdlIAhrka5zcoIu4h6rNmjVwaBSpoP16r4TcSzqLl+7Rtx7JNKEuoZ3P/vdjl
         wE9QD58dp1D0VWHYnUImktpVXDMX9Ep/C3xcEf6D76lNBpBFXdJRE3WhWVoAfwVUScyo
         d209tg5nSbaRll/UaIPIMdToZHnIxLa8orCQopCanpu7t3UBo0TR8UkJaT/E17qjis1o
         6kN3hyBDzD/ukl1ajpNNN9esorvZR/Qf37h4lBsA3IaxMWYOQ1Z0W8L1BoSZfPww9vsX
         CVXzNwWdhCW98VXEdbyu5ojl9XAt0NhBqPfzNhp+hJ0jv0WWXFCEuxDuxDqNn2zzfiG8
         q/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVut+F3HVHtNSpSiPwosW6GCykmjiaTgOIUlVwYY19uIawostQMaJ0gTg8M73kDHwRUXuecki4EtIpStrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeltx6ynUPHZV3MdYuV7hb5lsDks7N2XRv8YKvHGqW4VTBPjne
	lhRaXXjd+7lZtdOdhqJtCMIMZueGaqBf2f984jC0WeMM3u0cRG2X
X-Gm-Gg: ASbGnctuOnYluJ2We1SFz+xVEFqfqzGpD29GXwT3TEBDdsXu99hF35acHC15uutjzWo
	U/01zpVsnmG+vWTgsqGosqg7xv8XNqxqMeyN3SHUP2PuNaX0WzKFWoa8TvYC/SZn81+FIVLZ+x9
	l0CSidU6pIBk3ZiER5vn3ccuGTlXJHMEQMz5AGFqSd08M8Jfx0rcavJ1eS1YHps1azMqN16TYRV
	2EdwMlnYsOCyFZovuBZTs1QvrFtpJYP/Ilzf1AzkoQjuUWEqD0mN/3iVN2v7pft0nBM1XkCVSq5
	fTTL8vTqMbYtAQs6QBY+uBPxYlSqQd3Je9GkrkRBFGFrAGNTkX9xCTnhWNNf
X-Google-Smtp-Source: AGHT+IEnHaiVC24ef3meYMs3KCsnv7gtLUqxu51wjDeR59W8gyJRSgnTuyswcVHJ1xe9X8LX3Q4YXQ==
X-Received: by 2002:a5d:5f96:0:b0:390:f55b:ba94 with SMTP id ffacd0b85a97d-399739c0968mr7136652f8f.13.1742458603480;
        Thu, 20 Mar 2025 01:16:43 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df344dsm23735642f8f.10.2025.03.20.01.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:16:42 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:16:40 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Michael Rubin <matchstick@neverthere.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Correct CamelCase drivers/staging/gpib
Message-ID: <Z9vO6CyFBNzTpvjO@egonzo>
References: <20250319211827.9854-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319211827.9854-1-matchstick@neverthere.org>

On Wed, Mar 19, 2025 at 09:18:25PM +0000, Michael Rubin wrote:
> staging: gpib: Correct CamelCase and remove duplicate entries for bus control
> lines.
> 
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch
> 
> CHECK: Avoid CamelCase
> 
> * Patch 1: "staging: gpib: Correct CamelCase for BUS constants"
>   * Removes duplicate entries and corrcts Bus with BUS
> 
> * Patch 2: "staging: gpib: Correct CamelCase for VALID enums"
>   * Replaces Valid with VALID
> 
> [PATCH v1 01/02] staging: gpib: Correct CamelCase for BUS constants
> [PATCH v1 02/02] staging: gpib: Correct CamelCase for VALID enums
> 
> Michael Rubin (2):
>  .../gpib/agilent_82357a/agilent_82357a.c      | 18 ++++++------
>  drivers/staging/gpib/cb7210/cb7210.c          | 18 ++++++------
>  drivers/staging/gpib/common/iblib.c           |  8 ++---
>  drivers/staging/gpib/eastwood/fluke_gpib.c    | 18 ++++++------
>  drivers/staging/gpib/fmh_gpib/fmh_gpib.c      | 18 ++++++------
>  drivers/staging/gpib/gpio/gpib_bitbang.c      | 18 ++++++------
>  drivers/staging/gpib/hp_82341/hp_82341.c      |  2 +-
>  drivers/staging/gpib/ines/ines_gpib.c         | 18 ++++++------
>  .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 18 ++++++------
>  drivers/staging/gpib/ni_usb/ni_usb_gpib.c     | 18 ++++++------
>  drivers/staging/gpib/tms9914/tms9914.c        | 18 ++++++------
>  drivers/staging/gpib/tnt4882/tnt4882_gpib.c   | 18 ++++++------
>  drivers/staging/gpib/uapi/gpib_user.h         | 29 ++++++-------------
>  13 files changed, 104 insertions(+), 115 deletions(-)
> 
> -- 
> 2.43.0
> 
I will be releasing a new user part and will make a compat include there.
Acked-By: Dave Penkler <dpenkler@gmail.com>

