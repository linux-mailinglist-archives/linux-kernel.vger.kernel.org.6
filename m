Return-Path: <linux-kernel+bounces-276573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D45794956D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D68E1C20E68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51236124;
	Tue,  6 Aug 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30OntV3v"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8618D635
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961259; cv=none; b=setirq2WEtF5TWq1eSZgJWz9TYy50mw91WwBorPw9J1ywF4TMutX5vFoq7IlZZNiHt+b0zpBzhREnOPR1NN7Lu/pU6GkEgFgR6Lmlz5PuhD26jq03BscqjX3A6tg8taTaH6al9v+24Ekky8p46d3xQ+H0uUWxDSIJC0zKAF/3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961259; c=relaxed/simple;
	bh=1kevowYnPlHYLYU8u9TCipQQgHw367Fz6gkjoqEgEpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6QX0XgXbgwUxmLdW82s/PvbVZnImznP/7vhCkPsf+X/1iosIozpgsP90PxHmzDB2sVQjZfCIdqIBxxipwUtE6p9hEr9AW2Wg8FPPZJv79m7hj1j+1PkbRKbUuhCHssUPQpV8oE9X8fJCh9TFrtibpDsT1wi3lmyH56PwiRCBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30OntV3v; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso18908a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722961256; x=1723566056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kevowYnPlHYLYU8u9TCipQQgHw367Fz6gkjoqEgEpY=;
        b=30OntV3v490fIiUipTyVHbwGEe0AJUEHz4QB6yd+ty+jXQ9ZAic9YZdry1HVg0pQIt
         nh57JSUeZpCBf1qGDZnGFRodiSBZfOqY3xhPq6M0CwuLMkIXuIN6T8Ckxp0c+6FX1HEt
         uPOYkD9On92QeKuizzeVCfZi1Xi6Kg3a31Ae2uu8VGkVyiW2490bZSPZa7C7pJ3QN2w+
         JfPucG+EjGTlN834fKHctSm3vE78ja9IgHeEp6qFuLiCPjDIx+Iy+BWcNGL0l3tuKC67
         WzV8AHXdx7F+Pt66hBkkMiF/e0CGe8wPcaJrAU3912eBuakAbSA7ZgsuNAeXojmWS/qc
         12iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961256; x=1723566056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kevowYnPlHYLYU8u9TCipQQgHw367Fz6gkjoqEgEpY=;
        b=fWrIoQ9y1HTMGCad8ojZTk2/4hUhRpjxsQldRXwtj5gAKJ4PVm+n20M1cnsrZf6ITH
         nzEidltt+0UuqIW8PYVpS5p4QGHxxO1uH3518jczQn1AxUo12C24mkUxQ3sdHC4rssQw
         H38mzoMJYtHrPiFKt6wVP6gqxP+30ZTiLm6+TAw/hPdVvUVLyABnc2BSwwTjaN9KcALn
         cSvSUtylKTCoSoy60g0TAVPDUt35Rs+l46GuixWRq0jUOesFYSl4UY8G0uSYrilXVcgE
         KnZl4m3x53+65ZzbRNa3UljkIhIex7D0/nSfxMN29LMlm1gxnk/r3SvwKDCXbsznwhky
         FiWA==
X-Forwarded-Encrypted: i=1; AJvYcCV4/UuYM2I7Q3q5Y7MHIflx9AYzsURWlWEV1+sppcKIPkUSc59oQYfSR8ijnHIkT+NVAmlou27imGIYgl/5ov/5bB35a54E0MfPDCwS
X-Gm-Message-State: AOJu0YwhYP87vM137iTr5fg1uHczOI6yz224/TDBkY9Z1xt8Z+mXXWBL
	tPIzTFW/w2NU+u2azNakrnx/NpAlRJujzXVNtO/PcgOoo6K+IVIg5ggNOZh5P6eHBnpihLu9YW1
	y5gURn+zdY90Y8y/wJVi29PGF/U5ZRucL6AFMAAKmXumboVH+8AUB9dA=
X-Google-Smtp-Source: AGHT+IH9G1E4wUnFeOAD1wxpsFYmk4ANzDs4lKz5smbj4toDx2xB59clHn1VriJU+dFfw94NX90xpdvmWwuNsfjqBPM=
X-Received: by 2002:a05:6402:268c:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5bb991dd751mr151177a12.1.1722961254788; Tue, 06 Aug 2024
 09:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-fix-vma-lock-type-confusion-v1-1-9f25443a9a71@google.com>
 <CAJuCfpEy1QV-9uTUtrFvN-6eS5KFw-ZyQothQbLqXFyUaJ4xgQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEy1QV-9uTUtrFvN-6eS5KFw-ZyQothQbLqXFyUaJ4xgQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 18:20:17 +0200
Message-ID: <CAG48ez0LJGi_OGynxh3z8KNvDHVkVbENgGg_oPLzDCi=gJujzA@mail.gmail.com>
Subject: Re: [PATCH] mm: fix (harmless) type confusion in lock_vma_under_rcu()
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:14=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
> On Mon, Aug 5, 2024 at 5:52=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> >
> > There is a (harmless) type confusion in lock_vma_under_rcu():
> > After vma_start_read(), we have taken the VMA lock but don't know yet
> > whether the VMA has already been detached and scheduled for RCU freeing=
.
> > At this point, ->vm_start and ->vm_end are accessed.
> >
> > vm_area_struct contains a union such that ->vm_rcu uses the same memory=
 as
> > ->vm_start and ->vm_end; so accessing ->vm_start and ->vm_end of a deta=
ched
> > VMA is illegal and leads to type confusion between union members.
> >
> > Fix it by reordering the vma->detached check above the address checks, =
and
> > document the rules for RCU readers accessing VMAs.
> >
> > This will probably change the number of observed VMA_LOCK_MISS events
> > (since previously, trying to access a detached VMA whose ->vm_rcu has b=
een
> > scheduled would bail out when checking the fault address against the
> > rcu_head members reinterpreted as VMA bounds).
> >
> > Fixes: 50ee32537206 ("mm: introduce lock_vma_under_rcu to be used from =
arch-specific code")
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Thanks for fixing this subtle issue and clearly documenting the rules!
> Not sure if we should CC stable? It is harmless but it's still a bug...

Yeah, I'm not sure - I guess it kinda depends on how much we care
about VMA_LOCK_MISS being accurate?

> Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

