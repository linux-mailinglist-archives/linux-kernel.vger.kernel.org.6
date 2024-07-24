Return-Path: <linux-kernel+bounces-260861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD993AF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37271F224DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86931155733;
	Wed, 24 Jul 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFankBZG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688951C2AD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815467; cv=none; b=Ssl0Ttlzdw50Yh4cixyKHzDFWcijcTzTkR2GExQFKVYXtAmauxi2MUAOP9lL4Eu2Gw71PeZodEszpnaAp0UCF2thfGq6ulmKla32M6XnxJxSwwA1AJagcghSFQh/N/SMSTdBCFXhGu7YzTvB6Yj6ulg7AHdCkxNdP8qwasY/IIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815467; c=relaxed/simple;
	bh=0ry878GYOIw6TZ5+EtsbRvu5e55vhpxkxNMAAdNzsds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eld5vXkxLMd1AqDunw8VrfqKSTvxErniF0lQZ7Je9amOPJc3v2OxeX1lKWINmSWkKDsh/wqgW72gQbxlNwQyGOMHtrSb0kMRc+LB8RfKal0khD+uPCc7lbnc7JGyBQDWc6a48rOitIgMYQNepkKQrBQgQXu+d1lPCdWpVeJ2s7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFankBZG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so11186a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721815465; x=1722420265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ry878GYOIw6TZ5+EtsbRvu5e55vhpxkxNMAAdNzsds=;
        b=wFankBZGuwtSyNoPFQBmld4LqNqI9KBS+o+8Cc4jR9KwLoCuG56CTxeOMRpBK2xyKh
         9BaXqED1zm+6fKtGEMn4XMNc7zYQPc9FWrdixsYLP1uGKFlaGcPNvMCld+zLkMPkV/uB
         xqdFbxsmfZDVf4D7T4frOs2U/QOa9AwcH6sedpTnE1wcPwFAr1wF/Xnu5I393SBeNjt0
         wr9l0yq6qvoA204tErMoPUANRvzS3LRavFBUxS3rxNkw04a8zwqzPl8ouQ0t66oLYn09
         i3KiYPEBtP/twK1QvRbhgXgDxX1kzwD6TVsRpBYnqAYgR4hzOEh9iDXudATc5qU7u8J5
         oMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721815465; x=1722420265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ry878GYOIw6TZ5+EtsbRvu5e55vhpxkxNMAAdNzsds=;
        b=jw4dKIIAx4Rp1WiKPhLqlBl9JCmjB/HXTadES5YUFKqXcapiQ5AoO2ssk47VbGOtVI
         niNiwbTTb39lr3BUdAy6PHyFXu2Itdzyotq9eLlIHgpqnyZ7B2xjapkGt9wNH+9UBBQC
         uQOszKpjX21Ob2jCgHFtL3Hp3F8rGxf+SQMT/DqKmX7dJFa36TjwuM25BiNqmJD0rwOq
         96w3/brfiprxuJtvNJXscxiUWPVBfofwhAYcB2Bjhl6qquDEdoAgQ2C+AVPQeJen1WXO
         9X1oMF7bpf8leqvtECw2rL6aNUEzu60x5oGxk1kmMX3Fb9oHoHvaYCShroRUSn/j2rGe
         p+kA==
X-Forwarded-Encrypted: i=1; AJvYcCV2hGZnaczBudlGGPuC20zDzpfZimUovXKjRyjDFWIOioJcvXK1hNK5nhLQ6HG5RTcoxxkBPxEliVq03NA7Ovea1mh3WmKpKyeXrdwd
X-Gm-Message-State: AOJu0Yz1bCSaIQJ5JbtD3BhVvR0jXY6ZpvPp9t4WNDspfDk1P27JZxw0
	IuFzgUaBcvXkvPG+FPd7kunVQp5euOYyquyhHVphXEFdRaMeT+8f2LcxAwZlqbaLU/DvoOp2By0
	+jvd2frxji6K4hoPgQ3lnSBRbGNz4gfXE6y9s
X-Google-Smtp-Source: AGHT+IEdJ41Amqd1U+VYaV+EHraFq08EiG5z+/hezqT1qwO8csrJKX+iy6AtC9wIeKNmElPRqZnvAcO68SIb9kkEW5I=
X-Received: by 2002:a05:6402:51c9:b0:59e:9fb1:a0dc with SMTP id
 4fb4d7f45d1cf-5aacc18dcddmr188773a12.6.1721815464424; Wed, 24 Jul 2024
 03:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
In-Reply-To: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 12:04:13 +0200
Message-ID: <CANn89i+C=trNKcg0WNW35t=dM=0Qz_G6o1XzfDM-7JD+wFmL1Q@mail.gmail.com>
Subject: Re: [PATCH] net: Provide sysctl to tune local port range to IANA specification
To: jiang.kun2@zte.com.cn
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	dsahern@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn, 
	zhang.yunkai@zte.com.cn, tu.qiang35@zte.com.cn, he.peilin@zte.com.cn, 
	yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 8:04=E2=80=AFAM <jiang.kun2@zte.com.cn> wrote:


...

>
> Co-developed-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
> Reviewed-by: Peilin He<he.peilin@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>

This long list of reviewers, and having all of them missing the
net_rwsem requirement
for using for_each_net() is alarming.

