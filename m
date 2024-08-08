Return-Path: <linux-kernel+bounces-279739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B34E94C111
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D121F29B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904A18FC8B;
	Thu,  8 Aug 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fnci0RKG"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BC18C355
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130657; cv=none; b=FhwoKRKn4ETIqrDSazupCEc26EKflHlZChRcUciqPDZIfrDlCMW3HM/qJXaC02ej2dsk2hbkc4ZBD9YUFTT2/0QK0mwvs3+JaaHgICXLWNnNEJGQQEvMcZW3d35KGeyWRMMstcFpKSZsZwQHpfVGcoUsf1fBdij7me8hzma7AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130657; c=relaxed/simple;
	bh=kcznI73703eU0ObOZKtq7iR/3T9lbNSBrSC3WrZaDn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n36/YMUGLv5oFsBnyeYeESr0Hgd90NLCBT82eI+tRTVtKONynNLCBQolOx1a8ha982KkyT3zMqp//EethWzJ7GtjXjcEKb+zKx5vi/GC9WHXmiMo/E0bJPUHVQ0ZR5jR7Gfds4yqFFeYKeuYsKkw0HGKbxTYz9Fa9xN2JnEyCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fnci0RKG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efbb55d24so1967787e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723130649; x=1723735449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx18uaar07tjK8QW0faH95Ubd3Yujuqs2CBIHWPUeWs=;
        b=fnci0RKG/4fjljLluLOX3a37meRVr+Pa6VipVb/V+o0z42yfmINbUAMpdb7iqYXczy
         YIW3lMoRG96uNKbi9PJFcO5fNu3RsXCvSoKSE5Gm/4eh8+0Hvdn4PBBGm+RlOqcq+W+K
         cu0mV8R8wlVcoayIwVJMjXHl2XQQh+xxnsJ7JuQlSSxgHUUbzPdc0A5pagC4G+zsIsmy
         yKU8JCEI+udgrnnbv5jGe3ZbFbh2FVGuydewhSe6wn8+bhdP6k/3c0CmcNibT53/8hu+
         a8qydugzMe84EsvJBmM77YNoTjtW/R44eqRyHgTKh4/uCbbLLdHGI46V03sWES+hng8g
         UH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130649; x=1723735449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx18uaar07tjK8QW0faH95Ubd3Yujuqs2CBIHWPUeWs=;
        b=TU2EyVEypjBZvcjuLY/ZzNc+IbWTgSx3ADivVK4ft/62IumBZaYgFPlDIHm4mU8Iaf
         Xu55tXWzc/kvS8x+hTdXUW8O3pWYZKQb7kx/OmdV5gyQRiw5rsjK92U99lY1afANR9+d
         xuYIrTpGNuHBspNm0r5f2p4ECgrDRAfvvio+0/56oJUcIksgIYYCf6p9D0k4bPH7QUyF
         CLbteNZj2gX50arntj8O8NZzlPDhWD0UhUrtpxnKPX+eObOe/gxW9nIB4djD2b1oaWkA
         9PaFR+NDiMn/dgdN58rjAJQsAtf2bk30NFZo3cyt1paHHG/rFikGxuD1Tccdp+ORG9tG
         ehlA==
X-Forwarded-Encrypted: i=1; AJvYcCV7OAOsJ6tqjKRmXvfg/w/Zkuf+xW1iOzSCa9h0+ckSVntuVcF4ucVMrcMzKoSd+Ax11pDSpwvNsp9tisi+wMLLlfKRw/8xjhApUeY9
X-Gm-Message-State: AOJu0Yw0OeAmESRPvOuEahpd8CsFAPTor60HbI35gLhqKrdawYcxvgXb
	gVCIkkEoIhpY6Nv1K0W+2HiXkd06pKQe2lDIz+xeq5Flxwfyge78oiUFU03Eu+xkCbzk3+JL3PT
	Ciav8okAMTgf+oCPFWoJjEOPkYgkGwfBfsVELnPFyGY7MAkLmsC4=
X-Google-Smtp-Source: AGHT+IHQfJk4XwPcOfo9+O99r2JxIMlQxBCThMQWtoh/L0V+CtPk6/Rgp2Ne++2MFrhPmJRgmXKE8nv3eif8DzEPJUA=
X-Received: by 2002:a05:6512:1107:b0:52c:c9e4:3291 with SMTP id
 2adb3069b0e04-530e589929fmr1646154e87.60.1723130648939; Thu, 08 Aug 2024
 08:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com> <66b3fc8d39391_2657d52945e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66b3fc8d39391_2657d52945e@dwillia2-xfh.jf.intel.com.notmuch>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 11:23:30 -0400
Message-ID: <CA+CK2bCrXqnGPvQP86FpFFfEiCpBSyq_DzdP1deyK8vQ_ZYjzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fixes for memmap accounting
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cerasuolodomenico@gmail.com, hannes@cmpxchg.org, 
	j.granados@samsung.com, lizhijian@fujitsu.com, muchun.song@linux.dev, 
	nphamcs@gmail.com, rientjes@google.com, rppt@kernel.org, 
	souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:00=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> [ add linux-cxl ]
>
> Pasha Tatashin wrote:
> > Memmap accounting provides us with observability of how much memory is
> > used for per-page metadata: i.e. "struct page"'s and "struct page_ext".
> > It also provides with information of how much was allocated using
> > boot allocator (i.e. not part of MemTotal), and how much was allocated
> > using buddy allocated (i.e. part of MemTotal).
> >
> > This small series fixes a few problems that were discovered with the
> > original patch.
> >
> > v1: https://lore.kernel.org/all/20240806221454.1971755-1-pasha.tatashin=
@soleen.com
> > Changes:
> >       - Added patch "mm: don't account memmap on failure"
> >       - Changed from using nid in hot-remove functions to non-pernode
> >         system-wide accounting for memmap data.
> >
> > Pasha Tatashin (3):
> >   mm: update the memmap stat before page is freed
> >   mm: don't account memmap on failure
> >   mm: don't account memmap per node
>
> Hi Pasha,
>
> Thanks for jumping on this debug!
>
> We almost missed these. Can you update your scripts to auto-cc folks on t=
he
> Reported-by line, and optionally include the lists where the report origi=
nated
> next time?

Thank  you, I will add them.

>
> This is looking good from my tests, you can add:
>
> Tested-by: Dan Williams <dan.j.williams@intel.com>

Thank you for testing

>
> ...but I still want to take a look at some of the implementation choices.

I am about to send v3.

Pasha

