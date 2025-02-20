Return-Path: <linux-kernel+bounces-524146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6449A3DFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87B67A9C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBEF1FECD8;
	Thu, 20 Feb 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PTIAMy8L"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E7282F5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067255; cv=none; b=YB+W2QNKnUZUxGgrw72kcG1hRMBDCLDCwEj3yI2lxJoE2Y17tze9f8KAlzqbk3GBDnxYW6CgMmsmhW8ZdOIl7JNp1JiUAatR3b+10Y3jEfRwxr65bJHenGcLe2SLY9cO3SRUnrdcneRuEdxGDSVJ8YFfzgXKiPb4cYD4uwarhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067255; c=relaxed/simple;
	bh=PFLJoqT/cNJyDxWt7BAfFDChIabrl8XCG2RAweqsZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMfdmRpuUp0BjkxSl3Bome4RWZBvZ9EjWdBbnOJffYEeepOg98YeppZJy53G0dDT+jTpg2tzG+WyJzvcx8P49w6KNVGCtRFJGJ5lanBkOF5i58VqvZsvf3raDP8n6iDE2odfadzmMAwo/xspI3CmXokrBpWJhn4UHfkWgAhJxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PTIAMy8L; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7be49f6b331so110900985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740067251; x=1740672051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb4nDnsDItCK7e2FGSDzpODPaEsgaUkyUWraQucTKeA=;
        b=PTIAMy8LxYVf8aveDl5GB5cMwya9FqrCY9wMiL8n/iI08PT6HwUCig8mDDm9P/c25B
         BD8lWth2ZDFG0s/Gy6f2qtV/kuDMsSGbDccTs6S6PSPVwC+MidghrKZ5G7dRTguOdBKt
         r2PfUJSpAjS5MZ0t3Ikb/FZGbU8ev/QZIbcdzn8MUKdXuIeeMtWf1vcPwA58dMLb03+Q
         8+eNXMkc7clNsazlploVuNrxMAgRSXjsWNls3EzGIYttBIL8EK8B01xl5Ko7ZNiu50BM
         UgznjqrbapOF2ZgkLJXfmwGIyS5XP2lG1LgSrI08bvG1auda/fDAfDyS8KhBfvizgchf
         537Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067251; x=1740672051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb4nDnsDItCK7e2FGSDzpODPaEsgaUkyUWraQucTKeA=;
        b=hb39kl5PmZJGEnn4i+6Mu9+3tsnTnJL+47cHGxvqc/j7WrX75qJwVDIDI6DUhSl/xr
         obuGDvWctGtqCcMcl+aV/eBL7Cw9jlMm+gSTdk2oWp7dl8t/mDUlFXR9vz9BaY3uZKyq
         8ggWt3EPyrT5G2O3dJYiLzZ4at0YfU7wZ2+yZ7UHY/E4TEcYY9WdN8Sxl6ysimyK5jTJ
         SmccmvgOX7gefr9t0I7jrXeqNyVAiYrDEQHmF1hG6RnNHEhr7VY9XikP4CbkQPDisd1N
         GhXoR7pzxMU9X3T1WsistWQm88I28g5HLg0JVAI9ZL24vBWOiIKdhAx97sB6xTdpox6p
         YdTA==
X-Forwarded-Encrypted: i=1; AJvYcCWWWVpZD6uzJNJ/vHqBXH6xzNAWSo5SwChz2nftOTf5LY9SIOx9whnMCQWAHtDk66Frv0vpEhkljl+U5qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgYjB7TMI32X+RRuITBbincokdDNxotqR3lQF0Ou0TBaMCNjd
	EDfuWsjwHpU5jN4DGp3hRVljtyprOV4zT9wZ2B4bwKQ49B2PNfxsae+Vcf/BD70=
X-Gm-Gg: ASbGncshSSKekIoLhm8nx1t3xHciK1fVlDVETd/iEkQZNq0yNJDVbUS1KjYzkKDn+K0
	S8d/8P8zhiRyE4qpeHd/hy5bpJdWtsVK58hGZ2EWpcbvsXlKYn5UDg1ejNpEoipxdMME9vOBBgM
	Set5q5er3/PWeUEgaqoJKWEe0VWMwWU2yPZrVG6a4WNSDl5/E3/9K2mMXr3nmldU3LsTGe41MK1
	Iy4UMAL58amJ+O4yEUf2bUz6b9ukZf6Hnbh+CRrIPaPhXP3yYgm8qGl3zYvKA8kmPbXv3C0ZYgI
	pkSLtZlv1wexV/OH6cu0oeb7bUlsJER68IuOOwT+cqNVdLcBsizylDrFPYtqaIeh+PTCXEDrMQ=
	=
X-Google-Smtp-Source: AGHT+IGphiYX9yy9vqSy5vgpD7h+lkSFIztYChgp7ux/RvE6ggnd/svuGRnDHeGWZqk5dNE4JJcfTg==
X-Received: by 2002:a05:620a:4091:b0:7c0:bca7:1a34 with SMTP id af79cd13be357-7c0bca71e02mr770969985a.23.1740067249836;
        Thu, 20 Feb 2025 08:00:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720670039bsm25311111cf.18.2025.02.20.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:00:49 -0800 (PST)
Date: Thu, 20 Feb 2025 11:00:47 -0500
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
Subject: Re: [PATCH v2 01/15] cxl: Modify address translation callback for
 generic use
Message-ID: <Z7dRrz9D22p3urfI@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-2-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:42PM +0100, Robert Richter wrote:
> The root decoder address translation callback could be reused for
> other decoders too. For generic use of the callback, change the
> function interface to use a decoder argument instead of the root
> decoder.
> 
> Note that a root decoder's HPA is equal to its SPA, but else it may be

slighlty better wording:
"but it may different for non-root decoders"

> different. Thus, change the name of the function type to
> cxl_to_hpa_fn.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


