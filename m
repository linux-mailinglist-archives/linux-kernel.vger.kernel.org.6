Return-Path: <linux-kernel+bounces-330685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E597A2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E58628595C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65915574D;
	Mon, 16 Sep 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWkDfEF0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823B155392
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492017; cv=none; b=eB5Hh4LLMrYqAU65RTEKF74SARQCSm2rcf9UepFmdMZdRNfdMteirO7Q9F6ymL3Na2KrqvH0FsjTlwbP8igt0r0fDJfkL1xTSr5EWcYQ/ioQRzyEJvFmjaK+mBl3F6kSxqfT+Ey/IrlvMQvoyEN6s6G5mQQX2fknTtuBDqcmp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492017; c=relaxed/simple;
	bh=/qByNaWuoWPrxkM4E1LPgkTruxDhfDNAmxwqNdq0w34=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPiJAMrSAzXMZ8OmOcaq1fczOfQ9AgqTTKi9Tde++Ly4GLRzh+EbU5M0NEQX7tNYzbgsUULgvmydh2Tus0iXO/VLWXR29UiFRx9OMY3SOozdF+KvjesZa36w6eXMZ+Ael937OzxXqmmnjqiYt9qIUEVMerRQ2uPOkWqHygZo6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWkDfEF0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e5e758093so10181835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726492014; x=1727096814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01bA3eQ87yxP1v3+Sup0Pli/I9MSO00Bs20nRBnUXkc=;
        b=gWkDfEF0ciQomIc04qPnDAzQ3YqQAmXxwW0A7CXWxxmvsQghfrkD9f6Ydxt7yWyXZP
         VvxMI4PuOPhj043ArZhABgQUMo4xYwxYXqz+cW2x+nwnIb3W2R9YCvB6dFTQ48SsMnHz
         02OLEwWtgHb4dy31/vx+J4/QoLLjCP5bvffkoCQj029n5EjyeBtyk8+hvtuZQb8X/7v3
         Nw2ndgYBr7VBgQNZt59mFefCYxVqLXYiTvc0bwtLYgp2q9wyrNx8SHlOn2Wmvcn+LupE
         i8nGf3AsyH6aZvvOfxOR/wvepA53B9OyO60T/TLhW/+1kQe88MfYQ9v5/hj68qf5KL29
         V0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726492014; x=1727096814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01bA3eQ87yxP1v3+Sup0Pli/I9MSO00Bs20nRBnUXkc=;
        b=mRGWEMYdm0hTTWvPd75ug5J3VnYukgW0ArpjB8TGaU3YP1mo8GuHSWXGHdbl8S1T6f
         3tQxO14jeS3UVbfvBXvzg39EZ2Ufr1WnwW97BN8nenOUWBDM5PnFjqYofCNR5UtzwQoh
         DqSppz1DhqzizdRSyklaGEr2J9n6D0gs/RdqKgLIGIjbBO7PKLsMSK7PRzDuw0qZG0OI
         1dpP3jo8SZuCeH1F/N/fyjnGNPPlawV3Sg9TtNzqOdPpUXdK/gK/yFSXLjytps69iFiX
         Dx1IMyZEsUuSgIqwZ7S2gKoBaDA8Ls9VwfSXgl3kNhoH3W1TUZH5WPU0PaPeNp0q233Q
         LgIg==
X-Forwarded-Encrypted: i=1; AJvYcCV1ki3F1VOS1Yla4qgWaUnRQ9insk7sbs8ByW4HY43qawsqPTIzC2Cm75Jw48p2qpwpjlisiQK3qnh83As=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGALtz2dPuMuJtxX4shJpwrdC0K/YJARjK/PUBKp5dNTnWa0g8
	6ZLap4p5xWHEdH0D28k/gYOPGmxQiAtjcf5F4agw9f8kj/UNl9aZ
X-Google-Smtp-Source: AGHT+IEF/v1FQr6cAoRIjMFaNFemDgNbaga8/q9Ynq8knT4+1+VPiX+WoZ0EGxemZfJ7NBx1xzBzHg==
X-Received: by 2002:a05:600c:34c2:b0:42c:bad0:6c16 with SMTP id 5b1f17b1804b1-42d9070baa1mr73819815e9.2.1726492013673;
        Mon, 16 Sep 2024 06:06:53 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b194c57sm110569465e9.48.2024.09.16.06.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:06:53 -0700 (PDT)
Received: by wheatley.localdomain (Postfix, from userid 1000)
	id 8C3B024B44AE; Mon, 16 Sep 2024 15:06:52 +0200 (CEST)
Date: Mon, 16 Sep 2024 15:06:52 +0200
From: Martin Kletzander <nert.pinx@gmail.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <ZugtbMDP0AiPVrmt@wheatley.k8r.cz>
References: <f828f3177982a9cfe803d2aa8eb7602b70fcba50.1726482307.git.nert.pinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f828f3177982a9cfe803d2aa8eb7602b70fcba50.1726482307.git.nert.pinx@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Mon, Sep 16, 2024 at 12:37:13PM +0200, Martin Kletzander wrote:
>When resctrl is mounted with the "mba_MBps" option the default (maximum)
>bandwidth is the maximum unsigned value for the type.  However when
>using the same value that already exists in the schemata file it is then
>rounded up to the bandwidth granularity and overflows to a small number
>instead, making it difficult to reset memory bandwidth allocation value
>back to its default.
>
>Since the granularity and minimum bandwidth are not used when the
>software controller is used (resctrl is mounted with the "mba_MBps"),
>skip the rounding up as well and return early from bw_validate().
>
>Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
>---
> arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>index 50fa1fe9a073..7e6014176a29 100644
>--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>@@ -48,8 +48,11 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
> 		return false;
> 	}
>
>-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>-	    !is_mba_sc(r)) {
>+	/* Nothing else to do if software controller is enabled */
>+	if (is_mba_sc(r))
>+		return true;

I'm so sorry, I sent an incomplete patch.  This still needs to modify
the *data argument.  I'll send a v2 shortly.

>+
>+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
> 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
> 				    r->membw.min_bw, r->default_ctrl);
> 		return false;
>-- 
>2.46.0
>

