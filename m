Return-Path: <linux-kernel+bounces-375956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8B9A9DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F57283ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B615154434;
	Tue, 22 Oct 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KBgey3b/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB913A87C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587642; cv=none; b=jc6yDUQK/oc8wEeFYwePwZY3cJwICnlSzFwzgyPpuwX8cV5OddeXbWkO3NNtqoDA3ySv7WqY3ptVgpHZuT+meSqCaY4kAG59OvW11YeUbe2UF7usf6vds6MYjjwWINmt1c5b9Hr8WR4bRbT+EMnGOhUasC4fqop47BtLQ0sCx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587642; c=relaxed/simple;
	bh=pAMUEcrcBBsjn/My8edrOsqWlD5Q2CpOfj3OFx998zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUOCYKFaDhDDjSlwDE7hu/W+s6M89+QBBwrw5Cv6q1AeCz4HXA7nqNPp/UZfT5mEUjtYtOvslzmep77T2TVwM5+nBd8yZFBa2raLa39pbfD0gUtvd+GA3IbPThIAQwtVz5wf+8/5K52jhVZvtdizMayqZeqSXAE8nloHZRCYGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KBgey3b/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315eac969aso31930425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729587639; x=1730192439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hFaN/sAZ28IQv/kQdloNCB5hICOmfCsUB3mKiGC9T4=;
        b=KBgey3b/9Qar7Uk3cKT6KNPur8uyJpcufAlborSNqSRIxq7sfZ203o+a9UCbhOZCTx
         fYWRJw7lEHv2g3IQy4En8xkoYvcMy5TX7ETmj+Gi4T60v5l8mCLFcnHa2uC5z66dgmR7
         xLVfFRjqSGxDEPi5h3YdQoY3KZ5T5Xx8F68T9Dq24P0Zo2RIEvHaJzM1qapttzq2O6zS
         fefusX4o/C4n0H2fgTBKG/0S6yNi7fH3ituaqPlsS5MI7lIPDUfYr6Ky1Tn9nPDOBhmN
         zf6FI1shgoE0N4/40F0qvQZRFsoxjBAeZCMbrkdMZwUlKUYVK3di3ijF13shLjwF/f2D
         Hq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729587639; x=1730192439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hFaN/sAZ28IQv/kQdloNCB5hICOmfCsUB3mKiGC9T4=;
        b=a2FuRjfwqoJjL8Nu0/y1/Xg4MwzSuV0EDu9LDHySziT+JpfI2RZ9BD7y6G76mQIPo2
         v1XzJcCkgN8Py96EimBs9lSCxqvv9Qnl0/oPTTjHYIovPUpYpyShiR2KCUCj7Qh8Ossp
         pEiztnVP5qwDnLhtc6jfKltebySzubLIvrmh+Lmh1YCp7Py5UM5+yseEpGxABsWUCZXy
         CWhnLMcGm9+mz0zOb4DiCkL7ttC2e6hZmm81GIYQTymgPAXzq31j/gAB5Dz42FrLtjxJ
         l2gzWD9cgBOGIOu99KxNAaaUk064GCnJ8BValbp4aMd5IkKJDBf95AXQUjUqGBQZdxF7
         Oatg==
X-Forwarded-Encrypted: i=1; AJvYcCV3w6FLbzQkZIDWnHruSrXEJt2ZC8j8tgbmvOPxfEGMHqhEItAn0F3Tee8lH7Q+3v9WaOtVPwLbv5BbsQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSlfqPDojYzKx9wiWd6kw1jrrAl4WEcQB0o4ebJE68dII/hCk
	NSn5G/FZybDsqQ1HBVvMmeDJDjQkmoMaGqvKPjrSS6deflGxgSuSSFH+wT/5W6E=
X-Google-Smtp-Source: AGHT+IGBvL9DpIJxEKjzegaN2LTWBJWj4BRs/DC6X3KS+aNbMbld2ASHJC5m+D7+R6fz4Usrb++PBg==
X-Received: by 2002:a7b:c051:0:b0:431:55af:a220 with SMTP id 5b1f17b1804b1-4317bd8e649mr13858785e9.12.1729587638519;
        Tue, 22 Oct 2024 02:00:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58f1fdsm81759835e9.28.2024.10.22.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:00:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:00:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Michael Vetter <mvetter@suse.com>
Cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] selftests: livepatch: test livepatching a kprobed
 function
Message-ID: <ZxdptC2sP8z9wiYi@pathway.suse.cz>
References: <20241017200132.21946-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>

On Thu 2024-10-17 22:01:29, Michael Vetter wrote:
> Thanks for all the reviews.
> 
> V5:
> Replace /sys/kernel/livepatch also in other/already existing tests.
> Improve commit message of 3rd patch.

With the syntax error fixed by Joe:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Note: I could fix the syntax error when pushing the patchset.
      There is no need to send v6 if this is the only problem.

Best Regards,
Petr

