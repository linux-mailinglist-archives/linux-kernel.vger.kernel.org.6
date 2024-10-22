Return-Path: <linux-kernel+bounces-376293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA2F9AA2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DB91F24AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057CD19DF9E;
	Tue, 22 Oct 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="mpm9NsO/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79F19CD1B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602525; cv=none; b=j18z8KDfqiQTIr+X7OPNkkTGzAxZx+6yAXJeTHZ+/u8Dohl65keaDY/mN9Baq/OyS/BfRcPQH7CYr5VTEbIUeQVvcxy4RVhkfUNBaKufu/evbzaZy5mFHWt0nX/MgV9OW7ce29C8RBlDwrSFHxQ29cw7lTEib0uS3KhrUxAvlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602525; c=relaxed/simple;
	bh=3cVOqkFRTnn4fFWxsQTNO55gu0wUXV9eMQLfnE+68dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gzw3Xe6rSQF2Rgb4Cd/gJVTP4qKjgUC+ZsaRvnHkgCGxxFDsjkRszbxUZNan33ovkdobpDNoFkAQzptO5ohge7bkSCVz5sYOLLzXf9BWNd7tiZuUPxOa9xK+x7PIXLDqEyZXWvBW7citPVVTlltkZWp65l1yCqiS0S2XypWx778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=mpm9NsO/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c767a9c50so51895365ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1729602523; x=1730207323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSD76+9WkSJmJmUZ0lbLq6LmsKkpMwJOlweUzuTVP0o=;
        b=mpm9NsO/sfGnu3xOQHDwQLGxLRiYKVMDQBMTUd5qZwqd4/QawZkt1zzIgN/wn85krQ
         DWxgBUtz65t/i4Ayn7sMMKR+DlA+Kwqgo2agvysE6hEj2ZnAjOQXbt/LB921AFtaBa6i
         BhJ88/W/zaN6bosobRr6riPnGYY5KbPzzzXtYYxYftu1Z3hXw+xkTf4Zm9PgWlY2DD1d
         UfdHgJ/sgyeyabIkbQxWJaj0AA4SRR2xkqLS2m6c9j8kqDL7FHewB9C7joOMdAUD/8Pw
         rLfoZd7d6mrV621Y2rhgV8MiZhXYZFgVrcAoVV8pMVMlD3z97DZtuw8ioV5T3ziDQSGc
         i1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602523; x=1730207323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSD76+9WkSJmJmUZ0lbLq6LmsKkpMwJOlweUzuTVP0o=;
        b=eX3TbYtClS+cucvk0cJ7dEMt4plZUYm1SVGuqtrd9Gj3RLk48otxhurf0gRRj32AnS
         EcWUAtCSVjRNy6lWA5J9n/uDKmmJKt2omD1d92Hc4G4f8FdyKhk5aD/6sD2lGjajOC8x
         eUHK/knrwYtlcSdKc2lq25jboF2ndWSG1fNevM6oLinznuAP9EZwtMJE6avX77pG3b3B
         y2dXuAZDa7qgTTw991OEFwXifGVvcnkU3gf9Ejxpx7NBpHIy6DryLxXDHFWKc4ifNgUK
         d/Ex0GOTxUa95jvxeFAfOVdXzx6Aq3JOJ+6+GKsjh/F1X7Xl8nlKqPIoa8cJe+AuCVOA
         gATw==
X-Forwarded-Encrypted: i=1; AJvYcCXSfgozeAWx+71jZGCpdN4BmSfYGiGR+NigWPDeIsMqRNL/IZx61vYip75Fp5YbEbTP9gatVKv93MJYcWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Ju47oHOAtfoLVPoYsQhvXFRiVbOqlgmxSYYk1oTW2oSqmqYc
	KAGEQ2dYXF8iytpBz4GKX8vZ8L+sipF06ahmMZTRQupBmhlyeS5o1a4YcFoP3a2c+4MMO6npNz/
	8wwRFSpD0RPOI0YnqRWllrm9FHR3Z4ROrIMaIPg==
X-Google-Smtp-Source: AGHT+IHbGo2VQ8g5GmCprVUnwQHQ7CqOubSGDzGzyMmpKVAzodR2cXRT87GluNUR/opfbavjfYATFita6FYBPaa1n2s=
X-Received: by 2002:a05:6a20:e617:b0:1d4:e51a:932 with SMTP id
 adf61e73a8af0-1d92c4a0187mr20939890637.8.1729602523000; Tue, 22 Oct 2024
 06:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102256.706334758@linuxfoundation.org>
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 22 Oct 2024 22:08:32 +0900
Message-ID: <CAKL4bV6PwEy7ShiMBj18NofyQxtC3guaRwh_ZNUOOS2Ei4Hz3Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.58-rc1 review
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

On Mon, Oct 21, 2024 at 7:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.58 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.58-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.58-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.58-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Oct 22 21:03:58 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

