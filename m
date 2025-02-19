Return-Path: <linux-kernel+bounces-522380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0398A3C963
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF34717864A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCD22E3FA;
	Wed, 19 Feb 2025 20:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd0p5Nf3"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737B214A82;
	Wed, 19 Feb 2025 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995937; cv=none; b=mjHE0avD8BI28aIeFrla5+qUOFhSNz7IeZwqAF1/i0iUqHgzHoFsgv7DJUk+J/snoTorHnRbb6WgWNJZA+jCkmZmwGjAGYtBdtCVqRCFpNtyukcs0X1KpPDlCuogyqDvdVU3D9nh5E3Z+PcuyxS3dETlFJ+C+TbnpTotf0+fTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995937; c=relaxed/simple;
	bh=yvpoPBQOelwOm847kwi0+O4gZ/1KvyQbOdJn1SmPyt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqx4sv9ayu5bEmP++OnUt3TNaj4U4n/TyMoKRbqdVPtBKHuxF6+GihOuzj8AjZ+dhnVgWTi0ld2lmhiMAl6NNV5D8MormgX3YMah/QeJjZvpK0TRW6FEh9Jf2CnoUBENzs7KkHb/k+zDnsjpEKdMAewSnOz1un/xDWBt+P91Cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd0p5Nf3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-307bc125e2eso1565641fa.3;
        Wed, 19 Feb 2025 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739995933; x=1740600733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=neQSskfwyREar5ANcNe3kBzHKLTcu2V5yytBDjdfqoQ=;
        b=Cd0p5Nf3MhxG4qK6J8ive3w6WmVWKWQa3bGJH0gVqebVAMHTL786K9Ox7tKiXwHXb8
         ObtlVx71xaROshW1E7PiAe0hmT/sumI+Qpqt03UD0r7cjg18frWGryhweSf9E0ogJ1M2
         aJSO1LxXBSGxDi4Xq2EW1RlZHRadtv+BKXF5tdLlHnDTswisAzmG4rc4qvmEDOr92vMU
         DgEzYE7xXw18klIiI6+uunInSol52yMkHdwY0LH7eFAeBx9qrI32cuULwg5wkRy7AQxd
         cD77Ppr7dVONcxv+AYqWR88tR3iicB94aSnlEnor02VhsJO6VH2KKhpKKuDBeNae2ggQ
         o4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739995933; x=1740600733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neQSskfwyREar5ANcNe3kBzHKLTcu2V5yytBDjdfqoQ=;
        b=mYFD3nvf1lAsN53M3hJOzWYck/JOBoouiKPyOJPCCrukKrGvRZPXWcSPvL3O+TzqTi
         VMtJJbHyt6Ts6gISnmrYi7QpF98eQ9MxyRZvnqcoIUwdtL0WjM2R3Y/sFlqUVKv9VDqr
         KfJt+nrPJ4OsGkHTtVGnDgNDycg24ftji2T+OQZpGlZ+jF3GxFmtg+6yQi1M6wn8/8WU
         SFShzOwMi9yswM5l+j4TZb2B+0yh5ntctbanKKc/LAxTIhSvsreXTjUyfQmnWla2ziqM
         NOkaqus7UWrCcaMraLlIO1nIxQdb3jysPV6r4rKAHJMCK+csGWmkLPXX90wDM2pGQm6Z
         NyjA==
X-Forwarded-Encrypted: i=1; AJvYcCVYkYpnvK/tK7mO0VKA55pyD//qlaf2XGbBvXdC0Ofbsx1AfNdBXw6HxCt5kl5R1x7ZBcV/hnVmnHqbkhM7bmM=@vger.kernel.org, AJvYcCWCICnqtQ4TBYp70g6WA1mNvVd+qcYzbdqCbDWhbXIQ3RkK2JI9JXhuzwJZBk10INXFtCCno86RaUccPHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzihGIGT0m1nVqckKxD2p67JltKYgr/qH9j3cbR9PWzq6QSANY2
	bkGrfn+JdOtsL3adOzstQEFvRIHD5fpl2tRSJCHbnu52pxlMEJRyP8OVCifjzx9P+NQCNd5PxKl
	/d+SPIlpsGIZPcaWShZ6HVQogtgE=
X-Gm-Gg: ASbGncskM+E54pxTRZ9A9QhfrH4//tRy7s1mITb3pJEZ6utD8Wt24x82y4a+RsYva1/
	Zbo8u32EBAUd2bgemoe3QmiFSL6Lmgft+IJHntsqqs84noOhn8rJGeRz1YAXWbreoWs46Iz0=
X-Google-Smtp-Source: AGHT+IERkudwXdnctKCgwhQh5wIiHi3K6oTUjfFkhMs7gAVx3ULMl2XN8GGFtfg5cPmz9EyULRsi8kFR1EpVe7rcdLc=
X-Received: by 2002:a2e:9802:0:b0:306:10d6:28a5 with SMTP id
 38308e7fff4ca-30927a57955mr54400011fa.1.1739995933190; Wed, 19 Feb 2025
 12:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <20250217-nova_timer-v1-1-78c5ace2d987@nvidia.com> <C1FF4314-C013-4AE1-A94E-444AFACDB4AC@collabora.com>
 <D7VLMD31YB0V.OKHDSVUPAZTE@nvidia.com> <1b8921d46f7d70c7467ea0940d60220f05cccc5d.camel@nvidia.com>
 <D7W119MHCCWH.IS600FTIOV8O@nvidia.com>
In-Reply-To: <D7W119MHCCWH.IS600FTIOV8O@nvidia.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Wed, 19 Feb 2025 21:11:37 +0100
X-Gm-Features: AWEUYZlZ1YDFSsTTD8a_D8x7UaFQgtz2z5a-DCduNTwEVhrCsa7kpu99tLk_xgE
Message-ID: <CAA76j92DXbCrMoW1sta32TS5nnbTrgyXoOH=twwFeO1bzo-gSA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] rust: add useful ops for u64
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>, 
	"daniel.almeida@collabora.com" <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dakr@kernel.org" <dakr@kernel.org>, 
	"airlied@gmail.com" <airlied@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

> Actually. How about adding methods to this trait that return either
> component?
>
>   let some_u32 = some_u64.high_half();
>   let another_u32 = some_u64.low_half();
>
> These should be used most of the times, and using destructuring/tuple
> would only be useful for a few select cases.
>

Indeed very nice!

