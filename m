Return-Path: <linux-kernel+bounces-289804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8D8954BED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9D81C242A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B681BD016;
	Fri, 16 Aug 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNVnWYJx"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7F1BD4F4;
	Fri, 16 Aug 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817232; cv=none; b=pkS9AJGoL1s6/2P+zcgFIqbFj/rw44ksdrXGW2KiFCRjeTTaXRRecosLqCzvLYqBrdZXKZ4GmZsF+y6Mow3kse9AGpR/Qq04nAOQ5wVfYoZjDNy3S6SGJu+hfp0eiP0WfihA5ISHIv8fhLFa3Mak8JAFXYImxzoqCAtq7lQ3ALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817232; c=relaxed/simple;
	bh=lavjni/R6zo7kSEum2p7tjt4+ZfZq0En81bPlbLQDG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSVFXU2UeYgNKRPeI9lZsfjHx9EtiY4KZjrwWIMlNncKE/fimw+b9O07lTRzCo7ouQFXJM6QJkINlaYRU2vBeqRy3gk9gBchQSjZrW7X421pIi64qaKKj8MN+PM07e3L1Q78c2L3FowVNfRLpEOR9T9poVK9hBxsMN2CxPsVQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNVnWYJx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso1643021b3a.1;
        Fri, 16 Aug 2024 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723817230; x=1724422030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytMYhzF2r+ZfWYOrCSEGdROperK0RmUy3S9YImHNj0g=;
        b=DNVnWYJx743NMHtbKDXjL2d8obItAy9OF2JPl2/pB4zWUGBC8sG9QT4CS8rYhj9Kvp
         KEcdaIjODMfp+JtosoZZAHILjS/ykes3DeihnJhXriY99/+4TOh7N3Z0AP/6ZxbJHl2g
         lzzD1Q+gcCEg1jBwnYJ52KL7o3wQxa+2uJBUdgnaHujKTvZuPpfK7HcVHFWU/s4WwzCE
         J3xY9LEINDPL5pi6IDBI6UC8La4hUeJd3dEnVCnJqCaSIlPxa9T7qgtJavVFzeCU203k
         jkC++ECsjcRQStpW9CaO3+RiR2KnMcfe8Cj/HN1a/drU2XOTNBnw+A4p0uKmtxC9qgyy
         DG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817230; x=1724422030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytMYhzF2r+ZfWYOrCSEGdROperK0RmUy3S9YImHNj0g=;
        b=RL+Ow2MBpPxKU0QhnrZLTuCSmevLfe1zyAKMAEPiuIts6/1OdeD6tYUQ2xPtI63WkG
         Ncxjq5/zd5qT0Nm2EIr6vF8KR4qzjRkzgrDj1EmtnLkioEU5n01ODFrjXwLdkpZil0Y1
         llfs20H9k6Q+YKDIyL8aCi1SOX9OzNNxmDbE7K3aI+pAt3Sdss487HfwzOra0TyVauyV
         R8KO/9VZsafvFL7DdI7nVQ2aSu0yS/YnEJ6/RhNLJj7bYe0A4nfl9FKrgx4HbzDOQMcC
         b5OgIF4nKVE9ssZSmtaiEo7PL8MkTT4ZzBGuDp8tRyYMkDTluONVLS4FHF6J0UBCK52u
         XA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT+zvGTzKauyp08ndiItHZSbaRNlAyrnRUh+mCzcZVUcApgH8wL2GL87WVH1z6hnjgPPmSjJMmfvlIK6bw3uBgb3BWWy8dQ39mR3AMmkh8lFcXr3f1TUwhwN3aojtrXC4+3OJpCyWvY0c=
X-Gm-Message-State: AOJu0YxkSLWJEvXsZPq/KYn2sw0rFEchS/2mXGY1CFgDzfgeuJPJfRjn
	EL7onSOdyTKduGf64HlzwUoet2GdBDip4DhM0VOZ4QQeksCNg8YG
X-Google-Smtp-Source: AGHT+IHNNz6Xpf0SmlblE0tVkI6GMJNE9IiLSmkDJPQWv5OqIDeMKHJGipo0caI2k34AOpiCQa5lsw==
X-Received: by 2002:a05:6a20:438e:b0:1c4:214c:d885 with SMTP id adf61e73a8af0-1c905027f06mr3617080637.36.1723817229971;
        Fri, 16 Aug 2024 07:07:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e8cfsm2659887b3a.80.2024.08.16.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:07:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 16 Aug 2024 07:07:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jdelvare@suse.com, W_Armin@gmx.de, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] hwmon: (sch5627) Remove unused declaration
 sch56xx_watchdog_unregister()
Message-ID: <c55a0c8e-d81c-4d71-8d88-8e64d1e8759b@roeck-us.net>
References: <20240816095740.877729-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816095740.877729-1-yuehaibing@huawei.com>

On Fri, Aug 16, 2024 at 05:57:40PM +0800, Yue Haibing wrote:
> Commit 2be5f0d75325 ("hwmon: (sch56xx) Use devres functions for watchdog")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Applied.

Thanks,
Guenter

