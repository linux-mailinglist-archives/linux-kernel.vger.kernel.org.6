Return-Path: <linux-kernel+bounces-190613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F372E8D0077
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AA01F21CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C015E5D3;
	Mon, 27 May 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="N0/wY+f3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1A1DDC9;
	Mon, 27 May 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814388; cv=none; b=J3OMCK8qtyeMBa6Pbg6NFcKcwjlAtgeQ0obb+Etwvezx/MevEsjilCdVNRW4j3BZoRu3+hJHM0xU4TFweqnkbxstCf+z+HAs74b2n8ccMidipepVjYy88i/VWNtnW46A2ZCf3AdJ1nWdaHau1u/XZXMy2xljUGcVJRicyerFsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814388; c=relaxed/simple;
	bh=kBPorpQ7vBYqMRTfoGQhRu1WySBg6CbmBx69KpiwWGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJLxKLuPNCjL1Zf21c8AL37sQVaJMpkvaMNHLY3KLrUPplTeXJdAFrA/L5DVD8uiYz0Ujuj2OqusISBCDo1PPo+fw85HjFLVisDUavvZ8BlgWAmDJtaFFiStytFFDFYzpwlo33vV6n0w0oTu0XRZwu+yd8/BPsJ9sf4HtIPRgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=N0/wY+f3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 269E247C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1716813813; bh=hZwk0AW8MLiViFy52ADHgAvY9XF6YcrHWsC+PnuwlD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N0/wY+f3sVLJ5hmYykdJ3dqt8t9u6adwghZY4UVPJQrK/haj1xVCL/ipi7mnAIIZP
	 aOZRYUUa5Ix8zduN2WqD5lpzg79od4xBJ3E+rnSFWVBEt/7cKqb/RwmEsaus9ENcNd
	 HsvjHPtklHZk45chyYMocmPBDPI+EX6DsefwzWSc+pczfBLBEyodip6PgKa5AduTxp
	 9+9XooKIm3+c6J+Bwrth+T/WHs6mPTGRpy8ImJA/EQiFEXEaUtrWu/jsMngUcIelgG
	 92ZF3BDtAlLm/+3XxoqWLNNGflc5/gc/fwF/UAWq8/jo90vhoOq8judBV8PTuaQF8u
	 Yzg/RnE7R5mhA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 269E247C5F;
	Mon, 27 May 2024 12:43:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: yskelg@gmail.com
Cc: skhan@linuxfoundation.org, Jinwoo Park <pmnxis@gmail.com>, Austin Kim
 <austindh.kim@gmail.com>, shjy180909@gmail.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Yunseong Kim
 <yskelg@gmail.com>
Subject: Re: [PATCH v3] Documentation: cve Korean translation
In-Reply-To: <20240527103003.29318-1-yskelg@gmail.com>
References: <20240527103003.29318-1-yskelg@gmail.com>
Date: Mon, 27 May 2024 06:43:32 -0600
Message-ID: <87ikyzpgqz.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

yskelg@gmail.com writes:

> From: Yunseong Kim <yskelg@gmail.com>
>
> This is a Documentation/process/cve korean version.

Thank you for working to improve our documentation.  A couple of
questions, though:

> Reviewed-by: Jinwoo Park <pmnxis@gmail.com>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>

1) Why do I have three versions of it in my mailbox, sent over a period
   of 13 minutes?  What changed between the versions?

   Normally, you want to wait for reviews to come in on one version
   before posting the next, and you should put a comment after the "---"
   line saying what changed.

2) When did this review from Jinwoo Park happen?  I was not copied on
   that.

Thanks,

jon

