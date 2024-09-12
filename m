Return-Path: <linux-kernel+bounces-326898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE97F976E43
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EA21F22D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426351B78FC;
	Thu, 12 Sep 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcMCPEZq"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337031898F8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156588; cv=none; b=CUVPPZwhWqbEOxS4CTRTpmOOVj8b5eTAGrJ80U2ja3G1Z2cv2mir+QhGZQ5n1ftluACpxWf3xJ066fmgjvzFSP0gVStayI7QtXpjm189SIEQTF09Z60Mb/BDMiYpeeHu9jjjAcoe7CzvAQx+kkg+6DlR9Qy1pGr9iyvTtU053bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156588; c=relaxed/simple;
	bh=0KxMTMFwLEWDiU6JsY1B7nSNuzcA1yktVMPv4kYdEes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svYd7R3IxByRFTJRy5Ac3AOC6LjyPJETcstvQ/kLxPlrcOmwcF21euclJOu2uf1kb8KHhUlCujBoJkEW8KvzzUe5C+jPJFfgq+0/B9tBorrxUgbTDtkGuj4hHVND17Hnn8AxJDxAhZAaJ2ImRvjfXxwgnpBXnIN8TiNpywiqI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcMCPEZq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2daa2262so123061866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726156585; x=1726761385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyRNygCbaKKxy4c7gezDYP3ib0gJYCoq+xh8HPggzLY=;
        b=wcMCPEZqyRQselA/r8jd3H26lhjrEl5W3QnxOmfIezk4fVnShYOdXO6Bl5icHgpgtD
         b74qF3F9XRUMRyNgB/fpV67C8pi0CRoYEYuZJX9bjqxhnwq1SAYCQTE1W0boWUV8D5VH
         Ejny+mKQ0EG4eDUTnpIKzx1CUS7Fe2AhESGbIWZ03NktFKNvTvbMzytiidtzoVemiFDB
         HLVl47KAFI95gfUep/pr7/CGBAHWdQ2dPWquJsQ91/60Y8Be/nKhsKIQ1bCdhAbGkJu8
         5EDQ+/xakqt8C9vvlA/JgxxA+BjP9xhmIt2Pfi9cZ1q8lRdLz6wzGGVMZatnWvy0pR8h
         u+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156586; x=1726761386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyRNygCbaKKxy4c7gezDYP3ib0gJYCoq+xh8HPggzLY=;
        b=unWjv9JtijNLL6oHFgAPwk0XUeYvRVinuyasylEv9PEMK6KFoLZQxY0/Zxyqj0amkM
         2tEOcBjbHas9YCNdPpJnAb+gElgPyxBmPDsS160yfkCMrvrXIpdRyNeWYmB8WKtIRT4x
         CJbtoh0RU/hK+1I1uleliSeAuW63Yb0aMCowRMTy4Cel2paLThLsEkHuXIiHeJSKcf+L
         G0VEMWS4LdFLBRuTI69MgMpNq5wguR0w4mimxVxxayV8omVC1yRkH9c+VwBqmv205kfx
         cUCIlPYaOGGDfebiNGotJFL423XLJfx5OTdViWiZTPg1bl6Re4P44cA5qKRrSbwvDl+w
         PzHw==
X-Forwarded-Encrypted: i=1; AJvYcCUyGkaZI6J1I6Vwhzd4I2IlPxCaqQrHtBOMIpU07YP468yOMxIzpQ40iTNG/7U/yffMZtzimTtbxJ+6AlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkL3/7o68IVWjRr/l6HW1xmaTpkNa2OtEptmRCXBySqigww79
	BwqcXT/n7+S/ru+kM8PjMjXR4sctzBT46cYg13puEFxUU+jpv9qQL36m2x+E0/dlP9yZYMv8uVu
	j17sQpATleNAsVRgby3X9irpgggNtMPgwe0pG
X-Google-Smtp-Source: AGHT+IGVBHBJ4sB9gIBjwyQM7TkYIWL+8lUMn7Zt9w5XS5Y0YO1x2Mclf141VABjb/XKkh9aDWdNjmH/ntHJB90cCDI=
X-Received: by 2002:a17:907:25c2:b0:a8a:8c8e:f5e6 with SMTP id
 a640c23a62f3a-a902960a0d6mr297623666b.49.1726156584984; Thu, 12 Sep 2024
 08:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911135828.378317-1-usama.anjum@collabora.com> <ZuHfcDLty0IULwdY@pengutronix.de>
In-Reply-To: <ZuHfcDLty0IULwdY@pengutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Sep 2024 17:56:11 +0200
Message-ID: <CANn89i+xYSEw0OX_33=+R0uTPCRgH+kWMEVsjh=ec2ZHMPsKEw@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
To: Oleksij Rempel <o.rempel@pengutronix.de>, Qianqiang Liu <qianqiang.liu@163.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Chris Snook <chris.snook@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, kernel@collabora.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:20=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> On Wed, Sep 11, 2024 at 06:58:27PM +0500, Muhammad Usama Anjum wrote:
> > The err variable isn't being used anywhere other than getting
> > initialized to 0 and then it is being checked in if condition. The
> > condition can never be true. Remove the err and deadcode.
> >
> > Move the rx_dropped counter above when skb isn't found.
> >
> > Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
>
> Thank you!
>
> Regards,
> Oleksij

I do not see any credits given to  Qianqiang Liu, who is desperate to get h=
is
first linux patch...

https://lore.kernel.org/netdev/20240910152254.21238-1-qianqiang.liu@163.com=
/

