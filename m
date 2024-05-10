Return-Path: <linux-kernel+bounces-175480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF28C203F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656AD28251E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71DF15FA87;
	Fri, 10 May 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cn+6fzU9"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478E1607A3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332183; cv=none; b=K+HfQcfxpBYPFYU9WfSXlTWyItqFltSK9gqIUvbXqasMbdGePbK9ewVIWRJ678KC/diMa+sMeNSW7nqPgP0tiC8ty3iwujGLfHvV9l6dd34dtqc7gqx6GrCy+J9g8SDFmqK8+52AeHMIyj6QRLJUGcAdsAWqx1GSpOZtYOqqImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332183; c=relaxed/simple;
	bh=9yIdtQp3ur1f9Zjf3zmNi4wTquzd2hcg9pPvEGak2SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlAq+9NRUq65WpvXFCcoFiUz+JuuOWATE5z5O4S/RQBXawxTs/I6I8WatnYdK7dbXNrH8rtnXge3iSSp3iyHleH0lPpChTtAuM1cDbUTWxjbGk5bcdCt4Hy1ST1JNqZzoSQsdiG+It9EuFuqxCr6AkUF4XusuchzhJmkVwvzmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cn+6fzU9; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f0e79215a9so496200a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715332180; x=1715936980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yIdtQp3ur1f9Zjf3zmNi4wTquzd2hcg9pPvEGak2SI=;
        b=cn+6fzU9CQbKSFu+3w/g/5GrIUNAywHSk3egpBiaip5T2mB3gXKAR1R1PtDaUEtJmY
         b/GUCk0x1qJvdp4t4DcHaYsYHYrpmT/z5Y5gMk3MpdfW2dczAzr+Mex1ElWfnjqfMRZT
         Tna9AQODstVHiiFmY6YAv3afkfbZ0sUWNf95HS/tqqfpgtzlq3h13Uf0iY+L4MhpzfBJ
         KHSFUbm1vQbGrIxdCwVZXFUsOJXrRn6EA6C1qu6gCSnqcbYZGTIlE5hOLoefhFLRftIB
         6gpSGhtvOCfVcqzFkONQGFtTtkvKWh1DJ/GaxeX4Nz9UJfsL+OnQAuB05HDMcLxrnblN
         0EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332180; x=1715936980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yIdtQp3ur1f9Zjf3zmNi4wTquzd2hcg9pPvEGak2SI=;
        b=Wo9XRlwIR/NvrqQS2aI1dZ4yqoVzZEZrTXlmcM51VHqeZ4/V+yMepES+/Bis05Dlpe
         D/dtn+U0uOKWmE2/bQIGV+qNh2B0SQXJ0ociXLWHWJGAnIAQC20JEeOSE0GCthPFbcGx
         eCNZ3a4BHaAZHTuskc7ed3Iu2ZF/Rmm5V/8rmDI8dsD4VBGJ9PIWgUnmL5hxskw5/Gej
         X804jN3EfZuD3VBn0jFiyMfxVmjGTKN9KryOD04ChmJ2ADWj27OMJsVpQX+IaA7zzZiu
         QULCnEVN4RTjSl+81shyHCIGeN3y0L84tigxsMm3bLFpwnwD3QAofUjDELV7D5vHqm3l
         /V9g==
X-Forwarded-Encrypted: i=1; AJvYcCUPodr5r6wOZNr92WvP5T2hNbY1Y6kC0VgfSZMPHASHFwD18ZOirqTA/dZH2nYczwnO2fHxvuzJyWbeE1bR+sY4zo0KpEXH2XyjQZxh
X-Gm-Message-State: AOJu0Yx5r9DJO3IeEHhaq2/mzFAW3Sg5XqN8Mz28NZAapVnMQIudSfhE
	ntWgAQKc8KJedM2/NTPfwAg9sFgDHN/+EWLS1Gx+RldNV7g/8nRGRrWbnnrlBksGVfb8ga/lSVj
	/GrO/XMbspsJp0wNxodINd4y05Y3y8YUXcjq51w==
X-Google-Smtp-Source: AGHT+IFJUZsn5cCFuDu7+oE0uV3M2KrJJj2xWvL4ycCzP3mzWGKzZ6Zvm6RZSzXcZCEZoX2rhgdaX1mskMRMuYwjnB4=
X-Received: by 2002:a05:6870:6387:b0:233:5f71:4461 with SMTP id
 586e51a60fabf-24172fc60b6mr2387986fac.55.1715332179485; Fri, 10 May 2024
 02:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509073300.4968-1-cuiyunhui@bytedance.com>
 <20240509073300.4968-2-cuiyunhui@bytedance.com> <ZjzrXnOc5AAost4O@bogus>
In-Reply-To: <ZjzrXnOc5AAost4O@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 10 May 2024 17:09:28 +0800
Message-ID: <CAEEQ3wkHc-EaRPKLivZoxO6jKXv9bigbYhacWouL7+KbgbwWpQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Sudeep Holla <sudeep.holla@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jhugo@codeaurora.org, jeremy.linton@arm.com, john.garry@huawei.com, 
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, tiantao6@huawei.com, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

There are already related Reviewed-by, Gentle ping...

On Thu, May 9, 2024 at 11:27=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, May 09, 2024 at 03:32:59PM +0800, Yunhui Cui wrote:
> > Before cacheinfo can be built correctly, we need to initialize level
> > and type. Since RISC-V currently does not have a register group that
> > describes cache-related attributes like ARM64, we cannot obtain them
> > directly, so now we obtain cache leaves from the ACPI PPTT table
> > (acpi_get_cache_info()) and set the cache type through split_levels.
> >
> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I am not sure why you have not added my reviewed-by as I was happy with
> v3 onwards IIRC. Anyways, I will give it again =F0=9F=98=84
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> --
> Regards,
> Sudeep

Thanks=EF=BC=8C
Yunhui

