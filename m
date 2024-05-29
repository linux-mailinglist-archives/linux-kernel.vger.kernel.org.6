Return-Path: <linux-kernel+bounces-193918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB28D340C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA8280A54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4C17A939;
	Wed, 29 May 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dBtKORgY"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22C31A60
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977402; cv=none; b=XVI3rhkwpC5mEKCa5RCSPVI9mVNas01mu1X/UyR6Ubav7b5L+KpyXvxQAjYpuGnfvb68oUQw6mPBkDaDzKjO2T6AEgOlU+FvruGR+pgE0xRKhjO0fgWmDfGd/GSzRVzKG5l5UJMXQDngrZ7+HjTRK64wS75koAYGtv3oBD8G6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977402; c=relaxed/simple;
	bh=D4DxX2Xvz9Ek7Q2MsbuAmRNYh9AIsuYdbjeHdEbVh0s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITY80ilgZEPRdLZilix7jqanGYuV3F7shAEQCK6TDBvRzge6q9a+j3n0Z7135TGcq9rBmQRgdbXjx0ORmoVqP2i1b7ISdfqBDt0re8SwNLSo0hobYf0zkZIxbDWxss+qjxtWaahpIN4GKkPgki2ToKwsRDYuhN4059pGILsZWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dBtKORgY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so3514505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716977398; x=1717582198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FTKNsuia3RWpQHnWn/8QDl0FBPSRwXXETwGl7wxFKo=;
        b=dBtKORgYbGqdlmKFu/1a3LKvnBzwqk068BNTKq4DCLWqxUcKFhY7MvIMsU/NlIH8Rz
         cz4k4Myjg6E/T1+nvFCS4gd3DZKcF3QWCMmE2BfRw4f77KFeyzWbc1g+UReMv2nwBoaZ
         2asmuNOuNCulo4n9mOaKYxqhhFE0yfzwoBafyVqsPaEWj2qHZMrsy833iwN0HxRjofXs
         NDRq1RirQ9iJqB8TnarO40BHVpyz5w24w2xDEIOGdTdYyiIQ8b2OqtnQJwtklE5D6tJT
         OdclknmW1oRkhtRoQS6wurtHaJRRR7kD0P9e6mufy8RibPef1vy8Nq6P4Ii7VI5EZ6Sc
         S6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977398; x=1717582198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FTKNsuia3RWpQHnWn/8QDl0FBPSRwXXETwGl7wxFKo=;
        b=bmk7yzUVsqYjraSrcr4d1cz57KxEBPMgt1g5BOZgVjIaFrTYIHBqHM5x6vNWtJEzud
         O3xtN5NJIMf1DZI/WLN8FzWMcTRO6r+Zet8/7xBkpkBbcqWKvw0BLpm+bqV/Xj01cf8Y
         IEFfNPL2ZPbltOg8IuKvUprqO9xMwJUGoBLWzWD6h2QKmRo2VYAT4ew6Q6II0pPyCgit
         DM/VZYirMQq9X9neuiySsVyGRCWTUzoNjoQlns3oNx0+8kT9iSBsVTyFOsfJbeT7bUVn
         ig1YTPNGndsK76zgfJmPAhkjPXgo9QMuw+pEtfViRFEWIQJAZ7uIVYCDabtqliUHFzau
         FSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa9UpxGIfF9ZwO1Ue/RcFtdEhIAYO6SqhcjKy5SUtBnO0IPDh9tyX8coEEUoCeCWFpJtcI60+73OFBZ9+YaszUTURkb4/38/LQySWm
X-Gm-Message-State: AOJu0Yzu9lNeynAQ+zsxJ0F+AvOtRG/tHoBBEb27s3qPBzOj8TO4B4iA
	K63XW4TLwxwjjP7VOJ0m1prnlscobk4PI/n3uq938ytR7YSJ7e4nrrb+00iB4Kc=
X-Google-Smtp-Source: AGHT+IH9bfmSIStk/91xm8BYd9HX9NO21rvFMlN/xg/x0L9tsKc+sRpjBrjeX+ypNPkNr6P9URfuKg==
X-Received: by 2002:a05:600c:4fd1:b0:41b:d6ca:eefa with SMTP id 5b1f17b1804b1-42122b01e91mr13915835e9.16.1716977398527;
        Wed, 29 May 2024 03:09:58 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42122299300sm26362175e9.42.2024.05.29.03.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:09:58 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 12:09:56 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oscar Salvador <osalvador@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v4 12/16] powerpc/e500: Encode hugepage size in PTE
 bits
Message-ID: <Zlb-9DNmRzIYRdJO@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <10eae3c6815e3aba5f624af92321948e4684c95a.1716815901.git.christophe.leroy@csgroup.eu>
 <Zlbh5Bwsx7WqEEWr@localhost.localdomain>
 <3cf95f5e-cc8b-4417-a3fa-80dc3b24ac63@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf95f5e-cc8b-4417-a3fa-80dc3b24ac63@csgroup.eu>

On Wed, May 29, 2024 at 09:49:48AM +0000, Christophe Leroy wrote:
> Doesn't really matter if it's PUD or PMD at this point. On a 32 bits 
> kernel it will be all PMD while on a 64 bits kernel it is both PMD and PUD.
> 
> At the time being (as implemented with hugepd), Linux support 4M, 16M, 
> 64M, 256M and 1G (Shifts 22, 24, 26, 28, 30)
> 
> The hardware supports the following page sizes, and encodes them on 4 
> bits allthough it is not directly a shift. Maybe it would be better to 
> use that encoding after all:

I think so.

> 
> 0001 4 Kbytes (Shift 12)
> 0010 16 Kbytes (Shift 14)
> 0011 64 Kbytes (Shift 16)
> 0100 256 Kbytes (Shift 18)
> 0101 1 Mbyte (Shift 20)
> 0110 4 Mbytes (Shift 22)
> 0111 16 Mbytes (Shift 24)
> 1000 64 Mbytes (Shift 26)
> 1001 256 Mbytes (Shift 28)
> 1010 1 Gbyte (e500v2 only) (Shift 30)
> 1011 4 Gbytes (e500v2 only) (Shift 32)

You say hugehages start at 2MB (shift 21), but you say that the smallest hugepage
Linux support is 4MB (shift 22).?


-- 
Oscar Salvador
SUSE Labs

