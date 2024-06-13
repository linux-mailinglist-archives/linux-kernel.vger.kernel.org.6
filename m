Return-Path: <linux-kernel+bounces-212881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA289067BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A0C1F2603A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C613D88F;
	Thu, 13 Jun 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ1OKDk+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613F13D53E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268594; cv=none; b=nHCxRdmBJ41AlmGHBnHZs6rw0xUNpHeedq437EOUlUdlVjSDA0lxDae+VnVchxj39u0Wkt9uHZCsXvIcP3TS04g7WemL13+pdeKuBVkxBiwTkXZdUrMk+8LPdTj+FdPGEGkjfU/pJdTI+EdiaLxqxs4cfBbb7IdBhu8KW1fr4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268594; c=relaxed/simple;
	bh=f9zjtO9AtabnLNuJxqiPcWb5sV8xQYdL18OmBwU1Kd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VB3fwIslhJrehkwpJESDy0ZAE+d4+QWkxDhuKTnd23Udm8jjQR8RCtIKyQvNDniIVDV0MfPEx6JmEDhkXaMjKOQG/2FmzbWR/eqJUX+jjzwY/oBR9Qtbp6J9WWtvTM3GDZ/JQTqqRJOr07hW1KK+yqJ3JsNRYezQ7uNNHqeHL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ1OKDk+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso394602a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268591; x=1718873391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9zjtO9AtabnLNuJxqiPcWb5sV8xQYdL18OmBwU1Kd4=;
        b=IZ1OKDk+VfsxUUKK684UtQSpWUpSSdu/W8dkrQKUQZwamqyTUHOeTyEsyiOOzBATmP
         WyzkWw7ft2Xpx4GM0/F7FneFgp99EjpCQH+dTPs3q9mXEFbgnHUQE5QVUOMmDWcPhMsP
         xOJfeQrvugoZqLLxUNdqtVpk7Y88T46Yacqav3zMS/lY1pW1324aoMgWdccADwdrFTUH
         CBLdSQguXaggDwYYWeSaV6begIQME0l8k2D3/uVh3yqn8e+bKkLbPDLaDCbMm8iLAU8Z
         /oHHXgLVo5TI3AJtAY97xkqtTMm6GrxDjjfNE0BmGctKMRnAns/q53CroEd3XoNj+aPm
         DQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268591; x=1718873391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9zjtO9AtabnLNuJxqiPcWb5sV8xQYdL18OmBwU1Kd4=;
        b=MZRFh7PRejw3OQ2M4H/X6TTa8GzraUwuqC9UkXRHr9yE28yp1SSM4ylx2rFkToPN1f
         bfN943UT3oawxaeDBRyX2vM8r5QiyUbIpKelCwf+qLoe1Z5YEQvqb4qJpUzZvNkqCSDf
         j1Zo4DxahoqHPVkCL7Ejr1112BtWmkIFCIOC9XnLpi0FU+vjh+J/rO9p1PmTBiEESS3U
         5QjZA01y+Kwp4RLCX+6EI3+RwANhgixsW8Wq3uJYxxSRFY7ajjUrh9gPyj+dPsv+lJ+X
         WyDVlbUIVPfl4fw+hWjuIseku02v9pk/f55O0wtAaBPR+txaqdq48xPOs3/xo1114VBP
         VVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXviV32eccYdKuyDUJ5fMEQ5lnjjjNy9ySYZsnPi2UXP+W0mMRwEOahtrGzEijsEXaMeNfwmLKtqzX+WyjyNe0i0BiOyIMl/GLeHlC9
X-Gm-Message-State: AOJu0YyC6xtS11L1VQtC2LR0o1PyP4Cdpah05UV9PzIuUNMcMXKjSUli
	YDxiU0OA/n5sERVeEzlgKFhZU/Ji4OVUm9AJa93J7zkBHXLs9zXf9arP38H0pggj/H9duXADE4i
	aYQm8QjwwTWl+3wCpJbgBoRygcI8=
X-Google-Smtp-Source: AGHT+IHwOYreymC1B9TPFN1wj6YCfUaTdYq1QGaY2/vdQUfMOFyZMPCj764A6qrN+sEltGa36FWWwsci3aEnDocO0C4=
X-Received: by 2002:a50:8e48:0:b0:57c:610a:6e7f with SMTP id
 4fb4d7f45d1cf-57ca9750ac8mr2586590a12.11.1718268591200; Thu, 13 Jun 2024
 01:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610120209.66311-1-ioworker0@gmail.com> <20240610120209.66311-2-ioworker0@gmail.com>
 <CAGsJ_4y4sKXbq4_ra9tTD-LWgB-x-HECyouxm_9r_N7Kw2We4g@mail.gmail.com> <be85ddcc-88ee-4f8d-9f73-b388f4d47b71@redhat.com>
In-Reply-To: <be85ddcc-88ee-4f8d-9f73-b388f4d47b71@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 13 Jun 2024 16:49:39 +0800
Message-ID: <CAK1f24kWHWL=nT2uDp=GF6dLp9AYuEVr4=ipUsWGK=cf9Qbfbg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mm/rmap: remove duplicated exit code in pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	sj@kernel.org, baolin.wang@linux.alibaba.com, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, mhocko@suse.com, fengwei.yin@intel.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:27=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.06.24 09:52, Barry Song wrote:
> > On Tue, Jun 11, 2024 at 12:02=E2=80=AFAM Lance Yang <ioworker0@gmail.co=
m> wrote:
> >>
> >> Introduce the labels walk_done and walk_done_err as exit points to
> >> eliminate duplicated exit code in the pagewalk loop.
> >>
> >> Reviewed-by: Zi Yan <ziy@nvidia.com>
> >> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >

Hi Barry and David,

Thanks for taking time to review!

> > I don't think "return false" necessarily indicates an error, so
> > "walk_done_err" doesn't seem like an appropriate name.
> > However, this is a minor issue.
>
> Agreed. As we only have a single walk_done user, should we instead
> remove "walk_done", keep the "page_vma_mapped_walk_done" for that single
> user, and rename "walk_done_err" to "abort_walk" ?

Yeah, I agree that 'abort_walk' is better than 'walk_done_err', and let's
keep 'page_vma_mapped_walk_done' for that single user ;)

Thanks again for the suggestions!
Lance

>
>
> --
> Cheers,
>
> David / dhildenb
>

