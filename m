Return-Path: <linux-kernel+bounces-571292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F69A6BB6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECED7A4305
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1932D1F8F09;
	Fri, 21 Mar 2025 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvBHStLz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913B21A43C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562416; cv=none; b=J74I1goab8+p7tp5dU2qCDGpzSqv/05xhFh28IHlfi4y1NwmwuBzYV6NPKgMaGfqieRkn/wYnJERVMl9xGLjfrIYUG/yeKnokj5QOk7FQsyYZapXOOLogey8pUdrQsyAr5U2dCl4lAqsvi8AHfHzbRt6DVLJ8bL1qJRurU8+QII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562416; c=relaxed/simple;
	bh=N961mCDJ0wLdSjt3jDEsJ0osU/dLY7z6XBOnf3+WqMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOE496rNRuyPYl4iPHb9gSFII9MMP5WqVFVc+jn0LaVwicg0SpVTda6gB/1i2mpf39aQFKwtE/n3XTgWtyWuE+vO7I2mzOUU59LCj3ZKr25GgZnajSLH3nhoBDKRh2hu11pyE9VwJDzjvvawD8uauh2+12YgngFfrWb8bab83t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvBHStLz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225b5448519so36677175ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742562414; x=1743167214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZz5tqMQorycUyLjU9gel+R49TVR6ql3QYksmVM9sAM=;
        b=rvBHStLzZk4EqiN63IMH54BsxulK/M5o1nJXRdFxoezzXTeJ8Sb3+9N4IHvKK9TBad
         xHkY8eIOLIKr1huYMMMEKRVexGMKWe5XI/ClQhww64PQoBlu8pzS1+j3DdyTZfHyEGAx
         I0TI1VtYOhuOPITsL9SUnlFHomBtHkmQaBGckGQmLss8jOnbFk2RxkzZZbFK2UQj2IF3
         YKqNq8KzywVhj3jy2M9uV/bmlF4NhhTpKOMSxYIxzuwH+9auT/RBw0A6h7d1PcdktVrN
         bUdk4aK3oPld5FSsP6y1tu9OT1EV+oEaHrzjRvBts/HVRl4fmiQjPuuXHfdtUUPRNGQv
         P2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562414; x=1743167214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZz5tqMQorycUyLjU9gel+R49TVR6ql3QYksmVM9sAM=;
        b=FVI71wZ7kSHiHb3Q6/GYh9s4FmAQnVFSACwMNDt+btry0HlUzEVXmOUSHQpjhJm4EX
         h5zWFHu8JzjH7LdqF8iNX/74TcaMsGNP+j7XI94SEN5yaql5byI1BEg1KUK3SaUcpAD7
         mQwXLuS/6Xtau4O34aIbIQ7NW01EPjO8lKUC6D9PHD9hdutJuZPiiS3UfE3mneqkv910
         xJkcgN2OwEgqU+6wkJVlsohc/h9saBtRKU/u5s0SB+QStO+nQKQJRlPS9r092oKjstAi
         oM7ttL64ze+Xw19GDc2gHClGT89VZkMHk+23pQDCOu+YGGWN+a2TZLW8AlijoOr1qt57
         OEdg==
X-Forwarded-Encrypted: i=1; AJvYcCXZW7snAcxa3uwJxmAjoNJPWxbkHtYtLSC8aKa653HSiTjEIN6EqK8jdqgW9rghzxOzBYrnA49+ER774nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEZ6DPYThlSZBYeWXDuvy1acYLYgnfhDzk4VI64LNssy9V++I
	lMj6DF+DULmRFsUhMpIxto3NLs6liNkhl0YY66JpIlYd41fl6KlET0uNxfcNzw==
X-Gm-Gg: ASbGncu6DfkhAsLQDmIgbUp5CoaogLcjZ1WiO4B7nx5g88RFAXDpLO7ksG81LFEGIFc
	iXNIZ8cN61zD0T2zJDTHBzX7dWBsb+GkMoP7zAyvcCJPWrcXtGRTPB5cvNqG6P2/lkEe2T4+Oxt
	PPHTMQbCe3yhdZGJZUVXk1yseggBqB1rjB9qLzm/lleWyUiY0y8+nGFuK/m6sYjvfYsYypGqBvW
	Yqh3QChNT77ONzTU1ViiMAxNW2YOHcIiq2/vxuS/iUru2cfA1WCwdCvIOOOC5ZxSIrKlnHxEcVG
	9GtKv1jeTVXYfOxBAbHifMAvZLlWL8opboIMH7CEXOv+esYsXy+Di+8Oiw==
X-Google-Smtp-Source: AGHT+IF8vjx1b265u8EJjsRVZDEZZx94LHHYElIFcS4N4HsB3Zg9vHVzHwt/gANp8P/yU223Q4VzVg==
X-Received: by 2002:a17:902:d4c5:b0:216:53fa:634f with SMTP id d9443c01a7336-22780e206a3mr53111775ad.48.1742562414202;
        Fri, 21 Mar 2025 06:06:54 -0700 (PDT)
Received: from thinkpad ([2409:40f4:22:5799:90ea:bfc4:b1d2:dda2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2b1fsm15655045ad.144.2025.03.21.06.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:06:53 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:36:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v4 3/4] PCI: cadence: Add configuration space capability search
 API
Message-ID: <20250321130648.bnwf57qqsi7kkdby@thinkpad>
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321101710.371480-4-18255117159@163.com>

On Fri, Mar 21, 2025 at 06:17:09PM +0800, Hans Zhang wrote:
> Add configuration space capability search API using struct cdns_pcie*
> pointer.
> 

Please reuse the subject and description I provided in previous patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

