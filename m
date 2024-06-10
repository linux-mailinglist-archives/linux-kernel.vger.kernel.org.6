Return-Path: <linux-kernel+bounces-207835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB84901CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C2A281F53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB096F2E8;
	Mon, 10 Jun 2024 08:20:59 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84957C8E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007658; cv=none; b=iGM9PGXTdPoC+9E1uhlr/rt5SiQtnqE+kY2TkAkwjwpL0h6RMFxEa8U4Blllc21efr0IGdZQaNNhmLOxkvp/PCa787AnZhskD5D2+AzgkBOBllEvZKeMzNMAM9cJ8Cns8DneMSWU1SaUW+7W1cLYhNkSRHlqifRI0VDmMKvZi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007658; c=relaxed/simple;
	bh=7sgjYt9bByk8VPxzdD6D4OYMgJUX6+aYap9e0viUFSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7KXUr6hlHu7ltIzy8vPQjtROaBrbt+kVeDz/Kn3Nwyvm8187drIL4Cnm54+iA1o2TFa3oPxm1HGslMfVnfGuJnlOTf+52YvM6WvKKRGGwZo1P4Yo1QpiiOu89rDFMzWkA1LO1aTL5vXWIa8ifVXMBbMOj6Cw3IGzdtHgLb7g7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-37588517095so11559735ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718007656; x=1718612456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yw3XhbiXJGCTPVwL3WdCXnveLeLITAMMgMc7zLy57jQ=;
        b=i8YyneoTevxk1CB5WcmsZ7RgLJLJPsQBivLJBkkdbgCUV78byxzB1uI1poiSAf2R7b
         JyPoRkh73zxt4PcpgHHcRnpb2Y8NipgdQw/3hg5Of7nTmBuAdzXrFsrOfKkp1W9DzCN0
         VI5mTpWWI2lvuChl+z8NtikPt5beDXW8xqbtAs8WfSjfA2uaiSoeTOxr9js59RcEMUS9
         A9lnsR2bZ8hDESqDfQyDeYECDxp8nN9temv06JB/Wec08ODh+yQVtWFcpX8ULz2WVyJN
         Fa1AjjOkJR4/fYR8cO9LvgdfOs6hOaPesmuTf7kneq60wW3BTg5GxKrmmUSM54HZZ1JR
         HNEw==
X-Forwarded-Encrypted: i=1; AJvYcCWuolWDlyBS907iKhKbCN9FLLp79cus2zYqMnZuhKUC74D9Pm72+wlT4gT18SHCANTs4YzSsds/9Li9ckSp635BANBYRbUb76bVKkyn
X-Gm-Message-State: AOJu0YyL6qAXMWiGHoOg5t2eUpgg97fDByuxhHcfigoWhCMDcq2E/kBs
	dJy7bZ5JLc5rlPm5qvRnnNC9T8WkGyDVSBwQX9uIzlYNrs+A9eHDDgaBPSSx
X-Google-Smtp-Source: AGHT+IFsvja4Uwk598RHo6/Eo6FsQkQP6eGNoJ/01OwHDup4v8xPPR2dn1FXT4ufwiMZrNtrg8pNog==
X-Received: by 2002:a92:ccc9:0:b0:375:844e:bd3e with SMTP id e9e14a558f8ab-375844ebfa6mr66467965ab.32.1718007655667;
        Mon, 10 Jun 2024 01:20:55 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3759671868csm11655655ab.47.2024.06.10.01.20.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:20:55 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3748ebe7e53so17346595ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:20:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL1OML3Mjo1+OgK01+nOkmWXndPV8OSK3zc4caioTnKrNJ/TVLU9OvIKGLhaozp+4uXqR0lMe7KnuyLFoY+XG7+kJ/9D7kejvWt7Cg
X-Received: by 2002:a05:6e02:1c8b:b0:374:9427:6dd3 with SMTP id
 e9e14a558f8ab-375803a2d0dmr100405805ab.27.1718007655076; Mon, 10 Jun 2024
 01:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608152114.867961-1-lsahn@wewakecorp.com> <20240609140341.14ba3a1c62029771d60059ed@linux-foundation.org>
 <CANTT7qjthRWX+7m749mU_CmGUO1UEvY6O9yKsStm165Lz=tqAQ@mail.gmail.com> <ZmaX7cnUiWla9FCf@kernel.org>
In-Reply-To: <ZmaX7cnUiWla9FCf@kernel.org>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Mon, 10 Jun 2024 17:20:44 +0900
X-Gmail-Original-Message-ID: <CANTT7qizqvwJDTxNQnoHYVs5Lpi4w44LPq2KQmLb1HEtkyCxhA@mail.gmail.com>
Message-ID: <CANTT7qizqvwJDTxNQnoHYVs5Lpi4w44LPq2KQmLb1HEtkyCxhA@mail.gmail.com>
Subject: Re: [PATCH] mm: sparse: clarify a variable name and its value
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Leesoo Ahn <lsahn@wewakecorp.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 3:08, M=
ike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jun 10, 2024 at 12:39:28PM +0900, Leesoo Ahn wrote:
> > 2024=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 6:0=
3, Andrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> > >
> > > On Sun,  9 Jun 2024 00:21:14 +0900 Leesoo Ahn <lsahn@ooseel.net> wrot=
e:
> > >
> > > > Setting 'limit' variable to 0 might seem like it means "no limit". =
But
> > > > in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBL=
E'
> > > > enum, which limits the physical address range based on
> > > > 'memblock.current_limit'. This can be confusing.
> > >
> > > Does it?  From my reading, this meaning applies to the range end
> > > address, in memblock_find_in_range_node()?  If your interpretation is
> > > correct, this should be documented in the relevant memblock kerneldoc=
.
>
> It is :-P
>
> > IMO, regardless of memblock documentation, it better uses
> > MEMBLOCK_ALLOC_ACCESSIBLE enum instead of 0 as a value for the variable=
.
>
> Using MEMBLOCK_ALLOC_ACCESSIBLE is a slight improvement, but renaming the
> variable is not, IMO.

I will post v2 as it replaces 0 with MEMBLOCK_ALLOC_ACCESSIBLE without
modifying the variable.

Thank you, Andrew and Mike for the reviews.

>
> > Best regards,
> > Leesoo
>
> --
> Sincerely yours,
> Mike.

Best regards,
Leesoo.

