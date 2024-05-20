Return-Path: <linux-kernel+bounces-184209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB48CA456
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618AF282305
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0E13959D;
	Mon, 20 May 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FC4J8Efy"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16671C286
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716242747; cv=none; b=e4Xv4hoqawa+oEedyCCN+MqRl/WGQid5mpvBkSBJJ38QW722GqdEh5d542fpcb4RhmtPJp3sc2hc7XMjPVPMEZqVTzFjYYipMipydxkmGgYAIX1eodhUeIDzy+lKJf/ogzUnyUtTTNBNn0f2WvRon32sViZk86gs6GYvqXffthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716242747; c=relaxed/simple;
	bh=4JZdz/1D+d0zQQyDQvVHptZ5R9UfQntpoUvU5SuzHqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDo8PFkQzWPwWCG/W8oGzOArkeNrvJqXbUnDz0LW+cVSUc9TB6fxA52jYZiPN5J+/hom5WUzeVqdVwmnYFBk5lOtv23Cho2xuxAHKCw47Aa8VpLzFfrcFgPQNCsmrz664zF2lJa2uY9YwE91erEpICL6SiJi+rV1nReP3NANTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FC4J8Efy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso8867351a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716242744; x=1716847544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5k5eJmbzJa61ZoWDHg+7VWIVwbJtoHtJlHDNGFuDR+E=;
        b=FC4J8EfyNxDSU/f907zrY40tqmOXhCF8tOzhad1kJc/ZxRqn7DOfgcdPG4FreRzHV2
         Jwoapdt9mJRwPE4zwetIH2zUE5fE8Mz0Ty9/PXzx13IkxGuuG918ObE8WJDTpSLLBezI
         ModFMvc2cF6zW4eta25/LyFMlZbw2cMTVZzP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716242744; x=1716847544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k5eJmbzJa61ZoWDHg+7VWIVwbJtoHtJlHDNGFuDR+E=;
        b=tn5xUuqiPQ/rhUS3Hax0hhnCRqVs8N7EzmB4Rb9F1oKIz3iu1yphp6fQaubtrpL6vA
         JH6ycg/e/J35M1dVbRt+56kzAzaSObcP+pwZTn7bu2yrgY2bpTWn8TnvQkI5z08NzfAw
         1uzbotN5xFSEm2DkslbcT+LYooCGYbmyhSxVQXSM20R1bygrilRjBd3feZ1Ya9AIpzte
         HdqYMikUOcTTJNapggU2mwEmiL0sXzGWYiHrNFM60Do9XoPT8yfRwbnDSre0QJoTP8hQ
         zTleJMKSALbAF9tfP3GvFLv51bgJJoh5Twr2KkqxYyBWahs9voysJdpRNw8BBvtlfi/z
         8KDA==
X-Forwarded-Encrypted: i=1; AJvYcCUa05o3urfJLasrXH14EhS6bhDJo6de8FNZ6Nh+LJgwZpI5a/p5i0CdZgHqBpA83YHkNi20goOOC0QkfbGAA5zCdZgFPV0wSLtch9SN
X-Gm-Message-State: AOJu0YxK/qAaris9jOeTYXo8jlUuI3KFriRHyfgIz9dp5jp/gef6Y/NN
	pG1Fbz6aha8E/eXJ1Igb7V9ty/GKPZu8b3EHtGfHN4wSeBbmBzVLZWNuBoW68QLiv8ixcliKMID
	amJbFyQ==
X-Google-Smtp-Source: AGHT+IHDD/Y6HjGqNyXynlRgk0OXAY3PojGR0nLsvqE+IW/uDnXlZGJ/cMSK3vIlNZ5GtuT1o2e0qA==
X-Received: by 2002:a50:f61e:0:b0:568:d55c:1bb3 with SMTP id 4fb4d7f45d1cf-5734d67ef0emr20344752a12.31.1716242743977;
        Mon, 20 May 2024 15:05:43 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb54csm15432911a12.60.2024.05.20.15.05.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 15:05:43 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so4759715a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:05:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXymIeCRVw/qIAS0AzaIVPzL4yd3PB+S3kyKx0P/kMN4X8KpJtkhKYWCWQciOMYA3Fpw3sTQHuMWRVZI7Wi4FTCNNWYphed5VMLCmbJ
X-Received: by 2002:a17:907:9705:b0:a5a:7cd3:b2e7 with SMTP id
 a640c23a62f3a-a5a7cd3b463mr1819041866b.11.1716242743134; Mon, 20 May 2024
 15:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520121223.5be06e39.alex.williamson@redhat.com>
In-Reply-To: <20240520121223.5be06e39.alex.williamson@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 May 2024 15:05:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiecagwwqGQerx35p+1e2jwjjEbXCphKjPO6Q97DrtYPQ@mail.gmail.com>
Message-ID: <CAHk-=wiecagwwqGQerx35p+1e2jwjjEbXCphKjPO6Q97DrtYPQ@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.10-rc1
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 11:12, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> I've provided the simplified diffstat from a temporary merge branch to
> avoid the noise of merging QAT dependencies from a branch provided by
> Herbert.

The diffstat looks good, but the merge itself sucks.

This is the totality of the "explanation" in the merge commit: "".

Yup. That's it. Nothing. Nada.

If you cannot explain *why* you merged a branch from some other tree,
youi damn well shouldn't have done the merge in the first place.

Merge commits need explanations just like regular commits do. In fact,
because there isn't some obvious diff attached to them, explanations
are arguably even more needed.

I've pulled this, but dammit, why does this keep happening?

                Linus

