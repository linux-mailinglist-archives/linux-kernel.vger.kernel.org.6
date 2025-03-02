Return-Path: <linux-kernel+bounces-540661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A0A4B372
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D7716F384
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE61EB195;
	Sun,  2 Mar 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSp4iSTQ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC41E98F4;
	Sun,  2 Mar 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933321; cv=none; b=IhcdDfNsqjoDqM7C2WVAhiYN9gKZxzWGBECi9cL3GTETOCPYgpg1wRLfRV7Ny7RWrQCkcugdmRGbW60++tabp9jHM6fsdBXX8xjdA7eu0b0/q8BIHNfZQ2HyQmY38MIFUTA/ZLHz224+nWm2SPVEHYjUe67ojmugjit9L0aDcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933321; c=relaxed/simple;
	bh=L5YDP777lXDS7043ebd8KiLqrAwpAn4X/TLqrT1de9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7KgvcVNGHG7yFYnniFciLeNSP5jGEahIyMoNTMHzuNSuhOxFgJV87xLGLngfv9Sxgu+rZWVhVsXNpoZunuLKzS35xE24rGVp2LlFmkcfYkosdaHvdDfbWhr5pHurr0n96dyPsteJa3+QhR1W3sIM3WslU4E8fSXI45Qsu5yUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSp4iSTQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso6106151a91.1;
        Sun, 02 Mar 2025 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740933319; x=1741538119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYxTwQUP5klffG0amPd/Tb12A9um4AUq9vE7TamJHgo=;
        b=TSp4iSTQP1ohRIE8FbEdBQdtbe42NiSR6RHJzCrDBenW2b8XhSpXZeN8yPqwxH49H4
         fThvUMms8OVmwTi2uvVPkZJIF356onI79jMtVmg9qSypqpVaV0WbVm0SdLZOtvpiJVu2
         YhuNLSx6SRFCuq0T+RlTJgjLnmkan0YUtkU4Fnr6Q7zl+spZ+s/0zVQF8d/5Az5G5n37
         +sHbQMWOpiinVtSjhliEXg6ilcOqetaMxRDz8zPKCM/GJVHK47hzkp7KhYSufVvpaL+1
         Wmw7EC6nqk6AVPy2YJ8VuUUOzfV7KygH5RPbY5W5SCFecNnzkyzYvoyKhEUYN4T6rcfy
         51wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740933319; x=1741538119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYxTwQUP5klffG0amPd/Tb12A9um4AUq9vE7TamJHgo=;
        b=uUEXzzaJQvbRnaAKLPT6+pmfyZ4KwkRLoZbz42ygRqVkroKpkp37GvH1+XjbDMFjDl
         t4LY8IkrFQvhc6QGdzanzrLBwAjhYIy0N4+DL/sVDxhUW4fY+6uS3FDU+HlLlv+mdM1l
         yMwCKza9uMiRE8CI7OWTq9zXNMCg4nscRqqq2NfGhRUz7egwSYOOTznjKMqSpGbJWAHQ
         qqzbyO6vDzvbcYPgDKkXuHC6+zwpGddwKI8YozZIkmKkRh1movFfGa3Ghx1LckM7nQPO
         JJ7+vvf8FpS9qU5rMHZoH/k85ki8D5NSgIKgZhTnbwjGPI+LxI2BocuU+6mNS3Rr6Od5
         68FA==
X-Forwarded-Encrypted: i=1; AJvYcCVLD3SVd3cpTTRkO0dg5gE/22UlYnQGGVygVI6x4lKqf/WfwgmlFkGFqO1qYcHqoA2SHvNkNqvvpkcgRvmP@vger.kernel.org, AJvYcCVhJyTYMPYUyV4htUOOsFjmOPfKcKrF7tXEsVZzh+YwZyaYpYFpZaQDDEchoZpqxUMiTn2EBeGgzBBUqWg=@vger.kernel.org, AJvYcCWACUE9lSqjvaR0yNKm2cSuXuIhbDa7Vqy8/4ZSluCEX0HQ1Yz70Vluz7yt9ZAGS6WTUi/sMpS59Pf+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+TDI4oWaqm6BpxuFNMUDN/PHmhUmt7KTM0ztFf5T78ol2nY+
	NdP1mikCBmBI+IvdkCYnVbZlehlfbw9zkg43QAK6FrBg3WPnSQdt
X-Gm-Gg: ASbGncuIgdI8Qd5q43cf5vgsrV8fMOXSXh80ofiDYYff6Arl7N/4Pjt2+l+UTH9VV11
	Gii+gsReNhO08fVApWVE0tTj3cvYAjDAoceyeb7F57XO8pOJpg9GjJk83vzjbG8IR8Rtc0Jaae5
	bZxawOg7QCjrL7LirrUpddtu7qXr1yuvNEl/17zIugR8d+/LaV+ZKDlvpH3ytSFBQNBKobgXLOA
	QVqv5AJlZbUPpNJVBQKTBe50CmNdmuSxaDI75g1NunzUJ/fLmswMR6psccL7WmLIBo6/gChGi9y
	K6zGy88Zw2Nl87ugMhVxJAi/3ucfcHY66ebswHMGnrUA5sxZEVa14gv+eg==
X-Google-Smtp-Source: AGHT+IHja91W0EyanYeRx+xqsqa25zi0SvEJNEn3rdg6XU4bXHmYVqrKe00p9FaGbmf0MBpTeDgLVA==
X-Received: by 2002:a17:90b:1b08:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-2febab3e2demr16976087a91.8.1740933319487;
        Sun, 02 Mar 2025 08:35:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c59basm63137015ad.125.2025.03.02.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:35:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:35:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: maudspierings@gocontroll.com
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joseph McNally <jmcna06@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor
 table
Message-ID: <e7bca709-dc91-4514-9407-bef1438a6d84@roeck-us.net>
References: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
 <20250227-ntc_thermistor_fixes-v1-3-70fa73200b52@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-ntc_thermistor_fixes-v1-3-70fa73200b52@gocontroll.com>

On Thu, Feb 27, 2025 at 01:57:53PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> I could not find a single table that has the values currently present in
> the table, change it to the actual values that can be found in [1]/[2]
> and [3] (page 15 column 2)
> 
> [1]: https://www.murata.com/products/productdetail?partno=NCP15XH103F03RC
> [2]: https://www.murata.com/products/productdata/8796836626462/NTHCG83.txt?1437969843000
> [3]: https://nl.mouser.com/datasheet/2/281/r44e-522712.pdf
> 
> Fixes: 54ce3a0d8011 ("hwmon: (ntc_thermistor) Add support for ncpXXxh103")
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

Applied.

Thanks,
Guenter

