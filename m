Return-Path: <linux-kernel+bounces-518535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A979A39090
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A37D3B2361
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BA13BC0C;
	Tue, 18 Feb 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN9+1YRr"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E87219FC;
	Tue, 18 Feb 2025 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843202; cv=none; b=nd0CEgvQenqBsRmCNoRPygcAlYtxYEjMzfIIDChA/tAa7in0NKgpmMPzfSqwi4CX1f4EmX/hcAkXUCxfL9p7+pdFYIeqQflyHEsT9NpzC6bslr9N2FORMAAcf7ey3XU4MMaBpS/ncCnDRGqj+r1UZ6EFIfxtO/D3kZcqOU5flpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843202; c=relaxed/simple;
	bh=CCf72YGlIJXBtU156+rJph9kgwvJXx8dygCkaGYLy+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4lboNQrzbtluT16+QvYpRYs8+1648piIYZDI/Z8ufVX7u5L7C8+8ExK6beZ72Q2BsC2Au8tP/n3qMKA3h2Gsw2w+kLcc0gEb9iUJbHHVnRsk7Ayy7kkNjcFC06vKzEk9oqpGeRtzo5GDoZ4PNZ+bjJuJN94QLzbF+0WZ5HdSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN9+1YRr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb705e7662so472650766b.0;
        Mon, 17 Feb 2025 17:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739843198; x=1740447998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CCf72YGlIJXBtU156+rJph9kgwvJXx8dygCkaGYLy+w=;
        b=dN9+1YRr6wzl6N5K3iLPjrcz4cLP7hKbOwDX17ev4BQb5HTto5W7A55VgDYmoSm2NW
         1qnR37l39dqI0tU+v5ERxag+HVpGYbeRO1WdGiYWqplA2xCzc+Zej5qurvYhFl3n1sxH
         cypkF4r0LaqTmBCQm8v8Ijq9BMth67pWpcBR9UltY/3WwR912Q2RiU/2375ArG7Qo+IW
         sYAuByG3l/Zu3JF+Geyt5B5QeSMDfo6hOfWZsrWielytLfi9i8v+kHIoejRbPWuKWRgq
         tyiVP25vhVIn2n2cy4fM3laRnqgV4iNDJTcWwM6kbFlhMvU/ZhpjT+b7i+z7p/aMf2Bv
         dF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739843198; x=1740447998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCf72YGlIJXBtU156+rJph9kgwvJXx8dygCkaGYLy+w=;
        b=LxD04Vjsk2kjEMgClR9Y27z8NA1fp1QQn5lodaovHTpJjhe16sqMxEhLykY1wIM5oC
         aU9cBF8/zpsRvXfm9mx2eHcmOeXE6drOWin0oL47WRFN1LlI1L7yO3g+qHWC3kuxl/4F
         zsUMZjqx4vpkMPYuABFp6g82uQI9qmhs/SeXj5axmDt5Ralfzc7O8/UCXr1nEjYojvHZ
         16hAlV0rWU6v8w6SmLzDmtPuSvybhl/vnbh9yMdh+rfw5+xfkrjkfr0Xmpp7wpNZ1yiU
         rHvghMg8srwLlvhTJt2e0dKU4YVU/pyhJUECGJLLfq0ozosaDumF1DARaNT2Ijh5FYNf
         86ww==
X-Forwarded-Encrypted: i=1; AJvYcCU1foSIeMb86QpPmrDV6ILFw/Wn6IzIxQL7OUBwLhVRYlSNyLnrCJFZt7jMK/brui5Y1h9ChIG0Cjy5i4M=@vger.kernel.org, AJvYcCVJCYgfB+y4oFbjRA0lqkJ+Ywfle86kef0dolvnJXMVAMKA5X9UVJhTAN1atWTxNSAD1PeIFMh4fbOPwFpMErs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj25LbPk4gRPH/6yY3Q9dq94A7kZMBkF6hGc3P/6nWYFhsBLwT
	dUtrkFdA5Gt+Dh52+pY2W0ZGbaWNIxFKNf61M39PE/+obx8PX8vR59UR/3xQysJ2HeZo8yx51Gj
	sG7/+JTzW/Eg6PeCdUI5unnO/Flg=
X-Gm-Gg: ASbGnct+XnnjMrf6uLx44XSa5UD4xk99aQzbU6nNY0WPbsVKwAOg16Wz8LxJAxSOiW0
	ZwARRg+RiDHaNZRIqzZm4eR0P0szufr9iliQvc+sDupYSlyScMoi1dAEGjTj+tmJWKKtHWDQ=
X-Google-Smtp-Source: AGHT+IH7918UaP+tJr4P+w7Ncj31TNcQzIB1RN+BxYusaqdvDFLog+0kyShinpcWariciJXGkbjL2IuVNQoZvxsk3LE=
X-Received: by 2002:a17:907:8326:b0:abb:b24d:c63e with SMTP id
 a640c23a62f3a-abbb24dc7e8mr154657166b.16.1739843198130; Mon, 17 Feb 2025
 17:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com> <Z7OrKX3zzjrzZdyz@pollux>
In-Reply-To: <Z7OrKX3zzjrzZdyz@pollux>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 18 Feb 2025 11:46:26 +1000
X-Gm-Features: AWEUYZmF3nJ_6vA2tiOA_SUXKMv6w2unWAGmiFQTMmVBeIGS2-M0LRIEPh2iL2g
Message-ID: <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice implementation
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
	Ben Skeggs <bskeggs@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

> 1. How to avoid unnecessary calls to try_access().
>
> This is why I made Boot0.read() take a &RevocableGuard<'_, Bar0> as argument. I
> think we can just call try_access() once and then propage the guard through the
> callchain, where necessary.

Nope, you can't do that, RevocableGuard holds a lock and things
explode badly in lockdep if you do.

[ 39.960247] =============================
[ 39.960265] [ BUG: Invalid wait context ]
[ 39.960282] 6.12.0-rc2+ #151 Not tainted
[ 39.960298] -----------------------------
[ 39.960316] modprobe/2006 is trying to lock:
[ 39.960335] ffffa08dd7783a68
(drivers/gpu/nova-core/gsp/sharedq.rs:259){....}-{3:3}, at:
_RNvMs0_NtNtCs6v51TV2h8sK_6nova_c3gsp7sharedqNtB5_26GSPSharedQueuesr535_113_018rpc_push+0x34/0x4c0
[nova_core]
[ 39.960413] other info that might help us debug this:
[ 39.960434] context-{4:4}
[ 39.960447] 2 locks held by modprobe/2006:
[ 39.960465] #0: ffffa08dc27581b0 (&dev->mutex){....}-{3:3}, at:
__driver_attach+0x111/0x260
[ 39.960505] #1: ffffffffad55ac10 (rcu_read_lock){....}-{1:2}, at:
rust_helper_rcu_read_lock+0x11/0x80
[ 39.960545] stack backtrace:
[ 39.960559] CPU: 8 UID: 0 PID: 2006 Comm: modprobe Not tainted 6.12.0-rc2+ #151
[ 39.960586] Hardware name: System manufacturer System Product
Name/PRIME X370-PRO, BIOS 6231 08/31/2024
[ 39.960618] Call Trace:
[ 39.960632] <TASK>

was one time I didn't drop a revocable before proceeding to do other things,

Dave.

