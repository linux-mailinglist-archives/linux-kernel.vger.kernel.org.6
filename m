Return-Path: <linux-kernel+bounces-576984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EEFA716FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05887A3188
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4391E51EC;
	Wed, 26 Mar 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="WjfcLfDt"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BA1DE2A1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993811; cv=none; b=inKd3SIyCY14FEaqdBGjqdbkOx/cgQQWplfPy1Fa20xgsbIrhSARVnruGYKXktx+y9NKCKrV57kVdIeMskN81Fp9RykKYUcpm3FBodPXVn37xGbOtKWoLv4fKwOjosRO3c9JrhrOiqNclBt16P/d4Pmw0zK71muPrfI1LsB8DNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993811; c=relaxed/simple;
	bh=xvdRNCWSoMb4LFMgO8nhLmxtocYZrWldrhUAbUspffI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPvSlEt8ZZap/Sv7WEcQw0ekEWrGhlHf5nz9QmMo353beWno4OFkoCOvx/LSG4rK5ffXuCTivuibWLGxRA9gV2Es9aHeOXvl6sK+PsSutsUqoGmOSw4EZNcRD9weqKBm15Lcos5Fabn+WbbRK7pkdWGwLNug4TOtGRK0LVAjLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=WjfcLfDt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso8262209a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1742993809; x=1743598609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRQTudAEXM13GUB8NKDUowp/QnTU6FFua+8YuPXk7Rs=;
        b=WjfcLfDthWyohLKliE5IJApO0G4dYpBvNwIlZUDZx+Zh1w14DPLUfCZVSeapDnUfj0
         Z9M9Cish/3QTFlkIGtiOJU/Q3tGGT5m2ODDVOlyWo2bDnV1IzCZe0zz23Fx6gzUiFQIq
         wRSEbursI2uvzdrU6QrBryyjVKTsQANZf5Uyhdg9bMimckPmF5c9SS+00BhxluwX5Ad9
         TNzMLLXMOL05m5xwk3uBMs3vLUumLW7hZhNwe0oGV6NehT7M/6gAHvKLmicN01P9wAKo
         IA2VBYATDTrOgqUM0kDuAAXl7KvMFEzDgxvl8mir3xxapsd8Fvj4iMIvh/ILT0Koymdt
         knZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993809; x=1743598609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRQTudAEXM13GUB8NKDUowp/QnTU6FFua+8YuPXk7Rs=;
        b=xOlhpBslppdx1sLy4n3Tx1ofAvAspuJbUmlRRxhFgFTEL+EOKv8AtbxkWWq4dGbnUh
         x69EEDseaspUxBqel4BfvdNRBqbAA2CqLT+1FzPZRRc6BCGohEqFI7rxKzzI8iL4Hlc2
         7eYFz0OZF8HU/owLt6Suivl2jaFuVf7p9mKfsCuLPRkFOQaYS//KG7TgDKmH9NvqeFri
         NvJEl/sXKJWQVUP4gGmaRJTyZc2pM7/jyT5QmP2hOWvuN4h0HuqwVJiofln8C9IAdBCt
         YrHquu7PQy7gYGAQJ0JwNyGPq/GWLZiajkWlYElMWwuKdMNLKOkFLlLHnN+1kNL+exHg
         7kAw==
X-Forwarded-Encrypted: i=1; AJvYcCUXP1JRw3EpGtRFRNzk7hG96P3bapBJlgSnrA83O8T2PtW/ySjYoMv3hAv+6OjEwfWWcTFuAEn8+9p++HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsLgj4O82y0ZFu6EXeKHePdZSR+PBmFFVsv5EjN3cuvA0TStC
	fnEgqCBD3X2UPuWTWqtxjh97K94BisXlzkn6TH78+q5+UBNfR8cFuqqBEBsctxpBQaoE2sHW00G
	4x7WXkbXDiL3HRCwSMKll7vA8yT66QxXZLnUDIg==
X-Gm-Gg: ASbGncvSjL2Zrwr4ORKJyLZEdKNsw8869QFL3JBg0x2Q3GeLOO4PfFKHtZWFs0D7xHF
	8sqEMoljeVWO5A8xtLw191aTE7yXxbHrncTxtKLYQPgGfiGaMPxvtepWq//a01iNXuzbh4Uajyf
	hTAaaXbOI9Wi8bvo1BJDFXVbypJw==
X-Google-Smtp-Source: AGHT+IEHnIi6oFcX3sSPTlCWyPe5+ORCR0E86AOeljuBB1GhwoNwr9EkT7VwDALSkS463AkNJD21fbYSqSYAoxTdCy0=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3030fea0d35mr35976364a91.15.1742993809451; Wed, 26 Mar 2025
 05:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122149.058346343@linuxfoundation.org>
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 26 Mar 2025 21:56:32 +0900
X-Gm-Features: AQ5f1JoR9ImdCw0Rs5T9hQLB-tj_Cg1W61XlOGDrmHp1wfzXHUlPxH1S6OVVqCA
Message-ID: <CAKL4bV66BuvB=-qkecDrkRw9AwOxv7pF6CGz_pLX28DQ+Dgdfg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
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

On Tue, Mar 25, 2025 at 10:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.9 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.13.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.9-rc1rv-g3d21aad34dfa
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Wed Mar 26 21:01:17 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

