Return-Path: <linux-kernel+bounces-412103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3829D03E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1FE1F22B90
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA13717C224;
	Sun, 17 Nov 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGu/7PUA"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A113C69E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731848221; cv=none; b=igyCC+Cp2JAt+Q41kedBfSgJiy8MIAJBrXvIUXxfzYd1K9am9WM6cliMZw1MqtzG/5lNUqJGQ1ZrBb5i2rAbZsQdCAFowGCNjoUL476oS1Jm5768NW322/A/AL7fOB43GMpoMAA5E3frfhc0pr1r68iz69rnHHjoxNKYdE52u0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731848221; c=relaxed/simple;
	bh=fJEIsnSqI8wipe2VWRv3nlOjvj88fv3IkPJxxge8d1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyueBaR0XpdOHWW8WSYVPYSlex1FRNMXYWyr9S0Zmb2d9UqANQKYSxSwvwbqTDRFPNERZjgIaYKTYSzinuBPoowqDNEHiWZ89z7a+Ir0SEyAGepmDgZmXLFBI9n2JXSVuyyzxiXIzRXN/y+EUzLv6fuNIzlm4Upw6Htiale1RCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGu/7PUA; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53d9ff92edaso3619305e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 04:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731848218; x=1732453018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svuhUIea1dsD7kkQf8MYGnky2oc1jwagz62kNPGoCLw=;
        b=WGu/7PUA25szJnCpPNYpug9Mg33mWT4WDVHCOunHVwtECZAY4oHWSHaWCPnjkZxQOA
         tKcFv/GFNf6c7HepMsq6CtQAOqy6v2l6J1acHEEzFFLUXkvabvhHWcgmWnVULVLlyocQ
         wRTJHkVd/+dMdwoJXSyVW/xSovKXcH5CaTwCwS9yRww/hA8c0o0lmnopOMzJPM8xJP1P
         D6Lj4TP6luOMVRF6MSZg+B3fUhierELUxxU40v9SJGE/Lq/M9sGSyYHGZL9H7p8Z8cKt
         Hc3pMZlgtXIrHIo44umPfwIq97Q5MjXqD2E+2HWLLCf7jhCN0dpaRWfq0WBT7Q0/cT+D
         Gs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731848218; x=1732453018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svuhUIea1dsD7kkQf8MYGnky2oc1jwagz62kNPGoCLw=;
        b=CtJOidtA05hcQF1i9cOaTgSbsWRelufx3FWhzsw2N0dZKPIhDC4kqxy921w0U58w4/
         +TDkCYH6gpwstw93uQM4IQV4/qD6PeRbJS2HVfDe4G1fxW4dOnZNlHHwEQ8DOCdDRzp8
         9djooen/T4PS5HMU8J++tHwgYzZibf4Dcuq2rA+WTrumuciLFwLivEeCaw9fy+NNH+cC
         xkkQQhSdTmCei0cPwIwJO53IHbE2trJUB8H0ge6S7+kxxGdqHr94ADmWakC2NUhD+8i+
         bLGhyslbfnCX6v3oYGb5QAxuvDIPm7IGIPns9BQMyDVKXI+4koUANMD+A5yBbxWAV6mO
         k/ng==
X-Forwarded-Encrypted: i=1; AJvYcCWqy53R3CaJYWqaecLihheqGInlf1HRXJBpml11PMftM4hc99J3OLJYeADVKQ6+Ny4vxkuvzitg5dvxc2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjNFkbFUF8gVt2zlS6YgvfT8h3mUzOOFb8F8ZN59Re1bvt1aq
	BqX0c7/8kWWHec56u+AWI/EojceSuHk2an6Tg56RZAehJqexa0ybwe0TY6mhsPnIrz0INgSUjzC
	jiTwf+IFkL+iWtBKgyXYTTLU28Q==
X-Google-Smtp-Source: AGHT+IENauFXnL9odGy7CG8xGMA6YrZ/aFfz4C1dgiE+a47hpCYrcHW8Fwm0iKV9h8iq5Uz0DKavZjK0t/xe+1M7D+A=
X-Received: by 2002:a05:6512:2207:b0:53d:a5c8:aaa6 with SMTP id
 2adb3069b0e04-53dab29cc11mr3088530e87.13.1731848217285; Sun, 17 Nov 2024
 04:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03ec75a9-aade-4457-ac21-5649116afa98@suse.cz> <Zzi7BxJASrR_wbAQ@sashalap>
 <Zzi7zR0maqdCC3ME@sashalap> <52be272d-009b-477b-9929-564f75208168@suse.cz> <Zzll9v3dR8UxwvQ8@sashalap>
In-Reply-To: <Zzll9v3dR8UxwvQ8@sashalap>
From: Xiongwei Song <sxwbruce@gmail.com>
Date: Sun, 17 Nov 2024 20:56:46 +0800
Message-ID: <CALy5rjW-rOAUDuFVVL67yRXhyVUjWa_9saE2HBTGbyAfUV53kA@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.13
To: Sasha Levin <sashal@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems there is a conflict between fc0eac57d08c ("slab: pull kmem_cache_o=
pen()
into do_kmem_cache_create()") and 543c5bde72e9 ("mm/slab: Allow cache creat=
ion
to proceed even if sysfs registration fails"). The err is initialized
to -EINVAL in
the entry of do_kmem_cache_create(), sysfs_slab_add() call can assign
a value to
err normally,  but the assignment to err variable has been removed in
Hyeonggon's
patch, so do_kmem_cache_create() returns -EINVAL normally. We probably can =
do
the following fix:

diff --git a/mm/slub.c b/mm/slub.c
index 73eea67a306b..19630a2da8e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6199,9 +6199,11 @@ int do_kmem_cache_create(struct kmem_cache *s,
const char *name,
        if (!alloc_kmem_cache_cpus(s))
                goto out;

+       /* The error code is not needed any more. */
+       err =3D 0;
+
        /* Mutex is not taken during early boot */
        if (slab_state <=3D UP) {
-               err =3D 0;
                goto out;
        }

Regards,
Xiongwei

On Sun, Nov 17, 2024 at 11:42=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> On Sat, Nov 16, 2024 at 09:43:07PM +0100, Vlastimil Babka wrote:
> >On 11/16/24 16:35, Sasha Levin wrote:
> >> [ Obviously I fat-fingered it and didn't add Christian or Al ]
> >
> >I have found the problem and looks like I managed to force push an older
> >broken version of a branch, possibly due to switching between two comput=
ers.
> >Serves me well for amending in some last minute R-b tags. Doing git diff
> >@{u} to check for unexpected suprirses before pushing the result didn't =
help
> >this time, either I forgot or was blind.
> >
> >I have deleted the slab-for-6.13 signed tag and pushed the fixed branch =
only
> >to -next. Thanks a lot Sasha for catching this early and please drop the
> >merge from the for-linus tree.
>
> I've dropped the merge and tests are passing now, thanks!
>
> --
> Thanks,
> Sasha
>

