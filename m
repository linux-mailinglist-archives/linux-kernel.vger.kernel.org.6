Return-Path: <linux-kernel+bounces-174180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F168C0B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302B31C2230F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF31494C9;
	Thu,  9 May 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xidul/9/"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873938DE8
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235192; cv=none; b=rXUPJIFxfJcaJIivVnA373FO2mHoCR2ZWwExcUA5AlpPeig/BY6s5BW/YznCXKHZ8/7KHJxT9Y9pHVDmK+x15CQ2pc40U2VU2mEdEnaoSlQ3FpIX32kXuqT84pKNDrkmKNFwkhTQkCll/Rj7TrNvZSH99moCT8JwRqlVdXPwc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235192; c=relaxed/simple;
	bh=5sxmFsI2pvyRDZT2dBR9z4g7uJi8JaMwokUE63AQ8qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQ2B4SbnDswFzpdvkwlfX+LoyIOTopXp2xzRDOOriXw4cLcf/pe9luSS/2W0xj1BaRgTs9+BB406WNduUiaEoXx8kRyEbArw20ckQUW3O9L2yE9247g/3r1qpTiHwPvKswZ8UqJcW7ONiArAwYbfCq4qLtLCF02OWu8I4NFHQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xidul/9/; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4df29c84f60so319370e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715235190; x=1715839990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F6BKpRJQNg/VL1hLJe69exk1Y5QwBVu9m/6Ynps7qA=;
        b=Xidul/9/7jFGeiWFClcmNw3/bDjh8ITYhGPRWiORj2UKsqiYSNCKNl9Tfio3Mydg6X
         0Ot4KPf3kozAfS68tqaSobz0QO7flin2XOvHsJoAlZrZUVhg8TAB1Qgx/0ARqjupsA2a
         x/cl63Bd8mSl+f/wAaGWEN3RR1QLMgozKt7gWo1azXT53AuOqCZbwvy14NVOcC4HQ/eX
         gqNj3ZumhH+rEwRFTMMhsVptaQ4RIv6Sh7hg70YTl6kvDNoAqRSji2QFidQpDjlXeCWr
         DAvLJpPTcuyQuNrngSUnSf585B3izK/BDN72+3LCo+/EtFN9tKAwuKgvZlJGEDfXb/kx
         sS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235190; x=1715839990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F6BKpRJQNg/VL1hLJe69exk1Y5QwBVu9m/6Ynps7qA=;
        b=R8vE8b9TdvZTbNJ+rlRkzEZ32Vmo1XSah51HsMDKuwugLYT//wL39XuPU6m11ppZ8D
         ivO5PARsNQ3t6n8L2fG62rbSOxfMNHFf6BJ3NeXrYH8fMbprCDRDkxt3Vz9O246Sf6S5
         jQ6Iw8ElHrznNKrYBOvSVHoiDRON45IOVKJkhXSShE3bWCFpiZuEoajR31f9EgDaEVnW
         aKZMrwHIluuIw/x6EMHE3p/Cpsu5Vo6Xj0g7/fj+Zf5JKM4lw4zaNMKz2D1ZnEhz3DQ9
         D5mo2u/OTQD55BgcnjigKBLehAdqMbvQVRAiY7C1VC9wnyP1Qgy1cN7Pp3L7qRuIQyXW
         Ebiw==
X-Forwarded-Encrypted: i=1; AJvYcCU43/TEfxSHnYpEiS0+hZ93xerFJlG3Oo+KgEc9Rhnp2kNkU1jEAV8ZmkQvXra0Dcl7pgobLA+SIGJm2qSXOtg5pr5Miwf2AnX+NdJH
X-Gm-Message-State: AOJu0Yxlc17oWYjl3WXiMWaaCb8eAh4s+oV+lAVNR13tWGs7lGojYVX5
	772vqsbG10II++j25IvYAODztdBhwwqEcXNYXuEgIsAgEnZd0KPf2ydKgl4HfRD2mwKm9DZG8d5
	+jbN4yz09GGYV+Vw0WUXWm+luTJo=
X-Google-Smtp-Source: AGHT+IGVdIq1ZWy7m4bpS8XSGo5Gde81s0E0aZg6rWvS3bVTSyhJlxf/E2s0PdrLPIq/d/NF1HRPZWnhBfATpEVIiBM=
X-Received: by 2002:a05:6122:2504:b0:4b9:e8bd:3b2 with SMTP id
 71dfb90a1353d-4df78edca00mr1587765e0c.2.1715235189744; Wed, 08 May 2024
 23:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com> <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <ZjxWkleEdk5iUxI8@infradead.org>
In-Reply-To: <ZjxWkleEdk5iUxI8@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 18:12:58 +1200
Message-ID: <CAGsJ_4wW-Z+H=vZ44AJZEhJA1QXgoBn=mN+JUYJxNCUyAadfog@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Christoph Hellwig <hch@infradead.org>
Cc: hailong.liu@oppo.com, akpm@linux-foundation.org, urezki@gmail.com, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:52=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, May 09, 2024 at 02:20:03PM +1200, Barry Song wrote:
> > reverting the fix intended to address the OOM-killer issue in commit
> > dd544141b9eb.
> > Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
>
> What is large?  When you don't allow actually use cases people will
> just reimplement it poorly.  E.g. we'd probably have to add back the
> XFS kmem_ wrappers.

Xiang gave his number 24KiB in erofs, but probably we still have some
"naughty" users allocating much more than 24KiB with NOFAIL in other
subsystems. We should never return NULL for NOFAIL.  So, in any case,
we require Hailong's patch in some form.

However, commit dd544141b9eb ("vmalloc: back off when the current task is
OOM-killed") is also tackling an issue. If we can find a way to preserve it=
s
benefits even in the NOFAIL scenario, it would be preferable, though it
seems improbable. Thus, I'm considering if we could at least include a
WARN_ON_ONCE((gfp & NOFAIL) && size > LARGE) to aid in debugging
potential issues we might encounter. Furthermore, compelling a large
allocation with NOFAIL also appears pointless, as it could lead to
unpredictable long latency.

But I don't know what the proper "LARGE" value is.

Thanks
Barry

