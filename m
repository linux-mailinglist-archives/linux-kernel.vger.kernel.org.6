Return-Path: <linux-kernel+bounces-179127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F398C5C03
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732FB1C221F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A02180A6C;
	Tue, 14 May 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uZQHp6bg"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B62181318
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716832; cv=none; b=W15oEZAVTa/PUTVJFIkBtSC5ec2+pmv6b1Cy16dYPoSH9DnxP1ognNjTpWHgJwnlKPfhL/eh9mSkBA/nfDdOKwOtp7CAHIUrlBiN/d16Mp9doBwI9gumFeOE8kGSqjNxhjtc9uX0O77jSD5U/k8+sHB8RoFjoXcAuSdcq3be2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716832; c=relaxed/simple;
	bh=F1BCusWVnox0inKiwWulDDxeUYd5ETJQa5nYC/mUo7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlzOA9p13J4c3opHMXxBk8wuaGyCWaJtK0OscIXBb2ZGius6mH1DOxgTM6eKm1A0mHa7r+FIN6ru56NegkQdAvFFPZYUMQO4rJ1b8dBwsaoClFbaAUNCSajqc7jyFt5fLzzfHuAfH19wFbYiEp+xNt3CTmXHMif2fHMMoG8EkxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uZQHp6bg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b8fb581e77so686115a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715716830; x=1716321630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ll8ePMooaLJ++vSB+9syazdtLkK7b8/0TCj36hEfQbQ=;
        b=uZQHp6bgXhVNv4WSPqVQvAiYLV3mF+NBc0Eiac6OZ/inaPjDmRqjOVmAbgvGCcbWSP
         wTuX6JI/oeiW4Cgx5TrwyzkEEJwM962DpZ6X0Cwvxr0gzzTtPJeBStI754dEytgUv3BC
         H5mvPBBnrmdkXJkr0XDJAyB23Xe1bAl1Ki6nc2kIziDDpmjsD2xvKnU9xYKD6XgjuHg9
         WgKIkzJlskrafMzooda8nvLhVk3zOlFZinKclt/cjSO8fjjrVlIDtI+rpi5BkvInw/hw
         I0KM7xMLpzbgS+ddFCk8X0zxdrlMD8S4jes6PhYm1lCIUueR2dK++Uncmmj3REjvKKPU
         Vgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716830; x=1716321630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ll8ePMooaLJ++vSB+9syazdtLkK7b8/0TCj36hEfQbQ=;
        b=bg2A9QytJHm+u7dHlCT0+5YkGxjoeSuqenMtMDM6rMsadkQQ/vWqDMJ0YUPMP9DwnU
         RljsnqVnnBLnXiDhoJ5JLbV0fdvqVjM+UFcQhL3IgfpDMalL1KJEMeeoungvF9OOeT/H
         sbfZPy95hwzEXT6aUgsiOW4uYKoj9c6W998kz+2a43oh9tis5CjV1CqPvwHiLeD+mm3p
         kZe8o/ErtXTZOh+3DlCLb3jrDGl7ozsBmh6s+Vu7kMZnmzWRPDE7mA+OoshauDB/c7Mp
         TfxorNXOF6kBTKfblrlx862oogIAx59NlB5t7u1eiaN7vRTdj8bnFhP6p56JJz0D3jYS
         zMyw==
X-Forwarded-Encrypted: i=1; AJvYcCXLAmxMwOc9KRPxSsDC06irBo/a83Gr1c1n4ZJ4uH0bCxyRdGRJ6x4Oaf4FXWT5iCwrcaoHyZKy+tTzH4WxvkQ0GNGzm8SUTkBg8WeE
X-Gm-Message-State: AOJu0Yz8i1ch9BKvvmz5MEzIBi7ulYpb+GJpkxEw95umFhGSpoz9AHjT
	20JIAatS344YboB2q46d04yfdusw6FY4+LVMvukGyKSeafWcc/pQRatxqxFg8oM=
