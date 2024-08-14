Return-Path: <linux-kernel+bounces-286390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE971951A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22561C219A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DD1AC42B;
	Wed, 14 Aug 2024 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPOAtx+k"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF1394;
	Wed, 14 Aug 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636054; cv=none; b=sJtMsqylRLcBFPNFiRia+CrXK9VbCa7RfrTnKHbXb+aNZI+nKdrXAshevT26FX2LBWczp5xM3eVi9k5pjdw7ffYfuEfOCs1DhsVD3Mov8MUjhT0X6jckB30mjUjKplrTculK6rj8rJLE8weKoDpr6WaSN+kf0Uw44VqqxNYWdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636054; c=relaxed/simple;
	bh=kC/4hv7Tlf4rNkCbnBYC0GsGAYl9OySn5/anCt20KgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6lcD68pCFJolDRcpwmaTFrVYPPYDMsLeCTuGINE6NNRBXL/2hQH1Sn1DUGKzyplBlx76TEF28wiJPZtcs9BEEuAFPJRCaBfYkuTlc9u++F+2MKuAjZRlJNS/pErEocDfyf/684LqFmD/CeGtna808HCxxjv4/gE1/xSdoqVruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPOAtx+k; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so4047881a12.3;
        Wed, 14 Aug 2024 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723636053; x=1724240853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1fDlzH9jTOZIDrqhn7CKak5t9+eLag2AQJVTQtxzNw=;
        b=CPOAtx+kRFObCHBePV0bDRrt3RpzPT9CNSbkQOL3d4NE+WJDYLbP0sZUXg3YICPuTa
         fFgKHtheo0ZCfkIKJ2RWx9w3tOvRgNpyt+I62HaBb+XPLI0/H0znjzi2mCWtEK9uevyz
         DGyPjnmg9fXAU3GW9EKoJJ8P0Onlh+2HP5iZKvbrzdFnP0AXwYTIEjll+dWc6IuK3i6g
         +5BzkhS/OzUXcSIjaab/WfkUsR2WcbBxzLYcIUZtJ8ck5mHYFqnJe0LBD4QE/xB1GWQj
         eXCq4GIlvcXAYepuU8tpsb5eCySxYZ+C2rWPnI+5Z9uVlHC3/aJX1nJbquxvoNJOEOdj
         hdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723636053; x=1724240853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1fDlzH9jTOZIDrqhn7CKak5t9+eLag2AQJVTQtxzNw=;
        b=BA6BAXUWKF22ApbTyfXmY5ObnAr2Kg26zowV0IVlfhsW+HOwblXCbEqbj4WsEpJk8d
         1dm4Eu6Y93yl76JjLi5tvWW5a2bEGLXhOeDUlTKcJmfN68SPm2MBpCNp6RWDUunH6TXS
         Vm8ATKheKnLH8YpWVj4bvc3RvLZEWqhi2bOdzlttNIiWozk8lHEUqn/VkVLF0rpfPpZp
         Les5TWW0MzbvZvdTwghnwolEpKv6DTlj6lqEgWzlLIhB+PDKV5aesMcAEeIw+wrgUe8p
         i5qyHTuQ79VcA8dCgAufPs7y2XA2pLJmSHp8Ra1QVCLSl7lc0X/l4FagZHW2lqCBc4dS
         SmEg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+QWqw5ZntmpON4xbs9b97P9rabnqbn+7dSJfjDiUn5QwX3XShU9+D78K+fszWmCJYCeYB1MJDByP1jyr0ju52tquM5UQY5hRrllI
X-Gm-Message-State: AOJu0Yz6NhLNs0h6r9nJDRbWwTyB9xAe8alJZmbuwLn/nhY05UogUUbW
	Cm/mjBkiWoomJNGfN0ysl2Vi43OWHUp4JZrblvhV/a2nDnhCeDWi8BIwLQlAUcKm5K0+saFaQ5K
	eukJ6WLImZhFelZiTTi33YAjPyZk=
X-Google-Smtp-Source: AGHT+IH4JPkPrru7hYMt1EtBpe28EVi59tRIW828NVfe2AJkiq2cDKhyzHxj+fhEYLKzGRFlxkxIiNq4UU/GznCEU0Y=
X-Received: by 2002:a17:90b:350d:b0:2c9:649c:5e08 with SMTP id
 98e67ed59e1d1-2d3aaa9979emr2456633a91.15.1723636052751; Wed, 14 Aug 2024
 04:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814103620.8912-1-abhashkumarjha123@gmail.com> <20240814-vexingly-gigahertz-b4fca46f4626@spud>
In-Reply-To: <20240814-vexingly-gigahertz-b4fca46f4626@spud>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Wed, 14 Aug 2024 17:17:19 +0530
Message-ID: <CAG=0RqJ94dpFhAs6GihVZu3DKv2ZjjFMQxbCXd5Ux2tNCRrv2A@mail.gmail.com>
Subject: Re: [PATCH] LKMP(Bug fixing fall 2024): Fix documentation spelling errors
To: Conor Dooley <conor@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

> btw, your commit $subject is rather odd, as it contains
> "LKMP(Bug fixing fall 2024):".
I changed it to something appropriate for the mailing list.

> > -configured from the parant process. Also, users must noted that these interfaces
> > +configured from the parent process. Also, users must noted that these interfaces
>                                                         ^^^^^
>                                                 There's a second mistake
>                                                 in this line.
Thanks for pointing it out, I made the changes in v2.
Link : https://lore.kernel.org/linux-doc/20240814113003.14508-1-abhashkumarjha123@gmail.com/T/#u

Regards,
Abhash

