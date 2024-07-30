Return-Path: <linux-kernel+bounces-268259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D3942247
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BD9286C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9918E046;
	Tue, 30 Jul 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meJr5J5t"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5A18E030
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722375406; cv=none; b=d0vL/rq+aglx9J5NdrleIvgf48oWdXRbMY/zD9sQzPj6vTc7N2pJhXVXyPDo2a+j9rPw4rAOiI91sWtCR5bLTIL/5QQuHsZEpo9gX4/prVFvsVJKqEy+dYiMNXHQ0q38CNrcaVO6sMIWshV6R+qHApetgG3HKmXanmD/W93YShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722375406; c=relaxed/simple;
	bh=hbXVWVMc+U/vPnGw30EF4lr9xbqKWtMfbmledmU8bOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz3Ek9VFC67F25MHVY/AB2E9fW6cXZgTiKx/rLq1k1E9fl1J2bcu5LGNoM4X2EMc5aS436hoAoMyHNK7KMihlrRW5cWsGtT+UYLFau4JWDSYPtZn8XYe10QNxu9FWnhFlrsY5hYBgiBscY425bxzOQnLLKGCOwQFszH5EGBznaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meJr5J5t; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-75a6c290528so3341283a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722375404; x=1722980204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9hSnC4frMwnvg6eHXjtVZhj/XkM6NEo2dL87KVmYyg=;
        b=meJr5J5tM5O1dvvJAdzhC+lnJ+krvt4d0KmJQ4m3/djpvwu68warEXyDTqzscwwpQ2
         BT8qAoPxunWOt2PLL2gFGHWPmIAt24pBp4YBLfnr+dTbcUVkkXH93DbQSlKDUJpUa/kI
         hRHcGbdS5YOmF8PzR+wqJYbuS7zu9ZaLqEt59tFODRiKdVV0Elz/bYrLPg+rYTcmPBlH
         E1YWkNnBATkxV9DlCp/s1Po7Cnwqmr/oyFM+1oXpgU+L6ajmKcUoFav1pBBCZay83x5j
         AmwSD9BIpulqg0g610uHE7IWArYlXHvi3YpPLXswr0b2zON55zlEDD2aug+s+J6B0Hnb
         Kbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722375404; x=1722980204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9hSnC4frMwnvg6eHXjtVZhj/XkM6NEo2dL87KVmYyg=;
        b=IU3m9Fm1Oe6+avlPiJMRb3kzqeD7m4fKQ86nP5dSpml4O3Hq0mgAbpXYoPixAbQeB4
         IdlD+cqt1sydmzRHcyVeeGkXYGe2wOxgC2pgYQtk0rgUqJDzS7UqNXJkZddZlRysX6vQ
         6cHo6BkD+tSpEqeHK3k/EVI40Xv9P/9SSD274BVv1r+o+fHMRZ5L6IriPYcIeNFxIy10
         uZLkDwCiYLImDeTrHZLtsjmu0Ie9f14DwbZejthb12pTxgIOPydqWgyRJSnJzWDg3rHe
         cSNF32s2vYZ3y5OalM+mUc5dwn+f0DC0dDIigwn8jZ5eG/iw5gX3M07EdC6nvWX9AwZs
         ArRQ==
X-Gm-Message-State: AOJu0YwSw8S1V7iefa1PwOaVd//6Rs3sa/9/MFc+8PsUJJLvn8VrZaNn
	NXVXqf2WtWCaUZiaZ2S6rJNS5OEQIeI4MEewj1glV6xrKw5pK7Ow
X-Google-Smtp-Source: AGHT+IGb8sE9/P0O1TAc2ItI3WxiepL0LrSNzyqchjkNZb+iE+QcAsw82U6hXq4Z/S0Bm4dy5dXPuw==
X-Received: by 2002:a17:90b:388a:b0:2c9:679d:78a7 with SMTP id 98e67ed59e1d1-2cf7e2073b5mr10918006a91.25.1722375403674;
        Tue, 30 Jul 2024 14:36:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e43df5sm11118409a91.55.2024.07.30.14.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:36:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 11:36:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Fix UBSAN 'subtraction overflow' error in
 shift_and_mask()
Message-ID: <Zqlc6V0ZE6u9IgOu@slm.duckdns.org>
References: <20240730114431.1119-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730114431.1119-1-will@kernel.org>

On Tue, Jul 30, 2024 at 12:44:31PM +0100, Will Deacon wrote:
...
> This is due to shift_and_mask() using a signed immediate to construct
> the mask and being called with a shift of 31 (WORK_OFFQ_POOL_SHIFT) so
> that it ends up decrementing from INT_MIN.
> 
> Use an unsigned constant '1U' to generate the mask in shift_and_mask().
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Fixes: 1211f3b21c2a ("workqueue: Preserve OFFQ bits in cancel[_sync] paths")
> Signed-off-by: Will Deacon <will@kernel.org>

Applied to wq/for-6.11-fixes.

Thanks.

-- 
tejun

