Return-Path: <linux-kernel+bounces-406620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7429C6177
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B121F22E95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE19209F2C;
	Tue, 12 Nov 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+lKv/I4"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C518214424
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439843; cv=none; b=clQvITFhpoW0YBlr5c2EhUiMQhAss7PJ5SzBIhYoBAAzVvEo3dwmYKDvflQ1gANPlzG/o75vLaumLeoCL9mxVNq/7es0PYAfKWdkbfo+BOw+tBgGb1hcmThw9qDkWghRbCy9ahDMXXxUWYzzA50VxYmtMZBSh/zXw/SFUGX32K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439843; c=relaxed/simple;
	bh=Bw7yG7hIAVf72qATOe9KuIJdJ1BLU50StvC3OShE7x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBwGXpsuOYS8lI5OelO3S2xZ2MhBBdlKC56LIaRt8+YM5MQ71y7H0TFh3XXt2la+vW+ChvV86w+8MOB8q7rHrn4KccDZ5odONkxmomygD1oDVpgbkrlLrR+aJ8HHe9QdQzRY1DtHW65rU1K766vYZALPvkNylJtntJjOaR4AiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+lKv/I4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so823131566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731439840; x=1732044640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL7/5I0UejJahIrSSQ2JJZpj8WRu9ElaZGQSA2O5d9w=;
        b=3+lKv/I4ri80aauRz3wguYdXoxJIJbkHJbPOlhbvUznrYZBRHpI9lnBVCdpBjCD5MN
         6kylzl0ZNSYgsX8htAdDv0Ghw5pa2nWfE9chs0R5lwpZAfRl2Vc7swSyVGchHZZW4i/q
         o7s1Qs/xoN5+jhQRZ7DQhULM/1SbE8L60gvcO9DEcTVOai/8/OUtklX2ccvkT1kLVic7
         TGQZbr1w6k9Ll6q3Z5LaIW5dSxyLgfN208ZSFhpuQntgpwmtv1DbRuBq5FUz29SE1d3q
         NwtaEEANVYzhbeTK2NBFLZqm1mEZILG96GosEiQHLwTzLWjnXyhZ3cuyHcgbpDjcsvh/
         5QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731439840; x=1732044640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL7/5I0UejJahIrSSQ2JJZpj8WRu9ElaZGQSA2O5d9w=;
        b=jIuSuICKJsVpxqT+QHdsBR2nEQsSUFRm8K7Y1e4kFV9wwDAR61D1HhuPlLTuMwpnHb
         9hXlmOSY72Lj0THDuvu7w1865+aOD7YhM8kqJ6cNsOPunjjKMPoh6BZrNfFcWpI+9Wx6
         x4KsSe5bIpiHQ8gYP+2HhU24cM8KgKEONoTooTBOyLOWZIKSi3OLekbT8+zdwp/pBTcL
         FnOZUM0Lf44za7gQwCyTvD/bxNYLSDtxz5rfxcnizwbErdghGeH1gJEkLMxbqcxPml6h
         Af3U7NowFEFA/mdZfCoMrRD48/0OUYYEp0xgdJJegCOPlO+Zq75zS9G+eFCkMntrwcoF
         ukjw==
X-Gm-Message-State: AOJu0YyfakH402pdFCXxhEeraTM/B86TUWgKS/vZcf4xVjqUbqJjjN+5
	34hc27q2LKuCc+D9oY62TNQVROLl6OTIQQujB9gBgJ9mN/W0Hh1Ylja3g/8naiZlCftgcKBMqQz
	ck9n2oYMdKyY6XxXDQT6S7TUWT4Xoe8w2WCk4
X-Google-Smtp-Source: AGHT+IEF19hOX8AadWSfBjs29gQgzK5yh9aRT0DGOB4INyutV+2Swu8IcpZilSblZ2WeukCIwk/EeYtI9W/CghAwC1s=
X-Received: by 2002:a17:907:9494:b0:a9a:8042:bbb8 with SMTP id
 a640c23a62f3a-a9eeffeeeb1mr1736395566b.47.1731439839427; Tue, 12 Nov 2024
 11:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
 <20241107232457.4059785-9-dionnaglaze@google.com> <d49430ec-8701-72c1-36ab-4d9e612ac443@amd.com>
In-Reply-To: <d49430ec-8701-72c1-36ab-4d9e612ac443@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 12 Nov 2024 11:30:26 -0800
Message-ID: <CAAH4kHaQ0hh03aSPQ1N6t4zYwFMi6f0QOOa8sQoJqnobZhSD2w@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] KVM: SVM: move sev_issue_cmd_external_user to
 new API
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-coco@lists.linux.dev, Michael Roth <michael.roth@amd.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:52=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 11/7/24 17:24, Dionna Glaze wrote:
> > ccp now prefers all calls from external drivers to dominate all calls
> > into the driver on behalf of a user with a successful
> > sev_check_external_user call.
>
> Would it be simpler to have the new APIs take an fd for an argument,
> instead of doing this rework?

Simpler but I think worse?
The choice of using sev_do_cmd versus __sev_issue_cmd in kvm's
implementation is the matter of dominance of access checking.
There's no need to check the fd in the activate function or
decommission function. It's not needed to be checked in a loop for
snp_launch_update.
I can either complete the removal of __sev_issue_cmd in this patch or
move to make the context creation function take an fd. What do you
think is better?


