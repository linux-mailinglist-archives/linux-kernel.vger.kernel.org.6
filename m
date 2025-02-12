Return-Path: <linux-kernel+bounces-511169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49976A3272E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE5C1881583
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8420D4EB;
	Wed, 12 Feb 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQc/oPfW"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761D1F428D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367193; cv=none; b=DsshVTWjWb2TK0Cggi7lu4EXsZBqvJWhvXQtm+YLVjAhS64BWkkjDDo1SeqwlCcqn7HZyaYkvn+lmJm9cUnfRMTHr/1ZZFH0G6iUo/a9UN6eG/Pch2qTBb7XgATI83Gc+zvLFgFoKU+u/YpKEWyV9mIbaZKF92bsUtDs+BM5RhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367193; c=relaxed/simple;
	bh=DG5K1efkIC2K+ZlCbKrYiWVMIVvKX4ht3N52bXP2YJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCWIK4bY58PjsL0F6zJ2URwEOBoF4MX+qjrt/+b4fW7eCb0ikifvXONT7NqTf/txhGCnP6NV1cY79WsQybdBIMXRLJmK4P8hyLb2ctL/hVDIWRfK8SDd9VRVX0bjRVR63MzAsbw/dZkI4bZ608KdTLPajE8sUWh/E68LU390Rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQc/oPfW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4718aea0718so324641cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739367190; x=1739971990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=814iHEDDutusXvvl7Bda5iR8JAhTEOQHD9FkFVmlgo0=;
        b=IQc/oPfW2Cz1R61bljc+TQs4xLUnlg6goiUE2vavFvELoJxS+qzty7HGLJnex23Zwm
         6JjlZ6aQ1236Iblrkot0VcM6TX2kXzmjHJtW34+/pTtzMM3Avv/Q8OElbszynVtlFSWx
         HuUDVtqSsBQhTISQFNcOVW9HcGGi0KtGdBbSSQZHa+cTtF7Dghioyo3XX8OheqvFyj32
         dznBPh2k6j7BBlXwmNt2lq685fHRucUoasu8B125eE6BO3GyaVOWBMJBvhtT6GdubbVY
         dWCUOAkobXDSe1WBjDrknfNfW8m8wgjXHOsTaIKQiOTC8hhDrBck4LmStvsT/lFonATx
         od+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367190; x=1739971990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=814iHEDDutusXvvl7Bda5iR8JAhTEOQHD9FkFVmlgo0=;
        b=bjmeegucqlEs6GSuF9Uux/dZsPJJyvKAJP0p2yoD6X9otfYGWaioD6nJmWSHLag6wa
         jeYWubuCy6R6LW8yQoMKKDw+ZPFjwpxZDJPBw5fv8kdHqRjh8CZmE93VGjyUO2xk9RV5
         mgw9RVxOqWWK9xg8CXfCyrQ5zAIU9G0WJ3SjozN75Cs0Tbfb00+x5PaQdWvPdUpn+/H9
         9OMBbvXkxResSPca543jmghWXzjxMedsduiEF5obsCW1GI7n5r26CYwO6UJvvTaHLNdH
         DJiJoXI28k55WF75B5AUWp96Z5A/c78QSmiiknGhp2mBkArO5tNM+8UtC8zRLRsVHKNV
         tk4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIRsrrN4PdC+7wMJhsfaYKVPj86AnW6bXtDmeqkWRbfwzenfhKA5wCyHE6CP1LaV7a+GlnxizjMlSuPhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMcXObrP+8cBtT0jIb1aOHcnCcAnxJPSy1yQrEV+X18wqb9xB
	RSfaLtb5ThKOusuDoKo3ViO386uzVkTR5IqzmepMlWQlMuVfkC6vkeOvAM3FzWJD2l9orNv4uZ3
	plMcKqYRQt7FN76T3AUMEK+CY67k1I5gP6Afq
X-Gm-Gg: ASbGncsW3Rd/JideThxa9RAsOx9W6yre1goaDHXz++4rbGjWGR81S9aeU6Zwq2D6wE4
	hmV8+lHCv8JRb1wATkACguwjtnpsa1dKM6pIl5z3rcwEuTGkgORVFB0xigqWWK4uNEwLMHQcxAI
	P6pZvPnbfaK9qRl+/p+YOBL8/C1Tc=
X-Google-Smtp-Source: AGHT+IHICDlIangdiDQT3Xw8Tr3gOveP7vM3B/Sc4ndJi/x+/hVYoXLbNJ39b7nnkHJt1riTKHH+IfVbIOuPLjDYJUI=
X-Received: by 2002:a05:622a:4893:b0:46c:78e4:a9cc with SMTP id
 d75a77b69052e-471b1e3ee78mr3422071cf.25.1739367190462; Wed, 12 Feb 2025
 05:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211210823.242681-1-riel@surriel.com> <20250211210823.242681-11-riel@surriel.com>
In-Reply-To: <20250211210823.242681-11-riel@surriel.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 12 Feb 2025 14:32:59 +0100
X-Gm-Features: AWEUYZkiGLiKgxUEboUcIkVGtUOF1eylbrTa0sOIn3QmsoiC4NgJcoUkRsTEfqI
Message-ID: <CA+i-1C31TrceZiizC_tng_cc-zcvKsfXLAZD_XDftXnp9B2Tdw@mail.gmail.com>
Subject: Re: [PATCH v10 10/12] x86/mm: do targeted broadcast flushing from
 tlbbatch code
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	peterz@infradead.org, dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 22:09, Rik van Riel <riel@surriel.com> wrote:
> @@ -798,6 +829,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
>         if (IS_ENABLED(CONFIG_PROVE_LOCKING))
>                 WARN_ON_ONCE(!irqs_disabled());
>
> +       tlbsync();
> +

Reminder to add comments or move this:

https://lore.kernel.org/linux-kernel/e8a156d4c8f5db07cf03b55fb81c75d523cac680.camel@surriel.com/

I actually sent another reply which is not yet visible in Lore
continuing to advocate for doing this in arch_start_context_switch() -
I won't die on that hill but I do think we need either that or the
commentary.

