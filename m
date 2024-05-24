Return-Path: <linux-kernel+bounces-188572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B418CE3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F51BB211FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE585642;
	Fri, 24 May 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qvv+rTHr"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A984FDD
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543991; cv=none; b=iYzotBoCvaMJdKDNFPmWPVc578YazGHZDuQPPxtEafWmAOi2E5OCnFmy2wDsn1NCNejW0j/SiRNoblysHWnuPgJE6kwSSUXfOsXFp15ntwY7VCBNgZLdSH2vmKlS58dhjsWUqeyC0qR5ABn9Y1jSac6l/XYFLgQgCtgRQVrH5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543991; c=relaxed/simple;
	bh=HDU6Ikis2reepBp7XonSWdeQ98AVdDz0nuzQ+64KYp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLpcxeGfo5SXXG8UN1tpCh+8TGU8/lK8viu/Lw739JgQqzkGL7eoy/9nVG96esN+gK4qPyJ3KFKJ97qne6GuEqVUM+Gr+5KQFuhKMTACMWxeGwB41/TMz0hA1Sd35otVhb76LF45w67Irzxj/rzNJOQHymw+zzppeMcLHKsbxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Qvv+rTHr; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-df4f05e5901so2666977276.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1716543987; x=1717148787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjgMHPkdKke/sFW+wP3x/OWfAW3icjljhDceGb+T51c=;
        b=Qvv+rTHrHM5G+L52LeF/Ukc57xiGL2/T+SEBVpyDFh0YPcFG22QFWnTay7BdzrZ3JP
         hUQESM8tnI7oSt7hVKSGhj9+wW9szYPoHmD2M9QAApWzUHwgOWfaWPVbZ1VTYQq+fDJZ
         Z5r0118dPBrruHGC83QnOfMaHkNBCEvPh2gJ8KpOXIllsXa2YTOxiIBl2J4Nv85Ccd4Y
         IWjs40RXK78QI4z3tAFTn8diN+7XuYR/pxMgmzJJT3/jzKk++3dgxEaU1S+PBmbYngGA
         RRBipfTPQbP7nPrqaMOPdkb3feB8K+rO7FA1QBUlY9nYY2FnYz9vcF5xArFebdzgv4cG
         lx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543987; x=1717148787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjgMHPkdKke/sFW+wP3x/OWfAW3icjljhDceGb+T51c=;
        b=gMAO7TC+opWE14zTwAdYWzKQzJ1G/Y776yGMz9ZUxlFtmLIkn2CpMLKWHK8yhzCKVX
         TU88G7mz96bt6HFeIVTWICgLTVvT1Omp07je/2ou5UfjUHYeb6Ujkndhh+5iCERFD5LR
         KbH+0Pb7UcqD/ZVYxwdMFTeFt5w0x4lI4SRyiQjE70BQOFT90K2DjFLkHMS8ognogcz1
         FwWZxKgxTVUTsxcgZN/lwyxBN2agEpnIxLarltl8kUd4zWsz/AhZAaDsgQLiViSFQJ80
         ZqSFwCKfHp5nX4gRha4CUGg9SRQ+653SgviMCC9asZhIqXNxLj/x8NXLTSA4Zxtn/uAA
         y/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdBe/cHfiCxNsIAEDn4GkhiTmsyHRELh1U3kU918caPRFIMW5iYk7lAOBeT01PjA5JS1CC6M8hyCMjreg8GyfFZBnAZnbEB0iq1nYO
X-Gm-Message-State: AOJu0Yy2hOTRTgPEYeKzfIOF6s1DSI8Xt5aTnNFuETitUIbP/U3GXeSx
	EDinl9RG7mNoLwswgmDv28fL149w0PU937O44te10upVM+wEJEbD2nTGR5X0kiAHwws+DVmG36T
	6PUSdhK6+KU71IDkS7vR30N/nJ1As14C7uW6H+Q==
X-Google-Smtp-Source: AGHT+IElLw9ldbzBvHZ3/TQt52rrJpYv9UPwEZAezgFRSlhX7EDpAmWQFaSOD80MnXamfMqxd179zHrTOZ6XZB7bNkc=
X-Received: by 2002:a25:ae1e:0:b0:df4:df14:61bc with SMTP id
 3f1490d57ef6-df7721b7236mr1844605276.29.1716543987537; Fri, 24 May 2024
 02:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403234054.2020347-1-debug@rivosinc.com> <20240403234054.2020347-23-debug@rivosinc.com>
In-Reply-To: <20240403234054.2020347-23-debug@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 24 May 2024 17:46:16 +0800
Message-ID: <CABgGipW4ZTFLh1dkiRuWD0WP4RRkfhyFCc+RsUjCD2EkA5GhSQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/29] riscv sigcontext: adding cfi state field in sigcontext
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org, 
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, corbet@lwn.net, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com, akpm@linux-foundation.org, 
	arnd@arndb.de, ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org, 
	jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com, 
	evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com, 
	apatel@ventanamicro.com, mchitale@ventanamicro.com, dbarboza@ventanamicro.com, 
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org, 
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com, 
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de, bhe@redhat.com, 
	jeeheng.sia@starfivetech.com, cyy@cyyself.name, maskray@google.com, 
	ancientmodern4@gmail.com, mathis.salmen@matsal.de, cuiyunhui@bytedance.com, 
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, 
	david@redhat.com, catalin.marinas@arm.com, revest@chromium.org, 
	josh@joshtriplett.org, shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, 
	ojeda@kernel.org, jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak,

On Thu, Apr 4, 2024 at 7:42=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> Shadow stack needs to be saved and restored on signal delivery and signal
> return.
>
> sigcontext embedded in ucontext is extendible. Adding cfi state in there
> which can be used to save cfi state before signal delivery and restore
> cfi state on sigreturn
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/uapi/asm/sigcontext.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/includ=
e/uapi/asm/sigcontext.h
> index cd4f175dc837..5ccdd94a0855 100644
> --- a/arch/riscv/include/uapi/asm/sigcontext.h
> +++ b/arch/riscv/include/uapi/asm/sigcontext.h
> @@ -21,6 +21,10 @@ struct __sc_riscv_v_state {
>         struct __riscv_v_ext_state v_state;
>  } __attribute__((aligned(16)));
>
> +struct __sc_riscv_cfi_state {
> +       unsigned long ss_ptr;   /* shadow stack pointer */
> +       unsigned long rsvd;             /* keeping another word reserved =
in case we need it */
> +};
>  /*
>   * Signal context structure
>   *
> @@ -29,6 +33,7 @@ struct __sc_riscv_v_state {
>   */
>  struct sigcontext {
>         struct user_regs_struct sc_regs;
> +       struct __sc_riscv_cfi_state sc_cfi_state;

I am concerned about this change as this could potentially break uabi.
Let's say there is a pre-CFI program running on this kernel. It
receives a signal so the kernel lays out the sig-stack as presented in
this structure. If the program accesses sc_fpregs, it would now get
sc_cfi_state. As the offset has changed, and the pre-CFI program has
not been re-compiled.

>         union {
>                 union __riscv_fp_state sc_fpregs;
>                 struct __riscv_extra_ext_header sc_extdesc;
> --
> 2.43.2
>

There may be two ways to deal with this. One is to use a different
signal ABI for CFI-enabled programs. This may complicate the user
space because new programs will have to determine whether it should
use the CFI-ABI at run time. Another way is to follow what Vector does
for signal stack. It adds a way to introduce new extensions on signal
stack without impacting ABI.

Please let me know if I misunderstand anything, thanks.

Cheers,
Andy

