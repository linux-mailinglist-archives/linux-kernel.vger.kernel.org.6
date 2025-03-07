Return-Path: <linux-kernel+bounces-551459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92129A56CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849F13B55A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7752021D5A9;
	Fri,  7 Mar 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b7uVX/bX"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284821D3FD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362969; cv=none; b=PnKxhbixsLK1eyAJfN3jR86Smuwx1UM/cB8tsGiSuyPvvbApCRbpwKU3zoW8fcHaVa8kfbe9KTLGUhoXZIoexxF7s4DeAxQe+YBzbTZOIZuiFr1CckIeYN9fYq4yOoXu0XgRdWnNpa2w0LmOjeoNiJRvgE2lV51K0d0vyfVqn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362969; c=relaxed/simple;
	bh=1lADKmgBwBRegrRlx/3gxaLYiemyRMKrvd8ujRqmPSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMVVm2ACPThVR52t5ZcV+PBAHO8JmbPbwR1MPFe8Yr2cBSiR8XJTw/wufmxL5OeZ3RHuRsXxVs1ayCrYXxCtOJQHcciCuPeE6JSf/9DWURMIuBJrCbHBVZerWE7OrkGlUgYNkKye2aUjMGIJaQFOnkOc4OS5u9Gsc0m7ONiZs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b7uVX/bX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be6fdeee35so386403185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741362967; x=1741967767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0TiHKXqWd6IMW2qctayQwsULMdhPuc62rBxsjJYxs4=;
        b=b7uVX/bXB4cwo/VRyjvvD6+fjKhV/M3aTNMffS32CR+ZWUY8kdQwsEQv7PYjgUztVT
         HXZ5/dSU6sPzZ7/LB82y61YQmCwlkXrMFFnOaBEdxTDc0HLKVQnM+mx/h+ajKtMSa+3U
         pg5OhCg6tAE/90tnAPQaeWzyImM9x0EnqDNhKjuIlmGqMHV5UK1fqw6bA/kHgCoF7Wgv
         4TQNrHH+aQtleBx7v4pVlLYizx3zotz1SeT8fY9gF5FO8qhFpRSHwBv4ErhKJaGqOlFO
         4FZ2oR1My+BVxL12zP4xL8lL9naPzvV6FEgtNiKPRoFt5G5C2k3Q90IdQIHzXVquIF4H
         r1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362967; x=1741967767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0TiHKXqWd6IMW2qctayQwsULMdhPuc62rBxsjJYxs4=;
        b=hIWUPV23H3GRWw3aVC+6mUGS0YcgqfDeQbR9TduOrbLZbLqcgCQaQDtDuSjL23i92T
         J//ovpbrso7iyOaqHFAbMOSVFXyxFMeEbccMWZfiu8pZhg2O3W3cMXp4n/lGJlMpQk3q
         DFYouVzsBRVsn3Rwh3NJmYBjt23SH5ougwrOMofSzNyVK+dg29no66TdC4Vty030vCoy
         ucf4OzL+Ed3ygkg1Z4N0vyRBsbbn0VSsqGEZxgRk3dIBDpy6cujC0xMmANuj2ISr8hWK
         B4G58NPH/TUonB0vUNQps18tEgETBZC9pzOJ64Y9vg/DPjdw5PcUJhcmxHeQzSKTTij7
         Lt/g==
X-Forwarded-Encrypted: i=1; AJvYcCUJViMmT1C+GG3mPB1qawde+0EWGZRajAEA74SVsljJLgbgXvfpguOfWHoC9Rl/fzqLUdBY595KleguPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0IiXOpUbWEM863yvNIbz/NVKil1CnTv855mAhqmjr5+wKmCj
	p8r0l1Kp4ZWCGbg4U5VMPux3Ws0/H7riPu1xwqVOyxAOYTg5ubsEqsz54TTd3fM=
X-Gm-Gg: ASbGncvXBFIYjx7u3Dk/phIKQp6wDS4pvhGhTYn9Ls9D4NDKuSPBFRrpjF/5soTseW/
	XsDoPfAmQhfCKi7TQj316anUyEI+BVTJAsNAtFqh0R/WgpToQm4kjWt6+lwD14Cx2qUh/Zbeb75
	ESWHRawy2xh950/akzpxYN4cD6nRrctviPFu9fr5/XC0XrJEEKujG/q3wV1ura0855P+EqWaxgI
	kfH3WtyyqHdiRCEdfdjmFLfC1pCzwP+QnRIjeLR41fXFt57zmxP0YEHB6RtxEsxFl8HODR1qFsN
	pejhILwFtL6yf/JOBAWszvX2eShlXwtSXF9tQudmaIq6NNb3KoHUIA2yRpbqUvZuI5FUPj3/UfP
	7h6ubhx93HIoHV5N/DsjB08UwEnk=
X-Google-Smtp-Source: AGHT+IH7XtAc5bjChzL2elX0bnoZp9NgerKacTnFzM1lw35j/6Z2QDCgMu/vxv1bPHPCUZ3/1APJLg==
X-Received: by 2002:a05:6214:29ef:b0:6d4:25c4:e775 with SMTP id 6a1803df08f44-6e9006203a1mr52531866d6.15.1741362966855;
        Fri, 07 Mar 2025 07:56:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c4cbsm21148286d6.22.2025.03.07.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:56:06 -0800 (PST)
Date: Fri, 7 Mar 2025 10:56:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted
 interleave
Message-ID: <Z8sXFGBYFlG2Z1s4@gourry-fedora-PF4VCD3F>
References: <20250307063534.540-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307063534.540-1-rakie.kim@sk.com>

On Fri, Mar 07, 2025 at 03:35:29PM +0900, Rakie Kim wrote:
> Unnecessary sysfs entries: Nodes without memory were included in sysfs
> at boot.
> Missing hotplug support: Nodes that became online after initialization
> were not recognized, causing incomplete interleave configurations.

This comment is misleading.  Nodes can "come online" but they are
absolutely detected during init - as nodes cannot be "hotplugged"
themselves.  Resources can be added *to* nodes, but nodes themselves
cannot be added or removed.

I think what you're trying to say here is:

1) The current system creates 1 entry per possible node (explicitly)
2) Not all nodes may have memory at all times (memory can be hotplugged)
3) It would be nice to let sysfs and weighted interleave omit memoryless
   nodes until those nodes had memory hotplugged into them.

> Dynamic sysfs updates for hotplugged nodes  New memory nodes are
> recognized and integrated via the memory hotplug mechanism.
> Subsequent patches refine this functionality:
>

Just going to reiterate that that there's no such this as a hotplug node
or "new nodes" - only nodes that have their attributes changed (i.e.
!N_MEMORY -> N_MEMORY).  The node exists, it may just not have anything
associated with it.

Maybe semantic nits, but it matters.  The nodes are present and can be
operated on before memory comes online, and that has implications for
users.  Depending on how that hardware comes online, it may or may not
report its performance data prior to memory hotplug.

If it doesn't report its performance data, then hiding the node before
it hotplugs memory means a user can't pre-configure the system for when
the memory is added (which could be used immediately).

Hiding the node until hotplug also means we have hidden state.  We need
to capture pre-hotplug reported performance data so that if it comes
online the auto-calculation of weights is correct.  But if the user has
already switched from auto to manual mode, then a node suddenly
appearing will have an unknown state.

This is why I initially chose to just expose N_POSSIBLE entries in
sysfs, because the transition state causes hidden information - and that
felt worse than extra entries.  I suppose I should add some
documentation somewhere that discusses this issue.

I think the underlying issue you're dealing with is that the system is
creating more nodes for you than it should.

~Gregory

