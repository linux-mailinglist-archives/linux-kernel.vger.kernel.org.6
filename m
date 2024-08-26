Return-Path: <linux-kernel+bounces-302134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8FD95FA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0422817FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE53199E84;
	Mon, 26 Aug 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMPDm5it"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA612DD88
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702751; cv=none; b=NA5xaoIW9IoVbC3C1NIBOjiwf3QuH6VTWS20TYZqf/QHy2DNQoIjX8a8OF2gY43MqZaEkgJzO54fvOoRQ4W9W0FWJbXd9xkTlrP5gFtFoM/IA9D0olhuLWn7QzitUsQoo7citjbe/lLILvkFhwZ21b+REJa/eU2Dx+mocgtqn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702751; c=relaxed/simple;
	bh=IUpfP3Sgeq5oBNkk/3ORO0MyKxei7eyBm40BHBM5L4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tc5mc/CSd6toT3lLThocfmMe8B+pGh2GQJLcWqO/SPqTr9VLUvqjTlMtVTG4oHuRT0+G3o3qIoTEBrZVt1yM+I6rInq5yOttaDARX10eJG+KxnRB9kz2Bh/24nSKGgoOLKW1kMMdxLmGa1qyByhpeVSi7C99asSExvEptU+GbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMPDm5it; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b4eda2f2f5so69571747b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724702748; x=1725307548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnxIhNbH4Gch2W3JBVVv+gBN+5BkAO7Ys6CmFB2+1ug=;
        b=cMPDm5itG+idQUTB+/oQRYuTrd5UeEVzxxDpp5M6ii5jhzv6RXDD+oyZ5S+BH2yJ5r
         j4O4gBTRb5MX00k8suLA+pykgUpK25HBlMSFXOZH1nouS0EThspLzvOofrROup+S+pb8
         HTYuepGFIHFxVcLhfMxRtulP4xPCW2Q9hlGAoeuUNGOaNjXzuvwR4VZtqF7FBx6/yB+3
         ijWcCWtjVYdpQ9tmSaXTRIQZYOKy0x+v6FF81HF55TIIGYFgthMEFt2g1pmdARPjvd8M
         0klFl3g/xLRBs/HhhZcnldoF23y0kUX1VcgE7qK0hBdCwdSHo2QQBEu0mWU/t7bF0vQr
         1k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702748; x=1725307548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnxIhNbH4Gch2W3JBVVv+gBN+5BkAO7Ys6CmFB2+1ug=;
        b=SWmuWEpTkyf3AdSZTIsBo02H7xLQEyvBS21+8jxqoCjOJtH8hnM3amZITDcFXUiPxy
         AFHOi3mT53e0uGSV8JmJKYXTu4vA1ZCqnk3Isk2gRAHyBLfsj5tJcDKc3+hP/hqhRkqX
         mwtnynjRIFRunaR6jfSrIkgfyBVkmV2+23SH5NBaoavDAjIkH8A9qMhlaa24C83IG2FX
         SyqjuI1nfpdLO88eYU5Zk/Cf5ACTV7vDZ5XEKtLbY9+NJRQgj+5YeD9QpBHHn098w2J+
         tvwdzLx+VgU/sAC1L0+DFXNty1hpNyCta7SUbwReJi8vj/zqMSHpZtAqBeTwJbQQ66pa
         cowA==
X-Forwarded-Encrypted: i=1; AJvYcCVuZY5q4Aca+TvMoTHqJiqdzue8Y5BoBFp9kVhF1ORoNxdgBjWF8vz/+AlVlFomnLZ7JQC5wtTOq5aOGLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBu04aXw6oCRg5GPxn8D7a1ZuKSI7WgLevozO+TXgi0vWKDXoN
	pR7KsnkGazmNRFURF5z7Kecj3kSJrnL9S5DAuWpwJx8KyysC5A14m1EYW4qRIz3krdi5tiWYonv
	RuQ==
X-Google-Smtp-Source: AGHT+IGLSh4YWTamDhAv9x2uzuZdYhGakrF4oXP91GrZ+B9R3joQTi/ORWEEJKAfgGtk+l47h8Mnz0Jd94s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2188:0:b0:e16:55e7:5138 with SMTP id
 3f1490d57ef6-e17a80075e1mr22228276.0.1724702748409; Mon, 26 Aug 2024 13:05:48
 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:05:47 -0700
In-Reply-To: <096cdf1b-bc79-4e88-8ae9-99a373245ef8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822202226.862398-1-sohil.mehta@intel.com>
 <ZsfJUT0AWFhoONWf@google.com> <096cdf1b-bc79-4e88-8ae9-99a373245ef8@intel.com>
Message-ID: <ZszgGxZLDQYIEJpX@google.com>
Subject: Re: [RFC PATCH] x86/cpufeature: Add feature dependency checks
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, Xin Li <xin3.li@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 23, 2024, Sohil Mehta wrote:
> On 8/22/2024 4:27 PM, Sean Christopherson wrote:
> > On Thu, Aug 22, 2024, Sohil Mehta wrote:
> >> Arguably, this situation should only happen on broken hardware and it may not
> >> make sense to add such a check to the kernel. OTOH, this can be viewed as a
> >> safety mechanism to make failures more graceful on such configurations in real
> >> or virtual environments.
> > 
> > And goofy Kconfigs.   But yeah, lack of any meaningful fallout is why my version
> > didn't go anywhere.
> > 
> 
> By fallout do you mean that the observed behavior when the kernel runs
> into such a misconfiguration

This.

> or just the general lack of such
> misconfigured hardware/guest?
> 
> I tried experimenting with the behavior for the last entry on the
> cpuid_deps[] table:
> { X86_FEATURE_FRED,                     X86_FEATURE_WRMSRNS   },
> 
> In this case, even if WRMSRNS is not present, the kernel would go ahead
> and enable FRED, which would cause a panic when wrmsrns() is exercised
> in update_task_stack().
> 
> I agree to the second part that such conditions are more likely to
> happen in pre-production environments.

And in VMs, e.g. unless the SDM explicitly says FRED implies WRMSRNS, it will be
architecturally legal, if unusual, to advertise FRED with WRMSRNS to a guest.

> But I still feel that for the rare case when something like this seeps
> through it would be better to disable the feature upfront than run in a
> kernel panic or some other unexpected behavior.

Agreed.

> > https://lore.kernel.org/all/20221203003745.1475584-2-seanjc@google.com
> > 
> 
> The code is very similar to the one I proposed. If we do take this
> forward, would it be fine if I add a Originally-by tag from you?

No need, you came up with the code independently.

