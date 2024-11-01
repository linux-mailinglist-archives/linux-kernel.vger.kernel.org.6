Return-Path: <linux-kernel+bounces-392907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4F9B9984
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510241C216B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AD1E25E7;
	Fri,  1 Nov 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbV37bSQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE691E2313
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493288; cv=none; b=QHgwnxq500gTZ9GfTiLWxLxNg5gcsdIV2S+SmIG5EQF/pVkrnZLTUm0/QJmyOpM20/75kbepEwiEK4rnCH8LQnG47LCw4oxIFKp5JWHpCEaNfPrX+QC9/qCgzoShfOd3uMRdNRSUopk6bHPKzKua1Fn9nL9JMiyndFqdUgtKYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493288; c=relaxed/simple;
	bh=JGIKGLosAwaInaFR/dbZOVxT/qUwBnIv05j7Oofz3dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+h7NOhcauE9Yd9A1QETX3C4IEeQgK3FY0p41R9d5LBdfC04VueFUftnmo1mrxIM/L3e5tbyARK1kcucuo61rrvETVgsZfTEoHwNWCrUcGBxa98WGzMpB9LnyoaL2M4LKIM1QNBsEsbbtHpSry6m+hgogemZo5Hc2WmSnbfFw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbV37bSQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e617ef81so1275e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730493285; x=1731098085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGIKGLosAwaInaFR/dbZOVxT/qUwBnIv05j7Oofz3dM=;
        b=hbV37bSQhnYD+J/AL3xQnhTidhuOE753wZZHsPMhQWpxBEgn3gV30VTzzQl53R8xcq
         Zb7pVFQHyXfqS2PTzm7q0uFZPV2ox2p5zii5/8KjFBO16+85a5RidfsCrjPdIJbJOiWk
         zOdQVCVSGVzLBZZro0Gsbqzf6JZW0PLlaKXYjGN1axCDewi7Nwk6vwdBQ4elCkGFACUg
         FOHwXljzLdBcXr+ACzNgxYRXEN3xCdrrgm9eSVxa/daDHj6HiYS6sa4WCPmgwNvzX0Gz
         eftcQfWwlOWWRl+SDk2Lt9t2iXxtIXczOttzskTRsfsSPksvHPlLILZ9qB/FOhYMMy1j
         qI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730493285; x=1731098085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGIKGLosAwaInaFR/dbZOVxT/qUwBnIv05j7Oofz3dM=;
        b=vW4YhZ2VzgN4jOkaCTFCJH7Z1UylRZjCwHV6PsvIx8YVhuPzQpwZToUsORnofpDbfU
         lsNeKco5HWRTW+aS0bE+n221g8kyyhvlYp/SoDn4YQ17XiCw6Qh9C2NynnlAs+AJsW8U
         uEncJyFTZw64LZWY1bR++tJX2IxkeKmBa24TTNtL/JKnIJmu2LmMHIXFc0Tsp3D61+Df
         UEpcTATGwSIfawBuFAfhPdmS8glIT2gndgtYrNTAhbkVN060Iie4+kj9ZPHaanAXr885
         HsKRkuQfb4513HunIafcpcTbrCpIMCALCx6Hjl2WyYNvBkKD/OktorqX9/9h3+ghaU+V
         dlXw==
X-Forwarded-Encrypted: i=1; AJvYcCUwk1Jz9Z1OYTftyLmU/h4/N4V84CVPOjHtwFDfraR4FIKJGQfgj5h64q2rzIy9aWLcANow6ys7DdlPCNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVlRluZ9Rurvt+P+hj0bp2Vj6Z0g9qsVYON2SVYyo80nnp8Wf
	8YrXgbsVsVVAOFK0+khu4pXsepKgiHGtFw1WP0SX7IUFdNBXQpiZRLYrhQRSm7BD4WFZ3BayOXw
	miiS7AxdrRncE7J24YwfJsm6CYay3u1QI8b2A
X-Gm-Gg: ASbGncvVMYpfVSnylhG4JCYG/zLXVLCOh5R6MncKaBOs3LXkZfmJKbCw+A6oJjEI5LM
	EDc65nDTf6ZVZgd/X21NfcQnLmZAeuDyxzJ93YGnVDosdltNN6filGKty9ZJX
X-Google-Smtp-Source: AGHT+IHleSpzUKqJpIQL1LrNUhvfc142T9+XqdGHrdAhF6QcicNe3I5wzlOtm+Kk9zqaztwqVj/nx8LtNAJjTI6lcF8=
X-Received: by 2002:a19:5508:0:b0:530:baaa:ee10 with SMTP id
 2adb3069b0e04-53d6b1abe1cmr9794e87.3.1730493284385; Fri, 01 Nov 2024 13:34:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101184627.131391-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241101184627.131391-1-lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 1 Nov 2024 21:34:06 +0100
Message-ID: <CAG48ez1RvgDWXAt_gGw03EzY5bfh_2C21sBP0bBfhnq7ukv95Q@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unnecessary page_table_lock on stack expansion
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:46=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Ever since commit 8d7071af8907 ("mm: always expand the stack with the mma=
p
> write lock held") we have been expanding the stack with the mmap write lo=
ck
> held.

Right, in the 6.1 LTS tree and newer, the old stack expansion under
mmap read lock is gone.

(A related cleanup that also removed remains of the old stack
expansion mechanism was e4bd84c069f2 ("mm: Always downgrade mmap_lock
if requested").)

Reviewed-by: Jann Horn <jannh@google.com>

