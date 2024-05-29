Return-Path: <linux-kernel+bounces-193273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E208D29A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB82B25CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527DF15A4BD;
	Wed, 29 May 2024 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlgqGMPt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1415A4AE
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716943864; cv=none; b=rvVxtQ55N5KqkeztoGY+qJOqW5CsWhQGXMQnJxR6rUz/VP1Ne0skmyyb5vCbPhfAGT8MDnfZG8FNIVJGWKQDjmRwr/N/OXtrTLUGN72f1uNLeeXpdDrQrlT5jHWiprgbTxYvhxOh3WgXJ9QJ+8Dw/qnHsMMjqbJiKKP+AmRuiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716943864; c=relaxed/simple;
	bh=+pWlSZoqw64YXEzXVNhuJ9yIm/GIMMuyBwrK/e0NMeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqV0Hw1EWhJuXbqAwtLBvmggx8QqUmq7JUzGqBcC4EUh+BSFIzwPf0Lnx6zhJh2wKia2TMVqqVvRHf/lOKL0DHbk4SAQ41QRt9yqFiorczaB9/CqdAyfu4+1rsC8Y/KLaSHrCj1J6VKekQItnYALCcEmcNGXlvIuOhwZjAblou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlgqGMPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B548C4AF08
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716943864;
	bh=+pWlSZoqw64YXEzXVNhuJ9yIm/GIMMuyBwrK/e0NMeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FlgqGMPtQqHOPDHecsp8EBKaTdhdv9cRUrYagS6y/hQClOeozYoo5srrAxM8EO5oa
	 c8ZFk8Kp5Jaz3Sg8y670BEQWBTFfEmQdgUQkreMOLZWTlNT96a/OZGRmLuZe0VBfTw
	 qM/vzVs6n8BdHv5nNv/yPfafNodXs49+7umxdvumTLLpecwhmWFv5fBX+dD0MZ8aXj
	 Z/Y4Mn1ek+SiSi55yie+LLlRPGn7JSPfLTxYWy5J3pq9BC68b3qXgfmiNEuJaUOOiF
	 n3CZuLkmb/T5YGPtw2f9Dop19AVq4k1pFoV7rmNZml7bEjWBWlhIYLBo6ge1YrxLV8
	 irMMcylxgN3fA==
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3737b70a74aso1336945ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:51:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl7RVS0wxkthrrtNMvjsHpPfUWA6y/WaKZvBlIrqkEZuKojFOrZIdIH7ERUySNpnZEKQLFncfzgoVHQAiiRQCqe8z/IH1zeaAsc4Ne
X-Gm-Message-State: AOJu0YxmyTfsQqJghJHOlOyti05VPd2ECiwHwlWHo9EGOi76PEdzabUv
	CjhQAUYH6um2Vm0O3X8dTmHTq7aYWJrZHBA4LLYfpAKvcO6t0DZ01GLDuOgU2RWDBs3e86AiuPx
	qwE84pjVOBe98cPoapaou9c8MLTy/cwsL9Nng
X-Google-Smtp-Source: AGHT+IGogOvO07nZBdXAJJ3KWhwNuMCm9vKIy/R9kjeTHH3LTcJ3Fuc5R93FIU5owSelUtZBZtnVta4x9u28iThR9e0=
X-Received: by 2002:a05:6e02:1d09:b0:373:8d04:28a4 with SMTP id
 e9e14a558f8ab-374737150b6mr5970915ab.13.1716943863281; Tue, 28 May 2024
 17:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <20240524-swap-allocator-v1-1-47861b423b26@kernel.org> <CAMgjq7BXBrHZxCKgmQxe5TsCxuumaz1PMxauQ-fuBbTw4Vzs_w@mail.gmail.com>
 <CAF8kJuObD1ORzTXZhjoviVK=_=yyYw4=NjRxqU92bOsD6_4MLw@mail.gmail.com>
In-Reply-To: <CAF8kJuObD1ORzTXZhjoviVK=_=yyYw4=NjRxqU92bOsD6_4MLw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 28 May 2024 17:50:50 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNUneUEUwQy9h+nVtQnivFdhQPWghsG62ia3rbMCz18XQ@mail.gmail.com>
Message-ID: <CAF8kJuNUneUEUwQy9h+nVtQnivFdhQPWghsG62ia3rbMCz18XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: swap cluster switch to double link list
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:27=E2=80=AFPM Chris Li <chriscli@google.com> wrot=
e:
> > > @@ -670,7 +562,8 @@ static bool scan_swap_map_try_ssd_cluster(struct =
swap_info_struct *si,
> > >                         goto new_cluster;
> > >                 } else
> > >                         return false;
> > > -       }
> > > +       } else
> > > +               ci =3D si->cluster_info + tmp;
> >
> > This "else ci =3D ..." seems wrong, tmp is not an array index, and not
> > needed either.
>
> Yes, there is a bug there, pointed out by OPPO as well. It should be
> ci =3D si->cluster_info + (tmp/ SWAPFILE_CLUSTER);
>
> "tmp" is needed because "tmp" or " cluster->next[order]" keep track of
> the current cluster allocation offset,
> in the per cpu cluster struct.

Hi Kairui,


Actually, you are right, the "ci" is not used here. That is why that
ci out of bound error does not trigger kernel OOPS.
We can delete that else line completely.

Chris

