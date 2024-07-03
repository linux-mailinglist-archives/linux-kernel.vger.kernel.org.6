Return-Path: <linux-kernel+bounces-239500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F29260F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FF3284749
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E7177981;
	Wed,  3 Jul 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="qkKeVgqV"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015A176AA4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011295; cv=none; b=HiWW6v0LUkVlTi+D7v0ekGvMnyI1bNZZi7xeWgFao92t3QTFwG68M0+kmTJLAjTK/ARrLtuPnM+plFY15el7Fo19hZ1++UzCi1LPWBptuG55x+/1CjCRpFB5wyjS5iQ6QHlFnUutvY7keUThbkiS//4FZwRFHI3o5QVCGn/e/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011295; c=relaxed/simple;
	bh=rS/W1TqSZ7g/nTd/PX/LNoXQ3bRZucqWJPbOkYLIWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbnFlf7UGyAkp+OTN+SbgWXSecxvtCScjtRivvCN7lK9oT+wWrPzhPXuTEfpUULplBmHMKqe2OBMGlr7HzHYNkP6/nvNy0SI6FAs+12GFYhJnJm5EyegcBtdV4XUIUfYkXcjEYUJxVHnYY2bWcnMw0HkvrsX6veEY2PjWb9RfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=qkKeVgqV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so227833a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1720011293; x=1720616093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=855SeBJK+kQf7yXIRTBaRAUIqwJW4HXVIPFfDWbcfMY=;
        b=qkKeVgqVy2uM/EjmzNmoPeHxE95g05fjqa5c6spheBbedtNopGlmxFHGeQmr+IZI7i
         d3k020UBbuwZl8cb8qravxUXirgmT7mOckRHlbCrcCqlIKdgpTFViYEor8k+wwnm116q
         /RAIt4efJ9fk7rtAe2vP4xvKb96Ia54DU4QejUlE2HqE0OxKefAUIvgPdeGonqNrQshx
         XbfPc5wo2A02qGC4csBGIQHU4OCDik0W9551omv66wjM2u4Zi6+vP7uvLoqoixRwsL+Y
         9qjonhJZvSoMntiYsJlV5cdNu0MWoDi0KdyunleKktds6BaoqTP0JXp/Lghd0510Bu92
         grEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011293; x=1720616093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=855SeBJK+kQf7yXIRTBaRAUIqwJW4HXVIPFfDWbcfMY=;
        b=kBpgerKZBAMeDwlwny0+R60InldiW1I83/F/XVhY9h8GTSZzUxlv2Xv2jjzAjXFBFL
         Grtks7QMdYdieax8KLamDnd9Af7bRd5xAob/pQCPvmpYnn0RaLKw8seQFRK4PXtgZ6e0
         QfgTVi/QAVV48yODUPzQEea37ky8POr+bwqxIC+ANS9xeQE32SzKMCiyyzpM8zUiWO2M
         suJVDEj7PAdh8gb1eEG8d0cqGGVusw2kI4FkIlRFLua3oXcwQqm01iuQhkRMlo/JcOS1
         6xbvKpc2nsjJcuoLWKSSs41G4+Nl5swK60Ey7ib2yBcGJ9wqvWImpVRHP5JiCz4RfNJN
         gQiA==
X-Forwarded-Encrypted: i=1; AJvYcCWyxSwXrPe0AdkApXGG0an8YC4mm3PMC60+1uIEqqi6pUdGjNi6z5BZfUrUedEv5kmMv2EbtRWdPd9WkB5Y9kTJKOem3WmCCNU7g5k2
X-Gm-Message-State: AOJu0YxQf0GTuIMa5frwpIeiaixZqp3xZDsMvvGGzdM90nDP3A1DoZpn
	CD+mqrPgnzPCc4gICF1j/wglELvb5VQujsKNlAK/GyghTfibZ++tQgpWRuI+1T/JiB5IlABwj+8
	m9yOPj+792srnf3zCSilGLneLAnPYCjB571AiLQ==
X-Google-Smtp-Source: AGHT+IFeyxBhLt9MzjsdGvcxDI6Ss8W8+j+tZYOJYbNYqfjc+caqhGP3E6bzdV7g9BE3Tqajxbf9EkaaSQfkC7aoh3c=
X-Received: by 2002:a17:90a:8583:b0:2c8:df15:5ad7 with SMTP id
 98e67ed59e1d1-2c93d777302mr8133982a91.45.1720011292909; Wed, 03 Jul 2024
 05:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170233.048122282@linuxfoundation.org>
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 3 Jul 2024 21:54:42 +0900
Message-ID: <CAKL4bV5_povtwC25oFZfBHHzjHN_=aKGb_0zE_ZJyUJ_WseeNA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
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

On Wed, Jul 3, 2024 at 2:19=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.37-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.37-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.37-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul  3 20:52:59 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

