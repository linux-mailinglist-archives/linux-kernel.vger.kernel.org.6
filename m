Return-Path: <linux-kernel+bounces-517021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD2A37B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1473ABFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9518A6A6;
	Mon, 17 Feb 2025 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xwBhU6Qv"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6E29A2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771162; cv=none; b=QRTQpd4O31hEp1zloGSCUyZYFVn3eIiaAgLLq/b3T3sKve4XjPEFsjCBrYL5jf6XJkOgWhUjQQ07oO3pzsSvKxvQ60d4UXOeYM6r2yag5zsiK7PSzfHvBXU6/TN13igH3Lg+1Wkk48fiWhjiJ3rtytVPxVxfMDMAlqoAaiZZkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771162; c=relaxed/simple;
	bh=36v6jqmZpCEsxa7KW4JPCPXZ3N7MYiG6GwfdqHuGqxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufvPNNR8GtJoqOtE3HNq/zJikf1nT73J2KkpdX3p1GQiCvQRdrnEWALaY8O8rXf9xwazjyKYK/AWA0Zmq1jE2Z+cvCXfyYZJXNNGikS5Y4TnHi0Fx0X7ZHsbzZMqrn/ZMMibM2uHM0nCBe84EzLlHyS10kVuXMC36iD3wdwsAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xwBhU6Qv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471f1dd5b80so94481cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739771159; x=1740375959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgEtP7ZCj/iec489kglaPIikfWIGYspzrrfhJsqEWyQ=;
        b=xwBhU6QvlljIJXmjO2X7SCFQ/EhagSbhJL1Cti21f6E8vBUNEtT5t6NXlEvK1PJwE2
         51n8d0ICkNUMa5kyhjVsCGvBpe1TqINIsWm6MYJDhdrU0DuXWM8zW5RsAUpZaJiDEFGc
         Xhq4He7zw7kM7jjImzCDeJDh6b/wslGUGca6y2IgWMxC4/4hASeJbn8JMp6iyrLo3/4l
         BDoMfPfbFojIGriNnqJ86keGV2TYzRvsw7opClCnwutS4hZROtH7M8IDyPS7/UGRns2E
         WbugO3ONirEhuIBEYM9ixiV+jSuHVBc4VKv6VbZjw+aaBiTggZN0jyv3lKmWST/23xaj
         ZLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739771159; x=1740375959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgEtP7ZCj/iec489kglaPIikfWIGYspzrrfhJsqEWyQ=;
        b=PnrPh8pA0fTxdIHykMY8vqCGOQT+ikSjkYDpZwB6KGBogUx/A8MISLM6uRIplBtTs6
         /GnY1Q3o7AXzLQtweFZOGhbVBFxwyc4pYYGSHbn2j8SL9DPi2pplRqnyggHRKgST/UbE
         3YJ7jWw9Srb4vnfx2pZB/QgYSYmd7+8fkJu1m78lBCgGkG1fX4/mhFQ47gKkMWPLNf3i
         LTYEpHVT+FXfrkaVMTLPq+rm8FJcxw0gIZWk4FidylfNoKue1/BntKeaoA7zoeDHSBsq
         HRqVxtCY24h0r9rpPuK9AStNiVOV3dG6k/zOXOJGlOnfNr/Rs5Z0vVcEOTPLPtAFXNlH
         w/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Aqd2TREmdtwu9dnbNQzByMcrrjEyPEm3+9VW431N41OOFYQATui6yBjSfS221W6WyIVcYYB3By6Y11U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGja4zIBsDWlkT3S4ZJkXc7B1PDSE3DjR8cOjzUmues3R3phJ
	JoDMJtRM3q9DSzQHxwQSwuWBef9FiZVFRN5GqA39gKkPn37iEy6YdH5DFtMLX3q4TLC5vEqRimx
	GRSFrbZOjSmyQr9or2icFzIVnXQ9f4RRE/WcJ
X-Gm-Gg: ASbGncttxXUNNq5ZSQas1Oa9Q7ETUFTV7bj7IDyDNGHCM+/9T/PFb+ameiVwnTGQVY/
	LbUafzOm9ynsET5G56k8b/A85pXjAGoHyITwn1u6AqEgRBzsOlZsh++wlOrJ//P0ZI0K19fmuB/
	m7IaTvF7Y+c8UvUPhe4vD5emNvWAc=
X-Google-Smtp-Source: AGHT+IFWZTc7y7L0UDRu1d2wIAjRGiucn5vcsQ3bASYdK/8KN/JZXov27MH9PO3Rjj5rtaREOTBbM2DXstTopUX+pjw=
X-Received: by 2002:ac8:7dc6:0:b0:471:8b2d:c155 with SMTP id
 d75a77b69052e-471dde5eb1cmr4061821cf.1.1739771159280; Sun, 16 Feb 2025
 21:45:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217101453.34720e6f@canb.auug.org.au> <CAJuCfpEXqT-aHU39XMTtf-omJJUcQXtNF6RHmZ2bddqcVN0G=A@mail.gmail.com>
In-Reply-To: <CAJuCfpEXqT-aHU39XMTtf-omJJUcQXtNF6RHmZ2bddqcVN0G=A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 16 Feb 2025 21:45:48 -0800
X-Gm-Features: AWEUYZkLtcptRikPsV9k3V5QK8ESQI9OLOXmwPu4xnUTngqpDm7EjFewi9OLT4M
Message-ID: <CAJuCfpHR_NA+RERHRi3m1vwJVdDkcpd9Vd4XfM35gTnHeUmOag@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 3:22=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Feb 16, 2025 at 3:14=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > Hi all,
> >
> > After merging the mm tree, today's linux-next build (powerpc native per=
f)
> > failed like this:
> >
> > In file included from threadmap.c:4:
> > tools/include/linux/refcount.h: In function 'refcount_set_release':
> > tools/include/linux/refcount.h:65:9: error: implicit declaration of fun=
ction 'atomic_set_release'; did you mean 'refcount_set_release'? [-Wimplici=
t-function-declaration]
> >    65 |         atomic_set_release(&r->refs, n);
> >       |         ^~~~~~~~~~~~~~~~~~
> >       |         refcount_set_release
> > tools/include/linux/refcount.h:65:9: error: nested extern declaration o=
f 'atomic_set_release' [-Werror=3Dnested-externs]
> > cc1: all warnings being treated as errors
> >
> > (and several more similar)
> >
> > Caused by commit
> >
> >   1465347e498f ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> >
> > from the mm-unstable branch of the mm tree.
> >
> > I have reverted that commit for today.
>
> Thanks! I'll see if I can fix it quickly. I must be missing this
> function under tools/ in some specific config.

I just posted a fix at:
https://lore.kernel.org/all/20250217054351.2973666-1-surenb@google.com/

>
> >
> > --
> > Cheers,
> > Stephen Rothwell

