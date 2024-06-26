Return-Path: <linux-kernel+bounces-229812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0108A9174AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0CE28560F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658B17FAA6;
	Tue, 25 Jun 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQPlY/Wp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BDE17D88C;
	Tue, 25 Jun 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358022; cv=none; b=QRIg82kFx/YgsuMAOzGjFS6KwJ2vnXX7rWAxBGqIapm9GnmaIL68GJF9NI7lDn4ymDXLUjJ4qNff/VITEU6VLIKvddbXZwVyj5l4S4KKGIOuUy1XdSFwsJTz5zr1lqx5NLFezLLfhPJpEEttYAnADCH5VtrCgo/LhMKfLaLPavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358022; c=relaxed/simple;
	bh=JNPQ2HaQaJA9py3STciE5ETfWcfSH3lkOJTOv3+6uUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hy2MWfZu7rar/vvUPMudTAtrrgTshHj9svxllq8Dp54BkKCDcRw6l/We9IPU9lH93nzVTulADPyGHnEU4LQoQbVO3rNgW2VC/RggRG8ab7V5ycDhXztYf6NufH+9ABHPgDPj44HBYo7ukqjnW+i3vToNLpJFNXo5r1kY9v1h/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQPlY/Wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE0CC32781;
	Tue, 25 Jun 2024 23:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719358021;
	bh=JNPQ2HaQaJA9py3STciE5ETfWcfSH3lkOJTOv3+6uUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQPlY/Wpw5JhwkCt00yEbmdNphHDjboo9LK/IUNFYMLlPHJITvlUrhAg02ZqInyKW
	 NMvPpyOv8VBfbExwb/Tnn9s2U0RXSpcMEu3kRMcZpYoss2nOXg3AyRUuTAlLdLgTd3
	 nHRQqM9f6zl4uJ+wfl/DYyXMn4Sl/8FH99mF9sXTrZSAYUC4Mop49fo1y5+OTSimtP
	 ffypwoc11IbMFjDwOCJusBlK70NLoMrW3O4Y9FratPDHTPQItNF+Uj7y5goUgPBa7K
	 ye4kOHv83dmb+B3iYbYVz42Ku6gtnzYvC8vFiuru23KbdmSni7oAHg8p73twu9bcYc
	 gY9OGgub01jQw==
Date: Tue, 25 Jun 2024 16:27:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v9 00/13] First try to replace page_frag with
 page_frag_cache
Message-ID: <20240625162700.56587db3@kernel.org>
In-Reply-To: <20240625135216.47007-1-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 21:52:03 +0800 Yunsheng Lin wrote:
> V9:
>    1. Add check for test_alloc_len and change perm of module_param()
>       to 0 as Wang Wei' comment.
>    2. Rebased on latest net-next.

Please do not post a new version until you get feedback from Alex
on the previous one. This series consumes all our CI resources,
we can't get important patches tested :|

