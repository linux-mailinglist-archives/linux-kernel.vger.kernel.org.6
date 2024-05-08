Return-Path: <linux-kernel+bounces-173848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607B8C0653
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059821F22A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8997131757;
	Wed,  8 May 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mjPXoQ0Q"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820651E507
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204317; cv=none; b=kp5TDSUptu5p5vQj2nC6D0nUWAMpAHBGZApQRSqXurN3jjuJ44MF05JCMpQncg4BCMxtA5f1QE0Sga+HiYidcTtbGOI+e4BppoC9OP+ysaoxbrH6P2BDr7cPBkaFxvaGCYv+NT8Q1vm2dLGtsyWeaG6JYdIUXSMfGrbUFAYmp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204317; c=relaxed/simple;
	bh=KBXUYtxwvYRy8f6xUfurfkL3UHcikX6QmUad01Q09QQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gbFWyxlPVrQohoh21o9UdDbANugsB8AojA4XcEpVV/gLA5k4zb+VgfrU3M6MNg3ZoZAfEsXC0H/yKc/enysMJm28aglKBFLAAsSxNb4tfYdq8n5YRPf/Ye44Ors2I76UX85A1Ymie1RMwHQT3ceex6tztaBOMA40/p0+qAYUUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mjPXoQ0Q; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a073f10e25so926056d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715204314; x=1715809114; darn=vger.kernel.org;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KBXUYtxwvYRy8f6xUfurfkL3UHcikX6QmUad01Q09QQ=;
        b=mjPXoQ0Q0MrmqSIproS8vap9OnKXXqGiLjpvYSw4RMDSe3xystOLhKb9M/PiIzzxiB
         og0exjRyg1KH0qhT0a7KD70vNMRRhuBQa4n/9uZ9W0D+IIdl3zQ8wuoqmqAdZWSWCmHY
         sI5qBnkiM2wr3+SfzqLXjfrfcFEYFObR7y+5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204314; x=1715809114;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBXUYtxwvYRy8f6xUfurfkL3UHcikX6QmUad01Q09QQ=;
        b=L8Z/w1VyBLcBy4si5zI/MfruwZOhGq3jrIQb79cRJCwc0fYojtm9stRQ9j03xqHDMH
         VD/Tb3deFcFrj645nNHMQge1rIotIdFR1ZV3880xImOnEGNVgChjuo1kKhGF1Om9E5pC
         wKLi6Y9IXBFZ5ga0AYxXsstqfOc5KpoZYGhIS3iVE39Slsgc5lfG99L5MCnwR/3jh90s
         TEihstZ8XCHezAVt0Dzq9RRJxR99Vy4SHiIzjY/FqN9XOkKptLXBP/3ywfKn468Ps3F8
         XDoza9R2fpvdeDnEkGYmQRsgaZ/WSF3gUWo3vjqZMYNNd73iY1ruaOzJLIuVaU7cxVpQ
         t4OA==
X-Forwarded-Encrypted: i=1; AJvYcCWwe7sANeQnTQrdom0NRT0t0+A0iTVGug5w/7Kl4CYPVmWr42kkV63ROzrq/WtHM8AMyEeBFlfexVmyVGft5bfElSPplwm4VZXffgKW
X-Gm-Message-State: AOJu0YyiEKYqcr/oBZfNM1lyOBXN1q9CyF+pL2cKj9ac/GarzrB7q6Rs
	E+ZBZ9K3R4arfPhKnPzxGjcN1Q254tT9WoaiPcRnaQEDXfa3mD7Vg/Fz3clmyrY0sGUSlSRg+qK
	E4uGUZxDqFXk4MrT2GrxJYWwT3ixNUVTvzYqGeQCaG2M1Ktk=
X-Google-Smtp-Source: AGHT+IEna8GAW3FsCgsrx3UXC4aCTB/Zq0saIAxL5125jnWwo6mEo51aVJhdiS8M0VMwhxZq+dfOCALBvRHIkhk2ltQ=
X-Received: by 2002:a05:6214:a4f:b0:6a1:1f45:84b3 with SMTP id
 6a1803df08f44-6a1514bc58fmr37457026d6.5.1715204314566; Wed, 08 May 2024
 14:38:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 17:38:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240311-decode_stacktrace-find_module-improvements-v1-3-8bea42b421aa@bootlin.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
 <20240311-decode_stacktrace-find_module-improvements-v1-3-8bea42b421aa@bootlin.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 17:38:34 -0400
Message-ID: <CAE-0n50xwj04hAUFj9y2oc2VBgy0G-yVFC8f=DyhRofv2hYY8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] scripts/decode_stacktrace.sh: add '-h' flag
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Konstantin Khlebnikov <koct9i@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Sasha Levin <sashal@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Luca Ceresoli (2024-03-11 08:24:56)
> When no parameters are passed, the usage instructions are presented only
> when debuginfod-find is not found. This makes sense because with debuginfod
> none of the positional parameters are needed. However it means that users
> having debuginfod-find installed will have no chance of reading the usage
> text without opening the file.
>
> Many programs have a '-h' flag to get the usage, so add such a flag.
> Invoking 'scripts/decode_stacktrace.sh -h' will now show the usage text and
> exit.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

