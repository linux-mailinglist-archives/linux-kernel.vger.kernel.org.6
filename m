Return-Path: <linux-kernel+bounces-557610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1757EA5DB85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519D2175601
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B987B23F28C;
	Wed, 12 Mar 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey2qd3ZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26641155333
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778935; cv=none; b=FG59iu0HW6lW6o+G1vULH3aoxm1YHKF7dKGKQOef0atE40K8d+E0v8AFx1MoQUCt3u2djRIKzci8LHM01ZpyZjkkJPzgoQTO92eFKR0qRUSlsyNwMznRd1XrEsEQnT22z1/B6WNdkRZyKM72v9YyaFjMOVgbs/ZHjGbpPkqGL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778935; c=relaxed/simple;
	bh=+vV1V2eoLR31J9Ee8ZAsdPdScEOay5/Fbu7AWX0b4DU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JsUwZpiebuW7nRO8yEYoacTYdgA0PsgT4bQObyTVRqnHykHJfciABldIUub1JSIgxKk+q3q1GP64xU4apHL+rNwEOBrWqW/DXU4v6zwhuaJcf/KmIVGp6RY3Y7Tf7AMEOdO/PJxO6eJqEunaVTEyomTYrGknYH+5ZxKrM2tlhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey2qd3ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704C2C4CEE3;
	Wed, 12 Mar 2025 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778934;
	bh=+vV1V2eoLR31J9Ee8ZAsdPdScEOay5/Fbu7AWX0b4DU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Ey2qd3ZKS06k+V60Q99DwWpEJW4p4E21s8H7VBoEq8iIGdwUBRabDFFiUzNolA4me
	 wj78QdfrtGtmsWFRtnSeO72TjguID5A/9GS7tb9r+m5facMLh0qqi3biPnqb51MqzH
	 Zyzj8d2frYaCQiwRqa2aiFtIWNwcJjFrzEWHlgiRp4DM+0uXSbwMVSspOjMklphNEd
	 0JL+jlrqwAKBnEiHYJqShNlRQctRAQmKJr9YAO5FxDcYx8eLm3UZHu9vxKh3qHSHRq
	 jrg431ZZ9NtDV8Kf6uGgK1BEyq4DZav0fpRPush8Mbep+wyZjYvZ5f1xlT1fSsDVYA
	 AOVrTvo76pdNw==
Message-ID: <9c66f3f4-2ea9-4322-91e8-fb88e2a055e5@kernel.org>
Date: Wed, 12 Mar 2025 19:28:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix missing discard candidates in fstrim
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250312102005.2893698-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250312102005.2893698-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 18:20, Chunhai Guo wrote:
> fstrim may miss candidates that need to be discarded, as shown in the
> examples below.
> 
> The root cause is that when cpc->reason is set with CP_DISCARD,
> add_discard_addrs() expects that ckpt_valid_map and cur_valid_map have
> been synced by seg_info_to_raw_sit() [1], and it tries to find the
> candidates based on ckpt_valid_map and discard_map. However,
> seg_info_to_raw_sit() does not actually run before
> f2fs_exist_trim_candidates(), resulting in the failure.
> 
> The code logic can be simplified for all cases by finding all the
> discard blocks based only on discard_map. This might result in more
> discard blocks being sent for the segment during the first checkpoint
> after mounting, which were originally expected to be sent only in
> fstrim. Regardless, these discard blocks should eventually be sent, and
> the simplified code makes sense in this context.
> 
> root# cp testfile /f2fs_mountpoint
> 
> root# f2fs_io fiemap 0 1 /f2fs_mountpoint/testfile
> Fiemap: offset = 0 len = 1
>         logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000406a00000 000000003d800000 00001000
> 
> root# rm /f2fs_mountpoint/testfile
> 
> root# fstrim -v -o 0x406a00000 -l 1024M /f2fs_mountpoint -- no candidate is found
> /f2fs_mountpoint: 0 B (0 bytes) trimmed
> 
> Relevant code process of the root cause:
> f2fs_trim_fs()
>     f2fs_write_checkpoint()
>         ...
>         if (cpc->reason & CP_DISCARD) {
>                 if (!f2fs_exist_trim_candidates(sbi, cpc)) {
>                     unblock_operations(sbi);
>                     goto out; // No candidates are found here, and it exits.
>                 }
>             ...
>         }
> 
> [1] Please refer to commit d7bc2484b8d4 ("f2fs: fix small discards not
> to issue redundantly") for the relationship between
> seg_info_to_raw_sit() and add_discard_addrs().
> 
> Fixes: 25290fa5591d ("f2fs: return fs_trim if there is no candidate")
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

To Jaegeuk, I'm fine w/ this change, but discard is critical, could you
please double check it?

Thanks,

