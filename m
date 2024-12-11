Return-Path: <linux-kernel+bounces-442143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FC9ED88E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A05282E51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C271EC4EB;
	Wed, 11 Dec 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aadq7fII"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57161C5488
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952767; cv=none; b=l/Jn8MjREJLqilW9HsV6azg0/qFgdh2zN2gNBw5YNwHVwk2hHrM1NJZyuD7OZp9fv/k8e6Aq6bT86W3uCxPE3Bl+PjnP48WndJekXBDdQ9RHE+cTrAc7qn57IjQXV8VtHnpB+s4ZS0tEfq+RZ0Et7TwFI2goaPH/E3oFhC9wPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952767; c=relaxed/simple;
	bh=iQHe9o0OFC8o625cYkLtRXrWxS/+TJviekTccK7gui8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLMuvistT3fXQvyAyGTo9RBoA2UJqcswl6hgk1sgnFPcva1F0qWvqPev8CSzDIYTrfnnG6WkpF5g9zyAeytHTcDStUD5HwOS+2HiBL0SqDdo4NwHd2VnEJICGS/DPQyD3xQyCGNUS24dVuJtnid9NDQ50Db9ji1wYc8kZobaZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aadq7fII; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9ec267b879so1420146466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733952764; x=1734557564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R3OGAQ5vsTFqn13bOxJ7t9i7h4BntnMNyLupbofgMFg=;
        b=aadq7fII2fL8ex3+lDDV9EGkdTqfTzL/UoHTco4/gqmQDof31jhslLJUhnwAEJJ3ev
         ZfxLj5B/eXyUXVsacHR0gZXDCqINscDL/7WjGs66DHqppd2Oat9A7PkkdvvdtPpNINkH
         b8H+4n2MMuFdjQhINS7SuisFFWjilafN1CXN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952764; x=1734557564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3OGAQ5vsTFqn13bOxJ7t9i7h4BntnMNyLupbofgMFg=;
        b=iGyi9rLYox0KZKQiGQfuP5wr5UUcMR78SXI5raf9y4P4LIOgcp0Kk4CF+yOR8P+jeA
         DN59tWbuloBob71dhgi0oqZBoA9Tz6Il/uLCsY15UrtBbyxdYcj+E1ec5rmerte7b0cI
         AIY6AV4btr/6Z9IL8Vi7Y8nTtAo2fJvLePKLNF0QdVyuNaR+b6iGQq044t1W2AEtBzRa
         1VyL3QHBJEVrkzW4UaPW9KYsNWSaotoWL/9KXjcEDGpg1JiVfboHtep5KiMUFfvNrSfb
         WXbNie3xKGKwHGmcAAWoIRYkGw1lTJRMwKPfu1uST51xnRptarEd1EMEPiD1inAP3uFn
         IsAg==
X-Forwarded-Encrypted: i=1; AJvYcCXxV00jw1Vy7AM7QoIfzaw7innSY1jEpPb2YnDekPHpOLn9Q7lJkhXFTYKmQj5M6dbY/USb9qfzd+kBHG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfI4Kkznmxl4EVoJkn8D3+RJEDMiuv0CqE7w/hsokzBmwBi4Lo
	SMBbxi6pEgxRO92Pa1+VYop/sSX873CxRS0REur0J4Alas/JHhm9Ov7BiDehV3eWkFbDS/jQFEn
	t8G0=
X-Gm-Gg: ASbGncsVghOdIzVrLXxW2ZbEZUKLRVUmtz+VR/sGH2a0Cc3dO1wioJ5ul84a5IqYzZQ
	QKRH+IannU/4Ko53fsjgv16E5oqHqljcMIzYX9hTi0V/G2xrkT+HOjTEDjR+6WvF/d6Y0Fn1pYm
	azzIhgozVZmMPYwIwtJm7WqrCsPO9OYaxUnAMuH/522p/ZJSHSO9IzN6Zq9Emuu8jf8d2riVrVR
	yBrqguL1thZ+8t6GEj7b4g+V79uWdOynww8pOXrVf4+548AuCabYWxGbKEhQDsyOMzZ7hgVAp62
	EpQak1Q9PNRqY/0o6ZY8blQ0BbcR
X-Google-Smtp-Source: AGHT+IEPiwr+fqBqbWSBh32g/MuKTveHLsaEKZE1HDWRbuporPTHojvSeYwXB/c/kr8ZABkgz2q4YA==
X-Received: by 2002:a17:907:cb21:b0:aa6:83cc:7996 with SMTP id a640c23a62f3a-aa6b13b139bmr363323466b.42.1733952763802;
        Wed, 11 Dec 2024 13:32:43 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66ef6409esm655728366b.149.2024.12.11.13.32.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:32:42 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so1420141566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTPqHjJV4Nme7cWY9VGFUej0Bc47uKk6vNRnTy9qKNekuTw14zQui5hffE6YqJk3swoQpCh0SqYmpX+JE=@vger.kernel.org
X-Received: by 2002:a17:907:7747:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-aa6b10f5d3amr449688366b.12.1733952762458; Wed, 11 Dec 2024
 13:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675963eb.050a0220.17f54a.0038.GAE@google.com> <20241211200240.103853-1-leocstone@gmail.com>
 <Z1n-Ue19Pa_AWVu0@codewreck.org>
In-Reply-To: <Z1n-Ue19Pa_AWVu0@codewreck.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 13:32:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Message-ID: <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Subject: Re: Alloc cap limit for 9p xattrs (Was: WARNING in __alloc_frozen_pages_noprof)
To: asmadeus@codewreck.org
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com, ericvh@gmail.com, 
	ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs-developer@lists.sourceforge.net, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk, 
	Fedor Pchelkin <pchelkin@ispras.ru>, Seth Forshee <sforshee@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 13:04, <asmadeus@codewreck.org> wrote:
>
> Christian Schoenebeck's suggestion was something like this -- I guess
> that's good enough for now and won't break anything (e.g. ACLs bigger
> than XATTR_SIZE_MAX), so shall we go with that instead?

Please use XATTR_SIZE_MAX. The KMALLOC_MAX_SIZE limit seems to make no
sense in this context.

Afaik the VFS layer doesn't allow getting an xattr bigger than
XATTR_SIZE_MAX anyway, and would return E2BIG for them later
regardless, so returning anything bigger wouldn't work anyway, even if
p9 tried to return such a thing up to some bigger limit.

No?

           Linus

