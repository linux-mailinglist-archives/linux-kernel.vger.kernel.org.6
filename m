Return-Path: <linux-kernel+bounces-533866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB1A45F88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B616A924
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD3218ADF;
	Wed, 26 Feb 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhauGAZU"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C84217F48
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573701; cv=none; b=hxs19OvEx9gnIIzUWYNBE8AEhASq5GoJ5mGovm7DetRg+0L0ydJfIfxP9vGM1hokXHXPo54C3CeH/RoAEBmOg0pNciSi1MWY+tV6rB3NBnaYhk8XxBpvzD5qrouR8Pzs2rOcEXZh0AxxKVUmrisbcpOdXTaWfFhyaL1NhZOGTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573701; c=relaxed/simple;
	bh=CpN5ncp6Qt22Yuf/xSLGcVxFK88132BWG8W+NqjEdfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/8p+3IRXB/SBj7wimfbQezZxh43P860gt8jpvqAT5D0GhSN3gWYZPCYj88I5LzIWE4eMQFR2JCCwa/Eytef4ufD70An4MTaPIPDTZf6xq+GGCfIqC7sfx4YlHrNcv7ATLuTeseZXcpjyiNGIbqGaTvo7xIW/ZoBn1B37lViH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhauGAZU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so12066427a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573698; x=1741178498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQYuQIb36LWZwtlh3UmcRwVWXJSo9bU/1VRgIeGa67o=;
        b=mhauGAZUPHLvhUHwvBfEMhdiuYrEIgFcka/5ziEhF1ncnA+sAdFYk80B++h6vpFfNL
         wdANP3Fn/N31HBNiOiMEkc28CDDKsGiblFtAj8b1XCuxr6KttZLBACOR7JcPcqqtYN4M
         rGZLSJeAI1shgxKPREVobZRRAG76vMgFd2ir/CkZ8+l88vZJQbUbt4AwzSdC12JtYziP
         VRMappiB0FWrFaMgtvWhzEkLivMVqUJmVxiOD0l3bK/RqbLM8bLgWbtEEIesA9/7d1qR
         lVcGAh2D2owtR0xiuNqVxzdzWB9vE10Hl4XEOSOX7r3mwr9jbLGVJo8S04iiuxYk/uUz
         JExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573698; x=1741178498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQYuQIb36LWZwtlh3UmcRwVWXJSo9bU/1VRgIeGa67o=;
        b=oAvcPU+C7VlOgNf/CJZvRH1/+yZSQANRDY2vH1i4cwIak8I4xFfsfRg3WVFBzhxkVB
         54O/i9MDLLlhKRwbW80Ay2a2SFUVBT4VGkpJ1f6W6sk0fK64Jr8lrN7AzP1bmonET27Q
         lGprryY/CeH2KJ1UXnVBOG1cNYhBFylMcM9tLqbnKs88r+0GReIW1mPyVmz9jV7kw9aw
         FdXj0epTgvRBQGnYp6t2GAqtXqMgMQZWrtEH/ixqiFfUsSwzqYmRW25GWTQ1mNtRBybH
         S2eos5uRfQf4O0M6lV4PKYTC89e+/tvbCasVUU1+3JUW7NUj9I3fHVz5GDKzexJe+srd
         Dexg==
X-Forwarded-Encrypted: i=1; AJvYcCWZxMkyep7/XvM500vIgoLiCV2rkatIyMLpy7Dq0loC8ZpEiQUAgFqa2LwzFgBvl+fFKYGFju6lIGgFgww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74bdtI+Z68T9dZj9AqsnxNnmgmXlRu6LsmlFP2ZFcXGDwfII2
	0xZRjlV9oH/s+iQqGz3UTYdZSIBYWqFSXF9G6PoSQTLdKbkWEPWGqrWo3bIABLkpYctfRhzGWI0
	z/Lviq5T20eiZI0a6ewuUub/8eAaer6KkWsjX2g==
