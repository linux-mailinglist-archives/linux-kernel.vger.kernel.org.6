Return-Path: <linux-kernel+bounces-388108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A39B5ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580A0285262
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7AC194158;
	Wed, 30 Oct 2024 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2lXhZur"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DE192597
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730262841; cv=none; b=KzAB3Ag8VVuB8wegPInGh6VgJr5hjdUvjku3N4CDs6F9g5bF7+Q0kDphHsokL+5UP/jTkCugt0PAW8UczX3qtKuqglK6d/2QdL4lKYZyp1wyGPiXnGBGis9/T+F0lp+x37z4BV1iHYDcjskvpcic+oov9cJTK0SxXCC6Doe2npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730262841; c=relaxed/simple;
	bh=RcSRhMZZPGvMhU5zqKUirpaRLSx53bJaEo3kQjRlCP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfEe7VztXWDIMMRgboHUdYqajp6euLPcN1ygn69v6CPJNtRiEEOqq9FLDd/WrDtCye0Tkrwyo06Fjbl5vWud5f831TkSuNMrYJjHShzj7rKT5O8/cp8ajlxkOKWpMiBpoepwG8+UFhAZXi6Po/oeV12dcSgtVW3yXCBccqxGGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2lXhZur; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a4789662c1so1751755137.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730262838; x=1730867638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG6hO2gWJ8taKsYiL4E3MEns1U8+2l5JsQ0jftQaKN0=;
        b=f2lXhZurxvs7fEahkxH4Ngpj4K9BcJO1VscGzRhXvdlEEuwZuLy/gjYfZ3owN2SDvP
         GOE/Dthkqo88eeTYFZbckqSvQkrdXU56YO0mv6Q1htM0YMTnCy29DWlKHvejPTMEqjJZ
         DTytH/S3dItimhlZ7TpmB5C2WyBjPuNIJGCgHev64D/c76mhcEjduL+e0xyKkTc+oJCO
         Gv9nS51aUAiOo4chiFzeSZpBFi6aJBlWf9sPrE3K0tHNKXAbdwAjYJBjS7XoGsGzqMbT
         LexFh6H19aduXoZolfX/iucx4/9/woxT36WRLgbeoqemCUHYK5CVlHHNqodbzh52TSbr
         yzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730262838; x=1730867638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG6hO2gWJ8taKsYiL4E3MEns1U8+2l5JsQ0jftQaKN0=;
        b=PcB/VhFMx+a/+kSouQ8xGVXj0Yp552CTbGe3id/Plx3ohqjx+Ergxmh/23cAu4aote
         iwLvsrq9F0mG9hHzelaFnfmvlp0s6MUwuvTDgD6AvbY9XDg9HyE/PRUhrypW1WyO/zFA
         u+LmynAvrGqwIywX21kRkrvJnslxDuXUtvgy1fmCkR6LBJR+7W+YHSF2IIjNBUZNasOP
         Hn6Ym2rIXaxoPo4UwjKYOzV0UATkKdfZLfaPGncDkA5OYoMPrUBzSQW0xTy+Ze/X/S8I
         jtFshROhMnaun9oWi0GOZ8I5G2tFqSDELTkOM9EdzkEHkIItZuGAt97u/XacXC0MRyVN
         2uCw==
X-Forwarded-Encrypted: i=1; AJvYcCVk3Sagt6cL3QC2NqImmWJ3uSC5MWoqyoMKUzod18vRjhtxe0XfMeXvd14/qkDbI1cIBay1TK6NYTAbGlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgBg5cRDSf4WgxNl39hUDfYkgXI3Gqk7RiIu+2pOHJVarSjgf
	CTdqznQm4SpL8o0gPSyZlQe/QSv2epjgfJqXKzWI4mSzbn11SO44Gq9fRZ+ZTVTD7pP9LUp+E04
	1xdaRJKt2l7okZqZxmqvxh9gEyqs=
X-Google-Smtp-Source: AGHT+IFW22UJDra/AAdl18GtjXY/AcNc/Hjd5ddEPgygmD2/8jCptuTZKNZs8vX7bDYiXUqVlvoSrPh0zQJNNvPyWGc=
X-Received: by 2002:a05:6102:2ac8:b0:4a4:78a3:34f6 with SMTP id
 ada2fe7eead31-4a8cfb7d434mr14361593137.16.1730262838232; Tue, 29 Oct 2024
 21:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026082423.26298-1-21cnbao@gmail.com> <87o7329s0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o7329s0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 30 Oct 2024 17:33:46 +1300
Message-ID: <CAGsJ_4yv0CqAyiA1WaPdNm8HSUL5pda9frgT_1H31+FZt1fGjg@mail.gmail.com>
Subject: Re: [PATCH] mm: add per-order mTHP swpin counters
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:45=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This helps profile the sizes of folios being swapped in. Currently,
> > only mTHP swap-out is being counted.
>
> Better to describe the user space interface in patch description?
>

Do you mean something as below?

The new interface can be found at:

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
         swapin

> [snip]
>
> --
> Best Regards,
> Huang, Ying

