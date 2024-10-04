Return-Path: <linux-kernel+bounces-350077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99898FF6F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86CA1F2353F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEF146D6F;
	Fri,  4 Oct 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMnt1KIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95F139D0B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033292; cv=none; b=RrfcG76roZxzBVO+KJ1Gk+ic5TpgRrUVqE50o6jhACgz4trzbVTrgU/2hntg8Cb/9vM2szFl+mMdLzzIWgLaLFDK7CrbWDsr66Qs9M2JZjDpXT5kgKEIF/eMVxMBVeKlyzn/9p+h8rzWGCXVC/Y9Bqau66QLRQMYflnZUmItSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033292; c=relaxed/simple;
	bh=V2Qj0SS6sJwvhGcjrnnsABf1noNZUpQ15/Y5HwOOMuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1IQ1JGsCwMTs9jLoG+2m8aGQU7J4xe52Lp80P515PfflV3o6iD/Y9uALA4E1QgR9MveTm8YjA02P5IRrlH/20Jsum8Rl8uuu0dmCh9cXilBXKugejuuWwb8T7HOILhJcXgn2h7cDOXX/qzqqr0mw7zF0CLg50Fx7gR5vDpVp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMnt1KIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728033289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDOhSSfnwqEV5M0b6XkkFn1mNvs67Ik1NMNpWbXHdQA=;
	b=XMnt1KIT18eaBoBJ8aRqUlRxMk/FbeUSenXjMSO9S8X5p5yVOpYgDeXB52VVy7YBkzgQ2J
	xPskT9jbGcs35BqKEVB4gXp75DFFmhhIQxQymu7/D9u41SGb1OrSAVeP6141SqqiBNA3/1
	+VZSyvoSWIvernEvqG+pzhwN0+IMKtU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-OgWGJlFKMU2HpOdkH6tH3A-1; Fri, 04 Oct 2024 05:14:48 -0400
X-MC-Unique: OgWGJlFKMU2HpOdkH6tH3A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb22d396cso14300815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728033287; x=1728638087;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDOhSSfnwqEV5M0b6XkkFn1mNvs67Ik1NMNpWbXHdQA=;
        b=F6IeynBIYrHlmLg6psUAxM2RBodm0if6zzUiO5f+tf7fDKMKOVtPvxXho7PlZnrfLe
         B8iSQPj/31ayrCStZ4fxF13WdEetxzX5cHmZ3wxemFWHiNwm9EhAEOD2C0OpF9vQs7vE
         KgSbhb5P6zoPnUACSLsrbz7RE1Ex2Eneo+idN13HL1tCkrBehSgMV+ILcRddHRhMjizH
         uEOJ6Qf2/NTMcgxQJhSKHyQy7NE+8hvFkVVzP1HbrW/yflfwgVu4KGo6yjJ/mgCS+lj2
         In4m5ElYsUM/81iPublIs97Xk2x2M3y/dMzk0Asgq08FbHrTqHRUoDAPvf/hBpYUVrmG
         0/5w==
X-Forwarded-Encrypted: i=1; AJvYcCV8Xl4l4HNz7bxKiqaJ+/cWMAuEuR2cex461ZnNK5GfKAEYgBzGF+0Wzq0Vx52oplQFKnnh0XdsmR7eyPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXcBbdUMogXZkQZPe8uSx4dthzSYxsidHDM1Ia/zKdt/htiPX
	lFbY+x5SPcxN6Dnwqu2tn61qfHBks5hHIPyLy2MI7anTn8Rx9BH+8s2DT41+9oExit3iFxdRa8b
	dbRAX0IVabOJ5q4MxF2/fMYvmf1Sxl/gp0zc/YaA0qU/QCtUwVGkIV06d1ECW6Kl2NPY+WeKbXu
	L92YHbr5KB6ZACwmZwKkn54K5zPosinF66ulvYXbteGY8XBA==
X-Received: by 2002:adf:a31a:0:b0:37c:cc60:2c68 with SMTP id ffacd0b85a97d-37d0e6bb81cmr1345604f8f.5.1728033287145;
        Fri, 04 Oct 2024 02:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGhqszp2byTwfYsb1sEdeUX+x30sy7KoKJePxqxzJs0lVKO6UVrJ46owbj/tONeLV1P7YaZQ==
X-Received: by 2002:adf:a31a:0:b0:37c:cc60:2c68 with SMTP id ffacd0b85a97d-37d0e6bb81cmr1345585f8f.5.1728033286666;
        Fri, 04 Oct 2024 02:14:46 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6cc9sm2854736f8f.75.2024.10.04.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:14:46 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] KVM: selftests: Ensure KVM supports AVX for
 SEV-ES VMSA FPU test
In-Reply-To: <20241003234337.273364-12-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-12-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:14:45 +0200
Message-ID: <87cykgi60q.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Verify that KVM's supported XCR0 includes AVX (and earlier features) when
> running the SEV-ES VMSA XSAVE test.  In practice, the issue will likely
> never pop up, since KVM support for AVX predates KVM support for SEV-ES,
> but checking for KVM support makes the requirement more obvious.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/sev_smoke_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 965fc362dee3..ae77698e6e97 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -181,6 +181,8 @@ static void test_sev_es_shutdown(void)
>  
>  int main(int argc, char *argv[])
>  {
> +	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
> +
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
>  
>  	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
> @@ -193,7 +195,7 @@ int main(int argc, char *argv[])
>  		test_sev_es_shutdown();
>  
>  		if (kvm_has_cap(KVM_CAP_XCRS) &&
> -		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
> +		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
>  			test_sync_vmsa(0);
>  			test_sync_vmsa(SEV_POLICY_NO_DBG);
>  		}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


