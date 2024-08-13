Return-Path: <linux-kernel+bounces-284066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F1E94FC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E73282B39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517ED1CD16;
	Tue, 13 Aug 2024 04:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pttmDIC3"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98A1BF3A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723522123; cv=none; b=Mw7NoGC5f7L50CjvJVZ3cpaPyHWzki89v26TE2An2UbLjso6Wje4mZBKFEYSJfWck2tmiT8NalXhcpqdU9kIz4yL4ee70ag/VLAOymxaOzbip1t+HEAuUof/MlFG1+4XUi7MyNLGdZBxcNjWk/LZDyMlRvxn6ooRX7W4Lt2uHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723522123; c=relaxed/simple;
	bh=fntJhyjcOy7oflqhtRO9KzJcdMa1SeI7MODbm3MN5k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eE+AZ0v+qCiQ/QQE5VC9xynM1TFuKhvt8kcz5rourEOFZYCC8UUTcswt4fdatYsye6reNUJ5YYx69Bpz/JPTg8yl74lgO6sXKYh2VlmgjT7LHpVyGAe7h0glHOP0gtAc4iwHhAKa1xDa8BnnxIQFozxYZAi0aMjqrnfkQ9L3obE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pttmDIC3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-721d20a0807so5143513a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723522121; x=1724126921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHWstkZJouFpjxURopjUp/N24tS1IjVlq4SVfgNsTjg=;
        b=pttmDIC3mo2QvDY0rB/HLf9xG8H5+2h+oxtP6JF3ueCkClU6ipnmFiGJeRgp0Fr/fP
         O08xiI9cALKHYN41+5BpUkYRtc5zfqGUTZddwWnzg0lOvdwqShPDQNPwyI7aOZSiWMct
         kfcVxEqDk2C83YJ3kr3jAuibwGaYdzi++0YfhuZcGV9kX23UwoHdpYoyQCdbvWs3rFQ3
         xESPpvKpmZUe7rSgLiOh/ttK9TwXkCZnhfgCgPFfvHkB3+YrBLl6Q8YxUMdDxG5308mG
         OZkTouYL3WQibvAiG7WvLAtXtYSBGbfiYk/BCRUhIh81e1qha42K/zV62q+MFdYf9XUC
         AlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723522121; x=1724126921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHWstkZJouFpjxURopjUp/N24tS1IjVlq4SVfgNsTjg=;
        b=vGJaLa9EhRedg8/Fpxrla/SI0paGaGJ1vZ7ZRLzXk5l3UmaqMSDlXtm9CWlnEZgrcE
         zH5tGYi0eWOcjZCAwC4Peu/5ZoK9fMgEv9hsKDohlq7f/qZNJKoTYcvrrsTZYCX6yoZZ
         3NTu+j0Qu7kmt/lGRdMfXi9ImsKxaDQPyiBGmoDUb2VmOZ0y4P8vmGorF3Yt8CiPEo55
         Ub+PfTLt/lh5W+45fBu41HN/RBgeENOvob2Fzr55mwVlPrn/4OPkqoHt6+cSnKv98tvS
         6gVJpQuEfRI9FlV0ToQ8QB5E5ZqrgBPclySwRmqJDEVMVDRp+q4oLIP54D3TWullcTg6
         2sag==
X-Forwarded-Encrypted: i=1; AJvYcCXO306Ljdi6BBDKLrLoQ4Oi75aXcs457PrZutapJzHz+FXZacJK+LYh4x5VVBDoma4Ly7Am+uQFBE4iPLcStCeDxq47uppzdu17pROu
X-Gm-Message-State: AOJu0YyA4cdska1884EUF/Xr9vl01uS3VGKHWZlQ3BW2Kh4W8EFQNfQw
	ZOTvvs8brpEIEpn9rHgPtjS4Y2k2/lE3xu0IF+FtOdHGEMehUQHa2HIachcBBIKIDg7mhEHpijs
	Jrw==
X-Google-Smtp-Source: AGHT+IFy3tS0mDbLSJ3VFDM24v3F0/Bto9CsIFpJ5YeCwKlmxhaKPoZAnTM6U8EqvRJ7bCMM985q93CMz9Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:db46:0:b0:6e3:e0bc:a332 with SMTP id
 41be03b00d2f7-7c69507d656mr4242a12.2.1723522121034; Mon, 12 Aug 2024 21:08:41
 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:08:39 -0700
In-Reply-To: <20240612115040.2423290-3-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612115040.2423290-2-dan.carpenter@linaro.org> <20240612115040.2423290-3-dan.carpenter@linaro.org>
Message-ID: <ZrrcR-kJ8hP6afWb@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Fix uninitialized variable bug
From: Sean Christopherson <seanjc@google.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: error27@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 12, 2024, Dan Carpenter wrote:
> If snp_lookup_rmpentry() fails then "assigned" is printed in the error
> message but it was never initialized.  Initialize it to false.
> 
> Fixes: dee5a47cc7a4 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The compiler is generally already zeroing stack variables so this doesn't cost
> anything.
> 
>  arch/x86/kvm/svm/sev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 43a450fb01fd..70d8d213d401 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2199,7 +2199,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn_start, kvm_pfn_t pf
>  
>  	for (gfn = gfn_start, i = 0; gfn < gfn_start + npages; gfn++, i++) {
>  		struct sev_data_snp_launch_update fw_args = {0};
> -		bool assigned;
> +		bool assigned = false;

I would rather delete all the printks, or if people really like the printks, at
least provide some helpers to dedup the code.  E.g. sev_gmem_prepare() has more
or less the exact same behavior, but doesn't have the same flaw.

>  		int level;
>  
>  		if (!kvm_mem_is_private(kvm, gfn)) {
> -- 
> 2.43.0
> 

