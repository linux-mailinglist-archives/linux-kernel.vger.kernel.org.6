Return-Path: <linux-kernel+bounces-535945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB939A479A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDBF1889533
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A2229B01;
	Thu, 27 Feb 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aD/y+JHs"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AA225A34
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650286; cv=none; b=dkbAfFpGk+eLgOYsByC7T3STKcBqf4GNonMb+B1I3BHiwjUEkSu/x12Y/roXW2K1pxEI4AiiSy4m03fV5AQ2iBY4h2ZmH3sWA/ReOExWLEVeAq4dsnsnE5EtHJN75MqqKt+TCVbn+5s0PoLFbpauAXIQzSnPy3QDJ3TenoV9mwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650286; c=relaxed/simple;
	bh=Ge9fC7VXeXg5eotJVyxxvzY/sVzVFFuENY6NvoL9RQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9fX5EE5GyoAdXsyuecbua2V9tr3a9aFY8km4TqDeDJpQOFlsJEh+s2iVejvysknBtFp70zOW9rBZtnR5dQHkBTeJKdq7bDy7eTKqbTKYFV4lC0z9ex5iHmophCxWdIKYmc+oJiaijaNGcLPCK1RedRpxN5kO9K4xwJvuXiwhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aD/y+JHs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390cf7458f5so661111f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740650283; x=1741255083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luyiuzmIQ5J/UP1GJ3bUu38sxNpe1CL8R9HpytNsO4A=;
        b=aD/y+JHszvXIiJEDTAyEKVx0eJc5jY8kpVmSx3dgLfD/s7TVozmasXOB3wQh6OhDFl
         SkIDkAgBd2x9gNi/RgXd15USWU4oK/5SNSrSQ+VxrwTfYFI7FnEGYgHywmJSKE+HLP1D
         alvuFN+6N7445PvFRLkJc/4rgV7iVFi19WLlV0Kcf2YImWVrRZvZDH4CTftPtjJ/fYAP
         xoetbqfb86N/AIlJ+DNCJl1Iuo9r70IwEOixAro2AA5QEdIxcAXlBkIDCOMiJnIKSxCa
         gBQQpEm+cCkMA4dY6jEEK1AnNdkGXEE47UGgNGdvyE4bl91vZfoRZP8wc/pZUfNf+Tel
         FIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650283; x=1741255083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luyiuzmIQ5J/UP1GJ3bUu38sxNpe1CL8R9HpytNsO4A=;
        b=eXJrz1MBUThSpD+TevOrUvIp4Z9Lyj51SLx7b3AWHd+PThcmO6BUDpk0aQiN/2WppK
         o3DT95X/XZeRMTUqNaztBdjvdY+hQqyaBDgcX7xkXq7r/56md72FrUIEXIoHeVZKq6g/
         49PNQGGoueD0Ri0xh2UGfzmfH3XEg41Dr7SFUOetpkefCHPSu9r8tIIRBNy+0+Tt/o2v
         UrqgPoSYdLU/FmDpbGvnSzzxjj7VNW89AJS+41snkdKHzsqg7rQu3kKB+ylPqy/hJzri
         XbfCcuGqVAuZYO6z7Epv8h/n7ixYQIQLt0hlqO8pQSM+ZnDNlyQzXE8UbXaWtWqsY7Ta
         uaJg==
X-Forwarded-Encrypted: i=1; AJvYcCXSNZdDNl4JCK5incubxOsg0JtCylxI3nRLRi1yLIkkggBl30hcRK8jBHfSGMA18eFmt+NHSTyf+w1lGw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWSBN+fqMnnfz5UeqQCQs/cL7DqUPmGo88zbjwIJ8VNqRV8D3
	i1X72Yz6mOjcLFKxraD6xqLNDWN+0TsP7hbydhQqHdiUJaz0vcbPXvd6/0RK6xA=
X-Gm-Gg: ASbGncsjrDT+hWdlyWgfSDfhD5eZiZz8F0iIpkHZX5a44/2mFODS2Y7TNv8ectoXFAs
	hLRUbrX48onL3cuNdLfxQQYXhvWVOa08LeqlDOtQwtDFnaBbNjMbNS14KPtIJmq+II2ES1ZIlnQ
	XqRVd4cjgm+U4CglXlB1t4DqQqCNKX/VkFK2Jaa9mIVTVjcyXVc7uP1MqrtrXUw3Y/08FkNTYky
	HksTmyVSiY6+l8hQkW0T9ZYhrmbeU7ZplMAMA4iIB9Vqtg7lxDE8fot4hthrpLbBIriFnLfimSv
	VVXfXXwOVmSOtHMsm3/J4Knhbjrnvqk=
X-Google-Smtp-Source: AGHT+IFKHbXxbAc2/iGdRn9hXwR8RAtENLAY1c57Ue5l0MtullYL2bqOmgHNPsi1xz1ARqmNqCIOxw==
X-Received: by 2002:a05:6000:18ad:b0:38f:32ab:d4f4 with SMTP id ffacd0b85a97d-390cc5f58admr10673661f8f.4.1740650282838;
        Thu, 27 Feb 2025 01:58:02 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c6ee70fsm95121066b.116.2025.02.27.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:58:02 -0800 (PST)
Date: Thu, 27 Feb 2025 12:57:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scripts/sorttable: Fix resource leak on file
 pointer fp
Message-ID: <a7857c72-89ec-406b-8d66-d9e95657a6e0@stanley.mountain>
References: <20250226224934.594983-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226224934.594983-1-colin.i.king@gmail.com>

On Wed, Feb 26, 2025 at 10:49:34PM +0000, Colin Ian King wrote:
> There is a resource leak on fp on an error return path in function
> parse_symbols that causes a resource leak. Fix this by adding in
> the missing fclose.
> 
> Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

This is in scripts/ so it doesn't really matter.  We're going to exit
and release everything immediately either way.

regards,
dan carpenter


