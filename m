Return-Path: <linux-kernel+bounces-255585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBEA934281
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B071C218F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6A1822D7;
	Wed, 17 Jul 2024 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdmFxlzt"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D813ACC;
	Wed, 17 Jul 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242889; cv=none; b=OYBRiEbIatjHPtyjmmIGMcXvCHuNuQdVQ5ewuZXdb2ZxxHp9ESA5MmAUN5kbOB/Q7C3UK94956ja60U468floqELYBriqqeQUbHss3Sf74mOp56uAdboh4DHaEDYRZMUE9EdqowSEO5tlyg40Bv2loi19eO0lDAPh12K5wQK9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242889; c=relaxed/simple;
	bh=yKGmITPHeBZC/W7CCXq1yfugfxa5MVrGs9L2E2gIK4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKBizpJodLmqQkLoV6tdU22KKe5iXntJ1oBFv8Fi44MsQl5I8Pk25dTuh8vs9sQz0tWuNRhYp5sIc/SibIHojDuWaYXHr0sa10TcmIt9y+7DSBuRaCjWQV23PxbJvAwvCFxaMuh0+U8ERZE8U5qw4HtNVIOM9dGwnXytrwn1Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdmFxlzt; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7036e383089so3610a34.2;
        Wed, 17 Jul 2024 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721242887; x=1721847687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKGmITPHeBZC/W7CCXq1yfugfxa5MVrGs9L2E2gIK4I=;
        b=VdmFxlztfoFMJBPteqs5MZTalOL3MZ0XxQiz/XjHSdLhadO/0BLS4obfnN0gRyRmFd
         2wCMqI+3/vgKJCtZUIK3L4hapWCddlq+f0q5vBbP3zwS5IUc/qIIfAMrjWXohVJCSCBQ
         mIrCjz18gh2NcJtMtBQw6mDQ7MzPaF5hiVquvhWs0HgmNncIOCLzVJsT+wy5ChW/dDJu
         d6DHH6in/mMclOXkrW/xVxnP2FKZWBYKZlPfRBsJx/CBaGcLm4+Tqx9/GO5QSX+nZg7o
         +ICl9aSwyGqFGcg3E33j+OKp+iBvNAQfvX5QSO8oCigO2U9GGx5mhdpdBA1jBxEon4T2
         c3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721242887; x=1721847687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKGmITPHeBZC/W7CCXq1yfugfxa5MVrGs9L2E2gIK4I=;
        b=eFkZ3sbJ6PXjCqqNwo0USOEdFeEqZl/1SzomXIZnIjCzP60kiBglwUivfd8zbNAlgf
         0Jy+t1cH65PjMk2sBwHU/RmTjjk/rm6ysbRSOwtsMgp0ZYJwUwB0FBKYzK187U7qg8wd
         rAbK+0Ji0f8cO8NTpx9WTv5vjwUo+LDfEkFOF4Edl7PYwTI6O6Ho/64boAT6VlE12BK1
         E9Ds2oC5aHYHjU4FyCIHHKk2Ni9cpRcHJRvL5esp/qUEo5ijyTo1SfVoisoo0gbo9Jog
         yumCwQm9yvnMlS7bj2QTsHub3Bfrbx767odaB9alO5N9RvD3t31Nu+BpNkDJTtRvFMAL
         mmuw==
X-Forwarded-Encrypted: i=1; AJvYcCWdW6Fw2edBGYRrYnWlY9HIdl8RuE4bfGu6BfCtbZnsb+XZzI86P0peLpUAhatv++enFEjlgdFyxi0hIUkXIwULOBFD3VcQgWd89RtyEpRZUT6+sluHhkii/eqTmOpl8ZexPHympPuL
X-Gm-Message-State: AOJu0YylOJaAwYCj93iP/l9zseVL5A5tYFHMiGqGFNFDeP7RP737yANO
	CJ9ruer4/7yiH8aGhS6pDcml2yqNU5QH2VmyqEAbJtYdtjFPZtJFOH5tuCp+ojCJbAc8SiAww4G
	6N1NlrZYZXAZ6S/NPh7+zsscBwZY=
X-Google-Smtp-Source: AGHT+IGgMLRySBRxDItr4LJwkSAZttCB4F0EnNwbQ6R4S/aKgtby6Df7rUT7pWFyPRvqgvap5KjLn5UiZdUZkdtb34Y=
X-Received: by 2002:a05:6830:3981:b0:708:b2c9:1a9e with SMTP id
 46e09a7af769-708e3774d43mr3388507a34.12.1721242886693; Wed, 17 Jul 2024
 12:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
 <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
 <CAJD7tkYnBw-QiGXTb4BPScuS1VePBkuRx1qG8p92zN9TeD+gKg@mail.gmail.com>
 <CAKEwX=OPDkwnSno-8r9AsOpmzkZ90SzeX02xz0eDTqbL2_QL2g@mail.gmail.com> <CAJD7tkapE+qSmjFXnLBNamMvn3Lxbx=yvDF3gXW_qba45WU1tA@mail.gmail.com>
In-Reply-To: <CAJD7tkapE+qSmjFXnLBNamMvn3Lxbx=yvDF3gXW_qba45WU1tA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 17 Jul 2024 12:01:15 -0700
Message-ID: <CAKEwX=MPTLP5svbV+ixrqtq8k-E1XTfLdkUy44vm21MdJogNOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Takero Funaki <flintglass@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:05=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> I have always thought that the shrinker should play this role in one
> way or another. Instead of an arbitrary watermark and asynchronous
> work, it incrementally pushes the zswap LRU toward disk as reclaim
> activity increases.
>
> Is the point behind proactive shrinking is to reduce the latency in
> the reclaim path?

Yeah, reducing latency is the one benefit I have in mind :) I don't
feel too strongly regarding this though - in fact I'm more biased
towards the other shrinker in the first place.

