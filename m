Return-Path: <linux-kernel+bounces-572032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D595DA6C59D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570353B3505
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE3230BD1;
	Fri, 21 Mar 2025 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwdfF7sh"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B11F153D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594749; cv=none; b=iIqHWMcGRnujp5Ph7LCu+Iw4EF65qYmGhkW5a5hQg/no6PPwJYq/btag5Itt+UxvxH9Qr75Ux9CtAOeNaosor2P9MSr8KuMl6nlmdIQhZsy7G3Ux36r4qqOjGOCIKX3BeFv6O3UF/VDxPLqMiIy2TXh9woZ9m3ISeFcQGt0LzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594749; c=relaxed/simple;
	bh=GPWoxH3npdvl8WN2CEBUpA4DabBGBvrnSd1ljgk0us4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YbYuVt+LzPd6oPev58cqj93XIOIXI46LcWZrQvEjQyXR/sqBvfaTeNoNUkTxd8naWxORLBVua5SpxoOuexmiN3k6dbF5Ach84QhDWDO2S4OB6TCvam0vqEuIIA2suhMehBsPCiPRNAF3k/rzjCBnsjw+RnqE57bSIBo4mRIgF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwdfF7sh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241ae15dcbso44355235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742594747; x=1743199547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeooS45TQglyMMDVF6rkeuWL2/GQyCi5QA5y17By+RA=;
        b=UwdfF7shZVwD3N1CaEh+6VLPU26DYa/Ppn30uAZs6npM15HVQL27cpX28W05O3nJ3A
         g4dL57pG62pkC+HC92hGwTxHqdMdKFA+pfSjnhb3w9Y6E+mclsAoSTwWYC1ZWcNQULid
         eOkXZB/WmE0WqDZbjrddb2LwNQO3ItqYyZ/KKViSaj3q2CM+bWSfoV7TqJId5WYVwOz6
         i7UXzLD0VOt17+tpyJHmFCxV3y3jWtfscBQAtHW3jl+UPayrYC5j7cVk5/sI3a+V4BhX
         jQFDCdjsiTZKXYb/fva+XyflMhl77QsK1RkWqiOjGMmWxOXSiYWk4qg3NaEMLw+KlHvM
         +1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742594747; x=1743199547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeooS45TQglyMMDVF6rkeuWL2/GQyCi5QA5y17By+RA=;
        b=cTfzsBHPZdjkuQk5V+uO3Tdg1CuDGfyS4zDYA2Qv1VSaIIorqr9FsxVUgZ+9PwDctQ
         lINxYLVjaMuoMBFYxugj4sNIQfofsqSAwzoZefzhbwE38haH/Tdg9uiMfTeoWEfN8YHC
         /jE9mO2zqmj0Q6H307QcrROvNvbh1YnuLY+7HgeodWCUwF2M28Ih2njY92ExDGvzsp+J
         9iZBU3dX2lvUqSgzmFJEWa4G63pK2EaGUBTAtDjTAmXELyXNSKAa98+XBNJMJzoTvbSC
         8eXhnPzJhR359dg0SjzI2GwaqS5duCGZjTnV+7vmSt+HgU0QIfYhiKKIqP2ZnD+jLTwU
         TQSw==
X-Forwarded-Encrypted: i=1; AJvYcCU2OPRLvW5Ssz/vwa3GDZH0zq4+7z+GgkYfScLgtySZ2wYDO1B8Gik7DQ3QQ3oFfc8yCwu0NCT/PnQ3gyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVC3qGvttFXSZ9lyHKagY9Qzj1Umb+HxpRVD+Y/y9iHVrkEdqK
	ePMaof1+tH4ZLKy2A7jexp9bwBap1NKrO2AHwx+tRoKtzsVdIscOI+BnFxSbB1r6Ixbn/UuakBD
	gZtpYThKlCsdAxK9CNw==
X-Google-Smtp-Source: AGHT+IH8oUHOd8cDU3Sg4aTfcA9eCg006OOlCicgX9+Yz8rj7I1UgXvDgxqTd/osjeg/tlyBTgtyuVc/MG3MozO3
X-Received: from plbbf3.prod.google.com ([2002:a17:902:b903:b0:224:5a4:9be2])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f643:b0:224:2667:8115 with SMTP id d9443c01a7336-22780e307eamr102834375ad.48.1742594747216;
 Fri, 21 Mar 2025 15:05:47 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:05:37 -0700
In-Reply-To: <CAGG=3QUEY_Gmu-6K7rk6-y8AB7HVuV2V9sP5K3h379teAZXyHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGG=3QUEY_Gmu-6K7rk6-y8AB7HVuV2V9sP5K3h379teAZXyHQ@mail.gmail.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321220537.507917-1-changyuanl@google.com>
Subject: Re: [PATCH] clang-format: add for_each macros from libfdt
From: Changyuan Lyu <changyuanl@google.com>
To: morbo@google.com
Cc: changyuanl@google.com, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, nishimura@mxp.nes.nec.co.jp, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bill,

On Fri, Mar 21, 2025 at 12:28:44 -0700, Bill Wendling <morbo@google.com> wrote:
> On Thu, Mar 20, 2025 at 4:59=E2=80=AFPM Changyuan Lyu <changyuanl@google.co=
> m> wrote:
> >
> > Add two for_each macros from scripts/dtc/libfdt/libfdt.h.
> >
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  .clang-format | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/.clang-format b/.clang-format
> > index fe1aa1a30d40..4decda7474e1 100644
> > --- a/.clang-format
> > +++ b/.clang-format
> > @@ -210,6 +210,8 @@ ForEachMacros:
> >    - 'evlist__for_each_entry_from'
> >    - 'evlist__for_each_entry_reverse'
> >    - 'evlist__for_each_entry_safe'
> > +  - 'fdt_for_each_property_offset'
> > +  - 'fdt_for_each_subnode'
>
> Could you alphabetize these please?
>
> >    - 'flow_action_for_each'
> >    - 'for_each_acpi_consumer_dev'
> >    - 'for_each_acpi_dev_match'
> > --
> > 2.49.0.395.g12beb8f557-goog
> >

Thanks for taking a look, but I think the list `ForEachMacros`
is already sorted alphabetically.
Am I missing anything?

Best,
Changyuan

