Return-Path: <linux-kernel+bounces-252033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00B930D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E001C20EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F77771750;
	Mon, 15 Jul 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3rcfS8q"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931BE1F61C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018604; cv=none; b=sDFJZ1CDJtaXMwULg7El9+IegtKblY2MCdiO8Six+J+8gsKEeyNRg1pXJelt39dMCxf2W+2zLisucdLHCweDLs7qzpMzp1VcjwdoQSHIJNQBQMXdwZCBwcQ+3Vjw1sdtccitKdYtJtKX00lqNomVq0FbV08Sguxk3KlLzNTSzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018604; c=relaxed/simple;
	bh=HyxKInobQkvcNIpBi/OdYTvyaV9Mbx2ujjrH7lDcBkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW71kVYbnhHFt6oQMAHizVr5WwSITmeuVWEONhPZcPXyAN5uNEX0Vh1/F7C0HffAIVnk9JRuEsbdd6rOFkJml886nOkZOSwAhw+qb7HiUZgRFIyXMmWIUX57nHKn67WYGFzYSS1Hw95aM6UgRL3KsgEo1m0j/5RD+kQFvj9iMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3rcfS8q; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-75c5bdab7faso1934946a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 21:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721018602; x=1721623402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IrtwSpcBigLnBZEejCtmXghrUya8pHN9ukA0tWh9Ic=;
        b=S3rcfS8qRduxEkW3EkNyUJTowInNrSxTBFj0v2mkl8/jkWhu6C0qq+2Uzu9vBIeGcm
         5tDTYwJa3t0dmNFgLN3SyXV8UUtNPl4ickqItdXSiHXhJL3Lk97X0mnND84BLK3iR6Dj
         aQTp4OAI0tdqWT+DjafECOa1Dbx8FOSq3daA8SiEjRjrEw7r5FiB0zlUybHmfk/NWR8v
         aQmETZbnSTQ62cJPL9jBZ5+JflvrPY8gLqtuEICG2ibm2T961Kc63qTjjdYdTuOUNc5/
         ixSED8gsZYjF1eEouSn2JQqhPlH8rl363XxCjR7Zzn6v4e1AT85Ph/luden2q9ScFA/d
         c2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721018602; x=1721623402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IrtwSpcBigLnBZEejCtmXghrUya8pHN9ukA0tWh9Ic=;
        b=tnKUAWlH8yT3Q/LNY+7TINX3VUXpOa/QykGcGlngJxUc2Ni/LZLZVTF7sFgy5SrAuX
         y0kDlmzCbgp69LoVu8A6ek20XoxjBsDs1psntdaeR7+036bovUxs7V4SMrWDj+oyg/iR
         JZaa7NF2kAQVXj/iOuSWneMisIL4pFyJL7TuFbE2Ivrv8SNS1uwLjt2JHvN3MofNbtG+
         eICYryx9dQ3mcW/MTuZ1pVMEqie6sxqRgrZYmpb3hmbYhl1WW802MFOv8ZWq3nMSI92e
         gbMMsMcPHZ1VXI1aJ0jy2fZVq2KjUfh3SUZPxv8qbcvSD9QQZ/6eooLm2K79e4Xpkn9e
         OCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIeRm1voFtV3NkHJeQpP8B8+do9ccuZjEXItwyM6fvXTK0DuRpM3EGGEy2/QsKdGOQkag+d4OUbjcE8ja/bTdLAOV5/YYNkobWbmAt
X-Gm-Message-State: AOJu0YznHh71SH3JmgSbQVMqSQixaDaJYmsGOyxp/9ytZLmCxvctTaC3
	xOMAIO9ZeJ8qLFt1zs3ZWBFKOmdi1K4vly8W/dlbr+TOFflEEbkN
X-Google-Smtp-Source: AGHT+IHVK/YIo7jAWdYY/xQaNPzbmnoIW5SH50SlKXAPvV4qcLxYIw8BSR9N6GXz1USZS4tfQy4IFA==
X-Received: by 2002:a05:6a20:e18a:b0:1c3:b263:d992 with SMTP id adf61e73a8af0-1c3b263da2bmr10835988637.5.1721018601625;
        Sun, 14 Jul 2024 21:43:21 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc52568sm30837085ad.290.2024.07.14.21.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 21:43:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 14 Jul 2024 18:43:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] sched_ext: Fixes incorrect type in bpf_scx_init()
Message-ID: <ZpSo6CrDiQZ40Ysm@slm.duckdns.org>
References: <20240715021027.77700-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715021027.77700-1-jiapeng.chong@linux.alibaba.com>

On Mon, Jul 15, 2024 at 10:10:26AM +0800, Jiapeng Chong wrote:
> The type_id is defined as u32type, if(type_id<0) is invalid, hence
> modified its type to s32.
> 
> ./kernel/sched/ext.c:4958:5-12: WARNING: Unsigned expression compared with zero: type_id < 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9523
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

