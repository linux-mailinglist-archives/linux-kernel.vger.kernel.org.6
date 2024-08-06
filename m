Return-Path: <linux-kernel+bounces-275576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344A948764
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3230C1C22216
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF2DF42;
	Tue,  6 Aug 2024 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Am8D4qac"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B8DF5C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910646; cv=none; b=oNvSUvQyWEmdQf90PVObezFVeLlsAzdpmBsV7oDwSaABqoxu8LPCqJWWldF0kaIg4hEi55g/6K6sV4DG742xNqFZkyfVs8WIQYvf5DXNVSNVOeg7HUlSy8tmdf+XrK0KNhYrzAtiLPJzFIyDbWsXAXep5WXF98G9HnVAL4Tnw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910646; c=relaxed/simple;
	bh=1kbFbn/hAUhXKnkcqsPGGdbcnRxGgzs3MwJiZATRWDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orZaHDIkbGFugY9rQmUItVwscApPNDtVozWQYvyj2prwlLy2MDj+dghFOhWsJPBnvaidjDv/M4MZu3xrpEM9ubUxiV4bP4HJ3YRDuqmMpGwiEjhNAbiif/aAxKu7BNGG2gW/1IDEsnoEXtXt3Uwjd+K/qz+XQYJ5vcN1RIgphbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Am8D4qac; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efbc57456so106501e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722910642; x=1723515442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwq5AxSs3t0w/fOZRG6eJ0P9hFWvane6MBazV/wxmCg=;
        b=Am8D4qacjeW9OrAKHivXQNmZMPg1xWa3COmbUhBur1GxBq0VDquvIk9ARMf9OK1X6m
         nemA6pxm+CxjRJosPHqj6qZ0/mHsubx3PaOR3OsclSZjC1Xr70FqaB/IZCP3QKIbPbUq
         rOdvDFcr/pTuV1sH0AhnHDCmHvrHhRBA8i7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910642; x=1723515442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dwq5AxSs3t0w/fOZRG6eJ0P9hFWvane6MBazV/wxmCg=;
        b=YgB5dyoHXmY2myVXkiijZ46DoPgLLLDJfwnkJ/jSe5pBbvCph/RUCrrqJVYCaPisGD
         Snsq8ftN12a1TMq3x4TiaHXK74H8GM78yUPqWUqq8luhRL2yXTLqA+mL2E2y/qRjoj1N
         9I3DWjvRtwfKUzQD8UfnQGg2jEGUOnSEIW35KRY6GY28DMsudRUpyzwXut+QftaxxN9P
         tYI8/8CVFFWRL6O68Y9d8qt4L0kaGP2ZeuVsfZ3tCA03f5mnl79Zp8T9RdZjMHDc6X00
         L84KlO9wVeqmdbLzSpp/3Azyvd23i5K0pwd5RIuYIX69uvprCyrMqYGUeHBsCJ4kFlft
         Jw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp7hLg3oMpOK7H3ijJq40iLak8oC95B34FndLhuzsEbzl6r2nWkdmcd6fwa1rKepTq+xWBVpooRnnJdio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKh+1xGJM5mxRuhlMgrNtBZXjY71iDhBI4dVPKi4vt1Snl2dcB
	HuJyPmWZFPYIKQYF8pnqDgVYJGaQyl6iVwRC0JEX0M63Le2GAHMtywXlD/51UsM8/427bPLhxR5
	jE4+YpQ==
X-Google-Smtp-Source: AGHT+IHBgUMZFfDI/gEKKYZ8P+GfoLiBk3/7QSw+F72ZGUHonmeFw0jwggDkFUizWTZvMiysOCd27w==
X-Received: by 2002:a05:6512:b21:b0:52c:d76a:867f with SMTP id 2adb3069b0e04-530bb3041acmr8488012e87.0.1722910641861;
        Mon, 05 Aug 2024 19:17:21 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9dabsm504603866b.39.2024.08.05.19.17.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 19:17:21 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso128947a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:17:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk266YiF028glFct3wi7Yfo/mbRZ8IOJffz5KnIo43JdITeWVUOF90xSEw2nsMUi+4W1ujxRV/Z/PX/a4=@vger.kernel.org
X-Received: by 2002:a05:6402:a42:b0:5a2:cc1c:4cf0 with SMTP id
 4fb4d7f45d1cf-5b7f36f59ffmr9300778a12.7.1722910641236; Mon, 05 Aug 2024
 19:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com> <87o766iehy.fsf@mail.lhotse>
In-Reply-To: <87o766iehy.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 19:17:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
Message-ID: <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeff Xu <jeffxu@google.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 19:14, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Needs a slight tweak to compile, vvar_close() needs to return void.

Ack, shows just how untested it was.

> And should probably be renamed vdso_close().

.. and that was due to the initial confusion that I then fixed, but
didn't fix the naming.

So yes, those fixes look ObviouslyCorrect(tm).

           Linus

