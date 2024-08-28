Return-Path: <linux-kernel+bounces-304871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CDA96260F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F01281D18
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324C516C842;
	Wed, 28 Aug 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b="AjdHZ32m"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEC15DBDD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844675; cv=pass; b=NVS2WOdv5hZByf8/i55RrWCYh3tUrtBTX0JkyVGvVkzcSRGUT5c2diQYOO3ySF9ZIAp+Ybo2Ddn8gXmcWC1IB3vZ/jCDWg7k//+y2wF2IkMayVkXu0tZKdz9AW+XAySPvV88+qKDF2JHmdAhywnFNEAtGCCvSKEaL6pAc/UIJ2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844675; c=relaxed/simple;
	bh=VxLdtmPrQ73ddqPKqDEsURoRnrlOk5QtEr6O4MHr5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcUba9AZ2wF7vR6Eyw41SxbXNbMG6myvWSMUZp41QnBmGqx9OO098wSrZPq/HfI8+6hoC+j1IKZ1QexqfmQpckthaILI/H8wNNAXYfIDHLtqn7idceN88+01fX6z6SyfLeucKPyu24MVfYqKHdmbnTMtMCtSsMwOUuiyzaLaGe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b=AjdHZ32m; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: mary.guillemard@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724844653; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kEmUWvx5TdbFyy2dfxhUGT27oraEOwbJFeeuNDnmZwXFLfJf40bdxElNV2AupYMszILzkQriz6k5dh/42mVIa/5CpcmH1sGxag0s4bY3La6RFM5dSu22/OmowNm9IiVpVDDz4QAA2l8MqxqILqzvz7D+YWRqr/2GjFnSSlqVY4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724844653; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z57WRZxexRi0BGZvWyKLmh8V5LVchds8LoG56IN/+m4=; 
	b=I65gtZR35n1D9VhHknLbL92HFC9qdchvTO6hFV8HA8r6BP/zHsPyKVMKo8M3szGVGtYg/9RdCbJoePXwKwlON96FI2AxDyginYL9AlwmXlthvM2hoIfXUofptYYptH6ENLyZ1tf9BaIe0VL8nCU+53jiN0ARvw6NSZGns5BKXwA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=boris.brezillon@collabora.com;
	dmarc=pass header.from=<boris.brezillon@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724844653;
	s=zohomail; d=collabora.com; i=boris.brezillon@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=z57WRZxexRi0BGZvWyKLmh8V5LVchds8LoG56IN/+m4=;
	b=AjdHZ32mxKl5zZ1oRgdO537UsDDtMN8dSvdolxG/ypq3FlwG1cJ6k2y7mvV+Jf9K
	EnMLMOXekgnCu4H32VOt1068pjsLiNU36ilJfz1ZPRa4EdmQ0CRcXzRqm7Ekfp1yGJu
	VpcQi8LwPeEG7677lKfuJALJtOP9gd2zEEc3jisY=
Received: by mx.zohomail.com with SMTPS id 172484465166262.53866539524893;
	Wed, 28 Aug 2024 04:30:51 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:30:42 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mary Guillemard <mary.guillemard@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com, Christopher Healy
 <healych@amazon.com>, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Message-ID: <20240828133042.4b731826@collabora.com>
In-Reply-To: <20240819112508.67988-2-mary.guillemard@collabora.com>
References: <20240819112508.67988-2-mary.guillemard@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On Mon, 19 Aug 2024 13:25:08 +0200
Mary Guillemard <mary.guillemard@collabora.com> wrote:

> +/**
> + * struct drm_panthor_timestamp_info - Timestamp information
> + *
> + * Structure grouping all queryable information relating to the GPU timestamp.
> + */
> +struct drm_panthor_timestamp_info {
> +	/** @timestamp_frequency: The frequency of the timestamp timer. */
> +	__u64 timestamp_frequency;
> +
> +	/** @current_timestamp: The current timestamp. */
> +	__u64 current_timestamp;
> +
> +	/** @timestamp_offset: The offset of the timestamp timer. */
> +	__u64 timestamp_offset;

I'm not sure we should expose the offset to be honest. It looks like
something that's related to suspend/resume which only the kernel needs
to know.

> +};

