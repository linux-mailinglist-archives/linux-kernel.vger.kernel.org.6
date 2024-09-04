Return-Path: <linux-kernel+bounces-315947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420296C8FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B791C25B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435C148850;
	Wed,  4 Sep 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugRN2aDI"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7AE13B59E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483120; cv=none; b=L7OL94WfBjHDthnOYunHxV+x0M8eEfCePjQnhwYPiIPyWtKSasvxM50GZV/Be057F87mAlXPS2+gZL3ZNfcq7Ed9e8V6CC8NyrucaNz851DkuuwXs+PaitxINh4LTsMxKJODaex+L//mywfoPdQsjYdtoZ9dyRcRiwhFVcQk9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483120; c=relaxed/simple;
	bh=VEu8lwhgjRv28++UfFlI7Q85Fll0aPf4HEKrWKfuyIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHUdxTu1qx2LMH5so+KZYUvN4HZUvrrRTMjB2LXQ7MkAgE7DaZnatTr9N25LUJkam03LyYzCmnmMmX+ZP2hSBy9dqub5iziDvzXX0sgWq1o6plk7bxO+HAg7hpcRedJDbhd4wTHVTBrsSAPCywvTToU9rE/GTrPvmWBu/I+Ng2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugRN2aDI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4567deb9f9dso22801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725483118; x=1726087918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHG7bQnsGZf2B0kptsJNBpltOovSM7V6WQ5dy2HJTmw=;
        b=ugRN2aDI7E+J2Uu5vVg6GyivqnrccH4jBK7hFNCvIJCou0NguMywd/xMsmrIT+5tRm
         CLBc0hPYynzKTWqJff74+ldbzD44q+8i84y7TALTFYSp80nP289T7zCOjGlEGkExuLif
         PxLeIPei4BDNiisp9qYmaGzVNW/bkUdmEWu4HAuxLGg3di7xHYm376eZN76FrJZCxj8Q
         RaM8Th3Z1Nuu7OzpzD+AdRM0viEzkDpJ748ndLg8x/KPkbvH2MAtZJXME7lJfwnteSMh
         iGBkOjhoNTYenD1ArgvVxDFPOo2siSMVTkAN2PkzunYqMvRu4JkUsDEzcpjVpwCW21jr
         6i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483118; x=1726087918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHG7bQnsGZf2B0kptsJNBpltOovSM7V6WQ5dy2HJTmw=;
        b=uZtDQZmUAChb0SGwiOHK2IoqumW5w3szMsY37HeTbPiD79tt/Ih8tVspBDEDfOI6PS
         sjPZeCHJbHOE4X+jv7K8qz5iNjBLhXkThUQmGZgzkCbJnLF3wemVA8Ph/MrGqUL+neo+
         At0OqvDYxDeIUfYXwtD7rHkzBjhKmYB8o7DzePU++gHN2HMK3pNbn/7IwdriyC9cjf/m
         rwxReCD4rqOrgpgdOivwhPpsacGcxzr9jDAh8VGS3ycpekRKWWCPZwkmYYWJsgTmMXZW
         M3fNZhwwEJSmYpKMGmVjR7Fw+EbIwRoI7nbVnWwt+2aXZhw6qc2sAMQl/w0sfATw3vQW
         6BKw==
X-Forwarded-Encrypted: i=1; AJvYcCWagtIvpQOFOSz9HDf+5FgYM7SgiNABjsksYTpEzVrcDJzmLmuRWnNCGGcuRW3zcZU4id8++WF3aVa9f1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnM52vDF71A+XW5EKCXDlN4ZrUYlQQzWhRvVmp1UWqe3Eof9X
	1IU2FuKGefF6ynDsrcicTwF9KMNtC+HgeXTdTf8xovqh+LMc3Tt7JQzja5HhMmnyQHXxyWdWdLp
	Nmt5Hh3YLgnRc0p5+Kt83rNhSpW8Wwu+pJykm
X-Google-Smtp-Source: AGHT+IEPmGqrm6+korttValUScEVXntGBxadK6A54rTJrxJ0IKgJZvo9hatZFvSKLsYoMlB9sNpfgYUET/vFucdBRiQ=
X-Received: by 2002:ac8:57cc:0:b0:456:7f71:ca78 with SMTP id
 d75a77b69052e-45801deb0fbmr961551cf.4.1725483117896; Wed, 04 Sep 2024
 13:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com> <CAK7LNAR4BEpehbYtQP3fw1Gt60EmSpzTEj8BijWKNCAi41fyPA@mail.gmail.com>
In-Reply-To: <CAK7LNAR4BEpehbYtQP3fw1Gt60EmSpzTEj8BijWKNCAi41fyPA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 4 Sep 2024 20:51:21 +0000
Message-ID: <CABCJKuf140CSbNm_9D1NGeMuRnZiGytnV8fawnwsWwhvGpYpLg@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 11:00=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Aug 16, 2024 at 2:39=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> >  /*
> > - * Symbol processing
> > + * Exported symbol processing
> >   */
> >  static int process_subprogram(struct state *state, Dwarf_Die *die)
> >  {
>
>
> I also tend to regard this kind comment line change as a noise.
>
>
>
> I think you can squash 02/19 into 01/19 because
> this tool does not do anything useful at this point.

Yes, that makes sense. I'll squash these in v3.

Sami

