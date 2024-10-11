Return-Path: <linux-kernel+bounces-360452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA0999B28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F2F1F24550
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD821F473E;
	Fri, 11 Oct 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwBup2Ft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6BD2FB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728617030; cv=none; b=R5TBT6Zr/KfikqIVwzTI5oazFdLyMz3UeoAuSHq97ags2g+4CP7ecAjMCKoZmPsWRwPT+QBOMDEw5RUG0ytLB1IKACzgXNuFUAJGKuv+4wEderwqJFvxJ6mD8mbChtcwXYoHznSxb2K1mEBVI43MuzfJzYgZgG12Ni8GQijlugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728617030; c=relaxed/simple;
	bh=Uebx/oNcKWECtLhnrymtjaw7rE4TW8QKrIUn/TUZzJI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F+D5n2WHWWGXbx5uN9RYiBtqwFwLpSzr3UqvRzAISqAtb221RirLZprYf0bnkp3C2nelOQruo1sEeUiMVS+iPrmnARZ9CkGKZ4e2oY15SO2ijS/VoZYCkRshqv7KbYTRgvFzCJ0zc5uy4SeWaRr11zfT3rQ27S5x6J95Nu0bcYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwBup2Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB96C4CEC3;
	Fri, 11 Oct 2024 03:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728617030;
	bh=Uebx/oNcKWECtLhnrymtjaw7rE4TW8QKrIUn/TUZzJI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZwBup2FtT3HzT32tEiDuzeonnigpQskMYb0iYtniVwZGnX0LdRVFdO/Q3Qd+9d/2F
	 +C4jAeDAkGxqLcFtlYAIjWQwpPoHQphny3GGQ3ZI7v0R3yGBCrhKvm1BOM+4ZH00tV
	 sOR5ioU+8V2vbu6zbJ2ZG8oMMxZCYpm6nCtipXgwdgrYfqB94IsYH0Fk5FWT8js3Ep
	 wO8lrVV6dyPAwaWjjkh5qvcMGKxtrFAHlUIvW4MkHuw67k5J+V7AWg2KdHxSveudJp
	 aceCuOZ4ROMyk/pkbExi+BYR0mqi9C4/IxtOZHbwFIyVeRJVoPNrRtP5SraWOJqzzf
	 EtrRjBMh/Ekzw==
Message-ID: <a6ed3ae5-8ed2-4e7c-a790-8771adae121c@kernel.org>
Date: Fri, 11 Oct 2024 11:23:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] erofs: get rid of kaddr in `struct
 z_erofs_maprecorder`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
 <20241010235830.1535616-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241010235830.1535616-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/11 7:58, Gao Xiang wrote:
> `kaddr` becomes useless after switching to metabuf.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

