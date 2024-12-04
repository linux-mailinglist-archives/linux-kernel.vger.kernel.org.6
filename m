Return-Path: <linux-kernel+bounces-430542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E49E328D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F16EB23B80
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C016F27F;
	Wed,  4 Dec 2024 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OMwwVy68"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5BC15A848
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285292; cv=none; b=BiyjfEiKL8iZBh1IvfhfueYyuA2je0nyL4Ny+OgaGbB9Kna2SlekMdJs8TSEvrE2tJOSKyX31YRBqk/GcG8P1s0upyHJJzqYyVEvCvFk5VH6uMjP1AJFiBcIi6P8SkEfyKrfrUYcZDEKvbU0P0q9BTDnt/3BXEvKYNi8vmZQkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285292; c=relaxed/simple;
	bh=TZQBrheMnsgYnQVhKxCW0PTfByccTObNkN4XCut593w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXLeRLfUaFgjMu8+JQb39WQb1GrSNof1Nhgx1p6KczSxAuQpUPL2ZFw+CVZlkRAhbY0RlkQCws5PL/Gia9BomBnVZVhJLSRrYuhPtmxunisIKR3PHPXEL9IOaDujSrAAvil/KGi02MpbFb1CvmLb8CKLeZpGYgcCpxs8n8q9Vj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OMwwVy68; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a29ecbceso7428045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 20:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733285288; x=1733890088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2ON5vU3fLSgPL/E2zKUe48MfnIXCn/Dg1fGkNj/V0I=;
        b=OMwwVy685ZdTIMJ5TUNMOQXXBqf1Y4MuMpe2aizwzQsne2ozgvuSzdV1JRDOLvZvtW
         ANz1JX4whfSrAFo6b8kI6HkYDqjeJPZp7593s7ebuKDxz4e5aKc1fXZg0y1ORigk3KI7
         UggyRoZj4cElx6sEzYRN8NwIPvs+5FCrqxTCU+d5CvAbxQVdPDkR24lfgxgZBsziqSa6
         1gqSjSClJCjGLDKFjJlFXEiX+vqudLHWyXSfHvrDrIbOf2lrCnamhi9zMgaKWpcapL+9
         0tJGWmYnKsor30TpCu+Xzjl5YOx2Y5P4F49t621gGiIZhRI2FwMM+MQbULU162hstbeK
         1mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285288; x=1733890088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2ON5vU3fLSgPL/E2zKUe48MfnIXCn/Dg1fGkNj/V0I=;
        b=VXrdYKDD56C1HEcZ8DFAia4jT5NbphsDYKbg2Oi7Vy/tPhVWw/npXLCclNpVgB2IZO
         wgREyrMs1PYspljluokgZnqaX/tHDjKxV/wUBA+QK6xUUZDvMkuF7HqmuBBJdvwwMbzC
         p6o68a6nWfjm4VvIGm8MsWDLIyINw8NT9v229U+SRV1Ozs4dnwQ39ia0CzoBfWy4g2Zu
         J7AhyeUGjWb4STcwmUet3VL2+qE5u3yrJGm1/2kYVV/gzW1bbwKnJr+Arxa0/ft9CdIK
         gBirIAQUfrr0SlGiXPdyJbL3IxV49sIRS7sKG78aIlibs5x2YQ2rSOILfwTwJNpLGQSR
         Cb+A==
X-Gm-Message-State: AOJu0YzPsXW+GjcWx6S/EbWv0SEpmacTWzM4UMSSeuH3WPPCxQLO5Z1b
	ov9PKgCp6bpDaL2oz28IB4Jsg4Jt9rkj+Dvh2NfSObbSHVtL5cwti0WRQdqtlEY=
X-Gm-Gg: ASbGncuZV+3IH2WwO72J1idr3I80QdLee4KY0lZF3MphaZTVhy2reOzOky0guTkp1SV
	AJlfsmn4MttY6Ih/3kPeVhrNooy+pZLuQm6LIHBGMa8Lx+VO0pBI85qp2oIwnvzoDiy4OYPpfXy
	bZg/dpyqO/MAms8n7xdfZ3Hq+0LL8cBDzbHeK7OCpb3IcRgjhQRLYCTE1uxHclrnQL5AsJCFJbq
	ggbIZBTC8s3SZL9SlXEAhn47qPXf17PDhE5maUVz7g5EAL6u2Cx3Q==
X-Google-Smtp-Source: AGHT+IGHxvkiCBB4NiaPLH6M0SGztZMFIbJXXT9ig9h0h8STLB/tXqB8/nl4xw6BPF3PioI3NBI78A==
X-Received: by 2002:a5d:6d08:0:b0:385:df73:2f43 with SMTP id ffacd0b85a97d-385fd3c2f57mr1572855f8f.2.1733285288539;
        Tue, 03 Dec 2024 20:08:08 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbac2sm11301175b3a.96.2024.12.03.20.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 20:08:07 -0800 (PST)
Message-ID: <a785bbf5-7fa4-4c22-b4db-32df21695073@suse.com>
Date: Wed, 4 Dec 2024 12:08:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ocfs2: fix the la space leak when unmounting an ocfs2
 volume
To: joseph.qi@linux.alibaba.com, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org
References: <20241204033243.8273-1-heming.zhao@suse.com>
 <20241204033243.8273-3-heming.zhao@suse.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20241204033243.8273-3-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 11:32, Heming Zhao wrote:
> This bug has existed since the initial OCFS2 code.  The code logic in
forgot revise commit, very stupid mistake.

> ocfs2_sync_local_to_main() is wrong, as it ignores the last contiguous
> free bits, which causes an OCFS2 volume to lose the last free clusters of
> LA window on each umount command.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> Fixes: 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
> ---
>   fs/ocfs2/localalloc.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 5df34561c551..8ac42ea81a17 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -1002,6 +1002,25 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>   		start = bit_off + 1;
>   	}
>   
> +	/* clear the contiguous bits until the end boundary */
> +	if (count) {
> +		blkno = la_start_blk +
> +			ocfs2_clusters_to_blocks(osb->sb,
> +					start - count);
> +
> +		trace_ocfs2_sync_local_to_main_free(
> +				count, start - count,
> +				(unsigned long long)la_start_blk,
> +				(unsigned long long)blkno);
> +
> +		status = ocfs2_release_clusters(handle,
> +				main_bm_inode,
> +				main_bm_bh, blkno,
> +				count);
> +		if (status < 0)
> +			mlog_errno(status);
> +	}
> +
>   bail:
>   	if (status)
>   		mlog_errno(status);


