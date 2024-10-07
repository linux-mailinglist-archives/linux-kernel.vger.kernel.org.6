Return-Path: <linux-kernel+bounces-353945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C189934F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36272280638
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7BB1DD536;
	Mon,  7 Oct 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XBbk2TTm"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035D18D624
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321981; cv=none; b=mAnT2tFY1SLexbzjEBVW0NoLl8ogReD58tiEBB3fpym6MsEFN1M7M5ap6aR1Z54UtG3cnw3Nm/blbDE/Y6T6NICWeyqWzMC2CICC8cLJBEwrAcHrWrU2IKsQX1eHOOukhjxq132JwJnzCljdQjTSiqkdLE4ICXqu/bq20anqjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321981; c=relaxed/simple;
	bh=4qQEphBKvk8M31ANqTY8ST6ybCd2aMPTyFq1EXbp24Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axMSB0FRUdTSGqsU/o05Z8y6s/8FkWcWb7KYrTjyyAOwUvUS3Dd+KozrhkqOsx+A6KpFEGhAWckIWVPz5i7wEeOVPrHtz1dNH3hyVjUiQORVMpJMxj58zqQwShVZEZU2pjuCB6DNWrJGaJAxmmx5Bv7n4AZE9T9Y1lE9eh2eBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XBbk2TTm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso812006266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728321977; x=1728926777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NpGAocpAw/FPuQxEaYG6XWJIDzd4pKCEJY2xZgGA3Tk=;
        b=XBbk2TTmWcMt0jFOs3dyvki8DZ8YTCOlvx84YQoWmtERrvVlwJ3PxljfezK9t5ta8q
         RF7igbSUrfbQeoyZurixItTZ10mMAh2wVkProMHVOB0PVRVgG5aOmTJ0pnUIrCvAP8at
         7YO0tPofy3DTYOdokjz58qfOVgqQJYaNhvfWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321977; x=1728926777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpGAocpAw/FPuQxEaYG6XWJIDzd4pKCEJY2xZgGA3Tk=;
        b=jaRzMmSCQ82S056C2+pC5qD6R+313VYsMPaAmxqVrSvZMcVfLoeqnFT+RBCE7Mhy/h
         mG1sJqosq5xgzV1u229z/iqDpePfCjhVNWh4iceUvqqZOxyTVFxUBs+wmxPZaTjUSG68
         O0RbwTtMbi1iHxRjgfqx8FUEPByHY9PqZ3pwGKPk/hxzVGTtXsQ/60zaEnYSDKf27SEJ
         5Nvd3Gm461MamtyQlcePbZBDXv9jnxFJEa4kSfvzghAkntqVsKhIo/pEyioehdlUSOun
         6UIdFNI8tOmK8OjtPHNAlYq7cCCblDcPUWiENxrpnpk8bUdZ6hkZVNPyjfpCLZFC+nGS
         fZ8w==
X-Gm-Message-State: AOJu0YzrRxxD1jYYdH+40u+IdPu2oqgtopyf26AR2Ly75iyiwDdQ2b10
	s0w43/ovKI5kGRKyQztfR16S5Kp7mduRoVAxR/FmLxNMtJML8E6S29wtwPGg9MTm+stiUFfayd8
	jaho=
X-Google-Smtp-Source: AGHT+IGL2y8ZOgwAUCuFCkwWE3fYBXKYVwipBGcyaOKP3ExQFCAAv2hpfJZUZjKq/cgBFpNrCCD1XQ==
X-Received: by 2002:a17:907:7e8e:b0:a99:57c3:1fbb with SMTP id a640c23a62f3a-a996789317cmr50753466b.9.1728321977472;
        Mon, 07 Oct 2024 10:26:17 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9949c54efdsm254427366b.60.2024.10.07.10.26.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:26:16 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso812001966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:26:16 -0700 (PDT)
X-Received: by 2002:a17:907:7d8a:b0:a8d:3fb6:33df with SMTP id
 a640c23a62f3a-a99678aeeeemr45173166b.8.1728321976095; Mon, 07 Oct 2024
 10:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
 <3016e3d6-f916-4a6e-82a5-2bfcd1f2dc2d@roeck-us.net>
In-Reply-To: <3016e3d6-f916-4a6e-82a5-2bfcd1f2dc2d@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 10:25:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4zK9YY1rsghi5CJHYfLypj5OBHUgtMuytXZw=Vbea_w@mail.gmail.com>
Message-ID: <CAHk-=wj4zK9YY1rsghi5CJHYfLypj5OBHUgtMuytXZw=Vbea_w@mail.gmail.com>
Subject: Re: Linux 6.12-rc2
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, 
	Wei Fang <wei.fang@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 10:00, Guenter Roeck <linux@roeck-us.net> wrote:
>
> The failed qemu tests are crashes, bisected to commit d9335d0232d2 ("net: fec: Reload PTP
> registers after link-state change"). I copied the author and reviewers for feedback.

It seems to be this in timecounter_read_delta() (inlined into
timecounter_read()):

        /* read cycle counter: */
        cycle_now = tc->cc->read(tc->cc);

where "tc->cc" is NULL (but that's just a guess from the fact that the
exception happens very early in timecounter_read()).

So presumably the timecounter_init() hasn't been called yet
(fec_ptp_init -> fec_ptp_start_cyclecounter -> timecounter_init).

And looking around, we have fec_probe() doing

        irq_cnt = fec_enet_get_irq_cnt(pdev);
        if (fep->bufdesc_ex)
                fec_ptp_init(pdev, irq_cnt);

so the fec_ptp_init() is called conditionally, but
fec_ptp_save_state() that does the timecounter_read() seems to be
called unconditionally.

So that commit d9335d0232d2 looks just broken. Either the
timecounter_init() needs to be done unconditionally, or the
timecounter_read() needs to be conditional on ptp being inited.

                Linus

