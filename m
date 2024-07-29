Return-Path: <linux-kernel+bounces-265107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044493ECB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2420A2819C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240481219;
	Mon, 29 Jul 2024 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6nF5bZJ"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C678C8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228415; cv=none; b=usmn62h5/+gQaSiRlCK+qLLPXAFFBz3WjIxWaIikAc6hkAH3IJSes+WVmrT1/tbRq+7DVlCnt+TDJhv7ki8NBs5NSx/NUWfmPSw9yN3QqSHNepm1ykS5QJEjlApdQ/z6FcsiLWWtRrTPuGynq2qtC9jynKmwNEgee3bJ2GoCY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228415; c=relaxed/simple;
	bh=sVXnjAxmRkfGoBkGn/gPFJEr4afsmYREEfHn9CEzdk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/5KAPSGqOmPIy6P0jQ3xJ9Jm8yHdP4f34v7RPf0U8a0vTRCWqb1eArgVyX5m0yYIMrJsjO5levsTJPHYsrvHZ4RIzQCFYcV1x/bzoOY5RfwPfr6TvPug4LLLWvsDS4EHF1UCGdaHPS7sR1DD63uBkZJbp+DSpE4RCq6fiz3Ie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6nF5bZJ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-49297ff2594so475742137.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722228413; x=1722833213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIfrxqdGjofysDt2XnlAf0w5onRMNtZvYCQKUGP2fbU=;
        b=L6nF5bZJH/Or+rwaHqrnsNtonEAFF8cwaO6Zg3ECZTshj4MKVuFOUuReDdYJ9JLmmD
         FhF8S8N/cJFug5pZePwO1PHsHs+d9H5RWxQ9AEJP/PsvWi/H9BhOYiIT6rayem1GeKy7
         BQqmIdEIjKZ1DVFUI+wp5+i6KnOaO6ivK0nE1XB08Ioyygbrz8Yzu/jzZg2DU9Ol1g2S
         XFDSZnzH17rR0WWOBNYNOKZ2A5EfKlcpuBNtJyIvKrJw1RIjvP+1AvJ0j0hiipDkYIEk
         nlnnIaSb4kGfdHFkVEwv4oWs/5WEV330xJqxHwKDER/WhRCC9Jdn6Xco0qiYwpifFnC2
         ng0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722228413; x=1722833213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIfrxqdGjofysDt2XnlAf0w5onRMNtZvYCQKUGP2fbU=;
        b=iBKDO3aNNOW3G++uTovepjhLSzZoft88qXEDcb4hsdeJCSrDBvKCBupQOLFCdo+1P7
         gz0Dayymls5fjsDaIIuCEZ/ZY755Q6srzf3nusSlgbyhCFHH3q6y4L2l0gGTNfby/vw4
         4l7l1oiGGxPkLeBtfQIk8VESRqFReXkt9kfYw5SYZjZsfkhRM2wyXcdhFuOnyNPiGMRm
         NfpYAe6rlgTZ8uXuMD4jLq+4vLnokxzkOqovkwLAXw0GEjQjRkpeI7b7qEX+70xVfW6F
         /B2BRBMoNHubbvwSW+4OZ6SZu/g+0WadHhhg3jhkLGV4DB4/XOzR4hHD1HoY79g5icS9
         hhng==
X-Forwarded-Encrypted: i=1; AJvYcCWY85VeG1Md/Ahlz3lHMrbVF29LudzgBobNJD12QedrVJJ9XwgQxD6zihgfddLqfHy23fqhktpCKLUkzMYhM5EibRH6e6ri6J5hktAO
X-Gm-Message-State: AOJu0YxoPaWYPZf9TSmKAbDMFv2P9yM0I+r2SEeABsdmg9xS7A7KSXSL
	tS7qQ5eZKM34RgOo+s6/GNdA6PMjY915IS+NV2KzYFcl/KUdjjApAJWmVO+tMJlNosAhkGewWZ/
	7vRiVMUxwDI8d3msKCMYtCnltfYg=
X-Google-Smtp-Source: AGHT+IF1UvHKFXDeCU8sPTVdZGXnNX/70vz5xwO6TIoFEz+xxy1Cb8FNJaku230OaiJqvTadGEMuqBrbRrjZeLpAC+Q=
X-Received: by 2002:a05:6102:3ec2:b0:493:b2b4:3708 with SMTP id
 ada2fe7eead31-493fad54e1fmr6672772137.27.1722228412696; Sun, 28 Jul 2024
 21:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org> <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
In-Reply-To: <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Jul 2024 16:46:42 +1200
Message-ID: <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:41=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Jul 29, 2024 at 3:51=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> > > -                     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE,=
 0,
> > > -                                             vma, vmf->address, fals=
e);
> > > +                     folio =3D alloc_swap_folio(vmf);
> > >                       page =3D &folio->page;
> >
> > This is no longer correct.  You need to set 'page' to the precise page
> > that is being faulted rather than the first page of the folio.  It was
> > fine before because it always allocated a single-page folio, but now it
> > must use folio_page() or folio_file_page() (whichever has the correct
> > semantics for you).
> >
> > Also you need to fix your test suite to notice this bug.  I suggest
> > doing that first so that you know whether you've got the calculation
> > correct.
>
> I don't understand why the code is designed in the way the page
> is the first page of this folio. Otherwise, we need lots of changes
> later while mapping the folio in ptes and rmap.

For both accessing large folios in the swapcache and allocating
new large folios, the page points to the first page of the folio. we
are mapping the whole folio not the specific page.

for swapcache cases, you can find the same thing here,

        if (folio_test_large(folio) && folio_test_swapcache(folio)) {
                ...
                entry =3D folio->swap;
                page =3D &folio->page;
        }

Thanks
Barry

