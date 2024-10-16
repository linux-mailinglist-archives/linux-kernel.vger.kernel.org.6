Return-Path: <linux-kernel+bounces-368450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131F89A0FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B998B1F21DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B420FA9B;
	Wed, 16 Oct 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvRU/axg"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4420F5AA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096719; cv=none; b=pCxmGzrA8OGYoBUAU5xO60n/gnfjamaiMyqXicLiRv73o0LYnlaZXE6tM7coNhTaDfoYJ3CHaHRAO+8nTPix+LMi/gxQPnT6tQBrNEYb2exfVWyreopOZVCemPDSwgFOxFhAeClDoMdT5QHovKoDTmOuPsiQ/kqZ5dgymxFsmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096719; c=relaxed/simple;
	bh=3dr4dqfOkWOJbyer5ytCTlDI0AwlwUfu+DtjziI3WXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9ps10Vg3l+L28LQx2X7bbZNlklbNowFSJAIm7zLh5C1IOnoDIZZ8CZhfUnrY3OGYDpTv+Kc9ThAoWDRKhLdhn7cRRIjTg5aUu2BMjZnZl/znxacpyNPMlE1pV+EUsbwqm1sb7zKWDcqyXuAi8WB6QYd72Vuaj3QTvZq+hV/UJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvRU/axg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso1975ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729096717; x=1729701517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ci6gNrzUyVsUIE6Wb8jNNaoAEPNDjVwvjmEavYBzbkw=;
        b=zvRU/axgwpd1rmEqJkgcLqyUvgFTesCL1AMLOt3d7Gf+j5h2jYqUHdcMZbHJFotcPQ
         aY4DF3zk2KXvvt2Ya2UmfkWr/3VFnQQY2Ep2UoBTz+Own7Ul89pABAyM/LCzYV5Jtq1Y
         IDeMj5XZGRB2vP14C78XoeWkDUIZqC7zRTELmHl4+Kh/X1KLHD3Ja8g5OA5ixvXMBxxZ
         G4QMVRxwKIHM/muezbLAAr7aByk8nYXJYN5VuEPcShuNP8LSIDBdog6LA9CjAVNQUtGy
         p8IGWZIcmgUKezDF6oSExPKkUFs9w5NfKL9al9U0J47/wbLotSJYRGw8/XudoZUqXyhO
         R+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729096717; x=1729701517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci6gNrzUyVsUIE6Wb8jNNaoAEPNDjVwvjmEavYBzbkw=;
        b=CJlEyGmSy+ubCZzIbTsTNYfOaBh13zKjW//rJFX09gBVRRNd4NIRPsX1Y75Au7y6Wr
         FjRkzdRw69Hxb5B41vsVgn/eKzWje1W4Sb9wGCaWdDqtSeEpDPwKbajtElKx0LyQpC0N
         WCrcgCtSnNelE5BZbvvsV1uOsmnMha7NjCX8OOpxLVMm3Z3hg6KPutTSK2+h/SH2wnA1
         SggZ+sv4chkLVA3or7uYK91mXaAzNyMrjQGmMoj6+bpeEY8v8FBaksKG+x+m0g5AshZ6
         tyeKWbWFu6gogZa3FhxBpy/JdP2N8THt4WptFzLxxO4iHzxVvxH8r1nXpoxDv1VCZYL4
         AL8A==
X-Forwarded-Encrypted: i=1; AJvYcCUoWuE+6IVcw1Jgakn9Je0zLCXdawpTJgBkkehit71r4RFj0eJm8zO/m8oU58xB4VTvSOg7kX4bh7HmhmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTh5gVgNhla4aHSTXpwIkPc3n86MCjh96JXYoI9NE2TOBMi/t
	ykpt0hPvmvddeLezsLufiyHCu/33tRLcQAmX5fjzOgroou3ZsgixttnnoCBjDQ==
X-Google-Smtp-Source: AGHT+IEY+QUM0YmGraUZwx4v/H6sPrKFmZo465qYrhwg9e1tZH4Rkey11zyj3Tb+y462yCpgUBcTcQ==
X-Received: by 2002:a05:6e02:1a2c:b0:3a0:a224:eb2c with SMTP id e9e14a558f8ab-3a3de7d3001mr3543425ab.25.1729096716574;
        Wed, 16 Oct 2024 09:38:36 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:76d:3939:1f56:8278])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84e9bsm30973075ad.19.2024.10.16.09.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:38:36 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:38:31 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
Message-ID: <Zw_sB7wK97w4Y0Fe@google.com>
References: <20240930184826.3595221-1-isaacmanjarres@google.com>
 <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
 <Zv2LQLsIC1y0bCDL@google.com>
 <Zw5ke11y4TkRQJQ2@google.com>
 <Zw-USn7PUHwCIGfL@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-USn7PUHwCIGfL@pathway.suse.cz>

On Wed, Oct 16, 2024 at 12:24:35PM +0200, Petr Mladek wrote:
> I am sorry for the delay and thanks for the reminder. Last weeks were
> a bit hectic...
> 
> Anyway, I have just comitted the patch into printk/linux.git,
> branch for-6.13.
> 
> Note:
> 
> I have updated the sample messages in the commit message as suggested
> earlier.
> 
> Also I double checked the patch and simplified the comment
> in the following hunk. The original one was a bit cryptic.
> 
> @@ -1185,20 +1196,25 @@ void __init setup_log_buf(int early)
>  	if (!early && !new_log_buf_len)
>  		log_buf_add_cpu();
>  
> -	if (!new_log_buf_len)
> +	if (!new_log_buf_len) {
> +		/* Show the memory stats only once. */
> +		if (!early)
> +			goto out;
> +
>  		return;
> +	}
> 
> , see also
> https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.13&id=a961ec4e2860af4933e8c1763fe4f038c2d6ac80
> 
> Best Regards,
> Petr

No worries! I completely understand. Thank you for merging the patch
into your tree, and for cleaning up the commit message/comment.

Thanks,
Isaac

