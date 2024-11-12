Return-Path: <linux-kernel+bounces-405549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D479C52C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B60D283B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A912141CF;
	Tue, 12 Nov 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T9J2LnUV"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100332141AF;
	Tue, 12 Nov 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406015; cv=none; b=u7CmHNS4ogZOJIIVvbYP39ZMnalwa6ERGGIGVgfStzC3FSvKzsP3IXyuPW6RqeeqrWoNwKEzeTrHbAJAL60MChKCwREDwlGg8wfyv8zbCTHYunNintgi2cP3/NBDgEcJR7mn0ayNup3BwmIlwIDdFYMX2IVsCnxsAPeodEVBqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406015; c=relaxed/simple;
	bh=063IxRTvaCLAA7RUMgux//IKOwph19Yx799SSEkDP6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgHvPwIpX6YWvyqpSxWlNSWRuPHJfFXd46JxvERRPqoNycw4lSYUnu1XN7VMw4nzDnSXaFQ2J+Do6e8dmUJP0koPqgFf4wYgjHekOYx4Lg8uTIAe1XtWVASJOJfRr3X9ObVLsgnPfpw7rWY7mxJnYrpZFe9owjwQTc9ey0KVcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T9J2LnUV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1pqRFrb7LJiNaHS4T5S4SpHG1gN5+IWgrYGFa1h/sYQ=; b=T9J2LnUVn48Az2kWIFhkaV0ZJl
	yibpGFPtsjSmnwZgQKRkWgQnj9tQRjZfOb04PCYHYsta4Ac2mNE21d0Q+CIsINTO921RznWn6Uw21
	Yc/Nhrq18j9xewvkHovAx66NSg2+/yGljQgG/KyC2wJQNFntoFEAK3juqMQLqLP+4R/2bWucQrEUp
	1gsmBVSzdf5BxiCWgczsPe3kDpw3UCi+liI9azMxXRbQSFwMbcBq9ICYFVxqgF6cnCSwcnem7YfgN
	XRjQURijnEyBzpToRYRypMweNDrVseo41TbCIaYuD2Et7tCuNO+c6AlUyF95KcjU5pM1QHZ35N0XX
	gkWnfM0w==;
Received: from [179.118.191.54] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tAnnD-005pfX-BG; Tue, 12 Nov 2024 11:06:39 +0100
Message-ID: <3b865b4a-5d82-4d11-a60c-f4bea6cd25c0@igalia.com>
Date: Tue, 12 Nov 2024 07:06:35 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mm: shmem: Fix error checking on utf8_parse_version
 failures
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 Christian Brauner <brauner@kernel.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Andrew Morton <akpm@linux-foundation.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241112095449.461196-1-colin.i.king@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241112095449.461196-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Colin,

Em 12/11/2024 06:54, Colin Ian King escreveu:
> Currently the error check on the call to utf8_parse_version is always
> false because version is an unsigned int and this can never be less
> than zero. Because version is required to be an unsigned int, fix the
> issue by casting it to int just for the error check.

Why is it required to be an unsigned int?

> 
> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Another fix was already sent: 
https://lore.kernel.org/lkml/20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com/

