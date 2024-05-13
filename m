Return-Path: <linux-kernel+bounces-177561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451388C40C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711401C214F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09257888;
	Mon, 13 May 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elOZGoG6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086179CD
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603599; cv=none; b=pJdlSiCfCicle2K+gVnzMVhfly8ha/orodNozno/zwTshfWDbzCKVQLO1daRSbQAALlzU+GMzEl6m6//1PtjO9+QI4haoRUJVoRxPDcUa5cATFqArtHabXmQnqQ7ar0KC3D3dzIoPhvYgxPpMIimctOrXDfcYF6KECwvlRQn6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603599; c=relaxed/simple;
	bh=88nrqaJsYhfhJyUpQvjQX8//vf3CXxgAHJIupb2DEY8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WEej859FhF+/HvAhWGp3IdyGkdog3IMq15dMwD9T5n0XSXb0loIxtRe4s0SGRmQNEFMMNIcl1A3jLJGl1cpKjQKAMbZq/tGSPgV+36qj/stYrf2MD1g2V3khwgJvGrWmWSNpa6imaOhUH1tlu+gexWMNtgmBqpLJWep6AG4x0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elOZGoG6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b49162aeso1072305866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715603596; x=1716208396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/24anTbd23uTqFCzj46U+i/dC2oWYez6CRKoL/UqoM=;
        b=elOZGoG6JS58cn+XkenHQK9h8zcTEkykQYO308cxjYG53SYU8TDznq13QTSKV0k3yB
         nGHLe6yxx6n5uB9tmozrR215yBD3Dg+FlTI1DZDDCIjgAOWxE8NApIBdSnH7h7B0eTk6
         xnyWhrjKBBLya9NJQR+C8yOYHcEIZY3nHMKRYwz+Ph9oPF7LjgzvsAZAGqTreE7LgAHn
         lr6SpdVal3ncqB10opbHXVpyGF9jBPisLiaNdzvRdnPrQ/kUzlyDXk1yodLbTuAjyQ5s
         G6TmWsbLbx9G4Edhi4Xs9FP+X8lR/u43b8x2V/FTg23ClBG34h75Z9rcn0G1XUdHQaJW
         GNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715603596; x=1716208396;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/24anTbd23uTqFCzj46U+i/dC2oWYez6CRKoL/UqoM=;
        b=po04yQBmzPcp9JxqEAsONybab9PVhQLD+aA8JjnRfaGUV18tuXQ1jp6ThQnO3SLYfD
         LoE/IhKL77q1Rbv3FjIwlovUAhFLM+J+Ds7J44fo7VUicIvTSnzegvY7h7tQQ02TRHNn
         rf86HCw4TYHtPb7WK9jXlnVzcGv0XeADV6TUHdXeD0xbzuOas1+IqXc8pIkYiDovC1Fk
         SPpwev5I5yfwc2uiFDWGhfp/K4br/69qGjdUUOWIc7S67jzciQ3BvKM2umM5QXhYfDAa
         FyOVZQaY18jc4DS6Htm/WEXeFz9mB547cHBwSRILQmKAoV5GpkSPPMh/ntt5d9qt3Vk7
         mx9A==
X-Forwarded-Encrypted: i=1; AJvYcCX9D0OxM830kaKGZN7kAYCr0rFz25OubeChH3j26NbFNc27/SXawQiRJETxUr4cagTQEVufhpcETmS/axwRYSzYjmCaitSphFcmxs/n
X-Gm-Message-State: AOJu0YwiIwzpXpQcU2nKAdsT3G8jBb+RifeslVxaDSuqaPIofmwjbuj+
	LGneG2NxjBKca7145+28KRG0qF5UVnNFCAIi2YoEn5oXTNcRueR+
X-Google-Smtp-Source: AGHT+IGi9n6np+k21ewfVp4If9hyjezb1uIX+HkY1xJ7TGPPzTl8vW5wWpuCNurTnvQ4Zt7+zXzWxg==
X-Received: by 2002:a50:d745:0:b0:56e:3774:749b with SMTP id 4fb4d7f45d1cf-5734d6dfeedmr5504633a12.42.1715603595711;
        Mon, 13 May 2024 05:33:15 -0700 (PDT)
Received: from ?IPV6:2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751? ([2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfcc1sm6010876a12.45.2024.05.13.05.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 05:33:15 -0700 (PDT)
Message-ID: <ce50c633-598e-4252-88fd-109954808b2b@gmail.com>
Date: Mon, 13 May 2024 14:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ming.lei@redhat.com
Cc: benjamin.meier70@gmail.com, hch@lst.de, kbusch@kernel.org,
 kbusch@meta.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, tglx@linutronix.de
References: <ZkHcde1xeBOiEikg@fedora>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Content-Language: en-US
From: Benjamin Meier <benjamin.meier70@gmail.com>
In-Reply-To: <ZkHcde1xeBOiEikg@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > 'isolcpus=managed_irq' enablement patches are small, and shouldn't be 
very
 > hard to backport.

I have big respect of kernel code and probably for non-kernel devs it's 
not so easy:)

But yeah, we'll look into this.

 > > > > be tricky to assign all interrupts to those without a
 > > performance-penalty.
 > > > >
 > > > > Given these requirements, manually specifying interrupt/core 
assignments
 > > > > would offer greater flexibility and control over system 
performance.
 > > > > Moreover, the proposed code changes appear minimal and have no
 > > > > impact on existing functionalities.
 > > >
 > > > Looks your main concern is performance, but as Keith mentioned, the
 > > proposed
 > > > change may degrade nvme perf too:
 > > >
 > > > 
https://lore.kernel.org/linux-nvme/Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com/
 > >
 > > Yes, but for NVMe it's not that critical. The most important point 
for us is
 > > to keep them away from our "high-priority" cores. We still wanted 
to have
 > > control
 > > where we run those interrupts, but also because we just did not 
know the
 > > "managed_irq"
 > > option.
 >
 > OK, thanks for share the input!
 >
 > Now from upstream viewpoint, 'isolcpus=managed_irq' should work for 
your case,
 > and seems not necessary to support nvme unmanaged irq for this 
requirement
 > at least.

Yes, probably that will do it. Personally, I still think it's a nice 
thing if it's
possible to assign interrupts to specific cores, but practically the 
advantages are
likely not that big compared to 'isolcpus=managed_irq'.

Thanks for all the explanations

