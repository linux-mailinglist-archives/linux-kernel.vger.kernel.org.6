Return-Path: <linux-kernel+bounces-376391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED19AB0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B241D1C2261A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852B1A08CC;
	Tue, 22 Oct 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKxB/gqR"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4F83CC7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607130; cv=none; b=uyAvGRG7TMUJ/DZMNd0SH5wkF7KzNLGHU7RjGcJyuFxK589Rvk3bSTQDc9SMkk0t31rnhUqBn3h177C8ydYuuNQmzUn9g/0QU8qqQE1EpERtOSBh7Qf63/TMO49QzGHkED+9eoL7qWEyAD2HtmO+prS2SErgaIf+H9+xLfHI2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607130; c=relaxed/simple;
	bh=37Iqmo+qy+WFGzsf6uya3SA3tdIscHLZylxDIyGXIns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C74Gr7o3kqeckXEy5afhlgqZJJT+qVNymz6tNvqxmx4lejXTEVx7qvE5+9Xy44zAbxVsztdVA3DFFk+uOTZkX4swOaPTMQwDg5qEjSMDWhScpcLsDLTk7MD8w0YmJ/BeIVSvvaeE3WeccX6PPWTsIUIQIiV75pQMurSRrQwRMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EKxB/gqR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314a26002bso63074665e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729607127; x=1730211927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wehu+MEAsSEQ19L7grgHaXBLH+E5c19oiwcAV7y0Jvs=;
        b=EKxB/gqRXY0QGZvCH3Y7XpP9rB+0yAvGxgiOjb5I4coSXdhBbJHeojYE9grevnv0C+
         uLh2hBd+nGljQ7LPfybrJxOVk10l6UeniR5N4X6F+CfOTLuL2/Rjsxhz4OddXdlMD+LD
         jkOYqnFZmK+WNsOiNg/K50of5Z2Rjv01hZH0QXuZEzELa8W60V/PJaylFh3kvhGAHRPO
         XFvAmg3Iu014bfGu4v7x3o1JJpARQs5ptX28qokUMc6BXUcaReKwTLt9CeXKST0e+hx7
         sezP5mMitepLzX1chBHJOs+eDWqpwNF0Jjh4Et/p8lfneu4I2vOC6VhDCJwuPHONmFNB
         NWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607127; x=1730211927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wehu+MEAsSEQ19L7grgHaXBLH+E5c19oiwcAV7y0Jvs=;
        b=jKxmgjoNXjGzmkxj3MPNO6uu/rq/5XcLgXCU/XEfbKIuK9HWnwVbQDWDUVpkDv9KU0
         8eXyyTBM7nNQaDlsd5uNGqxSlVJSqdL9zVcUaXTfbIQLp7UR3EZGuVPhQNq+d/uTmRpL
         pHyHjsQbRbjzYggCO4IyO1PTT/ifB4qcpjowCqt+u/vYLTZ1eE1SZa70voIcQa3N088J
         KiU5u3YelME/3fiZWItQopDPyBaw3LLHJSbPBx0MrGrmNK1lcl5lVhvNwf0jQksCCryZ
         WDIBD/3qNKmatufWknqD+OO0bvyjYDdCbp4IE/WSONO86tXYK2S7gvCg/PuVqzZo0Gu6
         Ay7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7683seFz+Ls67TNC1iGogpd5oG6188Czd4b4tsVZopEHxdZgZPaglygBu6YgKAOc5hBXUGeHJ+Dla3o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oT+IRMa5eimD04qwv81oADX8Q2MTdkXqK87TsjfH/i940QZ8
	scEkLG4P9YfdI3i1jCO/ctnJXxqrU6QxDxVSDptITcrHIDp4yVAKrrP7CuMG8g0=
X-Google-Smtp-Source: AGHT+IG2iYYYcddme4KeFQF/W/N4hRK2Bm7CBf1vGlQL3CKnzTF08HVGCHmo4z335CAe2+S+n9JU6Q==
X-Received: by 2002:a05:600c:1c8d:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-4316165d3acmr142075275e9.16.1729607126945;
        Tue, 22 Oct 2024 07:25:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58c125sm89054125e9.26.2024.10.22.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:25:25 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:25:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH] drivers/staging/iio/frequency/ad9832.c: fix division by
 zero in ad9832_calc_freqreg()
Message-ID: <6c896172-d372-442a-a61e-6b3e46b9cbb0@stanley.mountain>
References: <20241022134354.574614-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022134354.574614-1-quzicheng@huawei.com>

It would be better if the subject prefix were "staging: iio: ad9832:"

[PATCH] staging: iio: ad9832: fix division by zero in ad9832_calc_freqreg()

On Tue, Oct 22, 2024 at 01:43:54PM +0000, Zicheng Qu wrote:
> In the ad9832_write_frequency() function, clk_get_rate() might return 0.
> This can lead to a division by zero when calling ad9832_calc_freqreg().
> The check if (fout > (clk_get_rate(st->mclk) / 2)) does not protect
> against the case when fout is 0. The ad9832_write_frequency() function
> is called from ad9832_write(), and fout is derived from a text buffer,
> which can contain any value.
> 
> Link: https://lore.kernel.org/all/2024100904-CVE-2024-47663-9bdc@gregkh/
> Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>

Otherwise it looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


