Return-Path: <linux-kernel+bounces-233269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FA191B511
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A51C21C37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E7125AC;
	Fri, 28 Jun 2024 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UcDyDgR3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFC7FF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541506; cv=none; b=OBuzcASss1K7GaEIgyzJ5iHjv6/YSxJwASJWrR2CND56ChctkYkLPyn82obsjyFjMCtgWmIbbxk+D4OpBdt6K2QAt+a66rJZnBr0weCroXE0/+cu0oZSu368F1uzHam4FgKBCu6vyc12dB8SQ5Lm02/wXmIYZPgw4PSDvKfv3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541506; c=relaxed/simple;
	bh=T71OnveBaXwkMJPAQSvr6AXJ4wY4UfAm7kzYgpxdJ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODs+o7ILe1bbbwj5ipEW9CcQgkk+z0NhZ8Oqsf4u2J8H4ABx7z49skbA3l6NL76sxyqLmTQY1oL0KvGMXSvlUOE2huT6Tww6GYYFA8KYl3HLcDAijV0QBWqLbofDIpKX8QIMX/1sWYx6HbT6Bv9D2B1jK8R5Fh03xIMgMCgFUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UcDyDgR3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9e2affc8cso537845ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719541504; x=1720146304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzO2A8iz6wHJZqZfsXCD1vEPIy2KLr5tygffi7vIE4Y=;
        b=UcDyDgR3m6eKT4CraQw6fmZbqu2QX+R/PEQhTCYCyTRXkpYslD53f0Bu4tkO9k9YWC
         QXYzmswJCjewZaYtat/dipOZM81ROOXTyM5Pdo6UkVVShk4DuIOfgnl/v5j0WfdL9HE6
         l3NNwJPp7dQcUtcMZ21wU1J6Av96DmO+QT6Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541504; x=1720146304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzO2A8iz6wHJZqZfsXCD1vEPIy2KLr5tygffi7vIE4Y=;
        b=Er45N1/rdduH41N3vzs+uAyA3BemE9hMBuWrR6kkLLRl39LRKTlo3cK95V4BaFDJOA
         G6B2XJoDpnOjRUizDpelYDcw3XFsjdG11EqDsmmoi8YPZMmlZz/5vFfQjo59gmgYiGcn
         vW1LqpXUjVFJaxiUhte6hlOu6rXhW/9jiNvNeBMWeYu9M/n5ttXl+4Ec9kD5igoIg03N
         Ub7f+hSvgyyluG2m1EfYVrkMRIR974COEvnyp9EOcjLCulBoLAq8ZHy91BdpMWs2iixY
         8PSPzRLNYzq8VXvs/zpk18eCATKDty/mW3xO0QYbjspbhXlYZ/ah4Zf059HEHhvfCunJ
         dLgg==
X-Forwarded-Encrypted: i=1; AJvYcCVfQ+iltorYnl7Sv9JXqlUL3FppUJ/vq333LaudjD41dSaAaqp/+9crULJShLHLTrDGkmgW+eN18rLd4oFnfu3rKxpC0diq+7OltSGh
X-Gm-Message-State: AOJu0YwFoIwe52ZQCFtmyGSw4MQ+Qdf/CiwgqLLgjt+wf89RvZvEWgtS
	apzUGUjIKE73q/RpBR8VgUzBRx6IEKgXSl/tYBmgsONN9S1Bc3YgUfY/LAZOHvq2vpScBgyFN3S
	uXw==
X-Google-Smtp-Source: AGHT+IG0Gep/G4bjbFazXgVgd9fSAqw2YFcNgT+qyMOGlRi48ZeT15IrtUQlOudz1cmwPH9WqKNK2g==
X-Received: by 2002:a17:902:e887:b0:1f9:e5d9:ead8 with SMTP id d9443c01a7336-1fa23be1ea7mr174919845ad.14.1719541504472;
        Thu, 27 Jun 2024 19:25:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c19a:b9a8:4bd1:72c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388fdsm4417415ad.127.2024.06.27.19.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 19:25:04 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:25:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/zsmalloc: move record_obj() into obj_malloc()
Message-ID: <20240628022500.GF15925@google.com>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240627075959.611783-2-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627075959.611783-2-chengming.zhou@linux.dev>

On (24/06/27 15:59), Chengming Zhou wrote:
> We always record_obj() to make handle points to object after obj_malloc(),
> so simplify the code by moving record_obj() into obj_malloc(). There
> should be no functional change.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

I guess I don't have a strong opinion on that.

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]
> @@ -1591,7 +1589,6 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
>  		free_obj = obj_malloc(pool, dst_zspage, handle);
>  		zs_object_copy(class, free_obj, used_obj);
>  		obj_idx++;
> -		record_obj(handle, free_obj);
>  		obj_free(class->size, used_obj);

I sort of like how here we would copy the object first and then record it,
some sort of "commit" stage.  But I don't see any issues with the new code.

