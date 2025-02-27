Return-Path: <linux-kernel+bounces-535553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ACA47478
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F433A2BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CB1D4356;
	Thu, 27 Feb 2025 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sqAuBJA4"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EC28F3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630711; cv=none; b=N8xrusI0iGLevZv1PkcQCf3tWWb/JRI+QE5scEfpzsJC8GRiZe6T7Lj9EU8j7RzfgRt+2kvrg5mwL+67wb8DeDz5o6Xv8G72qNrAOFtyoyqagbN0//13NlE63QWljodSLZFQKtY9/ORvC7my7LZBrcKYov6HhHLh5GBhGTEH4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630711; c=relaxed/simple;
	bh=HcVszmC8OBV/+9/Lu0DEOQSInPpAA+JK++A3ksJlusc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG38tSAy7D2ueXn+9F164yjurWW+A/24by6vrcaIDWUFLjphazRb5gfM0ypeZjM6tVFUeI/I8wROtCl8/tzWc3jRTyrc5nJPES52iQXe3ibtgn7ZUJ8PzpRWZLL/cDH0oO2hAJOdteFg1lfzhGedDSJu9Sq9fXBxEZTtpDDpzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sqAuBJA4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47200236004so4957841cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740630707; x=1741235507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEY3LjeYHMd/NM/6j5VcZJTh8Na8ZkiTgINYFH20qA0=;
        b=sqAuBJA4nxLCCC8PkEiCIZJuKSAGd0zUJKBYOYc/4xBE0CVpKoFilArXTOvs27l0Nn
         uKszMqmzTVr55xgsbnplJzOg0U3LkFTOo12vL9uwcmQvQPYDbtsyabDqXEK2rKQa2QQJ
         BIT2m7T1q4ni801inYfP4DrcLs+micQKauDdUx4Te0bePyt5bN1Qwet/IW9yVfEDtB3r
         RulzrkEg1+HWTskvAG7xjOFBo5OFiANOfRbwZEKYjuBWZORwAmagCyWSF/QXPo9qQr4E
         tCspLTi8MbPk8hX9V9TAeCQKJ28/a5Jw31WmZilmbIv57XxSMS1HBq8WfmhwHZRhcL9v
         hYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740630707; x=1741235507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEY3LjeYHMd/NM/6j5VcZJTh8Na8ZkiTgINYFH20qA0=;
        b=CDNUGWpfiYnmU0bckBith4bj5kKE51xuVd/23WFRh8xsCKUk3ggWEpGxZ1p8Udnmvq
         /mAlgJQYbqYFAWuw0JJcEweaNlvHF3VnFOmtIOgxw7f8GeJkAoOXSl7X5QWUzvpo8YLX
         7+MAqCxV4LhW6VGNAJoXB2sNPT/rL4sv62OuohpSkYXXQ7/HWCzVhrKD3awOyH11EtF+
         XLiSV6m9O6kQAtY0unLVQ8Ee/7biRFRBveNWQ99R1DhAfbE+4R2O5rmXYUxLy3+VDOkW
         hQusXVzwoZps3dSGPX5szOl9pgLD32qfOZWEY2jT1s/H4p7JqP5pkitJ7kE/pr4LWIQQ
         KLmw==
X-Forwarded-Encrypted: i=1; AJvYcCUxGREUQqHgL/C41efOwzolMl3PNpbejDX0vEgp24Bq2EyWQBOPmyxJiBxqtlwZGDccU0KoDKw3YhEb+y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fP231pkbF/mk5CqycjL3XPlbmDum7XmNrdFqUjYAI7Ku4ypT
	eIc//OIWbbd/1NY8Vkphj/EROoTopnjOJo1+3q3NBFoyeiuOw5HoZGwQEZSqmY4=
X-Gm-Gg: ASbGnctFPVMmnJWfHF/qYyAJE0qAHTMk75rxxb0yh5aaJf/UbD/AV9C73qr5QzgnetO
	lA9nQ7PJT5imLN/hb4Rg+pjWE3SmeI1NKzCVeX+sMEvRnNFcDjPyCak9Ajt9CwvEf0ndAF12J52
	AKlWVHCM3lC+ZOAJlvDc1Zsnw7y1ySjkINgJfRjA6VVZyXARdcdOLd6iFgn3dvpq1fnUY6LAnLF
	sY6yVSNJxGvwNjfJRZ85MxjpAouowPfkVAkhqlgIcy+FR3aRjs6dPvgE+xrUK31dxZpFkgM7PMU
	xTmFJTgv7orgkXCrZ2glgQoE
X-Google-Smtp-Source: AGHT+IFGYU0C6yXnxzDeStOhCwoYOsdhy3SbzTS6eUevEejPrNyHPqTne+RSMEnKkPn2ESpmnoYiLg==
X-Received: by 2002:a05:622a:1342:b0:472:70e:8995 with SMTP id d75a77b69052e-47381380745mr94338981cf.52.1740630707094;
        Wed, 26 Feb 2025 20:31:47 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47472409ab5sm6275041cf.63.2025.02.26.20.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:31:46 -0800 (PST)
Date: Wed, 26 Feb 2025 23:31:41 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <20250227043141.GB110982@cmpxchg.org>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7-9o81kBfw4tFSz@google.com>

On Thu, Feb 27, 2025 at 01:19:31AM +0000, Yosry Ahmed wrote:
> On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> >  	if (WARN_ON_ONCE(folio_test_large(folio)))
> >  		return true;
> >  
> > +	entry = xa_load(tree, offset);
> > +	if (!entry)
> > +		return false;
> > +
> 
> A small comment here pointing out that we are deliberatly not setting
> uptodate because of the failure may make things more obvious, or do you
> think that's not needed?
>
> > +	if (!zswap_decompress(entry, folio))
> > +		return true;

How about an actual -ev and have this in swap_read_folio():

        ret = zswap_load(folio);
        if (ret != -ENOENT) {
                folio_unlock(folio);
                goto finish;
        }

	read from swapfile...

Then in zswap_load(), move uptodate further up like this (I had
previously suggested this):

	if (!zswap_decompress(entry, folio))
		return -EIO;

	folio_mark_uptodate(folio);

and I think it would be clear, even without or just minimal comments.

