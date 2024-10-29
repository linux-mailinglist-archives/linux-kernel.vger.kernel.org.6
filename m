Return-Path: <linux-kernel+bounces-387565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3C9B52FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CEC28294B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423E2076B5;
	Tue, 29 Oct 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StsjIaZ0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B52076AB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231377; cv=none; b=dEtbaNbehr5CEsjC8kqPlRbRCzlqBtKElV9xsRC/eE/ni5AbPWc3Ki09ImRAITJ7a5GjvGRm5P8sFuj+tDVy+Dn4lioDd/cy+p11R7aErmdL64BAiHRRDmfwVO7HCp7O6uRROb59PTR3nBQ4eVzUQUK5ApjokWe+wEjWGM4GcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231377; c=relaxed/simple;
	bh=vhTJf7t7/X5EyRXlSrvjdYvaWcYE0wDuIRV2ChOwtlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTbrYYkgQIbIH4rrCz//fbefBVUGfdaI1u9z1AhSXIpnEU0DhaW1KHNt61UfmxjH2tM60FV670VIVJ+CY058xqd9zRGTWRo+8jHMpNrfVdkgPQ78UK0n44vZ49VF8j8HK+AIl/NFoTJ579qjTok2IIkKzU1kk5weEe7BIsp4lIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=StsjIaZ0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so706892166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730231372; x=1730836172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6O2h4B66uPtz7k2AhjB1yCKpOLR6rksUesCzlHXhZIc=;
        b=StsjIaZ0uQUFudpwSZDfm26p6tXtM8CghyhKlnL5oexP8YOf8s9+dZ6tFYpr1Z8KbK
         sdU6KYYNhIEQvhiSOzaE8LRPNy9a63v6bbKVtYfMXpPPzHuxT14bxEQrYyGFkrBsht+P
         9PVJHoh3hvIzDFjg3iFtHuvhKv8gvudBjmy9qNcIcniUaedh3R/74wHkT58i/M0fGxCT
         P55P7C4GzVO1kdD4YpPbrVuiHQv28QQgfbIPUnaTJZsg80wll4PmQd4WkFowv3+KUVfL
         MBLor3ffU4MxVEokOxfuol1xGRykumu888MVfeW5QKmi43JXAEIxXKLqHDuA+IfDM99n
         jjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730231372; x=1730836172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O2h4B66uPtz7k2AhjB1yCKpOLR6rksUesCzlHXhZIc=;
        b=YvmcFw1K6YmWApNdYtvqD5Ud8JunYfgcE+uuUkCbUIYV5ZhbaVwiHb9yHESnJ3oXyl
         EfxJ4SRwaaMMSiq4Yz1Es3rM877Cg8ZmJvFlbn7kSYaW+dpd7I1vEnroIAAK0dwE5HE+
         6IjqTBfEzKda36i+IJVW3Pp4meG1EHpX74x5HFFdkFWXNvA+vtDAqWAREkxAoGm5rkRd
         oGIq8YDcj5q2o7IZJHerJ1edshH8pwL0etFdbnz3/nKAkMfWbL885IsIcbXcFLZxJY0Z
         tkvdlQMd1Hi8UNCVYBih1ueGKRTd7scwBb+Cu8OxVD6n6KqmXK8ccPOiaPhB1K6+iMOH
         h10Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwHiY4EWkycgq7kVUejSvKufLQnpn3e7T69fBu7swWFOHUksj0ILZPIBg0xb1QQrcKvwO4AXeS7wqsUHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7OcSD34KxSJEezwXj8251sZZ3DO6yviudRrnVvQRCPmJA3ZFh
	RXoOhJX1CwG4ZiP1bYZm6thndiW1xziWRq1fM+7ldseFByUfp2cJFbeBo2j6/x8=
X-Google-Smtp-Source: AGHT+IEhcXXo9FaHfKPLm3VPezuDMVGoVPplP0GLW0T2t0EhbH/TJfxjJ3K5kbPv611l00iKJ7kASA==
X-Received: by 2002:a17:907:9608:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9de5a4b829mr1265190566b.0.1730231372302;
        Tue, 29 Oct 2024 12:49:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c392bsm4207800a12.50.2024.10.29.12.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:49:31 -0700 (PDT)
Date: Tue, 29 Oct 2024 22:49:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Sakai <msakai@redhat.com>
Cc: Philip Li <philip.li@intel.com>, oe-kbuild@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Message-ID: <a048daa6-ab57-4d06-a7d6-df119e2845c0@stanley.mountain>
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
 <ZyBQa45RTWXiXJke@rli9-mobl>
 <ZyCLo51ZyjxX7eQK@rli9-mobl>
 <13937d22-46ac-480a-8956-f89a0fd295ac@stanley.mountain>
 <68866f17-f327-4df8-ae17-dfcc50362d4a@stanley.mountain>
 <1c0beb9b-6b90-4c92-a4f3-f228dc0aa527@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c0beb9b-6b90-4c92-a4f3-f228dc0aa527@redhat.com>

On Tue, Oct 29, 2024 at 01:03:35PM -0400, Matthew Sakai wrote:
> Okay. Just to restate, what I took away from this thread is
> 1) The current code provokes a warning.
> 2) When bisecting, the bot found a (different) warning from the patch
> introducing this code, and so the mail points out that warning instead of
> the warning in newer code.

Not a different warning.  It's same warning.  It's just that the code in the
original commit was buggy and Smatch kept on warning about it even when it was
fixed.

> 3) The warning is showing up now because new checking allows the bot to
> notice problems it didn't notice before.
> 
> The commit I cited fixed warning from sparse, but I don't think we looked at
> smatch. This particular code does not have a locking problem, but the way
> it's spelled makes it difficult for static tools to understand that there is
> not a problem. I'll take a look and see if there's anything further I can do
> address the actual current warning.

Don't invest a lot of time into this.  I'm re-working the locking check really
heavily right now.  I know how to silence this warning when the cross function
DB is enabled.  It's just that I'm trying to decide the best way to do it.

regards,
dan carpenter

