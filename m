Return-Path: <linux-kernel+bounces-283663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4C94F781
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF24DB21CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7D1917D0;
	Mon, 12 Aug 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RBkAVD7Y"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF816BE2C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491200; cv=none; b=I9sJ1JtnkVo2GBTgdabaEm+tM8f6w825bbRT2ICoB9KzkxMCL4cob8d/ciR/k2AQPGkO0yYHxBdixdydOmXitudRAGYwgfM/MY6xyBs6I9MdxCX3elv86HvnZMQ6EGoLlrpYCCkE0Yi7mSffuu2ID4xZvYIQSJuVfOAQmLiJT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491200; c=relaxed/simple;
	bh=I7o/TuFiT1ulNiY/juCjMT5cj9AdysN9wAmi7vH9gKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8rX4I9qtBhQ51ZbiiAbVebij8ZDjLDOTgOp3IjrscAUO2Hb2Fy3HDAB1uyyG720pJ923pJ8fZOjO+yYIOJ+4qNzweDEAIXGsKUvQU0TD8HdcH41ORjfEVTlBk2nQxWZPkGNeyWxi/9YH2FHkMYRP6U7/vvEM0Nygd+XP3ZE+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RBkAVD7Y; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0b167da277so4624881276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723491198; x=1724095998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8ueVjdRYs6KlVN2J9hv8wL+GejLjR9GrR718rCUfUg=;
        b=RBkAVD7YVDizINxtBpH1yHSq9pPyLwrHhTvMuIYjz6a8YfUfPHSPkaSfLc0/EnOJPC
         KCJl5GwEkGQHUnXhLfE3k9LcSr5bbkPrELSG2YWfe97FA46HgE13jtNGmI6bkQiGRVGT
         12QkKHsJWH97lAaxq+xsjS7CXucPEzL7M7PFCD0i4SCidu1zO0ubxZiH+Kqf5NGZTuFD
         6A7N8dGNujS7ACi01HAF+JbXqhjKHpFqR/XLX7XkYUcOtQJiMOxQHrKEj+bZ4ftXRBo1
         R+7YH4rZQYzNqkWO9G9s/aE5OTk8c/5gMGkIyrZ8k+EELti6jMIzKCLIZfbYlfZnSL1w
         Xa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491198; x=1724095998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8ueVjdRYs6KlVN2J9hv8wL+GejLjR9GrR718rCUfUg=;
        b=gZi9l5Hc4rxLUhctpBXHSLsoCz+Ir+T+F1M7IpNHCTC7i+bAx9k/AvtSgPBLlny9Fc
         RbwW8OfI35Z51/74kCZUhhbLJyC0wNWIsKXDKxXTwfw1NzJKBqwGFVo5fSfOcXNbSt/0
         Ow5SpU28Zu0e/uK3SdLvjx53rYZCmRedCpMC85y9Lr00aWWEwiRu3KhadOhyJ0CnXKPd
         F+LK1URY9oT050SeLZUkTDCk7vtwE07vAF3O0SPKjiJ30K7BSKFsSfYmr5BwxGgSjUcQ
         IfTjjiqqo/hpgy0Ia+UCrhC1gUVD/Iftz8qdHzjs+EdAiK7s9A0iAtdygmcuud3Lg/PA
         qsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL14KZYa0Rj/GXL8ldty2xj4dgXafAvzBgjgd2IKMxUqq9GuXwBEHF62dPtejvLqWn86rThQQjICPOS49WF2/aVTVgEoNoWLXjCBox
X-Gm-Message-State: AOJu0YzpBdaD46grTSfOYn9Oj5XU2Y4/8WdpBgQ6SnDv16XTE6HDd/t7
	3cnFZB1WocOu0QDysNuUVs7ykonNi0HlQaALLaLzwzYSJ03WYKZyt6Hky5P3+Yx5dN5ah8bXTcl
	g++bSLF9rK3Hjo2zG/Sl43IjLr3g8tcA7RvEBrXetzNoz2co=
X-Google-Smtp-Source: AGHT+IG/T2WWeSxRTx3K6NjUZgI6/jCXqtBmNSmHWiEPCtzwVFftWXD+AHPOFIsHBFbzqMm/faid9c16SXjdccZDLho=
X-Received: by 2002:a05:6902:2b8a:b0:e05:e942:e7f5 with SMTP id
 3f1490d57ef6-e113ce676damr1747017276.5.1723491197963; Mon, 12 Aug 2024
 12:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
In-Reply-To: <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 15:33:06 -0400
Message-ID: <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:12=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> JFYI, I synced with Guenter and all arch seem to pass and alpha does
> not work due to a reason that I am unable to debug. I will try doing
> more debugging but I will need more alpha help here (Added the
> maintainers to this thread).

Thanks for the update; I was hoping that we might have a resolution
for the Alpha failure by now but it doesn't look like we're that
lucky.  Hopefully the Alpha devs will be able to help resolve this
without too much trouble.

Unfortunately, this does mean that I'm going to drop the static call
patches from the lsm/dev branch so that we can continue merging other
things.  Of course this doesn't mean the static call patches can't
come back in later during this dev cycle once everything is solved if
there is still time, and worst case there is always the next dev
cycle.

--=20
paul-moore.com

