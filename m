Return-Path: <linux-kernel+bounces-526301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB5A3FCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40FC7B0DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366A24C670;
	Fri, 21 Feb 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="D/bAUEqR"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA324BD0A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157600; cv=none; b=Yks/IEsxe1fJii1K6eED46/Q5H7GDMwD2lrte2BKZDjUb8EmUtfNVNlglYYpulYaZ+5WTNT4h1rpK8IEgdg2/YyvogFtqWxemstdWnt9wXFbK0unZ+GabYJZqzd9XlF5BSlu06ulotgEJqa8zmwPGWn6LvKe8GuFp/GuxwtOmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157600; c=relaxed/simple;
	bh=OdnitUOyPuNq7QGRt6IU8iiEd7Hok2Poyde+e07pzAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFEUOHcICXEDy28Cf27mQdVSOaDXEAUjPE72JfveR5tT/ksJF33poB0NL2dLtyIdMrxJCeUIx3ET/nT5A347iiXtL+GWH7aO8UEkMihcqsZSRFTsG75f0qKPmdP9w7xRq6p3gz8MMUWBjMErXPzU6Jtxlb7DXMCwVu99aAWflFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=D/bAUEqR; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d2b15760adso7528325ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1740157597; x=1740762397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0/CbgssrY9MdmhvaS9VAi8CgxuGoYSwiPbuLyClY14=;
        b=D/bAUEqRuvFS8c/jO3iHl+yFcRQm9XO/ZJy0HlVvSfBKfJO/QhUNNmhpJjhq9UtdJ5
         rJpHxPPR4twgaqztAi+ZdQUb8sZ5fZSUij6oFkFBRajpTZgYyd+RE2pYhzBZv0QcigfN
         yrtDocAt89wLyHZEtJFXRkvrPjZlcYLGd0tBX5O95ADS0lSpnA9XLSaAdn1M/EVIXXy7
         90Ju9l6LFuBipYUXxUOVXtvSmw2w0AkWn3KqsrUFVX/INOVyOoa9as3vrV4ruCUhmEov
         Hl9HH//nZnIsyl9g1OgP6znYQII1FdyHN0fLjcx6amksKYgF/96TQ1cNd+rxUnnDk6qe
         0YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157597; x=1740762397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0/CbgssrY9MdmhvaS9VAi8CgxuGoYSwiPbuLyClY14=;
        b=EyprcbKvX3X8mXowuLLyM6PXVss4RuQ+oeHA/JDt/yK/ocLcndlyMqAfQNfmtpTx8A
         RVs4H7Q3+4LIKABey0WV0MK4pGMJ4OSd0Y6GFb23m5hqkfwNTnZ4reNY7KRu1At5D9WP
         Uw3t0/6zeSWiSiFDe399jze5TaC/SV4lIzMrCE12XqSvI8sePwdHZR4P4m3gHGbZql4r
         zVlaaRF+QHukIFInAsOCSn/a5l3bnnnkFHBiiR0oz6u5BnO9BKnbe8mIEPINaiur1rOc
         9jv4QOJTxueL9gm0P+NpWJC5b7F6C+TiLv6HzTxsoa3TqQeyfgGAYJndnJBXwpOuP3DF
         PlzA==
X-Forwarded-Encrypted: i=1; AJvYcCXwoB3Zwk70GkE37BHjKAo+Venkj2lJ9cv8gv7SnuHscYdbfe5slYh+zczlQ5UfdkUOkl7hlQ8zHdCReu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdmFRtYq0Sg6gJkybFPBRX/erWN/Y5NcdySOjadEY7I3Hr3Fs
	7UaCnqL7nzGHFI19uKXIJ7Sh4hlOrrhuCBT9cv5MJ1L31badd5d2pHAQi5EgfVhlwcBo5F9zJKn
	/UJ4gDjX0Zb+Buve1NXf1P022Pj8fSooBDt2TwA==
X-Gm-Gg: ASbGnctgwBdZewebegYwOuN+3z7B+NyriLFaisT+tBGtNw+t/KA5wPmeggDmH06cB2R
	+EWgl8r6KCVnFY+z/tiP8p15rhJ9OVKlNzdbV0BzOoYGKbjIBQVhEbefbUyyYyvBR2ayTNQiapK
	/A6UOVXQpz
X-Google-Smtp-Source: AGHT+IFddscccecyBJuHpMIYpYRvh9YlBuKsbg2+gt14j7YH3RYxnm5jBOsEYz0eMa2s6iOMS/G/TbnvC9T8+ye2EXw=
X-Received: by 2002:a05:6e02:1cac:b0:3d0:4b3d:75ba with SMTP id
 e9e14a558f8ab-3d2cb42daddmr41475585ab.4.1740157597175; Fri, 21 Feb 2025
 09:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221104538.2147-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20250221104538.2147-1-xiangwencheng@lanxincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 21 Feb 2025 22:36:25 +0530
X-Gm-Features: AWEUYZko5N5M7hatn6QenhvKduK_Aqv3UdJMpX2Lv711NP2hVkEu-tpphWsd27g
Message-ID: <CAAhSdy34iNEqcVOziJcjnhS5xTYx3o+iXex8bEAwmUDApXWAcg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: KVM: Remove unnecessary vcpu kick
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: ajones@ventanamicro.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, rkrcmar@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:16=E2=80=AFPM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> Remove the unnecessary kick to the vCPU after writing to the vs_file
> of IMSIC in kvm_riscv_vcpu_aia_imsic_inject.
>
> For vCPUs that are running, writing to the vs_file directly forwards
> the interrupt as an MSI to them and does not need an extra kick.
>
> For vCPUs that are descheduled after emulating WFI, KVM will enable
> the guest external interrupt for that vCPU in
> kvm_riscv_aia_wakeon_hgei. This means that writing to the vs_file
> will cause a guest external interrupt, which will cause KVM to wake
> up the vCPU in hgei_interrupt to handle the interrupt properly.
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>

Queued this patch as a fix for Linux-6.14-rcX.

Thanks,
Anup

> ---
> v2: Revise the commit message to ensure it meets the required
>     standards for acceptance
>
>  arch/riscv/kvm/aia_imsic.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index a8085cd8215e..29ef9c2133a9 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -974,7 +974,6 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *=
vcpu,
>
>         if (imsic->vsfile_cpu >=3D 0) {
>                 writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
> -               kvm_vcpu_kick(vcpu);
>         } else {
>                 eix =3D &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
>                 set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
> --
> 2.46.2

