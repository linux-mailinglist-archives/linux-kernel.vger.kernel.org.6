Return-Path: <linux-kernel+bounces-528693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B60A41AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA0F16BCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C324E4DA;
	Mon, 24 Feb 2025 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fo86Tl0s"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78C2080E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392734; cv=none; b=rrw81NzwlMuVllVlAqxz65vqT91IL1ZFSZnMCrOyQxtLQbtFvtsE0iYi26LwzT/MxAaMyizg9tmdpRlLSEcC/qwtmHTB+Gp9Ewb+lx4E3A8UIrlx+J/8E2rCDS60/ZDpME6Bws1n6KZJ/xhPNCOD/NQgOiS93P+xhqhLDzwQ+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392734; c=relaxed/simple;
	bh=i4eleRcznfjhdEtYR1eZovpdeENk7cHdBNblRPiSyMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZ+74KzRGsc0bvFLJ9X4/lqNzbq3ekt3zx9KTyCbejCLNWjEk6UJh/6Kf0oE8U0P+KpdYzO5MgzqLHYhbzVOTqn0Ab/qwKdjVPmLi8oW/cj7302RdWQmcBVy8/aAOOqs1Wz+k0UGYNcUIw8bdnR7RZxmU+9FFuzXmV3klzg7HVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fo86Tl0s; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f1dd5b80so333731cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740392732; x=1740997532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4eleRcznfjhdEtYR1eZovpdeENk7cHdBNblRPiSyMY=;
        b=Fo86Tl0skQYbDB0GFyY3+m4pWnTLt4qjzUqbdBmZr2oyaPJWoQ6+2gi28xnR4kePog
         VkdZmmJr9YvRsT8wrdBpAoshDQBlwzMQ9ToXkOf3nZEJMZlLwiJ8BZVD3L0WQqSrhhRD
         loCWorwWpT/3EvDDHRoiqL3KbpbVxNZp65DQM8Xw2QZH5kjuEvB1/96R2cmtFzhdQRXZ
         dXBntlM8sTuzgR4wn07zJEk0MoD/oQe68FtyGnjj2UAYQ8SaMG8yZznDci4pRQFNAS76
         dn85OQpIjBqHOk3Ke3B56Ga+esH7IddOEnxOuxaGknJnrIXF0Hr6e0k1CsfLa6Bq48hF
         QpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740392732; x=1740997532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4eleRcznfjhdEtYR1eZovpdeENk7cHdBNblRPiSyMY=;
        b=KEIHZqVfMzKea/q9+gU6pkacpJ6uakKNA78HAb0+xk0xAMdDlDrHGYMLvURSAmLiBN
         +U0h5oM8UmfVi+heB7/3xjA1hHGOM4uVXZpGcjtktoXIJltU0joLjKSjeMArQRfjEc47
         g5sEPXhTokLS9pcqghwTRHMjw/TSm1u9INnt7KborcMgNPZ7mORE6I03ban24ft1Cr9p
         yEpbZijkOJlRB7Oi33AloWHEFz6YKIGoXRXS+kTx8JWKNjrnNTetTKTXZ8t4XG/pUg06
         vreW9DhDCc5Ji5pgw4V8EW/WBcGBXD+OIsWAJ6YRMNt2h8a29gHgpubX+XnKtRiQgHHf
         u7nw==
X-Forwarded-Encrypted: i=1; AJvYcCUzapqpV1NEq2nURYOFw26+Ejte1vdxRPCafspiXVZQt1zGk67ZcFtgNZebYZDsk9xY2U4m/ZUEKK3/KkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWxw//ZKvlC2yDMHQQB5dnQzllT2PlELFBauNgu+wFjcvue1b
	sojGl+S0A6w2nIpVaeos05/qPtKCxQHCbAonv9yBcjjGTEtdjCQhtO3MRDuRhcK3QOP/zoI4JoV
	0GCDOZvqaA3j/732z2LN67/xkeELGPlXsETSD
X-Gm-Gg: ASbGncuyxYC9R83gEgSUGO/id3uo2/PVfI0xzhFZ/Cdnqu5Ep+VQyCetFwBF25FgsES
	vrDOqt49BZL0bpwdespa7N40Z9bHhh8ma9T0hGcsjxshFHrLbzAn7mB1k/FEb7ge1a+D/1g1+Yv
	onshGwfaI1m1Icb3JolOjk24DjnXEIAh2h9nBUKQ==
X-Google-Smtp-Source: AGHT+IHcORwH6MkXUIuhNvKpirxHiqnifBvxkOChYQByYI8hUWdzlbaftAH/T5c5oza1wGn0qb+0RWy8+yWXJkLeVVE=
X-Received: by 2002:ac8:5912:0:b0:466:8887:6751 with SMTP id
 d75a77b69052e-47234ccbe60mr5534931cf.23.1740392731839; Mon, 24 Feb 2025
 02:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com> <20250221-mm-selftests-v2-8-28c4d66383c5@google.com>
In-Reply-To: <20250221-mm-selftests-v2-8-28c4d66383c5@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 24 Feb 2025 11:25:20 +0100
X-Gm-Features: AWEUYZmHq3d45n5Wg3TPcz7MJBRGHJ_DS5l_Brf3CVevVsclDXFs37_wvvoTAUo
Message-ID: <CA+i-1C3qSSgxJKREyVxFqCwZxGfZ+2962P5fKMATYFLGFb7fWw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] selftests/mm: Skip map_populate on weird filesystems
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 19:26, Brendan Jackman <jackmanb@google.com> wrote:
>
> It seems that 9pfs does not allow truncating unlinked files, Mark Brown
> has noted that NFS may also behave this way.

I have not investigated at all but I _think_ over the weekend I saw
ftruncate() failure on a QEMU guest where /tmp was tmpfs.

Most likely explanation is user probably error (like /tmp wasn't
actually tmpfs or the tmpfile() did not actually come from /tmp). But
still, maybe just waving my hands and going "buggy filesystem, ignore"
wasn't so smart. I should actually understand the problem before
switching off tests.

So, I think this and the other "ignore on weird filesystem" patch 9/9
should be ignored for the moment.

