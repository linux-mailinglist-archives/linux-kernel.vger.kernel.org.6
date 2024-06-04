Return-Path: <linux-kernel+bounces-199966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025A8FA849
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BEF1F2341C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4053BE;
	Tue,  4 Jun 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="maPZTs53"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763B12D758
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467992; cv=none; b=DOvtXrfR4X8Y5LDUvUBXZl2kojvSlW2q4ewcc9K84mNUDSygQre+iPy/nuL9N0pvNXNHcEgUaBL2KnXpRG/zheb5pwFqciOh+QVn3jq1QDtk1Q5MjPicbrT7o00X1KZlnleO9vYPAV+kc2KcSXsnEsvdbuo4qxNZ70bUfRHrUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467992; c=relaxed/simple;
	bh=8t+bbxOFKb/Tsr+2UziLXGE7C3Zx9/gJZQQEdwduWRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaN43lBbwydddEK+UQDs1ZrrFMWAzmJzUfOcWW8vgdnuf399iPRt3EIivkE1EruBFsEv8dYsI/ConitxvCpX+G63rT69fJHEsEnbo1g10cO8UPpolupj40s4XiK+pwVxgM1r3LbiReH75RRF57ZcQ/MIGDuSCoyqTLReI+T6C74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=maPZTs53; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f8cd25ebd5so2580703a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 19:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717467990; x=1718072790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4PmXD5MowMat90zUSKPgQAiN+HLbim4SCmw5MkJujg=;
        b=maPZTs53VO1pUbUoupdvqbSq9LfqqPk9mCjCZ1zNCOdkAvKPbKdwU2pXsNVIzmfy+w
         R7zl9AyoAJC0FJgMj+4BCZ9RUcaXLJqoyfD3IcpX2F28WbHkW4OCBRXVY4ztoHkoTMpA
         /frTGybb4kdLr+lfD+40YTHBaz3sSe/KxhqaWQ2nXSFC3nZIpD1QXOTkfJ9i1AKalVta
         XWLtwipXiq/SnTDw0OAeaw8unUtobRc4kBYNLH53AVDjY9nrBSBYFrryq40qVVO1kSU9
         ioyhVIcbDcqFoWoX0UminNMyUbMWUghyGDdysHXD7eOy29u5sqzrCbPMgPw9sRyBGozJ
         EZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717467990; x=1718072790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4PmXD5MowMat90zUSKPgQAiN+HLbim4SCmw5MkJujg=;
        b=YexeUU4DtMlUIWuNSb1aCFAcsqmPuGBKpIhlnAD1G8KCEV0+XhYRHD5g7csCpMyg3S
         z8CvNW0oAZzlLEwiyHZh/jD0w3lGiNq0/PXiNQ/Rn7Nj1h0XbpE37z2qsxc1j0R102LZ
         Wbx1GeGapJmCoHTASghAv3IT3w1mnSg6/sepPRpnmKue+VZxb5RPvykAFOzvp/TDHZOE
         LpuI+BWf6eRfqjbvKnYXhcYQ/vokiBq/Z7tqOxzz7+PbE+Mxw6IPYOfUz9uKuy0rcm2T
         +/v7Qk6nshUNwJOio9unbd1ecd7AwPKfizJM9vCekxMSR+eD2ACoRQW4NOlDofOirzk1
         bROw==
X-Forwarded-Encrypted: i=1; AJvYcCXWTuuW97T7ssMzceWv2pxk6J4sF41uaWy5XHRfK8p197v66k1+g6rgUxDIqDDQF9BllrTNiGbmYMghXupravxeDEgrPlecrmWlXMG6
X-Gm-Message-State: AOJu0YyQELG7klcO+Il2tX4LMTphPZbkOtmeLFxyCeHvf2MvnjLct6yY
	opHyd5e+pswXBnwMyXTVjPAxjbJgUEKgAptB4j/H17q5JPgypv4gL6qZNSoFbjG1kGcxHBGvAIN
	MInK5PYG0n9ePHmLpx5fsq2cHksUCdbuddEMOJw==
X-Google-Smtp-Source: AGHT+IF8osrWQw9+CtjSacKGaxmnj6mLifvKaK2i0qkCZu+VsezKa8w3LpXFIRo/H5fvWDp3fsIXnpfMZDYhhmvEt7A=
X-Received: by 2002:a05:6830:3a0f:b0:6f0:e381:77b1 with SMTP id
 46e09a7af769-6f911fa42d3mr11510807a34.27.1717467989658; Mon, 03 Jun 2024
 19:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524103307.2684-1-yongxuan.wang@sifive.com>
 <20240524103307.2684-2-yongxuan.wang@sifive.com> <20240527-41b376a2bfedb3b9cf7e9c7b@orel>
 <ec110587-d557-439b-ae50-f3472535ef3a@ghiti.fr> <20240530-3e5538b8e4dea932e2d3edc4@orel>
 <3b76c46f-c502-4245-ae58-be3bd3f8a41f@ghiti.fr> <20240530-de1fde9735e6648dc34654f3@orel>
 <f2016305-e24b-41ea-8c48-cfdeb8ee6b48@ghiti.fr>
