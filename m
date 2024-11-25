Return-Path: <linux-kernel+bounces-421693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0C9D8E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68E316AF2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45A31CD1ED;
	Mon, 25 Nov 2024 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bmy3a9g7"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED01CB31D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574150; cv=none; b=dbBCFYw2J94sJwrY/xQ4ACOWKL0GqaRlTEsQ1thj7+eBXv1slWXCg4amkwjSh7jLQ35lwHGqlBiOz0Z68oY6PBtQeIg3hQCKhQXrd4nVazS3gg+WoSuJUaYeR90eZVfhQL1fe/9zAh+uicOPCiZJjIOMjBQTgLGRinjkOV8RQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574150; c=relaxed/simple;
	bh=3rZk83BFapNTYSBmR45Ri1F6BV2vIxTmxP9C/qJIk3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBkWE5BUc2AJ/K7/s0rykuVfxqoLWKMVI8BYIFAB5xrfncRT81O+oXMjcRFDOfyF9szoC0TZLb2mj+YnRnwuHhOQ6RAr1AMHm0aWgCiRFxHIg4yE8bV9YCWXS3TDF1Q8VpCH0tsKFG51uhdp1VJahDQVbZQITHEU7SC1qr7QWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bmy3a9g7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4667931f14bso20123261cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732574147; x=1733178947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0LEVVmh09qWTmRbUUXnS8M397YMXluTgjzA1Orh4xQ=;
        b=bmy3a9g7l3vx+n5XzpfPuVURidiAr7SCb3Jx2iua8cP1S26eoskIAzODwCqpCRK2lq
         6H1eTsN6vMhDzv1OeqLP8Pe3mOYDtVcX2lkqMoLYOsamRlZLR798a03Pu9pH+7ToZB7R
         BckPEXjV//WboJlMAzxycaHzdU6olamSGgaPEviGzqybS9tPcFNs+F8X5HIyQhoCrHc0
         sUJe6XNMKtANmIIXdzKSIqYlOoV92qpBnMshjcbV7qTECR1a1bXWEmp1SnbziviQbYsa
         HAOee697Itt7oe25TPx9rqync05qV9+IMX8zpJhdZpilNGcQ8VO+sJVRYmHesxvSC10S
         66DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574147; x=1733178947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0LEVVmh09qWTmRbUUXnS8M397YMXluTgjzA1Orh4xQ=;
        b=mFNeXs0Q/WoCdBCeZGfl6JGDW7bckLouZ9Xjj1cyI0zloB5aFolQKWImrRB2WFOXa/
         qu/7x6hXiX9RWdfFPdguY0coEEfvEqXDRxd4cqOSL3FT+t6hWkMInoESqHNzNBy4RPq/
         xfvONbwm95Ww5+awHAj3d+/08Q5VqnmrBK+AeLhnKTRr4/YBZ/ElvWSjtX/AORSZGno1
         J5QASW5qgcUxk15D6hsIk6VNwuDwBzGsXFxO7E2/n3pDDeg2LijyCfHQ2/89QOrrRErf
         u19mxUdhT0tBMAXk9PpHHbzYL7sLhb8vwK7oGzjasiGH7PKVlenPCks/63MYXVwZD/UK
         etBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8J7VBc9j2Waokq2/ZmYEf1YpL4USdw6d6u6rWkzD8c20jkQwumJxRbfF6i35af6KjiKXW1e55gUlRmLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8sPFiDEsR6A45OIpPPMn9hjIPY0LQ/WIk2d+SWyThgiZ9VlZ
	Hh5rdr9FrMTFspGTe1KE+GbjcVvN2YhjfLqtSk+2SmF4sAHd5SDtkmu1lhq8NL4=
X-Gm-Gg: ASbGncvMr9Ze7SwSxfzNd6RGsoQHxrtEqmHcKyki7AseXsG1nprs+5nDrtVzM/7l7fN
	bS+2F6qh6ABafHeZEW+QW/xcb53HRX45WluoZCfWwCFV5zDUYbfiNhULRiA16RyTavVeIm5SjUN
	b2AMh6HnqZDDkLqF/jsc0HsI/OoIm0Eta4okh7SRCfPu/okB2yh6pljfytzMIFxF4cUyflcmAyb
	8eB5ztbAoeRomLNdYWF6gFT7568NLvydiOqRZY+EFTCLldKzDWicp0vJNUuMel99bqMAcklrXA1
	wGlhiHvDEb1qpEKOreg1aRAGnJyFBlVtne4=
X-Google-Smtp-Source: AGHT+IH7fIwbkI4uH8JkSw8OIkc51k/5IJgozs97dQO+2GrBwa44CknCf+8EgNq+gOdx+sWFIvRlIQ==
X-Received: by 2002:a05:622a:1917:b0:461:1361:eb14 with SMTP id d75a77b69052e-4653d5225demr239121711cf.2.1732574147447;
        Mon, 25 Nov 2024 14:35:47 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466a47fa3f8sm2743791cf.69.2024.11.25.14.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:35:46 -0800 (PST)
Date: Mon, 25 Nov 2024 17:35:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v6 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <Z0T7s7_j0_FCtihr@PC2K9PVX.TheFacebook.com>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-3-gourry@gourry.net>
 <6733c9d135589_10bc6294b6@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733c9d135589_10bc6294b6@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Nov 12, 2024 at 01:34:09PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > Systems with hotplug may provide an advisement value on what the
> > memblock size should be.  Probe this value when the rest of the
> > configuration values are considered.
> > 
> > The new heuristic is as follows
> > 
> > 1) set_memory_block_size_order value if already set (cmdline param)
> > 2) minimum block size if memory is less than large block limit
> > 3) if no hotplug advice: Max block size if system is bare-metal,
> >    otherwise use end of memory alignment.
> > 4) if hotplug advice: lesser of advice and end of memory alignment.
> 
> This seems like documentation that also belongs in-line in the code.

It actually is, just ahead of every check instead of in a numbered list :P

~Gregory

