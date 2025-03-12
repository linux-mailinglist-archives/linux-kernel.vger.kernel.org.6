Return-Path: <linux-kernel+bounces-557569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D161EA5DAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E0C1895AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013F23E32D;
	Wed, 12 Mar 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="jlLszTkb"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BB23C8D1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776743; cv=none; b=BhrSBwskDBUqxwjbDp84EeUjWi87aifRp8P6W5rNzsIMA/B16k8rxQHTSjAYYqP+2mnlCnqT6w7OeGJdmkzqqoQiSy83Ao1EPlOOIoAcdjZYV/XNm9M7GTPWEq3NOW26v3lkW9FeldyX9LDXQUYn9v5fecwwhyGXDuFC5D1rkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776743; c=relaxed/simple;
	bh=gjbUH7kAKKc/+1hKX36//HYzvvD9fqa3xfDCPoqEeBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbZxxoJCPUTW/54bjpFA2WZfUYUY5uJQ9E/NreQNTc83zYkl1INGbUT3USA7niZ/sIc4dwpEVsV7eP2rYrd5QE8mu28mgBg8L7wlknbga8tNaNmLPBihrbpZGjFcK+O6AZUo2YqC0pvwfWURKMWZDleb3W57ud4JBvF/A6n0pUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=jlLszTkb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3012885752dso236985a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1741776741; x=1742381541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3+PiV+uBaafq4RBHeVzsDnDBDg3GEz+NalwGRbaU3I=;
        b=jlLszTkbrpbkuDSibxQVNvAlG/6lTNYiZW4qlA0j9d1c0DYOrXWUmVp8yhUdvOOI5p
         VIxh2urfncvn5hzxXXeQk12vTj3p0JPH4j2Iur5oxaLsU9c+HwH1LycFUogiwSmjYv99
         /tFBrgeKL9Gg3UCnyfq2nY9nfmzMc/SH+4ndEcSrYaoIl5rxJbVthYGevAPoVKgb39Sq
         nFkbwxp2LTxkJJ0L2P3FsL5g9JlFEXWBtyV7A4QnZIafT8W7XyV2xFPxibDK/kGqY1O+
         w3YACDyfDW1UGwD6aTA9w7J+tGfGtZnzAC3Gzrc1hvcbCwM8cxWolzuKL8z8rAUGXsbX
         epJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776741; x=1742381541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3+PiV+uBaafq4RBHeVzsDnDBDg3GEz+NalwGRbaU3I=;
        b=kVS4UxQqwZUBAZq3/KXGNuR7WUlh0WzEg1FZqW0aHwu56nl6361O5oTaYLUFN+/AoA
         leahFI8yJjam/pdLCMAjV8oPuMOTRk+EAKnlibXG+9AyfKXFhfO57SMTlkv1IF83uKz3
         amPtBGO+mCE5HRcY8so31fBB7HgtffzWejycV50ggHDe+vAz06qB6T+97rV/jtaYAD7B
         PW193pPaZoAWAd5OF8sNne+1arzjomkVSz8G0VUHrvepbvFyjlvIfqBKgNlofbWfUevg
         ey7fVgWW9Jdevba7SSNKUtMWLYRpzAVkxPOLhAUUrvOFs1OVQDoZH8qM1QUxGnn4sS9A
         qg1w==
X-Forwarded-Encrypted: i=1; AJvYcCWPzeD8+gv7t/qvXkm7Mgi7ZpegrF9koY6tk4bMVI72sy4DAgYVshR+dGc4WKBLP0bK9KYkktCJio/DyiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MSgQF89Nti9k6xtN5EgqHw3QAjCgup/feIOI8pPLHZxyyz7q
	oXusjGsebUtKDjsugsVMeGINLZVLElESxXe+ui20Kw2nl2YnNXX6HXxwfJVVDhTo8mgHeNOjXNJ
	dTjqWMNLUNzBRUL+s5In8itOAk+8oOSk9qRYkoQ==
X-Gm-Gg: ASbGncsP4Z1RADZ4z9HA+E5UHD97VVueJP0aGpwVPzVlQS/z5w4H8tvAHavtjVVpKo9
	RZ5glpl1DtjWl26TI0n8nNCnxUZzCXHKe8VgnK30c7NVV0iJyirMQHkfOKmKHJKJds1meqgjXm7
	U5HdJ+U2pOAnL9o3D2cSU3Kkfhiw==
X-Google-Smtp-Source: AGHT+IGXx8ieZdctema6C598fuszKIgN/8+VSXT227UVWm6XgcSn9URsXMi9AG+8LL43/vYhgBTSwNHH8ZLeDEUYwIQ=
X-Received: by 2002:a17:90b:3f04:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-2ff7ceaa31dmr28985099a91.21.1741776741223; Wed, 12 Mar 2025
 03:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144241.070217339@linuxfoundation.org>
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 12 Mar 2025 19:52:05 +0900
X-Gm-Features: AQ5f1Jp4vzwvaXW8Cwgt2_Y6jV8MGhoF-jpghBXlm-wtunoGhrfsN0XP-137aQc
Message-ID: <CAKL4bV6jjxYR=x5=r-bed5Hck5ZmOAKTdM-PxL9-JTG03WndTg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
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

On Tue, Mar 11, 2025 at 11:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 14:41:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.13.7-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.7-rc2rv-gfca1356f3f51
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Wed Mar 12 19:21:39 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

