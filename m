Return-Path: <linux-kernel+bounces-174725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8988C13F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93B2282E23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF61118C;
	Thu,  9 May 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR95zewp"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25E4C8B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275247; cv=none; b=aen1u3mKjjYvOUE/fikNY6fnQus8bZ6H9rlyswlRs4RWxoGS/DRGYAuVnTPDdbqtu3nLuiouLufdzeot0Ag/ZmaQjCBfSfH6/lGbv6bIVVeHagCfRs1LyfF4nECVenI55Yo8ILsV/usE6QpapdxXvzfJ8yUS9C1h8quCUs9gWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275247; c=relaxed/simple;
	bh=2VdN5360nE8Rs4Q7QfvHLL88JPhHZUayj90hKIeFeKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJN9j3CqH+mH8HdN1w2F5r4A9C05Z2L2YhQjD5AefrT9fw9FC42L+iKm4wex6yfYpz8r5M4T4dCXKxCcsxVuaLEikPqAGPgSklpAAOckURrZAKxuUFl8VQ5IzmdGWphr3FSmpacFdYvgLmGlgPQII8ayzrLrWrua4XlhyrAB0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR95zewp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62036051972so12080857b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715275245; x=1715880045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk24WOVBQ8v9+/xBnGWVKv0pPEAEDr8oetxf6a2mo9U=;
        b=JR95zewpqMiYUQTLn/tncro0IKycIF9yEsmQ/qLFdbhShVp7ZirIGh7RMRXriwPUos
         wTQhWLdFRTBlphT/bNh2MWvAo0VDaz2ufTzAMPpgHO77eLnq5rC5YYmuFX/mVKE7F0vX
         G62+8uD/Q1fGn7LwjznLOiRHUWd/FcacaoPMDffxV1JadPlrObTLysSWAivaje55NQ5B
         +Hgtw5gCkaWsMjYQrLk81AYdb6Dl5jRYrOVeM7W3uU5oR8fD2EZ6Vw4V+reAof33Onnm
         +BO3h9fGbfCg6ojLvmEuHT/WAr92O6xpWGyicae79CosKucJEwfoE8KFRNE8xeQ8qn5J
         uiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715275245; x=1715880045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk24WOVBQ8v9+/xBnGWVKv0pPEAEDr8oetxf6a2mo9U=;
        b=MDnRwKvwq9ZRsAbeFMCqIk0n8sJ/v0Os6RZd1Td5Cquch4Y5b4qSwh+5AUCoD2xhdp
         FFk666nzR5pI6pjp2TdQOdVBVFpwZy8mS0W45x6oBDKP+peSSY/iz48Wp0tV4TDwWBow
         kBStho/vFReOpGyeMjeDxvNfu4jqKVhyptxnW5sxcnyHTyWJO8CdHzjPNAszD/zgUtIA
         POcBlPbn8AVTJrxq12b4sLVLmZQAakAoeuTHb6hn8AAda0wlKgKc3yjZWPWJmSZI+eLR
         ha1DlLEnXtH3k8Wh9tW44AP/hqb9C8WKjcU2XLK6qVapAdEou0e0q2o7UxAi1Ck5Uz90
         kvCw==
X-Forwarded-Encrypted: i=1; AJvYcCU/2BYo5cet58sMaDMW9aZlf9KoaSoftHy109Qoe7OFS4aiRKxfbBX8Pm3Bh0VjmVPNZohvRQH0KNLJP+5Odgn6hlo9k/L9EaBqpDNw
X-Gm-Message-State: AOJu0YyaRZhOkQB+pthVn/zykPO+ryAHgqYdNrI4mEPgxMKc7GWDj4K/
	z4rzs/m/ltpwEEQ/Q/fpWI7YwAvgNkxuFjZC9Zorx/AvTDGACR6jUPfnvkf+Ay4SnVrtCZrjaqk
	hZT5uUv8GQZ2SXAh+9c8COdJq5yM=
X-Google-Smtp-Source: AGHT+IF/8aJnUmfrbIpqLepFsHh+KPVVHIMPAmFClHK9dvSymnfyrdiejmwyETC2hEx4OHI/zQa0DJ/khRPhKw3RN2Y=
X-Received: by 2002:a05:690c:4382:b0:618:79f5:8d32 with SMTP id
 00721157ae682-622b0164185mr1225457b3.48.1715275245056; Thu, 09 May 2024
 10:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN7PR11MB660461A6E5F3FB4546B5BDB9D9E62@SN7PR11MB6604.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB660461A6E5F3FB4546B5BDB9D9E62@SN7PR11MB6604.namprd11.prod.outlook.com>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 9 May 2024 22:50:33 +0530
Message-ID: <CAHhAz+hvb+8sT3BYS_pT3Lmi5X4PjYWRJR=hvmX1e4Ays512FA@mail.gmail.com>
Subject: Re: Seeking Assistance with Spin Lock Usage and Resolving Hard LOCKUP Error
To: "Billie Alsup (balsup)" <balsup@cisco.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:56=E2=80=AFPM Billie Alsup (balsup) <balsup@cisco.=
com> wrote:
>
> >From: Muni Sekhar <munisekharrms@gmail.com>
>
> >Here is a brief overview of how I have implemented spin locks in my modu=
le:
> >
> >spinlock_t my_spinlock; // Declare a spin lock
> >
> >// In ISR context (interrupt handler):
> >spin_lock_irqsave(&my_spinlock, flags);
> >// ... Critical section ...
> >spin_unlock_irqrestore(&my_spinlock, flags);
> >
> >
> >// In process context: (struct file_operations.read)
> >spin_lock(&my_spinlock);
> >// ... Critical section ...
> >spin_unlock(&my_spinlock);
>
> from my understanding, you have the usage backwards.  It is the irqsave/i=
rqrestore versions that should be used within process context to prevent th=
e interrupt from being handled on the same cpu while executing in your crit=
ical section.
>
> The use of irqsave/irqrestore within the isr itself is ok, although perha=
ps unnecessary.  It depends on whether the interrupt can occur again while =
you are servicing the interrupt (whether on this cpu or another).  Usually =
(?) the same interrupt does not nest, unless you have explicitly coded to a=
llow it (for example, by acknowledging and re-enabling the interrupt early =
in your ISR). Certainly the spinlock is necessary to protect the critical s=
ection from running in an isr on one cpu and process space on another cpu.
>
In the scenario where an interrupt occurs while we are servicing the
interrupt, and in the scenario where it doesn't occur while we are
servicing the interrupt, when should we use the
spin_lock_irqsave/spin_unlock_irqrestore APIs?
> From a lockup perspective, not doing the irqsave/irqrestore from process =
context could explain your problem. Also look for code (anywhere!) that bli=
ndly enables interrupts, rather than doing irqrestore from a prior irqsave.



--=20
Thanks,
Sekhar

