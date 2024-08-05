Return-Path: <linux-kernel+bounces-274262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684CD9475CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915701C20CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE57149006;
	Mon,  5 Aug 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oI1NUU+o"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A631428E3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842096; cv=none; b=FCP+00PR54qITMk0MalR8gIlRrI36+1USj59p8FbtePe0xObwJgQeIhR5PbAdh6ieUuDDSgqvaktLaHxz6ZdPkA0l67kCeTFILDEqi02j4DDp2GKYzW2o2GowuDbAS8xk295g8mKlK13qZJGtXIJld2EahXPKoKRer6swuliOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842096; c=relaxed/simple;
	bh=fW8MLBzAsPhs0u9VrvbBFm8u7iwjuawKl22vTwi99fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzgm/dtEmSeYuKEXyNC0B6AB6VsvixtKEBHBfv8qGGXMe4+27rIWmu7x+jpK57srCDvhcQ4OYZpzgk+ojqOKpByiQdiLm3gLV2BkwHS7AKrTNw/eGf7BH7dOPc99bW+bXbNOTHl7Src+nNvPEVQoSl0a6w3NIFuhBjRHii2v12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oI1NUU+o; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef25511ba9so41595961fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722842092; x=1723446892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y19XxSyjp3CKMWvlV4BQJW0+ZXcKqmWJAVbV5kfedD0=;
        b=oI1NUU+oxsz2nZoHfmtNABE0QFqgFLdJfwaJtVWrD3DvsE0XQ/kyWgpNaH6P0ViAYH
         0y+3o8IPX1RNwiek5O9E97SUQRxKWNGVYSN6Pq34b00ByOOQPjHzBJImk0Vr0Gfjld7s
         T0rnUn76PVzCN04pufi5Wh+n2KK2wpF/uUW6UqAsW0YEmkErZDV68gqtzAzuVivqcsVy
         n3bb7RaDjYC3ykGYtZBaXTEZFAi8TpodO2ItHu7RcV9Lu/bBtxkNSrYcWWDYZdmhO9yK
         l02oyLRMbgaxq6OlF5ojdO4ygJfWjTnJiPsQ46vEcw8CzUkXpzw7jJ71eVH/9pOwq0vy
         xIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842092; x=1723446892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y19XxSyjp3CKMWvlV4BQJW0+ZXcKqmWJAVbV5kfedD0=;
        b=raGHLIqKCJ6kEmM3kh1sSbusRGEFmZDgPFDKdqtJTWIsJAuopxwZx/Lmo9RSK91jyE
         qmG6n63HGFouAWH8d6i5IlWgA8oqLxHFigSdaqk4c2Du8+BfNLeA6SQyepsNLU41PKHK
         w808UPccuka9zhyBlipX7L+yGNE50Wk2GPsGvuD2jkq3+CQaJ06g10y0ymcNOQEiJ/lH
         o00jhwllG8h4Az3M7XrplUOtK4X/mh2iryU45RwN1Ktvnqe7ky0uSRIdKHpxjA8GK1gy
         q8hmPoXsg0rbVn87xXTvZ/joMCtnGcLBTbL62abZPGOx8pm35CWoU2+CyRFTC69UK6dv
         JrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX88rVDs8GSEZerU/wjYWsIldyduiPAEzUxtchnmmfzwmxTgOZks5fG+uxb/c00Yy14dCND5jAyxXPVbkCTOTWT/rOiMo9d9UDbeukN
X-Gm-Message-State: AOJu0Yx8GsnJzMJ11hT3ojTO+lY1Sj05N3X+orV4cUcoNwhTbKKZQ0dr
	1FIWe8OLvXp0CdDxWNhraGuUY711KrAYjfhZiNqw9+C3O4Xln9KRE9J6ePhZrlsNkN8acRi5mAn
	w2Zn+n99rQ4EJQnJzWT/0Z+Y+SfR5iCPRtusX5w==
X-Google-Smtp-Source: AGHT+IF34z/ZLUVlzH77E64wmhKMmfMRwH+K/qOicLm/MuBaXCwJmFb/RSZD904NTBGvXcfzD9/ptc74/DWwaWjwUNY=
X-Received: by 2002:a2e:7a05:0:b0:2ef:2d83:c136 with SMTP id
 38308e7fff4ca-2f15b113e4bmr29565551fa.1.1722842091808; Mon, 05 Aug 2024
 00:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708133348.3592667-1-ruanjinjie@huawei.com> <20240708133348.3592667-3-ruanjinjie@huawei.com>
In-Reply-To: <20240708133348.3592667-3-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:14:40 +0200
Message-ID: <CACRpkda+ZqXXbvXBotNbpK39_ghtY77AVi_bGLYMn2r_r-X6-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Fix crash kenrel data type bug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, bhe@redhat.com, vgoyal@redhat.com, 
	dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org, 
	rmk+kernel@armlinux.org.uk, eric.devolder@oracle.com, 
	gregkh@linuxfoundation.org, deller@gmx.de, javierm@redhat.com, 
	robh@kernel.org, thunder.leizhen@huawei.com, austindh.kim@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:29=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:

> On QEMU vexpress-a9 with 1GB memory, the crash kernel "crashkernel=3D4G"
> is ok as below:
>         Reserving 4096MB of memory at 2432MB for crashkernel (System RAM:=
 1024MB)
>
> The above info is confusing, because the System memory is as below:
>         # cat /proc/iomem | grep Sys
>         60000000-9fffffff : System RAM
>
> The cause is that the crash_size is parsed and printed with "unsigned lon=
g
> long" data type which is 8 bytes but used with "phys_addr_t" which is
> 4 bytes in memblock_phys_alloc_range().

Is that the whole explanation?

>         /* invalid value specified or crashkernel=3D0 */
> +       crash_size =3D (phys_addr_t)crash_size;
>         if (ret || !crash_size)
>                 return;

How did crash_size get assigned before you added this oneliner?

Yours,
Linus Walleij

