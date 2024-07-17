Return-Path: <linux-kernel+bounces-255092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434BB933BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94ECAB228DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F917F383;
	Wed, 17 Jul 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="ndlft3dh"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DD14A61B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214352; cv=none; b=elOecfEVb6jDCLBjiGf4sFk4m2fsLTSBRNB00pRjdgP1ozqEYOT7autCfiEsu7hiRLK4wslzOKSXipB3P2g5jjJ+fdhPXm8QuDNypiUoFZ6JdlEmpX3s5W6l7xfFrdjyxRP5RmT43FipnNRmm/ZL2iOahPFvELUv9E6bIU7zCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214352; c=relaxed/simple;
	bh=P8bA1rS6MaVNpvk9zT8T6Vnj+t+0m0xxGVPMegUW/sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwckX1tVRD30CpLoqxtKG/SJnOXV4tw22CF/QEzDAmNf95KsWOLAOyjjpdv4liENnoHY6Durp5gfibwW37BfPC0COIliGrtNFEd5tsVXHS0V/lMWrrwtqs0E4RQXMWe9RaVDZKisuPVAeCXKDca3If706FRQUg8wAyhSmPf1szI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=ndlft3dh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c95ca60719so4422400a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1721214350; x=1721819150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B7F+PXb3NXcc4lYdWvAiUE7PDiOcWtXI9jJyLb/EpU=;
        b=ndlft3dhEKC33QoN4Mh94J0At7NT4KaWgcwu7gGXkDA0eSMZZagkZ5dyNXLihzLHv3
         W1deudFogPwXXab1eqaB4b3JqipDTpiHJF5SM0uhGFN06NQZYw1xu60leG3c3bMI9MN8
         zoJT7ta3jwJ0lvkXvC4pzBIiQjgqd0+G8Was6LL1C0nN52X9JDzEkTZ5ibnuH8jifOaa
         RXQW22Oq3j4xuPy5CVekJblHOVuanfnc2Wo0Jnvg3tz+kuXonuV+vRgm7QRQCa4P8iYA
         BX32VaU+M90W/nVhUTDBdc2cq1kbKNCkbPyp2DEFkL9GGWFCVJ4bPWEIz3JuOCr/gPS3
         bQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214350; x=1721819150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B7F+PXb3NXcc4lYdWvAiUE7PDiOcWtXI9jJyLb/EpU=;
        b=RXynEdGZ7PYRuc7D81qc/yRqRnc19NNpeo+UzoDkNa7MphmuDxYfCg2qtbeKsArMSz
         MPu9ytUyav0+bM5ttyvg26YGTSpFw9euosfjYfuD2KSSSeq6eFnAifO7ELp8/SuktxJH
         UHMWS6rjGQ5mgm1ornlWUb8/63WEgNHXk8y0o1WO9Hms3T35ZirYCwwd6Fuz5Raad28d
         HSPq5FEKM2I4Q1UDxbHf2RAwaN1JrswhujaLyMlW605lTNnyGJc2NWW562jKtL2fnduU
         hH5hZGvOVGFeiuj2ZXfzE4BTziMFYACChnYs3YWhnI7ia9PDYZP/dhDh/4PfI5Hykkp4
         PSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuLsgmjrWRkHhaY6rTXgfdvhU2jMAHhAJpQ9RMZkktZVimu7ndBAWxwaUMGInBHHs0FKPDxSXdxFnzBQKY+B6f6GI/ayYcx/VCThr9
X-Gm-Message-State: AOJu0YxLOpPlEj51r4fhLf3bgFDZ/JmbdsPgei24VVnHkJMTUbxpaSfM
	0DiTp3cvQM0E9GXRUyKOssZGpUe/5WWusJyrp8ti6Tbu/09GBaj7I3AfnTm5sWxzQFt5lR56Tow
	bYPEfejkT/8PYgvRokhcRgB5TsHcCYcc5p+Nn6A==
X-Google-Smtp-Source: AGHT+IGpbT+LGHYMMEvAwob3anXjVXuRNtGMAa8CZJI2wGGY0WG7oGPHIyCVsYd+8uK+P36Ly1r6oAyhxwJsQfCJp+s=
X-Received: by 2002:a17:90a:db0a:b0:2c7:f3de:27ef with SMTP id
 98e67ed59e1d1-2cb5281bd47mr877582a91.42.1721214349817; Wed, 17 Jul 2024
 04:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063802.663310305@linuxfoundation.org>
In-Reply-To: <20240717063802.663310305@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 17 Jul 2024 20:05:38 +0900
Message-ID: <CAKL4bV69HvCt8wuFFjSxk69PT55e_qERN6NCHDRKuO7SeF72ew@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.41-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Jul 17, 2024 at 3:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.41-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.41-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.41-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 17 19:25:19 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

