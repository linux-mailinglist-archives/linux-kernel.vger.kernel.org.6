Return-Path: <linux-kernel+bounces-326566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B0976A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5486B1C20DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B221AAE06;
	Thu, 12 Sep 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CKxcCSwR"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232F1A4E7A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146723; cv=none; b=stZcxY+bN0ntNkalNiRXGjLL2sHwHvvvqH7G220N1wp02sbNcOd/R0GD10d9psdUBSwQJ9OXO2sJDvlLE2MjeIWxotnSRxcLf7+yoYo5S68vUP3iC483JRJ1KTJbCY78tTWqKIox5b/ltulLquvSbnfQhUzQ2G7OsWxOZTCsmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146723; c=relaxed/simple;
	bh=RaydOSJFL3Q9Fw7f0XuBKFvCOwlO2D1b/uIs9scmK6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxMcDOiecBre4+s7RjEZ2jiTBcmBrJ2Mxit2J2VtbX9rR6GJ5KlW/goSrVEIDx4FVmEx+dOZd8GDXa5+0Dh742ZHrPrLWRYqXh8FWQ0J44nhs/IqMP3K50nG/Rag3WtimZejvCrbzZgDyEupUK2KmdNahhi3jWVeTpWRxtAPkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CKxcCSwR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ab8e5f96so72119885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726146721; x=1726751521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBD1supAppfnGRodOiWLEHyXSpQurWFz61I765SalUk=;
        b=CKxcCSwRlcQuIVHcElXMPyQ2gIgVj1QyFGTHHrqdZoIDWjvjlEuUaCEFecmFI5xqLi
         ZXze9mK1O0RsHTpXK2sKunz0ziAKPEJoCiD0nw+FjO05EAm+w0IrlDOUBQQNnIj88EcI
         ejLLCP03LYePKuOR0X4dYZ8NmlDF9hg00iBDJHqUP8MCMN0bENu5Rh//ott/e7iQI1GU
         fZPy5d7r7ZstUEhS6V+CKWWCs3DobzW5L0ovZs+pMzXft4h3ZYl8B84hFPEvzfUH8z95
         tUfonciUhStqheDdIT1jIpzCIX5G8CubuwTOXaTLMlffuZ8g93N2P30vw3Ess1siIwba
         3gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726146721; x=1726751521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBD1supAppfnGRodOiWLEHyXSpQurWFz61I765SalUk=;
        b=KwN+5SPTv14OqzJwDKHPoQsVE1l64/TRn6dPxqOWeXX5ENgKJ+9z1M66+ZKDQn3CiR
         NTqhiSigrguYXrljzvzRcZ5ajGK6rr2900YwmNLG8D58wjct8IkMXFHb+IekbGi2/FSd
         6UlrGmmv3ykaBgWZ5/oDt6b1NesuauPv4N+zvuuLTJ70hmk/8G6rY/qyKsNPnwY9wzFX
         F4/scUN8vlRhu9PAc8idDJ9pekYnf4Wusg542A8tx3VR26p5XgxUqrcnNqeS4Qej159w
         nzEhfp1dungJInE39nkjVdkj/o5DSPuHsx7Fn874wAR6CghYdr94/OYroZztUSNkYESM
         i28w==
X-Forwarded-Encrypted: i=1; AJvYcCWIAWXZKoy+lAu/Rx2jzB0kDnSo3MRS/iCr6wqjcnU//wVwqpSbF1OXBD4TetDx9pVp3I3ybqX9ZRta+qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNBGuJDHbXz2B1e3iWeI3s43EMRhzirgKJtX+OmlVKP+2xx0V
	cNenYFPlJwi+68QRUnnJ1MeqFDVGpRr38/nqvzwOAfSFyY0JsB0riBhTUziSFHk=
X-Google-Smtp-Source: AGHT+IG9WyRXWSNrKA444XIFeHToPFPIZbf+sv4Odz1gHEboQOTlEfHF2PRWRKXrNZsoGdWZluUUWQ==
X-Received: by 2002:a05:620a:2a01:b0:79f:1cf:551e with SMTP id af79cd13be357-7a9e5ee5707mr318668085a.5.1726146720738;
        Thu, 12 Sep 2024 06:12:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a283adsm533918285a.129.2024.09.12.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:12:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sojc7-00CzIH-H0;
	Thu, 12 Sep 2024 10:11:59 -0300
Date: Thu, 12 Sep 2024 10:11:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>, Ankit Agrawal <ankita@nvidia.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: clean up a type in
 vfio_pci_ioctl_pci_hot_reset_groups()
Message-ID: <20240912131159.GC1304783@ziepe.ca>
References: <262ada03-d848-4369-9c37-81edeeed2da2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262ada03-d848-4369-9c37-81edeeed2da2@stanley.mountain>

On Thu, Sep 12, 2024 at 11:49:10AM +0300, Dan Carpenter wrote:
> The "array_count" value comes from the copy_from_user() in
> vfio_pci_ioctl_pci_hot_reset().  If the user passes a value larger than
> INT_MAX then we'll pass a negative value to kcalloc() which triggers an
> allocation failure and a stack trace.
> 
> It's better to make the type unsigned so that if (array_count > count)
> returns -EINVAL instead.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

