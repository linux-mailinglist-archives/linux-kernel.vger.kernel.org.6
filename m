Return-Path: <linux-kernel+bounces-240201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0698B926A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB661C22517
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C68191F8F;
	Wed,  3 Jul 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XyWEGsCm"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47405181CEC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042122; cv=none; b=DkHEDV/YsTchjt0izCUcHgfP5zPGOShkQZAigLs09P24VwNrtQeHV68s7gAYYrNRkvN141gYR1hBb2Isxowrmgwqo4PL0JS4IvDrrJUOJrj9pZMlSfHJ2L1LtM03y4p7fLgZ4cQH5wKFMo/Z9FwNLcFSLXC5/+PLmxvfHj8MUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042122; c=relaxed/simple;
	bh=pRizBzT6P+pExbFelF1chI1Qk2EFTL1cdCGgkVMzIXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhxKjjZKDiKNx7y1Tz6PPLILCRRrGS+qdr6NN25a99HI1ipZ2Le+WubpJvcG5l/0byhbc6qSEo588GB0+G6qvtDnINRgCkWKB1E6o+zgscoiEBrhvKUJeQL6uf2yEnn4WFAbJsQpOu9wHfJTBhe6p6lZo67p9lmp7YPxfNC4Hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XyWEGsCm; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WDtF458fxz6CmQyM;
	Wed,  3 Jul 2024 21:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720042118; x=1722634119; bh=pRizBzT6P+pExbFelF1chI1Q
	k2EFTL1cdCGgkVMzIXo=; b=XyWEGsCmo5dBCGrnhGmXEkMqabMP/Jsfn/Y6Vwzk
	H6p0U1qaLY5YGMCbP4v1O4aD6VFvsNdSIQ1wwiJDNoB9mZKfNE+Zlh0+cIHdIu2L
	b4eMOn6Gvq1Ab24M7cnmEv/EPtXFBnT11y9Ettrp+hzTYtG4gxkR0QGogICTXJDy
	uuW8WveVVLxhVeBKPx39T+nj7RCO1Jv+82kaA5h0Tl4Y3IGXrFjmq3xYcBdBaUvh
	ohgldcAz88Oty0ZZmeCAOzVM6xKZz8aijGF+nrnfa0mVCAPj+Rn+cO4sMv4lcmye
	EdwKOGKuzxkmkkPc8DUlCmUvxwlR+Ln44kHPG0mo62ibPQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id G0Nku-Q8zvu9; Wed,  3 Jul 2024 21:28:38 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WDtF10gQnz6Cnv3Q;
	Wed,  3 Jul 2024 21:28:36 +0000 (UTC)
Message-ID: <f0333b86-212e-40e6-b41d-b393c312153f@acm.org>
Date: Wed, 3 Jul 2024 14:28:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/53] workqueue: Introduce the create*_workqueue2()
 macros
To: Kees Cook <kees@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-2-bvanassche@acm.org>
 <CAJhGHyCsypVP7VgsNKdQ=rn0hqiJOzSS9p_OGio6k-S2idaLtA@mail.gmail.com>
 <3302014f-6ee0-452a-a6a5-dea6fcc37542@acm.org>
 <202407031249.F9EB68A@keescook>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202407031249.F9EB68A@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 1:24 PM, Kees Cook wrote:
> This can be done with the preprocessor to detect how many arguments
> are being used, so then there is no need to do the renaming passes and
> conversions can land via subsystems:

Thanks Kees, this is very useful feedback.

As one can see here, Tejun requested not to add support for a format
string in the create*_workqueue() macros:
https://lore.kernel.org/linux-kernel/ZoMF1ZydZUusxRcf@slm.duckdns.org/

Hence a different approach for the SCSI create*_workqueue() macros:
https://lore.kernel.org/linux-scsi/20240702215228.2743420-1-bvanassche@acm.org/

Best regards,

Bart.

