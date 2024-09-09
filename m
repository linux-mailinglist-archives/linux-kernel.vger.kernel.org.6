Return-Path: <linux-kernel+bounces-321713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A61971E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E41A28585A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797455885;
	Mon,  9 Sep 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh1iEbQf"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD382D611
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896909; cv=none; b=i5q/jg4QrOUA0H1uv8oPlPN0dV2PBNBgK8njkF7RvEhvZqKrZcLjJrYLvzVgfovfJ9gwUWRaWOfTNlbUYgoEc88BXXLZZeMF6Gh18NeWgnjeK/cCsxHqkVUyHXSbIxUhDfSwuW47uaaWhlhDtVVo4BR6AXZudTFhEWy4F+TNpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896909; c=relaxed/simple;
	bh=7UsiMz9kx/2VwhLolSRRhzPrDBHKVQV3dsvZ27k7zj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8NkebgnCNvJq2RZms2dLSe3Ltt6bZ5Se3nxyW4Ri4alrptLVX4O3gQKBrp7l7kQVwK5ZgVha2raZivgcmvreGhwvmqSy3PDUvjsNrCBsLTyUb9MGzlndsEa9F/rNH+971wpueqbmMIrDtiSeL+dLh2iCQLyXJMCOMs86EAyhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh1iEbQf; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df02c407c4so2852628b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725896907; x=1726501707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmmsK8yuGMBdE2DHfUG1w3aEygGS+urTp46EhBLUm0Y=;
        b=lh1iEbQfS2s4Hf7g/KFtiyVegCM7AjF5MxtKpQeWN7v/i4mFLw1ky3ByLlq5UK/3Jd
         5luuNW5r9NuxSvsaraxq7f/DmuQYuM5yY35qtbe6SFty5718HHFWu3wa/SWJ/nHwihsJ
         5Zqq9kzyqGERZYsYom93PprIjJLjciA7euWRc/ITW6HMj6goPu3ba99iugOfXE0msANL
         EuodUR3GQnazi6cK7rgMygMopEA+ic9l+KvBx74xcrxTBw+JClcaWfiFotbaMWrkKKi9
         ULEkPAiFaW2z8kA0GnlXOnedt/Wl1muHpnLRAmBTvT6HlC03hFP3395330LeLszLmbwy
         r+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725896907; x=1726501707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmmsK8yuGMBdE2DHfUG1w3aEygGS+urTp46EhBLUm0Y=;
        b=P2s+Ts5Y7KY30jmmmmdDSGsKEmDXwxJ66pQY2jjSCZGyAUlpqmYURX0EcDVdLP249s
         tOz3lU/F+wQG2hAA+PEFYSkhNyJ9pbNvb/Hh7zJeld6W2x+Mh2HbvNwjQ6oBV7afuN5s
         rUcIdM4zTblSvnBf8TSelt40JalJ39RkWjrFUfqwgaci9ofxJhDFIb54IvifmgnCV/Yn
         jrOgPWth+1ZDS//G7c59cZg52Z9HqMjrQ/8GTct/f6fX0SjURJcSlurCiglJlTPbvY9A
         MRhniYKb14kzT57GmhxRcWCiRNOcqHr9OsWf+MBxXmsdmkyRbwLBoDCqttT43zHvbG9I
         Vl7w==
X-Gm-Message-State: AOJu0YwX2uourF8LHrWrfQtvM5zSqr+F4X8gWP5BQDbiaeQL9LNy+sRm
	mDzxnTfz46UfbqIhHdQQVqdkbr2W8AvwhlSBPzgWIBloyWn5ZKdp
X-Google-Smtp-Source: AGHT+IFO2xr4pLQEjF/eEWNQHlbeC3cST6UX0eSNTvgVOqqGhvQx1YlIzAHFJVImizTS8CfeIB4+ow==
X-Received: by 2002:a05:6808:2f0d:b0:3da:adc3:4a92 with SMTP id 5614622812f47-3e029ce5d9amr14947137b6e.7.1725896907299;
        Mon, 09 Sep 2024 08:48:27 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e039a6c87asm1173417b6e.23.2024.09.09.08.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:48:26 -0700 (PDT)
Date: Mon, 9 Sep 2024 08:48:24 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ptp: Limit time setting of PTP clocks
Message-ID: <Zt8YyCrQL1XBQk0g@hoboy.vegasvil.org>
References: <20240909130905.962836-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909130905.962836-1-mlichvar@redhat.com>


> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..bd7c5f534be6 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -100,6 +100,9 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
>  		return -EBUSY;
>  	}
>  
> +	if (!timespec64_valid_settod(tp))
> +		return -EINVAL;

Why not perform the test earlier, in SYSCALL_DEFINE2(clock_settime, ...) ?

Thanks,
Richard

