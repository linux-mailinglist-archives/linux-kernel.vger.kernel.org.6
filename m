Return-Path: <linux-kernel+bounces-281287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953A94D51D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F931F21333
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF69381AD;
	Fri,  9 Aug 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lvncw+aj"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C333321A3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222614; cv=none; b=DaGAPjvXJkZCQ8VBcHDUyg4V25jv4qrE4DUAWsikekYuRkoKCUTzU9duYk404ACR85m8hv+kS2O4RpzoJv2sH/+CEaZUUNT/MhNp43YKe3KTwnVXaL5YNwaM4jDdFiv03iaGjFgEls74Jcwhq5103Elwq96xrG0U7AjRIcVC1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222614; c=relaxed/simple;
	bh=+qeo8XSUb/uNR8I7ur2Wfmlc8S2xBQ8VkNIPAWrw9r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJjEbmQFfKGtWhfzEMY6+xj9kXQDa6q6fO/4KfiqWPoNYK2L6W9KdYb3myiE1aesX9FBHfTHxNFZ+z9MZMzsfq4tI6C259h+AJlQGMDZDMS2jOHthPMbL7SgE2oq2N1ZiR9/7B433fANvpwTOPpoPEz6psp50BU7j0A//YeyKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lvncw+aj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-67b709024bfso25257277b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723222612; x=1723827412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qeo8XSUb/uNR8I7ur2Wfmlc8S2xBQ8VkNIPAWrw9r0=;
        b=Lvncw+ajrEe+UxQ3dMVzWIIL4ahIYwoOHZGv1p/Hih7KIbXC0o3mwrMF8vKJTYj1k/
         NCdYFlO/xZVEqwac4GGv27mje0rHr8Nx1WyFfy7LKMtLq+UX5XxGI21zU6aRKfr0hIaZ
         RkWnslXMK+rrsVuoRPvSoKQ0/8KkHv2KICDl4fEmvo0lfpJZ67/JE8Bp480b4N8AVthi
         38tWIBXFcd2Q20l4Gl2bn0Bd3j39T9/ttF06B9ZvZuL+SSO1gbNMcCT8tEHghMrMrvC3
         c+1S5YQA9n4m/2MKLFjp7r95a0McIxKt9hYElo9DAP0H4BWRuHZzFF3UtISyueaV31Yq
         QKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222612; x=1723827412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qeo8XSUb/uNR8I7ur2Wfmlc8S2xBQ8VkNIPAWrw9r0=;
        b=BYmVwjL/tbiiuWhRi4NH2bwpuOFCOlbfRhQ1DCTlQwYrtN7OjWCVcgOsZFINGXlFpi
         RtIT6ndLDO3MlO0dLdiF0s0DjTvfgp/DAM38QYL8lJ36r9TTP7DGMxiwwq7tsEgoX6zL
         aYE66QGJozakFxCAN60NsWiGCdVBMCX+RKPZmjlrMa7Kn3dz/ZQ4DO6VhJe83O2xJ2eY
         psQ37NnfOlUqezEUQA7lsTfzUcpKzLBRbGDH11oyYaDj91XQUgAJLiDi8XodKKDjmczt
         +/V9j8OuwlK4wlLQjmN1fCeYzMK/iP0BIUGI1LcXQ+kwhZNhpCAgq+qrPYFsI0zqjNTV
         GQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCV3qT7u/NVavG7DYTOfmdiHFCWcIYs8dP94kAD88ZhnPgOvOG2STHvHwsagdcB2+ckbWggoo+wSSS+B4Xy/SvGtlO7h0GccdcPFCUky
X-Gm-Message-State: AOJu0YzVUxFE5mlCAXe95JaHd5RsOURSXTLN9oA3YWrnX2bBag3Of+Js
	19lRj7Hc3Lj+gMdBCqPpGcGEyz3M4GYFok0aE5LmQtKpcXi+rFcdTWGOMQVpzyMtNSmVevMjic/
	pnDyiumjd9BAIy/seAM+jpGXbEPy7Snk0Rb1v
X-Google-Smtp-Source: AGHT+IFc3F1gmnT9F8krxiHqs+sjwSdScGk+FUmjKl8caSE0mW5405YfmjJVKF5QXR3+7YzcGwjlZ+NxrYZutVx7g1s=
X-Received: by 2002:a05:690c:2f82:b0:664:a85d:47c6 with SMTP id
 00721157ae682-69ec86be920mr24013387b3.33.1723222611642; Fri, 09 Aug 2024
 09:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
 <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
 <CAJuCfpFXdx40UGRsXUYFgFGvEy-nM02f+TQ9nOPPepw6gbykmA@mail.gmail.com>
 <CAJuCfpH36sXvCaYL88nzi_8-Yr1tpxHuaLfCMqCac-zN6QHWmg@mail.gmail.com> <be0be869-4daf-4530-b90d-6dd6c27c8736@suse.cz>
In-Reply-To: <be0be869-4daf-4530-b90d-6dd6c27c8736@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 9 Aug 2024 16:56:40 +0000
Message-ID: <CAJuCfpEMyRATp+6Xhe_XX-8hPKzONKonWbt_Jnkyp-wOJkN9ng@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Liam.Howlett@oracle.com, lstoakes@gmail.com, pedro.falcato@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:09=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/9/24 05:57, Suren Baghdasaryan wrote:
> > Maybe it has something to do with NUMA? The system I'm running has 2 NU=
MA nodes:
>
> I kinda doubt the NUMA aspect. Whether you allocate a vma that embeds a
> lock, or a vma and immediately the separate lock, it's unlikely they woul=
d
> end up on different nodes so from the NUMA perspective I don't see a
> difference. And if they ended up on separate nodes, it would more likely =
be
> worse for the case of separate locks, not better.

I have an UMA machine. Will try the test there as well. It won't
provide hard proof but at least some possible hints.

