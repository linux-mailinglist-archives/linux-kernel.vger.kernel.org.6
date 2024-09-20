Return-Path: <linux-kernel+bounces-333980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 619AB97D0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBE71F229BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C92B9BB;
	Fri, 20 Sep 2024 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4Xfxzd8"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AA8BEE;
	Fri, 20 Sep 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726811138; cv=none; b=e7okFUUiQ6cYX4ngyH5VKP5UIXbJtaRhk6cJJwVVkh4zqgagQBR7QxI6YckU+fn5wHV/bmb3PNhNR+B/UhIu2hP1X2Ot6tjtmsYcLrCBA986mZEBqiJvcyug0Z218jAv/ffmJdczMzSmaGhJCWlOQEEHivUL4In6IxEHXyVhJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726811138; c=relaxed/simple;
	bh=xyZ7fCRKLLzOqpfrTCcNdYqnfwVAn6C7iTP3WNZQWGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlbXj8jHE5d+bmORKvFwnZPzJwrG9DjbGAi5pc6H0UkSI/e5zvenj7oxG5WbgAJ/7D/CA+6DIMUG3Oj97nVwqIQlm48i2WQrQuU4N+pE8N6GAMm+/C13H8EoblwNphtzZzPEJaVPvNXvU5Rh6v5050ztke3qdCu3R4u2v1zAa40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4Xfxzd8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso1372007a12.3;
        Thu, 19 Sep 2024 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726811136; x=1727415936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7Ff1g1Drswicd5AFypmvAveDRVf554D/Un1zMzYLss=;
        b=N4Xfxzd8GTdOr/bVozUCekNG3Rzat1Bag4hpeSfUtWEr+36f+Ktyms2A1Yk79qLY49
         s6if2VUiXq/YhPWQX04EyUjwJhuTLz7JKJXxXgKasCMg0yy2TII5kwDd1ifEGSQZrX3M
         8olHA5NWyanvng8hQccyjoobv/htrvZYZlBFJXFvqqlTmd1LhaL+v1Vk1Ca9EESWnTmV
         5CeYhOJCO/kO7uJlOBNQyykhRacwni0Y5xKL2iH9lMsRlKsKTJk8jU8PzY6MwoTOojAb
         LedJXQQbsvzFnWDMEAXO45XLAEsxMQzZE1b7L3FbZzlWDy9q7a2eh49A0UNMpkaOHAE9
         zPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726811136; x=1727415936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7Ff1g1Drswicd5AFypmvAveDRVf554D/Un1zMzYLss=;
        b=Ozfu191oX58GZJp1/IUMeiIgCNCsnim3ypKiKhqp2Ika6gaS7O/4K4YxvF3gO0Y+4K
         YYx8rfQ6ofdHpzTOHoBXZznkael0UhK7LGGMHT5Oil3l+eN2X3DY90/mpllN2P7Nnw5W
         qqHolDbaYil7AqPkmsFAJrysf8IqiKbCLaIEtEYR2Mzl6ulHZcK6FWNio2Svz2inucY6
         +5xDjZ9VBpSDbowJfIw8ROeYlbrUcFnPf7Mi5MzK1s5m3LmWCv6nRbG6cDc8laxOzS26
         dqUc2UUF5DsSQwIDHasTiMcDj+mYFFgiyUb6yX3GLJLGXkWt170Nb84CKKZ69J0bJqdc
         k1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo5TsJmme5yA7ndfFhnwn7/2A9a6v7H+v/EyiDpBEY9pBJVyM4+RjFMTWppyAHqcYl7CmmkaOT7uS1Kw==@vger.kernel.org, AJvYcCXRzNKW7ydIhTXsSc2vTLD054m1C8ZkNYLLBUOYHBOc9dWbdDo+DEAQqNzN+KK/Avm0JzPKUVFUfdlz2m2f@vger.kernel.org
X-Gm-Message-State: AOJu0YyKX4iwiwIKfxABnHs3ggAw/MWXJCy885LvqcAooeu3+srSX1a5
	un/fxbj/r2LmMJnf3C2oKQ/QiKCYmx7uu/LXku2W3RTeepWXSAD28HTrGA==
X-Google-Smtp-Source: AGHT+IHFdtE7QWCZCnH5cr3hwd9Oo2ECevFM89VH28VMj9rdW7I1xKnuCrwa/Bf4Bomui4V7HcmJAw==
X-Received: by 2002:a05:6a21:a34c:b0:1d2:e8f6:81e with SMTP id adf61e73a8af0-1d30a9268a3mr3058561637.24.1726811135651;
        Thu, 19 Sep 2024 22:45:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719918df7ccsm1972084b3a.40.2024.09.19.22.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 22:45:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 19 Sep 2024 22:45:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Michael Adler <michael.adler@intel.com>
Subject: Re: [PATCH] hwmon: intel-m10-bmc-hwmon: relabel Columbiaville to CVL
 Die Temperature
Message-ID: <badc6aff-2a95-4127-9355-c1db8f619c6c@roeck-us.net>
References: <20240919173417.867640-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919173417.867640-1-peter.colberg@intel.com>

On Thu, Sep 19, 2024 at 01:34:17PM -0400, Peter Colberg wrote:
> Consistently use CVL instead of Columbiaville, since CVL is already
> being used in all other sensor labels for the Intel N6000 card.
> 
> Fixes: e1983220ae14 ("hwmon: intel-m10-bmc-hwmon: Add N6000 sensors")
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Michael Adler <michael.adler@intel.com>

Applied.

Thanks,
Guenter

