Return-Path: <linux-kernel+bounces-537246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE043A48998
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56853B72CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6C26E95D;
	Thu, 27 Feb 2025 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYDrdXhw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9141BEF7D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687350; cv=none; b=E5mOcnE4bZyRtftrN9MziPo92S3D9tNwed+Rn+4kcdv58MhAKOLhGqOEqmODUNYFwIYhZUohYR3QY6Gl+PoUJQuvyDlupgRiGKHQavr1zV52HloEbczlrxM7HXG61NoDSTjkiPTwMZuVMxh/aaRaqOW0OP5D0iRLPerip11XgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687350; c=relaxed/simple;
	bh=+XWik2wC1ffv2ovjVvxk5rjvVyKAKeQWJsIjHTOse/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyucqB05ssp3CKbKPHJy01aEqhdstSDMNJMJlk4yO4jreOJMwtVdM6nKNd8CmD5azt6MehdxznoW8kcBhRU5FDx5fDvcSUZJMwLEvE1GbCBlwKOgZbcmEUPL8j/bMMlT7yFJiUzpSJQs3EVmnEHgpT/vEANUe7uoabcJHETk/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYDrdXhw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abec925a135so181894866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740687346; x=1741292146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jo/OqPqJ4zSpDM0RDYOakC9S8mm3ipT209j6FvCsm0=;
        b=pYDrdXhwqXIU8Alrfsj6kOhr82EW00Yj4UDXWrRssABoW0DloZOHUVfDD0dJArCAYd
         AQKSLCDSEKHohG29S8X+UUqM/SFLavcs09hOfTYq/EeJ8usB9MYTx+RNxj4gVDoGLsK/
         m/mVQTjFFBQsPKr+OiLDwHtjx/YGbkwQIBJ16CRkWl9pAIAL+VIBMOSUumnIt+DlLQR1
         Q5Ik2gArh2Nbw5PX/u3SiUpFDuOl7uIdltoLhOPcM7XEUUoxqC4R5kGF167mo0IWRxfX
         Iyc1ofnIML2wbDFay9AT9jRUd2mwn/NDWXzVPDN4Enbb2aXtPdvb4jPqdlnfplpvlOXh
         oNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687346; x=1741292146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Jo/OqPqJ4zSpDM0RDYOakC9S8mm3ipT209j6FvCsm0=;
        b=UwuYWP0H2rQ4Vt9DmYrE4F3tNHYtiFMIcpMLaf2nZutFMB2Ek0udZXvvPHQT0H4bsB
         QDYEKXBPbDfln05YUVi2a62r1uw3PTmIseEfQy2zvA+9qy7AvelrLU5xpeHUizdlczo6
         yO4lLIcL4Ag0rw9PxvByiu4ovp4fE8FFgJC+65kFkp/3/QQGPQf/PuLmT1Zy5bXWKteQ
         fWSt1AJQ7XTkNPaMZmMZvPcEKc29see8lFG0aewA/HIYQ6lsu2ZOzqcoyhaWBdCcfdiT
         W31Uoh23nQwo15mpz9YKmuj+b6q+L50Urb0/pz6QrVOpiZPBTY9iy+QmAj0M7SgzQglN
         rAxA==
X-Forwarded-Encrypted: i=1; AJvYcCXO9itZbyZyU4xutGSAbRBA3QRSmvQSpHtM+M/FjF6GOTemS3hl20z4/1K0PZmb0tWuhUcA/20TOX+E9II=@vger.kernel.org
X-Gm-Message-State: AOJu0YykWFJ83HFkMDxc6PugyO1xN6vCOdeJsLZuZLnglyjpnHWv+Q5u
	/ci7SpAsDZyEdR2qVUk+SAkwqcJIYFRDBXAbvoz9XDyvBB10zAuCph3HaspbU24=
X-Gm-Gg: ASbGncviZQWHjUgCKJs2gfeDjp8Ds6mZpOkQBi7rbFM4SDFB7YBx4A4mk7jzOXxNr64
	RwnmtcJG3KXsduFqETUx13kh4SlcQvX9QE0WY8SLoDTH7ugq0zFsR5O7XExsvEdW9rCjj8Sj712
	w+ExO/yIV8Dcqd8QP9N1GUGOyA3ArAqrMQn1CLZALZICdvqbSau5ph/8FZXHgJEF7IWUXnu0Uhq
	oIKHLHfsVCdK8nc35zR1QMix1vaYv+W7cl8cEZHVxcpRdoQzLTYvIgBI5LEwc+6Trs/fUVbsC7E
	mZpvrH7ljRkdCbcc5ebFwr/LRptv1i4=
X-Google-Smtp-Source: AGHT+IHEAa1ZZ8N7si4N7Iok01NnKREzA8Tp47LFBm6mrX2/YZngu4ctMzki6E6aFIm+hAJtSsGbmA==
X-Received: by 2002:a17:906:7310:b0:ab7:bb93:56ef with SMTP id a640c23a62f3a-abf25fa9fb3mr79625166b.19.1740687346341;
        Thu, 27 Feb 2025 12:15:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c755bb3sm173114566b.139.2025.02.27.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:15:46 -0800 (PST)
Date: Thu, 27 Feb 2025 23:15:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Fix bcdUSB initialization
Message-ID: <a8659c74-ec76-456d-962f-1690581da162@stanley.mountain>
References: <20250227193400.109593-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227193400.109593-1-abhishektamboli9@gmail.com>

On Fri, Feb 28, 2025 at 01:04:00AM +0530, Abhishek Tamboli wrote:
> Initialize bcdUSB to 0 to prevent undefined behaviour
> if accessed without being explicitly set.
> 
> Fix the following smatch error:
> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc()
> error: uninitialized symbol 'bcdUSB'
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---

The concern here would be that xhci->num_port_caps is <= 0.  That's
probably not possible so it's likely a false positive.

regards,
dan carpenter

