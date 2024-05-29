Return-Path: <linux-kernel+bounces-194020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D08D358B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD657B213B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396517B438;
	Wed, 29 May 2024 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG1vIyCF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27009169397
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982083; cv=none; b=RXutO005XLhFnNVJbJLRVZ01O9LzkGWMmLlX5hSMkV9enWYxkTQnS0ix6g55nznk0mcFsC6qRfpthxeCyf9M/HzGbDmcwiisERVy0OMAvFVWiXU9FNN631iGjlMuc1+Fs9uoqnW31Y9E4mlQa+6W90t04S6rvwbcw/dMzGereK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982083; c=relaxed/simple;
	bh=imM6wbNNhDFQlLHh0hY4tc0Miuy2SbOfK3Altmz/hTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO32Z2Yj6U6MS26W2xfjz5bwWqrIEFxhf0HUYRgrDFT9a6AbNLcBCCEzCJ84CgdlcWn8CDLIk+c9JJVIMISrtXrcfUJtaAYDKalKaqwqF3WNSnmyAkT+DICF7rMot/5p/aSGzOR6Ozfq1rRo3Ia/Zks+XmhfPhl6rXsRFH0Kf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG1vIyCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB872C2BD10;
	Wed, 29 May 2024 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716982082;
	bh=imM6wbNNhDFQlLHh0hY4tc0Miuy2SbOfK3Altmz/hTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qG1vIyCFCXlKWhycFd8PcMeYW3rjgS98w2/IWF+vnLkVlY8w5ToOC7xZNYIUocG2X
	 biGrO0fPEIujMI0xnXPtU+ad4IPnEyXxUPpwfVB8JNlX8nS+JxpsZxl25lvHpl967+
	 GItEyHPQTJRMRGJAeaWz98N720m4uSoKy42LFE6rAdgfJWU2depscf73CF6a39R2L3
	 cAKcoM/Q532yHFbXat5NyEQvd9BJ1Nt9RKusRsYZ27GE9YY/8zWpMh90cz/a+jeFoV
	 DI/L5mWhqeWaGTmXjbZ1fs8gxEKhxR464EHcsrCSSZY8Y18ZJSrveYZEc1j8NrOMNM
	 ksoyTLtIi9X+Q==
Message-ID: <674665d7-33b5-4c33-afd8-637222ebf04c@kernel.org>
Date: Wed, 29 May 2024 19:27:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: avoid resetting non empty zone
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240529112411.380453-1-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240529112411.380453-1-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/29 19:24, Sheng Yong wrote:
> If curseg is not the first segment in its zone, the zone is not empty,
> and it should not be reset. This issue could be reproduced by:
> 
> 	modprobe null_blk nr_devices=1 zoned=1 zone_max_open=6 zone_max_active=6 zone_size=1024 gb=30
> 	# /dev/vda is 4G
> 	mkfs.f2fs -m -c /dev/nullb0 /dev/vda -f
> 
> 	while :; do
> 		mount /dev/vda /mnt/
> 		dd if=/dev/zero of=/mnt/file bs=4K count=11 conv=fsync status=none
> 		if [ $? -ne 0 ]; then
> 			umount /mnt
> 			break
> 		fi
> 		f2fs_io shutdown 1 /mnt/file
> 		umount /mnt
> 	done
> 
> And the error looks like:
> [  123.169852] I/O error, dev nullb0, sector 41951232 op 0x1:(WRITE) flags 0x800 phys_seg 10 prio class 0
> [  123.173070] F2FS-fs (vda): do_checkpoint failed err:-5, stop checkpoint
> dd: error writing '/mnt/testfile': Input/output error
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

