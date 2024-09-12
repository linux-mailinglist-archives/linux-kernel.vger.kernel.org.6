Return-Path: <linux-kernel+bounces-326908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D557976E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4F21F22150
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FF13B586;
	Thu, 12 Sep 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iyG5zw/s"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8C7DA7D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157033; cv=none; b=soisq/wTLafcBSHqNarWJoX8s16XFK8W06Wuj8PfviHMq/9tg1IiU37wXDT1GdoymnwwDERknDyX8hglRexMrq4zvw9xlrkClbG5O21MY7aU2Vj9yypbxA+T72fKtx7Z4KTZzRzG+tNlD3f65bw0BQsZX0ZZvgiB4EHaECncKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157033; c=relaxed/simple;
	bh=CrCjW0ic6Db+J3kjsTPKwgfDJbBARSVIXo7Ekp4qkxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuM85qdyqTWjgR3oRWPF9qpio25phP5dUPaMnm0Te2E9+1wJ3/8Wh1Skf39fT6PdrGnDOhK/Qhd79iX0d7sPM5hbh3iWg3VeGD7idkag9yDWLfBqvHhwQvb8Ycnj+ec14t5hgLlnZebPa+uOXIeRiwaY8BwozWAlpdkhH8P/Bzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iyG5zw/s; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582b71df40so273681cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726157031; x=1726761831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrCjW0ic6Db+J3kjsTPKwgfDJbBARSVIXo7Ekp4qkxU=;
        b=iyG5zw/swZ2SxLcuhbOFs/Dap9n+IgEw11eDDj6pTWSoECIK8gQTLOa+BuA2R5/6Fa
         +kxUWCGgSGIrwnfjxT3kBdN6Eo+okVvGCCxdV8Y2idOVORdIvAav0wYZRVqstD0fuLop
         tSS6G/QjOc5HKiL0Tx14Ah6c2pucvt6BVpH7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157031; x=1726761831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrCjW0ic6Db+J3kjsTPKwgfDJbBARSVIXo7Ekp4qkxU=;
        b=LvI8TF7yKwinRXU+iXMVajePqlgqZg4CJAEccgckNropE40H645hmwiIy/YDv6I85J
         MYSD+EqClWSFVwThUaPJuzyL8VOUg1YeUq2bG8KimclWFIdAqbxBSozvk+MZowbV83qQ
         EzrVCZbUqjSy+RLz8J9hUwTTo4rYWXeYVVyF7ECDUfhsAPxhWQYM1HIURajmrgpgsRvS
         pOyMCTC2+kJXrGmEGV/AQNq/W81dvQFiqXcbXhrzItxk5/bK16JnkhxKhCq9k7nbjNf7
         uMkEN15qfZEqVH2rzFTpyaDL+ydaUmT9TLTuh0iiBCWOwwn/xVbu8wnVQb58qJBWrUll
         NlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmBJoq3odfivNXC+gnyTVWNFujPG9xHvUM1rQV25ZXR/hgjwVbkb+TQvSu/WpXK5Alq2htuPbeTLfDwjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hDG0zx009J7a8Co2xoXZTUe7WABBJEOVFBztE8kMRwGRYPss
	VDymsXXXwbqaLehYyzK5txbe8sOyBS4aRxT9bf6oR3l75cJL5VDnvG2DKS3VKnxZg9uQNF0s/K+
	GbEp5CX6sDEkvkGsIBMhVWZE/r51leLlmeevo
X-Google-Smtp-Source: AGHT+IFQu3yAL5DEk7oQCeXw0JvR4PFs6pcDDf5vf1OMase0DRLjYTPZIp+SdT/fDhzrb2YiYvR+LjfvMad1ROIciKA=
X-Received: by 2002:ac8:5845:0:b0:453:5f2f:d5d2 with SMTP id
 d75a77b69052e-45864403792mr2236481cf.1.1726157030402; Thu, 12 Sep 2024
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
 <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local> <ZuCGkjoxKxpnhEh6@google.com>
 <87jzfhayul.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87jzfhayul.fsf@minerva.mail-host-address-is-not-set>
From: Julius Werner <jwerner@chromium.org>
Date: Thu, 12 Sep 2024 09:03:34 -0700
Message-ID: <CAODwPW8P+jcF0erUph5XyWoyQgLFbZWxEM6Ygi_LFCCTLmH89Q@mail.gmail.com>
Subject: Re: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate
 device name "simple-framebuffer.0"
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>, Borislav Petkov <bp@alien8.de>, 
	Hugues Bruant <hugues.bruant@gmail.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Tony Luck <tony.luck@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Julius Werner <jwerner@chromium.org>, chrome-platform@lists.linux.dev, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

> On Coreboot platforms, a system framebuffer may be provided to the Linux
> kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
> it seems SeaBIOS payload can also provide a VGA mode in the boot params.
>
> [...]
>
> To prevent the issue, make the framebuffer_core driver to disable sysfb
> if there is system framebuffer data in the Coreboot table. That way only
> this driver will register a device and sysfb would not attempt to do it
> (or remove its registered device if was already executed before).

I wonder if the priority should be the other way around? coreboot's
framebuffer is generally only valid when coreboot exits to the payload
(e.g. SeaBIOS). Only if the payload doesn't touch the display
controller or if there is no payload and coreboot directly hands off
to a kernel does the kernel driver for LB_TAG_FRAMEBUFFER make sense.
But if there is some other framebuffer information passed to the
kernel from a firmware component running after coreboot, most likely
that one is more up to date and the framebuffer described by the
coreboot table doesn't work anymore (because the payload usually
doesn't modify the coreboot tables again, even if it changes hardware
state). So if there are two drivers fighting over which firmware
framebuffer description is the correct one, the coreboot driver should
probably give way.

