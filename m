Return-Path: <linux-kernel+bounces-421812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC509D9076
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3937287892
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7592B9A5;
	Tue, 26 Nov 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S6pNMyhI"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976F1CD2B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589123; cv=none; b=UY5AVvNUd+4jKGFiQQVHITd3TAfDs1in24kw0/xUa0e9rhO3BZZxjcoGkmXwnJbm8zRx32iai/vCKk2v7EmxUy/7qV/0SV8JGqBrYcL64s+P3ckWFjyDPQhudkzM3OFtQKs/O8TY6dVL50nXuIbhN2/zn9Fax93kyHJ0r8Cgqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589123; c=relaxed/simple;
	bh=YQIwdTt6cxgmVXfOJhj/54MLx9mAGl57houTp14qmmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIsLW5wAYzKMYk/ZVQ/4mCCchIwokI5nVSPXIntghriCH1LvBufyxmGOrqS4DQbYoJEQnRXkY3HMCUJ06UxIGHHdt8QtsqdYwSOGp4lQNX3eyR0/2RbmIlIlWLx++AcJxMx8ZXEJZ41mOa0j2pvkQCZJTXumC+bPED22dLSVEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S6pNMyhI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa55171d73cso280811466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732589119; x=1733193919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quBmcrD650pEIyPTImDpIW0ZSz5rzhaGhAnMOzpggdI=;
        b=S6pNMyhI9FjCVKeBTsBWPBbFVRPv7+3UgjSF42C1+Fzj9obDb9ZqPrEkweqb12WVBm
         IYXeOSdh/RWq727DEBLeYpmU2es6Ys0LfShLT+/he/uqIdH/k64QuBLCVzfTU5+pQ9T5
         dfomjEqgblRzeoQQ05NRlVsxzLDX3rr04aFv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732589119; x=1733193919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quBmcrD650pEIyPTImDpIW0ZSz5rzhaGhAnMOzpggdI=;
        b=TKUxW00tk6R3WR8L62x7x6SpP5Yw9Cs7zYAmXUbK5CJQ/rPfLGdNdbcnNQwuSr7e6/
         dG5tbuXCjK9Jfi0d4DrcNoOi+3OrCv67hOPiPSzrmYtCkmSt7koZ0lq7NODWLaS/IhjG
         zSdkLCqBJg4Ua7tlTEOgez8Pz8JvFp422HtLIZF8s1aioGIiDXCB8nnMv7363gtUs7dC
         wIWyCNuH6TRk45Cqe7dyv6B5KMjFWePdQVODCsoXYZqyidiw/K8i1ZxJX8uLlPRZSx53
         0H/1oK1x4SIKNv6Aw/iBZt+FLQcyO0Go3jRAC8CUdwEQfsDpnl9yRzOH52UEPTIcMS7S
         KtiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/WfksTpSnKG56vs21cgVZeHNcjznS3yaUf+yv4RVH3zamzN3lXnbrBotyBF64MvD06xKV8eNUJxtJ1ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtTdyBp8mWvr9y1pgxu0gK/ks6Mg49+iizAzbLWDHMX+sM8NW
	CRN4fbBHIsszxEE6SizlBbqGDoCIh9Gh2M8CIxfUh6S9Ar1qbIrNWnXtxgmNN15bh7oe5yisO/3
	9yjGjOA==
X-Gm-Gg: ASbGncuubNpSJhh+0dptBGwaxea5Z15dh7Eov3BgzKtLOePYoA09hNOADZhpzy5ZzeX
	9OqgS0ss2P9CGAdHrVKlx749jpysJtxjTX5aIsMyuRhWhNQC6v7vKI1St5K33l3rcXW/RVJ2Yer
	xz5Gr4wjgfKntTQx6SnBSI5YMnGmmc73E3WVhc931lOGO8roTruZRePH9x1uUVjn0IILCah/JYc
	Q/NTM8jC0Jxftn4ilU3YYv5LLvtxduQXPg4EA80W3rr/AuR86u3QoXwQ/6xxpkibGwrSFzc8OZf
	rA6UcL1hNnZ9/2rSOqQpoU/2
X-Google-Smtp-Source: AGHT+IET60mshwJX2yV90NJiOc7X7McBTmNGLl0CrJ9b+IEYVoRdaHMMFnFNHwi+LG7PbVvFcvrOwg==
X-Received: by 2002:a17:907:7752:b0:aa5:c1b:2204 with SMTP id a640c23a62f3a-aa564890cb2mr151563766b.8.1732589119520;
        Mon, 25 Nov 2024 18:45:19 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa550d3a484sm217561566b.115.2024.11.25.18.45.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 18:45:17 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so393720566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsF0P6olegBV0sz8VPziLgfO2MksVFPsuU3PrQPVb2XwdefqWiAdAdtynxjBqAoQjiyWAlOsq+y2oJE80=@vger.kernel.org
X-Received: by 2002:a17:907:6d07:b0:a9e:82f3:d4ab with SMTP id
 a640c23a62f3a-aa564891110mr139123166b.9.1732589116714; Mon, 25 Nov 2024
 18:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
In-Reply-To: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 18:45:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>
Message-ID: <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: pr-tracker-bot@kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, open list <linux-kernel@vger.kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 17:46, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> It seems to have a minor merge resolution artefact: iommu_present() now
> has a header declaration with no definition.

Hmm. Yes. It looks like the merge in commit ae3325f752ef ("Merge
branches 'arm/smmu', 'mediatek', 's390', 'ti/omap', 'riscv' and 'core'
into next") is buggy, and the iommu_present() declaration survived
that merge even though the 'core' branch that was merged into it had
removed it.

Those octopus merges may look cool, but you should never use an
octopus merge for anything that has any conflicts, because they are
hard to get right. Joerg clearly didn't get that one right.

I'll fix it up and remove the left-over declaration.

           Linus

