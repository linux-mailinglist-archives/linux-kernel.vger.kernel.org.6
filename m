Return-Path: <linux-kernel+bounces-315918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8396C8CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A22A1C211AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6058C1E8B8C;
	Wed,  4 Sep 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ppfX9umW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7214A4E0;
	Wed,  4 Sep 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482560; cv=none; b=OB6QPsAr1IMdSRvRRraSTTbEy56bYFaMg0G5yjTYA/jrlnk9KYNSRJtMOD9ZbNjP3vXTbQbAGxsR7WV6fIH0TA2a8rztgGJ4juPv/BH3j0RCfmFONv9MRt/Pp9hniY9OnreeDxXZolq5CMX9Enm6GLz2CFFo038PVuRIwJuMWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482560; c=relaxed/simple;
	bh=AdJMAOlfl60fpsBCc8xQ0+D+qfwEF1pp6GLq+DwA2yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw8N9Dp6UE6Fp2eqmhtcpIPnttn4NVreJiFZ+KQHL+mWuQt7MV4N4cFnWu2Tl7p6TGPw398jMba9vacXaDRLgTUOu9A5HNAaufAjbJkWNXY0G0m9AJg8rjQtHs8w8KeXqO2Cci3mHpXkJrwceQSY6vyTTqP/6cYgL2ZNEzAcK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ppfX9umW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725482557;
	bh=AdJMAOlfl60fpsBCc8xQ0+D+qfwEF1pp6GLq+DwA2yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppfX9umWo4Ww90ByqRMBy7KxNM0cdWtemMx2s6ioS25w8KfFXtnleY5qyi8eGlQTg
	 anV0MLrjXJUwraPCsbKKozT1whuDyJXJfDKst2yjScniMcjbdif8ZoiErBL6W63tjH
	 lIPzDaB1JyKHiyqpkztF6YHuU0s4u58wT7BLvqMsv1TT7mtJSHdEYhSEeJlcBvl9eB
	 GCTHW490RC0yaY9NM2Lco96MI6/jfKb5sLqxO/pYPqHhHKm21uLzcmyZU1cAORgHY1
	 R9imraqwWJuVLc3bt59o77oiY1jZZCaDN2/OJAY2ikDTcnE7t/eIHSUYasZAlmUCG7
	 eTs8FaaY8PQ+A==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4746B17E0B18;
	Wed,  4 Sep 2024 22:42:36 +0200 (CEST)
Date: Wed, 4 Sep 2024 16:42:34 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt: dt-extract-compatibles: Extract compatibles from
 function parameters
Message-ID: <80c61f1d-5bae-4288-b868-b25d48d679a6@notapiano>
References: <20240903200753.2097911-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903200753.2097911-1-robh@kernel.org>

On Tue, Sep 03, 2024 at 03:07:52PM -0500, Rob Herring (Arm) wrote:
> Various DT and fwnode functions take a compatible string as a parameter.
> These are often used in cases which don't have a driver, so they've been
> missed.
> 
> The additional checks add about 400 more undocumented compatible
> strings.
> 
> Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  scripts/dtc/dt-extract-compatibles | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-compatibles
> index 5ffb2364409b..13ea66d49e6c 100755
> --- a/scripts/dtc/dt-extract-compatibles
> +++ b/scripts/dtc/dt-extract-compatibles
> @@ -46,6 +46,15 @@ def parse_of_match_table(data):
>  	return match_table_list
>  
>  
> +def parse_of_functions(data, func_name):
> +	""" Find all (device|machine)_is_compatible() arguments """

This comment looks outdated.

"Find all compatibles in the last argument of a given function"?

> +	match_table_list = []

A better name would be compat_list like in the other functions that return lists
of compatibles.

> +	for m in re.finditer(rf'{func_name}\(([a-zA-Z0-9_>\(\)"\-]+,\s)*"([a-zA-Z0-9_,-]+)"\)', data):
> +		match_table_list.append(m[2])
> +
> +	return match_table_list
> +
> +
>  def parse_compatibles(file, compat_ignore_list):
>  	with open(file, 'r', encoding='utf-8') as f:
>  		data = f.read().replace('\n', '')
> @@ -60,6 +69,10 @@ def parse_compatibles(file, compat_ignore_list):
>  	else:
>  		compat_list = parse_of_declare_macros(data)
>  		compat_list += parse_of_device_id(data)
> +		compat_list += parse_of_functions(data, "_is_compatible")

This pattern seems very broad and bound to generate false-positives. That said,
I glanced over the results and didn't see any string clearly wrong, so I guess
it's fine. There were a couple suspicious strings like "B5221" but they were
indeed used in the of functions, so it's working correctly.

> +		compat_list += parse_of_functions(data, "of_find_compatible_node")
> +		compat_list += parse_of_functions(data, "for_each_compatible_node")
> +		compat_list += parse_of_functions(data, "of_get_compatible_child")
>  
>  	return compat_list
>  
> -- 
> 2.45.2
> 

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

On a related note, I'm wondering if you haven't had time to see
https://lore.kernel.org/all/20240729-dt-kselftest-parent-disabled-v2-1-d7a001c4930d@collabora.com
or if that patch didn't make it to you somehow.

Thanks,
Nícolas


