Return-Path: <linux-kernel+bounces-232880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3637C91AF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA1D1F22ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D819AD7B;
	Thu, 27 Jun 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh7zgLxU"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188143AA8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515162; cv=none; b=gUxMbNdtR+mGj6t8VDco+qMxzBii87Q2av/xXBii8/hhEOQE1zAHzuNTec4HFsEryno8KPHAs/6lkJorXsp8liMFZ4zwYCqdsd47lBVybpt0ZKGDScBZm5IV41pkReK1/IwNeD8zmvVbxbMPoZeivEyh/Q8KXaFOt91Edhqg9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515162; c=relaxed/simple;
	bh=VwGAyW/3MZj/uwN/5VQI8JFvow9jxahY6lAzs3Mg3bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8KRZrlDs13YSWQ3Y4OpOVOf9+ehVcCPbz4V3CYcB4GsS0xEfWGh1MhBp5GGsn8sumInm5wYT5zt5FnJ9ndf+8PPp/9Jr9/vDFrvXK/C62UC1HA6viKTH3RUpuFDgMjxImpCRvc1H7UwXc1yIWepIyNl175qa1Jij076VumaNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh7zgLxU; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3c5af0a04so169223139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719515160; x=1720119960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vk+/c0LF/RgD0vbdhNF6vDhDJN+mFHUvzefYYmrh9C0=;
        b=hh7zgLxUr0te53S9ULSPBua15G9OyUToqOtIurkoWw/pZjr4gZvcO2ox7mq6u/rnLG
         foN516gi7b8grRsN2OPiriAT7rL6wHnnxPFjn8pD+st0v/jzBROTw+tBaP4oJGLhCbFN
         KCo+P2ClDkvHNXY1h35AeQ6WhbnglMtRyDvnbwi/B3us7407EuISdkHs6BCieipaP4fI
         oj8kg3LBalW2jsSLOTtsSL1BL49mhFBfiUK6SRur9JA4N2bLfEbHjW4OV3kR9jU+hgUQ
         IBt28UVaxdHp+4R8N2N0VGLZr8JFbEw0VJfaqbQdwRs6UV0FYVi9eAfzhmfzn37BXpW1
         bqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719515160; x=1720119960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk+/c0LF/RgD0vbdhNF6vDhDJN+mFHUvzefYYmrh9C0=;
        b=ViJD53XxqHxNZ48XYuh4z8rbDCU0xdd5AiYGeEBLdt1KonjNdIdQZaKF7Etkzz/X18
         BjVtvMkYy3wZdBLzOeXjuIFuOs8FvVL9N7GMGvw1181AIvbqoZuwcQGBGxIhUpcAkuqM
         osObGb4hPQ9PA+BUQ2rlwVEMR6tLog1aZcOV0vNtZIZ128R/+0E9wdMG/C9nfMCExqFa
         vFSJTnip+ic6C5L+m8I9k659Iow3nQiF0/Vy5Vzds5FVT7sjeb/QzZ0UGIDGo3A2t6j/
         RW1Fs6jd4y2Kt2ACggUTo6+uB1QQ7i+5pDLgRl025ApX9XRMIFPZWJQQ0wC4ipaSssSA
         0uYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0m/lBuX+YIBhUpijrhEiegLJ3FrtDKENy7vIDyZbr7yOdHuOiNSn0+DsvSS/zEbJnrgzmd0uVUn8a1IbajBVWiTAbvJvyc7+sLfUl
X-Gm-Message-State: AOJu0YxAb6fw0xS9qyRDdZAzIyv8Y/m/k1fvkI3VcBV55zX4gX8B/xbI
	uYDZ/pdzDN/qydl1qrJy4xCX/+HXvI/z/hvJGiOlYO65W9WIFr1Hb9RwyA==
X-Google-Smtp-Source: AGHT+IEXy2Tt5VebokPdweajbm+UoJPN1AZMjcQTXxKxYxr62rtRsP8BU+7CUnYAZwPvL4j2C7l61w==
X-Received: by 2002:a05:6602:60cd:b0:7eb:8d08:e9ee with SMTP id ca18e2360f4ac-7f3a753482cmr1858692539f.10.1719515159853;
        Thu, 27 Jun 2024 12:05:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f723csm47502a12.57.2024.06.27.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 12:05:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 09:05:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: fix typo in set_weight() description
Message-ID: <Zn24FmRFUjq3sSZL@slm.duckdns.org>
References: <20240627185009.1258446-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627185009.1258446-1-andrea.righi@canonical.com>

On Thu, Jun 27, 2024 at 08:50:09PM +0200, Andrea Righi wrote:
> Correct eight to weight in the description of the .set_weight()
> operation in sched_ext_ops.
> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

