Return-Path: <linux-kernel+bounces-570346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB67A6AF24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589B44685DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BF229B28;
	Thu, 20 Mar 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/ZBaK2a"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1112288EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502294; cv=none; b=gGGLs0Nz7ze3lYL3YDa6KS+/5v6E5DpmuI3xW56fN2Xs9u7TOsgVsiY3nZmNrxP+5AaBswe0wwl/Ed/+0bQ4Y5PPeKHI/FkZMw1SDNjg6ubWxvlffxTXV5e5wwXp6AWs5uY343UwftOAP6Rk6S/9GCuuWVmiJppldxEHCfHKZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502294; c=relaxed/simple;
	bh=Y/NlFJOKWORBWvIQpg/pbrP2uz5vMat7aPPopK1J/mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBdyMs/fTwyaWt6/8OJ87I1P1gTew9OxB7lC0HmKgqqxPf1QS0VGWrOPV27+TGWmCbL5wAl7DNMWleBuysp8KORLt5zULYsaZ69akLc6/u+bJF7qnKtT9BE4g7mf9OIRKHj2cwmCwNsWSbxRC/DtZuPhZOfV34iXSZHFNTu6rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/ZBaK2a; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so1739337a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742502291; x=1743107091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXysNToi4JV5stFhHE3GKBUL3hMAfnax4alUV5eHbjA=;
        b=h/ZBaK2a+du7nqAvxxCTJVnBVwyp1w0bFTgmkAiKWPgkyT8rW57wzp1cmGJLtXtMPi
         /YFqs1r4PQgNTkTzn96zTdzQOviImreYms8sChOc6uZvmFW9AIey+DguTHP1ff0hh7n4
         E6YYtqZkmgJogodxfvDwzlk969MOBsC0+nbNJH4/YG1RGJDazvV5SoGqqMOBWLXz0OYb
         xtwA8Bo9BNRlCF2EdleWFeP+DwDB9jE6ZnrXqkmoe+MgqMfm2V/zKcjct/nPTllzUd4f
         bIkFG1Dk4frHKvv5orIP7AU6IgiaCBMxsXon/syTaRWULT44x2DhA0dETF6RHEXs04C5
         AG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742502291; x=1743107091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXysNToi4JV5stFhHE3GKBUL3hMAfnax4alUV5eHbjA=;
        b=mPOT2MfJqPXS9bHkXqrv2kCcAi6HJr+MEzaeYnt1pI6rO0omBq7jqwoOPjy1FfXZp8
         +szdr+Eyn9k9khs3MXeVyO5HGm6tWgn1239f1mmxSffRgw7Zq+TiDXR1lSL1WLO4eXTV
         9FsTuFnPJhTr7ELmXay5oiFGvKhduQialJ9XVvC+y6fNYDKu3ngsCv/WsCYqu55XfmS0
         VmpeoR/Cn5T1zeJZg6eafQdkqB/zwpSvynV6WbDxVDfNvBPI8h9DmLxepdoI0sEfbt6C
         HeZlVXzi/DCAfgW8Uz7JmxcWJC+ccyGi5eMiQvQbCMAaH0lEp4ffxByywJi/mlw5aw+C
         Fnaw==
X-Forwarded-Encrypted: i=1; AJvYcCV4MZGk2b2jbyE4q3yRPXglMEx2pEpEtNCVF4urVJOYJJZwhe7W1X8Lt+OJu3Ce5lcp+xO9fZ2w5l4FzlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuv8/jxQokvau1rdSQB+c6BTsWEh2KFJ42oGO/lV14Gz6S6pYC
	5rdk3Xd3s5f2c0cpORWNenXzrJpj3rMWVweEi02E2xT07WeNvgEytmrS4iur2m4+igRNpflecKi
	dT4wPZFq91JgQebypHoaCVYWxXPw=
X-Gm-Gg: ASbGncuO2sikodt0ks8LxZfePXqJmJK4Oz1Cvr0anv4ioRv1M8oygAf8/sCVuJXkGBp
	OxsqG6JMKx1DXlfUzLdbveVeR0DZSCuRpexiNa3bz7AZdUcfsufZGKvwOLSOK57n7ztmnlKQw0z
	rh3UyaYlooDi1VRw6/2QNv2owueA==
X-Google-Smtp-Source: AGHT+IF682jPoaFerBOWCa4Bv9K+7bZ80fr3EB5+nULuhjW0rt/e0wcODBYkJgSK8K2HiyBMo8FVHpiDvvyRnIhlDYk=
X-Received: by 2002:a05:6402:2694:b0:5eb:ca98:3d3d with SMTP id
 4fb4d7f45d1cf-5ebcd4ef489mr537841a12.22.1742502290691; Thu, 20 Mar 2025
 13:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com> <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
 <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
In-Reply-To: <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 20 Mar 2025 21:24:38 +0100
X-Gm-Features: AQ5f1JqgXuDa-mSIh9yO1NSI6kJ36hz7-OH4m1U0T4zwICM_rcRWjgckmOrgFnY
Message-ID: <CAGudoHFqGfiGPf2ZkVeAqco+0BD2G72_TSGCz29dP_tvwQN0NQ@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, hkrzesin@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 8:33=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Mar 20, 2025 at 8:23=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 20 Mar 2025 at 12:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > Sizes ranged <8,64> are copied 8 bytes at a time with a jump out to a
> > > 1 byte at a time loop to handle the tail.
> >
> > I definitely do not mind this patch, but I think it doesn't go far enou=
gh.
> >
> > It gets rid of the byte-at-a-time loop at the end, but only for the
> > short-copy case of 8-63 bytes.
> >
>
> This bit I can vouch for.
>
> > The .Llarge_movsq ends up still doing
> >
> >         testl %ecx,%ecx
> >         jne .Lcopy_user_tail
> >         RET
> >
> > and while that is only triggered by the non-ERMS case, that's what
> > most older AMD CPU's will trigger, afaik.
> >
>
> This bit I can't.
>
> Per my other e-mail it has been several years since I was seriously
> digging in the area (around 7 by now I think) and details are rather
> fuzzy.
>
> I have a recollection that handling the tail after rep movsq with an
> overlapping store was suffering a penalty big enough to warrant a
> "normal" copy instead, avoiding the just written to area. I see my old
> routine $elsewhere makes sure to do it. I don't have sensible hw to
> bench this on either at the moment.
>

So I did some testing on Sapphire Rapids vs movsq (it is an
FSRM-enabled sucker so I had to force it to use it) and the penalty I
remembered is still there.

I patched read1 from will-it-scale to do 128 and 129 byte reads.

On the stock kernel I get about 5% throughput drop rate when adding
just the one byte.

On a kernel patched to overlap these with prior movsq stores I get a 10% dr=
op.

While a CPU without ERMS/FSRM could have a different penalty, this
very much lines up with my prior experiments back in the day, so I'm
gonna have to assume this still is still a problem for others.

So I stand by only patching the short range for the time being.

Note that should someone(tm) rework this to use overlapping stores
with bigger ranges (like memcpy), this will become less of an issue as
there will be no per-byte copying.
--=20
Mateusz Guzik <mjguzik gmail.com>

