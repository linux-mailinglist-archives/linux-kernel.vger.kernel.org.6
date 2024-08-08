Return-Path: <linux-kernel+bounces-279238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88994BAD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83956B21E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F57189F5B;
	Thu,  8 Aug 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="bwX2TJ89"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE9188CB4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112715; cv=pass; b=YEK1UNXsRSoUBc7OINmn4cfrPQ9XdPsQfJCwcAL5x2UKo5QuxXLdmoPdoW3SzSWKhZ8FZ/EyeZ3VE7GyB3GPpHlTAL8Qh5cdTI21n/EuXU3QzUDYBLJVzo9aTamkDMUYEt5EhaLzJ4LRzsXX8ochU+Wn+VoIQVt7TtfkH1gFYRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112715; c=relaxed/simple;
	bh=eya6lTRvJyfi+sIyUeyXEIzd8EhakCMdIWAEW3ETkHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq8QC1xsycHcHvJERNPlLiWly+MVO8BlmjzgUbawZo3cn/prpjW5Uu577u7fim8xWxwcMxMIb6sHlggqC80WHuGUum24CCmqiHXXLGsZycEG++zTSqRtvpWltLpejFeUbgfRZOYow5EFZD5o2XkyziedUWwjDVyHHoiefnB8pIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=bwX2TJ89; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723112698; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AX4MtLArGT0YeizEE6ap3foXEGRAPG3kfQbEjH8W4mcsotf+wbaCyY4c62g0hG9QinqAJx6ijasUiCzinCxs43yKtUAnNDfwONgK48G28xY7+whW+DaYn2uBaMaBMXhQ+YUp+l0RerDKcQtH0urFkxIPGpC1Y3HPxjoMqC7FB5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723112698; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6VuuDzgz6Oct6fAZTlg1PnvNSVOVV/qd+NnU7AJAABk=; 
	b=VoU5kGyoSkqZFYRhF4DlqWLwstp2xwbDK2V2E//g6pTlkeBiEbaBV1FSN1tYtmGd8P63Nv3Sl/FtRhS8oPvR/xM3MjIKoRL9pQJp5hILkErTbRUCQZD4dGnMwdjaiT4x8T/Jq7lCLfXRQ9Ss/WtNqUeYhudSzUaMVv2fVF7E6ks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723112698;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=6VuuDzgz6Oct6fAZTlg1PnvNSVOVV/qd+NnU7AJAABk=;
	b=bwX2TJ89PzTIFNb6xM9L9DMZ4AkRqOA5ehMjsQG3VKC9YpdOG20lQYvoNYAdOQY3
	w6nyLbOW6vPf7ElJp4p3fHnm8+Kd0sfHEok/XUHHq8jQh3UIYthLIagyU6OZplpMn3R
	6o1IB2lanJCdP72lAOEWmHx7GfVxq+o7Ua/zyHgs=
Received: by mx.zohomail.com with SMTPS id 1723112696563524.6318540213172;
	Thu, 8 Aug 2024 03:24:56 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:24:51 +0200
From: Mary Guillemard <mary.guillemard@collabora.com>
To: Mihail Atanassov <mihail.atanassov@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	kernel@collabora.com, Christopher Healy <healych@amazon.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	nd@arm.com
Subject: Re: [PATCH] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Message-ID: <ZrSc87IA0U9WPNYW@kuroko.kudu-justice.ts.net>
References: <20240807153553.142325-2-mary.guillemard@collabora.com>
 <327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
X-ZohoMailClient: External

> As it stands, this query has nothing to do with the actual GPU so
> doesn't really belong here.
> 
> It'd be more valuable, and can maybe give better calibration results
> than querying the system timestamp separately in userspace, if you
> reported all of:
>  * the system timer value
>  * the system timer frequency
>  * the GPU timer value
>  * the GPU timer frequency (because it _could_ be different in some systems)
>  * the GPU timer offset

I see, I missed those registers... I will also fix this on my v2 of my Panfrost series.

From my understanding, the GPU timer frequency doesn't have a register
so I suppose it would be wired to cntfrq_el0 if CONFIG_ARM_ARCH_TIMER is
set, am I correct?

Thanks for the review,

Mary

