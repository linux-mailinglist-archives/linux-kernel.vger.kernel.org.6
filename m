Return-Path: <linux-kernel+bounces-373947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BDC9A5FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4DC1F22105
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CE1E231E;
	Mon, 21 Oct 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8sde/YV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612A1E0B91
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501515; cv=none; b=FnIMJMVEGfZ7pqslatrwS+BFIlwfZNQqEHBZmUe1flGShml3vN8GxpGNRdLC9+miBw8jwqRx8bAh3QRvknU4BeTyKKfF29q6JiRzKucCGOJXL8j5eZwEZO+FbKJuVGOUnqe62KRrxUwnFvwb5eY9vZF+rEbgYBjbrEM0T3yLKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501515; c=relaxed/simple;
	bh=U0XCZwW2pc6q4EXiiGWtDURI1Ew4V3wwkpW0XeXtwhw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QXMoj2AAPuaUVoCmLa1b44Oc9/FJ4nQSyWLRGCXdaHXuSUS89VD/xqbOJXVNq82bvjX7p9YLEIuKmRAa2RHa4YR3ysuRPlWINMFCgYgPKdn+AD8vZsgE+FCKx0IPU775SXp4CEQTJrsbbJWlkJbuJ5e7dt+po7sbMj4+yZW8cmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8sde/YV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC72C4CEC3;
	Mon, 21 Oct 2024 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729501514;
	bh=U0XCZwW2pc6q4EXiiGWtDURI1Ew4V3wwkpW0XeXtwhw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=O8sde/YVzg77X8UJo7Cyw/S/OhIHVCZvplX1medByQIL1VzegoPx1+f6QH/iAeGPD
	 qh+thcCscxCGndlYtoViuhtEk2dzkiW8fwK7AiZwQikfF8T6eHS1j1+KTqSVSxAFPf
	 HJjKP08ddFIQFG554kQOAc+jrffUHFTlRg4DhjowOqt8nmD2tg+qIjCOZjnIi3qJqP
	 pPL/4ervhQWspxfDxtKgL0Qi6q4VpVdDKZ/FSC4QNBMo808v4r8t54RTOoqNMvLpM3
	 Zc03a2JFW2NAKWceYvKK+vSwT2/E2pqN0IkJHwBCE2vRNq9h3NT4FJ6pCD0Lnu+i6P
	 UkQZgEz0ZnPZQ==
Message-ID: <b91d43c6-8065-4b40-b622-8df1824515ea@kernel.org>
Date: Mon, 21 Oct 2024 17:05:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: check curseg->inited before write_sum_page in
 change_curseg
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241021044801.1358850-1-yangyongpeng1@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241021044801.1358850-1-yangyongpeng1@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/21 12:48, Yongpeng Yang wrote:
> In the __f2fs_init_atgc_curseg->get_atssr_segment calling,
> curseg->segno is NULL_SEGNO, indicating that there is no summary
> block that needs to be written.
> 

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")

> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

