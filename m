Return-Path: <linux-kernel+bounces-560316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9601A6023E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EC319C6352
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C81F4725;
	Thu, 13 Mar 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPCNqhll"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61141F3FE8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896707; cv=none; b=mHf2nJ4cINIujaHXXd3LirVkdbR6b7ClDR1aRE37gBAJ6blVeEp2pYNqjA181lZDyHS3CKonZPVWMrn9w+5dgfDIZ9WqSmw71CTm635F238dEbVdziH0LPjSvVTaIKIKuHAWW0bZV3eN39O/6Pu7ahdIjXrWyXGANK5zoFbgyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896707; c=relaxed/simple;
	bh=YgUI60q5ptV+3ghWTvI6rPJdH4MbRbyGkUtPnyilU9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep4TBfGN8ihfXBxNJhdQrkb6b0OqY2ev9tGts4W6XjCoErx5bQYLwr9pAwO2jblTpkYscEntuMwWLm69hpZ+/68fB+KAbcn+RDvsZqAw6ZpxINT8fPlrg9Ev31I2wW/Dfsq+7eBAlaK6FbSJytr7l9Fk0H5QoTJfFeWq2mNDDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPCNqhll; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c44a87b9cso5912511fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741896704; x=1742501504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7OciFpgxZRF0cc4GubQh4tZE9/T3in31HW+mxGh1aU=;
        b=PPCNqhllYiK/xgjpowa0hplaNs1zxEcI+qNVheCIWYMyJti+fXojN3+lNgrRRWE9RR
         Mq40EPFQrE/KmBRMBdGrEECiBXT2ayIg6oci2wTi8un4TYNAiT9/7GG45jjE1gOTJJlC
         ega19wIlGiilZpU1ZuREE9NdJ1qOVAnInZaiGtU3SN1Fe2G5Kj8UUJCo60fk7iR8AU+m
         Qe/TcYjgYXxkS8QF4IYaWU4sgUcyK7/KJOOlgWItut2QX6FDJZK9hd+45Rj7T0FvAN1n
         7Pfc61UUQKKuwxiP9YAc828t45IXeOO5Exb1K1NCjKgVwmDDmN06V/eoOZY9E+C1QFiA
         opdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741896704; x=1742501504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7OciFpgxZRF0cc4GubQh4tZE9/T3in31HW+mxGh1aU=;
        b=mCf19CiO+Mtz1YyblH6jbui6RQsDlFIOBOwrryLE6wfMce6D77p7PA0Dm94Jut+y7P
         r7C4+xApNz+mKAKYF3DWWdAMHibQvebqpwDvQlS5S/UiJ58z5W7huC+uD+N/hCUkLCOx
         DB74G4K31Po9M9bUvncHRpFYE9xZEOLjILf+mtWyK2n8pf5d34rjB85QdHO7pJXJEGdI
         IHIbA4zDZGxWtAqGrVD71zJQBIT37K6G7DBYfhrZVzDdJwFOsh1t8Vw6dGDN/lQk3hD0
         uSL9ODEqp7LxsEniAZTbsfD0BJ/9aKPDIshnzpxTzdS7/iAqTVDOE0TTuAa+MEnbmzth
         audQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMeDEwf4H9luOMb0Eu78Hsh3ICi0JiYDbjlQSM/W/vccwljjZo5yu2997K8wT1JMTdYY9X/IGYo+QpXm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7z80H+ZaN+Nh90Bo19syvDdOIjeovBj1c0U4ot2ySPMvGVeR7
	9uuRTY1g4kWz4XCyGVVknPzni+FJZM9TWN+XroWVic2H4z9oL2yFOuh94B+1P2k+wH197Bpa1Dw
	fjv5fVS3iPo2BMTAOEEtbs721p2SrLBIC
X-Gm-Gg: ASbGncu9J9aZB/IawuD0uqPkxHs8vce4PBoNoc3iB9z8NmcfV7j7pHH4GSWJfncghAl
	t9u6/+RU5E/K8zn0SbEiMUGivPFRDC9zbmO4Z3h2caZzRXiBsrj0+ATovnbjNhoNsTHpdWMfdwE
	Wj9H2ujXSWTajXRmAfCXIpL8P2Ng==
X-Google-Smtp-Source: AGHT+IF5ddnkwXTnjcE0Nbv6J5+Gm/yWMCeb406QIA48zWz0ZHCSRMgUU43aKWnZvK+1lUrCs84igyn3Kk8K/NwOIc8=
X-Received: by 2002:a05:651c:19a1:b0:30b:bce7:80da with SMTP id
 38308e7fff4ca-30c46b42919mr5244771fa.9.1741896703625; Thu, 13 Mar 2025
 13:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313191828.83855-1-ubizjak@gmail.com> <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
 <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com> <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
In-Reply-To: <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 13 Mar 2025 21:11:31 +0100
X-Gm-Features: AQ5f1JolUuntaOXfwrH9RhdGSBPUFAQ8soaaZye7BdfaVms-tQIpLdNQNPwCv1g
Message-ID: <CAFULd4a5V3b6gfahGNsU7nHVki7Asnd-+t9NhV6NiE_8FYCpGw@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in amd_clear_divider()
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:07=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:

> >> > static __always_inline void amd_clear_divider(void)
> >> > {
> >> >-      asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
> >> >+      asm_inline volatile(ALTERNATIVE("", "div %2", X86_BUG_DIV0)
> >> >                    :: "a" (0), "d" (0), "r" (1));
> >> > }
> >> >
> >>
> >> So there's no point for this one...
> >
> >Not at its current usage sites, but considering that
> >amd_clear_divider() and two levels of small functions that include it
> >( amd_clear_divider(), arch_exit_to_user_mode() and
> >exit_to_user_mode() ) all need to be decorated with __always_inline
> >indicates that the issue is not that benign.
> >
> >It also triggers my search scripts, so I thought I should convert this
> >one as well and put the issue at rest.
>
> Sorry but this doesn't justify this churn. There's nothing quantifyingly =
palpable here to warrant this.

OK. This is not a hill I'm willing to die on.

Thanks,
Uros.

