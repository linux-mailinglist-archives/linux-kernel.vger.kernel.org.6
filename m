Return-Path: <linux-kernel+bounces-447114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ABD9F2D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E1A1885389
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05FB202C58;
	Mon, 16 Dec 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4KnY6+u"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C25203D64
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342950; cv=none; b=rhBkEJ0Zs0BYzK4Yml8FVaCUd6dgbW7+TmgcTvTV6mFSyfJdVkTtU16HuPchQgA78seJrsqUfqEhGcYW+NO6urbLqHWylOB4+KtVwTffLANVaMb8VlBDN6+KJz1y/0XyAuBa90555MlC6EyLVmh7dqeH9dnavGjnP7cnOl0Vi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342950; c=relaxed/simple;
	bh=kwbicLQAaZ25kUVEuKSW5PKae5KTmR13E/wKvhnjD1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juBZRZw+o5OBhZjZ96LgjewEisPxxshcC/c0QdT+umY9/HN6zF4fjSlljgZMh/YRW3gplSfaH2ierLKIu32yNsE2y/xaC/ggizksZsGMa7lb9IsVv3DNd/Llj/gGLPEuIjBsRo7PltX8MmxPmpqRyH60IvZZrTqPmlSn1mKozLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4KnY6+u; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679b5c66d0so383061cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734342947; x=1734947747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kwbicLQAaZ25kUVEuKSW5PKae5KTmR13E/wKvhnjD1c=;
        b=M4KnY6+uj4muv/EYfc7oo6TcpdIVp6pQ29M9E7rQv4FVVVHP15F024EZ69ytkkSTAf
         ItMHjMUHV7XvCAuTAkfkUKWA+6hVg03ieaO/G+94W6j6QI5W18iC539qXWIWMCyp3zPx
         jdAvBGWBgwl3FF+JSKBV6M2OxV8nLqGFLcKNgIJjUMFvez4qWbYewecouz3EAkkeLDw6
         u97mnM45j5Raa3UWB4WJha1yzOOMtwGHsOzUgi0Y3d9SwSp6Pb2JE1G66+XSKz3ngNFD
         Kzl+y2GoANtFqt8IMejbJfhyRljMUtoQIqTSi9jtwtWNj3/t1H4Du/ghLWtw+Id8iRhC
         59+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342947; x=1734947747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwbicLQAaZ25kUVEuKSW5PKae5KTmR13E/wKvhnjD1c=;
        b=VRT4MgFOJ3pGp3B7nmPlIi0ttDVd5xN7zAbX/ecmGkyxOYwJFmaMUVOu9GzmyxZuvC
         k8fuGNRLrsXBVs/TqsVoo6J5QTJQaKvIUIVzAno/HSMNrfdA45jYp4mFAiz1jwygUSEE
         /YbjK92B1OzIgZWs30JcKs+NAtztmtL5riCjHkbpBZRJH21aW96LxYf2koXSBtr9sBdV
         tIWqPfqpQAbjzKpcaP7snMVbcrwjulSrSdX7Vbz80R+NaquFvfkZq0/l53sFu+vvXZXV
         EOn41mDC2ktkmQdzSwxsP1pPBqANy8a83Amf4C4sr/GVfAENnBFXrfZGYKi4JaXZbGzw
         dAAw==
X-Forwarded-Encrypted: i=1; AJvYcCWWxgSpWZ5SLoPZ/Uwhb4iJRfQfXFXGMa7dvcmCbKNAhIM1b+jVeIE5h7T96OgsWXWxuVhVryrbP41yShc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsH1sFJR5Jo9yV2HAiZpL2nlm4vvH1kym8d0fIFdrl9lzWNCRc
	umQcZHf0HVhtvR4MtdQeT7IWsA63mMg70IyNxatKwum/+vCgL0fTfrAyDOorNZA6hagu9ROP8OU
	pcMuzVIGYe6HHLpE1F8+HC6zTIlGYQAfx6Ddl
X-Gm-Gg: ASbGncu+a4FOio25189W/RCxaIpR/VdO8D48mp17wDTSzFNIs3eyByqwmofXd5CLkKZ
	nJrypsP372YJrd6wo5bGmhZU36ybOMq6FtajumdQy8B6H1KNUxDFGkV1T5xifZZtp6vDA
X-Google-Smtp-Source: AGHT+IFhMvIXdbRZOcnTLEcbNjsVH96/VrL1zhECcx0p0tNYZx6zpfl70xXcIg6493jrc/wn5pPrjVOSlsL1jiDf7bY=
X-Received: by 2002:ac8:574e:0:b0:461:3311:8986 with SMTP id
 d75a77b69052e-467b30bdbdamr5040591cf.18.1734342947368; Mon, 16 Dec 2024
 01:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-objtool-strict-v1-0-fd388f9d971f@google.com>
 <20241213-objtool-strict-v1-1-fd388f9d971f@google.com> <20241214003605.gwlfukj3tdelx4bq@jpoimboe>
In-Reply-To: <20241214003605.gwlfukj3tdelx4bq@jpoimboe>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 16 Dec 2024 10:55:34 +0100
X-Gm-Features: AbW1kvYR2wFvoUWGEr5jX5uwNIWb-PWBSg9rh6xevYSQ8gDOUgZ1biEtXZ_I3t0
Message-ID: <CA+i-1C3WmjY6rrg9rTpwctMdYKB+u1=dNHEfZz6zPU7RyHdsKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool: Add --fail-on-warn
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 01:36, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> How about "--Werror" to mirror the compiler -Werror option.

Sure, --Werror sounds good to me.

