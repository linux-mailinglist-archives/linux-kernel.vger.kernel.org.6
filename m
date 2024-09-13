Return-Path: <linux-kernel+bounces-328713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC229787AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB7B28B7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A912C54B;
	Fri, 13 Sep 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BJvDICO+"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6D558A5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251426; cv=none; b=QvJivKcmmBE+7A5dSeZdfFPSgz+FA3YPAqZMzksWei/HaTwqKWnDLeIiCnq/PCWVejlOuiHFnkJJXNBgkLkoCKkWgcI88iy6ztjMcBd0/bw8gEuCEaksRyUhA8+pKamYzF25MQYpg5WjECNK/Z9mj3NTiSruXStTopIhWfpTohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251426; c=relaxed/simple;
	bh=Zirz1Pivh/a9Lqz7ebesycHuMBNE8FcBNu8UmFdsawU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYj88olxOKPkSsKpdOPz1b4tY7lncsR89XWyxYq3/a56awyrXSPe3ClNxt9PMbDK3x7VyWgvYTTSR6kN1XjffA988jVlffW7Wf07nDxC8qSXhCkTfOu34RGcl9vJzrrVO6sevs+nRFhLPzUTEiqiNiK39/qZhBQ49jDDr558ZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BJvDICO+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso2074714a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726251425; x=1726856225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zirz1Pivh/a9Lqz7ebesycHuMBNE8FcBNu8UmFdsawU=;
        b=BJvDICO+cmcqbF4DdqC9KpiHpyV7RIUE/9xfCe/1le7nJagqF6k6asLX5DpJjtHUdW
         0xk8ID4w+qN23g9FZpxqcwaHctgusKymCzQLy9q/o/roa8pYQpUVmyfrvG7yW6RUcHC5
         K+InIrKwbAjvJWGrpwKVrXY/j3e5ILIHdAA6dpHd81YDrpbajFZr9/XugfIuU1DdvdB1
         On4ELaVGjav6pyQ+hAWKS0yDQY+jtJkvRVKBFndkkg7qxM7WyCJAPZrlN0BQmkkaQYPC
         sM5vcDSlCD3xj6NVT/X+zqcwXNJhotnh5OAWdgW46EchEVLicutrBOyFa6IjD4+VpCs5
         V6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726251425; x=1726856225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zirz1Pivh/a9Lqz7ebesycHuMBNE8FcBNu8UmFdsawU=;
        b=lK1GB7qKQn7q328Em3L9ufg1sJP/yiwM3aCVDn4ViSNCKhbpRUGRomJVEdrB8+EqDW
         8P0j9RPnIvUtYlSUwvttB2Vdb1iZk91npT1WBLWJrujn4hetL5vsxj2RLY8T9SOJfVEo
         JnM4/pMEbCVZTMhvoKRo7uyO0M4PAjnpMJQbV94Tj1wtD/2Y9/Vi27Rdr4SqMdBDCDs3
         ndkHNGDCnfHmYO+DFFKDibNjRLaWGSVPhQS8+9PdHSf5jjcIxl9rbyOJV1Fp/f0Y1Gmv
         o8F462+O2nqUoM9iX6JVjtLq22xe3Q0NTTVs0yvPzgN7pQJYtBSThNr0KCUSOqWlNmXV
         BFtw==
X-Forwarded-Encrypted: i=1; AJvYcCV+9tI4Sslwfc3BcyPmfRqyZNZHP/1l5CvcC/WvK4A2m5Tvk8DbtykV+X5EmF+oLn1MhXjIJ4KJolu2AQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcQZvPxIULvuYaAgpTm7JMS8qHU2FeOzrhLbGSiMiIsTSByI5
	AEt1uxAoI2T7ynNia/6fSTLe6tQOk62rLy+SmuxrrIvxTMDNi0HQc/EnN9KhJPNcMJi0L/yUDBy
	DKILTMldoCGnTKBuZhYdiHSh2jhcFQmio9dNu1w==
X-Google-Smtp-Source: AGHT+IHZUwrVez/2PYUqPvng/skwEa4nwyDeCSrWYu4aCAeh0qkWxmBZN32geO/3Zu2ECvk/Sr/60BLsjf2Vkt083wc=
X-Received: by 2002:a17:90a:4906:b0:2d8:9c97:3c33 with SMTP id
 98e67ed59e1d1-2dba0061173mr8075882a91.28.1726251424747; Fri, 13 Sep 2024
 11:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725334260.git.jpoimboe@kernel.org> <ZuGav4txYowDpxqj@pathway.suse.cz>
 <20240911162005.2zbgqrxs3vbjatsv@treble> <CAPhsuW5GuADzdnsBi9Nx0Rrv2FRnO3c5SwdYA01ZShOCf6RY+A@mail.gmail.com>
In-Reply-To: <CAPhsuW5GuADzdnsBi9Nx0Rrv2FRnO3c5SwdYA01ZShOCf6RY+A@mail.gmail.com>
From: "A K M Fazla Mehrab ." <a.mehrab@bytedance.com>
Date: Fri, 13 Sep 2024 11:16:53 -0700
Message-ID: <CAJKDkqj5VL7fbr2Cn8uW11_Megq8hjCjSTF1UkLLhLj6-KDV2Q@mail.gmail.com>
Subject: Re: [External] Re: [RFC 00/31] objtool, livepatch: Livepatch module generation
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Song Liu <song@kernel.org>, Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Miroslav Benes <mbenes@suse.cz>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Jiri Kosina <jikos@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Thu, Sep 12, 2024 at 9:06=E2=80=AFAM Song Liu <song@kernel.org> wrote:
[...]
> > Red Hat (and Meta?) will start using it as soon as x86 support is ready=
,
> > because IBT/LTO support is needed, which kpatch-build can't handle.
>
> While we (Meta) do have a workaround in kpatch to build livepatch for
> kernels built with LTO, we will try to switch to this approach once
> the x86 support is ready.
>
> There are also other companies that would like to use LTO+livepatch
> combination.

We (ByteDance) would also like to try this approach as we are
interested in live patching LTO kernels.

Thanks,
Mehrab

