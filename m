Return-Path: <linux-kernel+bounces-434443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC329E66DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D8C2848F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905EF198A06;
	Fri,  6 Dec 2024 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w7UMkDNC"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DB194120
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462987; cv=none; b=Iq3eYSPPMdH1MWxrrKsjt923x6uF88lCbyEt+iyUzNjXUY4LJ4JyvuxNSrRCnJ9W4tR25FWHOF8X6XEU/hek6TPC60gRt5jrzndTJq/IkioRVwBTu8ZC4Nd8cDAyziX4C4VSPBkVS6dBeat1URm1Y2ymEstdjaxyzSVJrSb+nmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462987; c=relaxed/simple;
	bh=EbHoky4remtxo6zTFYXnPsy+Jw3aoDFvV6C4DGYvjBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3FuFXRN8RPO6n6hhAi61L1eE7qZn1n1CAWuoTiHvLgnJqOMRtRLv/ivlSXrLNJ2VM3US9+3FF+mkt3wc+Zgz1nQK54DZVpvt37K+73BXhVVlZS4L2oheXy5yowQybv/veoJQBXx5fdBoVDqtSdGViaqN60I1uaRewad6Itm0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w7UMkDNC; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733462981; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g4QVWue6mo8zs80s5tU7lK6zhLbep1rtwd6KYeuWId0=;
	b=w7UMkDNCWC7jhQRnhRUNDn+VWGDYRSPoaBknTdRi4jv7Ey47+ofqvjiar+13Qvf0eaIrMCfGRva6ACEsasWlqpxMdU2QDurOK8djzfB5fFryVxWiJStDuFOfdmH5cHXngd1Cf++JSNXcyxKUqRdWNCmAdvLoNi4IEsag6d4ho1Y=
Received: from 30.39.241.89(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKvI5vS_1733462977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 13:29:39 +0800
Message-ID: <02358773-18dd-4aff-a466-28ae91e729d6@linux.alibaba.com>
Date: Fri, 6 Dec 2024 13:29:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Control folio sizes used for page cache memory
To: Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Gavin Shan <gshan@redhat.com>, Pankaj Raghav <kernel@pankajraghav.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <480f34d0-a943-40da-9c69-2353fe311cf7@arm.com>
 <CAGsJ_4z8kh4Pn-TUrVq6FALR1J5j4fpvQkef2xPFYPWdWfXdxA@mail.gmail.com>
 <CAGsJ_4y=5xvZsWWiZoGh6eqhh+NXCsztyeLVbraUrxR=ruhWzw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4y=5xvZsWWiZoGh6eqhh+NXCsztyeLVbraUrxR=ruhWzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/6 13:09, Barry Song wrote:
> It's unusual that many emails sent days ago are resurfacing on LKML.
> Please ignore them.
> By the way, does anyone know what happened?

I also received many previous emails, and seems that changing the 
maillist spam filtering rules by the owner of linux-mm@kvack.org caused 
this.

See: https://lore.kernel.org/all/20241205154213.GA5247@kvack.org/

