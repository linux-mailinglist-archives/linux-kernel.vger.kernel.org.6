Return-Path: <linux-kernel+bounces-175292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708028C1DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3821F21C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007B149C43;
	Fri, 10 May 2024 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FO4iuYno"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E961509B9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319220; cv=none; b=uKEnWAVZnAKmFzgkPY+0fbh5jrY72UkqSS5sq2A3NHTWQOqnfYVp09QAZrqSpSvtGO/Cg8N1iJUx8GZ5+jofVwRxgS7RZLvwC41W/VlY3jHAvz81hjj08yM66R61E7B1O3921ugzThy4TmEjs3Axqi2KXtTXqlSoo3RsATMc6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319220; c=relaxed/simple;
	bh=lNJnk/IwO5G1DeyXGQQshC+4Yf6eHRgkO8qVDqyoQL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXrBpxXnY55DfeI0aM0c+7BEir8bMhm3hVCcj0N9w5x4cUW232DwdvCLVrRXnAchDUM0bvyRpJhaD1fn9e3HP/qb/xCs9o+/SBhO8EBompxbm/7dmqr8PxFeiE8iixBkvYGgfZo0ksqC17SmBLqr/YyyJhv21QU+ui4NzUAlxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FO4iuYno; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b27c5603ddso444346eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715319218; x=1715924018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNJnk/IwO5G1DeyXGQQshC+4Yf6eHRgkO8qVDqyoQL4=;
        b=FO4iuYnon0XVNgwdtr+jcshFBAkubJBUSmBWMkZld5UTaoDQ7NaFkUdFWUPj7Pmuoy
         bk53A2kauc6Emz8SkVBu7H7T2JP1vf0ivHHft0wPtEQA/oS/rDh6EWdzUoSRSNq+7+Bv
         J7sb2WbftU+b1KBlD6mLPyWaj8wIpyB/aT4uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319218; x=1715924018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNJnk/IwO5G1DeyXGQQshC+4Yf6eHRgkO8qVDqyoQL4=;
        b=JAH+rK5UMVDq5mwuFQl6TlcekWQKDUTB8Uc1J/u0iEiw1W7CJ5QEdKfuc98+1JWzdO
         QPnsyxEd6ok3rnivOiPAT+TDfGIPEzJ3X7OF5aLsuLYA4WnWH5NlNTM38qzccrm1gkDi
         1SdhY2qRq+m6RU+mmth05FoZZAn7LZ1IXF58dNlAMryUvaad8LBlignMxu9pQ8S3TOzd
         yTRbXxnKemj2KaqmV2svWeLHTM0zsKNHM6nAzps7uz2K2+Bq4QkybKnrrEXRDNKLJ6Ew
         ELjForpS6e0uWa0UIKPDfXk/JSBn8PWNGCvGle0Ii2bk2b04uIUY7x4O48FrQg+S+KwE
         miEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtV6S2CzG/DBrsSBX+w+vCqGRaaaB9sqKQ+or6ojUVhtpC16PgO4ApN/XK8xzki0bGTzyHAQzUR2SNExDXqDhqeLxBUTdtSKq3658e
X-Gm-Message-State: AOJu0YwWvzik4Gaun748dq1WqJ5ITPWBmmQHeYACQiNhGUbiXYo5TjmZ
	xkYKjIOg3oEal0Ob7A2XjPk3MR6oKf5zMaMztKgxse17Mahnuc8FeVTnGPe8mw==
X-Google-Smtp-Source: AGHT+IFCQqwUjXeObeIhefjgn08J4INBR3l9e7EL0ARvLx+ZWaw2vg+uMR0UfMEm8ujEuFv/PHtCPA==
X-Received: by 2002:a4a:588e:0:b0:5ac:bdbe:10fd with SMTP id 006d021491bc7-5b281a5cfc3mr1616558eaf.9.1715319218091;
        Thu, 09 May 2024 22:33:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a6660bsm2190608b3a.8.2024.05.09.22.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 22:33:37 -0700 (PDT)
Date: Fri, 10 May 2024 14:33:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: kernel test robot <lkp@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv3 02/19] zram: add lzo and lzorle compression backends
 support
Message-ID: <20240510053333.GJ8623@google.com>
References: <20240508074223.652784-3-senozhatsky@chromium.org>
 <202405091921.320BxOyE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405091921.320BxOyE-lkp@intel.com>

On (24/05/09 19:23), kernel test robot wrote:
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240509/202405091921.320BxOyE-lkp@intel.com/config)
[..]
> >> ERROR: modpost: "backend_lzorle" [drivers/block/zram/zram.ko] undefined!
> >> ERROR: modpost: "backend_lzo" [drivers/block/zram/zram.ko] undefined!

.. and that's how learned that my .config has ZRAM=y

