Return-Path: <linux-kernel+bounces-515456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D50A36519
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CABA3AF226
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68782268C74;
	Fri, 14 Feb 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GRxRh52V"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18A2690E5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555917; cv=none; b=hhCkGJ9HBRqOv45FgmLG2TLiiYx7TbjAYKUTd+vuh91+ltCrG8YXkAE54GE7DDXJeXHgdcjh99OcrCLojKv3EqsXiroUJsOOEvQ2dnD4lOOP4LbAdtR7gnqgDFH3ig1OZIY6A416NONobdDaEHfpkDi3WiICduR4zlXIDCFJzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555917; c=relaxed/simple;
	bh=qpkKS4e8HItfRZYJWNtNUlb2dPtuv8zQncwy6wMk6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwoIkdJXTvzrBMYY+lIhf+53wMOjeEf7XdrdGjot2rCuhyk9Oy/LofiJgFRTFCjUKGVB9crV+NSWxxj8Cv3gXtjy6TC7GXb5z6dsZQmXGj4oV6jT0wgWXMdLXCTOrO8l7OSSU1oW1bgnkHa8ocGGu6p6lx8ByrEVuGSb+gZgAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GRxRh52V; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso40748846d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739555914; x=1740160714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpkKS4e8HItfRZYJWNtNUlb2dPtuv8zQncwy6wMk6vM=;
        b=GRxRh52VbE1LCA0bn0IU0fSDClyZNHSjH79i6LsW+As2+jiVMfja3hCdoXD3wIrQqr
         pIhmU/QjybgxXSOUKuOyfrCQ1DKq/7l5mmy2otRAdF2cBYLKjXe129iW6Rl20ViL8PaC
         yFK2PbRLAN8kQKsk3YM8LHAcWacyGYAlugQrPc+2H4TwHdbQM27zg056CtLBZQf3Q3oI
         4bRqj2+NtcVEyBJVAZnYrZkAZIxltPQS2YinSzGzne0KR5bKdBGQpVC7LWir634EUhTi
         HYi6PEQ3LwgAEqK89Kf426kh2hy3tBGUy5pzRHjJBehObA9FBvQ2oEpDM/07YLuOovRW
         UIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555914; x=1740160714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpkKS4e8HItfRZYJWNtNUlb2dPtuv8zQncwy6wMk6vM=;
        b=rTnSQTCLv7StG3SRkdR7M6WCVcaypERAYyO72O7d+i0JezYRWVDkm/ljwFsl3TkhLw
         3IukbijtGx4KNx2htDrDuG3cPUWZ1opGrmWnUZ0E76d8cwLFJt6Fzq1dJey0QVagxkAE
         ti6F9XB6bGOnHmH1eGPPeZ9EoB9QT4wdyi3kOjAlBxKNKDwA8hKKNt2bCCoEHjEZz3qN
         vpwlgr7N/wMYEjLOKiqUsab16TAQYS1jAR2D4Xs3JxyRdJ+lPxLdtu9omagJfOU6Vigs
         Kp6KeXe7MtfDoe4Xz1RUCC14mDGdjaLCYR3iGfOaFjXKPyDON4ZrNvtfssnh6Cx8F2MG
         vKCw==
X-Forwarded-Encrypted: i=1; AJvYcCXv1r7ayJgOu7/yvRwrqHnj56DMm+cpCpsy8uDBQJZh28fDmkv4+hIytpc7pBs5ILb2krBGXaBBf5Guxtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lsuBAZl8R7BUq5bWsI5dFX6ND54mwkT2QYCZc4gnyv67k+lf
	UbxYv2tBHo3YvrxaUKJCNJ4g5mcUR9cZC7nFo8KDprGsbSj5SLtl/F2Qhp5hslc=
X-Gm-Gg: ASbGncvjeD06qlr8XB+Mbb9Ide4u4uFbzH6YHm+Oq7+/X8AZUtby2qx+Cj05ZJt9gfs
	mbG11HhPGX8bicC72Io6HWWKZIV74oher94t4g7jO0FRhoWqkJMfVhaewn0J+IPOJ5FW654yjIG
	eNP7askvwWygpfOb/td1Pj/gWombr/g2kN1M1g34CuQ7FWHCzAlNZy0UJEXtz7RJtU9Q83x6QL+
	A0R6C7wD3sMVAFQtVGfyTW5HSU6nyj3yy9fF25SLFb3jk28cSXbAjZn/XG4I9XZ3GMc/UEeak0V
	05WN5FMO8JfWp0FTBqO9/RTsTeeNG69+gGIjJWk0wQA9mwxnQ56J1+q/sqA0cgSs
X-Google-Smtp-Source: AGHT+IFQXyA1QsywBm27eP/YuJP0NIYkqtqnAWu3j0y7rUPGIIJHkpKTgTdEVUvYQ9T8YBfH/i2P2A==
X-Received: by 2002:a05:6214:5085:b0:6e4:4484:f358 with SMTP id 6a1803df08f44-6e66cd0b70fmr2403576d6.33.1739555914298;
        Fri, 14 Feb 2025 09:58:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c29e9261sm20091841cf.5.2025.02.14.09.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:58:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tizxR-0000000GliU-0b2Z;
	Fri, 14 Feb 2025 13:58:33 -0400
Date: Fri, 14 Feb 2025 13:58:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
	mitchell.augustin@canonical.com, clg@redhat.com
Subject: Re: [PATCH 1/5] vfio/type1: Catch zero from pin_user_pages_remote()
Message-ID: <20250214175833.GB3696814@ziepe.ca>
References: <20250205231728.2527186-1-alex.williamson@redhat.com>
 <20250205231728.2527186-2-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205231728.2527186-2-alex.williamson@redhat.com>

On Wed, Feb 05, 2025 at 04:17:17PM -0700, Alex Williamson wrote:
> pin_user_pages_remote() can currently return zero for invalid args

It is so weird that it still does that, I tried to get rid of most of
those but didn't dare touch that..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

