Return-Path: <linux-kernel+bounces-531197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F51A43D52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF89164569
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A652676F2;
	Tue, 25 Feb 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfKFlxNW"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE331684AE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482448; cv=none; b=OBR+QTBkCK2MJYUWcikJFDMgFHQ1WX2omp1VOpPkSKM3QsLlCw/pcpRro8CT+wv3o1/h4YUZVDv349vKsfvBr+eyXDEx6332uns4vqzqpCU2Gt1NH0IUp7Fhx7x3QrGYwqo8vBJs4mfyFjXq8Fl6KWxbG+whmnMBU0WE42DiVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482448; c=relaxed/simple;
	bh=ZfKFZZC2tmOCbwC1r8CVgXiCVrT0QAUCI8q2gJHsnIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV4oBfd9uLMNJRsrJ+ERkTUl+3NIw8E1GI4FyrqDFatwNS7HJ9P8WUTsdX5U+HJVMOkHcC8/L8BFJva/7ZZcXnGZm0PzHBOdybUt19TuKB8rgiIL8R62UHmXWU4iBejpeafjccc/vzJ5LYKYnF4r4fnHoKFua1HfcHFGkQgNneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfKFlxNW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471fbfe8b89so320321cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740482445; x=1741087245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfKFZZC2tmOCbwC1r8CVgXiCVrT0QAUCI8q2gJHsnIA=;
        b=JfKFlxNWjlq5clU5vEd271dAFSLau7gSI034IwmlfLGdq1M0x7gxKZ8Aot3SH+AhhL
         TRibXLmsVnGxfZZwzvhAegPDvsi/Bg4CubdmdVqn9ZmqL7z6daA+W9h+sevcf7ZTFP7o
         FOaHJdVvEBs3rT+IAfpZKgRHyLQk3Rul6KPvCW7dSUieEQt4IF9/iic23awvsCmOXzz7
         kqMSu2JEaTNYo5bGd2pxS3BgmgYO4w5p3COEURgYEzJ158/TzuJORw9U55SWhHpeyyMc
         H16rvDuc6bXW07vKk9YAoBqcjGVqttjZnIyLOs08JkV71K/hVFotIrIY32+cT1o1dqJ8
         HXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482445; x=1741087245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfKFZZC2tmOCbwC1r8CVgXiCVrT0QAUCI8q2gJHsnIA=;
        b=GW05Ji9ti+ASzOR+pOB9LBYfCHCSjJ/WBJ20yXPwvlQIhy89UT1pw2gVE7HcBzGFLJ
         ChleUZ6ajGjpUFNmQVCNVqRO6nAHUo5W8LAbAqICanbMlO9P1XxsVFW3Weau5FHK/32U
         Zjf/wpljuoS17eLN7Cl5urwvu9iOoQFREImX1SWAc72ewVxiP5xr6zIE4rkf8wYjTY7w
         dSEVLakjaiZNHcQvMMIg+grF3oxERpx2VbBO4yXoJ+54pRnrWrWncjVO/N5nw9xpDs3l
         NitK7NXhZXbY+PbiT9ehon+5X2yIzYt+C/4STgnayyLKhR5eByEH4pinhutQHmPFn7DM
         mUSw==
X-Forwarded-Encrypted: i=1; AJvYcCU5zVxR4N8bLRCkagx92MK5qJZXfcKdhWok8KbQkUNKHZ2XoMxd5ryMVaCUZdUeZvoYaOHNbG8jA4Bmpe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9qK+XvDfI7fMgPeH9NHKMPQTFO4CnsNkx5hkqJ0Xz6UXDlhP
	j8rtoSUDX6vm/7f9X0Q3Wwx7etki31fvJipHrSusRaR12UqOAUkyqfnWJwGbbLfI2iEEizh0avx
	7FPEoZ484LxeRex0qqm9IZLn23p/VvMa+PrpY
X-Gm-Gg: ASbGncuRb1EAPuOFWIRBlucF8IEPqOBEjnh+XnPBWFhLE5TobA80nQLGEdpqS5mWiTf
	670WYya7DDcBL+eU4y7LcM6f/M32Zkz5GcdUd2gq4bATO+BePK14eAbLV1WXQKknc/Ao1Qd5ZYs
	Lt2RfzfovIGDFBOrowEj9nKMKpCuF68tiyGRayOA==
X-Google-Smtp-Source: AGHT+IHFjJ0yKRObJdxsUgiD7JtmY8937g0CLtK//OiCCtPNNX1uIrk24753sc2sHUgmgRxIlWeBRTGfby6XhQp16yk=
X-Received: by 2002:ac8:7d12:0:b0:471:f2dd:4184 with SMTP id
 d75a77b69052e-47376e80f47mr4296161cf.11.1740482445292; Tue, 25 Feb 2025
 03:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <20250224-page-alloc-kunit-v1-3-d337bb440889@google.com> <Z7y7ltOSDjamYmhP@google.com>
In-Reply-To: <Z7y7ltOSDjamYmhP@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 25 Feb 2025 12:20:34 +0100
X-Gm-Features: AQ5f1JqLPRqnWEZHqnvgC9tC15jeAnKsKuFlQFRcyxCvqPiNNGA6fSRNHtlD5as
Message-ID: <CA+i-1C31w5yjVRBLNr9b2WwghP_=Wv0+SymWKOQtG8SEszKxxA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] mm/page_alloc_test: Add logic to isolate a node
 for testing
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 19:34, Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> > +#ifdef CONFIG_KUNIT
>
> Why not CONFIG_PAGE_ALLOC_KUNIT_TEST?

VISIBLE_IF_KUNIT is paired with #ifdef CONFIG_KUNIT elsewhere (I think
there might even be docs that do this in an example) so I just
followed the pattern.

#ifdef CONFIG_KUNIT -> things are consistent and you just don't have
to think about this very much.

#ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST -> better scoping.

So yeah, shrug. Maybe David/Rae/Brendan has an opinion.

