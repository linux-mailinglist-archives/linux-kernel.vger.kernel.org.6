Return-Path: <linux-kernel+bounces-368701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3589A13AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF6C1C22144
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7262210195;
	Wed, 16 Oct 2024 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="M/0VmudM"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DB18BC33
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109864; cv=none; b=YGK0CY/O8TUl/r0jgFuZJ7hGLUngV5fRUzMBkc/aivVvnUbq0RdlzpD4Tsnb7MlrkDyX4XgCpdgUbD15WEsIyMmvjbhaWia2fwd8O+TVO/00kjaD/Ht9qs/xVIK9UMWSelTrTFxXvgz/YQmHc5kqVKeMuIjk63sP0xY5yiFXEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109864; c=relaxed/simple;
	bh=0F3memFK2IqEIyDZRhf1ZtxUtPaa69HplF1wyp2YAb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kk8Z23GHeEOKr93qZwaZqi4oCzA4GE3csx9QAykHVl850VKISctoRWN42RPmmXt0MtoMTEdqN65iB/2qFxirghxtUgFzjpef/HR1hvBsu3ND85nXVYsMdgl0HGznc4Sro1NOZ8B0Db4iMHiDbD8K/BJK55GWLsJwKm6E5MASiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=M/0VmudM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so1781266d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1729109860; x=1729714660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0F3memFK2IqEIyDZRhf1ZtxUtPaa69HplF1wyp2YAb4=;
        b=M/0VmudM2+4g7UxCLx6G6O5Dmzd4F8gWNuXILkSxEV615ADFOEA51AYKpNQWejENW6
         IV2lPQwKKeQbwKqHJPphx7wJK+IlHr1L43kZYcH+4l8nSRWQgFB72wmXMPlhKHYYhHmH
         NGp4YAqGWdQy6X8hiSjFhz/dg5vNvGeWQO1/+3P5LpsKxweIU3ARCdt57uP0/0mXsxag
         EotlGWr64xU9ManROXCxEnSt1xlNlKVZRmiMzaX+vJPhRJTHdjgxAhS3UKkTHXpuYviL
         cSAYMR0Iacy9VIvdbiMm3mdUUUauZnAjsqqtAuFNmGIWYH/p/a8LMtR09yKgF1rlrgpB
         He1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109860; x=1729714660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F3memFK2IqEIyDZRhf1ZtxUtPaa69HplF1wyp2YAb4=;
        b=meerg7QVtqg33CcKQvgTPt0yVLemprmiULRNRcPlfkGe3ltUGxCRmA5CSAGGtruBpt
         TQ9fy+KNhYR3ccyzw15EQeqyG9oAIwSe3H8Ob7Vx8jfRlABTt416Dbq3UtgL/8am+vdb
         +Hm9y43RjdAFNUouO5KhOJp5Mk4Lr93UtSg2gUAz84UFbamZlf9XQ4DzYmSvrV153C4e
         mqXbovGg2icNfcmiqaHPzj39dcAGHYOMM7uPz7RGng6SuycEPd7ez1VqJT3yCuaj+XuU
         fPCD8t7WGHU8nWtqBtr2oBsQSfrf/NXerHbz4Tm6DBs5b/iAeMVkNJGQiz0pVpBoeWQ6
         YJlA==
X-Forwarded-Encrypted: i=1; AJvYcCVDspbhYPFBKwZrPrLLN6sQ+spKPU9RdlhCVXMCQLfcHv9ksnoYQd8BvXuGij02Z8w27mE3N3Xcv1b3krQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJx5Hdnr9MK/y5AXC0W3Ir16yOHU5qlBTbEedboPxkIwNggFk
	Osg3IKNCzHxE2pYhIl8xp2Ai5sHnRxXuD35omo/nCDcUUhEf+vRUMZdFWWtr8dIH4SLaYen5tPi
	JTAbgvoy647b24B880hqmdvtxdgj4vkGo6jDvgA==
X-Google-Smtp-Source: AGHT+IH8FdORu8BAVMYETQ3EFP7GdnSBr3/OY9F2kRda3SXcmSTFgN1GFVyxcQE38MPpmTDwMWhcvAQ5OacfMETt+rA=
X-Received: by 2002:a0c:fbc1:0:b0:6cb:fb58:3d23 with SMTP id
 6a1803df08f44-6cbfb583dccmr188633316d6.43.1729109860038; Wed, 16 Oct 2024
 13:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014222022.571819-4-pZ010001011111@proton.me>
 <7b45f190.452f.1928e41b746.Coremail.andyshrk@163.com> <o_Cyz_ARcHj4zNlovv75MBwslIRhn3YWlscoNrlpLVobh7eWIMEQR5bNv0yhHx2KEx_gbYi_gH-8Y-CdvRZs9lZscz3-lhAbM50GXUdtSKY=@proton.me>
 <30940542.b36d.19290215124.Coremail.andyshrk@163.com> <1974DYrs9gLrQrZ5VwCglFgKDDK686iyqnS_g6uPB-s9wZ_4CqfZXPjmYWihLgrkRu7ptNjpkFeqB0uTt73RFId6cL8FowQ8LFltPmaKCoI=@proton.me>
 <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com> <CAPj87rOmPyat12S4WUixiUBAsuAEEbyNX5VY2JS+wn5a1jux0A@mail.gmail.com>
 <kYKfHO8oonY1wP8ZvanmTnvgjGfw0uek8cmMIV99Bc6zO3EE32B2LKaypAphAxVJKx2I-Lnd3CzvyTRVAaM4xhj75z7dOzlp7xPMlFQKRN0=@proton.me>
In-Reply-To: <kYKfHO8oonY1wP8ZvanmTnvgjGfw0uek8cmMIV99Bc6zO3EE32B2LKaypAphAxVJKx2I-Lnd3CzvyTRVAaM4xhj75z7dOzlp7xPMlFQKRN0=@proton.me>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 16 Oct 2024 21:17:28 +0100
Message-ID: <CAPj87rOdQPsuH9qB_ZLfC9S=cO2noNi1mOGW0ZmQ6SHCugb9=w@mail.gmail.com>
Subject: Re: Re:Re:[PATCH v5] rockchip/drm: vop2: add support for gamma LUT
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Andy Yan <andyshrk@163.com>, hjc@rock-chips.com, heiko@sntech.de, 
	andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, Dragan Simic <dsimic@manjaro.org>, 
	Diederik de Haas <didi.debian@cknow.org>
Content-Type: text/plain; charset="UTF-8"

Hi Piotr,

On Wed, 16 Oct 2024 at 20:19, Piotr Zalewski <pZ010001011111@proton.me> wrote:
> On Wednesday, October 16th, 2024 at 2:27 PM, Daniel Stone <daniel@fooishbar.org> wrote:
> > 1 is the only solution that can work. Silently changing the colour
> > properties of a separate CRTC is not OK, since this can lead to
> > displaying incorrect content.
>
> Ok right kernel keeps track of the state and sees gamma as enabled even if
> dsp lut en bit was cleared.
>
> Would it be better to check if gamma is already enabled on another CRTC in
> atomic_check rather than atomic_begin/atomic_flush (and silently fail) like
> in[1]?

Yes please, that's exactly it. If userspace requests something that
can't be done, then fail the request.

Cheers,
Daniel

