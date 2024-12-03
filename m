Return-Path: <linux-kernel+bounces-430009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D549E2AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D173E2843DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CE1FCD17;
	Tue,  3 Dec 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+wRqACs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91802500C4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250597; cv=none; b=V4eKR+gpB4jQE6hp+MDIuaqk51SIZBomd5AF9+Kt6w9lWhFXc+wPKUqdrvU0Ygl+fSSpRdiTeZk5pu5q6c2Ueb91CBjJozUH6whJZWqBduIqVZBGPCZ3H1Rc8ss5asAmg+RL7YIgCGW4sIN//AXRp4Y7dSc746bWLbXT5CqOen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250597; c=relaxed/simple;
	bh=aIZFyQwG7O5mRix6OI6/uqtKoISduW4JyBE9nZNeWfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=batMiGCtO9PV0euNMUhH4PkVTLm1lOczq2jq1/v9bw0axPrubu7TPJge79LSov383SYn6vCcE6wNzPB28jfM7d/HBcNhFqeq9vdxmYrNxeYrqdoEMmQJBeS3u4vgR98SCRlbm5RaLaov0WlG/qgjeMBv1dYDwzUBwYhovwKeNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+wRqACs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566D3C4CEDE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733250597;
	bh=aIZFyQwG7O5mRix6OI6/uqtKoISduW4JyBE9nZNeWfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r+wRqACsSUGDsIzXlJ29qM2gAwDnhjMp/7CdlSLdaidNvQ428jC1ULPvpusbJOjac
	 mxuLRq26dOg/9JSRFEjgFg7xC9uWkkJXQia4l42TGUdjUnLkW2nU1sxBge15U5F6pi
	 nHwck8Jb9xmHl9aH6JFlL45MujGYvughUSxk0Ucp0hecRJM4X9Hyu9r67NRUa6k2N7
	 V5Eiqd4CD3l0aXOCXT06YImwM3jcEiOds+1wqtx2fFJhNMvJ3CBUVFfArrSSR4qI2j
	 Wdv/WhMBGVecE0ebDw97bEWV9pQpQUdLxOC3oF9/GscZVXg1z4Gk1ZXuK9+vLmo9kU
	 +4CCjx1xgMfJg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef66fd2183so43745417b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:29:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXP0+OgXETbImtmq3FWZP0QKo1Z1S+TBtARI7l1j2N+7TNoNhke1Ddq6Glv9Rme2MqZaE3Zc1SHiYCmfUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3VL4Ga87BeVjq2xZm1xas4JdLuGvn50ZuvXjJK3+kpuywAJ8
	tl3lLwd+nl1dQAPbEG5Uf+sA1ffKYTXbjZ4NxVurlXakmFluvapW3DdMTWoSPY3fb6A5QqfY6YY
	oj1zZ0E8HIx4HRZvimD8U9FnzqDBKBNB7JH9qow==
X-Google-Smtp-Source: AGHT+IHKoZh3gvnEd4yMs915MVbdzl8XMis+4rNRyH94s8XVG/kl6jxPQqejINWwvDXPTz7crCK5uvv3VsK2qD2DtVE=
X-Received: by 2002:a05:690c:48c4:b0:6ee:7012:d72 with SMTP id
 00721157ae682-6efad2f6fe2mr46342217b3.38.1733250596646; Tue, 03 Dec 2024
 10:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-3-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-3-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 3 Dec 2024 10:29:45 -0800
X-Gmail-Original-Message-ID: <CACePvbWUqjp8VwvNFU-N14+oQ7HCiMoLA_1w1jwY3CBzM7WC2g@mail.gmail.com>
Message-ID: <CACePvbWUqjp8VwvNFU-N14+oQ7HCiMoLA_1w1jwY3CBzM7WC2g@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/swap_cgroup: remove swap_cgroup_cmpxchg
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> This function is never used after commit 6b611388b626
> ("memcg-v1: remove charge move code").
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

