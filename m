Return-Path: <linux-kernel+bounces-542003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F5DA4C468
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6CF188201F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CF4214217;
	Mon,  3 Mar 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctAxVKiT"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0B212B04
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014780; cv=none; b=cjp8IX472qaGiolW2cTOeHjCtH3kwMCT7JiVjBxVBdjXlDp4BXkBRNvH0v7rot8w4kTYsrs56ywGLs03NqCB76YjLfQLrSdcgB6VaFaxxEY7XCiEs56gxVhY+jOnLf3RbDllsDbjKdJFqfDS1nizKdUWVC+L7CITnHdGcAgcFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014780; c=relaxed/simple;
	bh=P9F1ofeYrCy0v/tXEp86XKR4kq6FqY1je5tQrslWrMw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nQ6JBV0/bEP9sAhoFKCr9AEkYdCgVkHPwLQBZVI9vnov2jkCWb+iZvyhHMBhgfFrfzOfRp8mdXBtvLCVDGtDr1RKfJOddrizCuSrHKeSZ5GR5vgKYHwOi5zgYVhJ886vTqInibW+9ibhq5LqbGop0EjIe0H5BnhY018rNaUBg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctAxVKiT; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abf597afe1fso237862666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741014777; x=1741619577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDvNDSBHwWtbzP2LN4FrATbN6y8fQnYjZO4RYaZIKfs=;
        b=ctAxVKiT0tlyEXKEQfZUjfLQX7QQOUOpWPeQiUwtYrj7ZD8k1VOnUxm0FsBSItIwYx
         UGYnN/xDVdlY0aZF49Br1+GNhMdEUUIWJXSG3ZyGovG1mfz7mBFPD+RUB+fTwhxsyLci
         xhXAcITyCY4MufYbbThKEOk4qB6Ap6QueEDUVw1Fh1bYsQVq3xfFcJSterhyTuYbcVlJ
         EG8KD9I/4x9BNse+p+x279WJWCUOgf6D9H3pbX70XpEuJnvTA7b2gIzzP5/1hn/+zjzz
         c3mDInlvYp0mUvZvGJY6kxAotakQ6H/vUAx1qAX/o1tJi6AxCZO4rixk2Oa+Lgfa7qQ+
         PF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014777; x=1741619577;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDvNDSBHwWtbzP2LN4FrATbN6y8fQnYjZO4RYaZIKfs=;
        b=QZX68mZKQ2N4xM4umr/Uko8cjI9kLukwla7SoKOiLd9sh0gqHEZCw7heAEFPGqN6hZ
         uSYyDWEWBjAHdpykvtTUb5CBRJpCiDtSwJvkERMED7NRjERuOCsNCSXrH+xLFECfomQ+
         omT7i39rZKQLtkXEOIQESkXtAF9kWDb7am19mw77hhFmxto3MATMQ7WFpinr168TdmzA
         xpj0stIPjX8vTHcU+0Yw3pTPo4uZ3Fuu3vVRac0o5u7xX0I0v5S+Pn4433Df74MJ5Isc
         N1dEAZl/NcgJI1i7IJcUoiiiA2gYoT5fqEdZzhdZz0UXgcVi0lkxFLKqace1OL1YSN5R
         LEjw==
X-Forwarded-Encrypted: i=1; AJvYcCWNjAvA3MviYdwD/KQBeKtAxGZp8jdOwS+mT48U6JzruNhJpH0oq1qrD05QuMTBu+ueLgKdG9rqrvDRGEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNv60pGSB6EBT5R2hdx8MyXsiqdy+i5Lp4z0U5Qo/8iqJcpL1
	OyorHblBuOZUzpTv6VnzPjNSfqpWbKU265OkWDrFgo+s6go3UrE00O+loJR1CFwOazEfxcXvnTA
	rvW4j0cqwSQ==
X-Google-Smtp-Source: AGHT+IHoEuw10xjAFK3YffNpBzL0FGxTUI0tpeWG2zIYS0277Gf09Ura44LMHf5llA6zU5CoNjFRM4Oo2iaZhw==
X-Received: from wmbjh6.prod.google.com ([2002:a05:600c:a086:b0:439:9558:cfae])
 (user=derkling job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a48:b0:439:99ab:6178 with SMTP id 5b1f17b1804b1-43ba66da248mr109415265e9.6.1741014369703;
 Mon, 03 Mar 2025 07:06:09 -0800 (PST)
Date: Mon,  3 Mar 2025 15:05:56 +0000
In-Reply-To: 20250303141046.GHZ8W4ZrPEdWA7Hb-b@fat_crate.local
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303150557.171528-1-derkling@google.com>
Subject: Re: [PATCH final?] x86/bugs: KVM: Add support for SRSO_MSR_FIX
From: Patrick Bellasi <derkling@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Patrick Bellasi <derkling@google.com>, Sean Christopherson <seanjc@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Patrick Bellasi <derkling@matbug.net>, Brendan Jackman <jackmanb@google.com>, 
	David Kaplan <David.Kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"

> On Wed, Feb 26, 2025 at 06:45:40PM +0000, Patrick Bellasi wrote:
> > +
> > +	case SRSO_CMD_BP_SPEC_REDUCE:
> > +		if (boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
> > +bp_spec_reduce:
> > +			pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
>
> Probably not needed anymore as that will be in srso_strings which is issued
> later.

Good point, the above can certainly be dropped.

> > +			srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
> > +			break;
> > +		} else {
> > +			srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE_NA;
> > +			pr_warn("BP_SPEC_REDUCE not supported!\n");
> > +		}
> 
> This is the part I'm worried about: user hears somewhere "bp-spec-reduce" is
> faster, sets it but doesn't know whether the hw even supports it. Machine
> boots, warns which is a single line and waaay buried in dmesg and continues
> unmitigated.

That's why we are also going to detect this cases and set
SRSO_MITIGATION_BP_SPEC_REDUCE_NA, so that we get a:

  "Vulnerable: Reduced Speculation, not available"

from vulnerabilities/spec_rstack_overflow, which should be the only place users
look for to assess the effective mitigation posture, ins't it?

> So *maybe* we can make this a lot more subtle and say:
> 
> srso=__dont_fall_back_to_ibpb_on_vmexit_if_bp_spec_reduce__
> 
> (joking about the name but that should be the gist of what it means)

I can think about it, but this seems something different than the common
practice, i.e. specify at cmdline what you want and be prepares on possibly
not to get it.

> and then act accordingly when that is specified along with a big fat:
> 
> WARN_ON(..."You should not use this as a mitigation option if you don't know
> what you're doing")
> 
> along with a big fat splat in dmesg.
> 
> Hmmm...?

After all the above already happens, e.g. if we ask for ibpb-vmexit but the
machine has not the ucode. In this case we still have to check the
vulnerabilities report to know that we are:

  "Vulnerable: No microcode"

--
#include <best/regards.h>

Patrick Bellasi (derkling@)

