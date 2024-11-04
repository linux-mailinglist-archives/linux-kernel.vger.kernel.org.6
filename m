Return-Path: <linux-kernel+bounces-395359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD79BBCDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2332B21769
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3F1CACE9;
	Mon,  4 Nov 2024 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVKp93oF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A61C9B62
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743613; cv=none; b=KfPvzHDLa6T253wxMc5WHfXN+GQpLL741WY4IsQ0OrBGLtS6bHMQbUgl6OHcf8BuNsemnEMUQhGSgi+u7Jbk8HW6ymSpH3BWSBkg0umdnNtqVHwgjk/1Se6UAmbXxAnKlx36QyrBTIDh7nXqmwypNJkHNd23M/t6PN1imSoTHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743613; c=relaxed/simple;
	bh=f1LuNbWhHgohwcA9vB/DncE5CodJ8RZlb2iGhbl0WYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOxvurMSPfeZmFiCnJUoerbc8VamKy0C83ahH4p/faEU1tl/lTCxQkXwFt27pmA+MQh4l8zfK910OZqzQfUwgeOM3CArzg4EiOEW3++XI/F42VGFKLh1RPoN69YL4ka9O0tezejDfJildCVY6bVYfczprc+o7PiYzfsyEp5uXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVKp93oF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso54906305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730743610; x=1731348410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66XTrEb8XaLsaKj3AWJmhH0Y8WJaTZ1L7Zwc9s+LDGo=;
        b=MVKp93oFGTl35Ou8Wv3WkQm9uiiGoD8FvV8KHqy47I74BVQN7tbcLj9mI6jiIh+9I0
         p9pkgyWWW4NK42qr/95mx/KWuQ95HAwqpR0mz2wsJ3Pf4N1p4PDsy5FmQ5VMIMxKR+ip
         cdMCAtGhWiORKjYtrDpwEG2Pi+YETFfUNWJH6556//bN6ThQVIDtbaiXh6OUUGW8cLEM
         5nutSoo2omGfaRrwZvezv9q/EWBzDqcKTJq/pnW0zfH1RvW63OAiBOSC/IUbDA1a1gZ6
         sUdQYjptMhjvRfzt9iJoyjw2QEA3iNP975e9Yr3QhB+D5h8rjfI6PS4Qp5w0fzrnDCeC
         L+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743610; x=1731348410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66XTrEb8XaLsaKj3AWJmhH0Y8WJaTZ1L7Zwc9s+LDGo=;
        b=wrAvD6vgNqk+WW/1KQODkux/Pf/uQ8VKE7Gkq+lCqZ31jiFzknXyGj24A/KwmgvcuH
         qt8L/1YL8pIc9fY/6uoSadBvIG+vTB3Cd/VzG9QNV2OGcQ+zjr6v6OSados9oja0l5Rl
         YrmFMf/7COFtgBiKZLCSegjtFTwKT8qZDgmLLXm9/wye75u9ZQL1Ry9amJY/x7QInL9U
         KtVsVtNQBA75IGu9PNz7vqv85h7nkHmIPyVfd3UdO3cSUYNylTEyDovw5TIqzQnS4TOe
         bHCnPHEVfsEHoqWfOdXYZJYpN00cpUq4PS8HekwJhRGGzCN5WKUQBXgrlDaKl55Y/HK6
         TiWg==
X-Forwarded-Encrypted: i=1; AJvYcCWPB12WJzzvpP4wl9zhx9GjqvQHVNWOVlUdTRq3NxuRUo9fm0kApXgxa23dS8uJA3IJo7lk6iPdhI7Uj1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPbCswKdqZHciMu3TmSKtXz5c6UQ065GLVTeH18hu8cZe6/NT
	NVh5pKpdaTNxLJ+29C0rr0q0DdhVt/EdQZ42qZi7oPNzzsnfhpbE80MW7bdhEw==
X-Google-Smtp-Source: AGHT+IFp7IQDS2hXq6mWxig9ITdshgx9KZGNhtvynyA1yZU4S6SmADpBS/0Uu6xNlztEC4/gEjlquQ==
X-Received: by 2002:a05:600c:a07:b0:431:4b88:d407 with SMTP id 5b1f17b1804b1-432868a5b83mr126649945e9.5.1730743610212;
        Mon, 04 Nov 2024 10:06:50 -0800 (PST)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca8eesm189508925e9.43.2024.11.04.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:06:49 -0800 (PST)
Date: Mon, 4 Nov 2024 18:06:46 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Message-ID: <ZykNNj30iMlB2KgZ@google.com>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
 <ZyjyEl4kzFXz7tTB@google.com>
 <83ba4f8e-44bb-4cc4-bf59-3e4051a67a9e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ba4f8e-44bb-4cc4-bf59-3e4051a67a9e@quicinc.com>

On Mon, Nov 04, 2024 at 09:10:15AM -0800, Jeff Johnson wrote:
> It has not slipped through the cracks, it is being tracked in patchwork:
> https://patchwork.kernel.org/project/linux-wireless/patch/20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com/

Today I learned of a new tool, thank you!

> The wireless maintainers have a lot of work and it can take weeks to process
> new patches.
> 
> Have patience,
> /jeff

The initial response on v1 was almost instant, so I was surprised that
v2 took much more time. However that response was from linux-hardening
guys and I didn't took in account that now I need the maintainer
response that will take much more time.

Thank you again for taking your time to look into my patch!
--
Aleksei Vetrov

