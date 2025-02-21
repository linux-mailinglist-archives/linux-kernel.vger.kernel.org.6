Return-Path: <linux-kernel+bounces-525198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A9A3EC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF8617DDFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52A18D65E;
	Fri, 21 Feb 2025 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Grm+KJKX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262041EEA59
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116786; cv=none; b=tIm99C5Ip/k68Fp6fTAHvJ2f/C27e3eRtb97t0mytU0f9a68pdMfCJhOHE/Sw86+HVp8GX+XBCyWkAGXe9rGCEFG/AIyNTJxaNk5nw61YJMlN+YiwQInqzK3y5O2Nzyb/r5Adr4qKSu3hkpSbKjx5E3M/dmJx80ddAeRzqvf0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116786; c=relaxed/simple;
	bh=eTE5Qb00NNZE3F+GfObQZ4TzzZjogZ+hCA40EodSgn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaYOFpPCfjRxqBfKHn1J8xnv5Lhg6cAn4tOQZ3dgOq25G7QqxCTRW5N3r/c9qnSvBkqqXgDSGx/zW0ViFT+fA90g+A9dkGcFdCIp0OAvisb/9d9ZdZnPf1qN4zgBEw1lDgngyY0Z43GJsD5WW077m50ZoGSUnBBA+cWlRToYLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Grm+KJKX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c92c857aso30692925ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740116784; x=1740721584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouei2VTwRQWmGRLyAl+cvX6cCvzvQcBTYQL0O5+vXXw=;
        b=Grm+KJKXmYTw5Gc3Wnb3ClhiIsF5J1NJ1UPg2jGlqXnqOXIFWGCZRc/LJq3L2LTDD+
         +tU8gANpM/Kp18DpEI9Ld/9QzxC3nWbz+d65lp/x7YGidlLWCnPvBXIHtrQHgCV4ibeh
         jrriTCZpWH0+/VgcCljCr4z6h6WTApslkVBDZYFMB0VnV8tUHdAx1tp2UM5zT05KC+wg
         WuKD8Xkdgt1x/7KDWYcCdA4dBVpsE635baF510SqxQVbEElN8LZivaSBeMv0ZntPedrT
         3FW7bUE4AUHgyVr+xUgsTs6Jzp4MzyvWvrHpSdmZZT469aWlxaq9L8b4y7c6k07Yfl7E
         pxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740116784; x=1740721584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouei2VTwRQWmGRLyAl+cvX6cCvzvQcBTYQL0O5+vXXw=;
        b=tcGMSc9e1frP3bfgdejbsFSkte5mrchKOgO8shYJezT6zB47bWuQHTrNEyRJZA44Xw
         SR0YjNHBVntc0XzE9W1qj19A986UY/Q6CGToqXKCVAB+baVuQlho8DRrjyH7SDe7F7s1
         2MsO8xwm6bFX90WsQItd/d1Sg6LXLXOpOy/hfFZgosWCezPph0JXciztKCsoRaAnFqzC
         zj6+92G+nYpCYeQYAoaMkhp7iMugfJDlWgmRiaMECZ5BwZnCusDSYa/a+dC/hwG1kg/d
         aOaDNgRDmR9+GP/eu7SuG1CxxkeVrJdBTQI71w4Y4jQhww56zfJyzn/fzRpRkuOjJpTP
         eSWg==
X-Forwarded-Encrypted: i=1; AJvYcCVO6zVd2DPAo6QwGIzFWkH3C+/T0lGKp+U/FRZWUe7PBYMadqSlaM6gpNO4kO/EOAIpkfretgQ/WVjiJc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Y4PS7iQ5YdksN0YDo6N9nBlUq+/lN/fiLVP+fDOUAQAoZshN
	b7v1OVJ8IY0C4mLYLmPJG60jIR9GXjPIQpoBdFqi56PwebiRBBY7jpsR0wJGuShc84ZAOEYxVcQ
	=
X-Gm-Gg: ASbGncsoxdshL7guHJvVr9MC62XaNBXqF0QebIeV1lAZcgOgFP7RJ9D/wlPahSGp3ei
	vJW0uYTpW7KfGre1CXmYrZKYrYX/yXSaWRKyAVInVPHXkUTMAapHtayZn63a1y7pvMEqpYdWc8+
	MmRVQIaqVw/3Z89/W5CPnkVDR+eK+6gfNOsNjmafb1UAUNi0VJZ1mDnl0rd5KvX1wEJgFg3YQZ4
	4wKqIFvTzRWOxseUGqfL1J74RfT5rs9N0+gqqxlsKidA1dVVBCyWZp8XUjDlyff5CtY1VfUIbTM
	ChNmbh618d8pbZPhz+b5Vp0x3Rei6OSwUEw=
X-Google-Smtp-Source: AGHT+IEA54pL1ip8cSRNGmHkvOyN53AOFfgXrzau/VI9IcNo/aqckoQg9m/vNMh4kPIt3AOE0f4CIQ==
X-Received: by 2002:a17:903:41d2:b0:21f:ba77:c49a with SMTP id d9443c01a7336-2218c3cfaebmr93354775ad.4.1740116784400;
        Thu, 20 Feb 2025 21:46:24 -0800 (PST)
Received: from thinkpad ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-221040434d9sm97367635ad.196.2025.02.20.21.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:46:23 -0800 (PST)
Date: Fri, 21 Feb 2025 11:16:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mhi tree
Message-ID: <20250221054620.orulewump6jgzstz@thinkpad>
References: <20250221161344.09a6cf09@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221161344.09a6cf09@canb.auug.org.au>

On Fri, Feb 21, 2025 at 04:13:44PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the char-misc.current tree as a different
> commit (but the same patch):
> 
>   0f96e4d32983 ("bus: mhi: host: pci_generic: Use pci_try_reset_function() to avoid deadlock")
> 
> This is commit
> 
>   a321d163de3d ("bus: mhi: host: pci_generic: Use pci_try_reset_function() to avoid deadlock")
> 
> in the char-misc.current tree.
> 

Dropped the commit from mhi-next now!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

