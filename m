Return-Path: <linux-kernel+bounces-285485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E0950E15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8771F21460
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31AF1A704F;
	Tue, 13 Aug 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wM+c5grN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071C1A4F3B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581893; cv=none; b=hBusJVqfCleRizEP9R4+Ezf0Fc4Gmma2olLJ0f9OHR1eI+VO0KAWbdipmsskjHB12rFc4ilF9C0uYdWF6m87Fc8DYPeF/n1C8kK9rQe6XVD+N+geXnJ5LziYSJGEFiJsosov3Jg2IUP8O5wm1iqWc9meoWAKoD1xiP6QrUYMXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581893; c=relaxed/simple;
	bh=ECKzDgCz9IoWysKEXPW2k+uVJ4dvFDtSy7YQki8P7yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aO8sIkg7EeyfmyCCJVEFhpulzUTmg5RL+OWgOxGV1oFvaMC56Ds8iHCurL/YsackGkSwN5wLQDzbIRPP78izv1ysJanVreTEVxypP8/kyiIaZ06EhYju9MXVepz6UJnLlSd3QYbCv+pLMwjBoo3Xq82vXtmQYsN0Zu/d/rXOhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wM+c5grN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd657c9199so7155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723581891; x=1724186691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzOYdHcbQ4qkmVC9mC4xP2gackFKbPgb5KsoSuJgF60=;
        b=wM+c5grNdVPsSbq9cYbuAsBdx4z3hZMzuC87KrzyHfE235aO9IPLhJsGVT/mBJDL5d
         LRzikj9Tqr6NCmvHKfZ6vnXMgdNBEXWkWASEAq3pXmOyQA5d4+ABvTPEjPmXaRIM/9qB
         FI7LRB4Ec/XzYMYmSoDq2BP8YflbkPvf+SqlwHj1/i7odGKQwiGDS4ZUeRm3fe49pPIO
         yAn77WNvflzbZD3AsBkHdrRY1/Y/R/AwuXpLjIzgixFMqW7cI5m6DCpDV1XCljPT/yHl
         vxuZHG2m89AX+SKEAcFQcV8o6vo0zOO4h/IVYi4nEhD8msINy37bcDoDl1JS7YYkC+g4
         j87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723581891; x=1724186691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzOYdHcbQ4qkmVC9mC4xP2gackFKbPgb5KsoSuJgF60=;
        b=QLHB5NPlEb2KHqWteO/oH91DU58BWERpfOV9sl4mINwOlGrBBTIzJJ3urUonmDzQuz
         90WJKu1eWtfmn4gRo+KvkN0JduAEL+CTedjgexcpVAR3xLQaXapNeOyvO8M1NsoSN+TX
         mbJJU8KONj1ybfrT9VszyRYJiZ33/CzGt2TRe62iTOghc2v1yw2gTK+TDZMgKozSTR0F
         iypkA+eHa40Y+dtCuVRt4mLf/SAhIJq36IpKw098Et9d3kWDwZrJrAcHWU40IV3E+0KO
         zWR2B2GgNSH/ZJLJ23imCeaq0vEWEKfAjRyHiRKeImasRJzz5syD7p0ci4zGlA9996af
         zJbw==
X-Forwarded-Encrypted: i=1; AJvYcCUI44DmHBlKY7tLuxL6hgzIu2MFFnSo3foDV1I4SV7iQ1yNvFTDcTNClORL4WhtMEPjEz2QtQpJ7WS3at0j+37C2XZxBnMTq/owlIEN
X-Gm-Message-State: AOJu0YyqeydxsIGbD72OioJO+bVp8ZTXIBVrU4xxCgj1edyiq1bebHUv
	q2vzMxtIOYcU+tiMN3oBYzNYKXxLKfmN1XoXWQaU1kRTxXGlVN/7kG4dx8c/8l8Y/kpLcHvKtV+
	GgjkiV6kCwshlKpTFZBmxsUh4CPXEZP/BNQpk
X-Google-Smtp-Source: AGHT+IG7FjgM0XjSRwoF713hjf6YHH7UGJXXqThlFBhcQwt97F4e4nky1QguIN89VfWGjn5she76+r8okzo458dgjVo=
X-Received: by 2002:a17:902:d4c1:b0:1fc:6166:da4c with SMTP id
 d9443c01a7336-201d929d42bmr32895ad.27.1723581890806; Tue, 13 Aug 2024
 13:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
 <20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com> <2e14537b-cf91-479d-a665-c3e174cf2c66@redhat.com>
In-Reply-To: <2e14537b-cf91-479d-a665-c3e174cf2c66@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 22:44:10 +0200
Message-ID: <CAG48ez2P=k6Eezhu+E5OUzPLFpY5C4rCds1y842oyBC1ux3ocw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] userfaultfd: Fix checks for huge PMDs
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Emelianov <xemul@virtuozzo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:37=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> On 13.08.24 22:25, Jann Horn wrote:
> > +             if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(d=
st_pmdval) ||
> > +                          pmd_devmap(dst_pmdval))) {
>
> Likely in the future we should turn the latter part into a "pmd_leaf()"
> check.

Yeah, it'd be a good idea to refactor that as a followup.

