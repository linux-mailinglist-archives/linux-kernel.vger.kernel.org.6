Return-Path: <linux-kernel+bounces-372009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FDF9A4336
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FD62864E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57177200CB8;
	Fri, 18 Oct 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdUmnwqF"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AB133987
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267620; cv=none; b=FdKESCVYW86YP/JkCdnL/NheYh82EDIJ8cXLGoqDU/ijpONnHbbt3wcsd8WCGED3LZM2GlHAbLcqNycWjZFmi4rduYwaHzW4fw7WhKqTSHfF44ussSUz/RbeN43PGjZEQIBQlQf5L1t34vlr/M4jPvVm5ifdoT4uJxGH4eYwg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267620; c=relaxed/simple;
	bh=8UQAmDigmYSJcracBJQTIiTkRTICC3NZtqaNMfyfesA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jI1e+qRBAWwJgd6lh+ydReyE9BcrcnmYgKi+0u112RjaR3dOyo0GPeFDbfhu1FNEvwd186gdKVSmvQ0LZE9Hhs6jAxZhp6PDvoQlFe9SEbDyhbmq4Nsj1OUWUUWVvMZwaXyXRoJALJh1hBowcgUbLmeCt+ZGzwXlmznU+S+qwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdUmnwqF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b5affde14so16427255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729267618; x=1729872418; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2oxb/SAQUrEM+BNO0w0IMGwQpA+53ixNq+VSmsiWddk=;
        b=cdUmnwqFkHSLTTL9mZgneLpsRC/rKQGM7piCiqQ2PfukNXvrlhkB08Ep8zLg9gRHCh
         gbAUKV376BgkQwfCE5GybhZQpvgMLyvuqJOx+JKBJT4rIIUDFvL4c6f2LOdfFgw4gOwY
         dg8mzgyRWrZ5M4lAYSVlBgbAopkXsE5D7imk3pKRgoNoLlMZ9gzCBSjGnz98Rp7Amoud
         69YJz5NDzw2OrJEg88JgOu2sGaf+NApEKBsKnP2S1AT2JjflyUpZNYkPNcR+UnPDk6IJ
         e3IX/LUp74Ea+BS9dJyuZ/nrdq80y60oNxhh1pE3Tq2lN+N9kduMEQ1kaoU3sgUnDtJF
         ohnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267618; x=1729872418;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oxb/SAQUrEM+BNO0w0IMGwQpA+53ixNq+VSmsiWddk=;
        b=v1UsYIqis62k2lDchG2f9HJMDCxSoGIGVKF9DXVfVhs0WxLT4XKjluDdoL9erRchcp
         h+JwM/BGar4R3GETvqGBP1jWkYWKwPMrUX2ObI7g5qTJW2lG8W0OqWkAsUnQY/fuUTNi
         BRQ8mmbk2hMiD7LYhpKC+jo5baa5jm0TueJRFJ+L7APj3s+pGOiiAC27pnoxNpnComqk
         gq50i7X5jkHvuUYWtA9hPmVhDFlK3R36ooO1gctvES6hD1E/gLkorIRVvTpNMDmDR/2L
         5uZxKG9TmgG4Qtc+cYBYDXPf0bwKc6MDbB4zxmvCWA/Dhj6FGKfELzIThiuvqiOWK8p0
         K44Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbqjTSu6bfQwE/F3TZ6UudGeVAJcmAKp0FjK7qwPZEtRdpoUwxc08NE4kr/XfONCGFfAeFG/e4FAGw+eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleUfKnPJhoISrdoVmbFBCOyENP0glpKC6MR8eMeU4Cpnp6TXa
	uGwf9st2nhBkpVdHBMl405CY7wyCIiFP7UQyx7LvPtOEc+EVMjam
X-Google-Smtp-Source: AGHT+IHH+8mnLv/RNwmJofMZH1/UlAGTE95HlSmIfUGjBIn/0P3/HWerod9ADou0u6dLHFU/8kiQBQ==
X-Received: by 2002:a17:902:ccc8:b0:20c:c704:629e with SMTP id d9443c01a7336-20e5a93e82amr47973845ad.56.1729267618038;
        Fri, 18 Oct 2024 09:06:58 -0700 (PDT)
Received: from dw-tp ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fe68asm14345345ad.237.2024.10.18.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:06:57 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
Subject: Re: [RFC v3 1/3] fadump: Refactor and prepare fadump_cma_init for late init
In-Reply-To: <b66e69a9-7098-44f6-822d-f19bfe85117d@linux.ibm.com>
Date: Fri, 18 Oct 2024 21:34:23 +0530
Message-ID: <87zfn1gzy0.fsf@gmail.com>
References: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com> <941875f7-0d7f-4ba3-bc7c-7aedc3b20dae@linux.ibm.com> <87bjznyliv.fsf@gmail.com> <b66e69a9-7098-44f6-822d-f19bfe85117d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Madhavan Srinivasan <maddy@linux.ibm.com> writes:

>
> Patchset looks fine to me. 
>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com> for the series.
>

Thanks Maddy for the reviews! 
I will spin PATCH v4 with these minor suggested changes (No code changes)

-ritesh

