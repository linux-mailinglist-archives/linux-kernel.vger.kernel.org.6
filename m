Return-Path: <linux-kernel+bounces-376076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDEA9A9FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA575283D16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79219993C;
	Tue, 22 Oct 2024 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEOF1kZw"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368C145B24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591850; cv=none; b=GgiWZdde91I8g+KK73LD93rPcpVz+sNrFtGqCLZVQGBKGXhpl8j95f347X08lHaePmFEGAsxNyAs2TqdupLgOZwRjJeXB2EvuQuB/bIWLunFj9fXIZWvHQBw6V9UlV8jCFE8cJbu2XH/UfwqgQ2arEwoBBxzO1T1mgUNJ5A+P4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591850; c=relaxed/simple;
	bh=l02kqcQ9cL+j9dk7KMW/HwsByexeA6HHNyuuj1uQZKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZQMEahZYP4v9NEBTvOmq4B3sOLZhmhOuTcM9B9rqdaITkwR2EPpersh2KEh24Ne6kCTrmiVq1GdiGeLkQDuYAJCYScivao+GvK5EL3ziyOvlqWFRH68XT53ed/No+1ON4M2KOQgWBgATzv1vRxZeK/pnfhpRPasDNK2TwTboq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEOF1kZw; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9aa8895facso151285266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729591847; x=1730196647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0XkPZgcEMW+/3AwEKfGZ5bDzJZW7q1GrcVHCJ7Qg2I=;
        b=cEOF1kZwvMwh3mfZlzYXKsrgEnTolU72+HMF/aTD3VfKEQeNqHXAFAh/C5hq/YSFVH
         Lrgo1NBkQgpF1VRETbq3SfzmcirynOUtmG1RnWoaVcbsJgwQLLSJmnZ6rovHHvHTgz+L
         bRHE1aHKc2FBRc/xxzfaCkjPDGd2U1Yq1FNAoohNKf/0n8jWzSwEeKVag3vvB/GHJvhz
         FZ6PrIFuAoxdbtLLP1yX/p8voFwTua+brcVEBsVOszA1K2PkWHvtBJTkGAX075BMUy42
         kYpmgworixiCAo7oS2wXOj8tWmS+JSvzg2vlF72CJBVNcsF52NGC2qq+/EeHJwvf9F1t
         iuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591847; x=1730196647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0XkPZgcEMW+/3AwEKfGZ5bDzJZW7q1GrcVHCJ7Qg2I=;
        b=sdLlCfTZ2Gjea7B3dl2WH4TYNOwabL/tL7E172/Q2LETijhPMxdPKo5G8hgVOFMVZR
         ny41JtXpkhA/hLIZ3HEIWj1QIJZDH6uw3CRjcGBj2blub/d/bYIA71ys5WqN5upeasnU
         cJYufWAW5H0551Lrj1+QkZudTZo63cjdj2NYNhmrSdiIlTo6DZRADdWuv+s962pkOA5i
         gUqRGF1lW4tTl2+5iYdRKH7zzsVQOBbtbPELyt36xYDfrwH87n/vBCrXHfLWZ9ErVz9b
         bWQcbVMZq3PbelTs5GazZKiFIfAG67RN2ncjMqmz4KJpFdA8Z+YH6kNOxzSuIGSm1tZi
         fJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWtqFqBJK24KENue5Ig7GxmInxqyY/U7CLqGeCemyHY9xarZCSHA4wbc7YRpPBHf1+fBPjuCtX8S6B5ulI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4y0gc7SYYGPuzhO60ekoqLtIMFknYJk37nsVHxA8AgEcmyTZ7
	p28ASy4MnR8gM6WcVNTsGR3Bf/ovgMwEPeHxoYQGZ+kmgj+hHAXohIWf3Fl4pt3PppaiibMXIHq
	dJEMOyUaAQk/DjmrUvkbNYd245cI=
X-Google-Smtp-Source: AGHT+IGIyEihK3Mtb6v1K+Ax6jxg45G93wVNM1WGGsQR9w5ebdeLcl4zRT/OUGIBMg64f6YeDuNlwSSvzJfeIYDlJEA=
X-Received: by 2002:a17:907:7f15:b0:a99:43e5:ac37 with SMTP id
 a640c23a62f3a-a9a69a73b51mr1529901766b.15.1729591846813; Tue, 22 Oct 2024
 03:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022074035.139897-1-andrea.righi@linux.dev>
In-Reply-To: <20241022074035.139897-1-andrea.righi@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 12:10:10 +0200
Message-ID: <CAP01T76UiJAPVM1-KaiYyJLgDt37brdDUCT=NLOUxCuG850W-w@mail.gmail.com>
Subject: Re: [PATCH for-6.12-fixes] sched_ext: fix fmt__str variables in kfuncs
To: Andrea Righi <andrea.righi@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 at 09:40, Andrea Righi <andrea.righi@linux.dev> wrote:
>
> Commit 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in
> kfuncs") renamed some parameters without updating the body of the
> functions, triggering build errors like this:
>
> kernel/sched/ext.c:6881:45: error: =E2=80=98fmt=E2=80=99 undeclared (firs=
t use in this function)
> 6881 |       if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >=
=3D 0)
>      |                                             ^~~
>
> Fix by renaming also the varibles in the affected kfuncs.
>
> Fixes: 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in kf=
uncs")
> Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
> ---

Ah, thanks, this is embarrassing.
I didn't realize sched-ext was disabled in the .config when testing
this with other patches in the queue.
Sorry about that.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

