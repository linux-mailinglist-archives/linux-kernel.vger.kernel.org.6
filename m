Return-Path: <linux-kernel+bounces-534418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F236A46678
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE663AB006
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635F220694;
	Wed, 26 Feb 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpGhNrRs"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690421D59E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586992; cv=none; b=Q7TmMynslb+zK/8YjmWpufIseJyLrMmQ+L+3XtWFfe+GD4M18L62YITza877yOycwPURHVVrBNAGM0JdQ898tesR268zZmxLfz2skzeE8lmYf8PSxV8ZXSWrbf4m3iXIT74VRn6rasIYylPwEYWSf3JRUL6b138ift4wBNuwd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586992; c=relaxed/simple;
	bh=OW3EKjV0GFKj4H5+AkSi8pTx6ChzKOaZ0w6/vFl+i0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVwzltIo8z9I3WU+cLSqc9j7H8Dw9aRNQJh3z2jhiJHE2B+DNDvBLGl1qOzHZxyjSnkpsmYJq2zriw0lCPiAd4/PhyMON4RtgOn3KAbAnB30sUDmfL3n68lW/hAZhhOLbrL092zZKK6wuxNnQpeHT2ytc5gAP6zAlVvt200qLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QpGhNrRs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471fbfe8b89so414221cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740586989; x=1741191789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYwoz+4o0rXaFvnnGUxhQGDiYZ+3+SI/vfL79oLs+ao=;
        b=QpGhNrRskqxuULwkeRKM+2wrloPklxAfnPG00a6bCgCNzIiT9XRBOEp/26oQ6deUmk
         p0ckUo8yNCpA57eOgoqDPM7qfhdfdXSBRjbXKr7s292HCCwbJCwR6pOz5uuNyIDuXUMh
         4dLvkVTWnu0IxxZdDlvvH0QGPKzk2HTYht0NX0CZd1d4iYZiSTXwn0WUg63rtnevxtEL
         3JATLJCZ/U4bwyvGpi5gSbnxmZhzAGRT8LbjDyf6G7hUQWEawdhRrAam0jf/cYlB8EcY
         MB4THjlBd/xNRQ+sHbu1JuUGCodIe5gWCm67ubAI4ynnoHiu3ZZwCNnY/l8Ve6zE+tvp
         VbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586989; x=1741191789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYwoz+4o0rXaFvnnGUxhQGDiYZ+3+SI/vfL79oLs+ao=;
        b=M/ecsdfwqWaJGIWzni1id+ZrjfDc5qLGOwxs25C5lSqkfScKh76UjOt9OU9MdDbHvk
         DZNbd9WkMTXjm+komk58nsa6fK+gdC8TrL9WPujsZnOf769lzl43y5uayjqTkmMOQv1c
         zaQXQI1u+8qb88gXABbu7wDwNB4AKfq65f4oSZHz1jeSXwj0rodRGcGJEF5PTY9zUAor
         poQeTtmDilHTrqG/OiMYvOnczV/fkG5xMURvCt9nFJAQduHcSkMb6HUo505XNSe4nqwy
         sLWAjV5uI2ZVPaUpRMVNHjV/eIXjpH/bTB3K5Ndrx6TMMjwsS/Sr6teE6CKFEVXMGgvI
         47Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWZdocYGvUc2LR2SltKXtW/6ae9aGW3z4Xme+T1WB0B0wK1R46mqWzIn1D6yPpKq3tecpEMVYVR4qNP+XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpN6xRc+UH0Y7mrcVWLCDYtDnplptvwjTrA4zXa3xYa6NUxxqL
	TznEeRqBaRvLKmGctHqyVVeSUCZkTvPbUAdYasVtOTqqvPhTFQw9ij/MoxMrISV2bNV4z8ku6ZZ
	VemcDohMnTcoGJ2G/+b9gSXQTneqUN1We/+jW
X-Gm-Gg: ASbGncu3DOKhcnuoamGd1a4I67CHP+0Cy8KEzsIyGjwCK2YWvFqqBkbqH83r8yjzsez
	HP/JZUDYTUyzM3gGbTH1fASx3Yg0op64zQq7N2SDNfO5Qw6neBZbNGoi8/0PJu5iO1yfDP1z7oL
	HSmRMswiY=
X-Google-Smtp-Source: AGHT+IGS4E0sY58X5WbTIcOKDP+XrBsyCeu0B3UEDuEcqOOX1Zx7lgdZMjLUe698XuQNGjVGfojoKnWDqlMSyuzqMOQ=
X-Received: by 2002:a05:622a:287:b0:471:f8af:3231 with SMTP id
 d75a77b69052e-47376fd1970mr10204321cf.19.1740586989239; Wed, 26 Feb 2025
 08:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225204613.2316092-1-surenb@google.com> <hdcrjkqb4cevovpw5xprkh7ohykqay5ew27sbtpzg2k7vrm7mx@6ircmivkmkgv>
 <CAJuCfpGu3Gx-kCChgQjZMQNOxU=CqzkHuoghfNmbv+Q1UKYPxA@mail.gmail.com> <Z78-YdCGtbV61x_Z@casper.infradead.org>
In-Reply-To: <Z78-YdCGtbV61x_Z@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 26 Feb 2025 08:22:58 -0800
X-Gm-Features: AWEUYZl0Odoo1BBPR51MmJxbUsSi0fMIUcQ-Z4sIaMMNc_DMaCdMCu8Iy33_Mg0
Message-ID: <CAJuCfpFykPaU0XBPBdfnVzvYGK8k_KW7KAEeh2ROyibkuquJFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	lorenzo.stoakes@oracle.com, hughd@google.com, jannh@google.com, 
	kaleshsingh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 8:16=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 26, 2025 at 08:11:25AM -0800, Suren Baghdasaryan wrote:
> > On Wed, Feb 26, 2025 at 6:59=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > > Reversing the locking/folio_get() is okay because of the src_ptl spin
> > > lock, right?  It might be worth saying something about it in the
> > > comment?
> >
> > That is correct. We take both folio lock and refcount before we drop
> > PTL. I'll add a comment. Thanks!
>
> In the commit message, not in the code, please.

Ack.

