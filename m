Return-Path: <linux-kernel+bounces-424177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A89DB14D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B61BB21F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9D45038;
	Thu, 28 Nov 2024 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dOliguwi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967733F7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759217; cv=none; b=JvUDlmlSs+/qBtEUXaqhjiASQKXPySVYan+b4SFzSOgDyrWnYvUTzhfuREOp9NV9f9mMkwusXMTcOR5yfVD9qqmw+OEM8W/125uhYtKrMLjDmpVWCzRxUAzYn8L0arWRRr4n8jwmdlB8EV/JQr4euwd9xccTQ5TdZ1flVw36oV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759217; c=relaxed/simple;
	bh=4JgRpQhuxfm+8Ig9FV5l2jYht6pguktaYTxRlrJNpVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBluME5P1y8XzGLxgbkdOoDqi5DpYs6JSwDWi/LBzmNT9LJlrRUrosZVKoJzk/RMTp0KmFXOmbYqHpsK0zYj5JIq8QGWaQGQpc9sD5hWRjYdVAgE7FJs0PnbCsE8Q2vUQZfJ6fTHOYvk9ew3gvAPth9znqcvGgUW8kIbnpzxDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dOliguwi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a68480164so32229466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732759212; x=1733364012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phKPuAwhlETuyirMc9Kst/Ln0jqmFrDOaYl+HMwpY+0=;
        b=dOliguwiYeUoN19//jpxUPpL2Ra3f9VDLFOZEuVUdFx9D3WzZ5P/NZr9iWO0Xof8Gy
         4+gzt5urevTP2dloLw8j8UEpMEpYYGXDapNP0xKCpdpM1okKYYlXzecFE9BWvgMkKjpn
         Xdb4oHDA2pOQvNI/7Z9s6EHJEb3VhanbdZWFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732759212; x=1733364012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phKPuAwhlETuyirMc9Kst/Ln0jqmFrDOaYl+HMwpY+0=;
        b=HitRIKXsuyiedL1aFUgNpaGjDFyz27vJv2n7ldtrgc/dOdeLb3jk9HfqmJstxTg497
         9NlqDPqx+MbKLaoDREqe7dRpSePYTua21JZLDvNfTO1BWcRuxu4krEvjFih8wMagG1q0
         pJQrWiW4euYiNHPdOZcX0dD86dtNAPn0ICgEKPnxYQf/tQ5RfY9h0ubfoAzIgzCPKfaj
         w3VyEzM859tJxpQR0mppRYW7Z452aOe88XfcOZJMIvyLiSRkcrDN50ZSOoJsEocykBQ7
         JTms0t12OmiFDQAwRiuSXrllnncRzyo3cBwijlPisWEnaHsVD8gpemgehMkAH6JS0nUl
         UQ5Q==
X-Gm-Message-State: AOJu0YytYQLN3Iz4rhz+OV6/q+/+8tOHV/QUtep+amv2KSldGkusA8FZ
	xG/VEe6jBlw5RKD0dNdJWLIQ9TlvlpXoCsFHX1kIPQpp9rIbJf24/zo+rfCy27+nv3nLxwQlswv
	kGpU=
X-Gm-Gg: ASbGncs3MYHgnclyYsxP6yyu4z/8UdsGv8ufcmrSSzm32XmVi2FVf85IzTuiISlHS37
	NCd1Avc16cK+OVOAAqRnqe8BRbB+2m+sdjoIssb7gt/AroRW4JRowYkp68vfFTsQpbVVRiF/7p9
	AKPSxFeQXeF+VrzvtBu6p+pENGu3Z3eORirqJE9ssOD5qo7kdXsilxJ/Cy4kShLjaYxRH/grpbq
	+H/EmETVycf07HzColb0TXZI2TICgzzcKpF8WK1XwW0guSwAwkdNBxB3W0PfVld1SurJDiCsoF/
	agk8Ptppjd91YsTlsmZjNCEz
X-Google-Smtp-Source: AGHT+IHwczMCSfR4AmEUwdgvolnYViI4MTrJZmJ4CQIMYCe2q8GnwHoEVHiK6r116YRlezSOdnyDYw==
X-Received: by 2002:a17:906:8453:b0:aa5:4d26:8e52 with SMTP id a640c23a62f3a-aa581058831mr397206266b.47.1732759211943;
        Wed, 27 Nov 2024 18:00:11 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6a4csm12921266b.106.2024.11.27.18.00.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 18:00:10 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa549d9dffdso35601666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:00:09 -0800 (PST)
X-Received: by 2002:a17:906:23ea:b0:a99:ffef:aec5 with SMTP id
 a640c23a62f3a-aa580f2cce1mr344732666b.23.1732759209250; Wed, 27 Nov 2024
 18:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org> <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook>
In-Reply-To: <202411271645.04C3508@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 17:59:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
Message-ID: <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 16:53, Kees Cook <kees@kernel.org> wrote:
>
> On a related note, what do you think of using execveat's "pathname"
> argument as "comm" if AT_EMPTY_PATH is set? That'll give process
> launchers control over comm (which is what they want), and we can keep
> the dentry name fallback as proposed too?

That's not actually how AT_EMPTY_PATH works.

Yes, it's how AT_EMPTY_PATH *should* work, but despite the name,
AT_EMPTYH_PATH does not mean "path is empty".

It means "path *may* be empty - but if path isn't empty, it's a regular path".

IOW, what is going on is that POSIX required that an empty path be an
error. And AT_EMPTY_PATH is basically a "don't error out on an empty
path" flag, not a "path *is* empty" flag.

So if pathname exists and isn't empty, AT_EMPTY_PATH does nothing.

             Linus

