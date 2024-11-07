Return-Path: <linux-kernel+bounces-400707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4401F9C113C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081A2285BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323A2185B3;
	Thu,  7 Nov 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgQhXYxE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929B1940AA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016042; cv=none; b=YWcp1DxkBhnMQ2pDqRwJS9z8VxTTHo4WehZBBgOILI41JwLnvoWe6eNL+TTKYKyWFUB6PqIiaYeSorgE/GHIQJGE87fGOOdh7D9/+l/Mx01uUNXSz0MkkkdkbzZcdGsmbNrVTn6vwciu2MWO+y9j8nCg8hJMQ6jrVg0Kpp/s8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016042; c=relaxed/simple;
	bh=7Vzi0dFJvYhmESZb/ld30Zb5ZAH3BkRQjZgk0CFl3Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C72lvUBITXw/aZmQfhGsMaKAQa4Pa4//LbiXyNNaCO+1QP/4BtJdTarGB2x3RRR6KiAS/81QOwJYz3BrXkSDF0DtzZ9rll4kFoFmozPKevSNTiX/mkaHvvVQp1MF+FOaFoO8TAY4Pi8SFTLgqVdEKBzRZ7xLI9chI2yuyDL5eEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgQhXYxE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e617ef81so1270e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731016038; x=1731620838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Vzi0dFJvYhmESZb/ld30Zb5ZAH3BkRQjZgk0CFl3Ak=;
        b=pgQhXYxEqmY/IkgQGtxOWwmNUj6T0jmRTkob7zeiNP5D9/+wqckWEMkFa2vkJ+JN5b
         JBQT5NROTymJbsQ4OO6OVah1RBVh0N9dQrEcXde/Ry4zfVviHktg06JBrAhT7Z0PNY/t
         O3MSpbaEYhndkWSOwJsdzV3ofXQicPhXt3Gu/Iui7SZhvnrsUDWAve3kCtQ2lSWyWrdR
         A7ubly24LU/7taKfPV5azxnqYvv3IHn+ufJjVlGVhsJPwpHO40Uugp0tqdzqd/U4LNgP
         +usY0z1WpzhkxgKfLP5LTZ49frPjC4y9WOBhX/awZYyoAKDnpHmgyeQihDmLsYpUpS34
         09hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731016038; x=1731620838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Vzi0dFJvYhmESZb/ld30Zb5ZAH3BkRQjZgk0CFl3Ak=;
        b=lOIxwrEp5moB5n9mmig/m3A0S+b8U5tyweW35OlUnwoe6Hr9qCcQuWSxH533u9ewOX
         aft9WXcj+P0NVcKftuYrWshwwOcEMkxoz+A7hq9ImWBveaRwm0+CRIAAhpMxB7O6A/MD
         g+kov4SbOeT3QOXOMMwqr+EZKMO0KTaPhMvAReg0oUEusOrW9bKFFfZdackNJtdKYoNI
         vA7Q9Wp3iVqX1yGYxqJT+mbeyK9Y9E4A5jDbySC9ngVQiJjs6Up22Om+rRDbHPgDoUyW
         rDf0Kb4uqWDeLN3S8K3bG32w4GmCXQJBbygM3rVYSOS/ykAUj8MoxlHVnUYl1nwQ2OMH
         aH5g==
X-Forwarded-Encrypted: i=1; AJvYcCVxmj8DmBS6iwLb3Nydm23vzzDb3cZRvnEp27eVP+uzClPoUpOWvE5Q/wbgi7B8XVehRQRIK3tPtb3KLho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56kWd0n3E2AnS3NvHx0gvbR6JgLW2xyKrFXM7/iKhN+oLTL/C
	Ikg7dzdGtBFdvrWrXm3yf8Pl7W6wygPrEOSD+X5tAQXq4DOT3qPeccRs3S/4zjnrQYv5MAEWS8U
	b+xgcf8ctdp/dW73d1D71U+XkK/immDSmmCrR
X-Gm-Gg: ASbGncvjYG2fuKcEWtH2PgpE6wyE/nwCaFrYgI+uJWciFp5BeGcTHkPhPp+BqbKdoSB
	kR3B8Ma8S/z5VQP8lALiKQMFT9JuYTgX1T9n4oNHA6Iq2NN7+Ow73oMBFYb4=
X-Google-Smtp-Source: AGHT+IEVRtK3vBDQYo5QQzy8bf3W+78vm5grPnlmuPgEABF22YxhCkrdYd+v15ki6kcv6n3lBxfTPf/JP57XDaNq62Q=
X-Received: by 2002:ac2:5b87:0:b0:52e:8a42:f152 with SMTP id
 2adb3069b0e04-53d812536c6mr463638e87.5.1731016038083; Thu, 07 Nov 2024
 13:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com> <63c92f1e2a2fa6267490ab9fad5b090316b39b98.1730360798.git.zhengqi.arch@bytedance.com>
In-Reply-To: <63c92f1e2a2fa6267490ab9fad5b090316b39b98.1730360798.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Nov 2024 22:46:42 +0100
Message-ID: <CAG48ez3y7UgzMZUvEqN6-O0b7gpwhdto9xb5gBTeknTuKuPcbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] mm: make zap_pte_range() handle full within-PMD range
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
> In preparation for reclaiming empty PTE pages, this commit first makes
> zap_pte_range() to handle the full within-PMD range, so that we can more
> easily detect and free PTE pages in this function in subsequent commits.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Jann Horn <jannh@google.com>

