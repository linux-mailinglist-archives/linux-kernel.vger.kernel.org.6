Return-Path: <linux-kernel+bounces-571343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E402CA6BBFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70721894A97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D9542A94;
	Fri, 21 Mar 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="wOkiygT5"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6912B93
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564867; cv=none; b=MdciHnRB4kg0ycbqjD8kzMSP6JG2BRti3FCm8NRIxztB0E3TGVi525/m8joMEUiirCtR2I5wGZfQcsY38nJrjyI+SzIx+Nri49XmLljaB4wdQt1RSoPpL3JqmwZCYuXPwi517M1Z2SwzUfvvAzCj+drwPj1vF50tQsMCg13AH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564867; c=relaxed/simple;
	bh=zto+hD4T8Rl0wGhIV/0xoa9IwhY4ZDqaQa3d6Xj1HKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGiNdYjoNbuqt4cs1lsmMs9VozcDCdlJbN0BbuZYlgPdG9z0sge0d+vGd9vECb/y23hCCcCH/G3FXSbszk1U/BN/03GBTc/1Tc6BLsCUdVtwoWr7KLlIeku/2kkGbrfnRo0c8yopgv2u90HqM6npMWvuBEDgPE4xdgCeF5aeKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=wOkiygT5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso2782161a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1742564864; x=1743169664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8nQgLdmlUqdr9aYe+VPc8RjHS/d3j/W4qOBy0BpvdI=;
        b=wOkiygT5XK5gKLnLsEQp3gFauTepjz0CUsmqpUhuGOX6J1HoAitIm6bVkqJvPYyRDZ
         d7NmNKOMhXFHp+Z+rIh03cr6VvB5KU06Eho0GISuRUToruQoVUordXQxM/wcDWNXo9Hc
         XKEPj6kcWHFm6aM5Ojp0gtR5Ys7xZXQ3u1xmtB5xj7Lxsv5LB5HpdA3cEAZTNd2qqfou
         1nkVoTz9Oq9nPsy78OpjqGSzmDGN0XvK3+ejAxjMco8nJwC73E39Vq2vCYM2+q7qyjQp
         YYqk/AHZ/C4aAWTwrxXgF5NcdBMdA80IVJEbWEtYaKPjhSZCpUg9K6YG340r/m593ygv
         KHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742564864; x=1743169664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8nQgLdmlUqdr9aYe+VPc8RjHS/d3j/W4qOBy0BpvdI=;
        b=L5XI5rWwKUoAaaY3BS3tdgJZlSqx1l2LypAEoPaL+d/0917BsSIiBH8XBb5EOjOTkr
         gPoQ5hxneqYjAGT7cbWtR7Si4rrIT+6PdjHw0aYupXnTlwCuHiqm9SCth2io4B0F2E7e
         27V4y41ELTesIIIu3QIzuaFefU7mfUi/4VgP1RBtVLpz8eLFmRFzWMoRFn5l21nw+Ktr
         MCV3LI4JQSyIqBXP8+yAOPcDeztY28GpA2EqIPFBpYmc9ksIea/eoUXbpH0GQ/8izLHo
         8W23xjI6rH/k7HkOofEWbbp73LHla08I55OG4/StovCHKzEX27VRrVJ0nGF0W0jVbh21
         pskQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg5XbFqOFVBd6jqADCrsHENqv+cnrUmWI8G5Q2sRhfqBWHZ4JNvI+HhnHqP/Tnr6MKp1QAAZsT1WLvSnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbs+2uLZFBtoxTvRAJpT26sH6HbPX49Izad0gXt1B7rwq/f6Hh
	/+UY/Ke1nPXJp4CLHWs8AtgcuO1nAcR8w7yXjJrSqHXzErGnrMY18H543lL+MkXH14ta9+A53oq
	J7S5/XmCaP6vmiQQ/w0RVscxYEomDVU05sfVnsg==
X-Gm-Gg: ASbGncsTe4pIerHHdJk6MQo6UIQBq2/o7f6DqOQCipEVXxSFDPVURTLj7ATvyS7BX5y
	TpyR9WzyK2T4QPnEBbXcKg274Yl52kefCJIpIucltXN5HY/CGPvk49/xXEU5hoDfOpu41cHiJgc
	ceKdFdqlOEHbraBwjFWdpJDtb2yGXTUIQkZVuz
X-Google-Smtp-Source: AGHT+IG9gHzXZS2MDHa4IE9fwTzJ1H0FhHqAo4iMsZRn/mh9NpHgxYoGlNF8O6uvXxiYLj+Zs6L/giMBpxyi7SPgYGU=
X-Received: by 2002:a17:90b:2dc8:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-3030ff07367mr5795406a91.33.1742564864003; Fri, 21 Mar 2025
 06:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319143027.685727358@linuxfoundation.org>
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 21 Mar 2025 22:47:27 +0900
X-Gm-Features: AQ5f1Jq_-0xkKqLvecUc-RyuF4NKyutsPZK2DjPZzNY6v7pHHsBsKKACW7x7r0o
Message-ID: <CAKL4bV6JL0A2eqhC3wkppUyJLEXfTZW9qqVOHnY4p4qy8zLjAw@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Mar 19, 2025 at 11:35=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.8-rc1rv-g14de9a7d510f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Mar 21 21:51:52 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