X-Gm-Gg: ASbGncstMq0p6VEULt3NH8IdAodreKqT2IGzfZ+qALtyNKg3VNHr0pU5YU+x6GeJefP
	v7D2XL5e5TyXtXbfdV613cvDrialJPjfH6p0OCAieDhJveus21ZYOs6MmGE6Btoyjhz8VPoWAlK
	ArwYN4Vrs6
X-Google-Smtp-Source: AGHT+IFtHHPi5hkmqH6TVnGYWDkR7e1ug4xFj2NVYSg1I6rAVT2CYI6tkXVgzP5D51jopDQyKEnAB6LZ0JyFSwgyBV8=
X-Received: by 2002:a05:6402:400d:b0:5e4:b66f:880e with SMTP id
 4fb4d7f45d1cf-5e4b67ece50mr884897a12.7.1740573698000; Wed, 26 Feb 2025
 04:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at> <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org>
In-Reply-To: <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 26 Feb 2025 13:41:00 +0100
X-Gm-Features: AQ5f1JrR31HJzTDyJCuL3J36XOcjpMfg3bhgNxmvVH7R2MVXvJv9mjvlPkqUZlU
Message-ID: <CAPDyKFpwZt9rezBhBbe9FeUX1BycD2br6RRTttvAVS_C99=TiQ@mail.gmail.com>
Subject: Re: mmc0: error -95 doing runtime resume
To: Thomas Haschka <thomas.haschka@tuwien.ac.at>, Bart Van Assche <bvanassche@acm.org>, 
	=?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James.Bottomley@hansenpartnership.com, martin.peterson@oracle.com
Content-Type: text/plain; charset="UTF-8"

+ Ricky

On Fri, 21 Feb 2025 at 18:20, Bart Van Assche <bvanassche@acm.org> wrote:
>
>
> On 2/21/25 7:41 AM, Thomas Haschka wrote:
> > Bug Fix: block: Improve stability of SD cards in Microsoft Surface GO 2 and
> >               possibly other devices.
> >
> >
> > The commit 65a558f66c308
> >      block: Improve performance for BLK_MQ_F_BLOCKING drivers
> >
> > basically made the use of SD cards in my Microsoft Surface GO 2 impossible.
> > The cards do stop functioning after about 15 minutes. Mostly at io
> > intensive
> > tasks.
> >
> > As outlined in https://bugzilla.kernel.org/show_bug.cgi?id=218821
> > i bisected the problem that yielded an unstable operation of the cardreader
> > on my Surface GO 2.
> > I successfully reversed the commit 65a558f66c308 in 6.12.16 using
> > the attached patch. As I suppose the bug introduced with this commit might
> > hit other users of sd-cards in similar hardware I suggest this commit shall
> > be reversed, even if the improved performance might be gone.
>
> Thank you for having bisected this issue and for having shared the
> result of the bisection process. This is very useful information.
>
> Since the commit mentioned above is about 1.5 years old and has not
> caused any issues for anyone who is not using an SD card reader, that
> commit is probably not the root cause of the reported behavior. Are SD
> cards controlled by the MMC driver? If so, I think the next step is to
> take a close look at the MMC driver. I have Cc-ed the MMC driver maintainer.

There was another thread [1] where I tried to loop in Ricky Wu, but
there was no response. I have added him to this tread too.

For the record, I agree, even if reverting 65a558f66c308 solves the
issue, it's not the correct fix.

Unless we can get some help from Ricky, we can try to drop assigning
"MMC_CAP_AGGRESSIVE_PM" in realtek_init_host() to see if that solves
the problem. Or if debugfs is enabled, we can disable
MMC_CAP_AGGRESSIVE_PM for the mmc host via the "caps" debugfs-node.

Thomas can you try to drop MMC_CAP_AGGRESSIVE_PM and see if that
solves the problem?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/CAPDyKFq4-fL3oHeT9phThWQJqzicKeA447WBJUbtcKPhdZ2d1A@mail.gmail.com/

