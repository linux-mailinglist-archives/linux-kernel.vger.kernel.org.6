Return-Path: <linux-kernel+bounces-228483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158F916088
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F8D1C220AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C91474A6;
	Tue, 25 Jun 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="tBSpwwVs"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8F47A62;
	Tue, 25 Jun 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302347; cv=none; b=f33CMx9ZmUssKb/9CUx6dAvTiu8Kyqa8Fw6/Nm14qncyp2Tn2p/K7r7MV0TF/7vkfh7J59mjFzZSpMH8P67HpRbWklM8LjUCKdd9A7GfMOosIFVtqUJWIpNhOOBSw08PFPKFvL6rkBvsHNXYu4MVbaoh3W415YEHHy5Oz3VP95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302347; c=relaxed/simple;
	bh=BCVpcE/ahVIpBAMsyzDcvDdPwtpeId8iQRj4WuE9x90=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D/tB2R/xlJXp/BYhn8zuW/NpTISCHEbBbuuCOXQWocsF66yrp3RxCuEt8uFbefI7vdNwm0GGKRhlCcync4mV+8vF252TIbZjYAAD/p9MyvS/zP6TZVAwzfZg6t1sfFDURt0the5lQTXf9oTDR5cIlhYmPb62OorZKNamU+TLCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=tBSpwwVs; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 99C6D20D136E;
	Tue, 25 Jun 2024 09:50:49 +0200 (CEST)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:message-id
	:references:in-reply-to:subject:subject:from:from:date:date
	:mime-version:received:received:received; s=dkim20240523; t=
	1719301849; x=1721116250; bh=a4X7157x40dfgORFmmF9asFVj5FOglGHLaK
	X/TTxxH8=; b=tBSpwwVs+htGGyFsioAcxrCCT73GA9T8IWd0W8Ay92D0sJ7ppXd
	eDNlzxRBzOr6cxxhJlklZCVvAeOor7lHJCaVAs4sIORQMgyChkuMM4ztMnIbI3b9
	cF3aigXZgbYpVpChPfoKb2i/ziLoTcvvhRyG6NVsP6gmvNLsQ4mu4q6KF0INM8yK
	UL1NTiuxZehT4JfYyzPli4UqucomeAGV+rTWzghBiRjRGeDKCYvmvv2wumBLtR5E
	z5vzDlXwAfo8j4LmKjEWrsstsjz/B3n2RM2uXx5nXcSHAfZNJxKxQhYZ1tsaaeiM
	806NJ8QpcbJhXZowpUfZdRo0H/uUKcuYnew==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id TphZTiPlnIDd; Tue, 25 Jun 2024 09:50:49 +0200 (CEST)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id 5D2D020D1348;
	Tue, 25 Jun 2024 09:50:35 +0200 (CEST)
Received: from int-subm015.mykolab.com (unknown [10.9.37.15])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id 9F86721F0909;
	Tue, 25 Jun 2024 09:50:35 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 09:50:35 +0200
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Carlos Bilbao
 <carlos.bilbao.osdev@gmail.com>, Avadhut Naik <avadhut.naik@amd.com>, Alex
 Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] Docs: Move magic-number from process to staging
In-Reply-To: <20240624185312.94537-4-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
 <20240624185312.94537-4-sj@kernel.org>
Message-ID: <d7e4a36e27d0d6b8325875f740b94dfa@vaga.pv.it>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-24 20:53, SeongJae Park wrote:
> 'Other material' section on 'process/index' is for unsorted documents.
> However we also have a dedicated place for the purpose, 'staging/'.
> Move 'magic-number' from the section to 'staging/' directory.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/process/index.rst                           | 1 -
>  Documentation/staging/index.rst                           | 1 +
>  Documentation/{process => staging}/magic-number.rst       | 0
>  Documentation/translations/it_IT/process/magic-number.rst | 2 +-
>  Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
>  Documentation/translations/zh_CN/process/magic-number.rst | 2 +-
>  Documentation/translations/zh_TW/process/magic-number.rst | 2 +-
>  7 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/{process => staging}/magic-number.rst (100%)

Good for me

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

-- 
Federico Vaga

