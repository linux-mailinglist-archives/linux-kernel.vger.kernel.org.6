Return-Path: <linux-kernel+bounces-441520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7089ECF97
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A13F286748
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5B019DF9A;
	Wed, 11 Dec 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFevxFDJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B61A0BFA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930632; cv=none; b=QD15FelpccXQubFXCJ7WBZJr5bOI8qw5ltcnX/gHEVJrVb09JNUBHas2T1q6f0l+YbKgtBYzKvLBw4Rsd4v19kv/uVQwaWW0jkxTpQ5XvSgMy+X+mgT14rGObSIyqs7Gpi6KtTsoJKtVA0OJS7lqqWguq+mqUSozLEeTcfJYwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930632; c=relaxed/simple;
	bh=RJZhMih9zFKGd5VE36r7pOPU0r24hs5uMYstfLfN9a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQfB2SDZtsQjg7quqKRBmEZoz5ag5YObn1cSWzo59i7xVeA3vw6ejry/t6E8iVDt1NnBOtOwIZLscsgp8lJRO1mTR0MGOikm2kr0upGRnzbVa0DeEFbE7RQCG/i2aPO6b+segDmiBdbDKCFOsgPwE54AuBB4nxF2DnfzjQPhCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFevxFDJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd17f2312bso5130418a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733930630; x=1734535430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLkj4Ifhnd5YSMpubblk91DrbGMVpKZpsPDJsM64NlM=;
        b=cFevxFDJBDkypwrHmqM5bo0kKFLHa2BQO4BCP6DcJF4XXYdItn6hqmpLHyXYg7NT/B
         qBSbYLfelqNqn5Y47CPQCX5xZ5QprEsFhxta+polrffpmJd7zH+FqK7sr84zS8Rbvkf2
         vJXtaZOBwJn4i1mAyqzMHBpw1nDdOcbV0MbPOcn+VW6BqVeD17Ck/9DnPTRF2N4anUHZ
         DaYf9uYu4n9fsc5CCle6ecaiNjfj/+svaNjrR53oOZxYs+geAJf4GOXvTfmftoJ3fcoc
         KEidRx0Tt8ZkkxTLFicVv0HWXZJTgy60ixFidenj5fcPvN3MEceMiJxHuzjUi0MgWgEN
         AmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733930630; x=1734535430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLkj4Ifhnd5YSMpubblk91DrbGMVpKZpsPDJsM64NlM=;
        b=tpwuNLH4+1T5Dik8bxIRL76a9mF0mcUvJlCNnFKk4Eed1mf/mfyvcF5atDUL2r5Kqi
         ZjH5PtGpN81ksoOBNn5YJPFWUFG6gYhRpYXdN7M6d5hSHf5r0q+mmtshoUdCjvyzGXp4
         4sO+0fhKbHC09CUIN9wRAA7Ri4TX+KrviEdvIoj1Sz7p6pqWdZlMVWTH8lAmuqORDuDJ
         Pgc5NZN/EEhN6TIqJfpM+juisBiVR4ALSKLIaXs8EZa03eW9jJXwBqnlJjwDPC3jHWbu
         PODqKy78W+DHM14tXG2gjEv/uP76fFXzCaRWfrav1/X9aD2UA0q5gKkWOW8+SVmyaJ/U
         +hug==
X-Gm-Message-State: AOJu0YxhWzTBa9Fdkwy+0rdFG1WGlQ7nNjj3bl4WyU8y6uX3AZUplxEn
	bdR8/vuJgjeh+qDr/PLjQMg3TNUWL+FlWPNMHFXvTnBTkjVlq9s+2KNZ/rmTXtFc+hsL+4Dw2Va
	8FE2ufhECxEh0aLKnJMZZ4clug/w=
X-Gm-Gg: ASbGncteCUiAXm+JxVJvjkgFb0OsxcefAk1ZgFMW6WukraXZ6BVe0vNj+pAolxS8Cxu
	A4RJyhgO0S/XzeqQ2ZLOdMdcjurQ3nHTj
X-Google-Smtp-Source: AGHT+IFc/NfHrj1+aZI2H+5hJnmAqxCLz+iF5mpm5G1Hn8PNWgHNai+NPG92bkP/jR0ykXpmJizMZqWewpx61btZW8M=
X-Received: by 2002:a17:90b:3c05:b0:2ee:f687:6ad5 with SMTP id
 98e67ed59e1d1-2f127f55592mr4838302a91.2.1733930630229; Wed, 11 Dec 2024
 07:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210142353.6457-1-yongxuan.wang@sifive.com> <20241210142353.6457-2-yongxuan.wang@sifive.com>
In-Reply-To: <20241210142353.6457-2-yongxuan.wang@sifive.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 11 Dec 2024 23:23:39 +0800
Message-ID: <CAFTtA3NVns7er2o+0Fu64uzy+83ScinRp=u5wcRd=MFCWnZraA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: signal: fix signal frame size
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zong.li@sifive.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Ben Dooks <ben.dooks@codethink.co.uk>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Young-Xuan,

Yong-Xuan Wang <yongxuan.wang@sifive.com> =E6=96=BC 2024=E5=B9=B412=E6=9C=
=8810=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:24=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> The signal context of certain RISC-V extensions will be appended after
> struct __riscv_extra_ext_header, which already includes an empty context
> header. Therefore, there is no need to preserve a separate hdr for the
> END of signal context.
>
> Fixes: 8ee0b41898fa ("riscv: signal: Add sigcontext save/restore for vect=
or")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/signal.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index dcd282419456..c3c517b9eee5 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -215,12 +215,6 @@ static size_t get_rt_frame_size(bool cal_all)
>                 if (cal_all || riscv_v_vstate_query(task_pt_regs(current)=
))
>                         total_context_size +=3D riscv_v_sc_size;
>         }
> -       /*
> -        * Preserved a __riscv_ctx_hdr for END signal context header if a=
n
> -        * extension uses __riscv_extra_ext_header
> -        */
> -       if (total_context_size)
> -               total_context_size +=3D sizeof(struct __riscv_ctx_hdr);
>
>         frame_size +=3D total_context_size;
>
> --
> 2.17.1
>

Thanks for the findings

Reviewed-by: Andy Chiu <AndybnAC@gmail.com>

