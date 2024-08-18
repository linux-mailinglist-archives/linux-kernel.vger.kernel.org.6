Return-Path: <linux-kernel+bounces-291024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1C955C50
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928A51F214F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B71B964;
	Sun, 18 Aug 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RQ7ytieg"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5617557
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723981441; cv=none; b=deAf7zz/P8JBnTaxc1QdDAHGqFQgsNt6t4kKdlODc9c49XbrkW4nvX5u6ekh3+aJOTU9ZvB/XBaV+hhX8urSpEFuT7QVUyM3gY+WS3KNUtNnrn4ZGOrlHPu+X11AK7mbrfE0bnNo6SBZRETYxAimvXKo+JtDWXvBPac/zdXSYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723981441; c=relaxed/simple;
	bh=dLCARgwVurr1QJuhRCu+K/rPZakl9JnQqKm0TnTm45k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmk31rN0QKCs3Sm5Wlc1/Yk9MXBxF9M1pmq+W9xASs/l0/3BfgTdqIunwa1JdzWrhpyUvNuZ6HCcTUvHXlZl5iJPgqbfghlgzaZbjSvFwO/CDf5w1wjz2ZwWitqbeT5qtxFW7NriTdHdWeE+HJYEGrlTllriAuA/GWmORG/qOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RQ7ytieg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso39785961fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723981436; x=1724586236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CsHkOt9vf+tSdFHHxlwcTsV2VHa5VrYFOWKNehVdrc=;
        b=RQ7ytiegfTixBYsLlWFkoZsodBOSun7YmC9Ex47EFhTNbCWYMQ4h01rig9uHdYLTMf
         yNgqLXJkVGX7aRS5O5NgyAhMsKVAplNHGMbaDKskdKNm9v/hBTXYDrzj9RFGTaQ7TNaA
         jkPKX6ciNGZn6/9Ph+vs9+vhqiTSzXxlQIQBuPVXF57D2Acw1Hc5+CtjJpBwnZurWzxR
         DWgR/e+CwtlXzPgsxcGzSD17IQEZfB4ULrJcfFtCExEqpacsIGS6U7McgmK9vCwAST7j
         wzouCWkcgJL1rXI9S4A8F0Y47burH+LiHoi/5zrqQUNtv1in180AvK+u/E00FHwd5HGe
         1W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723981436; x=1724586236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CsHkOt9vf+tSdFHHxlwcTsV2VHa5VrYFOWKNehVdrc=;
        b=YzPcj1sZS7vYU2VIRtdXqtSHPx3OZ9j4cD375iwchFrzcmJx/wV9FWClWun/UTiZNn
         0V5OrRx1VEOnvjGP9vkDFpUNFQDCmPr5fh+0YX2Uv/KfI37vHc7ru0enaB9tb4azOb4N
         n68Fm2FCuVBykwmcvOxLzFLLgA38P9tD6vI1FP+yLMdcv77OQlGcdVsd/M1GPf/D0p71
         lEAQnnsaFGYM8UD7oTlPbNUBj2oaeof85aTTrDNLYG36h/7U0QyERSof0NEIH1vMAPDW
         L9yS7g4QrgylLhSnxKp+qR0WcBwg86bUCPm60zgQ3ELMTpyZMO9nzx9fMHK1oW2+JclR
         hOSg==
X-Forwarded-Encrypted: i=1; AJvYcCV6qfv4kOBtUixSJyLGLcVt8s9nFi3G7di7VMYabVxBMHyl+ACTepzZ+6W4GJscagRVSkO2PvDAUcoa4yTEcxI2J55xy7Zgq1PDvbXN
X-Gm-Message-State: AOJu0Yyt1hpJfsJBxPJqktrY5bh/1f4u3j21niNovXAqx8aPve5lAn3r
	cbl5ohW32WsECT8UDoJZD/+oCm1BPQajdIhQrvxwr6a+ZgkBg4eOH4DSFXt4bIH7bykkkFa+nJz
	K
X-Google-Smtp-Source: AGHT+IG7ta2jjuQc9D2y9DJGRgumHBihHGMFlS1nTYgEhcwU/OJqsrPk3SpooMiDTvMemesb1pkCvQ==
X-Received: by 2002:a2e:e11:0:b0:2f3:cd4e:b929 with SMTP id 38308e7fff4ca-2f3cd4ec008mr18879461fa.34.1723981435563;
        Sun, 18 Aug 2024 04:43:55 -0700 (PDT)
Received: from [127.0.0.1] ([192.177.92.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d94fa2sm5264560a91.47.2024.08.18.04.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 04:43:55 -0700 (PDT)
Message-ID: <cbd30b80-d213-4997-b447-10e455f20196@suse.com>
Date: Sun, 18 Aug 2024 19:43:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()
Content-Language: en-US
To: qasdev <qasdev00@gmail.com>, mark@fasheh.com, jlbec@evilplan.org,
 joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Zr9XJJlZ+RzkLK/M@hostname>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <Zr9XJJlZ+RzkLK/M@hostname>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 21:41, qasdev wrote:
>  From ad1ca2fd2ecf4eb7ec2c76fcbbf34639f0ad87ca Mon Sep 17 00:00:00 2001
> From: Qasim Ijaz <qasdev00@gmail.com>
> Date: Fri, 16 Aug 2024 02:30:25 +0100
> Subject: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
>   ocfs2_verify_volume()
> 
> This patch addresses a shift-out-of-bounds error in the
> ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered
> by an invalid s_clustersize_bits value (e.g., 1548), which caused the
> expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)"
> to exceed the limits of a 32-bit integer,
> leading to an out-of-bounds shift.
> 
> Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
> Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>   fs/ocfs2/super.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index afee70125ae3..1e43cdca7f40 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -2357,8 +2357,12 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
>   			     (unsigned long long)bh->b_blocknr);
>   		} else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
>   			    le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
> -			mlog(ML_ERROR, "bad cluster size found: %u\n",
> -			     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> +			if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 32)
> +				mlog(ML_ERROR, "bad cluster size found: %u\n",
> +				     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> +			else
> +				mlog(ML_ERROR, "invalid cluster size bit value: %u\n",
> +				     le32_to_cpu(di->id2.i_super.s_clustersize_bits));

I prefer to use concise code to fix the error.
Do you like below code?
-		mlog(ML_ERROR, "bad cluster size found: %u\n",
-			     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
+		mlog(ML_ERROR, "bad cluster size bit found: %u\n",
+			     le32_to_cpu(di->id2.i_super.s_clustersize_bits));

Thanks,
Heming

>   		} else if (!le64_to_cpu(di->id2.i_super.s_root_blkno)) {
>   			mlog(ML_ERROR, "bad root_blkno: 0\n");
>   		} else if (!le64_to_cpu(di->id2.i_super.s_system_dir_blkno)) {


