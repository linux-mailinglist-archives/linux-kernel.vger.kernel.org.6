Return-Path: <linux-kernel+bounces-231440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A259198BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E151F21F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1D190679;
	Wed, 26 Jun 2024 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEKL4PXV"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E41922C5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432531; cv=none; b=HSoyr9PdpmIVaMUKehQKDOIZa6sk5+DI3XNPP/FtImGVYXEJGQuSC6wxjA6ixAYMvjPLP209g2lQl1uN9IFhnDKVbYNJAglujdb+g01Tr0vsoO9+kDpvabggpfjbbYiKUkOqSYiUfLGDkKqzWqnkc3K5fEHC6waIVVlAOnh/ZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432531; c=relaxed/simple;
	bh=4S0EVxaJe8fpJ7++KuVyrQMRoO8WSKD0yaA4rxhijs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sp48X50Gd+5XA6nD7/hS38gh/6I8eK0waqgA4qYB52pws3h2nfesVDfxo4oppjxGhbzbEa8BzNToJGnMjB/xdKPKV1tMqQBK23gxL0kzzOZZyenYRBF/+OjQlXRJpj1gar7iBTz0mbHQ6s4rPqzn1M91zg1yAn2KvbWBOouwWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEKL4PXV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c7a8fa8013so8757753a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719432529; x=1720037329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZUK64owq78D+nkswI+vsRdMEdD3oJn8Wq+egIOghUI=;
        b=IEKL4PXVO0GlCgwOxnCdQYybwkGM5V46ZfWYAaT7ALdCVTwQv7Yl5J0UDZgy2qcouM
         CHO6cwzwIaZdrMUE1zM6LymCv54Ya8E9YSdXiwnm3V9PGjeloCtImZPLyGWD7jxD5onA
         TVWkfFgfiu2bZ86GVwbxFLNOmAU02vhmbA3gVBRnAlZC19bRk8zKBDFNED+Np1sN4cKG
         nGZ1Tl5kTz/CwwpmAZbXzuQ45lUi9rOTWcmlFZP4ZO2a7TIcGLo1egvsGyS6ZP4T3MTr
         Xyvq4oXlUBcsP7QUjHjBn+s+crlW1s9zuPUXtsRhxUB3BL3EoEY5ThMRIWzqWBxbzR6L
         hV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719432529; x=1720037329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZUK64owq78D+nkswI+vsRdMEdD3oJn8Wq+egIOghUI=;
        b=DXQOlXBLqWPRUS9FKaFYMPzul/IxwgzrDyZnn9nzgFAq73zCRNhdy37XVBlWR6Cac7
         QafOY7wQzQbIS+/6o0PQxi+6wS2LBmdAjEFcwWCfQ5zA2w7q9UxLMGQMws411fmPaHVM
         NGnmeC9xdjVgid9LS9qhdOv+42q3Ed30ZvRrEAAun3r5+q2T3meIVKQiFGc0MiUNg99t
         yTClkn93pVhGbscM0AVPWr0cmDsMmPk+IvRr4uQokSM3cRYRlJvdyMB+Gzi+BYCKAQZa
         p69DWqBfy2ad7cB6aznswmrGJdmkmCCM9pHHnHPJXdj4bQv9XV8vQMPqOd8bUiI3xNV+
         j/qA==
X-Forwarded-Encrypted: i=1; AJvYcCUwUIT1I8l1DwNGKgJuqqmLPmy4WmA7hOpHhnwJ0vcm9PUwaU6XDVF5c0JHJC5nujZ7YWyO3tPDIR2yxEMTsjsV/Xv0EwQaupJiQaOh
X-Gm-Message-State: AOJu0YzJD4UovPHAhwdg+5QPHekfwQTF2BToN9isjaLRsnzQW7R+TnIK
	GDKL3bQPf9gksbQ2GW+B9sAqFLL8AbHHcvwfu/ZnqZrcHA3KF7qpsvhKO6UU2X3Z3n1T2BKLni6
	/QQ==
X-Google-Smtp-Source: AGHT+IFobNEQjS9eARQk343geD0ViRI6gKHOTxtiSoNxckgqOSHSLxWkgoxi1wsgrpQuiN+Asg30a0OYQEc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d8c:b0:2bd:f679:24ac with SMTP id
 98e67ed59e1d1-2c857c4b24emr39492a91.0.1719432528807; Wed, 26 Jun 2024
 13:08:48 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:08:47 -0700
In-Reply-To: <20240625-bug5-v1-1-e072ed5fce85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625-bug5-v1-1-e072ed5fce85@gmail.com>
Message-ID: <Znx1T_hHNA_uThf2@google.com>
Subject: Re: [PATCH] kvm: Fix warning in__kvm_gpc_refresh
From: Sean Christopherson <seanjc@google.com>
To: Pei Li <peili.dev@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com, llvm@lists.linux.dev, 
	syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 25, 2024, Pei Li wrote:
> Check for invalid hva address stored in data before calling
> kvm_gpc_activate_hva() instead of only compare with 0.
> 
> Reported-by: syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fd555292a1da3180fc82
> Tested-by: syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com
> Signed-off-by: Pei Li <peili.dev@gmail.com>
> ---
> Syzbot reports a warning message in __kvm_gpc_refresh(). This warning
> requires at least one of gpa and uhva to be valid.
> WARNING: CPU: 0 PID: 5090 at arch/x86/kvm/../../../virt/kvm/pfncache.c:259 __kvm_gpc_refresh+0xf17/0x1090 arch/x86/kvm/../../../virt/kvm/pfncache.c:259
> 
> We are calling it from kvm_gpc_activate_hva(). This function always calls
> __kvm_gpc_activate() with INVALID_GPA. Thus, uhva must be valid to
> disable this warning.
> 
> This patch checks for invalid hva address as well instead of only
> comparing hva with 0 before calling kvm_gpc_activate_hva()
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> any issue.
> 
> Tested on:
> 
> commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ea803a980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e40800950091403a
> dashboard link: https://syzkaller.appspot.com/bug?extid=fd555292a1da3180fc82
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=16eeb53e980000
> 
> Note: testing is done by a robot and is best-effort only.
> ---
>  arch/x86/kvm/xen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index f65b35a05d91..de5f34492405 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -881,7 +881,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
>  					     data->u.gpa, sizeof(struct vcpu_info));
>  		} else {
> -			if (data->u.hva == 0) {
> +			if (data->u.hva == 0 || kvm_is_error_hva(data->u.hva)) {
>  				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
>  				r = 0;
>  				break;

Hmm, I think what we want is to return -EINVAL in this case, not deactivate the
region.   I could have sworn KVM does that.  Gah, I caught
KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA during review, but missed this one.  So to fix
this immediate bug, and avoid similar issues in the future, this?

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 93814d3850eb..622fe24da910 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -741,7 +741,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
                } else {
                        void __user * hva = u64_to_user_ptr(data->u.shared_info.hva);
 
-                       if (!PAGE_ALIGNED(hva) || !access_ok(hva, PAGE_SIZE)) {
+                       if (!PAGE_ALIGNED(hva)) {
                                r = -EINVAL;
                        } else if (!hva) {
                                kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 0ab90f45db37..728d2c1b488a 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -438,6 +438,9 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 
 int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva, unsigned long len)
 {
+       if (!access_ok((void __user *)uhva, len))
+               return -EINVAL;
+
        return __kvm_gpc_activate(gpc, INVALID_GPA, uhva, len);
 }


