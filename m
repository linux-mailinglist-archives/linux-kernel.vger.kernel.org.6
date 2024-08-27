Return-Path: <linux-kernel+bounces-303733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A0961489
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BB11C23E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687091CFEA7;
	Tue, 27 Aug 2024 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RY7eEK/p"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB946425
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777132; cv=none; b=Eu7HMDj2AeApSowYiJAgA1SP3PymeVIbfAp4rYb81Z8pfGkCnbfm2UtZGaWjWpe9rIoWNt26FvijR0khW/1xlaqMQnXaw20pJNLY1OfZA5PK6V0LJRWIYnfvdG0XyvhzT0wEC+Pz4Gjl9CMoQbPA2LrkOdZzHGXD+ZkJ5yiPtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777132; c=relaxed/simple;
	bh=13N9rWiQqinjqu5t0FpuSFOBXGf77nou/F+efdv0gD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUAfoMYSEo6tn5h1AlN7z8YXhKa4nHXXAAY/LyaGhMLYfAFrpiWLxN0qF7KitO6vB309CysSwHBAsHVsRbjYx7cZ0PtS/XaMWlP43IvdNxrIkOuqV6VjPl5JNFcprV9A0E3begq6E/cyORdWIyds8Z42p4QIfUHEfkt+8Db6pO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RY7eEK/p; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fee2bfd28so1721cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724777130; x=1725381930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg+baRcLpnI1aQ9hlrSp/2fH28bJtbk1x405VvbEiCQ=;
        b=RY7eEK/pvNkcY/cFL21Qknc+7wcnBa6HbZkqzwy7+P1UfVB8nkzOetBoD5J8WgRv7L
         tFmmpD+0HEjP3sF9OOXJwBau+MJ+IsnT20s5IUXtg0+40y7ZQ4RMRHg++cE6DZD0v5mA
         L3eTryIKWPN+V0Pw2SNuqw+q0nRw6frsmP4fuKkmnkF1zuI2r4VAXr8g0X/GsIZEsaPd
         1nLDwEg0dVCUn1qe4pLMra7q2SdBDqrl4UWtBmgXLD4Z3LSpLjZ4cqvJh6/VaQaGyNBR
         xYBw/VMQHy5gDNQKhmw7vWOtDJElogiL5MizUTu6+oZwv46sv4PwsqwXYud56y8oVqh5
         k0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777130; x=1725381930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg+baRcLpnI1aQ9hlrSp/2fH28bJtbk1x405VvbEiCQ=;
        b=WlS1vWnz10HMUViz9s6ijRXDzlhZBUwcmB5/n4DjvWnm2RObQNuGsk8PsnBAzTQGDi
         NHv9JRkG2NLmKBOawtykTQ2mHaCWIzoz3+J1rr/etng0D02JuSoq1TNsieMeglFkW0J8
         RVMSTQMigSVOvetAYwvg2VXY4/5AIXkJ5dMjDjGu9mAcxgr6Qlyt7RVQ2R3PLhjNPuia
         R+Dj1ljaSl5H/mMXeTORm4rvnMBhRkn7TXmR/eos4UzAAIkuQIcJhprK8QnTyZ3P45SX
         o3Ln8vbXx+FwBb7BzyR3Zl1p3kycE/1a13nRcxbmWQ3rvCEAGZYwyWtVtcmXSuy/jF0U
         b3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUklbe+pBIRrN9jm20P6WmaxGVEoxwAkn13AMyu42N7VPS9IezeYmMCFw47xLA4eCMIFbHPwWrlrxFm05I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBl+tZ5CN+ojueOxIsracyPK/cJsfKGd9pbRqMTtGSu/QXNes
	0RhfogzSPbSy23ya4nOVVTLTtG/4fR1znVLveVRpsuPUflIauteDfL2HymbeI80ycYrlIm0Rglc
	LQ83JXquRAwKLTWAiXZOt+owa38mu6LB2Ytv7
X-Google-Smtp-Source: AGHT+IESmvxfPWyz8OU6lrsb3/WdN97UClbBtMAbPPLrSZVeS26g2TfKlQrHovYGaH2tJhJuXW9A22yAePy9L6g0reM=
X-Received: by 2002:a05:622a:298f:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-4566168780fmr4067251cf.10.1724777129419; Tue, 27 Aug 2024
 09:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-22-samitolvanen@google.com> <2024081603-punctual-hamlet-152e@gregkh>
In-Reply-To: <2024081603-punctual-hamlet-152e@gregkh>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 27 Aug 2024 09:44:52 -0700
Message-ID: <CABCJKufF4xpwGkYu_H-1AH8cEAg2K4umrM07DY_X2j9qORQj=Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] tools: Add gendwarfksyms
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Aug 16, 2024 at 12:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 15, 2024 at 05:39:05PM +0000, Sami Tolvanen wrote:
> > --- /dev/null
> > +++ b/scripts/gendwarfksyms/dwarf.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Sorry, but I have to ask, do you _REALLY_ mean "or later" here and in
> other places in this series?  If so, great, but I want to be sure, as I
> know:
>
> > + * Copyright (C) 2024 Google LLC
>
> Has some issues with the types of licenses that marking will cover.

Thanks for bringing this up. The license is inherited from the
genksyms code that's included in this series, but I'll consult with
our licensing folks and adjust this in v3 for the other parts if
needed.

Sami

