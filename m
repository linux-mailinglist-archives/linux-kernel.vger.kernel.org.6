Return-Path: <linux-kernel+bounces-441123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4FB9EC9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBE9286769
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5741E9B25;
	Wed, 11 Dec 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="im7detmm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064A1B21A0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911605; cv=none; b=KerOn1r8QJHkFLbrjE86umBfjEco5kkEFXvS9Wqi/E7cqnRIQSt5B+SHEFwht8X97thYjab7B2mrmI9/Pu7vTX5G7e7rKRhNeRMyFXcjNq2XfNgSM8p72MmxTN4ERbaxIkm8n/WJrOZfhvB1BKBQVdX8jagym8+yV1F21VWGdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911605; c=relaxed/simple;
	bh=mg0RHQDyGlg8K19MaZcyqRkJYKXq3I4O71h1ISM80KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCsvnPHr3kCYq1JNM39lnmi3D+gRPL/7GlwL73z/ZhJLbjuuHjR65L3hlBtRMFNUW8hNBKkuQ1YDBSejFLisa2DN4IMAaKbZJ7B1tHvQnoto44HA1Zpb67pccdWP7zZr46Gh3+mu419Q4c4GEB8pczNVDy50oLAUUQSeXCdSPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=im7detmm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21670dce0a7so21361755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733911603; x=1734516403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUiuSU0cqUej7SJHTMapGKN9q1V1a1D7bIqpHFLsF2w=;
        b=im7detmmisuJOsL7KmfvyrEXbqWE4hSY0PQogaMYY0N3HVyUf10uGvRkYNnDias+2+
         6rXvq4yvTT7KcxHSIufon8Cm/2nembqcJrgHWMlgxDrzjYenSgi8EIvhGUXgvkbvoZWT
         D1HfXP+SVhHAL15wXFRDPfQBWdSD8rODYs34E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911603; x=1734516403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUiuSU0cqUej7SJHTMapGKN9q1V1a1D7bIqpHFLsF2w=;
        b=L8nzcyLQ/OZK1X1KH5dXDLq5Y+8EQnwHZ1DpIqdoXTRYuSoNiIf25kVvEPz86tzQFh
         aH7Hr6T18b7oV/o76InZwR3QlOvy3FT7z+6XdLyN2TQa4Xt7UjZPEtAoC/XeESgUZLlz
         H55b/MbqwTh+AQQBt3+JCzMcXxqvymc8h/FJ8NUvC9vhgD2YGTvjt/690EGQF57OCHFN
         5wPCQZMROra3OIgsKTEwntnxL+irMgC4dixu8oI1f6exY3Y/GbDmsjXE97QdoSuSxiox
         2aC+YW+kc5T2NgrWLPyQQ+wqx4NsEbamPnpac8aDs0fIG7KPhhZi83Xvo/QMILJgP26C
         HxHA==
X-Forwarded-Encrypted: i=1; AJvYcCWaT46ataRaTMbg0xh7+WgDpfQxbXZEA8LnQQMU/roMHgtzdF5pABrt2oyVbESbPwC6ZC4pWVdnn8fqHS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBGuzQ5qsUQJIsYQe2iAPrlF2Ba6u4a+WSNbBugxCXq4hQQpr
	DyPyEthlsXUa2Ft9C8UFsWeXcTpftnmCtgQJw9221WZOkCJFIBWNdDF3x4DMqw==
X-Gm-Gg: ASbGncs7Uqbz4g0Toa72syU//xG+kxvDgaLcwq0YqiF6iaFMi22c2INUMmcVrQ1i/I+
	z16gpguF6hPRxxvvSkYcj8kWhyFOwFhZyzMwiCaGz12dUiOahpexY01CvB25i+3B10oSR6JJcYP
	Ekb2nh3lGGj4t1XV0HrCZftm+4vXQYhU+NkclXNXmPbrnBYJDQUTeVNJVImwMykidLqfLMkKzyA
	8u6whaFlmYTyyGEHceZTAH+OOwLpEpYht6MAjMfre4DCNWFeBYvSCjtyg==
X-Google-Smtp-Source: AGHT+IHus8XK2DvkCyCh8UKzqM08Sq4m5mA3cuQ+OKHcmO/WqMS8cgiIMg8uHdJP0E4u6HIpo+MpSg==
X-Received: by 2002:a17:903:41cf:b0:215:b9a7:526d with SMTP id d9443c01a7336-2177854ac96mr41958395ad.32.1733911602970;
        Wed, 11 Dec 2024 02:06:42 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21615dba950sm86719655ad.11.2024.12.11.02.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:06:42 -0800 (PST)
Date: Wed, 11 Dec 2024 19:06:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] zram: factor out ZRAM_HUGE write
Message-ID: <20241211100638.GA2228457@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
 <20241210105420.1888790-6-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210105420.1888790-6-senozhatsky@chromium.org>

[..]On (24/12/10 19:53), Sergey Senozhatsky wrote:
> -				GFP_NOIO | __GFP_HIGHMEM |
> -				__GFP_MOVABLE);
> +				   GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
>  		if (IS_ERR_VALUE(handle))
>  			return PTR_ERR((void *)handle);
>  
> -		if (comp_len != PAGE_SIZE) {
> -			last_comp_len = comp_len;
> -			goto compress_again;
> -		}

I deleted too much, we need `last_comp_len = comp_len`.  This is why
I think zram_write_page() is too complex now.  (I'm still very very
unsre about last_comp_len patch.)


Andrew, please drop this whole series. I'll resend the combined
series (including zram writeback cond_resched() patch).

