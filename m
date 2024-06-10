Return-Path: <linux-kernel+bounces-207602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7605790198B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C31CB2145E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7EC6FC7;
	Mon, 10 Jun 2024 03:39:42 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF955227
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717990782; cv=none; b=GQMgylIiHy1fugV50FTWai7G7qSgDDY3dwyvnYj0Fa3gv2BzeIsY0p6G5ptiDM0rlk2NvCKg1cRp0bh3bwN0k37UfHOX1W0+zs2VQb2EFURoVqv9RLVNg/fPs6oFcy0MSimNrEIGMVVZhwIICTtUQcj6ilAmS4dl075BPj9z6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717990782; c=relaxed/simple;
	bh=uLR8znoPT3RGcg7y8Ypkrl4gyDME96mhL/mgjBYXiII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlklIosIjAIJtU4H5PBLDHDgpzRGTY8IyocdxoJ/SvrQnGHaoO4qlxAgHLny2yXn31OoiSSnpj3YnW2DDM5zFdLeW389eh5lDiGtuhq70OahfJCO6oKFbOiKADZ+eu6OodxEG48dl76DYJFcePBmqe7bNLp0XkSu3uuTa2zn31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eb01106015so175213639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 20:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717990779; x=1718595579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+eIMfo/S7Cz67YDTeYts3OKQVaj8bHX07uK0ALbnNM=;
        b=MzwTHm8veVL0Ehvp4WyY2m57rn9bS72txQqnvfRZG3zTgdfigbL1E9YRNSGL3sS1u0
         YayTlTRj7wdcSQ0RBlMuMmDRD0Zc9h1HHg4xBmqU+c6Ix3khC84iu7M0+6+f60kz3Oaw
         DGUUz2Y+yWE+1Q+xnQcR7+yJBt+X8w5jWqZfQqMeweCtJZIl7TQyhKOYagMxFmPd5RSj
         4MDJywz6Viqx/Wjec1qRvQjq1F2hMMQkaGH1wI5ZgIJq1YrFU4Pk3vWfukbtym4Ckreq
         KPFdJn9hm6RuYyuEK1KoLU3+ZSYaDyTu7lCEP4gD4/J+EkKCdo845HhYfgf4ZK1oTMLM
         ETlw==
X-Forwarded-Encrypted: i=1; AJvYcCUKdf2GaLgNdGvivW+ax30UZ4+9RQGRet3TbkSr68/IoiNaHt26u3LX02ZdTGzInsSeTeLfZQKPBz+nW42KVFwo98f8bT14oQwIKBy2
X-Gm-Message-State: AOJu0YwyPlmXgAiipCjlrNLwbBxtAyVzn4/tdqmW+p802OEH4fORPfUA
	pZvzu7tndzbpMS4e82w/wCcFo7gYCyEs9aqfF55fThUeL6TrQwhfdpW4xrl6RWY=
X-Google-Smtp-Source: AGHT+IE/VtaLW8stBt2XRnHR3DnHgeg5r9f3IW5yFS7lvtsy/jMndHv8r6+LhF7H3pK8IgcZkA1+gw==
X-Received: by 2002:a05:6602:2b0c:b0:7ea:da27:e59e with SMTP id ca18e2360f4ac-7eb57219317mr993446439f.12.1717990779501;
        Sun, 09 Jun 2024 20:39:39 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7eb6c5ae9b7sm117856339f.40.2024.06.09.20.39.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 20:39:39 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375a3edfc42so2765255ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 20:39:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoaUnnds43S7Tcf+hP0+x4EvK2P3lW5chHpm5pDEbDoy4yjWAntnm8I5Xbws3EmmzvveleGbBItdSizoMghPHlnk4ez6WMEa6+tvub
X-Received: by 2002:a05:6e02:19c9:b0:375:9ff9:7d0d with SMTP id
 e9e14a558f8ab-3759ff98134mr36892835ab.28.1717990779202; Sun, 09 Jun 2024
 20:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608152114.867961-1-lsahn@wewakecorp.com> <20240609140341.14ba3a1c62029771d60059ed@linux-foundation.org>
In-Reply-To: <20240609140341.14ba3a1c62029771d60059ed@linux-foundation.org>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Mon, 10 Jun 2024 12:39:28 +0900
X-Gmail-Original-Message-ID: <CANTT7qjthRWX+7m749mU_CmGUO1UEvY6O9yKsStm165Lz=tqAQ@mail.gmail.com>
Message-ID: <CANTT7qjthRWX+7m749mU_CmGUO1UEvY6O9yKsStm165Lz=tqAQ@mail.gmail.com>
Subject: Re: [PATCH] mm: sparse: clarify a variable name and its value
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 6:03, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Sun,  9 Jun 2024 00:21:14 +0900 Leesoo Ahn <lsahn@ooseel.net> wrote:
>
> > Setting 'limit' variable to 0 might seem like it means "no limit". But
> > in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBLE'
> > enum, which limits the physical address range based on
> > 'memblock.current_limit'. This can be confusing.
>
> Does it?  From my reading, this meaning applies to the range end
> address, in memblock_find_in_range_node()?  If your interpretation is
> correct, this should be documented in the relevant memblock kerneldoc.

IMO, regardless of memblock documentation, it better uses
MEMBLOCK_ALLOC_ACCESSIBLE enum instead of 0 as a value for the variable.

Best regards,
Leesoo

