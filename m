Return-Path: <linux-kernel+bounces-441638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D629ED120
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AB529084E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C121DBB21;
	Wed, 11 Dec 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPrajgsW"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD618732B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933836; cv=none; b=YqyhKxB4QoZAI4AYXvH7oI9p9YqC31EWGMP0OeUOyv8pgWwcCJw1JHtgQf6wsw5fJGKDK1r94wo+97OPOM95/TDOcAGfupDrB6M/Cdnv1SQN/Qs8YW0wwGtxNHiJYt/LwUgNWOItUaA7z1F6CSJIYP6Y/EEhnwEBOvqKp3zIf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933836; c=relaxed/simple;
	bh=CaG5aBZn8BqbpQdXq9E88Fbxi30vjswtpYM+O+tE0ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEseujHUurEqYPxElKMS8F2iotx9VbBYw07LiPX354UzzrhEihOykr994MMFOxJAO6A5ARvDp5Wdq7xxC182Q60KQjgiHVmnpLzGerxvhC9nD3otc8AOSxES7RfMnUOprQ0a8/yKZwVA3kf0RYZgJgWWfyr1tNw2cBJD+XTGhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPrajgsW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd51285746so2411842a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933833; x=1734538633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq/TCQwMHuOfCjEI0R/TuYzX3aKPM48YR1W82vm1fRE=;
        b=fPrajgsWrLmRqSF52Y86bWdhJg3HTG9N6hjrmde95jqeBISOODsbDX9f3HsICMi6b6
         ErW+fDgeHyUcvjav1YYfAe/ukF//QtSu30TjB9faumYRrl5zjvmge+ZmYkMDnKMW1SFK
         DZb1/MScvgyYQVoNpKW8mUtK4fOihmmlKqgDGbGH6fSsxenjp8TD05CDXDxy0DhQsThU
         Xxk6miHbaV9LK59NyMmT6ALQTMfxdeTWUgB/pewxduXY8Hv+WghfVFss7gKbYZWaEAtk
         vuhXuaqFmZ5lREi7oU27dKRQimfYBE+91L7MgpVFTH3BM4KtEvr1+zT0y9Z9LIswqXnA
         Eiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933833; x=1734538633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq/TCQwMHuOfCjEI0R/TuYzX3aKPM48YR1W82vm1fRE=;
        b=sWAcAe0VSybghdRd7x9js5z4C58AUGiPjYXxGQ8NjzNsFKIY5vfZuZDQtx3GoKnDOE
         19OdbbyrN2usCSUcKwpy90vY+rdoBo6hS1HGtesX2kQ8/h8lKZ4vKsCo9/eSe6qsQtIA
         iUvM8ZnQw3UBDG/ix1E1E/9aEt1jKcA70KA6fU6VkrZDJnpTz6k+QhBw2odVfvLmYVLA
         EsPyC8ZdqC1I9k/mOBvrh3ke/fLnxO39jKcIlF6ghSXOxcbi4eL36B8JC+GhjYmhqyvp
         qsobqRsArNGh+tIHRez7yahEkuFF7k+j0HOkFZziVMwDPe7CS3fzp5LxLUROf/+nCmU7
         SFWA==
X-Gm-Message-State: AOJu0YzvJh6vHMJzU7XQBvvujXxjDWbswdwl7ZtJBp45LzHlTZMvkLiu
	qzn+pIwianU6r7w2px97CZxNyN9zTCB9hWc5FT7T/uOi/9J1UX+wqoKaFmwklm3CajPxDHCB2Q2
	+Gucp3Rt17llb0GIagKFNiy56WGo=
X-Gm-Gg: ASbGncuvaqltMG41q2Oyqr7WT7YoSZZfbB2U64YGvrXFyJForj1EIY1Y61MACTPV4uG
	ZTD+JyMBbov5G0RvaM8Q/Yg3zWLMloqwf
X-Google-Smtp-Source: AGHT+IHYjDXPytNfTe0XKCQE1JXhVDpkYIM+eEQ3akL1ezpi8wWYQsifBttcnbEYMgIDsi/1wZ4tGjMZx4Q3s584ZSo=
X-Received: by 2002:a17:90b:268e:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2f13930a5eamr709823a91.25.1733933832672; Wed, 11 Dec 2024
 08:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210142353.6457-1-yongxuan.wang@sifive.com> <20241210142353.6457-3-yongxuan.wang@sifive.com>
In-Reply-To: <20241210142353.6457-3-yongxuan.wang@sifive.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 12 Dec 2024 00:17:01 +0800
Message-ID: <CAFTtA3NTcHAm4YRMQr5N8TkQnLS5tXhw7LihiR8=9D+3HXT7Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: signal: fix signal_minsigstksz
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zong.li@sifive.com>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yong-Xuan,

