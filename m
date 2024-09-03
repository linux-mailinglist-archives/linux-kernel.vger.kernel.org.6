Return-Path: <linux-kernel+bounces-313946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF7796ACB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CC41F25615
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC41B12E5;
	Tue,  3 Sep 2024 23:19:47 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35487126C07
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405586; cv=none; b=iHU6/LCpBrd9i8Kzjqi+DdsMM8pXOraXq/FQ2ksq43jEFBO10HKP+3xDAeaodkKkI1Nm2dN52ipgKbjN/k06LIj6IQyCtYHJ4kLTLXI1W7d9hTSUXIUC4QryqPJdVnIntsjzBCx9ssd9oCjhfhnaSCSWYG8p1fHWFcqYjJmrb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405586; c=relaxed/simple;
	bh=1cNuZ5vvM1BwYOrKWY3og5ZYu1ar/VPzjfYW7RN6UWA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGfcZ04ddfnh0BOMrOaR8GgC0A7o//ImslFpZ0/xWc7+LSjdfWND4dOESq49N2nmbbQOCJ251CZGnS/AxQTK/BkytDTS8Ad/9mY1HoyS2tBz8VQY8KLneEyDlXLudWz83WJNsizT+EJZ9sM5SjPu/0UjGoHAhu92GA2rLtl0lS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id fca0b417-6a4a-11ef-abaf-005056bdd08f;
	Wed, 04 Sep 2024 02:19:37 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 02:19:36 +0300
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: wbg@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/counter: close fd when exit
Message-ID: <ZteZiKKsAYmGdu0s@surfacebook.localdomain>
References: <20240903080121.5294-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903080121.5294-1-zhangjiao2@cmss.chinamobile.com>

Tue, Sep 03, 2024 at 04:01:21PM +0800, zhangjiao2 kirjoitti:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> close fd when exit the program

Please, mind English grammar and punctuation.
Also this doesn't state what the problem is.

...

>  		if (ret == -1) {
>  			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
>  				strerror(errno));
> +			close(fd);

Since fd is not used in the messaging it's better to close it before printing
anything. Ditto for other cases.

...

>  		if (ret != sizeof(event_data)) {
>  			fprintf(stderr, "Failed to read event data\n");
> +			close(fd);

>  			return -EIO;

Side note: This will return garbage to the userspace. Should be

			return EIO;

>  		}

-- 
With Best Regards,
Andy Shevchenko



