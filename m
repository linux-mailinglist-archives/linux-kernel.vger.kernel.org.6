Return-Path: <linux-kernel+bounces-241129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B72392775E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44851F23AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38071AE872;
	Thu,  4 Jul 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgP1S1oB"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94F28373
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100658; cv=none; b=c7i3C7jVCW3AbsBWGaGzIa69wuLaNihu8f6WZiHSkFAi5Xir64oJF1vJZf0DYx/ryug2SDO2wd9poXMZc4v5FiBw5Al9B0+BcHyGvicrCoMjbMIDmAjphkNwwbQ62iPPs1kt3IWRf0g+I7fd2A6q7bmbX9hGAU4GdszWNV3N+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100658; c=relaxed/simple;
	bh=zoKgRBUb7kuDaMtXW8wz7v4HHutoPtOHRRz+Vq0hYh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LixOPeDFwGr0Fk4fn2CQ/BdVcsJzgOya9R80Tk0FryxJHKXDSnGoypwQcFUPU1nvLcG4OG5QFbhBM9bhvPk2jhWrcEigIGz28ltldihEXuiyjlB5KhEJmsxY75OUVe7LWGkSeBhLVReVjjUYOAllgyTGvjdvUDjQiXbzVW/rkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgP1S1oB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce08616a9so2546e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720100654; x=1720705454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+vp+msh6RVYJW0VzGFNvL6QlCbOInjkhWL54qzwHAs=;
        b=NgP1S1oBVck55hYpqq+azeAt8sLhMM1KEpg56bkrBlexsPlgla14SUEM94S/8S6TYL
         MkZmzFIAuxZudUn/l+V0N92kSicHBngEVLUb/er27sMXgAGh9RVNel/e0jYEfWortXcZ
         tpW6F0oj3cicYeg4Ct+LQl3Rn/rOV2OyEw0pHh1XfJTAUT0k1H53yJKJ/J8xDth8VauY
         WTVguT0uO4ugQJuFsVxYCWzgcYe/Re+IeARKbjuRMO1d7v2wYwI2dK3mTJWuZ+9f0ek5
         eRXzquvotYdI4KifQaAxdoIp62uIhGmmsHj3q2NChL+QKPPcQFlw1xF1u/eUmsXpyOB7
         x7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100654; x=1720705454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+vp+msh6RVYJW0VzGFNvL6QlCbOInjkhWL54qzwHAs=;
        b=cGNA4+CSUcygtmo9I4LtGyVhLFuty9AbjHhFdTK/qf6uM2+uRZoqtGFDBSumoYwoxF
         FRN36y+KrvslFwIEoKCdTKjSBf1utQTBNu0NbJYW9r1//p4DFUyXjPLLiD8XtCbaEmiV
         vXBMTj+q56VGp0Sm9ib1mybdY1FKP7AOntrqnodAh53b6nDUJuX1K9R/CChr6J4rKmvh
         beq7XwCsip92mQXuJKruGyk1cqDESpLrWOJ/0+AE4Hdkw8m2886XBCHanTlawRNWsh7D
         wgG57+14wk/iST2DBtzTu4elcmzY26puwJ6tl53Z4Q0WOoStautpKHMGVAutx/FaYWqj
         P/WA==
X-Gm-Message-State: AOJu0YynblB4PRmUFX/ujullIW6GB+PTwPq37g4e6e7JkGoEKz4rHX0p
	wEOEqM7Nvo2rOVi3hVYkpl0gz5oPLmY4S6J7G6BPeatUPUWxb0oDStpPYWbhG/UnXhHgqGjGpdO
	GW1nF8FRDaw6DCC/kQ07QMgJSLX30H3i6KzO5
X-Google-Smtp-Source: AGHT+IEQEFNmS5/guB2ZeMf7QrGTvy2SJmUx0h6RIuIFJyk7uzgPCWgMud5O7qY6/THnSjJr5Nk3L3Df5LZjlKCNr+o=
X-Received: by 2002:a05:6512:3582:b0:52e:8475:7c23 with SMTP id
 2adb3069b0e04-52e9f2bb8e2mr88833e87.7.1720100654191; Thu, 04 Jul 2024
 06:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000012d4ed0610537e34@google.com> <000000000000b7606506105d2a70@google.com>
In-Reply-To: <000000000000b7606506105d2a70@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 15:44:02 +0200
Message-ID: <CACT4Y+ZWjUE6-q1YF=ZaPjKgGZBw4JLD1v2DphSgCAVf1RzE8g@mail.gmail.com>
Subject: Re: [syzbot] Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
To: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 03:49, syzbot
<syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com> wrote:
>
> For archival purposes, forwarding an incoming command email to
> linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.
>
> ***
>
> Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
> Author: lizhi.xu@windriver.com
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index 53629b1f65e9..a435df98c2b1 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -243,14 +243,14 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
>                 off += asize;
>         }
>
> -       asize = le32_to_cpu(attr->size);
> -
>         /* Can we use the first field (attr->type). */
>         if (off + 8 > used) {
>                 static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
>                 return NULL;
>         }
>
> +       asize = le32_to_cpu(attr->size);
> +
>         if (attr->type == ATTR_END) {
>                 /* End of enumeration. */
>                 return NULL;

Hi Lizhi,

I don't see this fix mailed as a patch. Do you plan to submit it officially?

