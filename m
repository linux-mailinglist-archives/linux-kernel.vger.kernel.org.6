Return-Path: <linux-kernel+bounces-396107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3DF9BC7E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B7F1C22355
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8421A7AE3;
	Tue,  5 Nov 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loh+p4/W"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F8762D2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794978; cv=none; b=khTJZfQLuuF4lkM9AsbPHyRuuMqW212pGT0RqiYgTUjY8lLfazZdBNt94HonRKuD1v/rhfZ53z3fCAa0G3FDZ9lXxnFxfKQjc9CaNu0yZougI/CPyemD2x0wylh8rIdYFI+BGeOvy4aV5eqObau+XYIjxful8FcL+j3KjsrmR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794978; c=relaxed/simple;
	bh=pDWRVTIIVd539bJF3xnYypJRZFABqCixIOL8uAG/ZbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCRJUh/2Bb1n/GAu+FO2JkTafeQTfyrlVY5zvuys9RUdM5pXLyDTR1t+DnLiZPcn0YDdFdsYZbtoro/+/kggbh+vhYQv14vPaCMPsmWnwrt1G5NQ17zdKTj4o7nGsOSgvOi2JChXG+OuDv4lHtHe8wC0wZnY3+htYrSlu4ATHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loh+p4/W; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314b316495so43889855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730794975; x=1731399775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5G5P4ojeaiWao+UaxuX3ijXfztM6+oSFmGiVcnC80I=;
        b=loh+p4/W2bxryAzTuNpgIIQyLBiLDWU5OqpfSlwoqPIP1Yyl3MyAQAwwVKiEOmIjdR
         q1uCLMsI+XZ1MoziyQqoVXL5DUBXjkpnmcFNVXtCiMjOCLKXB+Acgs9c7lTcrqyFotRH
         6MpViDz1Tk0Mdgi+xl6MFnPpGH9vFsWNruqpNLd7GV3xZC1ed/wQeIf9iwseU3MmxxfT
         oNPwTzxlAQayBmcfItS6k9ikhUdviCuZFyBCJQyuqCCe/Q6837sz4M+PdrD8BKB5v5ir
         9ac8l3FzsNaRTd2NYJTuf0RTNxnEJW5o1nm77DweZ0vVtr4xLXfv3EIZT7hn6oeOoHdP
         m4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730794975; x=1731399775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5G5P4ojeaiWao+UaxuX3ijXfztM6+oSFmGiVcnC80I=;
        b=k4qRnP1Vi5SOKWxslHwclHmsTuDqMFdA1Xbs1eoVDqd5P/YpdA7JQ39RlGcCV0xtH6
         UpT9j+vgmnHJoLByMFmKJgdNXs4E6fkobD7i96oV/PQ+LFvgH4CB7XHFYzCF+curJlu4
         IZpOzePXfV5YBVcidKSBA4tAQNpgZomxu+QUgnLt4HWfL7lAStzi/aB9hxbMs1IlaSJp
         3Qfu5A2v+AahPpANZfsZUYPeVb2ed9B//j2X3k2h/znGZj5s1JUs530Sz6yTe9U1Zz83
         UOGRtLfovcDor5qlyjklSXJimJr7RwJd3T42h1TOcSEXMPtEBx4tNHmBFx5dhgA22Aoe
         Cn3w==
X-Forwarded-Encrypted: i=1; AJvYcCUoWnmdw/VCJH+UIBwKSVYOmHjVpEAFGfQKYt68tvEaKqA7sHGbYVRfKCm7fhCCg44yWPZvwbSfOw7wgl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29z0wDZPppT5g0b/iTJp/0O5d9rBIY79puH3nBytnfOvSF4QV
	sf4njKvr5YtalDSev6Mp/TMUSYciwJUe7Tqt/ZyWHDMS+rNNwCNe
X-Google-Smtp-Source: AGHT+IEcMXQw8/WHDQdJxmE7WsNgC0l0q22WI6nuU2q9XsbmYSnuJG8GoAjWORpJgiqXCycmpYuQ+g==
X-Received: by 2002:a05:600c:3b91:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-4327b7ea7c6mr173442175e9.26.1730794975007;
        Tue, 05 Nov 2024 00:22:55 -0800 (PST)
Received: from egonzo ([82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8471sm215004125e9.4.2024.11.05.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 00:22:54 -0800 (PST)
Date: Tue, 5 Nov 2024 09:22:50 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH v3 00/12] staging: gpib: Patch set for gpib staging
 drivers
Message-ID: <ZynV2jm7vaI7xiMj@egonzo>
References: <20241104175014.12317-1-dpenkler@gmail.com>
 <d0c4c59f-dbaa-403f-ae39-4ee0476ed9e7@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c4c59f-dbaa-403f-ae39-4ee0476ed9e7@suswa.mountain>

On Tue, Nov 05, 2024 at 09:33:32AM +0300, Dan Carpenter wrote:
> Thank you!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter
> 
Thank you!
cheers,
-dave penkler

