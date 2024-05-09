Return-Path: <linux-kernel+bounces-174610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6D88C1189
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FC283371
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C9149E0C;
	Thu,  9 May 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YxneFfN+"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F612E1F6
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266406; cv=none; b=SqrCtLpVf+JzZIaKeOStQf91ZSL18zxZL4K/+1VaPvOXEB5xx18/lg2ZOkLw5ynHqjDkdggWoPYJlrXwkfVFXe9mdsEonEwkfi/APuJGG6+TrrKJXnhh2+AzNLNdZyMk8xgCQsAxUnTlI3GQpIUFCfeqGwcvluyZlu9xsroqkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266406; c=relaxed/simple;
	bh=iphw/ebLUgWrwbM5bvrzNsoS7jwizXNu5c2Xm3d0Cj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLZf7Ns5jIw/f5vVVKUutC4HqTvJPqM+Kn9RRL964Tb2W2CbtYZDF5bC0C+HxavUt2yI8V733buu+dgU8/yDYwLjz3V53uqo4/sgGRRuiZ6/sxGi0wUnF9ma0n5MXC2e9J9S9LWs+dGacjjKsO5PYBquD4VD+UZdgtCPPIMdvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YxneFfN+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449Er6XR026274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 10:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715266388; bh=4OAq8NjuXonF922+Ntk/mvwXgwHD/4pzpWQasDGOnmY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YxneFfN++gsPMYvITKPOkipy7ZBDBkC7jUPiLML+3kNMPMgTX3tHnQeIcQ2oBTCwe
	 yqFHbj6M2i+2nQG8D7jZyHHQJT7mDwta++Is0YUsEmTu5cJOVJy1PcN7+3pCJiymjb
	 9uKYa0SavhxTGxeWjaiU3cF/PpaZ4/LDLKV6DmxNAssaWcTjPJ74TTdwfvLjXWUfEE
	 +zekRQ4Yt4iHef6VLS8lI13fFt7Zri/4Gkp94jxDeD91pp/gCi3DzJCC/bXCxC6a4r
	 YHfkAaVn0cnYteUiDeXvH5U6zsTaY5HUfosfDvkdGfIcDvFEpx1f5m7frKF6HHw67c
	 oLTIgV7JYUgwg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3721D15C026D; Thu, 09 May 2024 10:53:06 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH v2 0/2] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
Date: Thu,  9 May 2024 10:53:04 -0400
Message-ID: <171526637520.3651173.11142126746926248969.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407065355.1528580-1-yebin10@huawei.com>
References: <20240407065355.1528580-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 07 Apr 2024 14:53:53 +0800, Ye Bin wrote:
> Diff v2 vs v1:
> 1. Update/add comment for __jbd2_journal_clean_checkpoint_list();
> 2. Add 'jbd2' prefix for 'shrink_type';
> 
> Ye Bin (2):
>   jbd2: use shrink_type type instead of bool type for
>     __jbd2_journal_clean_checkpoint_list()
>   jbd2: add prefix 'jbd2' for 'shrink_type'
> 
> [...]

Applied, thanks!

[1/2] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
      commit: 078760d950016f5982751f5512e69f26ad8feb31
[2/2] jbd2: add prefix 'jbd2' for 'shrink_type'
      commit: 26770a717cac57041d9414725e3e01dd19b08dd2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

