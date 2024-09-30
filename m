Return-Path: <linux-kernel+bounces-343933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB398A18A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C27A1F218FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486218E36C;
	Mon, 30 Sep 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYrb3QA/"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AE194080;
	Mon, 30 Sep 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697875; cv=none; b=PUHENC2m6vlSFBARcbjzakn5jykl6nuhOdrbXGGQWzhcY9F7WZ4/92V0jQbFCa6ijwN+GvCXt00kxFbaMHli2k8+zWtElDdq8V4UgiIgcRz+Up2VJ4WuhzBQmk4q1bIptTVQge5JDK2Ed1rrk8NqmyJALCV+mdwIKHFo2fsIBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697875; c=relaxed/simple;
	bh=hTF6RoHQT4pWd2+s940bP2ANi/Y+BVqA2BrPzz5E8KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNt2DIXaJ20VIiJAYFpmGYMeT2JqFQA/WTRsVeVJwfzL1EzCFZq5c35GbE03yqtxvWf2gzDSfo9q7mEmGUvvwEMMVde6+uRZ6VjkDYBHMR4jAV+1sq4VEKKJD8yZGUEPNRcs7FuY05Wp4bLRt6t7evFEBlnWcjH5JWySJE8B5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYrb3QA/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2facd990d28so435561fa.2;
        Mon, 30 Sep 2024 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727697872; x=1728302672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTF6RoHQT4pWd2+s940bP2ANi/Y+BVqA2BrPzz5E8KY=;
        b=eYrb3QA/dKs1HzI1VD4hsSPSF5B22/ywnhTxIhCNP0u9jlsjMt68wZCXIGgWQFZunO
         CvOSOu9NZYPTqmrS1xlJJvJUiOTH5edzTG4b6gxpZZU6nMARb29AFUA4oyKujQTZOVEa
         mPkKXrjbVYayJ6wmLDxTyX4eIniekCcnH3CG6FM6M+Dm81kFzEHRI/dn5WhKKeyqhO2v
         c2vhqktoAMHipl9WFoEHfYE2+u9OyOZBGa1g7HxJOV/0yhXFMoLp6G5Ro12KvbgBKjjI
         dzZrvJ/mTTJ0aWuHN8XWU6PqdhZRqdHsmNYJqa3sz5VkuLMhr3OQYBQSSq5s6XzJLRtw
         nE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697872; x=1728302672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTF6RoHQT4pWd2+s940bP2ANi/Y+BVqA2BrPzz5E8KY=;
        b=OBR8XUHq06bBmb5df4qOMYMmJmOCByeXYEOc9nvQoR9qlRGusUkQ4jInt/Z9a++Ybu
         NLrRDaU9VCxYOH3if9CSowbxCuasT1ofmZEU7psUiZ8vCkjn0PMDSXTfGG0+U5nnSxAe
         737pFZXRRse0T9fsOOueh1DBRWX+3/Z9KxSfUe1OFy5ka2wfu8M9rzPTKSrliq5Qu05Y
         BmVVPqDHwt6/bHbtP7uK4rfGeUgg+bNO0uYawMTvhGQf2NoSpWK25NFLqk60LuihtXeb
         SfJQeuwRbSsbCZQ7bGAvLK/m1DGAKiqCwJcRk7j5taEb17+MWp7ht9S1YoiK8vkP7FtC
         Jm4w==
X-Forwarded-Encrypted: i=1; AJvYcCUQFOlgA8Bic72MRSxPTXtnqwi9ezShaik6eP1EoGOCz/zFgOcVBgvbkUASCLyCyXjCHUNURBMAfSpF6gpV09A=@vger.kernel.org, AJvYcCVndrDM9udkIqArUj88mWhG6fJ7oMPGjiMb20dzzgcgfNEryRPVTRdwbRhphiEfWzW+m7KJpeLqNEuKA2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqHa9Y5WqHt67u20FOxP0DHIHT+DVjfTcZ+p2dTnoJk1n8Qa3
	S9Tsy2q/vJfwPGxBAyoB7Bz9NCfFlNiC+pA5Dl6PydPXZhf6Zhh1LBnIQ7kZRUAK1S8Hh65JYL/
	q47qTu04izfDRdQaJPtK4KyLpNrU=
X-Google-Smtp-Source: AGHT+IHCef3uPAZ3/EOATS95v1P9uU549H5U80h924is8LTvUs22WuXXUIdJa6Pj9+eASHHy/M2/8fy78RnMUlZ11qw=
X-Received: by 2002:a2e:be1b:0:b0:2f3:a896:1877 with SMTP id
 38308e7fff4ca-2fabfbc8aa9mr13513181fa.0.1727697871959; Mon, 30 Sep 2024
 05:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM_RzfavjM9VPJhTi1czOSC0BFOc3FUHRMdzFrU9fJE+WJMKbw@mail.gmail.com>
 <32476CD7-74D6-4575-9D93-2FBCD5AE3E10@collabora.com> <51fe3ee3-0b81-418d-b05f-626dbcea4f57@de.bosch.com>
In-Reply-To: <51fe3ee3-0b81-418d-b05f-626dbcea4f57@de.bosch.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Sep 2024 14:04:16 +0200
Message-ID: <CANiq72kc8scJjSiSwj81OSdcYMrsj2AFUp+Dm6=p6PGfM0k+Lg@mail.gmail.com>
Subject: Re: [PATCH 1/2] device: rust: change the name function
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
	=?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:33=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.com=
> wrote:
>
> This sounds a little too general to me ;)
>
> I mean we link a lot, using the 'Link' tag even in patches.
>
> For example the mailing list archive has the 'permalink' button and
> Zulip has the 'Copy link to message' button I think can be used.

Yeah, it is fine using Links, as long as the commit message is
understandable, i.e. please keep the critical information in the
commit.

> Yes, I was confused by that, too. But I wonder if just the numbering is
> wrong? I.e. if [PATCH 1/2] was intended to be the cover letter 0/1 and
> the [PATCH 2/2] was intended to be the actual patch 1/1? Just a hint :)

Yeah, they also appear in two independent threads, and they shouldn't be.

Guilherme, please use `git format-patch` and `git send-email` (or `b4`
[1]), it will handle these details for you.

Thanks!

[1] https://b4.docs.kernel.org

Cheers,
Miguel

