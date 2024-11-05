Return-Path: <linux-kernel+bounces-396624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACB9BCFB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFAAB22693
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1E01D7E4B;
	Tue,  5 Nov 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rCwN0OvS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5403BB48;
	Tue,  5 Nov 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818064; cv=none; b=frnKryqow076Fi+30HsCbTW4GSJ1iehHAHoLr2NGD25AhRpSNjZSH6oAVu8C939p6geD45LdRMp3TkGXVxITL6Our4QpJtqa0TPLRhN2UvTGnn3OshDtWCJl92nqtPwxgpfv3m0v7gUgmrMliOVQTotCRu1ONQUUxajnBwGtumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818064; c=relaxed/simple;
	bh=PoMXd7dlUgpkCKiBbkJd6Cewg8bQWQ/YiMv9xYOQ8As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+T//UuoaSnD2BRJ6mAkJCGgtIczKZ3tM7YbwbLcLRPzs0UGj4bvC9A9TKOJHzioAHD0CMHh2OeJMaOksktsA3wYh1A/dP2psh3yWS4MJLwc3Dc5froXPYv03yN3pugTywCDyVoPi7p+CPe84qf3pLPP+Vbecf2fFClC19Zg/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rCwN0OvS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EA92F42C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730818062; bh=JhjK8oTNggpbugVNNGBco7M0sdg9E4DFfHV94J2MJWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rCwN0OvS5F75E1dWKkP70arURvgbR2oYqARd44Iq2rzpnqySFqYpt+GWC42lhhaHe
	 bi8LqvjvipRcFI1eR6ecFAXE9p2ZVie0OS+WMDaI0+N6AXUai8E0ThRHyk4WeRtGA8
	 vzq8/0rWcK92gEhdGH0sbwBs1VpYgZUh2dDndZGdKvtkw9RR2OAJxrxovkw1rLSnUm
	 iczoZkj0ONLltGGE3WwfP23eKHGZsc2jsgmGCFBH79AHWskyMo6IKz1wZikoIioIr/
	 eE8zuKWn4Z0dh+O3YB69zCkwgAQh7vmKWOElUyKDrVIMFA9ZCQctdRnmHdNdU0iyWG
	 zJZquT6/ykT3Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EA92F42C18;
	Tue,  5 Nov 2024 14:47:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yanteng Si <si.yanteng@linux.dev>, xu.xin16@zte.com.cn,
 alexs@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, he.peilin@zte.com.cn,
 tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux-next v8 RESEND] Docs/zh_CN: Translate
 physical_memory.rst to Simplified Chinese
In-Reply-To: <641acef2-70f4-4172-9fa9-da0f5203a78e@linux.dev>
References: <20241028135321916ZWK032bHhlbncjvmzDkZs@zte.com.cn>
 <87ikt294v6.fsf@trenco.lwn.net>
 <641acef2-70f4-4172-9fa9-da0f5203a78e@linux.dev>
Date: Tue, 05 Nov 2024 07:47:41 -0700
Message-ID: <871pzp7n5e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yanteng Si <si.yanteng@linux.dev> writes:

> =E5=9C=A8 2024/11/5 03:27, Jonathan Corbet =E5=86=99=E9=81=93:
>> OK, I have applied this patch.  A couple of comments for future referenc=
e:
>>
>> <xu.xin16@zte.com.cn> writes:
>>
>>> Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
>> ...and this I don't understand at all; why do you need to reference that
>> patch here?
> We use it to mark the progress of the translation against
> the original document. If we don't put this tag on at the
> very beginning, when the translation falls behind the original
> document for a while, we'll have to go through the whole
> original document log from the very top downwards, which
> is an enormous amount of work. On the other hand, the
> checktransupdate.py also works based on this tag.
>
> Yeah, this tag might seem a bit ambiguous. I think maybe
> we could improve it? For example:
>
> Trans_mark commit 7332f9e45d2e ("docs/mm: Physical Memory: Fix grammar")

"Update to commit xxx" suggests that the current patch is somehow
changing that commit.  "Update the translation through commit xxxx"
would be a bit clearer in that regard.  I think it's better to stay with
something resembling plain language rather than adding a new pseudo-tag
that outsiders won't understand.

Thanks,

jon