In-Reply-To: <f2016305-e24b-41ea-8c48-cfdeb8ee6b48@ghiti.fr>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 4 Jun 2024 10:26:18 +0800
Message-ID: <CAMWQL2htSNer6zZe2SNoRfmF1wF7EVGHeqwNE3pkfSnS3sa7=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/5] RISC-V: Detect and Enable Svadu Extension Support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, cleger@rivosinc.com, Jinyu Tang <tjytimi@163.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Samuel Ortiz <sameo@rivosinc.com>, 
	Evan Green <evan@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Mon, Jun 3, 2024 at 7:29=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> On 30/05/2024 11:24, Andrew Jones wrote:
> > On Thu, May 30, 2024 at 11:01:20AM GMT, Alexandre Ghiti wrote:
> >> Hi Andrew,
> >>
> >> On 30/05/2024 10:47, Andrew Jones wrote:
> >>> On Thu, May 30, 2024 at 10:19:12AM GMT, Alexandre Ghiti wrote:
> >>>> Hi Yong-Xuan,
> >>>>
> >>>> On 27/05/2024 18:25, Andrew Jones wrote:
> >>>>> On Fri, May 24, 2024 at 06:33:01PM GMT, Yong-Xuan Wang wrote:
> >>>>>> Svadu is a RISC-V extension for hardware updating of PTE A/D bits.
> >>>>>>
> >>>>>> In this patch we detect Svadu extension support from DTB and enabl=
e it
> >>>>>> with SBI FWFT extension. Also we add arch_has_hw_pte_young() to en=
able
> >>>>>> optimization in MGLRU and __wp_page_copy_user() if Svadu extension=
 is
> >>>>>> available.
> >>>> So we talked about this yesterday during the linux-riscv patchwork m=
eeting.
> >>>> We came to the conclusion that we should not wait for the SBI FWFT e=
xtension
> >>>> to enable Svadu but instead, it should be enabled by default by open=
SBI if
> >>>> the extension is present in the device tree. This is because we did =
not find
> >>>> any backward compatibility issues, meaning that enabling Svadu shoul=
d not
> >>>> break any S-mode software.
> >>> Unfortunately I joined yesterday's patchwork call late and missed thi=
s
> >>> discussion. I'm still not sure how we avoid concerns with S-mode soft=
ware
> >>> expecting exceptions by purposely not setting A/D bits, but then not
> >>> getting those exceptions.
> >>
> >> Most other architectures implement hardware A/D updates, so I don't se=
e
> >> what's specific in riscv. In addition, if an OS really needs the excep=
tions,
> >> it can always play with the page table permissions to achieve such
> >> behaviour.
> > Hmm, yeah we're probably pretty safe since sorting this out is just one=
 of
> > many things an OS will have to learn to manage when getting ported. Als=
o,
> > handling both svade and svadu at boot is trivial since the OS simply ne=
eds
> > to set the A/D bits when creating the PTEs or have exception handlers
> > which do nothing but set the bits ready just in case.
> >
> >>
> >>>> This is what you did in your previous versions of
> >>>> this patchset so the changes should be easy. This behaviour must be =
added to
> >>>> the dtbinding description of the Svadu extension.
> >>>>
> >>>> Another thing that we discussed yesterday. There exist 2 schemes to =
manage
> >>>> the A/D bits updates, Svade and Svadu. If a platform supports both
> >>>> extensions and both are present in the device tree, it is M-mode fir=
mware's
> >>>> responsibility to provide a "sane" device tree to the S-mode softwar=
e,
> >>>> meaning the device tree can not contain both extensions. And because=
 on such
> >>>> platforms, Svadu is more performant than Svade, Svadu should be enab=
led by
> >>>> the M-mode firmware and only Svadu should be present in the device t=
ree.
> >>> I'm not sure firmware will be able to choose svadu when it's availabl=
e.
> >>> For example, platforms which want to conform to the upcoming "Server
> >>> Platform" specification must also conform to the RVA23 profile, which
> >>> mandates Svade and lists Svadu as an optional extension. This implies=
 to
> >>> me that S-mode should be boot with both svade and svadu in the DT and=
 with
> >>> svade being the active one. Then, S-mode can choose to request switch=
ing
> >>> to svadu with FWFT.
> >>
> >> The problem is that FWFT is not there and won't be there for ~1y (acco=
rding
> >> to Anup). So in the meantime, we prevent all uarchs that support Svadu=
 to
> >> take advantage of this.
> > I think we should have documented behaviors for all four possibilities
> >
> >   1. Neither svade nor svadu in DT -- current behavior
> >   2. Only svade in DT -- current behavior
> >   3. Only svadu in DT -- expect hardware A/D updating
> >   4. Both svade and svadu in DT -- current behavior, but, if we have FW=
FT,
> >      then use it to switch to svadu. If we don't have FWFT, then, oh we=
ll...
> >
> > Platforms/firmwares that aren't concerned with the profiles can choose =
(3)
> > and Linux is fine. Those that do want to conform to the profile will
> > choose (4) but Linux won't get the benefit of svadu until it also gets
> > FWFT.
>
>
> I think this solution pleases everyone so I'd say we should go for it,
> thanks Andrew!
>
> @Yong-Xuan do you think you can prepare another spin with Andrew's
> proposal implemented?
>

Ok, the next version will be based on this proposal.

Regards,
Yong-Xuan

> Thanks,
>
> Alex
>
>
> >
> > IOW, I think your proposal is fine except for wanting to document in th=
e
> > DT bindings that only svade or svadu may be provided, since I think we'=
ll
> > want both to be allowed eventually.
> >
> > Thanks,
> > drew
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

