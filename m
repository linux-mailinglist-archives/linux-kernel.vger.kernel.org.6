Return-Path: <linux-kernel+bounces-427672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D49E04A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA17A161664
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88B2036ED;
	Mon,  2 Dec 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJjlkMAi"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC11FA15B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148663; cv=none; b=fr8pnwB7Fmy+qMcWYIU0JAPNWGyJkW/pSSI/uXDPvBsHQaChH9LCZXCwoqCXbdd6IUjuHST1xiYhcVTkepRrrp+MhxF2lH4G5KAlYqXyb/NGixhcH1UP1BecGOP2aqt85OSRqZwlBijeFmthPhFxCInwm+CF7j0vbne4GF8+czI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148663; c=relaxed/simple;
	bh=Owvsd2GIFPOCpbP2iP2o/schp0Rwv7AIRVJzM5BKUTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8iSHLGsc8kZDUp2PhBcxIeFdcRCEkqtQvg3IGj9FB9xPGCnKQMCYq1kriy7IqDxuVbvLv43O7dZ4bF6ZMo+4eHTYLaiyiuZ0PgRXcLab6akoyQBaRMHE2iJedV+zJRLt0toH0IFcxlwc0yfNYNigMXlC/wFVeTe090ScbAk+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJjlkMAi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-72528e19aa9so237070b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733148661; x=1733753461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhG3GF72Fq8o/jk0lOvSw1REGfU3YheRFY4zkgPERm4=;
        b=XJjlkMAiCqVQde7Caabpk/akyB4KFxlg3JPdgnmO9iVAvB/u2P68ZYSQ27lWxlrt0k
         31KFETj0qLvaFIVPovQjPJ01Tae54LDkVTlBySM+bCJ7PjTAQq6L3t86xP8a1yO/HSeP
         10YwbkkiIrfEFRFhHrt8XZJ2ZkfTJnfGRSMAw8HcZsLUS2iWdqBV4u4C1V2O2O0iV+5U
         c+BoIw27x13t8kvilJwb1PKu68ADxr0RvHzXKsrffKblDkr1cPnr7jqsRRpiJFC95Lh7
         ojhz/DG+j0pKUFzi0jvNbsCxk/F39K3juMOsb/FiygGLtQHcNvEVPKAG+Tyb+a02o9x/
         tgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148661; x=1733753461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhG3GF72Fq8o/jk0lOvSw1REGfU3YheRFY4zkgPERm4=;
        b=uWqjk8Hw3C2LkZZt5IHkke/c8dasVnDq18uRmBn6OtAkqPdZcIBUm183JpjmYdJN/i
         k8EjaVuzi/3LDkIrfEOBxIKlgRaHDrXbsybVEWx9gY6G7IyPJJz45E0aLh01oJL3JF+a
         Bhf+EYZrGtp4e29pldSdpQ1NaIDHpy3vHn0M83ci08L4f1J0N0MwcRVjAPfVc7nF/5Qm
         PF03qdS82bRerp9df2gz955Nq6fiNNMLXT/A/1KSH+b1ll3AgL3g0vLmLtf7SHRKHqFN
         nsyMiWJUKVFjLIuU1tId7H7uFLmvNXapyQtP4QO3JJNEtu4ZW1vjQX3VKcunNvBArLpp
         QIMg==
X-Forwarded-Encrypted: i=1; AJvYcCW9uEkfWgFIGNuUMqO6RG0T3mGojK1DDJtxMiHEcKiAQmUdUQbRPp1frbEnm2hSPpBVdUoCYXP+xySs2mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJUDZOpD5mWCdtIRc7W+k1amGpVovuEIaM4pPl0wTuzPgVkmU
	gJTQubs4eQM3Pw0DfMCdlEpcyDW4ISC7liqzV3lQ7fzowEda6Vyy/kcLhb/wAWGghbPjLaIT/Wc
	4+/JRzLeJnYlk137iTIGh2EVLNNI=
X-Gm-Gg: ASbGncvU3z/lAW8GtmsacZ7+J/dwJfzy8AfYwGc/dxLoM2HVi4EsB3tybJPzT9xPwLH
	9bST+fId1ApaoyEl8QShxmbog37CS+fU=
X-Google-Smtp-Source: AGHT+IE16Z2x8BUgyY0P0StFngdqghpu4YG8qMPby96pkRXX+IYaBbPuSlm8Dx+FaTprGRT0KdZqOS+NHsz7SjNozoQ=
X-Received: by 2002:a05:6a00:26f5:b0:725:322a:9229 with SMTP id
 d2e1a72fcca58-725322a930cmr12270990b3a.2.1733148661430; Mon, 02 Dec 2024
 06:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzpFOhQN3yCb4+OpLsfYVrq4mLuUS+SP=H=gq=qSLDz7g@mail.gmail.com>
 <CAHk-=wh74-reWGqpP+i3O8usrS1Jr12UGGMCfaK58_0aK5Lw_Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh74-reWGqpP+i3O8usrS1Jr12UGGMCfaK58_0aK5Lw_Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2024 09:10:50 -0500
Message-ID: <CADnq5_PBLv4EDAPY23B6QztH6bnbht8Nzy9dd+=T4_dH4RwS_g@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Sasha Levin <sashal@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 4:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 28 Nov 2024 at 12:42, Dave Airlie <airlied@gmail.com> wrote:
> >
> > Merge window fixes, mostly amdgpu and xe, with a few other minor ones,
> > all looks fairly normal,
>
> Hmm. I've pulled this, but do note the report by Sasha.
>
> The
>
>         if (WARN_ON(!work->func))
>                 return false;
>
> from __flush_work() looks odd, and is fairly obviously triggered by
> this one liner in commit 93df74873703 ("drm/amdgpu/jpeg: cancel the
> jpeg worker")
>
> -       bool set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.idle_wor=
k);
> +       bool set_clocks =3D !cancel_delayed_work_sync(&adev->jpeg.idle_wo=
rk);
>
> where apparently the jpeg.idle_work isn't initialized at that point.
>
> It looks like the initialization is done by amdgpu_jpeg_sw_init(), and
> it looks like that cancel_delayed_work_sync() is just done too early.
> But I don't know the code. Alex?

Already fixed with this patch:
https://patchwork.freedesktop.org/patch/625940/
Will be in my fixes PR this week.

Alex


>
> The other report by Sasha seems to be a 32-bit issue, where something
> calls roundup_pow_of_two() on a thing that would round up past the
> 32-bit limit. Presumably it works on 64-bit.
>
> But I'm not seeing anything that looks like a likely *cause* of the new w=
arning.
>
> There's a couple possible cases, although this one looks suspicious:
>
>         adev->vm_manager.max_pfn =3D (uint64_t)vm_size << 18;
>
>         tmp =3D roundup_pow_of_two(adev->vm_manager.max_pfn);
>
> because it explicitly uses 64-bit types for that max_pfn thing, but
> then does that roundup_pow_of_two() that only works on "unsigned
> long".
>
> Sasha - it would help if your warning stack dumps had line numbers
> (using decode_stacktrace.sh, which you should be familiar with, since
> you wrote it...)
>
> I realize that requires some debug info, which might slow down builds
> etc, but it would be really nice.
>
>           Linus

