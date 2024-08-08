Return-Path: <linux-kernel+bounces-280117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3294C604
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D217288A68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1615A842;
	Thu,  8 Aug 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cEz1hUR5"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F11494CF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150512; cv=none; b=CQyzVwCgjd1i+FdGay3AEqtKIkn0Or2BW50oaaNItADPjScybU/Q80x5uV4pgktTw54sKPcltKO7nH3+dic4Wgnr71+Yn90v5S83iwYOBwLfOTbtcXKniuqGMprW5bowg7hSHIRxZAuTYtdKK8cVlWdk3H3KfAIMfeaAOz8Tkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150512; c=relaxed/simple;
	bh=alL33QDUMO3Gtu8T02QKWb6GAI04j9PGhdR9ysqgNsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih2pa6VnezCACC0UYeyW1dY8PTL6Grl3EqXCpXXfFDpw1Mu0k1bmYNiXaY2YHAP2u5XbYNJvBVi7DAkWmrISADTO6jSfzLFp8cYmN+Wxoo6+/MyZdCQCNE06jDJrwY3qftrOPzierGdNbMVIlTa0dE+A1SQjwriJx8S5SwLA6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cEz1hUR5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d6f4714bso114202985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723150510; x=1723755310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vfljrX8OmsTedNdC+viOpTYZfWEYyL9LY8J596dK+A=;
        b=cEz1hUR5kFRVOr105l/RNP9jFs+jMoa1jkJpan9cXSuj/mNOZJpsKQIJSj+SFTgWCI
         sdXQgwB2Ou7we0vC32Tl9YSyWkG4KaRzC9hCjVO6ftQBGGZOvIHrx3F8zlaSOhZwCp7F
         Pn4wDNm1Tlvp7OZKMBZAU5A+uR75WDaWWw44O+KS//e0VzlorMIhmbouWnDX2bjazq0e
         tJvvTqybsLpQj/vqRbYbs1wx+dzprgfnq6fdD1F1C7zhMikBt0ISuDdlZAenU92Q1koH
         w7fr238EG9GALDxiPyPJGJUdpPcgGnpcpOQHUpm7LfzwO4PsScC/zrjWSY7GI51LHy5X
         4Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150510; x=1723755310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vfljrX8OmsTedNdC+viOpTYZfWEYyL9LY8J596dK+A=;
        b=s0H4OhEVD6khfiwhEnRrQDMvqEnwk8I8K3qwgwEzs87RZ31BWTTzhJyq3Cdv06UVKH
         6aT2lM63Gic4+HypaPTLrrwwD8oVD5FkEJgnV/DpO2kydrGCHFQMxGI2ppblrZd6q1Lf
         xseqDTak75P/NUv06hmGhCYiXZk1CyEWO1929o6Db7xaBnoxpS14L0xAbT26l4gh/V1A
         ZNmK8nTZK3HXxMe3ZglNO4NUuzVtECqybhfCiimdIiUy3j7DjbswvAdh/T6D6EWJpssZ
         J/pq7jbwSzC2AEThTg2RlDOoCqff01uRLefyaHkQQBh8XTHtr2PHmm5upHtD0zO3w6LV
         zmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFS6vqmV9in17NIRU3HG3a7ghsJBnfeKP3YzcuInk7Qh5CDMpQY9o3zmrDvPKpZFYxB2qcM6U/LiUgUf1JgXJE9HgTK97lDga3407F
X-Gm-Message-State: AOJu0Yz7G96DYBKfL0cYvvtf02di2Ofsezg9znsTDltjD43i5BbANCVX
	/rCov3MvyUgnTYhzFUiYBxzDmNexKpCmgTwnWliWwBUIO1Ekq+ZwvxEk761e/B1PXSIMS71vrRK
	U
X-Google-Smtp-Source: AGHT+IGSVfRGUHjK+gji8OfdSpSNjQG5FHFefm5SGanJdS1BEqCoewLuJZ9fedevfAj2h75Keaw3Ew==
X-Received: by 2002:a05:620a:44c3:b0:7a1:e2d7:fc98 with SMTP id af79cd13be357-7a382476346mr641259985a.11.1723150509891;
        Thu, 08 Aug 2024 13:55:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f4301sm194991485a.69.2024.08.08.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:55:09 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:55:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: only read fops once in fops_get/put
Message-ID: <20240808205508.GC625513@perftesting>
References: <20240808155429.1080545-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808155429.1080545-1-mjguzik@gmail.com>

On Thu, Aug 08, 2024 at 05:54:28PM +0200, Mateusz Guzik wrote:
> The compiler emits 2 access in fops_get(), put is patched to maintain some
> consistency.
> 
> This makes do_dentry_open() go down from 1177 to 1154 bytes.
> 
> This popped up due to false-sharing where loads from inode->i_fop end up
> bouncing a cacheline on parallel open. While this is going to be fixed,
> the spurious load does not need to be there.
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

