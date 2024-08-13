Return-Path: <linux-kernel+bounces-285257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D4B950B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DDDB20DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BE19CCF2;
	Tue, 13 Aug 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/4c/eT/"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B832033A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569419; cv=none; b=BwQwTKrgNI5a/nJMd6kF7Q0CZTUOV91JyLMdctS8fPTS+pVXcDVgkq/6g6mR75L9K+wfTl/3uiZELudShyvD0zUIzHgLKoPcfq9EbMbD4oyYzkslNdluMQPuRc5fHw2q1NWa8N/l0gNEHElkhwQWRsjGLeZpKW8c24Mb8ZSuRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569419; c=relaxed/simple;
	bh=E322JD2Wtc9knVRaLvztksWEZy2kRB1Mw9QSaHszMWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJbEsD6VnzMDo1O1SlSicnIh8okrmlHOGo9d+OtuG+Gme67U5+F62454ZuARCC4ruzkxGRZwRDrgvyozhgUh3BiNT1URjx8TWYzVV8EWy9Iwez9td0/F+afb7not5cY5OUOBu+2g+nCcYiVr7qWvp1VXNeU23bEHT296qCO1cBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/4c/eT/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f6b67d9608so2416377e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723569416; x=1724174216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E322JD2Wtc9knVRaLvztksWEZy2kRB1Mw9QSaHszMWo=;
        b=L/4c/eT/G5z9IjAy6lscBqs4jPeAfr5owsVfjG8u5FApvnGaxGNsBJX9zPqKJ20ajY
         6lkgRQFkkPoRJD0kfUig/0fTPgk4uGTHexRDSsawMUMYP8RuANdZTzTu9zXnuJc9XWo0
         J7S37pKwIbmEpVg4fWkh+d+RZ9MoL8KLGn8LggkD754+k8hmEXbU2/zqnnIADJQru4zN
         LJlw1NoNhGHrYd/12hExqVWsfmtEJPhrYsm9zD4TnJvlR+9HNQX4zMLtclYB1Rogn9xa
         5RB5hK6SJqql+D0N8dVHXCw9tHvv1a4uSCM5z1nYIGY3gwbwlIiPTUli4T/iM1KWo0e8
         4mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569416; x=1724174216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E322JD2Wtc9knVRaLvztksWEZy2kRB1Mw9QSaHszMWo=;
        b=eWOQjWtDCyUdk22npvaeYUgYdaIDFJDJ/0eqV3Ev8mYHPqlZ8vcCxoMgNdj0y2094G
         g0GTGBFQlb02GijQFuv8mDoOSqvbVdG6sHx8+AU17r6GMbCnWDdWCr4SSSVIXF3k9jwf
         l8HUge/rFIwc9g5jtCjmu9cD3243v+phqXpDtiQXlPDp3JbevUpkNdR3ysfn8ISJRJeu
         jpPhiERbL8RRoKA20nn9k7HfgrdxJ+xERyHJhhOHt0pjNUSKM1MQQgxkkeB4LYCb+9IV
         EI578wGFwQrCtI6B2Tj7XcVQkD1rEiTsdTtQa90YANOkpGoEW2SrRpOWYXce/VT8CVWB
         9EeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNHtSsYv9lZLWr6IqdUETUaGpFS7ceUA/g6uclIInqRpquE4KZPX4015/Plyd2/l+CVQritDGa4NsnGUlIHjFkTrT4NIqnfPugXeqd
X-Gm-Message-State: AOJu0Yynt3+H+l5UNe9rwz+7nz3QQ34Im3odIuYwLRCVzs/FqRSCfjIC
	S2MN8KkJ5r1qe560P5AQvtMOWVrZUT5J/eiX4c8i6BmwsBa4O/wJOi3QlqSVRdvIk69Wa7TUT/a
	NRNOPnLBkG0P5xNvF4sASM4jHu28Pnn5acpHN5dThd/HdKgq7xw==
X-Google-Smtp-Source: AGHT+IH8DQAMUWESkE3uI4SAFspU5Lmkmnbb+Jk0Ftbm42szLeCxXAaqh0w+gS9vCMjP4HyEG3RJiRM+c5urdMop850=
X-Received: by 2002:a05:6122:1d48:b0:4f6:a7f7:164d with SMTP id
 71dfb90a1353d-4fad1da735dmr398339e0c.8.1723569416350; Tue, 13 Aug 2024
 10:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813163759.742675-1-yuanchu@google.com>
In-Reply-To: <20240813163759.742675-1-yuanchu@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 13 Aug 2024 11:16:19 -0600
Message-ID: <CAOUHufaqjFmeghdGvXNASWvjdK3n9y7MdzVFJfQFG486-P+Erg@mail.gmail.com>
Subject: Re: [PATCH] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
To: Yuanchu Xie <yuanchu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lance Yang <ioworker0@gmail.com>, 
	Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:38=E2=80=AFAM Yuanchu Xie <yuanchu@google.com> w=
rote:
>
> When non-leaf pmd accessed bits are available, MGLRU page table walks
> can clear the non-leaf pmd accessed bit and ignore the accessed bit on
> the pte if it's on a different node, skipping a generation update as
> well. If another scan occurs on the same node as said skipped pte.
> the non-leaf pmd accessed bit might remain cleared and the pte accessed
> bits won't be checked. While this is sufficient for reclaim-driven
> aging, where the goal is to select a reasonably cold page, the access
> can be missed when aging proactively for workingset estimation of a
> node/memcg.
>
> In more detail, get_pfn_folio returns NULL if the folio's nid !=3D node
> under scanning, so the page table walk skips processing of said pte. Now
> the pmd_young flag on this pmd is cleared, and if none of the pte's are
> accessed before another scan occurs on the folio's node, the pmd_young
> check fails and the pte accessed bit is skipped.
>
> Since force_scan disables various other optimizations, we check
> force_scan to ignore the non-leaf pmd accessed bit.
>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>

