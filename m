Return-Path: <linux-kernel+bounces-361462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543799A891
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45153284734
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8985198A10;
	Fri, 11 Oct 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlslq1fj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C4194151;
	Fri, 11 Oct 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662680; cv=none; b=supmQWxNkytbDbns4qL1pmL7yfvh+S0zFMRBRKIttMboN2VVPZQs4J+o9LONnBMVridQfb/oPlpvSVmhmQvTEJzN928325E7Sa1Nmwq/szkTMt/m6IlZTkVqZ++cllGS/TtKz5G3KZ7wAWJkkruo51VJIHw+1Ut3kdPmK8BiLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662680; c=relaxed/simple;
	bh=btdIZJkFl8Hi+v1GikHVB9SQM/XDWtE1YVNm9S45uvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtpHlTJhuHnViWdFUYKDi70fLNCqA6i/Wunf2Qw7LM2/7qU1kJ+u6YLjMcimMg40JpN10yanMaqyEYqmVyGJvfJ3dEXUb9QQBUBlADciaj2nNjIzfgEYHzlmXdiClmth4MwHtqiGDUzi36R+Tg9klffQxj8KjgVdvnaJ/SWXELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlslq1fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4561EC4CEC3;
	Fri, 11 Oct 2024 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662679;
	bh=btdIZJkFl8Hi+v1GikHVB9SQM/XDWtE1YVNm9S45uvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jlslq1fjARbS6bm+IXYzvpiCOQw3m++HieVubKqsJSxcQL9mX25hA+e+CS5341dPH
	 IcExcXAQjczYoz1QiDKdUCKWN+QdKM7xPHVp6cAqTR4dgRXrKO9/hvwmy9Kp3d3xJ7
	 bdky2Oqnebo5JlRSUNLdtyV7WxESTdtXaKHYps6l3WN4FVGMSaTF6Dp2mzBsvTXRwJ
	 9A4jCscKsvtXAt4YYDTDDjwzUPYFgapSlAQK1fLNg5FkqMdYpl6fp5/Ag8F3Kyeeqi
	 JqFJt2wWKZ9MiSCQpZSErsN3pJfQIWvI3lkm47kk1o5ELwD2ObJa+vbXJS5S9Pucy1
	 Sff1x5RPaPVKQ==
Date: Fri, 11 Oct 2024 09:04:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/5] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6mr_compat_ioctl()
Message-ID: <20241011090438.135501c0@kernel.org>
In-Reply-To: <20241011074811.2308043-7-stefan.wiehler@nokia.com>
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
	<20241011074811.2308043-7-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 09:23:26 +0200 Stefan Wiehler wrote:
>  		rcu_read_unlock();
> -		return -EADDRNOTAVAIL;
> +		err = -EADDRNOTAVAIL;
> +		goto out;

double unlock

