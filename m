Return-Path: <linux-kernel+bounces-529851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E40A42BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5220B17A3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84597265CC9;
	Mon, 24 Feb 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+dlz1gK"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64C11185
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422555; cv=none; b=b/YiWZrtmjz9CXFK3u9zmghVdfLjpo8KD1Ck8D5FPfL3I0VfB8E4FTZV7uM+jEIhleOyhNwO5SSEkMPyeigUZX10IPi32jIUtrizxfpe99ynqUZD84FihT3bxcTT89IWjXBVIlI3kyF0emLxR5283EV0vaZ2uFN8P2YgjvDCZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422555; c=relaxed/simple;
	bh=AH4casPf6/DDUKi8KsOzTAWYqkuG/dUYuR8BH479UCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GscCRn3/9jfv4UwmJdx5oYrDAZy5Y+SB44H6F3BuzOMO+x5IAftSR7RoqOjA0DgZx5G/whTLhSJRiE9TPPl5gaxIt4asUNVCxW1/WV5DEbBAIUQxldwS7HAndfhg1WI6Hn/TXLmBJhUulLQ3dFx33DEys39pmfT+kljWMRVmDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+dlz1gK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-472098e6e75so38741cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740422552; x=1741027352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EuAQyl7XnaQsGehxxZgOv7ogE9kkHgi56Hln0LhoXzU=;
        b=K+dlz1gKt4oViMdFrVZyayyu1IRN0tsVlQ4IUrlhFAAZJLjkTo47Hu8U4IkHsGzQNH
         R87uvp2UKWiVPORIwRTzd7SCR54PNAFRf+HFviXUEiHnaT2C7RtxpJ3akidzfUtcLr2h
         syXUeGN3aYYURqfbAVDZ80hTmXf8TAFEv0tuE1rTos4ZfHE22vLoqTO4o7q518IAhuY8
         J/lCfj3SZnNAEdr4Xh2Gou4ub1VeufgE8T9rRo7q81KizUR/WFPbMjgA15KRRKmlFzBr
         KcwiM3QoIZv4EghHpvDVgeFiVeBimE+6Ix27KnQOmfTj9Mcg9dagZN+AMRZuaULByEWH
         nf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422552; x=1741027352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuAQyl7XnaQsGehxxZgOv7ogE9kkHgi56Hln0LhoXzU=;
        b=j2RzUPFuBpKntHW2x1CQX4uL69zh46d6RPwMz9MjwI/B66eQ8ThkE2GFGmFDuMG8Hy
         KmW3Mm7pTV02DSN2RL5LpDL+R2vWXP3Yyf819IvjC8QlV40GHMWAHRgfcxh8ucA6QezJ
         5hiufbggPjOjvfQw+eVibUJUxmLzCJSYpG0jgVG963Lv3gaZKnF0VuLz/1lXjnYV0wmk
         9RYJK9NYHnoWENj0NZBe0lMOxRC7kTbQUrslMX4g4mrBAiRpAezzAivHvK8ODTdg4wc+
         vxojxmf7WdjWVbeB/P2XbMmOh+OWt3jSsbXM436hBYVu2E0S86ZXzBFY5ptULpmMX9WR
         DMWA==
X-Forwarded-Encrypted: i=1; AJvYcCUeo0UlZCCFYh5XrMGxy1TbbwLieMyCb5lpUai0bPM0X8xcR9lxJORGcgG7C83yhIFz6c7AFdlLBU3tfDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE1FJ92tA8l6I5T0fMQmk33Agxd2IobPBnnwr3NUyGdoFU7NNO
	rCevVGxN3tL4mey4ivpNwn1p2Zy5mKniTjLxe9Et2/boguKx+BAFi90mgpUPKxJ/K5eoKpJUqaY
	+jL+BM4we+Q1l+xZB1BZRk9UNHLHf0FOZOyaH16xtvWkrxfpo++MR
X-Gm-Gg: ASbGncuDzZ97iOqRovsmYGrGFgNpZ7Y5Bg48QT76gxqiwqviip5k49t6tpRkgrtHApz
	XWVuFrpEvM0/f6mnHGZtubI53AkBWpjMp+dBChkGOY4Taz1o1meEhE+06UVXChjdl2S5CCmTIdn
	klF43L4KzebmeaacnuZs80+7taW0BVPQMIJij7sw==
X-Google-Smtp-Source: AGHT+IEoGcfNcSuptDf9uSVbRQnf3h3SPFcv/1nuGHOd0Tc8j29NqZ2LvylQ3qv3adysrhoE7E71DC8ULhk/C59cJxY=
X-Received: by 2002:ac8:5751:0:b0:471:f5a4:548 with SMTP id
 d75a77b69052e-47376e5b15dmr606331cf.6.1740422552148; Mon, 24 Feb 2025
 10:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-clarify-steal-v2-0-be24da656764@google.com> <20250224-clarify-steal-v2-1-be24da656764@google.com>
In-Reply-To: <20250224-clarify-steal-v2-1-be24da656764@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 24 Feb 2025 19:42:21 +0100
X-Gm-Features: AQ5f1JoPcttjNCx9C8bx9cArc3eGSQlcqi1K9JjnTlb9vIuH9ycA3afS5xfXM5s
Message-ID: <CA+i-1C0J5DiFXB3begMqe+TeuFDHqaGc1cg5C9z3=_ue6q0KLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Clarify terminology in migratetype
 fallback code
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 13:37, Brendan Jackman <jackmanb@google.com> wrote:
>  int find_suitable_fallback(struct free_area *area, unsigned int order,
> -                       int migratetype, bool only_stealable, bool *can_steal);
> +                       int migratetype, bool need_whole_block, bool *whole_block);

Agh, sorry, I was meant to rename all of these to claim_block.
Apparently I got halfway through doing that then got distracted.

(Literally the whole point of this patch was to clean this up, and I
somehow failed to actually do that!)

