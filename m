Return-Path: <linux-kernel+bounces-288385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707895397D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391E028756B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DADC433D6;
	Thu, 15 Aug 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="bPo0rnSG"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D01AC8AE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744318; cv=none; b=qI+QUuB4r0Fnl5i85UDJL6rVGLiTIBm4s1Fi+iKhwXWAwn9OnclSgjHqAGiLKuiWnMupsmY2mhqob09VaEZPiVljZsmnMw//Zy9lCia2DKFtw0wVb7Q1oYrmDI9cCcKibi7ipsRd+/jNRC4RNY2osP/7zYa1R8Og2ly3Qfjwyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744318; c=relaxed/simple;
	bh=rGIhGjIF9diLpfaVuI/K9e754umdf6qNiEmx5tE8dVw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=etV4SyKysJfMYQrxbbcoXuuV/TAAkaAivv9dNL888N+udmEbYnYkZ72zHeYueOV3AvPnTa23RWPpUJVTgNter3u029epEmAPTYkLls4NxH1vc/GkQ4eYK/Q24C5fEyHqFMpWmIZnvATvzcCBqaWf1JOeF/0s3p9np0ih40IC6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=bPo0rnSG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so996728b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1723744316; x=1724349116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF5y7VdAv86rlsatFywgw34wd256R54jcN1htpL2/Ng=;
        b=bPo0rnSG9Uv/2xLigy4To61w95dlTPpW/cPJT0mnIyQZbNwVGAh6dm7BZoOI2F7FmZ
         m+RSAOPxW0Lp9TsmIoPxnnaVOQdgR35U0v1o4bZMaBQD6YOxa+WV/a88MEdJmFcV6/dF
         V8zYXijDz54Bx+Od2u43Rvg9UwOUh1/tc6pACxURgU1ANcdvPII/UrkaTnOPb13898Nl
         LHIvTmbR81ar8tHEQJyONpPS90Mw6MrMpuAa+rV+7R5uHI552TYiiCMxOZWtQTUGV4Ve
         kzZbxRXMbKso0KVAO4JoQGHJXaUIkToiqtSIUXeQMPm39mTOLAMDtMxptWSyeOgjTS53
         U4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723744316; x=1724349116;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF5y7VdAv86rlsatFywgw34wd256R54jcN1htpL2/Ng=;
        b=YSWgKGJpCjLJuxywln0rCvR6teLCXt12ENj3+h6Ncu4x1f6fNTtq7bQ8nO6HaoJPko
         2EtneM0js4NpArclY/O+0yQwgQGJgV4E99u+zgN65sAvYsW5LHQFgIrFmdPlfraUkm4P
         bSb11efFhSEiFVsELWw/17msXtY3y1AqiAIEUf4nlt0tOpjLWgShXRmewe73N0W8X9Hr
         rH1/dWRtJAyM26+x/h94X9dORBT/MFsJSa19KpwWEUStNR48gQuWLmCUDQPq8wfB+OwZ
         CDYnzCwt4V+R+MVz3ezb+VcMZVkoJsgB5u5S5ZXIPxulvSiLpXOB2SDa2smx/Q/qFX4z
         kbdA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ds/b1CPu4s8Rcgrndo3M74LV5EENVVEq9Dyhcc8W2fioWmOeXkAZPzkEU/w8A7kYieLnWo2B0TzVFfsZXdYrXUBnYeNlab1B3mFC
X-Gm-Message-State: AOJu0YwaxL00AQLAjOWW/i0lJgychAMCdmVxUoocNihpWInukrPFs228
	7xeuY7ss+AV4tpkAFxiumnES+RHzbqJeaLFKMd8/gQwekDEncjUPOV+feSP/dMY=
