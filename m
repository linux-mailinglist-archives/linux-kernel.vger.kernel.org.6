Return-Path: <linux-kernel+bounces-564697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226FFA65971
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71BF189035F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2280D20487F;
	Mon, 17 Mar 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3Y6SovF"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10226204597
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230408; cv=none; b=XsT99Qcsj45tjonq4z2+LI/6YeLmlNDVbD57J11IYmE6ccfVinJhUtD4V1M0mJj/k1XPmXXSXLVJtwsiGZ/z1Z+6jso6ZGHmK6gp/e96fDlQYXAfVH1IrAN6ldfYKafHk1We/32wQ2XPLQUNqd7GAWGKhCLKcVDFUlu4NwVnbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230408; c=relaxed/simple;
	bh=qXnVOgqYG1FQiAJ7DrIUcFxKM+SXGAYFBrMi0yRhVLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VBNzCRvsWlWAxwp0Tb6BVEPjqrdf6X0JXKFbapSwSkbAChpfJCN8gKsCTJsv/BfZma1CEoljmUPtXXZ3UsDNylsVGdR6B98qtuE7/M+msWACdOII9+9RD48LKcjB4LsAuip5pbFzOfceL5GhNF0B3NvPp570193Mxa3wViHue48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3Y6SovF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so6276244a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742230406; x=1742835206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v444Ih8Wrl3P9CM41VrD5YikquTct6TP/BZ+x7IqEJw=;
        b=G3Y6SovF+SS2UXIOsTCgWKScWPrmOHoD9kfv6i5s2qv3KL2EO545T4qI0XeA9mJJlx
         YlqWGkPuqSMwIkDxFjZUNzKIsj2uiVgsqhDQpeekpXMb5VgOOlCuGblSc7nYGvwAH7uj
         MzyLDXaeoc4OIZDzMYz2OeArIqOOH1giH87UMAGHQCsKpLSLKpnL0OfOqQDMhg9zrEoH
         XOdlf28YV1+vZzrPmdbzTJ6S0fEuUQwJLd8p2LVumexoI3FDGkppoBkzveE15BnajrDm
         wmrgHN5pXLr6RQyFH9D2tbs3LKfYKkoB29mCBBCiw+Rc/0ZAo7wt1lucSTDE3pmx9p5N
         DPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230406; x=1742835206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v444Ih8Wrl3P9CM41VrD5YikquTct6TP/BZ+x7IqEJw=;
        b=enSEzLA1uqKlUOoARPmNHZMOOY/agI7YuFdKFqwIHGZl17qxEYN738IvCmHcDM6ncV
         uybK713XRejrnwFWBT6PaIgEl9oEIYDeomvZO6OaOkIcrnOOEYWdk8/ZfH/2qjDRcmqi
         NLhmEj2xdLVgwAFGu+PvxBmNP4DYAWLh04dHpFKlGuHp2YexY2aUAqZ3iGL5oq5rAHlt
         njqFvOj7ydtTd4lQzZr6mfev1JXS7COzkI9MutFy7r+S8MCgKTp9wINK2WyuPmUE7DAs
         aCQuETGsF7tk77IS0f5KXjAw5KvgtXwKEkYvQnBC3efNVDnM2qq7j0BZi4vq4cN7KDqO
         Macw==
X-Forwarded-Encrypted: i=1; AJvYcCUttDhzzm9da3YzfCDCsaS+xT5xlqYUd4yw3bjVMyFvlCocfmzy2wWP2+6Gw1YF7nQEFgk2U17RsW4P9uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2V5zBIaKWvic7woz8KO3vYtTGE9JNh4pfa0A9RriF3sCN2OGV
	5uEKT4mysSc/Bg0AqC8hA4jVmuJNpdbmAtc+BK9AfIvDTPWiwgr73KGExgL/DcnZa+XzO+6t0OX
	PaQ==
X-Google-Smtp-Source: AGHT+IFOoYATiC/rIu32xRtF+lQHMNYL63/M8Ury4RfsKkWn2hqTxV2zJEn9dcXHvExkZwAcFk/2LTNCnBE=
X-Received: from pgvo23.prod.google.com ([2002:a65:6157:0:b0:ad5:45a5:644c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3397:b0:1f5:769a:a4b2
 with SMTP id adf61e73a8af0-1fa4428f019mr428693637.17.1742230406330; Mon, 17
 Mar 2025 09:53:26 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:53:24 -0700
In-Reply-To: <87wmcn4x78.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315030630.2371712-1-seanjc@google.com> <20250315030630.2371712-3-seanjc@google.com>
 <87wmcn4x78.ffs@tglx>
Message-ID: <Z9hThFNFrrbXjkjc@google.com>
Subject: Re: [PATCH 2/8] x86/irq: Track if IRQ was found in PIR during initial
 loop (to load PIR vals)
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 17, 2025, Thomas Gleixner wrote:
> On Fri, Mar 14 2025 at 20:06, Sean Christopherson wrote:
> > @@ -409,25 +409,28 @@ static __always_inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
> >  {
> >  	int i, vec = FIRST_EXTERNAL_VECTOR;
> >  	unsigned long pir_copy[4];
> > -	bool handled = false;
> > +	bool found_irq = false;
> >  
> > -	for (i = 0; i < 4; i++)
> > +	for (i = 0; i < 4; i++) {
> >  		pir_copy[i] = READ_ONCE(pir[i]);
> > +		if (pir_copy[i])
> > +			found_irq = true;
> > +	}
> 
> That's four extra conditional branches. You can avoid them completely. See
> delta patch below.

Huh.  gcc elides the conditional branches when computing found_irq regardless of
the approach; the JEs in the changelog are from skipping the XCHG.

But clang-14 does not.  I'll slot this in.

Thanks!

