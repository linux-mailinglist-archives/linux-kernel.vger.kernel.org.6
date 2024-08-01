Return-Path: <linux-kernel+bounces-271924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD2D945505
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE98F1C211EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539F14D451;
	Thu,  1 Aug 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW/gi4Ha"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81813E04C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556286; cv=none; b=F2huHtVvIAT31DnV+RtEeTqpsW9i8tJs48O7Eq0zEIQNmsSOvSkW/I34xP+L6THF/PusThB7V7koAM922aX/IoGD9VE2gFW0EqYB6f1HJOxOmqFDuvvH+EaIJ55Ubj498RvcavNhZiCR6Kb63QRmx8tQegZVDmS5MFLCBkUvA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556286; c=relaxed/simple;
	bh=eQxlU8eev6jnNRcfA4wEA1+aQibw5bEMR3sThiTngOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=bNqPuPDpzPcnCm9jGte3lL1rLzpF1SEGFhCku499gfH62Kd2iQz8XYxByYDYoPS2ENlKWwLiiz+IwXmB7SZnbJKGcR8hlxcdi52Usy7z23Nw9+qxJ5tlfsDFMNeGOdDduPASTS2G8Nz1mR0R9DMh9TH3w7PGxg3XYKiJmZvahJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW/gi4Ha; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db15b4243dso4685003b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722556284; x=1723161084; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFvxalt/XnEivZ3koHVdSp/ZabV80Phmkm5THmVQQjw=;
        b=PW/gi4HaNbtOa2x/dOWB0Q/L9Nd+u4FxRG11O3xfx315aaXI6bBTmV1WXtyPV7hFny
         nlePURhuzmZWQUCeZxn4yJ0EgEfp+8QsDqWAMT4NYjVxb//ACH5rpjysiG+MJvV4UWcd
         oIiyNSO1WXR8TVCtLpsW7bvorA+zwDnjyif8xXvCK3BAu8VqqWQhFUvMZwXjsouYWCDm
         jvZmt1MLT1GjseKdf/J5TzF/CGZwALt1tSlMOihXd64SYvfX5zlkc34ofGLS7FBsEVvx
         rjnD2Te7MROB//YzjyhLbzbgnbXK9+U/Bk/qwNe+24QalRSDr5TELrnkYQUTV764rHfg
         ElTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722556284; x=1723161084;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFvxalt/XnEivZ3koHVdSp/ZabV80Phmkm5THmVQQjw=;
        b=iYe2QRFN/nfhzT7DCmOkUlj6kGr0kwsDDZNJ6G7ehxb27DIBaPfkkK629UYPXQRBaa
         yvGr7eHYWW+htXYVPm84RNnQvLRYQvWYEdFRQf/SA0+IotoZZU8OncnAiB+oCyTLlDpC
         inLZASckZhHW2+gWKocUo/WpxFWgm8/OnyQyI6qLCt+BwKFQ2Ms07IhoIRPLpMTyoFhg
         HA1Qtd/CD0Q9HGuPqnXnng1DWIra8HL8BozbBDGs5N/P/LkYKjR9eDQVnRS68L3H2f3v
         nfnC60qAn3q8Yo10gW7gM9qmlOnf01+oALww1F5ufN+CiAr6K3SMHEKkxCDrEcTlhWB1
         aLuA==
X-Forwarded-Encrypted: i=1; AJvYcCWuposnlZpeJdDN3jXcy3t+xAdTZJEGgw86Dje/lpHxbgxUuLF5Pl4Zbwzg7A+PTTEWIieVYm2VCUbvEzDhL8sV1xwiJJEY3NSz5vJV
X-Gm-Message-State: AOJu0YxmhVhcDhqU05YOjpiiYpdUlFKOqEzATwSyI7sbOjcrsXgNbRQU
	zWq2BoQ6ioYTOZqe3YAoH3vPgi0mKequyHwA26lElCFRHZFkLspb
X-Google-Smtp-Source: AGHT+IFp+HAXtD80ma1JW7fWpZEAfu1UxylcH/V8Gkor3GmgdWTjRnkqijderz6r7js15Ahq4tepFw==
X-Received: by 2002:a05:6808:1b06:b0:3d9:dabc:7b76 with SMTP id 5614622812f47-3db5580ed1cmr2073787b6e.23.1722556284261;
        Thu, 01 Aug 2024 16:51:24 -0700 (PDT)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763945c05sm308998a12.49.2024.08.01.16.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:51:23 -0700 (PDT)
Received: from jro by jrotkm2 id 1sZfZq-0001LY-0W ;
	Fri, 02 Aug 2024 08:51:22 +0900
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    linux-kernel@vger.kernel.org, kernel-team@android.com,
    Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
    Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <Zqu2_OvnXIrCMMu8@google.com>
References: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp> <20240723164018.2489615-1-cmllamas@google.com> <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org> <Zqu2_OvnXIrCMMu8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5177.1722556282.1@jrotkm2>
Date: Fri, 02 Aug 2024 08:51:22 +0900
Message-ID: <5178.1722556282@jrotkm2>

Carlos Llamas:
> I simply dug up this patch from J.R. which avoids the BUILD_BUG_ON(),
> but perhaps someone should limit the rest of the configs? In practice,
> nobody should be using these 30 bit shifts.

I posted the patch in 2021. It was against the commit in v5.13-rc1,
        5dc33592e9553 2021-04-05 lockdep: Allow tuning tracing capacity constants.
It is a little surprise for me that you could pick up such old post.

As I wrote in the old post
	https://lore.kernel.org/all/30795.1620913191@jrobl/
	I don't know what this 'multiply by 5' means and why
	ARRAY_SIZE(chain_hlocks) is limited to (1UL << 24)
And the post is just to silence BUILD_BUG_ON().
There are a few more "range 10 30" in lib/Kconfig.debug.


> > btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
> > bitsize?  Maybe "bit shift count for..." or such.
>
> Indeed that is odd. I'm also not sure what to make of the "*5" magic
> number. I suppose it could be the typical lock depth? I could try to
> clarify these points, if no one with more insight wants to do it.

Also the original text comes from the commit in v5.13-rc1.


J. R. Okajima

