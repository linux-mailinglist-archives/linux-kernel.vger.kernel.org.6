Return-Path: <linux-kernel+bounces-271892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF6945489
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BEF1F21B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97614A0AB;
	Thu,  1 Aug 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5qIndzZ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD519478
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551587; cv=none; b=t2u2/9b1Ix/1IVPhr8+w64/1UAnbDmcSS+FsktXjrI0P/bQAig4vHHqIwcwS/CEVJJ7VwuQR1FDcvr3i7DPk/ZMNJeLtdR/1t55YR/rBGBaZIGO+UZcutQrETuT1WCQEen0SD8TdOE1JvCuSa+ncXVeAw5qaErAtMD2/KsgQyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551587; c=relaxed/simple;
	bh=3/DCHf0Mi7MnHas1RBkJFo29zzAxPCVdB6sNJMKMnxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9OHzihn7IrhxVEhoSLGf7MJmTO7VBDiG0Ep/x8Nid2yisleq8ejmEYDOi7qTvsIkPN/K8vAecGqXbQ8JGz85SNi7mZo39CjIuOY7a1uehp4H2H8Nl+Zg4gr2XYX+KNBchJSrmLfAqdUjyDftYbXC4VXSxuYVMl3LeWnQ8Wuvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5qIndzZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fdc70e695so1132191cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722551584; x=1723156384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3/DCHf0Mi7MnHas1RBkJFo29zzAxPCVdB6sNJMKMnxI=;
        b=u5qIndzZ+3VoKEdWjVTaVvf2n6J5CVhCOV3g51W0oEcJHwuMCZbwHyvH/Gc+fBpGKl
         xX4DTUzF1pPLTWxIA9Yd5FEK9dOcuOAR1TkPxc16lhfdEzN6IZoxtN6zRGHaBFjJ+NHS
         /shyOIePakCQEpQdHphb+W+Npb8ZceH5EezUg8Z2JZogSXs46A2Y71GaVDkNJIVx/jCv
         SGwcVSfOvrorwZGIkCRvam4JAxDavIlez+ljsJrY8+iX4Kb/7aAM+jsFJs6Z12Xw3mAF
         +gci/lnb/WXU8Tdj6iBI/qbMnQ3lwEcD2s6MmxOUmElMpcvVWn0IA55w5i81Fd9ZZMM0
         ZaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722551584; x=1723156384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/DCHf0Mi7MnHas1RBkJFo29zzAxPCVdB6sNJMKMnxI=;
        b=Jp47iBhPnjGNa3WJcF7RLdgR+Jrv2nN4PqgMe4kNS+0kr0RLYci8zSoiQU135SWKGr
         fSlDDjgwtKsFH8AqyLlGfsxE+ZCWxay40Am2H3agTyazFzBxYpWj9H5J942c5tFp6t7L
         qCawLmPAHM1Sc9syLuiM1nsG4ZXTx+IRNjTRT+RIbJ740Egp3h8yYHyd7f5J8yn0M73R
         +/wXWF8H7wh9C4qfoTq7g6gUm3aJpgZaQizJG9IGDkgNMKbLIHTAJ0EZb0OKEuAasCGg
         8vl+OIswygYpKE98s0gmTwsuUb/e4HbYA3JI6ZsvwecurciTCM2YKI1FYjA8Xiv8MmU5
         MsVA==
X-Forwarded-Encrypted: i=1; AJvYcCUecjP++PJWtLjTcDeAi5sa6+u8qEz46J2y7dLqbqeT/EigL1ER2bjuYNVPuFJcCpV85BMPfKLkxfux1MtjaOiEPbzV1+jbMXREVZMT
X-Gm-Message-State: AOJu0Yz1nLrupyMsuMnBHalHFaXkl6lnA8pzmbe/S13sIIOVruBRV4LL
	9lztffpv6shNh13LoRjr0HAfjMdDVKZUdbHNDt/LGuNnWnVugyH+6Cmi+EGvtFZL8KtU0MPeiIG
	ZRKP1SHyq4U06gnZrWj7haASGMf01lhFesG4u
X-Google-Smtp-Source: AGHT+IH4kx5BEHl2MYQeOJHqrPo3QiJWVFAMVijD+Yxbtszwwy+ECUOT8thV7bNlHDwKHQFEx5C6piS9XIci7cSVp8M=
X-Received: by 2002:a05:622a:1388:b0:447:cebf:705 with SMTP id
 d75a77b69052e-4518c40a992mr555461cf.0.1722551584421; Thu, 01 Aug 2024
 15:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724190214.1108049-1-kinseyho@google.com> <20240724190214.1108049-2-kinseyho@google.com>
 <20240725204346.GA1702603@cmpxchg.org> <CAJD7tkbZkuak=VYa_FLQVa=n+9Yd5EBXq5pc11GSiqn1fy7etg@mail.gmail.com>
In-Reply-To: <CAJD7tkbZkuak=VYa_FLQVa=n+9Yd5EBXq5pc11GSiqn1fy7etg@mail.gmail.com>
From: Kinsey Ho <kinseyho@google.com>
Date: Thu, 1 Aug 2024 15:32:53 -0700
Message-ID: <CAF6N3nW5ZwE_e7bF3eZqiD6d_QhkCyzZM4DEgo74kgO=hVU2Nw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during traversal
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Sorry, I replied to this email earlier but it had some issues with plain
text. Please ignore the first reply of mine (the one with HTML). I'm resending
the email below.

Thank you Johannes, Roman, and Yosry for reviewing this patch!

On Thu, Jul 25, 2024 at 3:34 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> On Thu, Jul 25, 2024 at 1:43 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > What does this buy us? The tryget is cheap.
>
> mem_cgroup_iter() is not an easy function to follow, so I personally
> appreciate the simplicity gains tbh.

Yes, the main intention here was to simplify the code's readability.

> This reads to me like it is intentional that RCU protection is enough
> for @pos and @root, and that the sibling linkage is RCU protected by
> design. Perhaps we could clarify this further (whether at
> css_next_descendant_pre(), or above the definition of the linkage
> members).

Do we want to move forward with Yosry's suggestion to clarify that the
sibling linkage is RCU-protected by design? Perhaps this clarification
can be made in the definition of the linkage members so that the
safety of the css in this function is more clear to users. If this is
sufficient, I will make the change in a v2 patchset.

