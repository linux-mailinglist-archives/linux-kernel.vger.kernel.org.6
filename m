Return-Path: <linux-kernel+bounces-545047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D1A4E86E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA9317779D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D6320C039;
	Tue,  4 Mar 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KT0LYQir"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573920AF99
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107238; cv=pass; b=HWmbp/kw52S0+YYmCioHSWIaafl1FwORKd3i7Oa4Z1y1gD5LWg4G8s0bBDIyhYEEXUbCD/rl31w1J8FEzpA8DQIO4KSUQ319OLTch8uy2Z440Sem5TB/50EeuaPYXyg1RSHzoCsWkFtIwwU9eRtCwhwT3LL2MiYdH+hplfZrVSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107238; c=relaxed/simple;
	bh=QhcA4whS6Un5CmsdrWExBnC2H3eBPdvl0YoTWezDvh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPZne8thSSu39c5LIzdpGFLqMh00U9GsRV282SVLkGHtn+tcEwbyA6pN7kynyW88asGTrJPoTwWYTlapZg8F/U/QEfS2/cUtLHWzVc5YzeIN/SPVnYszAN6YxeCi+woWqSIf9E17MDATF3Lz9ykAjy046PprQgLY/d48CkEUti4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KT0LYQir; arc=none smtp.client-ip=209.85.210.53; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 030F6408B649
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:53:55 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KT0LYQir
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fyC3KttzG0w9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:40:03 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5E82B4273E; Tue,  4 Mar 2025 18:39:51 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KT0LYQir
X-Envelope-From: <linux-kernel+bounces-541092-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KT0LYQir
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 876F44215A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:28:46 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 430F42DCEC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:28:46 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CF416E457
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 07:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F711EBA0D;
	Mon,  3 Mar 2025 07:28:04 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9E1E9B3A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740986881; cv=none; b=pA5BTVABVfJAsrrHzXoySmQL0AWqgb97WNYfpHqh7udIBHDJF3E3Jyn8END7BKLAFJ9cz+NN0iX8+uEUVsHF+7Rrm5f60x/lOTGz3Wzh1f4oeFke6H7lr8tzQ6umjTpAUbbcwJKSt90d7MgEbT/QLrcEMm1j5H8g6LQaWW6bmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740986881; c=relaxed/simple;
	bh=QhcA4whS6Un5CmsdrWExBnC2H3eBPdvl0YoTWezDvh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHi1G/uJbFGlhKpGrRC5rf0jawZ5tIXHBmILkNAF8UpgDJVr2f5mFBn6c+CtyBcKytm2YdVxkkMMQwrAnr7UJmSvsttgDXmtl6ynvCl4Eb6SxMP3pZPWSBWGGgscddc+xSl5ZXQNtDA2lI04oXb5mmABMgFmRtHEMl4U/ED+rXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KT0LYQir; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72a00f1f755so25329a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 23:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740986879; x=1741591679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqQf+xJ+QQAO3X5FgRqwqBs+4VjeomCIEb383qkkc70=;
        b=KT0LYQir+x5yMcUz5o/a3jgrED+KaNUHPnNifVJGaVuG3ez5HU/nogXThg10pMchEs
         0qx7Hs1GKpFfcs/u2Xfc+VorDJj/KNFgi8SLTe9d8eC5cRFqRPYUcVRs1lEL+OYW/U4u
         Afb7KVsDaBHB3vQMIjOMVGOzMZBc8jKkaZ0eJ4nfARAdSzxKbFq19/iCdKvOSXdTjSAw
         jDNl5VkCkHw+bUUC6+BjQ/NUy48AuU3w/hmg9lKnzbzUYt0R3c1Lk8fKXNfKB3hw5zAR
         5Bc71jF/s885LoTX2S7PHwICHHcPecbJuudKANQ2sqz+srlYWFK9PyYK9CT+LtExFpJh
         zEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740986879; x=1741591679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqQf+xJ+QQAO3X5FgRqwqBs+4VjeomCIEb383qkkc70=;
        b=T9/WXREwso1Zzq4FHvIRb3RimqDNNsE7Pe0+NUbui8yTZzcy5IN9fH83B6vDRT19Hz
         CMGvPd+WiJsp2k+9pp5ITwibymgzmvxe4+3YQb1fxw2ITdsPL832nPaAUDTsP9Hg/YDN
         dvNwhdDaMPVv2/SLFX2n6tXv+6oRaPCsbm0pKlVc6GodlQGekKxAL/zhKpCslwPSQjar
         R1+9ePGls6dBi5BM8m8BGTPb1BzXLYm185uIt4/f41JlTEPSppxeWf7L1nbYLY1FVetm
         GvhVFNeqOZplvX+M+bSPLZfIwCgmGKGsCtNhBlRYtx4vHD+y+XeN9C2vfFGsRW41OLQa
         hl4g==
X-Forwarded-Encrypted: i=1; AJvYcCWqNuXlL6pNwKCOenNUiN4C1l4lIWMI0KmcaNJ+rrjj9f2PkQ5bCUU0fi0n0Ba54agr5BrxTOh7cv0guok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpPWIolVPQsgZr8d89L6vgMOTx/hP9CXflsyUjkS1vBzbP06r
	s0csL5nqESv+KALktypfG3r0X+Qjkk4Ibo3Ac/iDZXCScmNCr9wPtbJ8vgcd2C83ooHTgHU9P28
	Dd5fPW8+KF4dlcSaYmEq0D1ajSH5UdQurBXg2Eg==
X-Gm-Gg: ASbGncswFD9W+X9J9n8zkcpDLOf/S+BdkFqVGj7y+j4/i7/Kf1B/FTLVNNzGpcX4J0D
	zJTTmYbarjPSkxSwSIWZ60nSZqnOnxZDOR9bGA8U9ceftNw/jyJ0xQOIljl9uFb3pK0bIPPSR48
	3/x5uNMJhwxCGAGUT26/eJD4APx6ky
