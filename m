Return-Path: <linux-kernel+bounces-547323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8FA505DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D967A67FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715FE19C542;
	Wed,  5 Mar 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwdZiYrg"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCC13E40F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194121; cv=none; b=hW1n1KhC2Up/4X12vTd0yKV7qnCgTSA7SNDoQZfCvvoDjZ9TfIiurdg6FnKqYfeImoxa9XyfrQR8E6Om6S0/+dUGEauvA6RCdtWsY/Yba7h2ZLeO9kSXwFSEQln2GAN6k7ZQq0mJa13EwumlkdoccmKx0evmSeb9DaBi9BvyH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194121; c=relaxed/simple;
	bh=0Bhr4XbwRS2+cz/YqlWTUSlf82o+LZmI2zOueoUHLvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0JsnMt3rnjImSI+bLdNWoNIbPGBuahNZMl/GhrlkrBofVp8HbTXA4ULz/QA4LuuW67T85HZTAXftKbcrRWlpudp56WW/Xi/6NncPGzhUuLDVb0GecOc1sdUKp8zSwWsAvFIywOudWVzx/hYNPJA3z7p/p3SUibAnF2w8HS9+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwdZiYrg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22337bc9ac3so135586715ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741194120; x=1741798920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyWbothfZd1bcluLctR/Ux9lghnizMSrLEoQvObjK0o=;
        b=kwdZiYrgpHGOeZuFOj2slPwbLAR5QRVVBenmIj+f8kTdUV0aFfvBI65CqoQiLb3xxe
         RtB+9o8vWzqWGIhiKHIMi9/PfIWUn2T8d1Y1OLYCIA7zv61ohCazSYlgRrPvxwp03Fc3
         mqxPCcSVL3LcE6ww6Ie7GB/CHjVvOuH9f3PGngosbnlhl32fuWCX8z9GbgrbU8rmSefe
         cT4CLSWfvIzm67NeKr36L4bpwbpDaUeB7hRb65Vt6ohRya+Dvw8PH09bC6vYLVr8GGfO
         7mJU6l3iENwTWIbWcvOXg9zDGsngXttp8EojmwQ+eqOsGY/2GQHvoHgmhGDwmp3Rx5m3
         enWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194120; x=1741798920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyWbothfZd1bcluLctR/Ux9lghnizMSrLEoQvObjK0o=;
        b=mOHN9fp2VarSrF1RaAX267gjrhqGn2m0hmumyInHcE7LgsrpbfLYhAHBu7AYgyGVrt
         iC4zzjy7fEwMezQwnUerJVTPko5kHNdkOl2LveMsq9dd3FUyAdYE/OmWu1FesOEtRaAA
         ff4Sf1v30+wo4c8074JWIfkb1jUn+Jwqy2B8443JTiCkfol8D35KDGBLMnZ0vGHjL/T1
         vVv2DGIw0j86mnJhHEf3y3UTt7bMlP9cEbMI724Tl3iwQAywJ3AtrSFHCNwdLhy+9hG0
         aqODfo2Izxa/AiuTbJBzXzKHi35UTkMUo5kOSX3HyKwKj6t+DTr9VGmNt/ZtkP/fZRYs
         gPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMPkdzTccKDPUhLvxxa87anqfYw1qxfGSgOK1el0EEFrHG7OB3NAavmZbQ2nEaHXeUn2h0zazZCbAXyhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rltXBaLujdEkidu9MFJ2t5F6+TWo0RD0VR0CRgxwCroVHPEf
	G24036gd8Awrzno07OcFCvSVr5jSmCdRnW8IrLPACcRD3rPUHt2E
X-Gm-Gg: ASbGnctbWFS6Kss8sjrmgpAH1MrzV/IdfSzgFwYvREZStW409KjTDq7ep7akYVwmQ7W
	bcRGK8H0Ji/NH78oTxEgJHMC52OxpKWBNibvtlbRQMEmioxvBKBIBA+VgClvbWTYWUcpgn/udVw
	uPvx2R7YKWE7oBLlFcLmjgRW85D+qqFaDV7+MGqgvvn5FXWwVln4k4ncQsIJXm1mEoihHYck2g/
	wIh3n9T8pHZ2vCYovJXJmqegLnpXlpkLAvtI9jljRe5ae3zRuWBDpjpOL7A3tVDoEEZQlVjj01w
	4r9YKzIuMpzULw6nZFV/5NybOmdYR7+YhBQjtmfI0vdt
X-Google-Smtp-Source: AGHT+IEdd0vgUh+r7YPOM5fhDhk5XGta2CQglz8Jmrwm+i3pgNxm42dA9lNli6yOoci9ruCCYm8XOQ==
X-Received: by 2002:a17:902:d50c:b0:223:325c:89f6 with SMTP id d9443c01a7336-223f1c67dacmr58123325ad.10.1741194119752;
        Wed, 05 Mar 2025 09:01:59 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9d7fsm116141315ad.70.2025.03.05.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:01:58 -0800 (PST)
Date: Wed, 5 Mar 2025 12:01:56 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] treewide: fix typo 'unsigned __init128' -> 'unsigned
 __int128'
Message-ID: <Z8iDhOraVJgaMD9N@thinkpad>
References: <20250305-fix_init128_typo-v1-1-cbe5b8e54e7d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fix_init128_typo-v1-1-cbe5b8e54e7d@wanadoo.fr>

On Wed, Mar 05, 2025 at 11:59:32PM +0900, Vincent Mailhol wrote:
> "int" was misspelled as "init" the code comments in the bits.h and
> const.h files. Fix the typo.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Applied, thanks!