X-Google-Smtp-Source: AGHT+IFnBHUUmMWtiYG9e/YiHxcQJT/qNVtzttvhR+ZqrEmfm+gaRsCol3BlyeJlD0TCv2qEnJ75gA==
X-Received: by 2002:a05:6a00:8986:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-6f4e0343824mr14250305b3a.2.1715716829950;
        Tue, 14 May 2024 13:00:29 -0700 (PDT)
Received: from [172.21.2.105] ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a819e7sm9572850b3a.56.2024.05.14.13.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 13:00:29 -0700 (PDT)
Message-ID: <593a98c9-baaa-496b-a9a7-c886463722e1@kernel.dk>
Date: Tue, 14 May 2024 14:00:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Rust block device driver API and null block driver
To: Andreas Hindborg <nmi@metaspace.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
 Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>,
 =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Joel Granados <j.granados@samsung.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
 open list <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20240512183950.1982353-1-nmi@metaspace.dk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240512183950.1982353-1-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/24 12:39 PM, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Hi All!
> 
> I am happy to finally send the first _non_ RFC patches for the Rust
> block device API.
> 
> This series provides an initial Rust block layer device driver API,
> and a very minimal null block driver to exercise the API. The driver
> has only one mode of operation and cannot be configured.
> 
> These patches are an updated and trimmed down version of the v2 RFC
> [1]. One of the requests for the v2 RFC was to split the abstractions
> into smaller pieces that are easier to review. This is the first part
> of the split patches.
> 
> A notable change in this patch set is that they no longer use the
> `ref` field of the C `struct request` to manage lifetime of the
> request structure.
> 
> The removed features will be sent later, as their dependencies land
> upstream.
> 
> As mentioned before, I will gladly maintain this code if required.

With the following stipulations (and the kernel test bot issues sorted),
I think we should give this a go. We already covered this today at
LSFMM, but for the sake of others, here's how I see the rust support for
the block side of things:

I see rust support for the block layer as a two stage kind of thing.
Stage 1 would be including this patchset. In stage 1, all fallout from
block layer changes fall upon Andreas and group to fix. Under no
circumstance will changes from other contributors be held up, or
contributors be held accountable, for breakages of the block rust code.
Should contributors wish to sort out these issues themselves, then they
are of course free to do so, but it won't be something that gatekeeps
other changes.

This leaves existing contributors free to go about their usual business.
Kernels that don't enable rust (which won't happen unless you're setup
for it anyway) won't even see build breakages. We will see some noise
from the kernel test bot on the list, which does worry me a little bit.
Not because it'll mark the rust side as being broken, but because it'll
cause more noise which may make us miss breakages that are ultimately
more important. I don't think this is a big risk, just highlighting that
it is indeed a risk and will cause some potential annoyances.

In stage 1, block rust is just there to enable people to experiment and
play with it, and continue to develop it. Right now Andreas has a very
(VERY) basic null_blk driver, I think we should move towards a fully
fledged implementation of that so we at least have _something_ to test.
We really need to full API to be used and exposed, this is generic
kernel requirement - we just don't merge code that has no users, ever.
Since a more complete rust null blk driver does exist out of tree,
perhaps we can get something more complete for v2 of this patchset? I
would highly recommend that.

We may never exit stage 1, and I think during this particular stage, if
things don't work out for whatever reason, the code can be removed
again. As we have no critical drivers being rust exclusive at that
point, it won't cause any issues yanking the code again. Moving into a
stage 2 for block rust would mean that the rest of the kernel has fully
adopted rust anyway, and being able (and willing) to write rust is just
another part of the developer arsenal.

I'd love to see the rust code moved to eg block/rust/, as I would
greatly prefer to have it closer to the actual block code rather than
sitting off in rust/kernel/block instead. I see this as a similar
problem to having documentation away fro the actual code, it inevitably
causes a drift between them. I understand from Andreas that this is
actually something that is being worked on, and we can probably expect
to see that in a cycle or two.

tldr - as long as this doesn't encumer existing contributors, then I see
absolutely no reason not to enable a rust playground for block drivers.

-- 
Jens Axboe


