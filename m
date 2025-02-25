Return-Path: <linux-kernel+bounces-532647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ACAA4504F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F0D3B5902
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80A21516A;
	Tue, 25 Feb 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cX/ZfDhb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0A1FBEBD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522776; cv=none; b=mfo+oZBZ7NE/7E/yjnbatVyWvSYHnrynlsVtIAEoB9xFSoOEMcPp21fv6Ioor8fU1rmzqJBdn99xOqU4cz6VrfnJsMFXe671GY5scCo+J88F33SYdxrXNm40ESwd7qApVFCyA3bo/2pX0IiHF9GZyWpGqNr4xa5Wm7sbGxkEjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522776; c=relaxed/simple;
	bh=ASZpiCaz/lujoT+hKvH2SvCb3OzGoif6hv9DMAwNjF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FlYVz+QLOzZNg8OH9NhjphVEhf/OGANBs9ItCOiv5oQPzz5WuwJc2rUIBl1y4C4RLZ/2LcvVMcDYqrp6XUE5V1OpFLpHbUXfmr0MWuKa9vwOPr5yP5hqfFUZMgGsMT3SnkqqtjCNXsnCotLHVMN6RLTwnUf3HQDb3h+KpWkq3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cX/ZfDhb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so12714042a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740522774; x=1741127574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGwMJeTN+dKZHBUUmf4B4DWcKF/PGoO9rdnWonYrQT4=;
        b=cX/ZfDhbchmpkuHqIBbEKjzXthQFuJZuxO0MOIT9drK22A1KoQuL/ceXy6wPa8qlI+
         aXD32f0NFjSoMIEXdF3YnCUDpVBfQrSV3pW4DF4omsxar4l3hyXwvmYTKxxAUVQGWeYd
         tdLWDiR/SBR+85eLXzbTzAnG4exYK5krHWpTyqeuZkabqr4H/pQ1pfAQSWthtHYwdkN0
         +2i14CN4j9AJTT8rQ5KlJ6rrXJU2025RBeP77yGargK1oxBS5GeTrSE7EwXR8HhqRSi/
         ISrLU8RtKtaqh4KPsvIkgcMUYQCf9z8UjTVIKayxFonpDe4ONvqr5p1iOCqLiYQJTb41
         IQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522774; x=1741127574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGwMJeTN+dKZHBUUmf4B4DWcKF/PGoO9rdnWonYrQT4=;
        b=xC44fCeKfG1W0OaWWu5SWM4ps6rNmRhDHq/U1MalnRA9ZYr/vP/9lP8HQ30ELVZoZs
         9zZ3nFk0W/h3aEJ0zOhSyaSm3JEys4WoSGaZqpnEdUHkfPJxr7jQtAIHkPsmCtA9mJDn
         +JQ33+jK5m2I85myeeOm8CxEB6fpQKQZElgjPK7UXRj2JJ6TaBbe4h6WJBUg6JlMysCt
         rfNF0uwXqtHjL1Js22KKUJCumgMKZdpWPjuNKe10Y/6f4gRypp9+HNDt/l+hptU81GFZ
         6fBnPERiRtsqF1rNkaNjR5P0zc0k7IByY48R514w7e2vJ5v1bqkLvRZRHg5nk6JI59bg
         7pQw==
X-Forwarded-Encrypted: i=1; AJvYcCXF7VY+KbN9otP4nYO9ZyDw2M8Q55BE4HEuRhy6xn6nHqb8uP/QKt2cnT4Uv2XU4uPrSMFiEEosUNmTzOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUA/lteTkhwojA0090Lt6ikWJlm3+itU78vVOjv24K6WM1EUz
	eViiG2QlKuIS03b2SMdAoeCQL9oW4T7eaV181wyDBbypHcBbGFrW1c5Nzf/zLpMLMKwAn1d6E/Z
	89w==
X-Google-Smtp-Source: AGHT+IFdywSgZgWisiM3fsWoKNuqZEmY/ulK9kNQX86fbh4TBv6Dn9TbtR9/PAKzKbHi2Sbm54RZsl1lrMs=
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:2ef:8a7b:195c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ecf:b0:2ee:f19b:86e5
 with SMTP id 98e67ed59e1d1-2fe68ada443mr9176092a91.14.1740522774713; Tue, 25
 Feb 2025 14:32:54 -0800 (PST)
Date: Tue, 25 Feb 2025 14:32:53 -0800
In-Reply-To: <20250225213937.2471419-3-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225213937.2471419-1-huibo.wang@amd.com> <20250225213937.2471419-3-huibo.wang@amd.com>
Message-ID: <Z75FFZqPLyJgt-4g@google.com>
Subject: Re: [PATCH v5 2/2] KVM: SVM: Provide helpers to set the error code
From: Sean Christopherson <seanjc@google.com>
To: Melody Wang <huibo.wang@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paluri PavanKumar <pavankumar.paluri@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 25, 2025, Melody Wang wrote:
> @@ -3675,8 +3673,13 @@ static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
>  	svm->sev_es.psc_inflight = 0;
>  	svm->sev_es.psc_idx = 0;
>  	svm->sev_es.psc_2m = false;
> -	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, psc_ret);
> -}
> +
> +	/*
> +	 * A value of zero in SW_EXITINFO1 does not guarantee that all operations have

"A value of zero" is largely redundant, and somewhat confusing.  There's no '0'
in the below code, so to understand the comment, the reader needs to know that
"no action" is a response code of '0' (and is communicated in SW_EXITINFO1,
though that's much less of a problem).

> +	 * completed or completed successfully.  PSC requests always get a "no action"
> +	 * response in SW_EXITINFO1, with a PSC-specific return code in SW_EXITINFO2.

Please wrap at ~80.  Yes, it's a "soft limit", but preferred KVM style is to
wrap at 80 unless running long makes the code more readable.  For a multi-line
comment, I don't see any reason to wrap in the mid-80s.

This is what I ended up with

	/*
	 * PSC requests always get a "no action" response in SW_EXITINFO1, with
	 * a PSC-specific return code in SW_EXITINFO2 that provides the "real"
	 * return code.  E.g. if the PSC request was interrupted, the need to
	 * retry is communicated via SW_EXITINFO2, not SW_EXITINFO1.
	 */

> +	 */
> +	svm_vmgexit_no_action(svm, psc_ret); }

Malformed change to the closing curly brace.

>  	case SVM_VMGEXIT_HV_FEATURES:
> -		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_HV_FT_SUPPORTED);
> +		/* Get hypervisor supported features */

This doesn't add any value.  If the logic isn't clear, then GHCB_HV_FT_SUPPORTED
needs to be renamed.

> +		svm_vmgexit_success(svm, GHCB_HV_FT_SUPPORTED);
>  
>  		ret = 1;
>  		break;

