Return-Path: <linux-kernel+bounces-288704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B80953DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA7C1F26D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90A154BEA;
	Thu, 15 Aug 2024 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="HKoGo5cv"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB814D708
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763081; cv=none; b=DwmXc443wyPv0EdQtz6YnqovGsc4swklZBf3I+ufk37hZO4posBWQ4e+Sb2Bx8oMzDhUCFC+t6/31uHTbX30fUeDAHpZi/7i1rQx+/sPdscxccmZR7xXSvyLID9WAHNnv4e4xacXf7GhX6FS+OQ0UfN9FG/Cm9ujkM/d7j5/3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763081; c=relaxed/simple;
	bh=ie/dkTZLLEhd4iOQo/ic6x+ZDM3wew1wX3BPPhT3+Xg=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=gpYES6aKro1eB2+kURr8KfGSnCHrqG1EDWtpr6AjbMOTYjz9AVMtaYYYAn7I8vPnIsGZf5acVB5lfOoEPtcWmoc+2IXKO8OwvJYIzofawbRk/qEY4vzWE8bbaCSWiWWcm8Ib/fiN6+2fihVUfF1q2qPwZcohZpWJ7La35rp9WIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=HKoGo5cv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3ec4bacc5so11973a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1723763078; x=1724367878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iX+LsvVh+pS0eXJpm+RAssvfTKz+ILUKR5VgTsl+lRY=;
        b=HKoGo5cvCBwXDBRVkozsKkB2smD3iYvz2WMaS3EurFnoVh0Up+fKssLFhcmpDv1SM0
         bE9XQCwt5JbPsRTN1MWtlnOcKOfzu8qV4d5QazNJbYdmam9VTh61vYnR58vQaWtDNamh
         s5SUs2FxEezyNccMBEt1uJoKtkz4HZ4hZsCxEBzevDUinJ+UrKWAp7sLBVGRBj6P5naP
         2osloIhd8j/s8bxvpW/Ok9cPGbx4XSeB7g45wPjhjrLW52e1oCennALy8inWBvK0e912
         mW8jAhTx9DLQqnhKIcKXPPdRM1O9J5a33C1I3CCJyiRKOAJvzk39pTj1FFeKJrYdhhJL
         IyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723763078; x=1724367878;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX+LsvVh+pS0eXJpm+RAssvfTKz+ILUKR5VgTsl+lRY=;
        b=J/7EMEz2Qbo5uln5kh2TFc929d+XPdSM6g5WrzZXnsgHIVnCwcxS5RtyRwSSqwkqDe
         4unpbgfcLNcGM74vMjABjs/qCgZ4mN7RKsETsmpoMHQl5VQ2aIrAbMZXoKgFqnvArwTd
         tZubEzWCbqB6JWcDpDJ1ILL+W+SdE9PujpAycIpnXEFF4nyzea6mE6cR4Rx7+CIGwO5H
         KKUCMhRaPwi3vr8sRObkpK4USoTi29dT7kdDqpVuTWOA4dgLeasOqgWzIeYnVXcdftNu
         3sN8k2pVQm+5jVShNU9QtDPPNiRWXg5vKJj7CjhYtUIaSlqUGf1xYMat3EBqbv39/2O1
         j7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXxdSkZ2xawp5x70VUzJ0ZQU2clnkaq+zr8sT+p8dQgiEzFgIayG2INkc4+AceS+p6s7BlFwDCe1H09QfioCaixaPTHwEvXfUk7Tijt
X-Gm-Message-State: AOJu0Yy7WROyQmcbksDMbOLoD3kf7OPVXfHis7mOlg1SAfdOns+cK013
	wYeb9BysH5lQuP2M79pj9EK/sDGv3QhDTSjB1Zvc61/Cc/eyyDgwehnNL2IBh71pSRP7xu1bmmH
	YrDo=
X-Google-Smtp-Source: AGHT+IFhxZ7NAK3s2WpweiweY2yeckuFL2Dz8Wu4zsfzGp3owFSCW3UI/IA1hRZ30CcIlSfJ7C9y2A==
X-Received: by 2002:a17:90a:b00a:b0:2c9:6d45:8187 with SMTP id 98e67ed59e1d1-2d3c3a919b5mr6378489a91.21.1723763078062;
        Thu, 15 Aug 2024 16:04:38 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2f633absm380677a91.23.2024.08.15.16.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:04:37 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:04:37 -0700 (PDT)
X-Google-Original-Date: Thu, 15 Aug 2024 16:04:35 PDT (-0700)
Subject:     Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <8734n5mzce.ffs@tglx>
CC: Renner Berthing <emil.renner.berthing@canonical.com>,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, apatel@ventanamicro.com,
  Paul Walmsley <paul.walmsley@sifive.com>, samuel.holland@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tglx@linutronix.de
Message-ID: <mhng-ab233e0e-973b-47d2-b0ca-4675f7967977@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 11:10:25 PDT (-0700), tglx@linutronix.de wrote:
> On Thu, Aug 15 2024 at 10:51, Palmer Dabbelt wrote:
>> On Wed, 14 Aug 2024 10:30:48 PDT (-0700), tglx@linutronix.de wrote:
>>> I'm very much inclined to take the reverts right now, send them to Linus
>>> for -rc5 tagged with cc: stable and ignore/nak any irqchip related riscv
>>> patches until the next merge window is over.
>>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> if you want to take the revert.
>
> I'm happy to wait a week and see whether someone gets that CLINT hack
> working or as I suggested the D1 PLIC early probe quirk.
>
>> IIUC the patch above doesn't actually fix it, that's what led to just
>> sending the reverts -- at least reverts are better than breaking users.
>> I'll post over there too...
>
> Right. We figured that out by now :)
>
>> And it's no big deal if we're in the doghouse for a bit.  Regressions
>> should get fixed faster than this, so we deserve it.
>
> For a week I consider you probationers :)

Works for me ;)

>> Probably also another sign we're way too focused on getting new features
>> merged, as that's coming at the expense of making existing platforms
>> work.  IMO we've been way too focused on getting support for specs that
>> don't even have implementations, and not enough on building real working
>> systems.
>
> RISCV is not alone with that. This whole industry is nuts about features
> and forgets the stuff what matters.
>
> Thanks,
>
>         tglx

