Return-Path: <linux-kernel+bounces-562816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B7A63347
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 03:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D049189369F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF732030A;
	Sun, 16 Mar 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyhqtU5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3E5227
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742090631; cv=none; b=E/WwB6op3Hmdkt4/wKcbhVKU4OE8M5FSAcsOvN+Q3dv2hIx5ld8+bBUen2TCxTGXobRj5a2un0ZIt5WTNYH+HZ/YRCDXQsF+o6YJi00GW3eKlF1gHQ58FgaEphyROPnCvLISgNsv7AMRi+Wv/jMLUMuYmI7WirHnd2+Y1a8VngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742090631; c=relaxed/simple;
	bh=xdojLrL1ulbwn5kbc3SSUv+quj7A5W/B6BZ765yLndg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AVIQ73CXI5TkOoj4QBlTIaDx3V7xRzkxstrNk0/y7xvqn9p4mYbxsW6mTPEhf/oQ8lCozsSYB2H0GSE4EV+jR+wr1HwzJiy7egzveflcIIPyI0nv/wh1syF8rDqWlvlAp4JsQ5uQb/svRqXFeOxe1iJJv66NHqtAaxsn2rIhxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyhqtU5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5122C4CEE5;
	Sun, 16 Mar 2025 02:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742090631;
	bh=xdojLrL1ulbwn5kbc3SSUv+quj7A5W/B6BZ765yLndg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tyhqtU5sk5lAyxI1ghX1c166pstdJpKQUCmMAo98ROEPYEnN3bBEiQ2fMpA97wap4
	 gnWTV/A6IDK+o9sHACMoljMwi5IXoQkqYVOqt6csjzlrGXTjOZq2ZplYpAEb4GJYs5
	 Cz9tmCii+6Nqcyla5G6t6dyBAqbsNqUjmjM22pjqgMXeUo4Wj2mRyabizk9N+8oCHS
	 lxNNRSo1xCOBZw+z6j+Jwl5vmL1wMxjqHGsku3aMCHTgn91JEzSR7wEJy1Hfqsi855
	 C7AQbf3yTqkbq8vC/B4pJS8uWFADKag5TpQUNnHxgVtR7PVTVxpAZWDNx1CSr/d1Lq
	 49ugKIXQeeK6g==
Message-ID: <d013939e-9a88-4d5d-960e-ab5f59192e19@kernel.org>
Date: Sun, 16 Mar 2025 10:03:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2] erofs: get rid of erofs_kmap_type
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org
References: <20250217093141.2659-1-liubo03@inspur.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250217093141.2659-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/17 17:31, Bo Liu wrote:
> Since EROFS_KMAP_ATOMIC is no longer valid, get rid of erofs_kmap_type too.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

