Return-Path: <linux-kernel+bounces-425932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169309DECAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87376B21D35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11EC1A257A;
	Fri, 29 Nov 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VBO8wR+m"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56414D428
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912110; cv=none; b=ZPvhEVsdlKOhJ6zhAV77N37uw6VIPfVpSyiasyAXVQBi7takMwyVpciZd0o3W2E3wGaSZQdkfmGfrbykuq7UqPN15tHlnbPsPEwm3Napue2LkW2lDn54eX4fjzSvlcsmD5XlWQS14tiwnW7xGuHKAxHUyu6agcjCYmwU6DYwK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912110; c=relaxed/simple;
	bh=gwUK9l6qgO892ybXoJEt3H9VFyiJ8/SwoppMeYF9Y68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7vnR103dz7DoDCwOhd3qQ83Jhks++bQow3yr09/WrBpM1Tnf+49/dBWbQtCh3PMGapHkR4Xw5IhAbX+JYGFh5TmzGAIOhcY/XPToFbso/NXWUhw+JNw2/1pnAczJGA2Hro3UZkqsLYKwxYor+caQP/epje0tkoI1rz7i3J24d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VBO8wR+m; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa535eed875so324505566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732912106; x=1733516906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wXiyYa/UqigkuopokYOURbzNGQMtk7G4o13Nu/4ERk=;
        b=VBO8wR+mBUx7KQNMmprGFLcRH/vRiVX6hQ8P6/VP0A1oRvxGye1XEi7Dcd2cGKe0CJ
         4NVyoe4CFLnDx2b6d07yobcURkT6taQp5mclCLpTXthMPgyM5B25k1tbII3t2Aty41me
         /+wmxiaYBqp2V77AejOR9RsyX5njtpJB5SKw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732912106; x=1733516906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wXiyYa/UqigkuopokYOURbzNGQMtk7G4o13Nu/4ERk=;
        b=f5aZPB60hJwCr0LysdKq8GdPSZ9M4cnZreFrEHdYWNFbbEv4RYLjhH6+8XqpppmDvy
         F/mRjtyoIFXfWjeSTxdvNSjcLsv90VG9almSYIW0gTZmAtK3XwwAS/573cCB66jHXf4h
         hcEP9uOlXffVY9KFXJXibSsOqn6ZiON8NLhifcAuLoZNNpfhsOgHfWG1tF5qKmByGVGw
         13Fv+vx5bHxw1IU8eVmpjkS1+UUHKymSf/9nE3F/omtFfCtaoqTuvUmZlkO43NhMBgya
         l/+Taty29G4YR4egFebSpSFiE9Gy52WvEV/QaCy9DLK1AiLjBMZpMHzAc1wb2XfmBHMH
         5tKg==
X-Forwarded-Encrypted: i=1; AJvYcCVoy3voZAMcpP+MD8L1SX2ObkqpD7grHNH46l2MrXTsznsc7t476LmZSiiyLTSFaxfB320PMkfAItG4SGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSkf6X6TJCD8fyBnWik1q5YiQufwAP0BTpp3qLp5cDVbfhKiuY
	X1YSFQh6e14jDcIAEmLON6iT2GzRro6GoU9iIgA9XSekyKBwzsIQeqli6RgnrTpLBrSd69VMi5F
	KYe9/4A==
X-Gm-Gg: ASbGncsXTk3M78l0Xs6G1qXdetAeXrtENT7I9N1/zFEcaXz0xoh3C2CGaRpG7UVLsWb
	U3WYfeBdGuciAyehX5GgYi3+oTA2isWS0esO2OkYAhDPiQf5U+Yv0XdbNsyDpzhI3Dx259ZVvXA
	BRiHTXN8MK0Pjyp+DxsYHDcGWPPQyEf+iOe2k6PTtO4s4fBUWw+D2/4pAvLU+hHWhXz5pf2LKjG
	DVzYs2MwV++temex/q/qG/SM7kCLKeVQvB99ZYlgQNIqDNU/YlERVyLxa7x51dqRIlna3bV7EYr
	iQUla5a0ghVf7WWa8ADUuKeh
X-Google-Smtp-Source: AGHT+IEsUEvPsMESbJ+pa75t0/D15JKvt8YHItjafQ9vpL9uVVhSk1c0qSjDW3Ia/6uivOPb7t9ZWw==
X-Received: by 2002:a17:906:3109:b0:aa1:e60e:6fe7 with SMTP id a640c23a62f3a-aa580ef31e1mr1002612866b.11.1732912106061;
        Fri, 29 Nov 2024 12:28:26 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599956eb0sm208424266b.196.2024.11.29.12.28.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 12:28:24 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa549f2fa32so319580566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:28:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWL/1g2fq1WMyQ5dQ6Xtp8VBxrdWpfPS/Zzwmq7vkQmyimCTRaIVD1PcEdxRt/9TFSm44O9NI734wVwUeY=@vger.kernel.org
X-Received: by 2002:a17:906:311b:b0:aa5:b1b9:5d6a with SMTP id
 a640c23a62f3a-aa5b1b96013mr334340866b.54.1732912103149; Fri, 29 Nov 2024
 12:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0lCihhE75lE9Zjd@kroah.com>
In-Reply-To: <Z0lCihhE75lE9Zjd@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 12:28:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXUMgkaJyQiQbUBNR-fVQC8LO-QPJ7y-30oThQCBDLag@mail.gmail.com>
Message-ID: <CAHk-=wiXUMgkaJyQiQbUBNR-fVQC8LO-QPJ7y-30oThQCBDLag@mail.gmail.com>
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 20:26, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> TTY / Serial driver updates for 6.13-rc1

Greg - I've dropped this pull request since it sounds like it will
need a bit of fixup.

But holler if you prefer I take it as-is and I guess we can fix it up later.

            Linus

