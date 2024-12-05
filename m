Return-Path: <linux-kernel+bounces-432599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEAF9E4D86
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0132918814A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903EA194A43;
	Thu,  5 Dec 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSt9m786"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87323918E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733379411; cv=none; b=Bq9UNnl/kI9gTL4L4pWMGh4yB3GNLkwLj2VNXg46bHmPRc+PwnILMJhuIln9Xjx6IiuHQKZCn8vQAhD+gdaS0gUgUWWapGWbu5wdP/zIjAWfezGdn1s6vsem0OYE/piVb2XZGyOLbbSCEMsXjJu8ICEVO7k+fCTw+4+D6Ie1epk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733379411; c=relaxed/simple;
	bh=GO5GvGNkQm2CXQvX+NzCUot8Pz0Noz/hsL9YqrIz2MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNNbrn+6nA/ATBzbFfQygBCUT7gw3KO5aNeQe/2+2OAPdt7MuNyIVHGbaoJyT0rALGLPEHNZPGhT+/GFRJs72jUsF8IGIEJ7qvgATS5CLzR1GHMlYzfxHUCnzvbm9rdOwNKU02dsJRKcjIUr8oEKMg8jUDavjPHLFsojSdIBf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSt9m786; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso4440491fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 22:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733379407; x=1733984207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7IhqScuF0SekULEXHkyMNtxs+tsMMoBSwfRpdhF42M=;
        b=fSt9m786kSbIcgvaLQCMcVvAdTlBxog6wOiZ8B+UV6JfDzz1GDI+Eu0EYPy5yS5Bz4
         94JaotoE8yz+FYAZoQBWAf+HOtkK+Fpgz58BjcLjco9sj/8+qNVEMj7dJoqQIsh3nyp9
         4Gvj/9QwdXxuWQRY3gIFLYgbYYm2w81qOWQApIO2dS9Y+rRwQElWni5cXuzabeBVAvNr
         /H1nAsn/oezBWZg4KWF2EzWQrizfpPHWEWBdA0mU4FTG/H3mWL86uQ1yjaZzAlIkDVru
         kuLX3J75dH/eo39872KiZudFmANtBLjXVSCLfDtLlDIxBIVLxXILW2g/eQtfHZXWVj4+
         f3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733379407; x=1733984207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7IhqScuF0SekULEXHkyMNtxs+tsMMoBSwfRpdhF42M=;
        b=nlZ+7wtuiXznR/ChlBZct5TGBfs/qOGW17+SigoVD982CnGLGTk+0Ohhqp0zhiJ+I0
         P0jbi6P8DU+90d/Yevdyfq3PjLKucKBWgMtRXpJsb830Y1YlsR0M0vzXkyIuWuNe4yZ7
         wib413LHDqWZSiNHWZ4oJqbD82OfoCbfI3nDr4JnKEDfZkqyDyo6cQRYRxW3NXOfXAV9
         OMTOwLRQDyGXFVD3T51RWrX1k+1ZOt1F5bYleiXvbxVXdX5oUBH6iKg8/Mc9f+Ys1/BJ
         LACexMKOVVGlwtZUxJx4hgoYI4zo47IbarXwN+VWD8JX1+1BAa/jqmYzDtzwERnsLd0t
         malw==
X-Forwarded-Encrypted: i=1; AJvYcCXiHK52umYlyPBoH76bM+OtieUpGdzGsgt1qyh4PIN9ld63b9vTqhnGeuS5V4PltdSXKYzINsFu1M3rZb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq96jjkWbELx65JsVCfsgJoHEW3aoUlfLr/7YVia7DngluF5w2
	KxksIYbtvYvfJDJw49wBZ5iFVlljw93eh8Myc1t+qDStzMhqFtxneib+Mrx5/rtszCFRW0FEJ5x
	tpth0FCxSB30tz/A9/snXWvmwK6/I9pukKR6d
