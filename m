Return-Path: <linux-kernel+bounces-301463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7495F14B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333FF1F2260C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E242170A11;
	Mon, 26 Aug 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O5dxkop4"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4789816EBF6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675181; cv=none; b=Oj4zYMqzLU/u0XHqEC3EH2kkMSgx+go0NIxaR6UazDV3GSUA/Ea9DkaOz5Uvf8bSHFrgbvmQeXtiEc3/vcGmxTbVkQTFx+bcZF4YBQdnt6EjLle8UWppQ/hZA9AOArS1j9EyHrZ8MBygUsOls/lYIfdPbheLk/WLZxQJQNrfkYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675181; c=relaxed/simple;
	bh=pagydAvzvZpx88GqbX7fQb/9e8ooMGjJGmoNcsY+0zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXSUbwE4CeSE3xlvodC8BbDaY5XCnbRhGQxJ9aSzuRnFjJ7RSbazTl35QZ3W3kjEzXlGwijz4Wc42QqFpMTkn4rQ+8uHX9CQA4ChDs2rqKYAMHCi8VNo4TIxsu1Hbfg0FV0HTGo+GypehEahRPqNJ3YEKLN8cT7vvvNyHwWItKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O5dxkop4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3f163e379so67008731fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724675177; x=1725279977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPZa8z5KaYcGXwMz9yqXraXx2BOzrBRSPNhLZ5vpqsA=;
        b=O5dxkop46IFyT1R9BcvU3+t2qWZFZXPCvMLc28Jo/ji4JbdZAYCeERNEpNWPA3j2Or
         qfV9kkFGeEU4FOF0cMe28Tg1gM7leZtrKJh7DIlgC9dA5mUfqca3dLBhtwzq5FqJHe2y
         4+LaQq3yEwsn5iEVcLYekkhczHfyNrWJ0cdFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675177; x=1725279977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPZa8z5KaYcGXwMz9yqXraXx2BOzrBRSPNhLZ5vpqsA=;
        b=aiurcc0NExI9BZfrIDN8WZUis6ARLRZFXMjA8kyKkFvSnO3/zttX2QlndDanm27vcc
         xpyXotRiLZAZ8A66Imp12ltxoZ15NshhoHU/23Mc0DywPAoBUrczeoQ7917IcQLtpmaD
         eRbcwyjAEWiHoKK2j3D7BecY6q+1416SkHK6Fs6KbOqyzWdJ5fuvTsjNA1Vth58PFv6n
         ELe3GDRGSWH3TAyU9K7vGRfEe/aZZb7N2b7u41jWH4Ud6SNCyXzs6gJe6QXG8pB1whWw
         e7hWhAOhSRIS3WZg0xFAS9ElgqMwLbHCrg+3Nw5h/uuiaOPAKq6r1zXcv6trq28MQ37/
         /aZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8ysTsJfU0Xno2yo6CKumQIz3l2w9wSvAQcT7PclxyvdbQCG5i35yQJRNase7wKzA1RxZNO6zK1BaXyjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYqq8N8L9TICJIP8t7OXnI653qtEDJ6rtnRkJ21LS74FUvF/k
	cy1znHSSEiKfJ3tXEC4BnzPpeZvMazRslU+x9EhI++JdENS8YWXh3B91tiAezF+dbRZPkzFEAwI
	7o/nfX6YVv8If2wmH1/mkoNGZdp5iQ5N8QjUTMaTSRoxj0rqa
X-Google-Smtp-Source: AGHT+IHcIrvI4/qCTVNkp4GR0C2hU9chlKv5LmalO9VjJeNbl8gIATqDEuVCEuFUip3z+LI8mm4ypP9hikrdoWLQ0Zg=
X-Received: by 2002:a05:6512:ba1:b0:52f:cd03:a823 with SMTP id
 2adb3069b0e04-5343887e0f9mr9418735e87.45.1724675176318; Mon, 26 Aug 2024
 05:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87seurv5hb.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87seurv5hb.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 14:26:04 +0200
Message-ID: <CAJfpegsxVmJLT7uL7d2s1nhGQaXr4ymYeZZ-ttaOAVauf6Zv=w@mail.gmail.com>
Subject: Re: Recommended version handshake for FUSE clients
To: Florian Weimer <fweimer@redhat.com>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 14:22, Florian Weimer <fweimer@redhat.com> wrote:

> Or perhaps I should bundle some older version of <linux/fuse.h> with my
> sources?

Bundling the fuse header with your sources is the only sane thing to
do.  Libfuse does this, and so should you.

Thanks,
Miklos

