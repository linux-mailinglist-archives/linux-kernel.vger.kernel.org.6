Return-Path: <linux-kernel+bounces-524605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2CA3E515
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06417A881E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07DB2641C9;
	Thu, 20 Feb 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Fgg6DbOH"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B162116F6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079920; cv=none; b=nyD4uOfruI+wKdOHUUUKOVmDVOB+vZ3Cm3h9E3n0/3Uzq4d3Mhe8EJ+eizL8Mz3zlUcCOE52zvaV9RpBshnR+BtJ9asFV9rdp6SeuSHodsxAQ4Y3OpcEFw3mFAHPnYO1X5dxKl06OvGCPDTI7Xef2NHXCdI24wy31YN2Qt/WN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079920; c=relaxed/simple;
	bh=zKZRbmlMfiArVhLDPOtXDkIrEe3d98jChT9V5NFyQL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3qMb+cpJ0wBjm1vvRmc7nKAVMPVnyTic+ONprUDhon4Q217+EfCpOKeaWF76urjHs8qlh1sEMx8JLOlesVaiqf1qqda/TKjqWPdjZZaj6ci0OydUGwzEYfhO8Y2MGAYtwuXwP27llvbqAXo8iO4HdiojgkfOmQWI2mF4lGwqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Fgg6DbOH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47201625705so23626151cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740079917; x=1740684717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5B3VvCvglVGU8mE6rfo8Oq9Xi4U6GIxDpJLBxzVgoWs=;
        b=Fgg6DbOHQr0YEpHX+8VRRJWLvqoFFEiJWHl7ZKBzIISFDv/wnbEL+te2Ub38obsSRV
         sXm7as4Efv2gXyWyRewNEYEZznp7lO6MztYjmjzUL7J6VyCyYXgxXQNsW9nJc3LwsSGs
         MzCZDv9uu1mhdEjp5Nl2TwO1Wz2eDC1jQfSlH4mtkwhbmaJLDL3h9jmqV1cPeda9RqNy
         IcVIv4xJ1MAMhtalHMxY0p/WzR+2GPhwe4hkKDg5WLpef2ym171+vlcTxB1+68YE89NR
         9ogu2URwNEGFk11w96TX9h1Z01bUAaUikHmw+PElIfuVGkz3UTA8sFv/r9o7XjvMYkTe
         CT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079917; x=1740684717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B3VvCvglVGU8mE6rfo8Oq9Xi4U6GIxDpJLBxzVgoWs=;
        b=fv8UfnoHsVtZLjh/zC6+jWoQTyU0ClIQ/N5qjKe4lTAJ+p9XnY6RI9WvfHYOA4b89N
         XxcJNdOInyJ0MNSDLFZxyk1G2c7Cm4WjvMfhBcteSBjyz5S18d3yUzNnF1G2WJtJFbo7
         hPVNd7Zi6RZuvNK4DWv2R0OQQkxcRSrBbUvbdY1WY5pXbjjXy5Gz24/SAdvScgBZk2zg
         ul9RVJ2kJGg2UIniGfLqzLsfcBO+tWBP+8Ymn+6VAO0ksKOK20LKzjxNg5iXRJIst45h
         P8MYEd5K+6QheLmuz+wkCbV1tmFQHdLqGKhyWhrNYj2T8a2zmTE/xPXsTZuqZwPTH49H
         GUWw==
X-Forwarded-Encrypted: i=1; AJvYcCWhRRw5ZGJlr4nw3EbeqDPmRrL7F0xDJYBx6ijnGc53YMRZSwcG2hobQHh+3HH8WzCAC8UtstwORcw0svo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQiASNpWMkDJtOwBJUu9VF+mphZ7vtZeAdoohrXcfxHwC5vzq
	zfJRTiVGCkfz49ZteGUXs9cZsi6eI09FzTJkeSsv6QNGUzxfZyTLGVzxkY71GD4=
X-Gm-Gg: ASbGncs781oayDmVeKxuNrw8d8IY0WzulB+fqiVsSerTtBkVAT3oN5+nj7g5F+bo1at
	+ngKSfePPjBSWoLUOtbusHaErJy8bREnhLzPN1bBUVQGTIVWx9Tni8d2h1Qsec48bVYHeMZFHjO
	X6xtsknyhs8G7jd6uyL/XENQ7qLtALmNAR2QpvcC6e3tQX28v4oZKgkFavBbYRGa/6OfqKdN37X
	fUQp1aq9NrmIvk3UAa2w5MPQshrdcH8Bq/VXU1c/BKlw31FCShCU1Lj5GXaZFu7EG+YjiWAz/M5
	5IRr/sLz2WrtXt+TTBdX1+ijyAIXOULZAPKGgHDOFnHuP1gbAAi7xOvy9pcrCpVzJ0xDbzEeXA=
	=
X-Google-Smtp-Source: AGHT+IFIoH2n7atYbRZlP+y6O4TJiqvU2UuxiHPMwz2VbHTgGdB81yXveIX9y8r445vXk2WbBopA1A==
X-Received: by 2002:ac8:5f14:0:b0:471:80ef:35e7 with SMTP id d75a77b69052e-47214ffad1amr59567541cf.4.1740079917672;
        Thu, 20 Feb 2025 11:31:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47207d1dc11sm25157871cf.6.2025.02.20.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:31:56 -0800 (PST)
Date: Thu, 20 Feb 2025 14:31:55 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 09/15] cxl/region: Use the endpoint's SPA range to
 create a region
Message-ID: <Z7eDK5pk0qLbo3BA@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-10-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-10-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:50PM +0100, Robert Richter wrote:
> To create a region, SPA ranges must be used. With address translation
> the endpoint's HPA range is not the same as the SPA range. Use the
> previously calculated SPA range instead.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