X-Gm-Gg: ASbGncu7pxXVAt4AJVLXNr9yXjpcba91NCY/IOXqLeThQqJca0lhf0ust4HKN43A7zK
	LKTlImac3T1JDIn18Q9S3D0gJEpzYLaHimk3LJdm1/eW0XI1TAQ6as2G1yoo5OZtS
X-Google-Smtp-Source: AGHT+IF/tGvWgxbC4KvaMISzuxN2khyQv1TnjwqaSv1h78hENRaTtZfpkwXMen+PKrIZAvc63iCZOoiHRInLvCmFTJ8=
X-Received: by 2002:a05:651c:12ca:b0:2ff:c757:7105 with SMTP id
 38308e7fff4ca-30009c92611mr57418601fa.31.1733379407192; Wed, 04 Dec 2024
 22:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005831.15434-1-elsk@google.com> <CAK7LNAQFk1UNARu4HMcAfpykpw6u3ex_PHOLzfnAo2CoOzBT8w@mail.gmail.com>
In-Reply-To: <CAK7LNAQFk1UNARu4HMcAfpykpw6u3ex_PHOLzfnAo2CoOzBT8w@mail.gmail.com>
From: "Hong, Yifan" <elsk@google.com>
Date: Wed, 4 Dec 2024 22:16:11 -0800
Message-ID: <CAABy=s2i2u_KtqwP1GVZkEB7WVF1dsu1_r3uFm8eZMM_3kybBA@mail.gmail.com>
Subject: Re: [PATCH v1] kheaders: prevent `find` from seeing perl temp files
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: enh@google.com, ccross@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Matthias Maennich <maennich@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 3:18=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Nov 7, 2024 at 9:58=E2=80=AFAM HONG Yifan <elsk@google.com> wrote=
:
> >
> > Symptom:
> >
> > The command
> >
> >     find ... | xargs ... perl -i
> >
> > occasionally triggers error messages like the following, with the build
> > still succeeding:
> >
> >     Can't open <redacted>/kernel/.tmp_cpio_dir/include/dt-bindings/cloc=
k/XXNX4nW9: No such file or directory.
>
>
> I tested this patch on Alpine Linux
> with "for i in $(seq 100); do" loop.
>
>
> [Without this patch]
>
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     kernel/kheaders_data.tar.xz
>   AR      kernel/module/built-in.a
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
KOEPLf:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXFEJdaa:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXdcljBm:
> No such file or directory
> Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uap=
i/linux/XXlLaJJF:
> No such file or directory.
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
ELBDIO:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXoHheAk:
> No such file or directory
> Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/in=
clude/asm/XXeMGhpj:
> No such file or directory.
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXbJmIOD:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
iHiAAd:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXjmiien:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
HDjNNM:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXlOHclm:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
bOGokp:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXfiMojG:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
hjfhgd:
> No such file or directory
> Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/lin=
ux/XXiHbNEg:
> No such file or directory.
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXKiEgne:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXLNlene:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXmKpBbk:
> No such file or directory
> Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/lin=
ux/XXdgokkN:
> No such file or directory.
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXDpfMGd:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXhAMmbc:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXpaKiKk:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXJNPgAH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
lkCjbB:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXmkfeAA:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
FFbADB:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXEJlBBd:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
PHMiNP:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
eiMaiG:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXpfopfE:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXLOHHKc:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXiaBiIc:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXJainoG:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
JFhLEI:
> No such file or directory
> Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/in=
clude/asm/XXhPACEf:
> No such file or directory.
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
pMhaAc:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXNdoMNL:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXgKMLkg:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXaKkEKh:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
mdOFEo:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXmjKioE:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXPeEhNj:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXJCnpLp:
> No such file or directory
> Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/in=
clude/asm/XXHNOiKd:
> No such file or directory.
>   CC      kernel/kheaders.o
>
>
>
>
> [With this patch]
>
>
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     kernel/kheaders_data.tar.xz
>   AR      kernel/module/built-in.a
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXeDFldH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXLJMCah:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXckkiOH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXNggIFH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
njOibB:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
kHOnGO:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXMogCin:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXogNJeJ:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXBAgJfo:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXfgFjJH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXKiiEfj:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXkOEknj:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXjbddCE:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXDHGOlH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXMGAdak:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXhfAChH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
mGoEnP:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
GJEpaH:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXkKODpJ:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXDEfBDk:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXmgjJkj:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXBjhcbB:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
HoLKEE:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
OgcfAB:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXdjoEEc:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXFdEDFO:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
iNpHAN:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXopbKfc:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXlJnGkN:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXKfPIJB:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXDfbPkb:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXEiOgDb:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXdCdCIK:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
doCePE:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
nDjKlh:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXEEcAMM:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/lin=
ux/XXjlDBLj:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XX=
EFPFLj:
> No such file or directory
> find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include=
/asm/XXpoFkCA:
> No such file or directory
>   CC      kernel/kheaders.o
>
>
>
>
> Indeed, the error messages from perl were fixed, but
> I still see a bunch of error messages,
> which were presumably emitted by 'find'.
>
>
> Do you know how to fix them?

