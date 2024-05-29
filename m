Return-Path: <linux-kernel+bounces-194758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C08D418A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9563284003
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34561CB319;
	Wed, 29 May 2024 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glPZg63r"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6617557C;
	Wed, 29 May 2024 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022947; cv=none; b=t2X+PbucgtQPTbiQu6YmCny/IADXKS0aAevejcdP7oBQcWWF1to9MzEXf2cBoc11MsmbRwl/ug8VtFZl0gj2Gu++C+OXhGxhpnZMKF7P/ByoGxhQtsgpob60lLYalzNeAVlugWC4KMSNNfveuCWr/0pFYOwLfOSZKAXa+4gjvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022947; c=relaxed/simple;
	bh=sE2MJlPikjuOSV4yS4MMCF38uk7qYy35oo4TnxwPTko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW6fP0yQjS/Hw7zQUrk088VdRunsJF8v2j95/84ZDJADv26gZ/j8f36cHHLIskkxNc1y2k4Ys5nsLmydQ1Md5ID33hEA9SwvnBhXEeaek/j3Yma1ytDJLachAqjkVYiEY5kyQ1whn6GCrwVXyMx3pvZCzy0z6hpcYzvQi8yC/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glPZg63r; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f48b825d8cso2581155ad.2;
        Wed, 29 May 2024 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717022945; x=1717627745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDjKNrVLRGu5Ne1lYlgXYi1sa0MIYMtjQjWt+EANKSU=;
        b=glPZg63rnQdOI5xVsnpgjxIVZMT191zXPlDAjRQ5s4oC/zBKeakQKOgKrad0C7sTvQ
         c3QKsmL280BpnnBCrE3Us3l2lSRTu/SeWM8jBozPeUq3QNbjMXoghbzYIrPmoB/yo1Ha
         GRzzzL8hbO69rvJUbdPcsv+deGuqxfBzK3lXdy60+zbt9S5xqOMUtQQzS+gJwIi33zXI
         QZsYPEqqGRKHig9yb0qzylyN8bdrODmKFB3bjj7tEqCvubbXAKD2MF83FHDKHJHslgzl
         y9qxOyT5en2dXCVmAnkKCGJlssWmT6qwitUGb2vNAb0JCcmg1wnH2WmDsty5nrprW51k
         VNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022945; x=1717627745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDjKNrVLRGu5Ne1lYlgXYi1sa0MIYMtjQjWt+EANKSU=;
        b=QJh0jKCSU/dz8KDEI1b/QqQfRihdbCqUMmfoiqk//i6tE2jcOtNEAMEkOtvK2Nrd2R
         Jbkh6W4Tbv9P98HhtZpGV9l2UtH1mHkZpdfjC3YIxiq/QDedcKfoxlUE2VpIgs6IiX9e
         90UB7/kpEeVvbQV80xIut3h5HF/aFcXpfHKmLn7OIDzkiO8vGoNnuoIvGRTAWClhBdQ+
         dIcYmxmxqY/qLvtvcPysINDKARJLvuU5B63K9Yg+1tFCqryiGMUcLrU5kB6PI9GMqxHS
         OE/MfoEPvxNsiL0y6NObJm4yFZqknb/JvVndt3/5dMtP5mnMkitLNT3ZJ5cuUsGGnWoe
         Hwhw==
X-Forwarded-Encrypted: i=1; AJvYcCWovnNqpfmb5F6tOj61btRgZfjsjp9+Czq2URIp92jGGMy3gN8FYziriW6ktOxRI9F/c4ExpNsH6UqS4R3Z1NTA5c28aEN53jblGEucLWFrgjHVjDvjZZ9WXbt3ASKv4PgwkdCPgqJOMs4=
X-Gm-Message-State: AOJu0YyspdKsquX4u46kt9UEqHSeiFZPeGewLtup5JRH5o7v4+qONRMR
	uDSlszeGUGZFi2TnR9ji029tk8cNMROGNwRrXCNBuH6MeHtqAjtU
X-Google-Smtp-Source: AGHT+IGeIXCl30GkVgxYdOIAqW8hOTpfwE3Jxy44LwEitvhX2wgehaNw03uH6PgVyne+j1WdVb6P9A==
X-Received: by 2002:a17:903:2446:b0:1ef:35d5:e3ea with SMTP id d9443c01a7336-1f619937986mr3908585ad.59.1717022945017;
        Wed, 29 May 2024 15:49:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a683asm105572925ad.225.2024.05.29.15.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:49:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:49:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH] hwmon: intel-m10-bmc-hwmon: fix multiplier for N6000
 board power sensor
Message-ID: <1a3269bf-6f0a-4f59-8e39-c34f4f782860@roeck-us.net>
References: <20240521181246.683833-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521181246.683833-1-peter.colberg@intel.com>

On Tue, May 21, 2024 at 02:12:46PM -0400, Peter Colberg wrote:
> The Intel N6000 BMC outputs the board power value in milliwatt, whereas
> the hwmon sysfs interface must provide power values in microwatt.
> 
> Fixes: e1983220ae14 ("hwmon: intel-m10-bmc-hwmon: Add N6000 sensors")
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Applied.

Thanks,
Guenter