Yong-Xuan Wang <yongxuan.wang@sifive.com> =E6=96=BC 2024=E5=B9=B412=E6=9C=
=8810=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:24=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> The init_rt_signal_env() funciton is called before the alternative patch
> is applied, so using the alternative-related API to check the availabilit=
y
> of an extension within this function doesn't have the intended effect.
> Instead, the riscv_isa bitmap should be used to properly check whether
> given extension is available. This patch also refactors the estimation of
> signal_minsigstksz by extracting it from the get_rt_frame_size() funciton=
.
>
> Fixes: e92f469b0771 ("riscv: signal: Report signal frame size to userspac=
e via auxv")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/signal.c | 40 ++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index c3c517b9eee5..85eac84719e9 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -203,22 +203,18 @@ static long restore_sigcontext(struct pt_regs *regs=
,
>         return err;
>  }
>
> -static size_t get_rt_frame_size(bool cal_all)
> +static size_t get_rt_frame_size(struct pt_regs *regs)
>  {
>         struct rt_sigframe __user *frame;
> -       size_t frame_size;
> +       size_t frame_size =3D sizeof(*frame);
>         size_t total_context_size =3D 0;
>
> -       frame_size =3D sizeof(*frame);
> -
> -       if (has_vector()) {
> -               if (cal_all || riscv_v_vstate_query(task_pt_regs(current)=
))
> -                       total_context_size +=3D riscv_v_sc_size;
> -       }
> +       if (has_vector() && riscv_v_vstate_query(regs))
> +               total_context_size +=3D riscv_v_sc_size;
>
>         frame_size +=3D total_context_size;
> -
>         frame_size =3D round_up(frame_size, 16);
> +
>         return frame_size;
>  }
>
> @@ -228,7 +224,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>         struct rt_sigframe __user *frame;
>         struct task_struct *task;
>         sigset_t set;
> -       size_t frame_size =3D get_rt_frame_size(false);
> +       size_t frame_size =3D get_rt_frame_size(regs);
>
>         /* Always make any pending restarted system calls return -EINTR *=
/
>         current->restart_block.fn =3D do_no_restart_syscall;
> @@ -318,7 +314,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigse=
t_t *set,
>         struct rt_sigframe __user *frame;
>         long err =3D 0;
>         unsigned long __maybe_unused addr;
> -       size_t frame_size =3D get_rt_frame_size(false);
> +       size_t frame_size =3D get_rt_frame_size(regs);
>
>         frame =3D get_sigframe(ksig, regs, frame_size);
>         if (!access_ok(frame, frame_size))
> @@ -465,19 +461,33 @@ void arch_do_signal_or_restart(struct pt_regs *regs=
)
>  void init_rt_signal_env(void);
>  void __init init_rt_signal_env(void)
>  {
> -       riscv_v_sc_size =3D sizeof(struct __riscv_ctx_hdr) +
> -                         sizeof(struct __sc_riscv_v_state) + riscv_v_vsi=
ze;
> +       struct rt_sigframe __user *frame;
> +       size_t frame_size =3D sizeof(*frame);
> +
> +       /*
> +        * init_rt_signal_env() is called before applying alternative pat=
ch. Do not use
> +        * __riscv_has_extension_likely()/__riscv_has_extension_unlikely(=
) to check the
> +        * availiablity of an extension in this function.
> +        */
> +       if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_v)) {

This should also check for IS_ENABLED(CONFIG_RISCV_ISA_V). Another way
to do this is to call init_rt_signal_env() after
apply_boot_alternative(). This can make assumptions on different piece
of code more coherent. What do you think?


> +               riscv_v_sc_size =3D sizeof(struct __riscv_ctx_hdr) +
> +                                 sizeof(struct __sc_riscv_v_state) + ris=
cv_v_vsize;
> +               frame_size +=3D riscv_v_sc_size;
> +       }
> +
> +       frame_size =3D round_up(frame_size, 16);
> +
>         /*
>          * Determine the stack space required for guaranteed signal deliv=
ery.
>          * The signal_minsigstksz will be populated into the AT_MINSIGSTK=
SZ entry
>          * in the auxiliary array at process startup.
>          */
> -       signal_minsigstksz =3D get_rt_frame_size(true);
> +       signal_minsigstksz =3D frame_size;
>  }
>
>  #ifdef CONFIG_DYNAMIC_SIGFRAME
>  bool sigaltstack_size_valid(size_t ss_size)
>  {
> -       return ss_size > get_rt_frame_size(false);
> +       return ss_size > get_rt_frame_size(current_pt_regs());
>  }
>  #endif /* CONFIG_DYNAMIC_SIGFRAME */
> --
> 2.17.1
>

Thanks,
Andy