X-Google-Smtp-Source: AGHT+IF21HYGAE3KPrPW3reiICNnsIeKgkTr+GBGGbmpqUgn16gPDMt9igP4MuSSMGRTKpzkEHV2Jw==
X-Received: by 2002:a05:6a21:3a81:b0:1be:d1bf:a371 with SMTP id adf61e73a8af0-1c9050477c9mr585813637.33.1723744315617;
        Thu, 15 Aug 2024 10:51:55 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef57fbsm1290185b3a.97.2024.08.15.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:51:55 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:51:55 -0700 (PDT)
X-Google-Original-Date: Thu, 15 Aug 2024 10:51:49 PDT (-0700)
Subject:     Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <87jzgjnh9z.ffs@tglx>
CC: Renner Berthing <emil.renner.berthing@canonical.com>,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, apatel@ventanamicro.com,
  Paul Walmsley <paul.walmsley@sifive.com>, samuel.holland@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tglx@linutronix.de
Message-ID: <mhng-5403a4a9-4cdf-447f-9c7e-ea655a2f86fc@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 10:30:48 PDT (-0700), tglx@linutronix.de wrote:
> On Wed, Aug 14 2024 at 16:56, Emil Renner Berthing wrote:
>> As described in the thread below[1] I haven't been able to boot my
>> boards based on the Allwinner D1 SoC since 6.9 where you converted the
>> SiFive PLIC driver to a platform driver.
>>
>> This is clearly a regression and there haven't really been much progress
>> on fixing the issue since then, so here is the revert that fixes it.
>>
>> If no other fix is found before 6.11 I suggest we apply this.
>
> So this mess has been ignored for two month now?
>
>>From the pastebin in the initial report:
>
> [    0.000000] irq: no irq domain found for interrupt-controller@10000000 !
> [    0.000000] Failed to map interrupt for /soc/timer@2050000
> [    0.000000] Failed to initialize '/soc/timer@2050000': -22
>
> This comes back with -EINVAL. So the timer cannot find an interrupt,
> which makes it pretty obvious why the system stops to boot, unless there
> is some other timer available.
>
> This is obviously related to the SUN4I_TIMER because that message went
> away when it was disabled according to the next pastebin.
>
> Obviously that can't work because the SUN4I timer driver is using
> timer_of_init() which cannot handle deferred probing.
>
> Daniel: There was a partial fix for the sun4i driver, which you said you
> applied:
>
>   https://lore.kernel.org/all/20240312192519.1602493-1-samuel.holland@sifive.com
>
> But that thing never materialized in a pull request.
>
> And of course everyone involved ignored the problem since March 13th
> 2024, i.e. almost half a year.
>
> Seriously?
>
> Can you RISCV folks get your act together and ensure to fix things you
> broke on the way? Especially when Emil reported this nobody pointed him
> to this patch and nobody noticed that it's still not merged?
>
> It took me less than 15 minutes to find that patch and the correlation,
> but this is absolutely not my job.

Sorry, I guess I'd just sort of been ignoring the platform-specific side 
of things because it's so frustrating to deal with, but that's led to a 
bunch of breakages so it's obviously the wrong thing to do.

> I'm seriously grumpy about that. This is not how it works. If you break
> stuff, then you take care to fix it before you shove more changes into
> the tree and waste my time.
>
> I'm very much inclined to take the reverts right now, send them to Linus
> for -rc5 tagged with cc: stable and ignore/nak any irqchip related riscv
> patches until the next merge window is over.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if you want to take the revert.

IIUC the patch above doesn't actually fix it, that's what led to just 
sending the reverts -- at least reverts are better than breaking users.  
I'll post over there too...

And it's no big deal if we're in the doghouse for a bit.  Regressions 
should get fixed faster than this, so we deserve it.

Probably also another sign we're way too focused on getting new features 
merged, as that's coming at the expense of making existing platforms 
work.  IMO we've been way too focused on getting support for specs that 
don't even have implementations, and not enough on building real working 
systems.

> Emil, can you give that sun4i fix a test ride please?
>
> Thanks,
>
>         tglx

