Return-Path: <linux-kernel+bounces-435814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6169E7D7A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BC118864B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F84A24;
	Sat,  7 Dec 2024 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGC9+vZB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FE2563
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733531275; cv=none; b=qqh++GStHaNek/bxsTGMjpATVtGFrHxCt5/XCva+SOlOa0/v51ImC1hO4PLjYqok+FpiVjiyh+L2pgm3ANxTeHtP7fe4REUx+JFzRxyAml3Ub3Usvj8rw7m4eGS9ey+IQGxMMXFimECLWL7QNh9ONE8FEXOXBxRFIMlzXM3vQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733531275; c=relaxed/simple;
	bh=HDiTD71cqWDmXF0EB3u4x3BdN5QWqMcnruc9oR5hxjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yv+RFBAXsRjBedYnUBq1m1lKUEWXqLwdJpOcAffzTP8285yCmPGxeQSV6MEbgmBFJ5YD5wfzY7kUc5vYag8OR+htFXWDFLmoPxQD5DLLTWiyoB0lKRab8frwCDduNIcUvhvgtpcFGeViaSdOlPAd5fYwn3M3rGoZzNu0CMDXJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGC9+vZB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so298265666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 16:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733531272; x=1734136072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTfrwgPcpoHCXEKAVJ5Gd9meGKlJ3WwJtdjkvqdBBtc=;
        b=vGC9+vZBxv/Gtj0Y3DrdJgVccxR1ixxfvl+x50HuplKr0kQtgX11EM9JfnloQdFRCf
         sl7OUgxzYJibs7hVJTxWXPk1we9I5iIa73r2NCBrhIJU97W1S4v9MW1TGNwsOvkuvhTX
         HT8j/7QUB0yuf/AFXt61pKkzrALUxynoTBGgZwSkL/alW6Bjn7CAxr9+hyzn4qY22Dgy
         NFpJBMASaqS6395HD8MTZe+q417tn8ifD5T9mmherEqK/se1RkqiT99cp1nxxKcyfsgQ
         8XX5ARcNVN4kSMaeA9ZWgIrroHqvl/uIFb7GKY33zwphk/nAQA0dXm35y/+QibaOGpRo
         q4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733531272; x=1734136072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTfrwgPcpoHCXEKAVJ5Gd9meGKlJ3WwJtdjkvqdBBtc=;
        b=wvYWRxQNzQg2+K7MrsqW+gwPhdF9r3KuD+gBlvLanUJc6DWNISaOpjLC2ZlEMh9o/N
         vuKS/PUnEbFGA5rIx/5O9ovxKVoFpi+4lX+gq6Np6e+bdkSIMES0nU7RVPPEE7xF6E5X
         d0U8hnygR8IsWtLZTmulcIBWxKMcrtWU0G9Rhhr4xEi18QIadZReSfmulmuNlqaB3sVF
         g1FWCrfrjpuPnGtdQQk9OstM8rdRPb4tjKXdvpYXII5e4ZZv5IFrb/3EvzFjyLyI0n1Y
         ajUhF18HwKfQKTkRD5qRXbI5m7s4v9XXPvtIaNmJ2Jg/JvvdDrAYKEn4PAko5dZgpEW1
         Ndag==
X-Forwarded-Encrypted: i=1; AJvYcCWCibAWIH47EU4J/j0xDdtd9FmvDlO6M6ikgkZRuq1B2sXaT7RjztSIJOmYqse0o7pSr350HaMyHnmvIGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RpiUJqkBV5KpSAxiLZD8+qYR5+xytc0QpM6ayq0KIgFCbWnP
	cUH+OTL6+A+76Li1a2h5xBfCubv0VtgLoAFc3P4BkhhBHnZhuav2zo39hHKZI3pNaNirs+MWiIQ
	i/riMl72OIwpmQaCokQTaJ2wPmraRiuflzMjE
X-Gm-Gg: ASbGnctG42jSuWGTOwFke3YKkJ0GJXoq5BFvCnIZEjtyt/ED21kx9nGLdfJc4rROPpD
	1xDWPnocRHRE5+8DGlA4EBAXLAW7lQ28=
X-Google-Smtp-Source: AGHT+IGzJ5Ke/Qt6cMillUqq3xL/DpUwLfu70bGkQYSeVqx4Updorm9nDhkBlTBwgTkSILEBYgCY+kqHOfJEu1fAU50=
X-Received: by 2002:a17:907:774b:b0:aa5:2ef2:58bb with SMTP id
 a640c23a62f3a-aa639bf9d65mr352823466b.0.1733531272316; Fri, 06 Dec 2024
 16:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203090045.942078-1-nikunj@amd.com> <20241203090045.942078-2-nikunj@amd.com>
 <20241203141950.GCZ08ThrMOHmDFeaa2@fat_crate.local> <fef7abe1-29ce-4818-b8b5-988e5e6a2027@amd.com>
 <20241204200255.GCZ1C1b3krGc_4QOeg@fat_crate.local> <8965fa19-8a9b-403e-a542-8566f30f3fee@amd.com>
 <20241206202752.GCZ1NeSMYTZ4ZDcfGJ@fat_crate.local>
In-Reply-To: <20241206202752.GCZ1NeSMYTZ4ZDcfGJ@fat_crate.local>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 6 Dec 2024 16:27:40 -0800
X-Gm-Features: AZHOrDl3SpW2yUOE4NnqTw6drUgFtOkKUmQITX9vdhNNtxkNKTbrn8zbUmF7UeE
Message-ID: <CAAH4kHb-qoBtUxPiNtFsBFFQdh+5mx2z0F32KrkFycgc-S45Rg@mail.gmail.com>
Subject: Re: [PATCH v15 01/13] x86/sev: Carve out and export SNP guest
 messaging init routines
To: Borislav Petkov <bp@alien8.de>
Cc: "Nikunj A. Dadhania" <nikunj@amd.com>, linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, 
	x86@kernel.org, kvm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, seanjc@google.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"

>
> Well, it is unlocked_ioctl() and snp_guest_ioctl() is not taking any locks.
> What's stopping anyone from writing a nasty little program which hammers the
> sev-guest on the ioctl interface until the OOM killer activates?
>

Given sev-guest requires heightened privileges, can we not assume a
reasonable user space? I thought that was an organizing principle.

> IOW, this should probably remain _ACCOUNT AFAICT.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>


-- 
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

