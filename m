Return-Path: <linux-kernel+bounces-360347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627AF9999E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912E41C2286B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F45FC0B;
	Fri, 11 Oct 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQsO6bXl"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDA2F44
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612044; cv=none; b=V+XSXwXLnee3NalWZiqVnIjaQItmR4df9EEy7qEvsARX0BtEXxIOVBH1/Phs8M4VZVF2tTfBXrpgihUKp2G8FPWPSAklqFWIDpmHQFhneKLYcn3UhRjQRYtAErmtviz/znm8iPgid2QebPrtYm83uvkeBNaJLdpZRD8SqkDg+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612044; c=relaxed/simple;
	bh=S/07THXKPjn2+J7gSbyOUaULr51TF75IUzYmA7jymUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk2wiE/dHSmoJayYzXdSlhr81FwkqSLUhSEsNIVXUotDapyXE8e6fc6VcDo3bN5klF7aL2mzUvwCVSUjzMVaLS+DOxooqp3G2YBNVUPYCLIKjAMCASgMeFdQvGKlPsfVjtwt7tZGBTZM43tg1s74anDbWiTHB38xnjobDX5av+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gQsO6bXl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e10ae746aso1242176b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728612042; x=1729216842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIY27C0tdIqOwD0lf08R7TNoajKeaviVN0jzboFZio8=;
        b=gQsO6bXlSaqDkV3GSBmbEueB80t9bluDksB0vmBBUKMoA1o4Jp5HtWL2ApSFLmRCEg
         0ida8BxpQD/Eu8NzLW5s9fwcdePY17n0dnIzFtfhoXI8j7aQjovz9FIFzwtIaMO9wYmm
         pnhKYBcAM6SRBT+kYKrySR4kYIcdyeeKarleM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612042; x=1729216842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIY27C0tdIqOwD0lf08R7TNoajKeaviVN0jzboFZio8=;
        b=AlPXqFN9kCasWcFCZDPs97uxaadbdCo94xDQxkcF3IzclEdyTIEi9VXuJXgA/vSk/s
         8vrZm1bgdSrzsOhwP0tf2MiaL19Xgi9wKGMhH5yFgSvVzpM6cMNyUg6SvSxKeW3OlfG7
         PME6DAx/O1WQAgURDYIC5UfuI54xkkl5fnus4La6OF6vBn748sbjnifrviON9ms0xK+S
         0rfHu+udVovIQKReFrl3aj6xdEzGWNU5Ih3PXsMZOW6fonVr6Cc0C1xXJ6LyqlgrXVuN
         MFJO2g+ADeEyjsSYxVvUbYCyJoFtsn6xctY94fEkYCjwTMc75nU3iDebaMg4gHD38fAR
         6ZlA==
X-Forwarded-Encrypted: i=1; AJvYcCWMl3LNA/vXkmUUcUqLLX0vnmr1RT2kNtzBQWvwWlVcwLkXwm6QD1CuXUM2AG9pDQ1KS10K+PciC4F+NHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZNq3HLNJOgZfUUZNb9q2II0e0S4TCVTtgsA6QRkgpIRne2ul
	6LjmK0pFVpgjxDB31mylxREPP079dAjrQiP7GlUIp8V+Se0zWjpsQg+pLE4voODOwARYmGvvCIE
	Fcg==
X-Google-Smtp-Source: AGHT+IGJyjGx3ZGm+9HQWFGv7fNGUApFYuM6cF7ZnN4rjViPpPLM9Kc/z3JKRlbmwLWWBOIhgxfTGg==
X-Received: by 2002:a05:6a00:2314:b0:71d:fbff:a4b6 with SMTP id d2e1a72fcca58-71e380c5f82mr1773228b3a.28.1728612042138;
        Thu, 10 Oct 2024 19:00:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c13a:abb0:1c8:a3c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa93b06sm1691672b3a.100.2024.10.10.19.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:00:41 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:00:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org,
	willy@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, joe@perches.com,
	skhan@linuxfoundation.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/zsmalloc: Use memcpy_from/to_page whereever possible
Message-ID: <20241011020037.GB1279924@google.com>
References: <20241010175143.27262-1-quic_pintu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010175143.27262-1-quic_pintu@quicinc.com>

On (24/10/10 23:21), Pintu Kumar wrote:
[..]
> @@ -1511,10 +1501,10 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
>  		d_size -= size;
>  
>  		/*
> -		 * Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic()
> -		 * calls must occurs in reverse order of calls to kmap_atomic().
> -		 * So, to call kunmap_atomic(s_addr) we should first call
> -		 * kunmap_atomic(d_addr). For more details see
> +		 * Calling kunmap_local(d_addr) is necessary. kunmap_local()
> +		 * calls must occurs in reverse order of calls to kmap_local_page().
> +		 * So, to call kunmap_local(s_addr) we should first call
> +		 * kunmap_local(d_addr). For more details see
>  		 * Documentation/mm/highmem.rst.
>  		 */

I'd prefer this entire comment to be dropped.

