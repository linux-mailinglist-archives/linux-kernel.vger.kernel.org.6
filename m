Return-Path: <linux-kernel+bounces-267799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17C941597
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970672822B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253A1A38D6;
	Tue, 30 Jul 2024 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIByJ6xt"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17811A2C08
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354106; cv=none; b=etjRb+Pva5bxJwdSeNcWAxXy+NQEjLMvA3wEw0jdXKdSWgitcBgOXaJqywNI11d5NbNHku+cz/Oqfu0LNQdVwEha5nvfG6QQlwOY9gEiLcuZhZ7haEwCxyger7tnbXY/iyPJkMpHYDnYVCTo8HIMjeawDa4Xp5bWtQdlQljUHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354106; c=relaxed/simple;
	bh=6S1+m+RU5TP0WJO+ATrG36zohR9UGzfg3bpcYcZuyIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otZo4DtypIvz0HYd3yNLCIZHqotApRSO99bZoyPMOKAuH5f3IaqATrGzpe21jOJcxoiqxz19YQySFtdWI5+aE91dIF4KSz0mihIwQp++Nb/zVc+lWfoALtq6kY8b18NsbvHWduc5x5vHBOSEIvXfa9Pj0xtq5PqT0RyFpGuzP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BIByJ6xt; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260dde65a68so3187586fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722354103; x=1722958903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QOYhoQjLh01grFeGpfGAtgBAV8l3EXt2trNxBAoFc2Y=;
        b=BIByJ6xtp/ijXxEHzvIL4r7Tj7CULE8pzjrH0jtl/CPmPskxaCK8tgDpmAuMQcTuSy
         JJvV1uAwAdEtlhdGJpdIPc0LbJVcPMzFNKHE/QYR4CIj/uvdkFKROeKk8TsRh0wv1V2y
         6JJ0Yb0YHHOJVBYVmG5ePrVumm0cDmxVm6thTLE5z//CsBXrDqJDHnl/UQyvlmbDFkEV
         ST2h/0o2VGk5APQCTmCu9JR7jhBoqgdgSxXxknUY0ZkT+QdDjpcvE/tMBy1kJ4USoMH9
         ttsZflmPIgxQt4QAWJqadTxWenaWjwUjQKPL7DSzS4kllJB6ZyRd3hQkLDkY9QUSpCdu
         EYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354103; x=1722958903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOYhoQjLh01grFeGpfGAtgBAV8l3EXt2trNxBAoFc2Y=;
        b=Av5rCCK64FcuCVbJInykYF8Oyh1NipsNCKcJy7sFnW4E8OG1ZLwV6GB3oQYAk5wZ9v
         DZh/bNwRpIZxEAH9zi1HJ4cOeFyqTmzRM7GFHNEwySfzUuTiOSEDep+1N6AszXortnHB
         X/3r7k7kC+0rDSg22Yu9BnzrY0TR8Wfse2pTFxfJPKLyFD4nYEKGV4Y8RoIIFjPIOiBf
         XWfqxzvyhEE5ISDrffI2mbIAH7nvqLLhH23RlbJG2r3hVYRzKFrzUlhSn4fray2sedR5
         6q0cxz0RlKkXNVpwxSal3pefBSGdeKy/K4tWPcjGbYjPWO6B5xwHmXGNc9nPKFcs4n0J
         fpBg==
X-Forwarded-Encrypted: i=1; AJvYcCWajOGK95fxvFRj1qF322t/lOS6KdlBrV0/tVupgn9uBKzGA1wjuL9AahzXc9ymq0X6zTjciYJ2k/Vhhbc6DWwvQV2E/Y3883+TW1Z4
X-Gm-Message-State: AOJu0Yzoye+vcoeHaxyUsTOTNNCwFi5HAmkUXujGURnyWPFhTlrSa971
	xVloX41EKg3jx+9Mw7XbPs64TMdigpf0XVbIpwc4Yz7PgoomRqVl/fLdhQer+hc=
X-Google-Smtp-Source: AGHT+IGqePBFhhpk8DQstbQ3a2wmKNDOtmsTlHz8YGGpoYP/ywMn8gIPcKM/fxeJ8kWYjggfjSyb2Q==
X-Received: by 2002:a05:6870:519:b0:25d:dea:456f with SMTP id 586e51a60fabf-267d4f36803mr13457664fac.42.1722354103139;
        Tue, 30 Jul 2024 08:41:43 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095ad4e936sm428038a34.7.2024.07.30.08.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:41:42 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:41:40 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Santiago Ruano =?iso-8859-1?Q?Rinc=F3n?= <santiagorr@riseup.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, helen.koike@collabora.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2 1/2] staging: media: sdis: move open brace to a new
 line
Message-ID: <e7fb44cc-1a48-4486-b9b6-e505fa1a4e73@suswa.mountain>
References: <20240730080628.991297-1-santiagorr@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730080628.991297-1-santiagorr@riseup.net>

On Tue, Jul 30, 2024 at 05:06:27PM +0900, Santiago Ruano Rincón wrote:
> Fix checkpatch error "ERROR: open brace '{' following function
> definitions go on the next line" in sdis_1.0/ia_css_sdis.host.c:239.
> 
> Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
> 
> ---
> This is one of my first patches. Could you please tell me if is there
> anything wrong with it? Thank you.

v2 patches need to say what changed since v1.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


