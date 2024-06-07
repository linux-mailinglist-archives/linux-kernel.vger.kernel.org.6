Return-Path: <linux-kernel+bounces-205550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248A8FFD5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BD51C22053
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B154156C52;
	Fri,  7 Jun 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dz7rD2+H"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433DE156978
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746130; cv=none; b=MNCL5lrGoG2uAsi3iNlsOrChK/qggL5K2EycTcmUZ0KIrYxmyXb2d740PjvYpjNzm8uHGt5NKfhKxnSr4/tscvb4KyWMvxd13NAr1pDENawv8xEHG86whsO74DdbINdcZLp0/h+LKmzaaB0OcwsdtCRecrJYxLQVarXjN9XwVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746130; c=relaxed/simple;
	bh=u+XcyhkXHgzuuGA4BJmpKvhX7+okEQ+D0gQbMGy0WRw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkTo1/JWR23SgUHe9duV0RPPm0dm9C4HqAFxOZE+4InJkCuzaiIXC83kJ/0/zn7DWkI4RNT76v6mU7td4xTabERnnnLzkByYtJCqnZk7npSqqV6KA0ylJ7txK3E1G9+5XAEXedqc9AwGKZtV9De0mdlzKs4I6P6lg1vS0CT4KhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dz7rD2+H; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421727f4e4aso875615e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717746126; x=1718350926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wITECR6vYaIP6jyiFKUOvc/9eKV7eRvDEEZ7dhmICro=;
        b=Dz7rD2+HHFNRncSlOGKe2vjT6BIs5L2dJH89w4ILhgbdHPL17PC2PLOyuzvXi8nCAP
         LbewPsAtwwnHTZ+NCpz8v0r19c8ZoxJFAJfl6DY4d7SbKLj6uXVMCxyXhmb/0tfFR5E3
         g2YbUGVkXIxRCeCFFVBNfDDddPelmgJqOKXMBx442Z6blBa7GiiP33mFeKWGSMvbDrkM
         4rBFy6hwboNPnwiSPi/QHX1thRVpjMhw9qYctJXCyYzxEkKy6uIaGOc2FnnhDl8E1rCW
         mJxQGbWBUrIf84sM13yQyl20LqC0pzY2VRdxtPt1CZWMzPoZbtO6Fwdq7uWeffNPg+Fk
         ObNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717746126; x=1718350926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wITECR6vYaIP6jyiFKUOvc/9eKV7eRvDEEZ7dhmICro=;
        b=G5p757V4rRUaqQKMwWmh9ikF/wmF2h4cAOon5y7wR5d0Dfk1/F27bnFPzjdYWBpQKf
         TX4/PWYj4TX6U/z+dpXR6klQkINS0InGDtIfGdsPGlaMWAWQA8YELBrVzh0EG7KJprxB
         DNPt1aIjFFPS7BrrV06Qa/cbUSQeStVtn//ImkZ9SOkRkiTSwQDrrKIV7mmuY6R9QjCg
         sT27VWvB54QBPTEn9rf2kq4AUEl0y+p61XJmfDLr/A+ZsvgZ++IW3h7hfZJTAJOOYQuL
         Rs3v061Gs4GBFQAVHqs9qvhS9/fIe4AFMVFOz6BYYV3WTAphpnG0Cq9Ify9kSjrhE58d
         o5+w==
X-Forwarded-Encrypted: i=1; AJvYcCWr/OBjso+alDzGInka0NJyGfSi8Kwt9HnM8v4Tjr9Y2u0EK30UQMr5/23k8biviQLuElhVAdO8kwXgjfcc4Q37LUUUjr6eLzDbUtMp
X-Gm-Message-State: AOJu0YwpG5AUx0oJIkmKSF3LQQM9ThH2+FYtZpPqucp4DMAUVUvg62Z8
	+sEvtZDgjWhTiB3+vGHELjUWZstG9SjfOoAG5+0N1MLjbkk32ukuiXgskdFUHX0=
X-Google-Smtp-Source: AGHT+IGEGrYrNCpMyH+l5I3g+OTZ7h0Gl/uiF7UhTMeVBlXXIwCceP2HiECTjY1R2oJ5tRecdppfwQ==
X-Received: by 2002:a5d:6d06:0:b0:357:b063:183c with SMTP id ffacd0b85a97d-35efed08c92mr1744256f8f.5.1717746126636;
        Fri, 07 Jun 2024 00:42:06 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d47debsm3370095f8f.27.2024.06.07.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 00:42:06 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Fri, 7 Jun 2024 09:42:04 +0200
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 0/3] mm/hugetlb_cgroup: rework on cftypes
Message-ID: <ZmK5zF-2NYao9w31@localhost.localdomain>
References: <20240605070133.1941677-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605070133.1941677-1-xiujianfeng@huawei.com>

On Wed, Jun 05, 2024 at 07:01:30AM +0000, Xiu Jianfeng wrote:
> Hi,
> 
> This patchset provides an intuitive view of the control files through
> static templates of cftypes, improve the readability of the code.

Just dropping by to say that I plan to have a look into this today/tomorrow.


-- 
Oscar Salvador
SUSE Labs

