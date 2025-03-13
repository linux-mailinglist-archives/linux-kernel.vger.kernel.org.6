Return-Path: <linux-kernel+bounces-559641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24DFA5F70A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C31165F35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCBA267B7C;
	Thu, 13 Mar 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="Qe/3eXMb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09C267B07
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874173; cv=none; b=t9/jq0BiJYNnphASoHZ6wcJqumGIlYxjdwM2udrCVcZzMT2U41y9JlPCQ7OXh8JIaTaJQHxBHs+Y1v1b3eo9oXY6vPzkEYTctPq5sx2ByfjHMKSuwn8Kfbw6VucBvQKwxw3AvtDwnruSa0y4FMO6p/vO6VWeCs+0Xib71RWwjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874173; c=relaxed/simple;
	bh=OXZwBbGFVEFD60c57eDI5cj9JWNWhkxbptmsSKbkSJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ0CNBjLMaKbydV2U6pQP8OMHqgvAuwdeavxupgbHNtYCxNuHRg9QsE5IJcJ1O1Hfo7fqG6SPJoZp7Jvkzs/sK11qXzJfyzqpbFUxmPPfQFpZsweCN/jslxbWNTzfGkeN0M4b79LEhJhVnqjHd2qKKurzrYmUUnTHj28irykyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=Qe/3eXMb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22355618fd9so19094615ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741874170; x=1742478970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJWf+2Kk9KeIZXFG3cJ7oE/X0yoKG+h9t1wBj4fhOuw=;
        b=Qe/3eXMbVcP6ytBYJ76iyF11ZFTjzxBwTRc09YSXvuRg1IYxHKQgV14nktetSYpSH7
         adaS39IwuERhNLr8a3010uqOF/ybTM2gXqB3OPhSOH16cHJ1N4Wak4de26b4imXn8dpF
         T6z7cDBgj4ZWNP2DJzvUoVzYv7KUpukZTewf1HR9j7GW7VgbD7WYqzlzcOXllKG070QI
         r4hVG4okhyBmRCTh4TWudn4gX0zAIjmvDQxG/fSCo3ZSm3tLHGmZSLs6FZMuKcBZznq2
         SxoxHJZBOAwkBtH8O0gsnm4YdLhiimO5OPLztXLM57gvqyNLgFwE+DJ7jjbOl575Np6/
         CCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741874170; x=1742478970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJWf+2Kk9KeIZXFG3cJ7oE/X0yoKG+h9t1wBj4fhOuw=;
        b=NxP8RKxOL94bIEaL3mTO5pWb0vuB6vVVxLvUNq42ziK7zVibDjrRxbWfSucA4wqzHT
         d1jg8yXJpw1Sq+36XxbWK6lIduAeJa4LbVrRkPGFQp3W8L4rP6v5vdieeRCWwKktQBiS
         Cddv2s/qqHg43hk8X4fe8RyBsi9k+eX+xFnwEXrJee9UA/e+RELNtd1XcKwQXmzfm6j9
         xMGqajNGfz/HfeijL4Jg2yo/K70kRgJO+wGiGDZZfpIc3J8OgwVo1y8tAh8gp0rnO7cj
         fChzRzkvdToo2GW7fQyWrfMcl83e44/IMrxAae/d0nFd7yGSV6JB2msGftnfU6PYfd4X
         hY9g==
X-Forwarded-Encrypted: i=1; AJvYcCWkHXjzY+92TD+4COGYiweV1DQc1fBPey2F7viJVjlK+TXsdWM8nCRj9tMUWhrUp8S8A03QwGm+8Iijvm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uPUuaqlnugskWba7hzVN23mWnb1RAXlE1bGPaJMFd00mDEIx
	n2NtyTrrRYJjuuuDPRmML4izKTGK3mCObMJX6J3NjdUmrwsw0RkF4HYXjJqvJ4M=
X-Gm-Gg: ASbGncswpYY4/DZD0FPRj+41kXIkwTAzcfZMjF5UkWzXpAxsGnVhGyCbclTWB9A8dsN
	iY8aexza5XE86sYP5lmnlUlNxHg4AHyuUfpOfsd7DrYqVFp5JJRtGyn0XUZwY6r6hda3D6F4pGy
	WrXSZ5TxPDkFgtod7eKNXMIb8xaKPoJ2SREmZlRUQTi+7TW93TQ2/2DvCwbGozkcbOfxqj+UXle
	sB2yvr67jeYaEI90sbha2w0O4pYpfKRthRHSmmFwFMrOo9qfvuwRM/y7jhbzqnjks3eAUQ9GqZ1
	nE1a8fs2o9X7EDJgK7HF2jG/30ZICB+XRa3vHk+OANx/msf5vJMZq10wRVdLk08LqzhKWilSjg/
	D
X-Google-Smtp-Source: AGHT+IEaZvgrjYn2hacXxym8AfVHesqurCWdjoDGFqV63N73+ZMsWJUmVSIvP/Ou4EEvrvg7tRtGpQ==
X-Received: by 2002:a05:6a00:6c96:b0:737:9b:582a with SMTP id d2e1a72fcca58-737009b5927mr9817205b3a.24.1741874169929;
        Thu, 13 Mar 2025 06:56:09 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152948fsm1365507b3a.16.2025.03.13.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:56:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:56:02 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9Lj8s-pTTEJhMOn@sidongui-MacBookPro.local>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
 <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>
 <Z9K2-mU3lrlRiV6s@sidongui-MacBookPro.local>
 <95529e8f-ac4d-4530-94fa-488372489100@gmail.com>
 <fd3264c8-02be-4634-bab2-2ad00a40a1b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd3264c8-02be-4634-bab2-2ad00a40a1b7@gmail.com>

On Thu, Mar 13, 2025 at 01:17:44PM +0000, Pavel Begunkov wrote:
> On 3/13/25 13:15, Pavel Begunkov wrote:
> > On 3/13/25 10:44, Sidong Yang wrote:
> > > On Thu, Mar 13, 2025 at 08:57:45AM +0000, Pavel Begunkov wrote:
> > > > On 3/12/25 14:23, Sidong Yang wrote:
> > > > > This patche series introduce io_uring_cmd_import_vec. With this function,
> > > > > Multiple fixed buffer could be used in uring cmd. It's vectored version
> > > > > for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> > > > > for new api for encoded read in btrfs by using uring cmd.
> > > > 
> > > > Pretty much same thing, we're still left with 2 allocations in the
> > > > hot path. What I think we can do here is to add caching on the
> > > > io_uring side as we do with rw / net, but that would be invisible
> > > > for cmd drivers. And that cache can be reused for normal iovec imports.
> > > > 
> > > > https://github.com/isilence/linux.git regvec-import-cmd
> > > > (link for convenience)
> > > > https://github.com/isilence/linux/tree/regvec-import-cmd
> > > > 
> > > > Not really target tested, no btrfs, not any other user, just an idea.
> > > > There are 4 patches, but the top 3 are of interest.
> > > 
> > > Thanks, I justed checked the commits now. I think cache is good to resolve
> > > this without allocation if cache hit. Let me reimpl this idea and test it
> > > for btrfs.
> > 
> > Sure, you can just base on top of that branch, hashes might be
> > different but it's identical to the base it should be on. Your
> > v2 didn't have some more recent merged patches.
> 
> Jens' for-6.15/io_uring-reg-vec specifically, but for-next likely
> has it merged.

Yes, there is commits about io_uring-reg-vec in Jens' for-next. I'll make v3 based
on the branch.

> 
> -- 
> Pavel Begunkov
> 

