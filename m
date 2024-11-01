Return-Path: <linux-kernel+bounces-393035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE09B9B34
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CB61C20EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEE1946BC;
	Fri,  1 Nov 2024 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="f6+dqw8a"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAA16DED5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730504153; cv=none; b=RoIJINpn4TvyFbA3t2MjLbYJYaL02hzYBtvs5lSCj/5mFMQ3ZPd3aEN6tRJ5IYp8OFPaXYQGM4xUK80cJYuAyp1KLYrDfmoUTxTQa979C2FYc6VhYbPIoq75xfRU34K3FpBdcF9qzVMVapCfWL2FnwUwcIV3+ytT6j9FMQhOKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730504153; c=relaxed/simple;
	bh=Ue885HcxmPf0L8ARa1j6S9W4nBVkiVf0INutQUO3kS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJlcFTx/jeiO8V+8hTmUi9YbEJbvTXwtKp51t3KaRTh4QesHrxYIZYsBINAr1yVZtbY3rgTK3hl2mUkyfq1ThKleK3C4lK6DCZBgWDXnodkL3ZQbPl/LXvsMxEExWevLbYiixquiuHVq7PFLhYBj3sHsCmjnnIDJPtPtDxxAlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=f6+dqw8a; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7edb3f93369so1732670a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 16:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1730504150; x=1731108950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue885HcxmPf0L8ARa1j6S9W4nBVkiVf0INutQUO3kS4=;
        b=f6+dqw8al4caZhNFFLtdIFnc23Kleeh1mFV+MsH4J4ITexl5Eml1ZEyRHtH+GGEc78
         QM/9thD8Q+2DFtnc3E+wDQqUpvQXRFRqTpS8+cbQrAc1GZsBPqG/+gVb+7rOk18Jpta5
         ehLAPZSs2VfdG+kKxVcqQw8tWj14kjjUTshRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730504150; x=1731108950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ue885HcxmPf0L8ARa1j6S9W4nBVkiVf0INutQUO3kS4=;
        b=l7w38wM4mV+7VXmbaxXKIHpDjvREjruXpEu1PhYPDBAFfFvOtiH9lfC/pE9TNeKRrf
         9UqH3SeoAIvb/eUnzMzd99e00tVTJsY1jrlDVtyBGBZs/3ZIQb7jCpU4jmKrwUBmL0wn
         dSwoTxeQdHe565Jdf4GtEkAIn2SuTuLmXVLpfGxTwZh7iibd0pYOoLooyfjVoKnBLdhT
         zMBM6fojj4m4f4CpTtkxbVlotj10qefofxIy1W6zNMR20MZlgh2GNQTG+BoxCAI2cNpY
         N7FIJil0wk3oH0fKf+Ysa75NPrxc38TuapIHfGJIuUR5KD16k5Ky2UAxphU/skLpI2XB
         TIDA==
X-Forwarded-Encrypted: i=1; AJvYcCVHYICawuRwCSggT07DMxa6cNhYrLw/cLzkdxj+FaRxb3LQQSeziw6vloA8ZETlWWvj8jCRzG0lrGgCVhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFtc+7SMG83T4Vmlk9WwpP35tjBpF/A3krEhYOskMfsjgm0Jf
	/EO59mzxKJoH4uOGRx3cBzLWQFzMnP7kNlnAi70yQSRft92IRSDNXLOAhIIEmeZvkhmnXUSjwSH
	9w37OiQdQtoCbr26nXSOrAWntLTWIuXzQBAuh0mX7VcoWeRq0
X-Google-Smtp-Source: AGHT+IGSCCGc2XOfqTuOFo5khzBYSCD3q/i/ZhvzprTRm0qV62b3/sKYvu1Q2BKXYbheXAm5J0pQa/GsCtf+WDDJFOU=
X-Received: by 2002:a17:90b:5306:b0:2e2:c15f:1ffe with SMTP id
 98e67ed59e1d1-2e94bdf49acmr7314138a91.0.1730504150505; Fri, 01 Nov 2024
 16:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e7636a21a0274eea35bfd5d874459d5078e97cc.1727926187.git.fthain@linux-m68k.org>
In-Reply-To: <0e7636a21a0274eea35bfd5d874459d5078e97cc.1727926187.git.fthain@linux-m68k.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 2 Nov 2024 08:35:39 +0900
Message-ID: <CAFr9PXn8Wi8btubVXKTNNQQyQRtvWaYV5aHyvvQLypJYp5i=9A@mail.gmail.com>
Subject: Re: [PATCH] m68k: mvme147: Fix SCSI controller IRQ numbers
To: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, stable@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

On Thu, 3 Oct 2024 at 12:32, Finn Thain <fthain@linux-m68k.org> wrote:
>
> From: Daniel Palmer <daniel@0x0f.com>
>
> Sometime long ago the m68k IRQ code was refactored and the interrupt
> numbers for SCSI controller on this board ended up wrong, and it hasn't
> worked since.
>
> The PCC adds 0x40 to the vector for its interrupts so they end up in
> the user interrupt range. Hence, the kernel number should be the kernel
> offset for user interrupt range + the PCC interrupt number.
>
> Cc: Daniel Palmer <daniel@0x0f.com>
> Cc: stable@kernel.org
> Fixes: 200a3d352cd5 ("[PATCH] m68k: convert VME irq code")
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Reviewed-by: Finn Thain <fthain@linux-m68k.org>
> ---

The other part of this that fixes the SCSI driver itself is now merged
and backported to stable branches so it'd be nice to get this merged
too.

Thanks,

Daniel

