Return-Path: <linux-kernel+bounces-260226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159993A4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C010F1F241DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E4156F54;
	Tue, 23 Jul 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFuvWIPJ"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6875158DBC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754299; cv=none; b=dFasgN4ZJ7GssZUMTQaj57gS0+6lwAWEd7nNmT/k4a2y4dMGJGFpY3KMIfl7nhGXxxkW0z4klBngtFKL98jw7fzQfP3DEy8dtb6DqdLoxHCz7l6dERMY3OBdcYTJME9SH/sobGgaQtjQ7C2AZKl2I7RBkh6BwFqBZ9fZcDRTJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754299; c=relaxed/simple;
	bh=rjm+XiXLjAv+cv8lsSElkzlnzNnwcUwpg8OI2sAcgqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7fybRlEz87a5RIXGt0OHAhaGRuTCQWaYAsw9dFunkM0b8zToLKf58hkcpJXaSiNgucfubmPEb1QexRsVjbOt1Ynl8eA59f16IXUSC/vfSgqDRNsG9N/dv9wfoKqiOzSbF5RLXOSEYVbUGR03j8ET91RJv1SI9yATG2UHG6G+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QFuvWIPJ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-706dea920f3so21034a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721754296; x=1722359096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=17PO6P9m/EPzTuaWqEoZXJbBkST2vM/pJLJreMB6/QU=;
        b=QFuvWIPJcJ8EFnQdZ4+EMwvjvVaE8w/RGKJI4t/pRK55VRex3xFoPFEVLEk0ENDt77
         oa5AhM3Lk+n81cqqKLBqTjIn0g36I8ssNpIJOp0sKYxcKp3VxWoH11vyVVjEn7ySTpJv
         wFUCASZ+zhxITL8IyXXcHtPvJKOlvW/LzFKq41pYnElHTz0SFXZOiGMTpdYTxZgvYisw
         GCGJ0n2m/geBoEFQUEGYUObA3Gpi+V6IyHMmwLYWI+w+uojP5U5LZZZ/ZFPL1o94XW6F
         EcVgkg42KIPbKwW+Fgd6aTbo1hVxvCEnZCrHmmKWFHR+Sm7dxD9IIYbQ4+UklzvL9kpx
         csow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754296; x=1722359096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17PO6P9m/EPzTuaWqEoZXJbBkST2vM/pJLJreMB6/QU=;
        b=TpJVzwmr8zrYdP9g1fR5RzhU+5csHHLo0hSciQn8IzmA9VoyejJGAjE5Ypnufhf+Je
         322Gi/YzWAJQmSsmr8WVj8f3hWHS6vLaibbuZaG7k8llyc0L6Al/Izen5SDT/Jq/tCYK
         ffauiQQSBisDFdxXiQR8O6RjFtuWK7qcSZTai1cj4Al+Dt51c4ESqqyxHyiaXg54yA4M
         KmaPUnQSfUJX3mEsl8KRPEvBLrftkftqpTeDdokc3/sU+u9HUrYsv7Uv8ZWUuKs9xKi3
         GggdPFJLCh7IxeT8qofsN5IZlI3ua5eSFI89Omgh6Bgcx6RQMd6EU+DIkVzrShyiQqfC
         4H7w==
X-Forwarded-Encrypted: i=1; AJvYcCW5avVhRHafzfhhszjMelEByNX4W8pbcLXBazw0JpulofdhqGfjZew8cSA66LeNyOZPWcetWv7YhVpN/hNzGHNESHDdgKUEE7Nidnh0
X-Gm-Message-State: AOJu0Yw+TfGR9p4FcvS8eQJ6PG/OuUIw/F66sN2omzQH8zQ7LNJxkPfG
	4LZLuvJlWwwpwRvRB0QTcrjuW/fUQYwHJeK/NScXY20yD1bFI0q86RQpJ0Nll7Q=
X-Google-Smtp-Source: AGHT+IEA0MFAjBrBs9eGln7moHaVSCxxONpZPV/R5VMZKTqO7d8zBcegIRMtxIjGeKGufDvuoUnqhg==
X-Received: by 2002:a05:6830:314f:b0:703:6563:9384 with SMTP id 46e09a7af769-7091aab9531mr1132985a34.1.1721754295924;
        Tue, 23 Jul 2024 10:04:55 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:eca3:bb93:d28d:1005])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f61747e1sm2057512a34.64.2024.07.23.10.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:04:55 -0700 (PDT)
Date: Tue, 23 Jul 2024 12:04:53 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: pressure: bmp280-core: Make read-only const
 array conversion_time_max static
Message-ID: <abc73704-17c5-40c4-a92c-b69c571a006f@suswa.mountain>
References: <20240722151738.572913-1-colin.i.king@gmail.com>
 <20240722210111.49e66c4e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722210111.49e66c4e@jic23-huawei>

On Mon, Jul 22, 2024 at 09:01:11PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Jul 2024 16:17:38 +0100
> Colin Ian King <colin.i.king@gmail.com> wrote:
> 
> > Don't populate the read-only array conversion_time_max on the stack at
> > run time, instead make it static.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> I'm almost 100% the compiler can hoist this off the stack if it feels like
> it but sure, it might not and adding the static keyword probably obliges
> it to do so.

You would wish the compiler would do this correctly, but it doesn't.
(Or it didn't the last time anyone checked).

regards,
dan carpenter


