Return-Path: <linux-kernel+bounces-384977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074059B30E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C097B282A73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED071DA2E0;
	Mon, 28 Oct 2024 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="uKzPpCki"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C5143888
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119727; cv=none; b=n/g9ADrWcm1Zet5fzG3c1/hcdbtDrlbQyzFaGbyuI5qHMvlaQjcqbuAb/e2gZ9YvcAZ+PPhZfblnvUi+ecWqAGBeYMDgA1VqUKwCGBbKiEDWvwPAyG9/GkwWU1pUw4nGm4lNZf9WWphAL7gV9/3xXKezEDO6GYpmsmcrDRvInsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119727; c=relaxed/simple;
	bh=JoPSXOQeJqMKZgY81YXFOztSG1vOJXM3CX4fstflfPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUbRbIeynpfU+K0yDs3uQixUye/lVc64BgQMVhZtSoamNUdIvsv9rIE+twMpgA31LVz+dZspGMfNqDbzk/otUSDrWOf7Mv1Bj/2rAiKRYpIvZjPyle3pc1suaZx+PW71+QlUtOVIsQc3LxTI7jhrVQScCJHpwMclGyWz67ZgNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=uKzPpCki; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e681bc315so2891081b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1730119724; x=1730724524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReVN0cLvWmqthK71mUPz9Vh7INJT2/+SuZUXMARwOEU=;
        b=uKzPpCkiNHGgrfKjIwM37Xq1pe3YpqnWCc95TaBk7ZIWR4J57QBhpMvMVLk2TltuUn
         ghI+2bK4zAP1/gqx23U1Ccpiczz1NIFlzuWn2ugbcRwLxv8Aiyraeee91jCipnYUlOmL
         gW587I3BHRgIMPjgZQj76Xm3Wb4u/ZPlQAuPJpXJuQYAddVJ97Z8Ag17EzDKyaI5/9sn
         bud03Tlhx2HJkz9Lh0QEkpUpDgmN1CcAMCK+Z4OSW/CvUDla3/P3SXmHZtMqQPDwAShN
         lH3dAcNjp2krWynG9mOdbLe4EvLUmhnYSuXm12/tbyLFgJtJknHAZ+um5AX6Fzue00Fh
         jyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119724; x=1730724524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReVN0cLvWmqthK71mUPz9Vh7INJT2/+SuZUXMARwOEU=;
        b=QTNbEYGqMkJBfyYkFgm3YjnhWbLbY403kGUKcF7XYCC6lGXTUkl7Y/y3AKEe7+k2BD
         hev6kcfNgnKIKyFBeGZZGF/YwtJYktQDULR9e8ny3tUFqf14wMpcl1e2DCSZQFsfWbxE
         oEWP/7yc+vaiApcTmsmsgt6X++ObjGzWq7pGbSfrNzBHCa/weAzB1QQStVaeaHa2xf8a
         IqIvip5QiSQ0QYz+u7Ua5+KfidUxR40iL9r+5Ni1miaq4Dejjc7wW/fcS//kIq3TEd9I
         A1gtELOZPh7snq0z54uUuiqIR4xV3b09nerbuqcVjTdDs633SHL3qk1t9or3ttpL4Mfn
         IWjA==
X-Forwarded-Encrypted: i=1; AJvYcCU8asPLQOA+ZmjvSRt2EkjbhebnnnjGVbEQnNBCcz0ZrvBosCZikJC43WkUmWbkWtCILu72lTTPpZ38jk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQnALr3np2dCaDIDtFZdr9kbkzBgtJAj9ylARVCxnhePNQSln
	3zozfc5maosimgyGTfCjgh0UAlIRv1l+gbypXs2lEPQdUqPsFdoYC5mTrumrzMmmduQyOOgvx71
	3nco+MSG6AUzBj0vEc4yt7TQLf9XI3kaXIAlvDQ==
X-Google-Smtp-Source: AGHT+IGhLfmQkrVqP4HYAOjiKc7239c27pDkdxqrymPqmidDyewNr77EbQ//qBWctOJ8VAhkGWdsckBMrKZ6g9++IUQ=
X-Received: by 2002:a05:6a00:1954:b0:71e:44f6:690f with SMTP id
 d2e1a72fcca58-72062fb21e7mr11792989b3a.8.1730119724055; Mon, 28 Oct 2024
 05:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028062306.649733554@linuxfoundation.org>
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 28 Oct 2024 21:48:33 +0900
Message-ID: <CAKL4bV5XW+xCFSSie3tBE1GiB4pFZ1vSpHS9qkyzZg6ibxDVbg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/208] 6.6.59-rc1 review
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

On Mon, Oct 28, 2024 at 3:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.59 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.59-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.59-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.59-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Mon Oct 28 20:41:12 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

