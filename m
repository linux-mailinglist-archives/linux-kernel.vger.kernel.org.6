Return-Path: <linux-kernel+bounces-262686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB8B93CAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF28B21CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB7145B00;
	Thu, 25 Jul 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0+KE8Iz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D31411E6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946121; cv=none; b=fzT5ikLflMhz+8wGqhbWfMDSlow5eIACgE2oWtLLd88qneCQcRGEr+fINc/NhwQrQ33yy4YAFGg+KRmXd+lNwZpUFDYNB2y+0qHJEuckg9YwGZ7SAGpTVUSXIpGrustf+uxDwIJPO2HvDOr6oMDFQ8s3H5EX3uxARWWYVKzJEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946121; c=relaxed/simple;
	bh=e3QtoGAhKBBmMhj47JDionvHjW/apkWJ7Za+hWvi5KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppnP+00wPUNXPQNpAN7KB2EPQMABjy8jQc4SKY/UJt2itBTY+SALa9HBNSAfCFbUY/sfdHsqMtC3n2QLGOrq2wZuivQLk+6QS9JqRVup2rRn8lMIdTCjCKN3V8uUwwl+0FLB+VqyZTacVag6RAi/GjhHyBG7lOqEhvQq59FyFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0+KE8Iz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721946118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/KmYr3jbfKPlvOHElaBkUrO4ia1UgbTouR26iyDyNM=;
	b=I0+KE8Izv2KPCiz2ecVmGBJ8VnmtxmwN/NOJOwwzqXTE7K1hXocw9Enh1yXNrtpVdLxTHb
	QCBVzRMO/j04GG6g1IHgVsSYnT0EQOtt1ElmRNJpEqma3JVaXPMyT8RvIZTWMH8cHkOPko
	I50TFaq2KEHIjcoqD4en7IVrGQBQ2f4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-9opXPXowNxKtd3Btc4UCNw-1; Thu, 25 Jul 2024 18:21:56 -0400
X-MC-Unique: 9opXPXowNxKtd3Btc4UCNw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b79810e326so595326d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721946115; x=1722550915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/KmYr3jbfKPlvOHElaBkUrO4ia1UgbTouR26iyDyNM=;
        b=EAizSMNUlt4MfTn1InbYT7jXKBEHMdzV9gBW4KV7nJNwgLWv5LLnfEWzGmurq7M/bE
         fjRqH3hvTcW0QfFmifAG5cmcJSbu7mWu3AgKmHaekqZAUUSIANwvJu+MwFGV8leU6DVA
         mzIG20TuxvymvJ9JA0EJhlf0I9Yrgu28mRbGETnHDUKrpj1nKUG2L88qUCKhl0olT4w3
         KSvk1I89PoGQsCkBkWfJIsGgFuyhJnlSMFmsszSflYyFXXwcDpmnp1pSoJzqys5W6yFe
         ur3PqxgKDIiKgcBF72n8ul7cbgC+zkekUngoKjM/C+UOOs1TUKasytaUPPFqn9+4+LxA
         jn1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcrZxm/5uhIKSJVgWYf+/zdLd7jxfd1XeOFMhZ1ckFlzIpKPE2izvoX7KyQYqJlEckHl3vSoovqDCMZ3JLavpFpaCp/Sdbl+8NuzTG
X-Gm-Message-State: AOJu0YyRd8+2khvTggXKAyM404sd8ZTYp69ZfQHEsb5OKXOC5XsvgFsu
	qG5z7gusk7/z7d64NO6lhry0XbtEeghEPCskIyyxZS5g+6Yi2Zv7TKd2mujo+bhs87Gv9Yfnu5M
	Y6RtbAMDjL+V6bBayeUT3fmDIcC0PDjfKvIrwiy9AmcIFqOu6l64mMGmhWwjCGw==
X-Received: by 2002:a05:6214:cc6:b0:6b7:a4dc:e24a with SMTP id 6a1803df08f44-6bb4088c657mr43849296d6.54.1721946115681;
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07I6M5sZysuSbSiY1fNxwueDCqDxgZ2yyxKjAhplt3Bd7CWYx3uTZ4M/qfs37U5MR3g6jXg==
X-Received: by 2002:a05:6214:cc6:b0:6b7:a4dc:e24a with SMTP id 6a1803df08f44-6bb4088c657mr43849116d6.54.1721946115407;
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f925dc1sm10943676d6.65.2024.07.25.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:21:52 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <vj6vtjphpmqv6hcblaalr2m4bwjujjwvom6ca4bjdzcmgazyaa@436unrb2lav7>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724065048.285838-1-s-vadapalli@ti.com>

On Wed, Jul 24, 2024 at 12:20:48PM GMT, Siddharth Vadapalli wrote:
> Since the configuration of Legacy Interrupts (INTx) is not supported, set
> the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
>   of_irq_parse_pci: failed with rc=-22
> due to the absence of Legacy Interrupts in the device-tree.
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

Thanks for the quick work and follow through on the patch, I appreciate
it! I would not have come to this solution myself, I was definitely off
in the weeds when debugging :P