Sorry for the late reply; I just got back from my vacation.

Thanks for taking a look at the patch. The error would suggest that
the patch is not robust enough against different `find`
implementations. I'll upload a separate version of the patch that
properly streams `find` into a temporary file before feeding it into
xargs perl. That way, find shouldn't see the temporary files created
by perl.

>
>
>
>
>
>
>
>
>
> > Analysis:
> >
> > With strace, the root cause has been identified to be `perl -i` creatin=
g
> > temporary files inside $cpio_dir, which causes `find` to see the
> > temporary files and emit the names. `find` is likely implemented with
> > readdir. POSIX `readdir` says:
> >
> >     If a file is removed from or added to the directory after the most
> >     recent call to opendir() or rewinddir(), whether a subsequent call
> >     to readdir() returns an entry for that file is unspecified.
> >
> > So if the libc that `find` links against choose to return that entry
> > in readdir(), a possible sequence of events is the following:
> >
> > 1. find emits foo.h
> > 2. xargs executes `perl -i foo.h`
> > 3. perl (pid=3D100) creates temporary file `XXXXXXXX`
> > 4. find sees file `XXXXXXXX` and emit it
> > 5. PID 100 exits, cleaning up the temporary file `XXXXXXXX`
> > 6. xargs executes `perl -i XXXXXXXX`
> > 7. perl (pid=3D200) tries to read the file, but it doesn't exist any mo=
re.
> >
> > ... triggering the error message.
> >
> > One can reproduce the bug with the following command (assuming PWD
> > contains the list of headers in kheaders.tar.xz)
> >
> >     for i in $(seq 100); do
> >         find -type f -print0 |
> >             xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!=
SPDX).)*?\*\///smg;';
> >     done
> >
> > With a `find` linking against musl libc, the error message is emitted
> > 6/100 times.
> >
> > The fix:
> >
> > This change modifies the command so `find` only emits .h names, thereby
> > skipping the temporary files. Another possible fix would be to store
> > the results of `find` before feeding them into xargs; I didn't take thi=
s
> > approach because the current approach appears marginally more optimized
> > and involves a smaller change.
> >
> > Signed-off-by: HONG Yifan <elsk@google.com>
> > ---
> >  kernel/gen_kheaders.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> > index 383fd43ac612..271e0145f406 100755
> > --- a/kernel/gen_kheaders.sh
> > +++ b/kernel/gen_kheaders.sh
> > @@ -84,7 +84,7 @@ for f in $dir_list;
> >  done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1
> >
> >  # Remove comments except SDPX lines
> > -find $cpio_dir -type f -print0 |
> > +find $cpio_dir -type f -name '*.h' -print0 |
> >         xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX=
).)*?\*\///smg;'
> >
> >  # Create archive and try to normalize metadata for reproducibility.
> > --
> > 2.47.0.199.ga7371fff76-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada

