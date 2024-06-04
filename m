Return-Path: <linux-kernel+bounces-201576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767D38FC03A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E3283E82
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF7D14E2D2;
	Tue,  4 Jun 2024 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efdYZXem"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF014B97A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545251; cv=none; b=uWqQvwx6B+B18OuUx9nmE9hNK1+7NkmwHdZZDFomvEALSONC2/7O7jiD3Z/QrnTDbXm+1oe/TIu95vjYUcz2OiqsIluO7wjsmHgHR+KzJzBQeN8x2p1rY28PG3H1sw+Q7xOYwzO+g54BgfUs9pX+BNnUA2U+Ful47apK5t+hdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545251; c=relaxed/simple;
	bh=6n5yBPEPKuLBc16hNZxPmgwPkIO5nIyaN/aHQt8Cc1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhyQJIxvsLnP9AGZ60WyHOY4yzMKJUNlrjyBbFsQg8oAIpxMzbcE7a4OvjRfKhHYtZqUiPZ7of9UgNj6IhH90rnXXp2tHLZQpTQ3216zhIqXSSNIl1pt3WGNGkHRs1xJqddex/fqExa1xskftNUo8p+BN42CAeq20F8U9hgFq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efdYZXem; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421338c4c3bso16231105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717545248; x=1718150048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n5yBPEPKuLBc16hNZxPmgwPkIO5nIyaN/aHQt8Cc1Q=;
        b=efdYZXemIkdk8AOLMlFaqVnIsBKaHoTov6mSHPDvkDQrg8ZDhY6dlAvZGiszEz14VT
         fzr4I9f++ZUShCelPQzDHUocZgW9L2+ohCBfE0bLxf+MUwI4jmD2NRN4Ajv6f7qUNM+S
         X8Vv8jncIIMWw51JsuBUPLxLh9kOqd1ZhyfoPJ63dlHU8GSSI97BsvNy4WIHFV1q/zXm
         A/Cbl2vuID/F7BFKWlDk1R0hd5o3eWXL3GqUzHqFg6514jynDq9OLzd4dTauMjf7qV+J
         ixtuJu6luuo7uQyrq9hhZy/RpNE1a+Ev795KWK0axVgieJ83IWOhTakJdiwNcUxZvuXI
         HiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717545248; x=1718150048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n5yBPEPKuLBc16hNZxPmgwPkIO5nIyaN/aHQt8Cc1Q=;
        b=rr8yrRlJnNSpL+NaG5l0wWwISpJDSp8qQBCKi7rvo44B9CpqvEUQNYGpHQzXPngv3c
         Vtj5GnYujL/kaiZas82S+fKeGHEK+qBB3/+vgjxG+UTrGTJmGSOSsOxLA+lFVP4GsXZw
         oqVZoNVhnJoZ/rE02inM6mx0aP5XLjElImMPC76ij3okLKv4INFzQgNOWvcese4HSRKX
         BFpB8zK08SCRKVGUpwuzfSQZ/TpUHOD5aOcHU1xziQFEJR4dA0+HdAYjNY7B2oNYm6QP
         za40lHNyva6bc+dRgl15mzLGJW0ZzW0cp5EN7RzdZl8cYW1PT+bCG+j5WuNe11nA7Ibx
         fMgA==
X-Forwarded-Encrypted: i=1; AJvYcCUVwttVowJlt1BhHrZ8MFTnJXZsUIKho32DIDnUdmaXeyd4uHNTRn+Q2llcSaqC5BoGiV/Gi8hmGDIlRFN1taH9b04QNXnNLpqaAyaW
X-Gm-Message-State: AOJu0Yz6kDMy3ZBE/roGaHlwHWcndoSTS/iRToORd2vHDB1YvidXLWwo
	pJoPIZW3AL5dwad/xq8PLMGoZZmGH5z+uY5F10mlnNtNrFSy8kOgWY+ioz3ivCHVuHnLScPo+RV
	buQazRgrn0egTPJs3Vmz9kDDW4VA=
X-Google-Smtp-Source: AGHT+IEFa69ZUCNNBYc+8Bm37HfM1r9rsWHOXTP1G8B6R46/+68QCImeVcPzFFNbacw5tmIOxlJAgbHRWt0rfzbs7Mw=
X-Received: by 2002:a05:600c:3550:b0:41b:fc3a:f1ef with SMTP id
 5b1f17b1804b1-42156339013mr6380615e9.33.1717545248325; Tue, 04 Jun 2024
 16:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
 <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com>
 <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com> <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com> <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
 <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com>
 <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020> <CAHbLzkrOTAaYahG4JYMNrJDhQNZZxW9u+2n71J=v1XYJEVpUdw@mail.gmail.com>
In-Reply-To: <CAHbLzkrOTAaYahG4JYMNrJDhQNZZxW9u+2n71J=v1XYJEVpUdw@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 4 Jun 2024 16:53:56 -0700
Message-ID: <CAHbLzkr16YZ80ES5U4BEWJ+ueL22nDJtgH=eOztdHfy080diPw@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: Oliver Sang <oliver.sang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 9:54=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrote=
:
>
> On Mon, Jun 3, 2024 at 7:02=E2=80=AFAM Oliver Sang <oliver.sang@intel.com=
> wrote:
> >
> > hi, Yang Shi,
> >
> > On Fri, May 31, 2024 at 01:57:06PM -0700, Yang Shi wrote:
> > > Hi Oliver,
> > >
> > > I just came up with a quick patch (just build test) per the discussio=
n
> > > and attached, can you please to give it a try? Once it is verified, I
> > > will refine the patch and submit for review.
> >
> > what's the base of this patch? I tried to apply it upon efa7df3e3b or
> > v6.10-rc2. both failed.
>
> Its base is mm-unstable. The head commit is 8e06d6b9274d ("mm: add
> swappiness=3D arg to memory.reclaim"). Sorry for the confusion, I should
> have mentioned this.

I just figured out a bug in the patch. Anyway, we are going to take a
different approach to fix the issue per the discussion. I already sent
the series to the mailing list. Please refer to
https://lore.kernel.org/linux-mm/20240604234858.948986-1-yang@os.amperecomp=
uting.com/

>
> >
> > >
> > > Thanks,
> > > Yang
> > >
> > > >
> > > > >
> > > > >
> > > > > --
> > > > > Cheers,
> > > > >
> > > > > David / dhildenb
> > > > >
> >
> >

