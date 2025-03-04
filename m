Return-Path: <linux-kernel+bounces-543056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9CA4D10A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430DF3AF0DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8E148838;
	Tue,  4 Mar 2025 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XdbBZg+I"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BE7603F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051977; cv=none; b=o/wq7F8scXLnTErgkgPLk+JVZenCkgV/0WFokkKiLjXV9Fm446HdVpMXS81Bn9wD5jCK+aHN3/c8EpY9uHpvgg5UaMc12RvFUFVj+XARpbQhOQrqU4+N5y/yo3Z7xIuVnzivAB5xxcxxo8veRhwDRhltity/jhDYXTVfMB8DaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051977; c=relaxed/simple;
	bh=v5/bYUBFt7ixahljwJAw2cD9ksUIJ1iHD9P7j1AbFLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsI/WJbbl0dyEn2Hn7YbuagIAdTsaQRjACBG57xOc21G1EZ5AuF+C64xz0e67WK5PJVsSLbjJkYOtOG363+LWiWYo4Qr/ptoxpYcQYFfF+DFRPGY0xpO18tpFhlEzvYH1jwqUMbSSqq6wB412DvaOXQ43DFYKqvlfiA8aM7ZiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XdbBZg+I; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0ba9825e9so369809185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 17:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741051972; x=1741656772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6xB6tZBkxBseJmMvpYQ2Hhx7HYfm01hEgI0/OHSmWI=;
        b=XdbBZg+I9bH7LQ2/qdjfVbSKeONUcg9+3Ft3PtqlqqIQzNPuRpi4vT2heztO9Dt9Lj
         v28fVEua0ENpzt+WOc/SIzO4GHA27iQZxgFsUk1Zt/Qf4CLuXZ18j0u7kq+AE+RcXuu1
         802V3MDWGbsQDe4Wja6bDtSJVfEkO6JakM7/60q2St0OF7drApZi+K1tXifkM5qPRUvD
         WJ91383hb1Z++nMsh6FKjmdBeS1QfA47FmkVrh0eYVeP50FjBsVRaVGk/+4RV3x6ivM4
         iXANkEKovhG0ZIOZPjtJrcDkALepTt2MBGff3N3bFosVoAcS29vwKqQrGlspRelpY+Q/
         9amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741051972; x=1741656772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6xB6tZBkxBseJmMvpYQ2Hhx7HYfm01hEgI0/OHSmWI=;
        b=ILXKBEJkFW3lCRg92lQheRhp1gCLeWyeWp+e9+g9H2XylcGWFl384MoL3sqIOy5s/5
         mdo7dOdqFPcAnhvREeDLSJ+E5GtvLgIwng8N66XLlbBl6F6NqRsZLoGdXboafxD1tuNQ
         obAaCQuB5JrjUmYdcRYSgac/mIPZzeI8nlaY04VfrWOwzGxDpOd2BsX8sADPgSFkmYke
         d49MueP2FVeT0vn780cq0tPt4SCbdo7bdkTBB2l0aLIGqP/FB5eT843Jgj1wuyZJtUdQ
         OzB+RMh2snOClj8zlM6AXY0smx7iqEXbATH5HMyXG9FuxU84IjRMmeneDEQNJB7BikUX
         rgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvvk1cmBDve3JWPkWi+n0StmUGEx/o2ztn0XEK9lfyildfO5JJ9fmb+o+pgS3DqXNQxgRIgYmvkoOVSHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvVIKQLb6IimZ86UOKDkONlKIaDO3Sn9dU8INLzbhsie6Kz8A
	D3WW7Jg/Fb4OjcrrfdjIHddc5fuvANIF+h4Q9TRZ7pW9r2GBdB0ZoMBcg3MVUas=
X-Gm-Gg: ASbGncsCzwaFWTFyJqkKUjH2W8ujiRkSUdBRY2Zgn2D/1zm1ms8IoEkPxtb/9AYJ1QR
	VX5BTZf3fOe/Zg3eiNmmjsh5Q7P9LMRnj4lU+2fWBkdj3usYRZDlpQzisZqgE4oFrK2pJHtMhhk
	bIsAPgbeaJPbaX0FKoCmSspTiq5PmoqHQyRK1GbD7zg34U185Jf6hwPHub/3LEyzrfCorSDmLVB
	A/nhvWtFC6Uqt7hOQ+hvcChSp6SwWXH7Zs9QoVj9FEXc1qks9Ct4J/7D7wMxZ+ZAH2Y8pxsnmJ+
	du+lmurZq3zZHRv8IJePoRzvWeFZa1E6jCUAzcAwFhByc9xEhK1iwq0qwwbO+LTnAt5/T/wfrKc
	2KZvdIFP+edWzSoWXSpP2ICbJ2AQ=
X-Google-Smtp-Source: AGHT+IG4dWln+CNbJieutk1fOc0kWi4nxKmsaP4G3WEAip9vevv4K/TkpbAdj3Eb+EfbBCSu65rNPQ==
X-Received: by 2002:a05:620a:4492:b0:7c0:9f12:2b7e with SMTP id af79cd13be357-7c39c49fa6emr2001696785a.11.1741051972460;
        Mon, 03 Mar 2025 17:32:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b7366e26sm231363985a.87.2025.03.03.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 17:32:52 -0800 (PST)
Date: Mon, 3 Mar 2025 20:32:50 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 2: The Drivers
Message-ID: <Z8ZYQqm_UxDDphSf@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>

On Wed, Feb 05, 2025 at 11:06:08AM -0500, Gregory Price wrote:
> ---------------------------------------------------------
> Second bit of nuanced complexity: Memory Block Alignment.
> ---------------------------------------------------------
> In section 1, we introduced CEDT / CFMW and how they map to iomem
> resources.  In this section we discussed out we surface memory blocks
> to the kernel allocators.
> 
> However, at no time did platform, arch code, and driver communicate
> about the expected size of a memory block. In most cases, the size
> of a memory block is defined by the architecture - unaware of CXL.
> 
> On x86, for example, the heuristic for memory block size is:
>    1) user boot-arg value
>    2) Maximize size (up to 2GB) if operating on bare metal
>    3) Use smallest value that aligns with the end of memory
> 
> The problem is that [SOFT RESERVED] memory is not considered in the
> alignment calculation - and not all [SOFT RESERVED] memory *should*
> be considered for alignment.
> 
> In the case of our working example (real system, btw):
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>    Window base address : 000000C050000000
>            Window size : 0000003CA0000000
> 
> The base is 256MB aligned (the minimum for the CXL Spec), and the
> window size is 512MB.  This results in a loss of almost a full memory
> block worth of memory (~1280MB on the front, and ~512MB on the back).
> 
> This is a loss of ~0.7% of capacity (1.5GB) for that region (121.25GB).
> 

Some additional nuance adding here: Dynamic Capacity Devices will also
have problems with this issue unless the fabric manager is aware of the
host memory block size configuration.

Variable sized or sparse memory blocks may be possible in the future,
but as of today they are not.

~Gregory

