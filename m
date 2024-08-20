Return-Path: <linux-kernel+bounces-293318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0C957DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E0CB22328
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F516B391;
	Tue, 20 Aug 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeygWVjM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF32A1B2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724134936; cv=none; b=fqEKMl9t3ADPz4A0aBGAiXnENrzikye0lQjfwi15MYtBBUY5gA/1U3ULyZ6o3bESXwaOvZ2LGBxdC9WcsuU60QkCanw5YaXyq2GpgYX0PlhwgJqM7/yiHYnw0YxEF8ktwEhxtmL3YhDfVQNZ0IRMjR/sM9D9I30ur6qJLsj3v9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724134936; c=relaxed/simple;
	bh=nmpOsuhEd1VqW7WI90l/qT8cVMm+spA/xbcJrhh2aH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy8OvT5U5O/7bIqd014GRdK4NIb4nrbEBmC0COvZpeY7gSpfpTbSGBS1zzXBVwwx1VgjAHueZW3VmYytlmOxX3S1NokH1ZMc1o8cJKvndIU2IFao6uEQ8e9SzOGViLpUCkluSnYTujlbvpaAYMvVCf+0vhjWszRV66cwuBWdLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeygWVjM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724134933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXUQ6S9LUaXEBDyc5SfH3+dWBx0vw8nGBraXRhSJ9qk=;
	b=PeygWVjMQYRRwjSI0kaRdsp2h3iaU1n9hbu0iBvFrWUOHPGWrWaJe749+8emFcZDQeRoqC
	FW3ssbgrOARsI4v68Pyx8ssmSuvPOLCesowSjepyxJEn3jDEmdEb+GA2OSJAFEkvk3zcma
	u0ak1KeKqXI3hx9mBa1LCpDcbYvvmbQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-2ZB1VKNRN6WxLWbSg-eDZQ-1; Tue, 20 Aug 2024 02:22:11 -0400
X-MC-Unique: 2ZB1VKNRN6WxLWbSg-eDZQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7094db8ec7dso5156178a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724134931; x=1724739731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXUQ6S9LUaXEBDyc5SfH3+dWBx0vw8nGBraXRhSJ9qk=;
        b=X9QmsbrgHBp4pWnu1OstBHYsYqVovzYX+xDG4VMRdYQ4j7Xd3YQ8lzUWyIlcnqb98u
         uWCvFV/c4dTnXZMz0xwNwuj10Xv+RYcjhoWpIkF3KERTPGr3HsHCntwUE8vy7FC/ABIk
         vgUVwgpPnwc/wdv8rNE9fVHauk/KKzEq94PgMEsG3PAwPMn+WauXCmPK6e3rr60/tmDp
         UcTeI52cUgkpjCbWrtfhNBZasHX03UbrHqJ6T3SW5IyRsqM1JEeGM36IRqc7cCfbs0qo
         qnAMCsPBE7D7Me5QHN8XFOkAf/1bfVjrOYDuaxqRe4nBNk4on7c6Ff5yMd1qnsgBXl3S
         iI4w==
X-Forwarded-Encrypted: i=1; AJvYcCUFO5BtGqWlXB1Y4mTyNNUGz9UZTnyrT1u0c1OkfgnuvXL/N7LEtveeibR1U12iiQYSnxJF2jSdXIkc5s4t4peY4HfvMntLfK/Jw84L
X-Gm-Message-State: AOJu0YzpYXKbLTtTtnBOuuP753GrC45FyKGw6V3IZRMVjBjU2wKwdD5x
	5FnwjUlVlwGaoj3rH26YgLGId/soE41bxXTJgtKOQw2PW4bLoDwlaY2V9YTDuaMHowGxfyNZRIS
	uc6/rDrvBm3g2vqeWzpAXJ+kych+cNpTEeF2Oxn9HaCj5tXbM7Dx8OtqsVUyPRUWEZQUepHMip9
	P9zEYy6A1kjAZGzptgTeZqu8RFbch/o6FeBlnN
X-Received: by 2002:a05:6870:224d:b0:270:1708:b7 with SMTP id 586e51a60fabf-2701c3ee79amr14224569fac.28.1724134931053;
        Mon, 19 Aug 2024 23:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb5d3VIV1ox5jbNO6hiX/HAXSAHPhftdaKo6KlrxFXT1fY3Fj9Jd2s4VBnZBE1CJ8hZWTbmM3nNJ0j9YUlCus=
X-Received: by 2002:a05:6870:224d:b0:270:1708:b7 with SMTP id
 586e51a60fabf-2701c3ee79amr14224554fac.28.1724134930629; Mon, 19 Aug 2024
 23:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-5-costa.shul@redhat.com> <87wmnrj4uz.ffs@tglx>
 <87seyfj4h7.ffs@tglx> <CADDUTFx4XPtAYNUPK03BSFH0p8Z17OCftEb7aq+f6VqpnEWkoA@mail.gmail.com>
 <87zfsbb7a3.ffs@tglx>
In-Reply-To: <87zfsbb7a3.ffs@tglx>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 20 Aug 2024 09:21:34 +0300
Message-ID: <CADDUTFzSAXm-OUhC8OZ9vL1pYuVybjofUuYa4hWi9y9N0QtCfg@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] sched/isolation: Adjust affinity of managed irqs
 according to change of housekeeping cpumask
To: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com, pauld@redhat.com, linux-kernel@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>, Bart Wensley <bwensley@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> On Sat, 18 May 2024 at 04:25, Thomas Gleixner <[1]tglx@linutronix.de> wrote:
>
>     Reconfiguring the housekeeping CPUs on a life system is expensive and a
>     slow path operation no matter what.
>
>     So why inflicting all of this nonsense to the kernel instead of
>     cleverly (ab)using CPU hotplug for it in user space.

On Mon, 27 May 2024 at 18:31, Thomas Gleixner <tglx@linutronix.de> wrote:
> That's non-trivial because it's not only the interrupt affinity.
>
> Drivers also have their queues associated accordingly and if you just
> change the interrupt affinity under the hood then all the other
> associations don't get updated and don't work.
>
> That needs to be solved at some other level IMO.

Hello Thomas,

Our telco clients run DPDK in OpenShift/Kubernetes containers.
DPDK requires isolated cpus to run real-time processes.
Kubernetes manages allocation of resources for containers.
Unfortunately Kubernetes doesn't support dynamic CPU offlining/onlining:
https://github.com/kubernetes/kubernetes/issues/67500
and is not planning to support it.
Solving the issue at the application level appears to be even
less straightforward than addressing it at the kernel level.

What would you recommend?

Thanks,
Costa


