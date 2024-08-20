Return-Path: <linux-kernel+bounces-293538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEB95810A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15481C23D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266618A6CA;
	Tue, 20 Aug 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MGvDWWeH"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C234CE5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142758; cv=none; b=RK6fZA7vSQVR4nihMBNvoFzUoNEV7/cujWSRwlhCeI+8sq4aEOZ6Vq4Gtwomk5L6dxNa93w+Uje/QyBkOmpIJuzxGPrukGwR5Fgmj1TQrFRnO0BPX4G1DiaBeqQD7czruUzjRkfD9kfQqiz16LgIVAZqc5qmKM4DfRj65k/Skj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142758; c=relaxed/simple;
	bh=PgAAwi3ABtUV2uBhW15Onu0kh0z8ocEuwBZ2+wxVxVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUL9Uawkqtf0FHJ1MNz+IH7SDIL7WSSpOzlloqrA0gkj2CIwcJP8CRSpO1K2NW08BqEwHa6KcuDGiNqN83kJqVdKOLupAOSzSSKWKXAdrZ9xZsJAcTCh10HJwzsoNNdLSQuXc8WnMgIBK1+Qpjo5DEEVeErT0GgyWTYkl+n2iXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MGvDWWeH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso51257651fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724142754; x=1724747554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlH8CopQ7GW3XFywQZo01UHpbUpx8ne/x30K0676QQ0=;
        b=MGvDWWeHx1axk/XLfV3ZBU9xGPNG/Gk3ZqVAwXDPsJmQPjzAePdTMpvmaaCubWOF0M
         PLj+IercryFWchNR4xnL+YzsBzeJSeaqdebDgmgrGKEeIiG2Vfy2LLCxt3EKvTwkoaSq
         fYaNsQpSO2o+/XzyUA0wyglAHlmOeY/YlmqG9/nVblnmxprukohwBjhAfZzkOPX57HUq
         tG3ende2xz/Hh3YFXHuu4y6asRfBTxgOewCLjqZlE9/aG3YDNZU5z6eO3tRlwn6hWFL8
         Ld/raiMEnXyEqp3brzG6P1Li7T7LLho7MhUIdrdsIbDw1FWmp6hczIZpehEBuyzIV/s6
         hqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724142754; x=1724747554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlH8CopQ7GW3XFywQZo01UHpbUpx8ne/x30K0676QQ0=;
        b=cwyMAiC+PQXvf8KtT5Fa2WThgZzuJneV/l8p0guKJl6n23UZOOO5JZIEX/oMXqSWYm
         QdO239cvi3I6ULI3iuEqEAo+Zp7cwuHGU7uz0+Sqj2Uz8anpbey8WlatbiI0eidqWtcF
         k7ZTv+LqYb6ikKmQCzViZxfdszIJywo44LPcJS51H2ijrRKNeRI24P04YiTlJrvXuqLx
         hGNeDW+HT6ijJxLerXlVz/C3eXBCR54W92oHJpHxe5CBf4vF4Fm8qoNS3ORHJ+albXnB
         9prZVC+R9lAUQW/UTWjUnIlBI+5D8h/wKAcnXKmOZBRlkQvrRYxFRnzmWbd5xb1Tk7Qx
         ltUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4lUI41+qLfHW4acVOu9o/c8Lq7+zR9kKZHFGMPCB9TGJ6qSDxnMTma33qQJdyANrwZorbjJfWVlph1ZUq+iw1C/AoXrEiFH8e88G/
X-Gm-Message-State: AOJu0YzMk1rbl5zJTTGdjFbQBipeHFArA6pUgUKZrKruihmYls5m87mz
	jVNIUV8mc7LXAsZDXF3bxLhLSOe+G4UUv0xO5ngaKNiIG2EqAiLc/b4LEeH+q4SjU1SGlVq+d71
	F
X-Google-Smtp-Source: AGHT+IElV8FXU9Q6EEmABmhvrh+lahp6xj2LFEIEf1QhrKDweKz1u5w5NdpW4uS1wZNhYW+l1Xol9w==
X-Received: by 2002:a2e:3515:0:b0:2f1:a337:958d with SMTP id 38308e7fff4ca-2f3be597903mr82730551fa.24.1724142753616;
        Tue, 20 Aug 2024 01:32:33 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b65a9csm8678000a91.3.2024.08.20.01.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:32:33 -0700 (PDT)
Message-ID: <980b3f4d-f265-4eb4-96a3-8f1a75588193@suse.com>
Date: Tue, 20 Aug 2024 16:32:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ocfs2: Fix uaf in ocfs2_set_buffer_uptodate
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <2d6499d6-fd03-43d8-9595-5babfd82481d@suse.com>
 <20240820073739.1289567-1-lizhi.xu@windriver.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240820073739.1289567-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Could you resend v3 with both patches?
And add my "Reviewed-by" tag to another patch.

btw, you miss change log area from v2.

-Heming

On 8/20/24 15:37, Lizhi Xu wrote:
> In the for-loop after the 'read_failure' label, the condition
> '(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
> When this contidion is true, this for-loop will call ocfs2_set_buffer
> _uptodate(ci, bh), which then triggers a NULL pointer access error.
> 
> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   fs/ocfs2/buffer_head_io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index e62c7e1de4eb..8f714406528d 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>   		/* Always set the buffer in the cache, even if it was
>   		 * a forced read, or read-ahead which hasn't yet
>   		 * completed. */
> -		ocfs2_set_buffer_uptodate(ci, bh);
> +		if (bh)
> +			ocfs2_set_buffer_uptodate(ci, bh);
>   	}
>   	ocfs2_metadata_cache_io_unlock(ci);
>   


