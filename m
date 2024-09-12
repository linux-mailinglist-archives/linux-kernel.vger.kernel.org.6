Return-Path: <linux-kernel+bounces-326499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551097691D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B4A1F23655
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271F61A4E78;
	Thu, 12 Sep 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="AAdVE0CB";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cZQ5IMM7"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491881A0BEE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144088; cv=none; b=qMX4VNvpXw3H03iLeFP/WBX59grHfmP12p19/5hjYm3PL9scS+G1sx+kFI7JNGDI0YRH4sFF429ofjwnpPCYDahgINUEcFBFyBqDtGeOIkVoFIXQN3n6zHa41W3vPXiTkTs8LFfqfC969WJooWeWibVbj6z1OwbfhqyaNjky2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144088; c=relaxed/simple;
	bh=9ZjnxTfWpjA1p4zlfI33l+DzUXnH6P+5rE0W9WBIxOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXlYWPBGAlUozzgOubRZT4WXjCYMULUGVIkdy6dIK1+OcGgzBtYxIa4Gd1+qb90gQIm6bHWIe6NApFnTwprY0JYQQbbybrbOE0GDzZbWXZNc8ulcJiY7+n5Vr3n5WozHgbpdug6QS142WXNr/5mp1htJiAnXC1QUjsi448cQHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=AAdVE0CB; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=cZQ5IMM7; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726144086;
	bh=9ZjnxTfWpjA1p4zlfI33l+DzUXnH6P+5rE0W9WBIxOs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=AAdVE0CB6ztaej2NjLWMuVFfb6OO2Y+Kdl/dGNBOjZCV/TNYh+ARWTRoHcT2Faqpg
	 vMDKUPr4HrgZYdR95dEm42ppafoPM1NXE5aK5scdSuyuDhocrYXogt/HRVbkJ/MlQL
	 yUMz3L1aDn4dhujn5awfVtwmOQYhskI3t1nEmqFc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2EF1E1286B75;
	Thu, 12 Sep 2024 08:28:06 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id pNQr286WJefl; Thu, 12 Sep 2024 08:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726144085;
	bh=9ZjnxTfWpjA1p4zlfI33l+DzUXnH6P+5rE0W9WBIxOs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=cZQ5IMM770InZlyQTl/BVP2feJT63s5tz6Xlc5LfMYjzPY/vuZotfONtKQpj2TEZw
	 igF4o7D6uchL1NKkZ1iqhSgl/QmOEnZNZT4LMLyvGV4gRkIufV2bCjIwrDq6UD2cHi
	 aoTzxzO2OrfRbMD6+/WksiC9n8Npvh9i0C2Jd9bE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 228DE1285DB2;
	Thu, 12 Sep 2024 08:28:05 -0400 (EDT)
Message-ID: <86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 3/3] tsm: Add TVM Measurement Sample Code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Cedric Xing <cedric.xing@intel.com>, Dan Williams
 <dan.j.williams@intel.com>,  Samuel Ortiz <sameo@rivosinc.com>, Lukas
 Wunner <lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>,
 Qinkun Bao <qinkun@google.com>, Mikko Ylinen
 <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Date: Thu, 12 Sep 2024 08:28:02 -0400
In-Reply-To: <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
	 <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-09-07 at 23:56 -0500, Cedric Xing wrote:
> This sample kernel module demonstrates how to make MRs accessible to
> user mode
> through TSM.
> 
> Once loaded, this module registers a virtual measurement provider
> with the TSM
> core and will result in the directory tree below.
> 
> /sys/kernel/tsm/
> └── measurement-example
>     ├── config_mr
>     ├── full_report
>     ├── report_digest
>     ├── rtmr0
>     │   ├── append_event
>     │   ├── digest
>     │   ├── event_log
>     │   └── hash_algo
>     ├── rtmr1
>     │   ├── append_event
>     │   ├── digest
>     │   ├── event_log
>     │   └── hash_algo
>     ├── static_mr
>     └── user_data

I'm not sure this is the best structure to apply to logs with multiple
banks (hash algorithms).  There needs to be a way to get the same
registers measurement for each bank, but the log should sit above that
(appending should extend all active banks)

How about

/sys/kernel/tsm/
└──<measurement type>
   ├──reg0
   │   ├── <log format>
   │   │   ├── append_event
   │   │   └── event_log
   │   ├── <hash algo>  
   │  ...  └── digest
   ...

That way it supports multiple log formats (would be the job of the log
extender to ensure compatibility) and multiple banks.

James


