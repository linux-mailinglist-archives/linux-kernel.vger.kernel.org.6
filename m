Return-Path: <linux-kernel+bounces-524252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB2AA3E12A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F778602C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A020C00D;
	Thu, 20 Feb 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Y2tqgT8P"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307B20B81B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069675; cv=none; b=dJJQN4uubn3Qg6B/vSIAIu1zFEo7+zcRo4NBnV0EQCprlL2BgCvKCXu/GLjmoo2fHzY05bXYha1Ddb8jYKEhkVeaXASQEmVSq25JgT9cexm4KmcW+l9+IwbbNBofhSSgQ2c+J6dmY/YmB7RIbw2v6sJivlcfDcNsJIxVhQqZ0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069675; c=relaxed/simple;
	bh=wtVm1OReLkO+WQiX2RY76tqiMRy5uIw9+ikeo3KDP0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNEfWYGhT6r/TN6xdgbCZbDHPGgt/Eb2ud7zUMjPcGURIpoqnypmis2gE4cjuVG7HOtjvhmtSAUN6htxBrEbIart0KvFpx+bbcnysVIMezkkE07i6BgQqn/hs86Rw5KFbZnYLIMWDCW27JlhGRhxf9FkKt0gFYLX6ImHOiipCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Y2tqgT8P; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c08b14baa9so99860085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740069672; x=1740674472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvT9hr4wyRdgqH4GD8vWiYOLKGLcsbZRX76Llb1LL6s=;
        b=Y2tqgT8Pjo3g7ZZPfYB6vqKamFXy9a/mwd/St0nRqbx85XVIRfZYl5bcdr90Fyqo/E
         jtX1mKjR4wsR+ZL0J7yvyvdHGjwAfaTknUc98dedqPDCynkrMMgNjj9M4n4kGbNmoKhw
         yd0h8fHXDV4Hd1NxvXVhsN8fRUroy2ya9Qm5KbMgm1Hyh6mkhBhOMVxtSOOjcyWcucqi
         AH5+o/8Tq4MICedCyzIXoA1JU6XLJTha/cawWTxeCVap4SniIR9rghA8JGy09To/LpQy
         sg9n6E7gtlB1hA7El7K4u3o9ekh2L5YqSJlI49XPQKjdkB3isCMTzGERFyhgsfCSSTup
         lENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069672; x=1740674472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvT9hr4wyRdgqH4GD8vWiYOLKGLcsbZRX76Llb1LL6s=;
        b=S3MXz03splaqfMazti9zEUy4vXcPGSSs6CPXujl/vND+D/PbFthkrklKER96uxnGWr
         h24Ya2xm4zIDK7DxcOF5zVI+gcIOU46Y7m3dh0fyEqQpPPuNxoJu5/XJFcKosbFpxT+8
         yt7HUHnyRYB57zEr3dFSlMmR9tCaErP7kquG1//6i2JiEUTCJ+OsVpoR7UL4UW3YupCc
         wxe7TAEdg4Y4jcFD1SINWMbIjeeg7IjdMAJpE9/21MWs07eYdkOT9ScgXrVLMghp7N0A
         rcr1y9ssLXcsDQ6uORv/k9ufBd6+1L+AtmgA2sLOW6PvETUTpl0rGFPhk3BgeIMPRbKk
         nBig==
X-Forwarded-Encrypted: i=1; AJvYcCXxLFZcPZdT71vkNMiXA1zN2ttf8xrF1dW1jv9+sJFGIVsTncT28PbZEcui6C0bzvm0RaZgILOg4tetH4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IXAQBy9F8W+Tua//wTdTURO4bGHoGnFL2kEJX14u6eGvcBod
	fGBSMUpIpvnrwokLuX9NVh2ncuSw2hkxbP9/gdlrqrQUJXPsBYBSg3hJcpnuX0w=
X-Gm-Gg: ASbGncurWyhTWu+p+wRoH4m5xAo3cB93d7NzqVRHh0i9/1GTy1mHcmsXbmCM2oULOY/
	CDSoUcsqQX32FkN7nGKciZ9BYoYlNVequ+VOeiFS3pOsQQ6MxQKb8us2BtYfQe90mVqEmDfR8r0
	PqqpAvYOzqfEVeUMiXHs9Nm4I8zzD8sXhdb/AvovpwSBK3O/Hftg9XlG6IsVTrG8fRzoLwZHMuW
	LXavG8G/+NAfBSnvIA7o60BxlHXwHHNdktlEQQG4DpPXYjM0kYUD4TKkWAWa4AjpQpptl3IrSIr
	Vlmiel8iuEqdhEAl/lSb5h6RZ+o+OCe+bczjyqo4nFUmeidT2jbtAHIg1uFLcqbzl1VpgB2ciQ=
	=
X-Google-Smtp-Source: AGHT+IGlH80zk+2PBNQ/ZB5qRD43YHH9jlASFS3zwf6R7lUXwObcQaUrgnHIjK3rfriVXd+k7XVBog==
X-Received: by 2002:a05:620a:1927:b0:7c0:9df3:a0d7 with SMTP id af79cd13be357-7c09df3aa60mr2071684885a.41.1740069671990;
        Thu, 20 Feb 2025 08:41:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c6d41b5asm70688485a.73.2025.02.20.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:41:11 -0800 (PST)
Date: Thu, 20 Feb 2025 11:41:09 -0500
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
Subject: Re: [PATCH v2 03/15] cxl/region: Factor out code for interleaving
 calculations
Message-ID: <Z7dbJfr-qVrXj6ek@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-4-rrichter@amd.com>
 <Z7dYODuRrRv1bXpV@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dYODuRrRv1bXpV@gourry-fedora-PF4VCD3F>

On Thu, Feb 20, 2025 at 11:28:40AM -0500, Gregory Price wrote:
> On Tue, Feb 18, 2025 at 02:23:44PM +0100, Robert Richter wrote:
> I get that this will be used later to pass information back, but this
> patch by itself is a little confusing because ctx seems pointless since
> the function still returns the position and accesses the hpa_range directly
> 
> Looked at in isolation, having the context structure change in this
> patch than just adding the hpa_range as an argument and adding the
> context later when it's actually relevant.
> 
> static int cxl_port_calc_interleave(struct cxl_port *port,
> 				    struct range *hpa_range);
>

Disregard my note here, I missed that pos has to be carried through.

Didn't notice until I looked at patch 3 and 4 together.

> +	ctx->pos = ctx->pos * parent_ways + parent_pos;
> +
> +	return ctx->pos;

This looks fine

Reviewed-by: Gregory Price <gourry@gourry.net>

