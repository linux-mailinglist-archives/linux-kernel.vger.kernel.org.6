Return-Path: <linux-kernel+bounces-517820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C57A3864D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84CB3BB5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030622069A;
	Mon, 17 Feb 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KM6gEvKw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43350221701
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801968; cv=none; b=LTDCclyrdtSPxgIDTKM/qORp5CiQJRYV5LBIWbhl+KBkvt64ux6ljziBC0YEAoo71gQYBj0du7cETqM7qc8JbF32SYJZ+MawC88RRcGIQho4fyichhP1/wjxvQ/YsAp8plRZDgecvbUvlPPJY/lMFIWOrNZdFjNS8qK6XXbfFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801968; c=relaxed/simple;
	bh=f+lGY3bRo6/ZlhAWhfwDJ4lK51LrYKEasKvNJQ3CAN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEZaZq2PgdqpSpVebIE3fV4W8JDQbq8l7L8ktSJsVsxsaZwMn0DcJzLQluMC1uP2ndIRAEVpuSYWYKkRBD8pPmu9tSzMsmoKtK/PNymPz/K30HiZ6581fWwUk/koKmNrO7E8143ckkFwkN69UvsOf9MMtwRq0yBjPAS0lVpYggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KM6gEvKw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb90c20baeso182195966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801964; x=1740406764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zu4oJ+jaqD1SJBOCWTKei1kl+R5dexP/eMTe6Jc1Gjc=;
        b=KM6gEvKwOZVqAr9YsrHEiRTrrwe3c6xFtk7kht3PDiqiKeAiTXHj3SMEmO38hY82nz
         I/fRrFqoQvfB2DteAOyKm10D/8Y/fBS+Rl7YK1gC+r5dV0p9Kduu3ZQ/tAz9zEDvxeWR
         agSj0HM6ud3d2lgVZh1q9uXRsd4AasB03GTaJffpXR/DU/PKpP3NvAsUCDLckDhihz7A
         DIBRlf3BZ/vFRYHUc6iIXvVhTEY9c3qUlbITuwtR3LybKe57PVFVjNGVVWCNrx7J9rMO
         bEhe4bv6T2adm33Rn14ijXBgUDb6V70LdJO2AC/nKGVyIbu8/MqY/GzBnSvJ/eXa4tV6
         ghww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801964; x=1740406764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu4oJ+jaqD1SJBOCWTKei1kl+R5dexP/eMTe6Jc1Gjc=;
        b=YtyJiWf7I91+NhY1OJp//I5z4O0Xfh4KWdwXxeEGzSwpmvSbis0Fkz8MIDwxk5CreH
         p5ooUy/skDadoxcNvAaLV3GClYzBZhanXUCSnFISkzGFbETc1Vl4k/ebYHUCV7GGo6qW
         EhAICCBIq4AAgYYbZeb4M5R5mqAVWBbEIeVWJelNTlrhOM3TTep/RVCxGo5WNHumtRt7
         XiKfRRi/AlWTDdjwfyxTrFRihdNu0/PppbCgQSuSp9yc87vKr7KE5fhf6si1gQjnSewx
         NF1r73Pysjs6MXKPmRHg8hsAHkvITUNv31etnVuIK8YGlX9O31EuUagXjJWvM00pSqcT
         2oiw==
X-Forwarded-Encrypted: i=1; AJvYcCVZErAYwq72uAkqUAxCRsvDMAfN2GY65+ry5c4hqrkB53s52JOxrT4ccN2jmgAAGx3vAE1d+3vLfqjgVow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjsb79mYZPU36MrbfSvL86x/o/YJ1UbvS8Sxq+CLh50BjniGi
	gmSc12efZTGANkmgSbJlgHTdrTnTQe0yxmiWiSks5WV59142zT40G8zXEu59WSA=
X-Gm-Gg: ASbGncvwGpdxSfAz6ZlF7zdghv3pZ1QPA2uTV47/iO5CfCdAFrcAntjWYJoAvWYAGj1
	RHE/yKRV9b7gqZQwnLQ28LlxJRcEX16EbtfzJ+R167sGcDXrihLVmfwTEgY3FT3as+1xINaWt4e
	c1Si4UzvIxXhCRpH2heAdA5zY9LZUK+TFutxFx1oHB7SVzQh4hKKOA74bJeKprOfa/n3MvYANi4
	aaSpNqKqvfT3cKLeQmYECVoHBoIxD94eABRVdGYWhaim+9CNBx40l3YrsQDDhYBBA78gTvwayTY
	ShkWB993LrZlOgMTauG/
X-Google-Smtp-Source: AGHT+IE8w6imfFH8KYgZ2tawwP2DiwXKUkUiNLxLFwschuBltQWRjocByVFunBs3ccNxbFC7TA3z6Q==
X-Received: by 2002:a17:906:6d04:b0:abb:b092:dade with SMTP id a640c23a62f3a-abbb092ded0mr66067766b.38.1739801964594;
        Mon, 17 Feb 2025 06:19:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb99fd1983sm224140966b.108.2025.02.17.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:19:24 -0800 (PST)
Date: Mon, 17 Feb 2025 17:19:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	kuba@kernel.org, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH v3 2/4] [PATCH V2 2/4] staging:gpib:agilent_82350b:
 Removed commented out code
Message-ID: <2ff8f3f8-e915-4ec0-80e8-fbc87c8fd1b2@stanley.mountain>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
 <20250217103046.54294-3-kumarkairiravi@gmail.com>
 <629f57dc-d6c7-48ca-8b05-f1d0169eb454@stanley.mountain>
 <CAEEw=4mN+Y8G6a92baCH6kANcpmTFDzn_LSS3XRfXAFdPZxo8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEw=4mN+Y8G6a92baCH6kANcpmTFDzn_LSS3XRfXAFdPZxo8A@mail.gmail.com>

On Mon, Feb 17, 2025 at 07:09:23PM +0530, Ravi Kumar Kairi wrote:
> So should I just do the whole deleting comment thing in one go? Instead of
> first deleted comment and then deleted blank space?

Hm...  I had to check.  All the issues addressed in patch 3 were
introduced by patch 2.  So, yes, combine patch 2 and 3.

regards,
dan carpenter


