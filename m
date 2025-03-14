Return-Path: <linux-kernel+bounces-562228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842BDA61F65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BFA463EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6863204F86;
	Fri, 14 Mar 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="QiFjnhyk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5A1FCFE3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988680; cv=none; b=jwED/mTXLPAKuIEgw7JQ8/Dpg6g0GZ/nYDuJZFy5tF0ws90KGYrtaEpx7x+Jt/iGBW8/kc7f6nRMxJyFA9p4sopwm8pOmPIBsxsvpMpOmGR/0RbrpJWoqJdepQ5fNsokG2R2Pdf55Lxt6ZfLIQSPaeTAEAfyshHsPZFi+wE59Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988680; c=relaxed/simple;
	bh=vfncAfddjIcNiQo8ie81bODzjNZjL66lZljd6RJcJBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqoOJq6VDoqLkSqGGK0EilpjCJ0QCEPG0Jwaxk67GgZjoSkzPtb/XITHmL3cLQOtRl+Nrp8cMVyLGy2+3Tf2DhN73JCVXobdXWVh8zi7GwmsVYtSw0JE/rgf6FgAPOdXoTuabjxoAusBhO8xCeyDp/qMI2JfGuwtyM85pPzpd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=QiFjnhyk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-547bcef2f96so2882226e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1741988675; x=1742593475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygJ0H2vxATGxkU1M58pqnJ01OJulJY0qCIFHyH4kGoc=;
        b=QiFjnhykMld5xiCWfCALlB3OfAYorrYYO/UN4EhO9dKKWrmcEXM8uURHxSRWDkqkRm
         eMuXTdsD0SiU0rFlbg8Fm94uqoXkK1+mmXDPUgr+DEZKHAOntAEvrc7342eEZzVN64ju
         Whud/Cgnyi5YNbfXAPPjzTUTeQULKPpK9vWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988675; x=1742593475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygJ0H2vxATGxkU1M58pqnJ01OJulJY0qCIFHyH4kGoc=;
        b=W0io0xA4WoQW9oTPj1wnmsgZ3pJmREipCXq94KoqmR6VcVeytkjizlfl7OcMafX9+s
         DorneEo6fHzXW/A5MY36jxNFgMid9I+Y+Bu/FAqN+XEtax82QH6n4OUkHW5kRjAc831Z
         uf4h4X4xAMEzSTL6Jxs7SftXm7Z6W1T4n8U4pyl7Kroy+F3jadW5Luxd4rXUJ0K9Qsqt
         C4Gt8xefWtbhRbyFNYIKJOmas7ZfMU9MLW2NtjFGNjt98qhhuGrYqCI3Adw5LHCBGq4T
         e2rKjcSuSxXW7lBcyFGAMwgguqHSnqQZlApVOP+Ejj0e23fOc6ChYCdRwe2U/P8twxi2
         bTvg==
X-Forwarded-Encrypted: i=1; AJvYcCVNszko3uU4TOqpoIZqlrHTLgOt5dl6vofQyBP8SyaA2FYypJB30g++rLM8u2o8cZlhiTwWknw6fwOaS+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxofxnFi1uGH2kJFW33HyJ3nFASvup7EGj/DfGLmUe0mZrs3rK+
	2AJ1gcYp9vLY5zyt94o76NkLhN5CsbTNC/2L7A3+Vru/qI9rMFSTAMiqm3s8HVnCt5skJ0qzL3r
	APdADM1AR94ocYX8XYQs277nOEilAiF0AnhVF03DfSGUZREeBh67mYw==
X-Gm-Gg: ASbGncuQGNSVrTnxJQtwgIamkgR59k0YqNUD1A2SfPA4SiIyabK6b9jAv9ITXPX9ph3
	C/pLZVSCUES+wNQQ/bYRvQjk+D6muU4jMyIdiZmZVmSVt4qS8fqtLEi5gUZzM+DtmW2Iof2P2LD
	kRFBG0mkvHWGmuW+AJkj0PxkEIVMU=
X-Google-Smtp-Source: AGHT+IEWnBhSIPLhooGWGB0QxRqKLPoxClk0plnFc0aU0hQcJNEEZNrsXc81K8BgPOFalpv3pmHZB9T+v3qJh5b2Kao=
X-Received: by 2002:a05:6512:1148:b0:549:7394:2ce5 with SMTP id
 2adb3069b0e04-549c3989a46mr1481063e87.41.1741988675047; Fri, 14 Mar 2025
 14:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com> <20250314195257.34854-1-kuniyu@amazon.com>
In-Reply-To: <20250314195257.34854-1-kuniyu@amazon.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 14 Mar 2025 22:44:24 +0100
X-Gm-Features: AQ5f1JpjBGfpOP5zNlKX7GO_VCD0NDNoLpNnm489_7MjjqdnEeHOwR7BjyJB7Lk
Message-ID: <CAJqdLrqJska=kCcq7WUEPFnttHfvB_xaN12MDEkc0MQzgMVZ8g@mail.gmail.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h
 with the kernel sources
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aleksandr.mikhalitsyn@canonical.com, annaemesenyiri@gmail.com, 
	edumazet@google.com, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	vadim.fedorenko@linux.dev, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Fr., 14. M=C3=A4rz 2025 um 20:53 Uhr schrieb Kuniyuki Iwashima
<kuniyu@amazon.com>:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Date: Sun,  9 Mar 2025 13:15:24 +0100
> > This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
> >
> > Accidentally found while working on another patchset.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Jason Xing <kerneljasonxing@gmail.com>
> > Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> > Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>

Dear Kuniyuki,

Thanks for looking into this!

>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> It seems the patch is marked as Changes Requested on patchwork.
> Also, I think this is net.git material than net-next.
>
> So, could you repost to net.git ?

Have done:
https://lore.kernel.org/netdev/20250314214155.16046-1-aleksandr.mikhalitsyn=
@canonical.com/

Kind regards,
Alex
>
> Thanks!
>
>

