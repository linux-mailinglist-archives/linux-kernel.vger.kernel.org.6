Return-Path: <linux-kernel+bounces-398442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC909BF15A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CB4B23F57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953EB2022D1;
	Wed,  6 Nov 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkJ9eDg7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993D17B439
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906148; cv=none; b=DeTe4EYZt/QXPRFfyEbPBnJnrs4QbYwzguqEVHAk237Y1n6ileegExRCEtvBWz5l/NyF93P5Wgmc1YmpvyX8gmcEHMu/K59s5sDT0zAXnClIWMLcPDo++yTrnPA8YkbUDBv2Y3ilSWdFZSYMtdrSXsMnOFz0+UPU2Kcg4KNfo1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906148; c=relaxed/simple;
	bh=ah6lRDJ1vIAqy6JYLuznrNniubx0AIAPGEcdoLbmwbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uFqp9/C67U2qDH09oTL+3A57Bh+fJdeOA9WF/c4noit5rAdsfLa4+Vu++1PK8m30ZwokULzlUc70kBf6WwRYg+pJZKDSf8wHk9jXYa7S+/fRFWnYFOKNUmSj4WUWku69nGgf0FP3oIFCekdZYR9o+WwpH7jrC4SBoQq0Cq6kXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkJ9eDg7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea258fe4b6so136870877b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730906145; x=1731510945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ2mx+EpljTToGeyel8oB03Vw6L977V2IZ3L/Hui8OM=;
        b=fkJ9eDg7ln6P3eFEkRVgNEFW9EqDRPPRY78Ous36LuuWrYz90ljfWAkGneRo79LVAm
         /MXHDOFDG1USCtwA1GzmWncEGciH1qWqktpF9/M3O+V3DebHgmetqhccI7lOpFzJNAiA
         Sd/k3gSduveuHBkz91z8cULgdJkw3cY/0V48QnaPWiy7n/xIpuPVpT/W7/SVe2t5HW0M
         90ZMoA52/BUnLeTtqS0fQJVsmnSUnsTVKoT12Q4vKGrkDXc8QTEHY56WOv33opMBQ1I/
         Smakj0n0Nr/tWplJuBd0pjN+tsHyn8vsbuPpzg5GYnRIT7lTVqvNfSCz6fuJEtgcT424
         kdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906145; x=1731510945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ2mx+EpljTToGeyel8oB03Vw6L977V2IZ3L/Hui8OM=;
        b=eRIOyluVX93UFGRgEsRjWkO/up7oxLyAXD9TZRZfbzz8vyhS8iR15nR6QPMJCz2MGk
         M+TvcvHkocrNUiiHifO3Pv4ASpYHDWkcFEnMlZ6BsUCm9iFo5DxADWU2+CHebfWhuZKq
         K9eTv9gxOOITstBXU2lVLeoBR0WTzdEeG/p/dG4Wp0luJsKegYggxZxnZLRlTAXsX91L
         sAKuVnHvjF1ogJ1woUS/FjOg6Z+7W1oiAjwkwzayulsFzQ2DLvzY25bClxhjCpJa55Ja
         DZwUM3LqhLTFbKTC3AvhRMus+mZxF8pjegL6XnBfSG1ehl/KW4IJONOiDDaM58c9LXeA
         3kSw==
X-Forwarded-Encrypted: i=1; AJvYcCVn0wmycp/211hGLB3ithE/KRY5faK5CHcbUVa//TSi/lyoFmVaeYnpRiIVcF/1oRU8s3yHoEzZeBe3kSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30zZC/oFZ0mXQBFWZzlR61SKOkNEPRzXyiVN9Azws6EkBtTDM
	PmtwJhx5Kh8fB2n476cEWxzVLinSrDtEWifhTsh4aJOFXsTJCJlUN4U6YYPZhliCVB16bWA/i49
	/vg==
X-Google-Smtp-Source: AGHT+IHSVYy6O6LuOrDLKfyMmnWs9nkPoThhKY5KU2GVwo0c+o1WEZ/A33w3yFUxE8RmnKti3wVld/5lngA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:7448:b0:6e3:f12:1ad3 with SMTP id
 00721157ae682-6ea64be01cdmr2004097b3.6.1730906145701; Wed, 06 Nov 2024
 07:15:45 -0800 (PST)
Date: Wed, 6 Nov 2024 07:15:44 -0800
In-Reply-To: <fb72d616-dba8-410f-a377-3774aa7a5295@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105160234.1300702-1-superm1@kernel.org> <ZyuFMtYSneOFrsvs@google.com>
 <fb72d616-dba8-410f-a377-3774aa7a5295@kernel.org>
Message-ID: <ZyuIINwBdiztWhi3@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
From: Sean Christopherson <seanjc@google.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 06, 2024, Mario Limonciello wrote:
> On 11/6/2024 09:03, Sean Christopherson wrote:
> > +KVM, given that this quite obviously affects KVM...
> > 
> > On Tue, Nov 05, 2024, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > A number of Zen4 client SoCs advertise the ability to use virtualized
> > > VMLOAD/VMSAVE, but using these instructions is reported to be a cause
> > > of a random host reboot.
> > > 
> > > These instructions aren't intended to be advertised on Zen4 client
> > > so clear the capability.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219009
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   arch/x86/kernel/cpu/amd.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > > index 015971adadfc7..ecd42c2b3242e 100644
> > > --- a/arch/x86/kernel/cpu/amd.c
> > > +++ b/arch/x86/kernel/cpu/amd.c
> > > @@ -924,6 +924,17 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
> > >   {
> > >   	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
> > >   		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
> > > +
> > > +	/*
> > > +	 * These Zen4 SoCs advertise support for virtualized VMLOAD/VMSAVE
> > > +	 * in some BIOS versions but they can lead to random host reboots.
> > 
> > Uh, CPU bug?  Erratum?
> 
> BIOS bug.  Those shouldn't have been advertised.

Why not?  "but they can lead to random host reboots" is a description of the
symptom, not an explanation for why KVM is unable to use a feature that is
apparently support by the CPU.

And if the CPU doesn't actually support virtualized VMLOAD/VMSAVE, then this is
a much bigger problem, because it means KVM is effectively giving the guest read
and write access to all of host memory.

