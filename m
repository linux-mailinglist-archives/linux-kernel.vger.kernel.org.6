Return-Path: <linux-kernel+bounces-203441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44338FDB20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E621C22A06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EC646;
	Thu,  6 Jun 2024 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="t2ifmkDt"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034A173
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632239; cv=none; b=KOBCwkCHDmPzj6dvituzOLc99wxUaKgd9BbNDp0CkMZcXSpqFtrVlfhkOKucPcKWzCul3yKBX5mnFsfeniWc+grdqsd+SuKYmP32KqHtd3/L/fx4gKEDpsnW5YRgBidbgMQPRcJqibJ2fRrK5HCk1ZBO8YmluKa0ctPCl2OiBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632239; c=relaxed/simple;
	bh=WoThAYQjf7dTY4PLzHJ+8gSIcpbK+fsSTkttAk39lN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smM+dBLTDoGzw3pKQZ/FyZMMZEVUwyWj7pK2i9a6OGFsyWBfh7MZX4U++UymT32g2wISCsxv1mkYCkKR2MLfML0NHnqXlbqRztS4qrgvAndzrjYHxPk1SVgPS2aLgVmkhGzC4JtDAFMldPMflto3cIW2YdWKHvDZmo+iA9vKEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=t2ifmkDt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4402066471cso3191071cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1717632236; x=1718237036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Amsdr4HLBYsBEEfof3gSxLShXDHW8pNbXUNczYcLiRU=;
        b=t2ifmkDt8S6Vm5kz28dckZie/nvhBkqtUJDBMuE+S0p08t2wEfe0sYkUw/67Wf1Lz3
         ImXB+oUHMqm9BVVc1XiLGXKxpHmisyXVRlP9Hjq0/NqiFeT0pcbVC00MI+trjWEOXx+9
         0rYq8bliFHu/E8ELZMUddMeqNbnZCG2DzJ3Xj+mM3KqI5jUIleKDq3aRdq3N7K3KU++T
         8DiY+NaEA1AT5ujoO7A+p7ghkTgUh1c05ZpC6Y+3Swd7iF+a0fDH65IvFw22+PCmiapi
         o8mvKQSgRa9VIx2eVEDID3agqoC7qX3itOFKfAUtQ/GLmTfvRRAj6gNvEZseWZ8vc1g5
         j3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717632236; x=1718237036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amsdr4HLBYsBEEfof3gSxLShXDHW8pNbXUNczYcLiRU=;
        b=IQxEOXLuD98gXiIE73jPgm/KtKZ2G324gq7eB/GxEDEqo1J0lHla+OkRE980w78aKq
         qk/cZrkOy5V7bUY/pWwKZc/rQyTwE/helAfnVKnltsPxVCIwV8cbE+8VJ1jP48rFCXPQ
         3Dt5QljwnoSWfZ3eaWfvRLQp26ltMhniIJQc8uPznKXHGyjpjk64Cl3acDnTSnVlK1lG
         +zs6ZIF/6XVaAkNjM5RgB5Hy0NZCtBLttNg0h1LWMvxndsFYXFyF9zlc97P1izyKyZ0S
         CXDYi5ytVXg7GmXxUmJoF4oUV8k1qqagYCHD0XOgqlyxmcml8vsncSBvVUImnoFN8SjM
         WgUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3XNQP/nJaG2klao1KMOE9bZyKAJ76CvvX9S2gCae3bZRCSSGQdiAJIBipgnz5F0nAr6IkX93VsugGNJDkEBZKofLsE80uvMG7J5Vi
X-Gm-Message-State: AOJu0YzJXjCNHuR75op5eJC7VAbsUuJIrds6PbvOqnGgD8YJBEB4n8Ao
	RLDQzTYT+TWqQ1rW5H7NZ736XQRgPxhcan3rpPPpJVAY2zU95VLhKhXCG1psAmNq2a5oEywEHDP
	MZGdAZ0Oj4e/51uo63Agn0QPumpzdZswu9+g5eA==
X-Google-Smtp-Source: AGHT+IE2DRuFlltNwyIS/VDUUwHtknHgVQUgsXKv0p5hEFT2yy+hK1MWJPZ7tc+UeYTVvVhfRpP8lZ99+uKTnilin4s=
X-Received: by 2002:a05:622a:1388:b0:440:2a5b:ed6 with SMTP id
 d75a77b69052e-440361fbc96mr22097821cf.5.1717632236484; Wed, 05 Jun 2024
 17:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
 <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
 <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com> <20240531173823.4ec7b4693a4e433b1da91e75@linux-foundation.org>
In-Reply-To: <20240531173823.4ec7b4693a4e433b1da91e75@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 5 Jun 2024 20:03:19 -0400
Message-ID: <CA+CK2bDD-S3xB4F8CHPLpUdfhTGf7=QJvoQL2XtdW3CYfiZ-GQ@mail.gmail.com>
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, vbabka@suse.cz, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 8:38=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 30 May 2024 20:14:17 -0400 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > > Couple of questions:
> > >
> > > 1. In future with your on-demand kstack allocation feature, will thes=
e
> > > metrics still be useful? (I think so but I want to know your take)
>
> I do think the changelog for this patch should reference the dynamic
> stack feature.  It strengthens the justification for adding this patch.

I will add a reference.

>
> > It depends on how on-demand allocation is implemented. On hardware
> > that supports faults on kernel stacks, we will have other metrics that
> > show the total number of pages allocated for stacks. On hardware where
> > faults are not supported, we will most likely have some optimization
> > where only some threads are extended, and for those, these metrics
> > will still be very useful.
>
> Also useful changelog info for this patch.
>
> Pasha, could you please prepare some additional text which I can paste
> in?  Thanks.

Yes, this makes sense, I will send a new version with the updated
commit log soon.

Thank you,
Pasha

