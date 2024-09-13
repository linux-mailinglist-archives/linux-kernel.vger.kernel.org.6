Return-Path: <linux-kernel+bounces-328656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33F9786FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A791C23E70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FCF839F4;
	Fri, 13 Sep 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3Jadakx"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499979DC7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249160; cv=none; b=NSGQ7FnrlCcFdSmWzmVXLqvSXCG+hkBvvsamqmARlZVzF4DHiJakGiB8bN9l2UW9RQb0cSv+q7CCVoKF/DiwhZqYVngitUvZXCnea73mQ2CBbxNqR6f+t+2Oq0DrjQDleyixLiYkHrUI2BKSt6cBzFvhDZb7UapFE34xkE9Vgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249160; c=relaxed/simple;
	bh=Augwq6E3kJa+ITey02QUlXrj7/RSXf11V3IFqWKw0P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcNwdioj/LgrRNtTQyZ0Rua0cWIC8kzcYbJT0vtjULtzxpjNGx7LF4ke00j4VvaIYCreqZXfyw6Bu6Sgz0IGjKQChEH59ogDBJVFJ1VEHTu8TLP+txasBeoQucC+Ziv9VtcJwaGHjByXMNn+pgpKb6uYhLWmxKxEJEbWyWPbP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3Jadakx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso1791621a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726249158; x=1726853958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEraXErRXS1IWHSVQbtwA0Xnq/Dy63pRrYAxugf/Fok=;
        b=l3Jadakxc703C2YfnITL03Vf2D0vufNo9FjDdcd30k82HPX2balfEc6RoAK/+WulA2
         7LSn49XsMgorBmDgtLyKQPNhiUQQsrVYj5Dd6xOtrQMjGxA4REWy/gNP0Zww4x6Q8wbl
         lgpSUSMk7hNbr+rAM7gWeYR0fRx27xzqz9unYhQG00XrTRqgw6Kg4TaznLmeuO8jrirc
         rLiPSup+VZRZ2N04TDVVWYImyHnFfL6MBAqHLXQUmlxEIF8R6aAD+D3RoBEvc/ccvi4N
         pk0r64e0B6zPT+/0tbCeZHxEBh3SD3IWSg2ngQmlwf867nha5JWZ5Rxjdo5DQwWI+Z5I
         Un4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249158; x=1726853958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEraXErRXS1IWHSVQbtwA0Xnq/Dy63pRrYAxugf/Fok=;
        b=tl7Zv9EVEMD9ZP7rdnMGkBTXPdkObiZo8yLRvr4X5zTLOOimjrHNSGRcvcfylbvkb+
         YKEggzcQibV9glNZA/DHoHJShu3mhfkceMoJSkcQBZHKeKD0k4M5fhmY1E2drJlHmNBT
         Cpj+pq0aG6ZcRnk4kDVMPjWPZE5fGIwSSG58L8JwXAYwbLbcbyDzntadjPs4muXwFyZC
         vF9b2BJi5bC8O4b5lZnjfqmfQqi79XGoeMgmw8XeDBq5ig4KT3FJE3NMMiIbPO/dUvwH
         CVx0fsjOG5lqXF6cC70aa82eAKe5Or3gmJdk6R/h+GIRjxEwT3aagC7Sb3YzFWAiT3Jc
         craA==
X-Forwarded-Encrypted: i=1; AJvYcCV2TL7UfOhL9Xl0vvGRyxrTU/Kvx8nRcLydvXGN1HmVQLooSEQgsuExZ8XS3wc00KnbvKfhFLKAMR1V+D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJRDCL9hf5LxTWTPFU6GNhrhguWVqGPacfqPaJ8Ingk8Mu9pr
	j0vEGIk3Vy25hpjsNUjN1rIiPJvZW28ajOcL/4WJLFtBfGVS7SCc
X-Google-Smtp-Source: AGHT+IGdrWJUip0k5onVVt8+KyGuKHHsOoDgu1ouQkt9rI2sfYjR5Qy4DdkJlOsDTq9v7ljf3kpYXQ==
X-Received: by 2002:a17:90b:1e0a:b0:2da:8730:5683 with SMTP id 98e67ed59e1d1-2dba006a195mr7060228a91.39.1726249158005;
        Fri, 13 Sep 2024 10:39:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4c0d:1024:4781:3234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c8ca84sm2081922a91.19.2024.09.13.10.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:39:17 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:39:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3] driver core: Explicitly initialize struct member
 @data.have_async in __device_attach()
Message-ID: <ZuR4w5l7kLkwSAQS@google.com>
References: <20240913-fix_have_async-v3-1-793707cfc0d1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-fix_have_async-v3-1-793707cfc0d1@quicinc.com>

Hi,

On Fri, Sep 13, 2024 at 10:05:38PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> __device_attach() defines struct device_attach_data @data as auto
> variable and needs to use both @data.want_async and @data.have_async
> but it explicitly initializes the former and leaves compiler implicitly
> initialize the later, that does not have an elegant look, solved by
> explicitly initializing the later member as well that also makes @data
> have full initialization.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> IMO, this change still has a little bit of value as explained below:
> 
> - Looks at below similar commit:
> Commit: 8f45f5071ad2 ("gpu: host1x: Explicitly initialize host1x_info structures")
> 
> - This change's initialization way is obvious better than
> 
> struct device_attach_data data = {
> 	.dev = dev,
> 	.check_async = allow_async,
> };
> 
> which is better than current
> 
> struct device_attach_data data = {
> 	.dev = dev,
> 	.check_async = allow_async,
> 	.want_async = false,
> };

Unlike host1x_info structure from commit 8f45f5071ad2 that you
referenced, which sole purpose is to describe hardware, this is an
internal structure in drivers/base/dd.c that mixes together scan
parameters and internal state/result. The scan parameters are
initialized explicitly to convey the exact request (i.e.  for given
device we want to try to attach a driver synchronously, but also we
might be interested in knowing if there is a matching driver that
supports asynchronous probe), the state is not mentioned not to draw
attention from the particulars of the request.

I'll leave this to Greg to decide if we wants to apply this change (I
would not), but if you are doing this you need to make similar change
for the 2nd instance of struct device_attach_data.

Thanks.

-- 
Dmitry

