Return-Path: <linux-kernel+bounces-554718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E98A59B83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B360169144
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA4235364;
	Mon, 10 Mar 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e9YzPdcR"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AA230BFA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624990; cv=none; b=JcfaiuqeblDXgPtgK30g8ykjPqoBd9XWtp7emXMrzN1984RSc2iOtovn+sKwHDnT5RWVtYn65Rjj4YmFgUyvCdgAcxMk/u/OBgHkuf7HBPrU9LjIMLhTXCnDHNMnJD5GqGvqAnXnjMGUKc66p95xW0mFgOJMR/aChPoZeXuQkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624990; c=relaxed/simple;
	bh=KeJ1RRzvTqUvULwTdyZYl5//YQOn9JBoSQ1imwwbGMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXi0kTQlWKV2cU9QeiJliNEr2pCwFqBlf1xS99RhKkfxO6lKzOEXV1piIRUuJG4tNbzxUIaWgIzimFuwUV348atBbEAaWwCwDpkQ37Lan2K2+Ma4RT5xCT5CaodotT9yGQT8QtKFWSOm4g5GyLHo6S74f5U86rWA7L14O0Zg2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e9YzPdcR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47698757053so3183551cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741624986; x=1742229786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7+xCb6XzG3joR6a4M5865iGYkCdDkI6eexc4SK+HB0=;
        b=e9YzPdcR3SFGD+bZJnuWgXoRnN1teJnbhbLGJ02CMSZV/2Sh/iFUP1vtA+FZICDd1h
         /ojuL8ALW2tgQyVBsfq+shE/L2G1YWwcfx7MgSnvikhjzOwwSlt663tDAohogz99P02b
         RdYm8pHf0JncWM8AzIv+qaLfAktzdvfUkyHtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741624986; x=1742229786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7+xCb6XzG3joR6a4M5865iGYkCdDkI6eexc4SK+HB0=;
        b=LrGOtEqqqJqEW39OGehYH4yaRsSDZXgNgl/x+phG2DpfG9YYjZwKQzO88n88ZSgJ51
         oM8lyhqLPEkuwXBNpBKP9iAJ5Xd1Ywi2DlOHaMBC0ALLmIpNh1BImHK/NKEFeumCmVCM
         vi5b/bp98Jp6tIyo9ggx2KK4cNtgPTGLZs0izYGJ7I73dpAtmSW3rFCcrQ7sMgJ8J7vw
         xs4DvOpy7xOtlfk56zmivwZr/8bUR2rYsGLffpCm2rYsQH6oTjHNFIM2yw9TURUzxVFJ
         z8ussrINb0UsNqvNsghFj0vJAZZTkes1q3eEnHMqIgdSAoyytcDwzzzE9y+/UNSehyo1
         o1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO5LGN8IHwKvX/fyDbbo7fm1VhlCWidqF42wIURZ3rXPgUhEAXQuYZlzuqaoypzmpNO9LDVzRRGCPT/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2R8FQ7s8WJks9Ia+eJO3NHaZbTlHeSgEFrZxS2W2awUC7gC3
	zo9RmXwFP5ZLoU4PisGFuB0uX55FzD//jC5KGZkR5rHV2/kvZIBuSeXzhXBa/0h1KOW5rLIcpHl
	GXZ/yIDe+3uL1g+LJWXwivtl12YJX8ekJ8SHFI0at2aYqQ57bhrA=
X-Gm-Gg: ASbGnctOBPiaJaXZvoPPQ1kjv6tkaC8eJktLmLxsBebWOvlm+f+uTvlAstdooTdsWW8
	2wWamPLqjAInJNXzhUCJ9ceWFHjFo9TtqQAFFBnvSqvE7Gn8p03ZWfYWsxhs4bo0DX0xSnftUd4
	wMUP4qWjxmHigGp5FF6HXju/rECUs=
X-Google-Smtp-Source: AGHT+IEBIzx9e6K8gY1P3uwG4053vKnCQo/A/45CHTp4TpCwHW2p6fOzKlu/gMvt4iEwPXinaX6bmM7d+7zufNH5siI=
X-Received: by 2002:ac8:5a4e:0:b0:476:959b:7592 with SMTP id
 d75a77b69052e-476959b7aadmr25117691cf.17.1741624986587; Mon, 10 Mar 2025
 09:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226091451.11899-1-luis@igalia.com> <87msdwrh72.fsf@igalia.com>
In-Reply-To: <87msdwrh72.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Mar 2025 17:42:53 +0100
X-Gm-Features: AQ5f1JqEE_1WaqbsqdDTMPa4eJILmqSWGchDRmitOQV2dELsrChoGlHoLVS5zaw
Message-ID: <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation behaviour
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:

> Any further feedback on this patch, or is it already OK for being merged?

The patch looks okay.  I have ideas about improving the name, but that can wait.

What I think is still needed is an actual use case with performance numbers.

> And what about the extra call to shrink_dcache_sb(), do you think that
> would that be acceptable?  Maybe that could be conditional, by for example
> setting a flag.

My wish would be a more generic "garbage collection" mechanism that
would collect stale cache entries and get rid of them in the
background.  Doing that synchronously doesn't really make sense, IMO.

But that can be done independently of this patch, obviously.

Thanks,
Miklos

