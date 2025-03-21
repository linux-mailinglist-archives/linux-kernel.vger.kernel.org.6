Return-Path: <linux-kernel+bounces-571390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CADBA6BC96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4780E18915AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD513635C;
	Fri, 21 Mar 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Bn1/FXCL"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED7288BA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566158; cv=none; b=P5yw2Q0jAelitEYl+yXpBAlchdagA8MSQbfpUbzuKyjwnDuu24Ud1iEX+NrCh+nO4eEtRKl2FpkDMUb1tqhzBfosGGke83lgegPvuxMFIj3qBw13ThwZb8deKb1kK9bj3Ue6H2L3i7dCGJ/8zN7jhFaJMJBoEtB4t+0i8McDFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566158; c=relaxed/simple;
	bh=CZKwgwIIXJK5jYXBnZ/QYDErx6q9q+UM57HllJCNgIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmGA7d+XYs/AFUCIhWjo1Fz+Fl5bfi3GaMngp9Nol6Sk+MHfPckI0HS70IEQciLyipiC64GypGALAWn7FZqldHA5JpKwqJluFgvOImXu0GDX4cddD+VHm9WgQ+n/Wq9fDKbUK2g5yOA+hhK25f4u//XRLpeOsRbKEAf0nNTkREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Bn1/FXCL; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c53b9d66fdso267652785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742566155; x=1743170955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+nhgTbLeJKhDFnNTQysneSWHNY3+PqAlhMu5LglW/M=;
        b=Bn1/FXCLuTYk901fwQCPcEGDnJRDDlsRs35vV9xZqVfW5csR8bjZA0iyqeLGBfWNa8
         Tu9iDR0B0ymso4BDupJKSUpb/LzcqX2Yd5dE0UUrpusvkZrSmI7ndPX3H89cf3nFaMOZ
         cpZP+Hc7BQDhiliD6O9HJiIQihtvjA8Bzy5pnwOlVgV63B8TA35UVKVhLWjGqEc/8BVq
         EQL2yGbBphWGh3PliDxquMmGdMZLeLXNZDMx0kGN2Gt84IfYz0dtJkDm5GhZVcVtpr2K
         UyE9LwUIfYaVe3dpZdSGvdS31EnPre8nltUYvNeYmdVz9VTvqRuRo/C2C1r+8Eh0e48H
         KuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566155; x=1743170955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+nhgTbLeJKhDFnNTQysneSWHNY3+PqAlhMu5LglW/M=;
        b=oBdBAN1mgyDtCW+Dmlzo8+NpPMCWE1rEV2S7Q+3L4bF1gMrTs2n8N1ZTL7FnS/p/eC
         Y+4cRqrEVnA3g9PcIPj1fC60vl79KHGk5wHdxZd5DhPxVVa9COj9zOR+aOVsZIezmpuV
         c94UUiGAAhGDCTL8/TXp7ekyMce7dIKKYY4pv4ceachCzEsN7aPsqFvioVKnXCSRaiJ8
         h8nVp8cWl+uqvS8Qnu5A/23WyfTURXETQPuIyA44guUnMtCHPstdxfeCNeqsa6Yoem1s
         krCL9lErV/R4JnWo1gbKZ+7PIWTBCPmgafdycUYrJWqa++/dadcbdqEeKZFS6n1ifMh4
         scIw==
X-Forwarded-Encrypted: i=1; AJvYcCXA0VaLxMpGyYzp3I8b+ihW5fk6cAcTogCeyMxfj1TYmg94mTvFZIpk8SCW+gBLJzxpcMLDtlMs2/MIrI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qw7RifAnE07Ea8rfaCW+jq9xnF/2Fy9esP67uIOmCKnN/9Vy
	mFGCFWhy4dkcw9KVK75AuysZQm+1M608s2leDOscPCzfepnMmDYPdGocQoWrq0c=
X-Gm-Gg: ASbGnctUW40+TsOVy+eVX9xZ3wZF3XCYan0gb5smfCOMdAVmO/DM2RU9D0EzYvoNno1
	COU4jCqkDaO8FRUHSux7aBZA9EEW58SkIhAep4Y5XGoeNzJj3v3/HdLkyRzEVL1r8RpyAMn4eBE
	uEzHSXI/yNr9YiT79TzWSuGFGymdSITFmTG4eH56zUNV1C0B+t9UzTdoZqBGcGzKYPgcXx/8XRJ
	tOqHN/XCeraYmxKwy2QVuYfc9VaukhD4x08D4jX2aWi9Mfckw2AcPqsKZwsbYlRlEH81kCjzooR
	8Kt9ZjkTM4jw09dUP9pQ70yvCV/RgRrXwIuRrTWy1JUFSaGgDaQZEfIvD1u3oBdhOETHioNIZfT
	BUFb/1ocoyruBArxLcCGWWRzfc5E=
X-Google-Smtp-Source: AGHT+IHYL5PtE1l5A53doJXJiyZ0pMLxq3g63BRJBYsQxz2bFKxwUqG2PxozWwwqOpZAZvNY+68OCw==
X-Received: by 2002:a05:620a:2727:b0:7c5:3c0a:ab77 with SMTP id af79cd13be357-7c5ba1337f0mr490684885a.4.1742566155122;
        Fri, 21 Mar 2025 07:09:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93484d7sm134529085a.81.2025.03.21.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:09:14 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:09:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 2/3] mm/mempolicy: Support dynamic sysfs updates for
 weighted interleave
Message-ID: <Z91zCELAdts-l3Zp@gourry-fedora-PF4VCD3F>
References: <20250320041749.881-1-rakie.kim@sk.com>
 <20250320041749.881-3-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320041749.881-3-rakie.kim@sk.com>

On Thu, Mar 20, 2025 at 01:17:47PM +0900, Rakie Kim wrote:
> Previously, the weighted interleave sysfs structure was statically
> managed, preventing dynamic updates when nodes were added or removed.
> 
> This patch restructures the weighted interleave sysfs to support
> dynamic insertion and deletion. The sysfs that was part of
> the 'weighted_interleave_group' is now globally accessible,
> allowing external access to that sysfs.
> 
> With this change, sysfs management for weighted interleave is
> more flexible, supporting hotplug events and runtime updates
> more effectively.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

1 nit

> ---
>  mm/mempolicy.c | 70 ++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5950d5d5b85e..6c8843114afd 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3388,6 +3388,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct sysfs_wi_group {
> +	struct kobject wi_kobj;
> +	struct iw_node_attr *nattrs[];
> +};
> +
> +static struct sysfs_wi_group *sgrp;
> +

sgrp -> wi_group?  Or something similar, sgrp is not very descriptive
for a global.

~Gregory

