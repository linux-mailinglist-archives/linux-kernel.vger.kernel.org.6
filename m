Return-Path: <linux-kernel+bounces-417423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC019D53DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AD01F22C85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856C1DA0FE;
	Thu, 21 Nov 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lXmURCcR"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2E1CB9F4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220286; cv=none; b=NyL9nsfhao0dpjqu735pDH+WUN9jYYhZw/L4zzWmCHe84AgEBORMFGRjJ2EenMfQisMjpxTKj/YpNPBmuSIooXrQYmnWkyuoQniAdAjn0neM2IDfJBxiqz6Olo3H0nZ8KKL//JQJ9rJfq/l/LX6sQpWd6VMzlOiiwC5H1arQBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220286; c=relaxed/simple;
	bh=PoQ6xe9gEBhTT4I8U11K3X6ngcSjvsKe9RH1AZSUE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g75UJ6hO6PjVqOjoaqR4cKXNeL9uUaPql++YS/bnHCiQ7J2T1cqMfzVis+4pKQZ5+vvV+Ib0TQnjGapGXTpWmuKnej3TimI/ACwg8fa1rIQ6oxW61aITdZTRtnFh/wh2maJjh/ejaJz17tO74gXjqP6Z0kkV5L0oTDMNyoVxDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lXmURCcR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382442b7d9aso1142636f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1732220283; x=1732825083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2mZwNr3eW1Z9Vp+PcgzzHwsSK7NqM3DGZ9Ok0Kn/lA=;
        b=lXmURCcR2y2JM11ebEG56j0PKzDY/qy+47ocVFpemLSlClkU1wTpZwLL/QhhLPyW3s
         iF9Jsy6KQ+oxhvR8qRApsLH9BZhYuBrwPyfpf3YbRgcHt4ris8boO3EV5a3OzwR0hHu6
         GaATFgXOi3cHSpHOnsafal4zQvELNEmOZHVFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220283; x=1732825083;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2mZwNr3eW1Z9Vp+PcgzzHwsSK7NqM3DGZ9Ok0Kn/lA=;
        b=YWehoM6DONlJV45bmStOIU2rDeqST6VBscqXcXtOBserChNDDB3ptr8VDWUxkMbbvc
         EBQRfghHkHL7JmBTjS4n4M1buoQuoorcD4tIQnddB9KRGNcSwQKJpl0f1euUpXB0I5ix
         8jPkk9qFqwSvghT86wxhGIiW+wV+sRvgWCgl4Z5QUa29RdeNv9aoJdrvZyLDTpjdvL+l
         1vKAUH8BVf815raYTJG1NoC/5Lsiu689CsaTFQJPmvDQy8asWYRSBLKHcsDUGI2hiNoK
         K3wEotWcIwWVmvRiOs9/oO4jyrhkDBgdKM76tNG7KS0tOxVDJROfqiy22TIaF4koq5Iw
         wpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa6D2UtA1B14X1KWJlhd29jl57ZvXtAJUAWZ9sT9rus/CGsEQFS77CjrGDIcgeB43BZ/pqDl0azQRnahQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJ+2HDmHbO6RBCb8APqcBqgUcHIcwotcAInPVQUws4nib2jHo
	nT5DSTfK6QcjvUpXM4NV4R7egsDgMaTxr8knehGKJl3OQgfhUzEJjyklIz2ZxBk=
X-Gm-Gg: ASbGnctBvmO8hwtSs15cVOg25dipQC0BLPWZykQc1bd3T4M+J2TQkjuSpKBzuudGbut
	1uqPfLdLTVGlQ2dq/x4LNn9KySlWTY+Mbn9j/pVIGq2PJ3udDPjwe4U0KAC/lQuX8ZzENHCeJSP
	QAgYFq+oq/buwf81mNrmh6KbiUasCA4ocTUZtRr4PEBuHn6+NX/ew2RZvxPYX+Y+hPhI9NCjNqX
	Y5Z0JyCBwsOObDSbZBwx3KxzaZ7wZ0xw1A9BG3e7JQvlxdryJku8aBkfsKWiw==
X-Google-Smtp-Source: AGHT+IFIAEZgwOdLKe2aLVeTOHcS+P2fVWqmTMpDKu9ZFOYWSBuKw3u5Or2kbjFemduSGbeJqRdGPA==
X-Received: by 2002:adf:e18c:0:b0:382:5aae:87ac with SMTP id ffacd0b85a97d-38260b8966dmr360789f8f.32.1732220282992;
        Thu, 21 Nov 2024 12:18:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb271ffsm455908f8f.53.2024.11.21.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:18:02 -0800 (PST)
Date: Thu, 21 Nov 2024 21:17:59 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>,
	Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zz-VdwLPBUV9d_Sj@phenom.ffwll.local>
Mail-Followup-To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
References: <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Wed, Nov 20, 2024 at 05:39:09PM -0500, Kent Overstreet wrote:
> There were concerns raised in the recent CoC enforcement thread, by
> someone with experience in such matters, that your aproach seemed
> extremeely heavy handed and I find myself in 100% agreement.

Ehrm ...

Yes, I did quite strongly criticize the new coc enforcement process.

No, you would not appreciate what I'd do instead, not at all.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

