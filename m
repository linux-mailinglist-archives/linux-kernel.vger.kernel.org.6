Return-Path: <linux-kernel+bounces-420263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E49D77CC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DF42821BB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3913156997;
	Sun, 24 Nov 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNoCXNo6"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F22500A6;
	Sun, 24 Nov 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475702; cv=none; b=PThg8zO1kcTh9bBcTH3qQwBGhnrFHRArgvHOU5NJe/heyhMLHK2MUtZDBwwnymT4SfQpvD77gMhsudMCYsd/4cRs1qPAcMIQmBFWDSveaIHHfl8j7m9JHB+29JTgqU34ZK6omLcYTCoVN6pXiwQxytpRg2RgV+GdxIIPKh7xwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475702; c=relaxed/simple;
	bh=M8GOuipqgJxXqmzjl1wPMtDYUrY0VjibW6ZasGRWQKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDaLr1+xEvloDKRaP+qfb0h1OYR0PfNmIs+2poCBFwX1L/p8gDjOMzs5/5y5qkCtRa2Er9/HhqiZL6aZiHOpWdo/iEFqs6XulfZEMhrRMPQqsirOHuGHE1VPV6SzX4PGHk/VuFHiAXgTIsOBAXSKNIrAfaJWlmQ7muR2roidcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNoCXNo6; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ee79e82361so40244557b3.1;
        Sun, 24 Nov 2024 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732475700; x=1733080500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUcdfu20vlbQrbUIjv/kHG2vfF1hWf+xGemgGCwntLM=;
        b=LNoCXNo6hFtVH/jaGsqIrwDXnI99VnBpoyf2Xn9kUm4MyEKMzgCG8e2OXC6M/QwgGQ
         CNsl1CWmbOe5r+Xyd4Dj6bopA6wsmVz/rLifNboFkpxCDK5b+w+KxSozJQMUYfFVLAVI
         USYnfiYksgv2h8RzklKy2huB6NPAHJ4VLqq9LV38WbK48aPbsclASwF+VnKYGQEpHJpq
         C/xAwhcYuqStvpOh2b/LwSQ/s8HdHatieXAgvEQsXPfACaOioPIq+BEhyeGMqET9M5EE
         o8BhpKCk2DpUb0SUBPR+hoyM9OXpkR6OvRbUtAmCBaB5Ps5ZTA1QOq2gHd6Uk//a7rIZ
         bcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732475700; x=1733080500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUcdfu20vlbQrbUIjv/kHG2vfF1hWf+xGemgGCwntLM=;
        b=TEuBZ0cvir7+v5axSM+OJo3MZkiIC1gpvGYLegCCjd4tIJd0CZwFXy8PhX7g3L/Hii
         pRFfeJGdypQr/ufE72NCLMGpgqE9AJzSZHnhWNaXUap48P7vja9PzzCoNQ+zj9Cl5tLC
         r8BMrcfFfm1Ly3Wq1XxYGXyrrKyfDBzUgM6nKtTMeADJPxVoDCmsmhwse5iaaDliQuS/
         tAt4Cgs1dU/5II0LeBVHXESKBroaFUaEEcOWRjrZwIj76kh/VgCHP4ui3XcjQq6T99Gr
         lK7LoOEZojwNTc2/EpZVqDDFhpEiIQ/wsV9SUG1AmKVUof5MCn8QJ/PBM0E/FQr6mFTj
         cyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNdgkyo89GSMekrRFqKgAcwj/bjmburZcLWmzWWaEIVRQ6AJ7O4ZhaPHs0ESSumLZh8xGufwI3WXv2@vger.kernel.org
X-Gm-Message-State: AOJu0YwogTpApXwNYFhJ0FdH0OtP9d2OXWtfsysRbvm2RKogcSuIOIVY
	kUoeKHKQ6chI8wax2KOOTX18kMKjkLIfA5FTI8WiFVILIr3XCAPOFVaa8e8Dru53/GHdooOEN1z
	XpA9judxrbOHv3pH0n5k93GApUrY=
X-Gm-Gg: ASbGncsTmuL6KCHxBaD4AfM7Oal7SLkhsQBoOohx+xJiTNdZ9qhJi7vE7vfd+Nlczws
	n+iRnd3gItttpSZzQDBL8/KmDgdon+PbbtaSL07x7i+sw874nSXCmPcHkEvT2CUeO
X-Google-Smtp-Source: AGHT+IHKRZlUaCOi723pd97G/msekH1s8xPuV9Y+aAZNnkMkpHNkqzMOXJaL29JkY+PIZPFmh2ic6PoNXDjqv4ViCqY=
X-Received: by 2002:a05:690c:6ac8:b0:6ea:88d4:fd4f with SMTP id
 00721157ae682-6eee0b6f234mr78667757b3.18.1732475699701; Sun, 24 Nov 2024
 11:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124080220.1657238-1-kikuchan98@gmail.com>
 <20241124080220.1657238-2-kikuchan98@gmail.com> <f0d983f7-5f60-4cb7-9522-ef4429359c52@kernel.org>
 <945786cc-1d6d-4a45-b9df-26d9335fd271@kernel.org>
In-Reply-To: <945786cc-1d6d-4a45-b9df-26d9335fd271@kernel.org>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Mon, 25 Nov 2024 04:14:48 +0900
Message-ID: <CAG40kxH8bQHauBAd1B=UpC7LLAJoS=ETKczL=QWBKqvk=VKh_w@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: display: panel: Add another panel for
 RG35XX Plus (Rev6)
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Christophe Branchereau <cbranchereau@gmail.com>, 
	Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Krzysztof,

Thank you for reviewing.

> no wildcards

Sorry, but I believe these are not wildcards.

As discussed previously, the integrating vendor and device name are
preferred instead of the OEM serial for unidentified OEM panels.
These compatible strings are based on the actual device names:
  "RG35XX Plus", "RG 40XXV", "RG40XX H", and "RG CubeXX"
You can refer to
https://anbernic.com/collections/handheld-game-console for the full
line-up.

Oh, regarding "rg40xx-panel", it might have been separated to
"rg40xx-v-panel" and "rg40xx-h-panel".


> don't duplicate schemas

The old schemas "leadtek,ltk035c5444t", "fascontek,fs035vg158", and
"anbernic,rg35xx-plus-panel" exist independently.
So I had to add new schemas since the new ones are not compatible with
the old ones.

Perhaps the compatibles should be like this:
  compatible = "anbernic,rg35xx-plus-panel", "newvision,nv3052c";
as some others do.

In this way, the schema files would be a single file and not be messed
up, but it would break the previously defined schemas.

How should I deal with this?
Any suggestions or advice would be greatly appreciated.


> BTW, isn't this v2? Where is the changelog and proper versioning of
> patches?

Sorry, I thought the previous version was completely rejected due to
renaming back to "wl-355608-a8".
https://lore.kernel.org/dri-devel/20241105-maybe-chamomile-7505214f737e@spud/

But yes, these are somewhat relevant, I'll post the next version as v3
with changelogs. Thanks.

Best regards,
kikuchan

