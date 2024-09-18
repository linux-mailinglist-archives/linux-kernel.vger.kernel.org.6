Return-Path: <linux-kernel+bounces-332789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B113597BED4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EC21C21D03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674021C984A;
	Wed, 18 Sep 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CUTnijK/"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D10EAC6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726674575; cv=none; b=VnidQLPTQe6xmY4mdeKwLD4EO8cAkyXRWg8fo4LFs9Xr3b3k+s8MK7uoeYVO+V3mJe0H0dAVb+FFTLWh+tz7i/leRv5wyGhRq9/h2dKCw7nOeL9dpP/ipMgfIR2X0wSg+cA17l8rP/n+dpAUS8S3L+2D6auEoz1nYeq45IUwY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726674575; c=relaxed/simple;
	bh=C0urIYHN9IJ+0/Jk8D/0CoiMipC73i1i0NjGcp7Rvh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnXi0XXZ5ySHj+e71Ce59gMKM2D1y9bDO5tQmeVwrUxqVRoG9a1+BPX0YGb7kSftcFF7ordeIy0Rwy2IAKl/EQye/h7Pzl15yWTlvyidYC96OIqSj/h2C25ShaAqIxuTFhzRV0kPAUMqKupzdEwrBsRKTb28RCZin0BBk83mDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CUTnijK/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D06BB3F744
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726674570;
	bh=F+xAcdwvemJXFq2JmBI2yNArggYzfuI0I0zCGmRTnl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=CUTnijK/pfinQP8UNv28R2vlBU+h5M7rj2tLOkilM160O0VxhHVq/Ok0D8R5Nh8pS
	 XeeG9h49dvXIvzAeSfy9tbWQXUB+KPV2ofLIgjHnE2iV/8w1kkLVHK2J/4oxFqZ/Lj
	 K3HvWlRwcwBNTIpe2p9Oua2BU53XXCFfMxHITJaJ7XAr/NJkx9xLJxYnNT3TqvswAi
	 tK7g96yR8VDSEUwHraIsmHIbJzXhOojqQP7Xm+XLT3SJUhpeY630rm17bTjfldYuVG
	 jUbo8MUFz87eosHNbQgE+40BNu0Bs+nqEnGZaJWiud/n3EVdZ8yB47Ds3AW9TWB6F5
	 M96CQhZhejzkQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb080ab53so44284135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726674569; x=1727279369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+xAcdwvemJXFq2JmBI2yNArggYzfuI0I0zCGmRTnl8=;
        b=UWMvSHkXaVSTU3R8jXOHa+gi4I24MhOskBWmNatFqy3DABRc4DNFHG9h/A0xP3rpjE
         B8niOqow5+0s/ym6T3x4jU38pwoEhj6Rd0aZA0WXMwaauHlXzHx9zlWSoTrYRdeLEUSj
         ZO98efQ59KE1Xs7rC75jvXMmjVxTGaifazbpSrTGBiIridqJu1y7UOMNWYZi6ux+M2Ej
         vgKCPdSnkzb8PG9hzrUgCOTMeJas7m2UuTbrKCJFPyP5LekN+h3ZPAtqb+BAKku+1byk
         2cRR2T3UiMcxVqRvR/8qmNjfrzOVuY9ziLjN5BJZf2RHj5xIVm6ncsmLv4YgnoS1Qte3
         yFyA==
X-Forwarded-Encrypted: i=1; AJvYcCURyiyKgsZmBmPFaufC4Y8o9fnOoIFj5inVHPxjU7/DElez80CKrX7HHQfwnvUVdcSHFuSBjXo1Be3rRK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI609qxiXBK9Be0TA3A+jh2i+IXc728lzyQuH+a6JU1ig+SGgE
	PuBETZSuTnqGKIEi1lfw4v1RoszQT+tG2goFMubs+4k7KcOw98ENF4xvxXpuC6Tnuq6L3zr4jJH
	p6dzNiAkivrzRIt5ALfgsGMXSY1mAl9PYoW2MtnqYEUjH59i7tEVccRR92t8/e3spNnRZCpy4Fd
	EzGQ==
X-Received: by 2002:a05:600c:4e93:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-42cdb540288mr156767975e9.8.1726674568852;
        Wed, 18 Sep 2024 08:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAlrcNId5RFaxWnWQbjyD7bs3F/Z1jJ/Y8qRGrKFZW3zH9kusnRT07hhPZ09WpG/efGfuSA==
X-Received: by 2002:a05:600c:4e93:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-42cdb540288mr156767565e9.8.1726674568334;
        Wed, 18 Sep 2024 08:49:28 -0700 (PDT)
Received: from [192.168.103.101] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4a46sm12643718f8f.14.2024.09.18.08.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 08:49:27 -0700 (PDT)
Message-ID: <620daf0d-caf8-4fe5-901e-2abadb751392@canonical.com>
Date: Wed, 18 Sep 2024 17:49:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
 <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
 <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
 <f1e41b95-c499-4e06-91cb-006dcd9d29e6@canonical.com>
 <20240918-4e2df3f0cabdb8002d7315d9@orel>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918-4e2df3f0cabdb8002d7315d9@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.24 15:56, Andrew Jones wrote:
> Thanks Heinrich, I had also forgotten that distinction. So the last
> question is whether or not we want to reset mstatus.FS to 1 instead of 3,
> as is done in this patch.
> 
> Thanks,
> drew


If the FD flag set to 3 (Dirty) indicates that "the corresponding state 
has potentially been modified since the last context save". Upon context 
switches the value of the floating point registers has to be saved.

The value 1 (Initial) implies that saving the registers on a context 
change is not needed.

3 (Dirty) is the safest choice. This is why OpenSBI is also using it.

For reference:

3.1.6.6. Extension Context Status in mstatus Register
The RISC-V Instruction Set Manual: Volume II - Privileged Architecture
Version 2024-04-11

Best regards

Heinrich

