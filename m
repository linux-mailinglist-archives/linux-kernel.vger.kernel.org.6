Return-Path: <linux-kernel+bounces-267719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE99414B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B02818D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86A1A0AFA;
	Tue, 30 Jul 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3DCa3Fi"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF21993B0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350874; cv=none; b=h4ck1JkDMAsqTSdMdeZg+L2rVJ5GQvUwnZEZMPfQ2wibM+NzDhEJ/DiUVif9wF5H+IyTwk6LppIIIw0zK8OLiDkBcsuEMDu8/FDYFPrgF9Q4cXLpFWCmf/2M2LFnIWU05zgR5ZUEDNzd9T37WBmzSAcHbfnRyLsr2JJAjt9xdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350874; c=relaxed/simple;
	bh=cTI+YjBitz74R3nmR72IlRqLtVxl6R9IAY+bHLuOOrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv27RPXrkJrXWxsnMPz/+qy0Zlb3fot9CLa0byBp8SVb/5tVhIJ6CYknVzJIto/C9GJJ4Caq7CImkHHykO/lTmJXRHVk82t1IpRyqAXVJ++r7WLNsy5h+K5pQHRfrZ/DpaSWPk7X6KCFOGoWG2MoZ9RdiSDFDX6gpBczFFjzD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3DCa3Fi; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7093705c708so4717477a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722350872; x=1722955672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrPUSNeFtUoQE47sRLQsqvHeQ5MzWDhr7teSoQBbv/o=;
        b=Y3DCa3FiVIQm7Mh5UlFyjMuzSuLdiuHDdeU4VesWPrrFf9dGQL0AXvbe24MfTdXWn9
         0kcB8HWPf6SD2d+wR6c+Lu9blDVTLHqRODJRzb33SfgdraSFwD2aYduWYhlk7Zc8QILE
         OQ+BF8h75irdyajy16yvoVrFgBQYDQ/M1Rw2JLyd23rlgteLF8RHlSJNn97T/NCn6KUI
         RQZQaK6bRFDkwT6uzRWogBtkdWQXBoVF+kXMX5TLUzRp9EdeYBxBO0fn15UbQIS4mKPX
         alWqRcY+S68rn1WExiY1z2Da/Kt/HLAby2Eow+hKDKqXsNsQbDY7U0rHTNve74xRENzL
         GXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722350872; x=1722955672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrPUSNeFtUoQE47sRLQsqvHeQ5MzWDhr7teSoQBbv/o=;
        b=diKHu1ahlfAQVTtre3GSeOomLCSgz19Y2KyQugFiiV50h9yzxU8nmvlHIMdjcYCrbE
         zp+5N7RqVB00BGm7z/ddUEVQqM+gZO7v2RV/9jpUFBo/RPbQpzTxJWDewIJACioYbekD
         qoqVQUX7AnHQ2R6XPuN4q3O/cXKXghVSoaAGCBjZTayZRwMfWotAUaNs1cPBFJSUtQLd
         2g3pR/6d/x/Ox8c3fx1fBdIUSPw2ZAhd27ak1gAHrwW37FUGZvt0hc6dZPvdIPG5kdqs
         Q7r7ebOoSQFdkZK76gWTlxSkDXv20bth3sZu75FhcAogUsqm1D1ulUIqjvhf0MRxO25M
         yJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWz7lv2pf3uP6rEtg6e+U9DjeZ5ubBM49oJZdH8+POcB6JEhm58zbcoEaUn/tGxFa9YwXGTCllJHtq3qlcgvjaLFJPPz8qCcTjOIJV
X-Gm-Message-State: AOJu0YxgcEe1T+YwKWERBKQMtBjNrSr/lImlmHXrgYnGr+HpdvzOasTe
	i9JcMIRzwQXRWWJQyNm9dX6h4mWFcbgs5XrqhFLPWMrQPd0w7dwTUDio65NJ4kM=
X-Google-Smtp-Source: AGHT+IGIo7EZ1NVtJyYeWy7OjNQHB6/jdcUWY8JQ73VVrZG1sHvv/LZIidEEuXYsZbvfuhtDSsM+Bg==
X-Received: by 2002:a05:6830:309c:b0:709:2fa3:133a with SMTP id 46e09a7af769-70940c1ae83mr9532547a34.18.1722350871901;
        Tue, 30 Jul 2024 07:47:51 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095aea6512sm403459a34.62.2024.07.30.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:47:51 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:47:50 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
Subject: Re: [PATCH] staging: media: atomisp: remove trailing statement
Message-ID: <2ca1633e-aee9-42cf-a807-7f397ff31b4a@suswa.mountain>
References: <20240730071808.35591-1-sskartheekadivi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730071808.35591-1-sskartheekadivi@gmail.com>

On Tue, Jul 30, 2024 at 07:18:08AM +0000, Sai Sree Kartheek Adivi wrote:
> this patch fixes the following checkpatch.pl error..
> ERROR: trailing statements should be on next line
> #48: FILE: drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c:48:
> +	if (!anr) return;
> 
> Signed-off-by: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
> ---
> Just started contributing to the kernel. please help me understand my
> mistakes if any.
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


