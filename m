Return-Path: <linux-kernel+bounces-574530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B34A6E672
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4FB7A4D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3E1EE7B1;
	Mon, 24 Mar 2025 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jUG8Hgmu"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DC1DD877
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854452; cv=none; b=hEx4b/wF3JCKYIgq0dWzDXv07FQWoZqWS0M60BfgSv9JqTnvHlodQAnv5oO3bWx60XTaQ6z1apbv0icNoOVCd82YpI5KFXVz8Fteov/WNTcwtBr96bnRYNNgDelkruWLtacEWiwqv5Or+EmeNiguG+XK4VHbFISzLj8/0A2Hkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854452; c=relaxed/simple;
	bh=MBZ1W6CapH5d1usBknnCkjHBOxHiRymKU3jB4IbXVKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLClQBVpNcU2xLv2zuy5gvlAhLCJtFCYPa3T5xDQYt9FDGAll0fkKVFzAkOZNI7EuOKVIZB7jX53nPO6hM+ANl5aqBNxFxGsNJi1i7IiOjQWHbp2Yb84uVwReFpiubtIZJTinbljZOmjIIlW3rhQpVRIlu1TXp5VdE4QeWItQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jUG8Hgmu; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47691d82bfbso98108231cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742854449; x=1743459249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKFno+iOMuHuHC6FIOmkLIKhwtvzDp4MmUu/eD7g6UQ=;
        b=jUG8Hgmu3qbb0PUAtX51m+gsWwDcG/c8BMyntGjDGcVqwhbY4tQ15Sk/plH8BRZSIe
         E33ZvDqLTsFI/KhsqjMtzp2K81cT//cCwxee55Tsw22JHn6BEfuArCDj9qLHehscyL0O
         UvNz6zIqViCPCM8+kA5GfWrRVVmivTldAWxnSNSdLpJTA6qugzcLhnzyTOnGpSMPj3aC
         033yJalopafgkcYN08WdlJlvlDctqNal8PV4nOtQCiIYa8AXyscICQVi2qqzbbIEnfa8
         iopsytAoeLhVg2ljGYo6NpH84vDMpsJuwjRJeXKFC9Kcay3n6B+N+/4qlSjK4fusvXXj
         7ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854449; x=1743459249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKFno+iOMuHuHC6FIOmkLIKhwtvzDp4MmUu/eD7g6UQ=;
        b=Gbt/NH5FXEowEnCrCLtlO6mXqyCtpd6a96W42FfIfDEgF4JPlANF2thBq26zldt186
         2F/JFp8hPcNsuOLW19T6yZVlY7JLN0QOcar4GUbqSrIpPIN9lK+Rh8SzMD+xIxwV2Qfb
         fh8/Qz+ByDZmQYp2FvNJgEntyv5URW/d3yvin6595Ql/lWgwS9PlTPFQ0+F+2yzkDpHH
         +3ytjlJIYc2kaDxCuY//f8reDsyl+XAGPmWLgQSjbqiIeKe9g11VsvlZV97bCPH0aWct
         3PPBphbFhVNyLetyKLv79FUnrIn++Yww9VfefloH55udtKvzjCqhwPHbsw5K2vdKQ4m2
         p6UA==
X-Forwarded-Encrypted: i=1; AJvYcCUS88U4z3YmFIt4/TlY3zgZE5qjZ3ZDplSOC0XShyWXDKMyHNzWo2mFl65JOHsjDVwJZbFFwrkHi+OEtdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlisd/1r9yKGojFOZh6Szn/cdTvvqMHwQWUUINV3KaxAGzLnfO
	Nokb0xcDdqNsMM0JG64zOq5eU4tJrhQDBB2oBpM3BOij0/uftAkHDlsPuQF7qB4=
X-Gm-Gg: ASbGncvpTqBj1OC3x1Rq8mVTwcScUWtjYKHJUfst29goJcW94MSkjtup+LuZNXpKaox
	pyZ7RX7l/C1GrhlNpORL4UNcFLe0lrhD/gywVdb6UsN+ltrbz9+phIFlheaZR5ff2zBpcROnT6L
	8MyHJcBqE1JiYJEevv614ZXkDlzwslZFjiE4sjvxAySizWJG/WzgzmWKwBxz/z9H02O+PekYl2L
	kFr562DYad40xRvUIB2VMJZXINn5uTe8TPLw+ZkR+EuTrBYVulPH8SYIYHnNGntgz4j+UaiwPAy
	PjjpdaoJQuxUFQscLUd+FQ1+rU24G/6Cr+T5st8=
X-Google-Smtp-Source: AGHT+IEN6pbLUjK4t/MwdNJ+7x4g+/K+DOAyn8HeIcLki0j6zcILdxKCHHj5sT36bGH6QAwdA1QJyA==
X-Received: by 2002:a05:622a:59c5:b0:476:6f90:395e with SMTP id d75a77b69052e-4771dd94fcbmr237673821cf.21.1742854448967;
        Mon, 24 Mar 2025 15:14:08 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fe11sm51891581cf.50.2025.03.24.15.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:14:08 -0700 (PDT)
Message-ID: <80835395-d43d-46de-8ed6-2cc5c2268b19@kernel.dk>
Date: Mon, 24 Mar 2025 16:14:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/for-next 0/3] Move splice_to_socket to net/socket.c
To: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
 hch@infradead.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Jan Kara <jack@suse.cz>,
 open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250322203558.206411-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 2:35 PM, Joe Damato wrote:
> Greetings:
> 
> While reading through the splice and socket code I noticed that some
> splice helpers (like sock_splice_read and sock_splice_eof) live in
> net/socket.c, but splice_to_socket does not.
> 
> I am not sure if there is a reason for this, but it seems like moving
> this code provides some advantages:
>   - Eliminates the #ifdef CONFIG_NET from fs/splice.c
>   - Keeps the socket related splice helpers together in net/socket.c
>     where it seems (IMHO) more logical for them to live

Not sure I think this is a good idea. Always nice to get rid of some
ifdefs, but the code really should be where it's mostly related to, and
the socket splice helpers have very little to do with the networking
code, it's mostly just pure splice code.

-- 
Jens Axboe