>
> Thanks,
> Tom
>
> >
> > CC: Sean Christopherson <seanjc@google.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Borislav Petkov <bp@alien8.de>
> > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: Ashish Kalra <ashish.kalra@amd.com>
> > CC: Tom Lendacky <thomas.lendacky@amd.com>
> > CC: John Allen <john.allen@amd.com>
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: Michael Roth <michael.roth@amd.com>
> > CC: Luis Chamberlain <mcgrof@kernel.org>
> > CC: Russ Weight <russ.weight@linux.dev>
> > CC: Danilo Krummrich <dakr@redhat.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: "Rafael J. Wysocki" <rafael@kernel.org>
> > CC: Tianfei zhang <tianfei.zhang@intel.com>
> > CC: Alexey Kardashevskiy <aik@amd.com>
> >
> > Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> > ---
> >  arch/x86/kvm/svm/sev.c       | 18 +++++++++++++++---
> >  drivers/crypto/ccp/sev-dev.c | 12 ------------
> >  include/linux/psp-sev.h      | 27 ---------------------------
> >  3 files changed, 15 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index d0e0152aefb32..cea41b8cdabe4 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -528,21 +528,33 @@ static int sev_bind_asid(struct kvm *kvm, unsigne=
d int handle, int *error)
> >       return ret;
> >  }
> >
> > -static int __sev_issue_cmd(int fd, int id, void *data, int *error)
> > +static int sev_check_external_user(int fd)
> >  {
> >       struct fd f;
> > -     int ret;
> > +     int ret =3D 0;
> >
> >       f =3D fdget(fd);
> >       if (!fd_file(f))
> >               return -EBADF;
> >
> > -     ret =3D sev_issue_cmd_external_user(fd_file(f), id, data, error);
> > +     if (!file_is_sev(fd_file(f)))
> > +             ret =3D -EBADF;
> >
> >       fdput(f);
> >       return ret;
> >  }
> >
> > +static int __sev_issue_cmd(int fd, int id, void *data, int *error)
> > +{
> > +     int ret;
> > +
> > +     ret =3D sev_check_external_user(fd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sev_do_cmd(id, data, error);
> > +}
> > +
> >  static int sev_issue_cmd(struct kvm *kvm, int id, void *data, int *err=
or)
> >  {
> >       struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.=
c
> > index f92e6a222da8a..67f6425b7ed07 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -2493,18 +2493,6 @@ bool file_is_sev(struct file *p)
> >  }
> >  EXPORT_SYMBOL_GPL(file_is_sev);
> >
> > -int sev_issue_cmd_external_user(struct file *filep, unsigned int cmd,
> > -                             void *data, int *error)
> > -{
> > -     int rc =3D file_is_sev(filep) ? 0 : -EBADF;
> > -
> > -     if (rc)
> > -             return rc;
> > -
> > -     return sev_do_cmd(cmd, data, error);
> > -}
> > -EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
> > -
> >  void sev_pci_init(void)
> >  {
> >       struct sev_device *sev =3D psp_master->sev_data;
> > diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> > index ed85c0cfcfcbe..b4164d3600702 100644
> > --- a/include/linux/psp-sev.h
> > +++ b/include/linux/psp-sev.h
> > @@ -860,30 +860,6 @@ int sev_platform_init(struct sev_platform_init_arg=
s *args);
> >   */
> >  int sev_platform_status(struct sev_user_data_status *status, int *erro=
r);
> >
> > -/**
> > - * sev_issue_cmd_external_user - issue SEV command by other driver wit=
h a file
> > - * handle.
> > - *
> > - * This function can be used by other drivers to issue a SEV command o=
n
> > - * behalf of userspace. The caller must pass a valid SEV file descript=
or
> > - * so that we know that it has access to SEV device.
> > - *
> > - * @filep - SEV device file pointer
> > - * @cmd - command to issue
> > - * @data - command buffer
> > - * @error: SEV command return code
> > - *
> > - * Returns:
> > - * 0 if the SEV successfully processed the command
> > - * -%ENODEV    if the SEV device is not available
> > - * -%ENOTSUPP  if the SEV does not support SEV
> > - * -%ETIMEDOUT if the SEV command timed out
> > - * -%EIO       if the SEV returned a non-zero return code
> > - * -%EBADF     if the file pointer is bad or does not grant access
> > - */
> > -int sev_issue_cmd_external_user(struct file *filep, unsigned int id,
> > -                             void *data, int *error);
> > -
> >  /**
> >   * file_is_sev - returns whether a file pointer is for the SEV device
> >   *
> > @@ -1043,9 +1019,6 @@ sev_guest_activate(struct sev_data_activate *data=
, int *error) { return -ENODEV;
> >
> >  static inline int sev_guest_df_flush(int *error) { return -ENODEV; }
> >
> > -static inline int
> > -sev_issue_cmd_external_user(struct file *filep, unsigned int id, void =
*data, int *error) { return -ENODEV; }
> > -
> >  static inline bool file_is_sev(struct file *filep) { return false; }
> >
> >  static inline void *psp_copy_user_blob(u64 __user uaddr, u32 len) { re=
turn ERR_PTR(-EINVAL); }



--
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

