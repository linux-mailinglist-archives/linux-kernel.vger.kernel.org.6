Return-Path: <linux-kernel+bounces-396825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32389BD2B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7ED42830CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695E1D968D;
	Tue,  5 Nov 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4TRtE0U"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F532EAE4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825144; cv=none; b=rqC9oHk3NYIrVyoI/9f8FdPfpEFk8qBzZ/PRnHik74GV+jM1UgHtEZ1OLfRVoeKoJzybiBVor7xyQbQAGh+7c9MLG7WPsV4n/fWonCA68L8ZKvstlM9AWjmxSiDsEo1JIlOYZo9G3u5cUwESKcFG04LdU7Qj2UyI1JI35bmCGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825144; c=relaxed/simple;
	bh=GqxkKxfCepw+WI0L9oUkhsjWH1YFkyvLJN/ydsnKHRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVY2iKVQSxvEJgB3TkcHVbI6ZrmogUhj0jI3Aj0y+MyrACqEUUEqRXK8Vr/dLinUAAZTC4zVE8Y+QQX1YABsN9WTsic0ob8SoHTj8iDpDS7kKX5xvjZNscxC9mLV25i87zAnMDYKvYWcwWr6R8PsZc+B5PNNAUNIqyBRus4s7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4TRtE0U; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so5590972e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730825141; x=1731429941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eO2Rc2ylDy//zWsYbxaCN7+Jb/tGlO2igB2V28DpRFE=;
        b=g4TRtE0UaQxF3cXKTIoQnEz6iL0ZsjO1SmYLbveO8wd8Z7EZLGDpB2TA8D1jjMmovA
         fXiLo5KOZfGWgxRSNE0SBXD1sMkijhX6MTKYYF/IAt7vaFsiElaujhn9CxKqCfiZJVMA
         oBTV7NifJEoo0GidMxUe6Zwrv7wVTWqPCuqOx+wU7zOsm+AxdehwnvXhsYV6pk0+aRsI
         wGmlUS4M+gh+ciIJDyUp92M4rz5RnhH1bHWY7F5h3Fvl7i5nf6Ik3c5gejpvMeNJKS4G
         zIxyeYy6seDk9XuVIRa3E6nH+EC6uMuIHYP3sqMxEO7O45PN/A7O4KBQw2HwdcCeQpwR
         SdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730825141; x=1731429941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO2Rc2ylDy//zWsYbxaCN7+Jb/tGlO2igB2V28DpRFE=;
        b=UqNspUD1RsCtQvENM/p2mLbdKC6XLs/vdOTRIqvB4Zb/3kW2pvWqkXpI5/fhIQUi1s
         j0qDFHCwpjmMWS8k3LlUlGtVU7t27wt8VUfxJU5oDRKCoWyCE1+bMmT6HSwlF00D2zJf
         DzHzUdZtU417kB9mUZu07QZ6AyL+gkhZuYdquY1JrmMlRxLNBMiUrq34Tr0f2iqJp6OE
         gW+b+he1xWWwyIp1E8en9t0sigXZjH/nRp9FfsW2yT4v5tXTfuoAalDPvVuQyQ5bzDSw
         KKECpXxFMf8gqeLQKsQDB5zBsA/CrOrQbtPHOkN7ASkPU3BuXyxV+GgtxfIcK9cSD0NI
         +HtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzOC1DHN6kZxh9Wssjxtg/rzEKhyMHUu3INTlpynUapze6Qf90GknCpdGdrnmLOcJUtJxzUz/HKLuNIVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHYrIdJt6lnpnr+VFmv9BTnGk8+LRXTUg7bTtFzSnOAnYzACm
	RA5tx5x007NN2fPsqvroHpo5g6roDPrJHiUJrFOC8d940XRBuyNo5At5oz7g4Bg=
X-Google-Smtp-Source: AGHT+IHbbL60OFoSRKrDaKJLcmCLmCs0FTzW4o/g/NDSmkrMXRKBjyIAqB/wjh3gYIeBgf3U9lFeTQ==
X-Received: by 2002:a05:6512:1307:b0:539:f886:31c6 with SMTP id 2adb3069b0e04-53b34a18f24mr19234091e87.38.1730825141265;
        Tue, 05 Nov 2024 08:45:41 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d698055sm195385765e9.40.2024.11.05.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:45:40 -0800 (PST)
Date: Tue, 5 Nov 2024 19:45:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] media: xilinx-tpg: fix double put in xtpg_parse_of()
Message-ID: <372abe0b-fd67-4498-883a-7139632ed43c@suswa.mountain>
References: <f41dfe97-6e6c-47b4-91bf-199c5938c6d0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41dfe97-6e6c-47b4-91bf-199c5938c6d0@stanley.mountain>

On Mon, Nov 04, 2024 at 08:16:19PM +0300, Dan Carpenter wrote:
> This loop was recently converted to use for_each_of_graph_port() which
> automatically does __cleanup__ on the "port" iterator variable.  Delete
> the calls to of_node_put(port) to avoid a double put bug.
> 
> Fixes: 393194cdf11e ("media: xilinx-tpg: use new of_graph functions")

I guess the CI system applies this to the wrong git tree so it says
the of_node_put() calls are necessary and it can't find the Fixes
commit.

regards,
dan carpenter


