Return-Path: <linux-kernel+bounces-398972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8172E9BF8A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A70CB22667
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A81D88D7;
	Wed,  6 Nov 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faU7YRqh"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F41684AC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929769; cv=none; b=Riu2Q8mQMDGeB5SgKoNy9C7/I+UJM0UWk27KWWC4NN6O+oMGVGchAGhggrKdXUoZWamY85mkVGy+AeN8zt+nMx6RLtxukVc/pikmA6FRyjLg51thBr/3B32CGqw4RNgsKpFiHTUzWStK/+pxo00lbAOW65Yac6WTRIt5xorNtkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929769; c=relaxed/simple;
	bh=DkdeLCyWbByRnIMQF9lRMRFpW19bHGGmbEBvPN4xcms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZOWGjDBUePUrlEvct7UheXKdF0SE0WkCjdPDP4yi63orgSMewJ+HX3I4xJUy6rrvH614dop5N91zbx6K4YKi6l4KKNZP7AqYqIvr4/1jy+snorVxO8IhpdcVHfwRXCgmQFYYm53+CfUEyAh5oxA8nlWKsaP4+QfvAIt5KyAbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faU7YRqh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso25a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730929764; x=1731534564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkdeLCyWbByRnIMQF9lRMRFpW19bHGGmbEBvPN4xcms=;
        b=faU7YRqhvB2jBrGL5jc76BO/EPetJS6qa3oay+2j3S9SowbwhI9GeyuiOEs0SOQh3G
         FPyONWernZA2020Gx3SDnPGJcVVxTO6Bw4wayZIx4qEpxCNbhZlqIddXIy8827odPux/
         WLxqvTgSwAu/UYfhfE5nUBaG1vVUWMxuSQJJ100xwVddUShRu+0gmHdY6Mu+V0wWJIxU
         5iSS5BaDHPJo72qlAJ2+gtXRAShzBKjd4AYVGF58cAZxtfMM4aKsY0qJV+JWvoj14NIE
         mVcKBNvDDx5IdosXV1f32wErY9Wj9RyFB94tE0YXat8eiykVFmxs+z4vpgqyMpVzAT65
         n4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929764; x=1731534564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkdeLCyWbByRnIMQF9lRMRFpW19bHGGmbEBvPN4xcms=;
        b=U9YP+p5Cwt0dGKAUKH6BaNs/WIjCkhQMTuZ4tMMJIBmcpyc8izwdp0ehKUgTFcF1uR
         qI3xL8GGNGo5IpfR2QfNywMYQLVpFeKjdh3HdVRrmSlW/Fc4MAkpymkDETr+VH2dUaou
         HaRVSKT4hYrpNG0LiiR+XmtUFZ0UCvpkVj/OKyn9NdQoYu63a032RsxFAaVZCrXfqhxQ
         OU3VRSnySMogWRmo3XZzQ+zWD9KBDOwQJMQzB6v0g0uOPrhrhcYRJbGFM27K+ogNcB1R
         9MR5iImsae9MAus/rN145XD0XSvfbDu7h3ZK1hEeQ2wB/ky1rE1YbvCKEMPPIoT81EBH
         Hpjg==
X-Forwarded-Encrypted: i=1; AJvYcCXA1l2lb0MWO37wgQm6vggh0dPJDnXYWhrbsR6MAwts7cQowycbE8Ge/swd9eKkISadREErEVzW/sDthLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpskH/94KVP2SAz0w0IX62sTR1IzQ1NJXU1f7Ae9BSnVCKzNl
	ujmcGsqz+sZEr7p81t2yGPaby8zyvWYMaMBsRnhGxBJ8xR7ZuL6+Xzon5cuZlvAWet3tNv+97jY
	C1jO/l554HazEPl5f3+Ugo5imy/cAWR31IVtg
X-Gm-Gg: ASbGncshrjMOpBUDD9ZHNgmQHWfjeZ5emHtclGO11Xwbyb8yhxR2MY11HPedbZWCBrB
	g5fyWiJjZO8xG2NemK/9LthbB6aDpvD7T1ssmiK9xq4vhF1l1cuhwPUWmbd8=
X-Google-Smtp-Source: AGHT+IEpChxzwvSxTHIqwu6daVe2ViC6m/lr6cMJbnKIZ+O8LGmG0OXW2VCUMLk6sT8Z8i/tHHn8Qv2QTMVLtUOeexk=
X-Received: by 2002:a05:6402:33c:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5cefbca5e7cmr997a12.4.1730929763655; Wed, 06 Nov 2024 13:49:23
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com> <34ef26a763af7b2d8dee707b6f60ff85edda345f.1730360798.git.zhengqi.arch@bytedance.com>
In-Reply-To: <34ef26a763af7b2d8dee707b6f60ff85edda345f.1730360798.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 6 Nov 2024 22:48:47 +0100
Message-ID: <CAG48ez3eTssOtAFHK98ScOjDMaVUe4ioPjA2Y0=20tqy=daFLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mm: introduce zap_nonpresent_ptes()
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
> Similar to zap_present_ptes(), let's introduce zap_nonpresent_ptes() to
> handle non-present ptes, which can improve code readability.
>
> No functional change.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

This is a nice cleanup.

Reviewed-by: Jann Horn <jannh@google.com>

