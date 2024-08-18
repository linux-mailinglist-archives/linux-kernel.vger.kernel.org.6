Return-Path: <linux-kernel+bounces-290999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087D955C1B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C2F1F21670
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5117C96;
	Sun, 18 Aug 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M2ZVek8H"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90814285
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977107; cv=none; b=pINDwl2TJmTPDG+Np/18c2XQxMEJeVPveH4GDcTEKmWRMKTd900PmB2W3uo6+EojMoGnzHDXhsa4rDpt0GkTRcIZTogOFAXSODJbswFK18VINdBiyC2CMR3SuuNKbwPBraZa5M1qV7JkZIKPeQhdoBhZTIk9G/ZOEmEJCpXDJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977107; c=relaxed/simple;
	bh=4K7mKnCBdXiqVPpyYPuFnTNVm6B25O8KuVa7kOzymuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8ENx4jNvt4RpL0ztE6pzYDbDCwV8CYXzAf9yRy6JLMWZTHPXytd42ElnrXRanGARjBL6DKZFZ4TWdxh1sBHukBuYgc/MKxREWq5IWNvjP1ANpPgTcY/lC+pMF5eweUqH00wDZ5jzNWyr892TlmxcZT9lXGTLZ0mnqFnrpWSRoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M2ZVek8H; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso237156f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723977103; x=1724581903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hT6IIPT/Q7vxLCeBHiJq4nP20R/hkDkoYUOFw2T0UCs=;
        b=M2ZVek8HREZaCQLcXcnY8xCS0OkkaVmhBE/NfYiTQQ4PjFCUtdHkywRD8YbJMoNA3Q
         vqFDgw49sCwBKSdtGRox5sjeIxY0jFlq/fNjYBUG1GzGiH2ycX1fRdaX8tAtrnRIDOda
         lHheMagH5eroKnvFIMBCwye4pHvcv2dUvxNAsjCXKWKhtDf8gWNyn0h7qq1nxLvEmF5+
         9PvOgnrs2LSodmOxAcFEnHPkhRSXcvxGpLM4/bLMdcotwZMka678yk50G8gN5ocjw9Cw
         SPq0qZHD5Th42h4QVLBIlOVbHSo7gTQ7MWzHO+h+ih26Oa1lIlGwfF0LPRug69LLHPxs
         8Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723977103; x=1724581903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT6IIPT/Q7vxLCeBHiJq4nP20R/hkDkoYUOFw2T0UCs=;
        b=pwdB9wq97UKeJY2+G+g4dMdLJHNA6DHGf4+S7uHpJ9MMGbL7pXtlpMBjxeACKJavoY
         s3TppRDOe5UwAwbZa/+quCWDjuWRD4MuB4o6h21U9GjWIl6rYLMvoZGSFke3lbaCUoJF
         pdU9dXkDtq2kBP4wI4v3Eo4zugJ/Y760pbi/HgqPEBLFmDM3Ifbydv2Z7vOK+fowOprn
         O8Lbqh6+HSk1jvvwUqj85yVq2SU/W7GmkcEih0MX0v7n/RXG7MasXk5kuW3S9RIrHXuy
         b9FQIB5V4vxmZzv9hneRkzPok0sEAgZBfDjEa8JH4FbwW9+BQu6IOo+Jaq0X2f9R4JKD
         l5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUDneuf2ocTNDmHnmS1+J5RW1uXtTs24ZBsKoVichoPhDeIZDXWp7rAL6sdkDey1lKzm6Ew7qBYa0cGl+oDFJHGlDcvQgXnTZt8/AR7
X-Gm-Message-State: AOJu0YzNmF/Ez4hLcdrBwor3AllvG5ka3AaBMTksJiMPlv40INNVtwbV
	fu26eOEQeIfbD7D/B0I+dUUogPgdfW9cqzte83akawn915UzT5zcYjL8ICrZFbA=
X-Google-Smtp-Source: AGHT+IFCbBc63RMQKFvlgM35DJE5gbz6Ke0sfHq99SQD6oAwbq7SmoSbMUm0DsA+Y09a2JW7CO3HfA==
X-Received: by 2002:a05:6000:b51:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-37194314f8amr4866508f8f.10.1723977103190;
        Sun, 18 Aug 2024 03:31:43 -0700 (PDT)
Received: from [127.0.0.1] ([192.177.92.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb2esm5086164b3a.64.2024.08.18.03.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 03:31:42 -0700 (PDT)
Message-ID: <432954d5-3b8e-42f7-8c06-1a489281129e@suse.com>
Date: Sun, 18 Aug 2024 18:31:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix unexpected zeroing of virtual disk
To: Chi Zhiling <chizhiling@163.com>, mark@fasheh.com, jlbec@evilplan.org,
 joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 starzhangzsd@gmail.com, Chi Zhiling <chizhiling@kylinos.cn>,
 Shida Zhang <zhangshida@kylinos.cn>
References: <20240815092141.1223238-1-chizhiling@163.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240815092141.1223238-1-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 17:21, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> In a guest virtual machine, we found that there is unexpected data
> zeroing problem detected occassionly:
> 
> XFS (vdb): Mounting V5 Filesystem
> XFS (vdb): Ending clean mount
> XFS (vdb): Metadata CRC error detected at xfs_refcountbt_read_verify+0x2c/0xf0, xfs_refcountbt block 0x200028
> XFS (vdb): Unmount and run xfs_repair
> XFS (vdb): First 128 bytes of corrupted metadata buffer:
> 00000000e0cd2f5e: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000000cafd57f5: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000000d0298d7d: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000000f0698484: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000000adb789a7: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 000000005292b878: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000000885b4700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000000fd4b4df7: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> XFS (vdb): metadata I/O error in "xfs_trans_read_buf_map" at daddr 0x200028 len 8 error 74
> XFS (vdb): Error -117 recovering leftover CoW allocations.
> XFS (vdb): xfs_do_force_shutdown(0x8) called from line 994 of file fs/xfs/xfs_mount.c.  Return address = 000000003a53523a
> XFS (vdb): Corruption of in-memory data detected.  Shutting down filesystem
> XFS (vdb): Please umount the filesystem and rectify the problem(s)
> 
> It turns out that the root cause is from the physical host machine.
> More specifically, it is caused by the ocfs2.
> 
> when the page_size is 64k, the block should advance by 16 each time
> instead of 1.
> This will lead to a wrong mapping from the page to the disk, which
> will zero some adjacent part of the disk.
> 
> Suggested-by: Shida Zhang <zhangshida@kylinos.cn>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>   fs/ocfs2/aops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index d6c985cc6353..1fea43c33b6b 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -1187,7 +1187,7 @@ static int ocfs2_write_cluster(struct address_space *mapping,
>   
>   		/* This is the direct io target page. */
>   		if (wc->w_pages[i] == NULL) {
> -			p_blkno++;
> +			p_blkno += (1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits));
>   			continue;
>   		}
>   

Looks good to me.
Signed-off-by: Heming Zhao <heming.zhao@suse.com>

