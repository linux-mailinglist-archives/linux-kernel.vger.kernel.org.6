Return-Path: <linux-kernel+bounces-439163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1439EABC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B95168CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D8231C97;
	Tue, 10 Dec 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TH2IE2kT"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B513A41F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822298; cv=none; b=BpgQGk6aDAKu7ignaCDv9ytzmlKu8DEZBjGpHpfdoVr09bj5XO9UmY4fB3CcvLfzwdVNhKMrkv5q+oqVNWZ42b3MLojecULg/4W4z/me4oJTcNZdHcMRmMePTHQRcJNDu6JNCpwThb7aBUIJTTqzQt38ckRJS71RyjRucQf9Nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822298; c=relaxed/simple;
	bh=omI4H5wEH8JLhRjGKGKPftUxFGeyKl21rA8XVcXsT0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTDczj1AIxugxBioZenQk8kIZba2Yg1kS+CEOugLPetXmzY75j4X4DvsVU6ep0MG1XMR06QiwcuZF4xXAhrUMDJfBdIwTVGJhOxt39A6gfRJ9AU00uNDjjqgm/VH0ekR984MOrhYC7dPpUyaeBXSh/Mqx5hntPuABdlqDrQSvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TH2IE2kT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f3d934fcso14012115e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733822295; x=1734427095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5TYm2lhOjGpM9NhFrWhlK4D413vHYrOoe381gQTxjI=;
        b=TH2IE2kT6sebE/0jSvj43+KaXeTWtdwQhzBuicR0II+TZru6ddlEDwGCwKywhjLNI6
         yC/f478J8hKEESXp7bpySMqCJk++iIfbjfaMtUeE2gyU4RHJPCRiKXnHvsqDKjO2QwAD
         +8x5HSZToyvAlDI7qs4w51KcGTQOHwjSKrMwyf66q1WZcF41yOT3PJYTGjM6+EcOL4/G
         WKksOu2iUXIgM+NiJG6mKCE7axkTz+wWQCIDXJ0W6HlI5EYJNio5j8xrz5Z9P+pr0u2i
         3FIGy7N+VsHpaGryyx0/OVrWAq8EsaGBCw0cMS7dpM4K9N6w43hl4KB1jld+zTtIWV1f
         xjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822295; x=1734427095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5TYm2lhOjGpM9NhFrWhlK4D413vHYrOoe381gQTxjI=;
        b=sFeKAB/s4C+wrdxSjp+0MBMLz2QU26sYpUeoZMEPwtEh1l4KXm9Kki+l5TmzVsR86y
         3ttgdCOUGbIAopJLjvgzvbuwM0qOia64nHBCMM/28QNU6fxFqRImBX+5yYp7e0QnnvJm
         J3xHeTavF2HYXRbcEfHptrjRHuU0d6HGXbMCqhqEx0C2Kl6zHVDx50cZxTocszEiaQMY
         kvuQdA1NvyaKponQCaiFtnojRIfWbF2E2V9RKENQkig3Ophb4JDVKm/EAtyivs+pgWGc
         n9vEzzcMxQ1Gv8HZ9/jiTk/F51Aj7HoByW+Q5EpcBDudKkhnas4ehP6Lvc56KIu877RQ
         lbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWThwUVbZqvN2hf7irI3SBoDfRlhR4EoguOSR53fa6PTVcsQ46rZ+zODFQEal8kDSKSx96zC7ZjCYUJ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJapwAtYHuGfwhXmXH+LBDBkBPHHU1BKp+++HDbZ+ejmDJYcN
	6OMOlYFjOFbCu8mSh1O5sSVmLuZaFciKI7dVK3jWQ06/HJ4L2HLN3xVshbYys6gWdXhf8sDpS6D
	9
X-Gm-Gg: ASbGncvOoBZy3DI0qcwyjJbR7H9JfoUD8qfH7TL0BjjG5wWoN6QsURBuMEDrEDTKbtj
	WvIyYIKwEFaDuVujzSvJmyTE4l8lgFsO2CnXcqBrk5y8VUe7gQx1Mld8O9Zu366kDWoIkQFm8xs
	nofeAVRiewQ39EP2EOyqxdF0oDLTQGyMXdP96f2DV58X0CuG1dQ+J6DiBzIFDevccccwlJq8SZh
	Jz/AuGjad5CilK93O5Q4N0AmyZu12k3NXSL8afdK8FnvSPlk5+pPLacHmc=
X-Google-Smtp-Source: AGHT+IFjWDG/W2QUiJNWkvXL0j3HEL2mML/EEgKgjQFUReAFpFCpCXM9Ksl+aVXTWX9RQ6O6ancsng==
X-Received: by 2002:a05:6000:1acf:b0:385:f409:b42 with SMTP id ffacd0b85a97d-386453fe4d2mr2869941f8f.53.1733822294723;
        Tue, 10 Dec 2024 01:18:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm15221326f8f.27.2024.12.10.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:18:14 -0800 (PST)
Date: Tue, 10 Dec 2024 12:18:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Atul Gupta <atul.gupta@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Casey Leedom <leedom@chelsio.com>,
	Michael Werner <werner@chelsio.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxgb4: prevent potential integer overflow on 32bit
Message-ID: <65603cba-eeaa-41ef-8d62-3453f3d19c7b@stanley.mountain>
References: <86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain>
 <20241209185556.GA2367494@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185556.GA2367494@nvidia.com>

On Mon, Dec 09, 2024 at 02:55:56PM -0400, Jason Gunthorpe wrote:
> On Sat, Nov 30, 2024 at 01:01:37PM +0300, Dan Carpenter wrote:
> > The "gl->tot_len" variable is controlled by the user.  It comes from
> > process_responses().  On 32bit systems, the "gl->tot_len +
> > sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
> > could have an integer wrapping bug.  Use size_add() to prevent this.
> > 
> > Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This is from static analysis.  I've spent some time reviewing this code
> > but I might be wrong.
> 
> Applied to for-next
> 
> I fixed the Fixes line:
> 
>     Fixes: 1cab775c3e75 ("RDMA/cxgb4: Fix LE hash collision bug for passive open connection")

Aw crud.  There are two implementations of copy_gl_to_skb_pkt() and I
only patched one.  It's pretty weird how I mixed up the Fixes tags.
Anyway, I'll patch drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
as well.

regards,
dan carpenter


