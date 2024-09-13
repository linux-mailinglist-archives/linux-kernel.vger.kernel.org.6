Return-Path: <linux-kernel+bounces-328884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F884978A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064D8281834
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804514A084;
	Fri, 13 Sep 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGAEYv+1"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F74126C01
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261515; cv=none; b=XXpf20w81Gm9OnV+jnfjsejoG56lUrCTdG4zSrxQSn8CZM4sfR0mOuIAYn164VItSGMEct16cVtVqm4UfyQN++cpI84hKANweAVkODizw2akG+aOLN0Gok3mqmIPF1Iezkl7IRnIgaqOA7rNKHcBvBEJMMGUanEjP+4lHEPtGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261515; c=relaxed/simple;
	bh=Y5vaHHHX9R/doH4SFIBNsgP0FRw42PlBP15OcUVBXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ut4A0MwmtS0Kp8cIR7NZebwjFTYK9q7INgzhs6I0MvPCUFVjNlvhMOYVxd101pw6aEzOM478d9u1QBdzPNHElI5rBykM5dN7MwEhIzvzr3kK9rPUFoG8Y7Qn9t5cS3MsvtrUKMvTonPGm3RcLDDv2JX2eIMEgs2TnTN/ONF5G8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TGAEYv+1; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582b71df40so19671cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726261511; x=1726866311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1BcM4lFpbGajeTbbT/mhOoL1c44seTsAjZcdL46W1OY=;
        b=TGAEYv+1Uf/C8AG04SIIUnngGMwiXleLK1P5YgXWCA5I9GVYZEPWqnqcL5n424CCb0
         AaBeTrmW37BpX8eqlEoIGtxYCmINXfsHXGmNetmJ3uRQfRRrTm78CvoM76Ky2O28cYWQ
         gxSWqqyyTVoUeY70Z+Zk6XHbMSeOCWZH5VaXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726261511; x=1726866311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BcM4lFpbGajeTbbT/mhOoL1c44seTsAjZcdL46W1OY=;
        b=culRjuIcGyhd1U1CS/p4/JwvskENIqJ3yQpmBC1GHJbPKEB3AmSwQgYb/POkmV9N8L
         DWAAjZzyfcFKlPl1ksX3Bdx3Ti2QcH4F9/BlmHDYoWwTJ8w1hZ/gSQBThH+D1PQRDnPM
         VxTwPlqZd+1OjXeYkX8ZNmJan3/wBM7VtHuRIz2+uH/vFA40ygXyrghh2Cvv/RgypzOM
         FugsDraWszofJ24Xh/LzD97ZA+uYI3KRFcMXAKC6sTMhPjDazmltoGV2otNcehS6CfsV
         QLV1UsYq9+VI4onEQQxZnZ6Xqr7C4iBtHOVaoJ2erFrWRcSGxeR6KuNWMtyyTLbBsEC8
         FUKw==
X-Gm-Message-State: AOJu0YyPWV2fcTyAfT494gbLCfz+2Dpqmo0J7jCAMPAWUBBza0oIi6l2
	V6t3EoVNQcBgJcLj1Q7xD+g/HHS3HyhZQ9+2vPDZIJwJTPHXIBjy+Au2fL4VYpMNkqckWEBfrZ3
	aupcv30tvZcgFccEx3oDAV3puTrUFTMNoLNMf
X-Google-Smtp-Source: AGHT+IFNRp9kjdF5lPJBN4P/u35hlTu6w+0QAcj6x9ZSyI0WuN2oPGU/zG4A4BHZew+CcsGHtVNi4SatFGwQfWsqIMc=
X-Received: by 2002:ac8:7e8f:0:b0:453:56d3:d155 with SMTP id
 d75a77b69052e-4586079ad25mr7773551cf.8.1726261511093; Fri, 13 Sep 2024
 14:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913191428.1539653-1-javierm@redhat.com>
In-Reply-To: <20240913191428.1539653-1-javierm@redhat.com>
From: Julius Werner <jwerner@chromium.org>
Date: Fri, 13 Sep 2024 14:04:55 -0700
Message-ID: <CAODwPW8nEkc=x+BeSajfMVjXzET_0G3h-xFMnbUaE8Lgi-173Q@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: coreboot: Don't register a pdev if
 screen_info data is present
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Hugues Bruant <hugues.bruant@gmail.com>, Julius Werner <jwerner@chromium.org>, 
	Brian Norris <briannorris@chromium.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Borislav Petkov <bp@alien8.de>, Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> +       /*
> +        * On Coreboot systems, the advertised LB_TAG_FRAMEBUFFER entry
> +        * in the Coreboot table should only be used if the payload did
> +        * not pass a framebuffer information to the Linux kernel.

nit: The official brand spelling is "coreboot", always lowercase (even
at the start of a sentence). Not a big deal though.

Reviewed-by: Julius Werner <jwerner@chromium.org>

