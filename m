Return-Path: <linux-kernel+bounces-540486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE167A4B140
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7470418908D8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A61DED5A;
	Sun,  2 Mar 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vEtO+1eV"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7741B6CFE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740915680; cv=none; b=eRJQZXqwcFW9cgIrX/O+iYzxmz61AykQUWhvLLHIVBoPoyb/W+xlYTaEDzooWONZiksZooiROLvQsh8SzQJ1sTAjRCvf6VdJmaCm3JNvfJ45mv1a2gb+v3XzfsnVxnN4SxCum3Wb4KgGsMda+eq3AJFV166ocAAN/wWOFxgpGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740915680; c=relaxed/simple;
	bh=wSUAd1s5N/iBgL7Y88NB1XG8kmSc3Kb2oAAksWO4TZc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ojUTziQjy4JbJ3NoCFv8amWJwnQp5Xxw1wqHVDGN7Yq/g2hdV+aCCueDE9V0hMWrwn9xGfQYIN1waBm27sij3e7eelt3w9Dy6YIWTrzsuioBMY8xRLlS0QEPLQQRqjudq7uOCHWpd2OgByHcQK89binxMl/Z6as7z6wUQipCCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vEtO+1eV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740915675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbvANEeq16huInpU2rpT53ULjM49+1Zj7aN8rbxK8DQ=;
	b=vEtO+1eVBJHoNfFGPyDf7AdTJfX2FBOD41jzdE8k4CudOHfjx6BSoy49uR22NAZfWmvBTR
	V2GRkHcGcEdbKp4DTLxNK93vIfGev3cL6TPeqJY6ZUN2HfO7ocWPDCSFZGwv/0feA7/zm5
	fkGMkGlCtkomki3WghLohFR2su8eoo0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] scsi: target: Replace deprecated strncpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202502281204.CE15A6BA35@keescook>
Date: Sun, 2 Mar 2025 12:41:04 +0100
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-hardening@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FB0D4471-9413-4E7D-BFC0-246AD3F54C60@linux.dev>
References: <20250226121003.359876-1-thorsten.blum@linux.dev>
 <202502281204.CE15A6BA35@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 28. Feb 2025, at 21:10, Kees Cook wrote:
> On Wed, Feb 26, 2025 at 01:10:03PM +0100, Thorsten Blum wrote:
>> Since strncpy() is deprecated for NUL-terminated destination buffers,
>> use strscpy() instead.
>> 
>> Compile-tested only.
>> 
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> When doing strncpy() to strscpy() conversions, please include details
> of your analysis for several things:
> 
> - why is it safe to be NUL-terminated?
> - why is NUL padding needed/not needed?
> - why is the maximum length argument correct?

Yes, I'll try to describe it better.

> While you're in this file, though, can you replace the other strncpy
> that is used in target_init_dbroot() also?

Ah, I missed this one and will submit a v2 soon.

Thanks,
Thorsten


