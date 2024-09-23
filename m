Return-Path: <linux-kernel+bounces-336164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480BE97EFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A691C21650
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DEA19F434;
	Mon, 23 Sep 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f/ggZUEk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF819C57C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113775; cv=none; b=sOL00l+4GRkuQadVLzUi5n64sRtR+6KVuoFX4G3WxGSUv5EAuK75qnKLlTfvaFE9C/GTsF2CFhUOMfbIfHIIna37UZ6WqTgsI7DcFhag8leiddUmcAcDv4o9ioyyoA31Qu23oUmDOyqIbCD2sN9/EIRNWRCPGicQKpUsRBlJ7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113775; c=relaxed/simple;
	bh=LCi5as8tr2ldxM530hte0aShriHsWKbt0neamqouoKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/HmgajuaSEg0Vsp8cBNsY0mMesOT6t7L9qFIuU53KEZTz8PK0ZUafX3VhaR9VMy2U0WSSPt9Sjf2OJOCylRRVXpGs6s1FClq6PI/HDy3qPUd+pdGuX6CPi+y7u9qoziAujRATlMZFOcMLKdjZQ9Zc6G3AAbH4W9zr3ex7fGoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f/ggZUEk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a90349aa7e5so693008166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727113770; x=1727718570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUYv6+7WELIuXT4Lyojyqw1b8CePFF71EV43HfQ6mr4=;
        b=f/ggZUEkGDV0+OInc/zENdcVHl1n0iKOIW/3UJ72YM1iSsogwZPgppjze8rf72mzwc
         Sx1wztO46oTyQdENPT7/yBFkLsOmpEW4jOVIG6+c87U8o4c5sPIu4aXqX0GRJKteRjin
         3sPqYyZvmxuK+DM0EfPG0T4jWbYIi3TO7qNf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727113770; x=1727718570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUYv6+7WELIuXT4Lyojyqw1b8CePFF71EV43HfQ6mr4=;
        b=bWw/fUUv2HngZLNrp73OajYq6enWnQu07y2RTyUjfDbwloCP8qJJseA+Yr4aQbf8Tt
         +FZ9c5gZL1brPu988mtgnEuaHtjC93IXOoR5J88DavjB3SlR4ZCD37qpWvCfOf12u7CG
         Ql/WKuqD0r0PGTTqbh81g42WjBB2Qo67+AZJx5ECIzs45BtroBtm8BrFgfVG65lewVt4
         EABEZKlLCWvyX4tJ70fBzO8G3H1fTnarMsqPAZNipgjAcMHZwhQP7q/cpOWztCdM9vcA
         4ImrNNx4rWTqmMXP5HgBTl18cPd7EeOwaEfPl+2BweaSHS1jIUJ1ePz7eI5mPvHUinUS
         IMBA==
X-Forwarded-Encrypted: i=1; AJvYcCWAR5UgNOKVqxUp/He37yIpVR3dVXkJBsrTxT8GM05up7VgzRuW9U+WQXGCs+cdqy+zMZH/uOiV9N6MjCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ue4VW+cKo4w5JVTk7g7jcioXzPeSGe8bt6Ou63hz7CL5dZRW
	ZtPOm9paipElnc/d9+Xcf3lXZb6EIVoUyl0BMN2T9JPRymTY8W85kF+mHXLeVyK9pWOKI4KBRCP
	j3NU=
X-Google-Smtp-Source: AGHT+IEBXozRiumToV2RHnpTSh40goe3DSdHZPDeErhUsKbKQd9eF0/iorveRI7plH1UAIeTzv8w9g==
X-Received: by 2002:a17:907:7e9d:b0:a8d:4631:83b0 with SMTP id a640c23a62f3a-a90d566cf17mr1128929266b.5.1727113769901;
        Mon, 23 Sep 2024 10:49:29 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df770sm1271854766b.145.2024.09.23.10.49.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:49:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d13b83511so566855566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:49:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSeKXeQ3PhbEMY4+EJBFhgCVxWkVUU1KwQ+QpDVvQrZL94eL5QCuQ47C1cPZqrN85EwomStcUMwPejkxE=@vger.kernel.org
X-Received: by 2002:a17:907:2d22:b0:a8d:3998:2de with SMTP id
 a640c23a62f3a-a90d566cecdmr1222211766b.12.1727113768756; Mon, 23 Sep 2024
 10:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922140047.261100-1-agruenba@redhat.com>
In-Reply-To: <20240922140047.261100-1-agruenba@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 10:49:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
Message-ID: <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Sept 2024 at 07:00, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
>
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-rc1-fixes

This is just a repeat of the pull request you did (and I merged) back in July.

I'm assuming you meant for me to pull something more recent, but I
don't see any newer tag names either.

Hmm?

                Linus

