Return-Path: <linux-kernel+bounces-296652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6478695AD43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF842849F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD5137930;
	Thu, 22 Aug 2024 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJ20HHwm"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06455136354
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307270; cv=none; b=SsyY9IIMrqjesGl27nJ1LoItXXXh1aezbLrlqJ8Hz/SnJdua2/OxHEiCxlZV3+Ot8lBl6XibGHO2qLxO963XOANOg/cx9LbhdmF3C5iqMHbm630EIe3Pwnp1nVuJh7D+zglWQQ8MyGcFOMvsXK9NF+NgXG7yxQZPkOGi2bn7IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307270; c=relaxed/simple;
	bh=X/AcZ0iF6xFu4GrGSjyIJXtGgZILgu9A7UJpP3PiaXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+twKY4W9F+l8fC6an+CP65tq2rpVIS2QsTK/Q452tcTthPo9fQXz5NUSny2tNg/oHVmfqFhKAblt/wCSDARcudNzQZy/YdOL/bPTb1Av10ZVoQ3+FGn+ZmphGW/aSOO2nNVXxPleoDco4O65rHJ3eFXTT5QD2Ojc0F4Pt/nyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJ20HHwm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a864574429aso70963166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724307267; x=1724912067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHVY5A23Y8dwzOpFT0v9pVJprbgTbddkPeBrxq5dkIA=;
        b=mJ20HHwmH3Wi7ktyk38Vi4OG0lYhoMeZ0X1DGlQWCNbAVZa6fNeYPplen6RQ9LuCMT
         WNk/pEZ+PZGU8m/LruwN2z6rlJOHfW1ZMcG2tjbN1AUqi9RQaZQYTG6FGsqBvhbR5iF6
         CfZs8crGHgwgkoIb2EGCcWxk0O0kq9YH8dj7uqxQIrlDyGpWUNT7/UlH7XnzFr9e/RmZ
         PisclOgYOTvc8ot8BVaHuZL430KgNuwX2Gv6M7/qcALfJI4eth8eq0mM6P7sVTOVfMlw
         fgjIZji7RWTWspubB0QgTaTt5YKr2ZhOOvqwwL+IglOKESPSD2M0tcHlO8NSasQOi9Yt
         gN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307267; x=1724912067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHVY5A23Y8dwzOpFT0v9pVJprbgTbddkPeBrxq5dkIA=;
        b=NKVNWAqzdfgOZnzqadd5c26FjcguDGCml+82uUkGzZvrJ7KWJVq8pDjtdDvGOq+yYc
         anyzIqmTjQ1zdDM7Odafzz4Kt/cc6cNN0C39ODr+dnSMj9Lr/ErUvpb/yVe8MnTbe4U0
         w/iRv7H3sAoevurOp4CEgD6M7le8bcyuvl7JAbsUDuntPFTZyZDzXy7SMOjgIlRfPC/m
         sy0l0ieN++9ka5ZGLzVbokDaxnZBK4utXkzZ9Q62IRBEvJwxNwbEqJ1S2CCtiQaSvGx8
         jNOdeCmrGPIyaJu8CYqHoqdYj2pMPKUVFMvOlioJ451A/2smogCSqFPgflsWs8Efwbr8
         08pg==
X-Forwarded-Encrypted: i=1; AJvYcCW/gOKYC7kkRpDlSkQexEhCL/So7hJYnbMn+BSPjM1+4PjN3y0j+jQzVMKg12YeJMMO71yp/LDwsXdUtk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5w7ZQ02DQJZ0UPaWypC3rLRPt4TYHPELtwQ+7dE/NDL6Ygun
	crWoRDN5jjuRAOyX16ZW8eXS7BoFtkVrLmiFTiC9ZNMU53Zx/k+DJM+QLJw3cMM4IP+DL10GoQ4
	FO8WUtsqqu8Uv8iUKWQJaOkXk6DkAnP1hshJI
X-Google-Smtp-Source: AGHT+IGkLdWFXeWBo7YlNuCirWCunCos803uCba1zpN6dzXrFxr17xPZiWKxAd6Tc75MZT0p4qHJOxRwWMdf0abf0H8=
X-Received: by 2002:a17:907:7d9f:b0:a72:9d25:8ad3 with SMTP id
 a640c23a62f3a-a8691abaf76mr63888666b.9.1724307266605; Wed, 21 Aug 2024
 23:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822033243.38443-1-xuiagnh@gmail.com>
In-Reply-To: <20240822033243.38443-1-xuiagnh@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Aug 2024 08:14:15 +0200
Message-ID: <CANn89iLbLv0P_cw99MiXVjZ1N2xOqzTemPxFkhBgtoWHty7otQ@mail.gmail.com>
Subject: Re: [PATCH] net: dpaa:reduce number of synchronize_net() calls
To: Xi Huang <xuiagnh@gmail.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:32=E2=80=AFAM Xi Huang <xuiagnh@gmail.com> wrote:
>
> In the function dpaa_napi_del(), we execute the netif_napi_del()
> for each cpu, which is actually a high overhead operation
> because each call to netif_napi_del() contains a synchronize_net(),
> i.e. an RCU operation. In fact, it is only necessary to call
>  __netif_napi_del and use synchronize_net() once outside of the loop.
> like commit 2543a6000e,5198d545db.

Correct way of citing commits is to use 12+ chars of sha1 ("patch title") a=
s in
commit 2543a6000e59 ("gro_cells: reduce number of synchronize_net() calls")

Quoting Documentation/dev-tools/checkpatch.rst :

  **GIT_COMMIT_ID**
    The proper way to reference a commit id is:
    commit <12+ chars of sha1> ("<title line>")

    An example may be::

      Commit e21d2170f36602ae2708 ("video: remove unnecessary
      platform_set_drvdata()") removed the unnecessary
      platform_set_drvdata(), but left the variable "dev" unused,
      delete it.

    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html#describe-your-changes


> here is the function definition:
>  static inline void netif_napi_del(struct napi_struct * napi)
> {
>         __netif_napi_del(napi).
>         synchronize_net();
> }

You do not need to include netif_napi_del() in this changelog.

Please send a V2 in ~24 hours and add this :

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thank you.

