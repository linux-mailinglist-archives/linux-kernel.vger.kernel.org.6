Return-Path: <linux-kernel+bounces-284920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CCE9506DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15CE2834E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398419CCEB;
	Tue, 13 Aug 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ME7ff/IW"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E111EA8D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556920; cv=none; b=DFV0m8fgWzrMcS9XdhpFV5uCY/g6H05UoMYJPO0cjQs6FYhw6vxyZl9A35AZnM4QXMgabAVlzF2whxfwYdR2cnJzjGgNQ4JD4dstQzw+KOktu2uy0MUgBWYVf2zCVV0l6oJzx1ox9gHVEIrT7bIUG8mxF13TIaOad6vS+VkiQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556920; c=relaxed/simple;
	bh=J7EQyefZIhPS+LFo6BXF2fBKpJZft2paSM+4jMeHsY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TITKrIqkLkbPbpJn++l/dy0Jqec0t12WDrMmH/+vpusEgW+qpMVltjV3CH3clshAHlDO5Dh7xYoP9DXH5WC0Z+Q9k8dPBPvVlAJ+OCP9NgODwrE50W+DWl9C7pIQZ1k1F5ELthgHEBhUSsax+sW8+//CZrJmCM9jQNrv76PbI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ME7ff/IW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bd1a9bdce4so3662308a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723556915; x=1724161715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZNAzTyg6Waa0pqBLj43mkX1Hv89TbQTGu6ZA1/BZfo=;
        b=ME7ff/IWK6lOO9b13+O2luCtNkWrBSNaxBPQRBfjqQuzcuPswrh+vXrtZ/Go1CFF/3
         gOpjM6Jpql283qhfVKDGICVtASCXpkx8EozUjh6BSbyJyhsbe021w7IvA0w0cjdsjzkq
         57/MgMXQmsp/ZJA+mIPlWdQJ8UWHon1sc9Bf5qIDwWvfgjmeh7ORyl5/V2jndCCXcCE+
         9VGCDPeKjRFTSKauY/2+YKFUpi+5SQbZfR8DRFqMWRi5PTV8HF2KLFqhmQ86bXZLhOO5
         95evMFHsb4FSc32CYDK0fsHISuBVp7912mZ5KZatrYbTkDF/ABcxpIHqNENO1Vb5L24T
         SGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556915; x=1724161715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZNAzTyg6Waa0pqBLj43mkX1Hv89TbQTGu6ZA1/BZfo=;
        b=GzdThS8vvSsS25iqssHTHmeTWVixwsJEF26aaWREbYdoPHVyihv9n4JyX6wXBKtbfr
         j8L0jmFSTKhMfGF/bsL/i0DSKHqywSRmV5T92vSekpD9C1ncMZ+iiZGYUKInOFUB1PpY
         W9V4wYK20eO2w1W1IrtnK3Ai0lrcN0tMgs8tRTg+WuhImWdsPOgzLjr8Gsml9/ncEMAK
         8B4ZkSddLgC/PvsmCtbn6CQ5y3haxk4v1nubCjLoyF90KubM2dO7W4TG69kAXfn14V+I
         Mgtcv11wTOd2Kd3EZXodwhhL9uBIwb2Hj5XGxjlltGb9AwJoKKfT1rZqtaudZTIFmJ9v
         zsrA==
X-Forwarded-Encrypted: i=1; AJvYcCUQECBuMSSDyEKDDZBIWU+qsSHyVxl/of1e2QWxFLJO35tMpZr7Qv2EAOtpYSB7QCtdJ+VkOIZo7AAMrTGY9lE/1PjLn0N7wCXXHD1t
X-Gm-Message-State: AOJu0Yw9fymlU3Ipoxe8oEQX2R9f5W/nk/QvsTl+GfAqkcfubrJZDWmT
	MRzrssvR/g2TMurySypA6JTjZ1rDX0N/M0j3zUR6auC1cCxY2EJ5p2tgVjTLNHA=
X-Google-Smtp-Source: AGHT+IFDI23ZutMxXOA0vQkFPnBjN3ma8S+VSR9VcD5oReOiT667cjDK2CtZzA9egSKOEDpRfH/FOw==
X-Received: by 2002:a05:6402:27d0:b0:5a2:1693:1a2e with SMTP id 4fb4d7f45d1cf-5bd44c42176mr2862979a12.18.1723556915510;
        Tue, 13 Aug 2024 06:48:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e07a9sm2933877a12.78.2024.08.13.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:48:35 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:48:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: takakura@valinux.co.jp
Cc: rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, akpm@linux-foundation.org, bhe@redhat.com,
	lukas@wunner.de, wangkefeng.wang@huawei.com, ubizjak@gmail.com,
	feng.tang@intel.com, j.granados@samsung.com,
	stephen.s.brennan@oracle.com, linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH v3 1/2] Allow cpu backtraces to be written into
 ringbuffer during panic
Message-ID: <ZrtkMciiYhUK8Fs4@pathway.suse.cz>
References: <20240812072137.339644-1-takakura@valinux.co.jp>
 <20240812072703.339690-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812072703.339690-1-takakura@valinux.co.jp>

On Mon 2024-08-12 16:27:03, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
> to ringbuffer") disabled non-panic CPUs to further write messages to
> ringbuffer after panicked.
> 
> Since the commit, non-panicked CPU's are not allowed to write to
> ring buffer after panicked and CPU backtrace which is triggered
> after panicked to sample non-panicked CPUs' backtrace no longer
> serves its function as it has nothing to print.
> 
> Fix the issue by allowing non-panicked CPUs to write into ringbuffer
> while CPU backtrace is in flight.
> 
> Fixes: 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

JFYI, I have pushed this patch into printk/linux.git, branch for-6.11-fixup.
I am going to create pull request after it spends at least one or two
days in linux-next.

The 2nd patch is more complicated. It depends on another patchset
integrating con->write_atomic() callback. 

Best Regards,
Petr

