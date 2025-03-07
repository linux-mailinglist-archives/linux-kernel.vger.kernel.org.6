Return-Path: <linux-kernel+bounces-551194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CFA56944
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D34B7AA301
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767821A435;
	Fri,  7 Mar 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiEYHAVL"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DF82CA6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355148; cv=none; b=k6Gjtw3jVZRds8EB037AcPPDsJPWOCXCCYac3i9n3f7e6K4V0RZtG2RWIP4hOiHahm6uIAR26Ni/+s43YiVGNAL4W0a4m0d+LmXEn3fb1+kswaXioWINFqP2iELvSjRF4LvW/w504rmQ9sdtxSV4f4ZTaILOHdqh5LzIGcfRo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355148; c=relaxed/simple;
	bh=UUTXKM9BZVnjKVF0sUzGrJAYz6rcNpp4BYAzQ+7MdW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1eYKwof07kMKWjSU1fx3k6P4NVHqkGp06CG00WDsFXmAoi3sMDP5pK/2pB8r48YhA6yRBBED1bIV7adz9WazQJt/NHPuJ2XI4Ntq43Vp+WYd+ya7b3uF6aMvM8sfUY6KVq4t1aRCfo66wfDiRU+irBzdt5G5+BRJFHKmYf8W6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiEYHAVL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30beedb99c9so14895281fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741355144; x=1741959944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af0lLqPdfRutAXAZrHY9yH7b2yNgA2IA91i5JHx4hZE=;
        b=GiEYHAVL7hyHwL/7/g0oPmMK8WdUynUresHFSUhIbKPE68x5BGS1TSwaJb6/IyKcmK
         txjNweJtGxN8wQNChBJURiRzV/nmnHRdNKpamLej7uPbUacQWpB12Aqk2Pc2eCyZr4mb
         BJhWokV7HheabwhZ9OwMEDTR9RF3u+Oevqgf+rXrWE4ftTw9l9l4GA54Nk1XMzu2Iy3o
         t/6ScFGq0m7/kAimx7fQc3vskku7umE4PNX1MBl4ydKcv2gRUTIchrh6OIn9FOmISLFW
         11c7GkrzFPQRQkDAl41ve+ao9xPIKLvSzHttqkbx/I8f1Q5yzSFEEuxmuSTycg88y6jz
         ETiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355144; x=1741959944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af0lLqPdfRutAXAZrHY9yH7b2yNgA2IA91i5JHx4hZE=;
        b=L7PBUVeMkE+WWVmwx1wvbgPNA0TVqukRmqM+dPkh7b4plmO90yINs3R17E3GHpntJ9
         DTdvl7eLPhQ+m7h6hX8+QB4I3CLRKz2/QfuvBxPlV85M+Cwr+/P0WEc+AW0ekMQJVa4/
         yVJ8S4wug9MH7saKrX0S09nTUnkMcGkGAseK05CrKWY9OrL9P7V8h7JMsBy55fMb99bZ
         bxuKX3XhRGeHEMd4A0cWmr+iGuuLz6KPt+G3WWZ0uaj+1iKKud/VQqoR/ChZyygy2fwI
         +xpuuwSOo9DvMcuoIohvTyhBLhLbdggEsG8TZPCm1/sl0WZFTUf+Cpk0uJ2Bslti92QI
         qtXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq7TctLW0QV9CMkGZn1Q+r4je5CXgpjBwYQgflOhQV7nhIer8Xdt+ieTCRKafZatcyW9ReCAeBU3HsNso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9jsBvPowlk4JFFhKj2+NiTh05z1FSFCLmo7jnSax8SUbck9lC
	w6gDkN0mFf1+v5Z5faR5w/dRYID6mim1JvVqV39034M/PUDlQBCQ21E38bHAXx/XvpYy1uQIq3M
	ons765iEKpdLKitgQWn8cnY1yJak=
X-Gm-Gg: ASbGncs8e0fsK2tMiESU4TYZDwFcBjrn3i3GCGEPBWdGlHDbdm4XjcJxIjeh4z/FRk2
	Pvbo+fRT7IVBP4s+nii8wim5aTT+4uhHiYBVK+A9tX7cXRmiGXb6o4czdVTRakjsDQGTQnQKNS1
	HPonxNVlo0oMAHzN17uEIk5uqPyg==
X-Google-Smtp-Source: AGHT+IHH5+V/k3odvLpkTUChoRRviTypvTTpo9pvWbCF3XU41dgtnOeHRk0blJs5PXF5rm3dbDoeTtx8Twc5kryQ9bc=
X-Received: by 2002:a2e:a9a6:0:b0:30b:9813:afff with SMTP id
 38308e7fff4ca-30bf465adcdmr10763101fa.31.1741355144004; Fri, 07 Mar 2025
 05:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307091022.181136-1-ubizjak@gmail.com> <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com>
 <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com> <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com>
In-Reply-To: <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 7 Mar 2025 14:45:42 +0100
X-Gm-Features: AQ5f1JoiP3UVCBb8B0Gw_vnsbXmY8ybiA8YDl9lBH3F77oTK3-Ozz7Br-BFGUG4
Message-ID: <CAFULd4Z=ZU0z3g3yc6FTBkN38tsgF86ps2P7Dhc+bdF8A416Uw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Do not test if AC and ID eflags are changeable
 on x86_64
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:13=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:

> >> PUSF et al =E2=86=92 pushf
> >>
> >> The -l and -q suffixes have been optional for a long time.
> >
> >No, not in this case. Please see the comment:
> >
> >/*
> >* For building the 16-bit code we want to explicitly specify 32-bit
> >* push/pop operations, rather than just saying 'pushf' or 'popf' and
> >* letting the compiler choose.
> >*/
> >
> >We are building 16-bit code here, and we want PUSHFL, the one with
> >operand size prefix 0x66.
> >
> >Please consider the following code:
> >
> >    .code16
> >    pushf
> >    pushfl
> >
> >as -o push.o push.s
> >
> >objdump -dr -Mdata16 push.o
> >
> >0000000000000000 <.text>:
> >  0:   9c                      pushf
> >  1:   66 9c                   pushfl
> >
> >Uros.
> >
>
> *plonk* I should have remembered (.code16gcc is different then .code16 th=
ough.) I wrote the damned things after all...

Please note that while "gcc -m16" emits .code16gcc, "clang -m16" emits
.code16, so in the latter case we don't have =E2=80=98pushf=E2=80=99, and =
=E2=80=98popf=E2=80=99
instructions default to 32-bit size. So, the only solution is to
decorate pushfl with operand size prefix in this specific case.

Uros.