X-Google-Smtp-Source: AGHT+IGdGihCdXsHvPy1HB+Hi01lhvTlT2V3S/bXdVPc4cd4/qzcouwXquivhfRUZCtj9S8/0Uw/BjeV/TL6JLeNSuQ=
X-Received: by 2002:a05:6830:348d:b0:727:3380:66ce with SMTP id
 46e09a7af769-728b830562fmr6634750a34.25.1740986878930; Sun, 02 Mar 2025
 23:27:58 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201110607.34766-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=uYad7UAedSU4M_L277v=RQGWHpJQwOW-p7W6=hcijsQ@mail.gmail.com>
 <CAHVXubhW9b6fw8ZvHtn7zmyRSUVt-3JjmFbE-_L42wZ9W6=vKA@mail.gmail.com>
 <CAEEQ3wmAxF=PkRt_pKFZE5-r9w1SMY7YQtco2mCyE+vus7vufg@mail.gmail.com> <CAHVXubiHhDgC4=T7xCxK9hoCG7R2KZ46LRPmS8rgYuT7EiQDcg@mail.gmail.com>
In-Reply-To: <CAHVXubiHhDgC4=T7xCxK9hoCG7R2KZ46LRPmS8rgYuT7EiQDcg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 3 Mar 2025 15:27:48 +0800
X-Gm-Features: AQ5f1JrsGJklPaO7yuMRDKV0ZqC70eeIlZ0wPBsVlz4-JWSVixlDQ5gxzrmW-PQ
Message-ID: <CAEEQ3wk9MWBG_neU5Ez9if9UcSsv9Q-EMm0gA2vjt8527rUujQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: print hartid on bringup
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: apatel@ventanamicro.com, atishp@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com, 
	jassisinghbrar@gmail.com, takakura@valinux.co.jp, 
	valentina.fernandezalanis@microchip.com, ruanjinjie@huawei.com, 
	charlie@rivosinc.com, conor.dooley@microchip.com, haibo1.xu@intel.com, 
	andybnac@gmail.com, ke.zhao@shingroup.cn, tglx@linutronix.de, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fyC3KttzG0w9
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711928.93637@4InF4Ug52A/LDANdb5FQZw
X-ITU-MailScanner-SpamCheck: not spam

Hi Alex,

On Fri, Feb 28, 2025 at 4:19=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Yunhui,
>
> On Fri, Feb 28, 2025 at 7:41=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Alex,
> >
> > On Wed, Feb 26, 2025 at 10:58=E2=80=AFPM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > >
> > > Hi Yunhui,
> > >
> > > On Thu, Feb 20, 2025 at 1:54=E2=80=AFPM yunhui cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > Gentle ping. Any comments on this patch?
> > > >
> > > > On Sat, Feb 1, 2025 at 7:06=E2=80=AFPM Yunhui Cui <cuiyunhui@byteda=
nce.com> wrote:
> > > > >
> > > > > Firmware randomly releases cores, so CPU numbers don't linearly m=
ap
> > > > > to hartids. When the system has an exception, we care more about =
hartids.
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > ---
> > > > >  arch/riscv/kernel/smp.c     | 2 ++
> > > > >  arch/riscv/kernel/smpboot.c | 4 ++++
> > > > >  2 files changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > > > > index d58b5e751286..e650dec44817 100644
> > > > > --- a/arch/riscv/kernel/smp.c
> > > > > +++ b/arch/riscv/kernel/smp.c
> > > > > @@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
> > > > >  void __init smp_setup_processor_id(void)
> > > > >  {
> > > > >         cpuid_to_hartid_map(0) =3D boot_cpu_hartid;
> > > > > +
> > > > > +       pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid)=
;
> > > > >  }
> > > > >
> > > > >  static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
> > > > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpb=
oot.c
> > > > > index e36d20205bd7..beba0efb00b9 100644
> > > > > --- a/arch/riscv/kernel/smpboot.c
> > > > > +++ b/arch/riscv/kernel/smpboot.c
> > > > > @@ -231,6 +231,10 @@ asmlinkage __visible void smp_callin(void)
> > > > >         riscv_ipi_enable();
> > > > >
> > > > >         numa_add_cpu(curr_cpuid);
> > > > > +
> > > > > +       pr_info("CPU%u: Booted secondary hartid %lu\n", curr_cpui=
d,
> > > > > +               cpuid_to_hartid_map(curr_cpuid));
> > > > > +
> > > > >         set_cpu_online(curr_cpuid, true);
> > > > >
> > > > >         /*
> > > > > --
> > > > > 2.39.2
> > > > >
> > > >
> > > > Thanks,
> > > > Yunhui
> > >
> > > IIRC that's a debug feature when you can't reach userspace and use
> > > cpuinfo, so what about using pr_debug() instead?
> >
> > Using pr_debug needs enabling #define DEBUG in
> > arch/riscv/kernel/smpboot.c and adding loglevel=3D8 to cmdline, not
> > convenient.
>
> You can also use a kernel command line parameter to enable a
> pr_debug() statement
> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.ht=
ml#debug-messages-during-boot-process

Umm, it works. I'll update v2.

>
> Alex
>
> > Can't always cat /proc/cpuinfo before running in user
> > mode.
> > It's true that pr_info prints a large amount of information in the
> > startup logs, especially when there are many CPU cores.
> >
> > Do you have a better solution?
> >
> >
> > > Thanks,
> > >
> > > Alex
> >
> > Thanks,
> > Yunhui

Thanks,
Yunhui


