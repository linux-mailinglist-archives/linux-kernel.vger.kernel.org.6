Return-Path: <linux-kernel+bounces-577649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85034A71FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648593BB7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118225484A;
	Wed, 26 Mar 2025 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="EsH2tnBR"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB21BD03F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019769; cv=pass; b=kZMq3WH7xkHeHJPd9noECoTkZzyK0AINPN175+rzLQZkVzRXpdWei9uZ+tmpzFEV5zpvLGjf9kbWuLVdkEyM4gdbziIGfxQj8cFmmc47/AvusKccF5ApMkg1McFxzvRtKLE9qRlZ9RHla7f42RXt2yOud0rkl5ULk1D24yumQ0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019769; c=relaxed/simple;
	bh=f2UtcRRZub/HpkPVYMefrEyU7OxM4hgtJ27zHGLc6mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1rQ6/C7yZVfMSB2J8BCHWRaJzjJSleLno1K2Toh7iAZH301liRitYpawc2TY0jmmAoaz/DcfLbXmWjxFDKf7HLijhPs+gUfBevFrGJxFmHl4/HXvA5FL+/8XTPfxUMZAA6GlSEdL0Pdg9PtGuaCr0RHmrI6On/QLWAMyEpi8UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=EsH2tnBR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743019743; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d+c7ESZdkyR1GlQ6EZ4v8xLwEw/oKw0riRg66riBzhCfJSrAeGexqUzmzdfwFyCq7meKu7F2yQVysGolZvL7Unxzhpo0TkMRjfrfGn0+j8mwHiY6dCDTV4/9LH1TzQqdwGcsgoHiQ2wPp/Fy7KT7gTU79nc4pKQaRVfkPrBLX6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743019743; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lJEcZ1DcNk21RCbuiJsB6ijhomxJfvHr1TaAlYoZBCc=; 
	b=GkIPcwwh7HB/IGpBH2AnXkqZAd4hdXSX3bj/p9sRcqnTLoUqRvjppr5kmQrz21LxgY/pqfJ4TCiM4jCPBuZmjJDJCz+ON117sz7dWksI/MYToc92QMLbfl9MJdMxJVhLMRkRrqbVZ2PDmcI0dMBhS0Y5oCqG0AuL6X2RDdIn8xA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743019743;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lJEcZ1DcNk21RCbuiJsB6ijhomxJfvHr1TaAlYoZBCc=;
	b=EsH2tnBRrr7dJdta9C+6iQk5/8TN4hAk1rhugDnJmCZNu7aO1o4Sq397v7a8Wu9u
	qu9mW3vOAy4mXE+LfgV636KHGGerkSq7tI2cZ81xUI3TdVgkFiFCMBiLoct9ynRoq/X
	MbGrIE07MV+DWEpqWf2cgezHYDTN4KRdxov+11Cg=
Received: by mx.zohomail.com with SMTPS id 1743019741127156.797910467649;
	Wed, 26 Mar 2025 13:09:01 -0700 (PDT)
Message-ID: <1c9daef3-cd64-4f2f-8021-6ab2f17ae572@collabora.com>
Date: Wed, 26 Mar 2025 23:08:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/10] Add generic DRM-shmem memory shrinker (part 1)
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Qiang Yu <yuq825@gmail.com>,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
 <0e0686da-ae96-4a7a-81b2-b9ece1fa4837@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <0e0686da-ae96-4a7a-81b2-b9ece1fa4837@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/25/25 17:17, Thomas Zimmermann wrote:
> I've looked through this before, so
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.d>
> 
> for the series.

Applied to misc-next, thanks!

-- 
Best regards,
Dmitry

