Return-Path: <linux-kernel+bounces-418956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842EC9D67C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A12B21032
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D21165F04;
	Sat, 23 Nov 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IsMpb+GE"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F0BA53
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732342166; cv=none; b=i2T6gAxorjRHB7tpo7Yx3sfzlSlUDMfPGdrtFmEJHJTdL2aofbTul+QfnrZENdbRgwqipLOJ110IgHSNAdt6Fui7zOsZojiGhyanHWv83DHZTO3Q3SZIunmG5pgKMseMcQZ7mrcNXW9nYgqY0HrYmqZCsMlU8KocvXVcd7g5f1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732342166; c=relaxed/simple;
	bh=MGyPtryu9vwlqXgH+YK8PKy2Yv9hW/j3LeOUBVe2VI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5RjDWAMd0HiAZaHHjE06apKAteV7gmGwgweJpasDnR9q/I9UMw2likNIJxhV3BAYXmYFi39rB0YOIA+iNmn+/JfyzEHjaku23lmb93eBd0wbAxu9sJSsAP+z8fDi1uP7QCRbV91CfPaJ3wKWWz0i+cd5jFROMHV2xoIbua9xoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IsMpb+GE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfe5da1251so3392146a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732342163; x=1732946963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbrjbqNKCRo+IWqsypSqGBrpKrn9jqq/jrjfhjQ4XdM=;
        b=IsMpb+GE9S3EQuX4OjSBqeBU90BXVpMVwWDTZl0XII9fZCcpOcf/YZFXXE/8/8YUNQ
         xjpdzoY4ZV1Z+xrY20Pptm5nahgfk675MeVLddykasp9S+5P9PjyBXa5ATgQ3rcaTSlc
         NSYtPj8i1cxyBwPD8p+5HSpy2iA2q8lhofdOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732342163; x=1732946963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbrjbqNKCRo+IWqsypSqGBrpKrn9jqq/jrjfhjQ4XdM=;
        b=VWPjgwTCpNGlTWiy9D3q0r9CTUzqGjSqenrk3jpNP1KICKZzFlAU2QiNObCyxecqdn
         TvoTBtXHx6CUvKrgySQWHP6+JIGuufz++34xx4BZIVSzVwRVC6afoi9aaeM61v8yJfd4
         84iKXT6ME5RjP0QhTAqpbVeTgjY4icI0zK8viK9RZPVjYK3od/voxo/d7ClMCWWwtGi7
         rM54PeUeTFGgbUzDcYgRdKrwF7tHJy9n426meVKf/vbvzo7dfznXcIAY9bA1GNE5bFqj
         Ge11NC0aPY9dIe3QtoClSM6SnA6LrzvmMi0lQTBRfkD00XI7CfyljbHO9g4hy+R6k5Hv
         xsfA==
X-Forwarded-Encrypted: i=1; AJvYcCViSGHlwKXLDc4PKGoS4LUMDGw/BX8ziAWxo1E2ULp1n4hEx/AWwqexlBdihukwpRwZ5xzg+HMnHtQDxFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6nh8knWd0rSEOpIbjFYLgm8GfceXZCfcin92Wo3q29SK/elt
	oF3Evm6h80wes+aBc23mdkXFTtpSSziMHnMP6Hc7xscOoqhRTt8z8NWDOXKY9xJyUZskojrrlsw
	TbEtZ+Q==
X-Gm-Gg: ASbGnctl6HGtUk8T48tt0gzMfF4K8WMYd2Lz4tBsajSFyzZSOq7yJZE1Tbf1UVzoroo
	BDA5aDWS17o/Q210cNjYzwSLf/dsRaS1zYi4oihdE9vN+ku8/tiQMRqAjy5dJQwQWHweWfxs4ww
	tyIYq7dQt+F1fv6byJoKxJkhRdfCZmmJHsvjGADFMCBJCm91pL+tqMsCUg/0fq7vdWj2k44Z4Fv
	WrVmAa4KhP8OUR748voSyhe1z2zmXaB2NLW8382OLiQ9S+EzZR/HI3aapSeV/CFomky846K1fC/
	7xbqFJ/ZeB6kxnAyK1O0x6WZ
X-Google-Smtp-Source: AGHT+IFqOBmBFZl0GbOtbn/xLrygSoglQLhcC0x7QE5sl79uYt5LlAqz3dJef3x1t16f8gaR8YUOcw==
X-Received: by 2002:a50:d755:0:b0:5d0:214b:96b0 with SMTP id 4fb4d7f45d1cf-5d0214b9b4cmr3267793a12.1.1732342162880;
        Fri, 22 Nov 2024 22:09:22 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c040fsm1638888a12.50.2024.11.22.22.09.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 22:09:21 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa5325af6a0so44545666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:09:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXP8vSm2HOK130l3U4o85k6wk0KHdyuxswYOXXt2H5iQq48uG1AhXx4eivdBl/DsbOw3Q0K+0PST0SRc74=@vger.kernel.org
X-Received: by 2002:a17:906:32d1:b0:a99:cedd:4612 with SMTP id
 a640c23a62f3a-aa50997e1fdmr440623366b.22.1732342160869; Fri, 22 Nov 2024
 22:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
In-Reply-To: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 22:09:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com>
Message-ID: <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 21:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So may I ask that you look at perhaps just converting the (not very
> many) users of the non-light cred override to the "light" version?

I think you could do a completely automated conversion:

 (a) add a new "dup_cred()" helper

    /* Get the cred without clearing the 'non_rcu' flag */
    const struct cred *dup_cred(const struct cred *cred)
    { get_new_cred((struct cred *)cred); return cred; }

 (b) mindlessly convert:

    override_creds(cred) -> override_creds_light(dup_cred(cred))

    revert_creds(cred) -> put_cred(revert_creds_light(old));

 (c) rename away the "_light" again:

    override_creds_light -> override_creds
    revert_creds_light -> revert_creds

and then finally the only non-automated part would be

 (d) simplify any obvious and trivial dup_cred -> put_cred chains.

which might take some effort, but there should be at least a couple of
really obvious cases of "that's not necessary".

Because honestly, I think I'd rather see a few cases of

        old_creds = override_creds(dup_cred(cred));
        ...
        put_cred(revert_creds(old));

that look a bit more complicated, and couldn't be trivially simplified away.

That seems better than the current case of having two very different
forms of override_creds() / put_cred() where people have to know
deeply when to use one or the other.

No?

                Linus

