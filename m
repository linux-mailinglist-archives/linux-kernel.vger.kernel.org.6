Return-Path: <linux-kernel+bounces-169797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F38BCDBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D488B24E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B9E143C46;
	Mon,  6 May 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2wHWU+qJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEE143899
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998207; cv=none; b=DXCaeUiw2OJ0sZR/VpuzaT3ywOYRnjdDrLF4DengX4Ht8tuuwd9PxheEZrolccw1Wy72nX4wYyDc+M00JjNcz7kaIXfHEl8XH7Nr8vo9VdIuQcp84on+HoiBPyxCGhzjb2KHaEG3odQFyEoiCod5aI1YJGH0onUcZedplOzSDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998207; c=relaxed/simple;
	bh=CeBSZCyIULZ4lID6ixB6Atv3O7cFtl+byeqy/usUoJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hXnbJbcgYPn9eCF6YLw0JZZlIXD1/R4roBmkEK8DiesZXj63hDNR7tn/TyHoih4m9JSEz2cRAruE5s7C01GFOaxqje46jmK/OxL6bmdJ88QK6km+XNedsJXpmoSAKuB6bCqBCsF0u2XhDSbnwX9/boDbr4UlX/geZKLjD9LxxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2wHWU+qJ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4468VNBQ032357;
	Mon, 6 May 2024 14:07:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=6EJVQ+wMxEHRL14RVOpH9mV9WNJQFrNy5pxAip0Pyy8=; b=2w
	HWU+qJMRg1YngPQfOl2Y2ECz9cKoNqJYUwSlTSND6V/PbTOT0MsrXLeTeu4HssOT
	wasRDCloTdPyC97jZm9AFjC/JtAnmD481ohyP5/jZjH01hwzyOlLb2zXsnSAVjTU
	VjEY5x7+x3IiEegYTgUQXLsQfq0YN0e6zYGPWQGrzh9eUb65Pa8ebxy1BykX7ryc
	1YzhT/l/BocGomvLB8ulcKVxEq2bzszRDKlm1TlhLzBaJJgT4nEqYEgJOdQa53y2
	WltLcY8euLHAX704v+gmlpwXXgrScCrwqzpJodRmLLxwJrGx5p8BhdZ6PVlE7IdM
	6cNahAQMf6Lxhx//AUsg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwcbx6qg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 14:07:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 52CF64002D;
	Mon,  6 May 2024 14:07:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4895B21A239;
	Mon,  6 May 2024 14:07:11 +0200 (CEST)
Received: from [10.48.86.107] (10.48.86.107) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 14:07:08 +0200
Message-ID: <02e9e9c5-449a-48ae-88a7-0483895cd4bf@foss.st.com>
Date: Mon, 6 May 2024 14:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] checkpatch: use utf-8 match for spell checking
To: Antonio Borneo <antonio.borneo@foss.st.com>,
        Andy Whitcroft
	<apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray
	<dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC: <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
	<clement.leger@bootlin.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20231212094310.3633-1-antonio.borneo@foss.st.com>
 <20240102161038.22347-1-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20240102161038.22347-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_07,2024-05-06_01,2023-05-22_02

Hello,

A gentle reminder to review this patch.

Best regards,

Clément

On 1/2/24 17:10, Antonio Borneo wrote:
> The current code that checks for misspelling verifies, in a more
> complex regex, if $rawline matches [^\w]($misspellings)[^\w]
> 
> Being $rawline a byte-string, a utf-8 character in $rawline can
> match the non-word-char [^\w].
> E.g.:
> 	./scripts/checkpatch.pl --git 81c2f059ab9
> 	WARNING: 'ment' may be misspelled - perhaps 'meant'?
> 	#36: FILE: MAINTAINERS:14360:
> 	+M:     Clément Léger <clement.leger@bootlin.com>
> 	            ^^^^
> 
> Use a utf-8 version of $rawline for spell checking.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Reported-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
> Changes in v2:
> - use $rawline_utf8 also in the while-loop's body;
> - fix path of checkpatch in the commit message.
> ---
>   scripts/checkpatch.pl | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..2d122d232c6d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3477,9 +3477,10 @@ sub process {
>   # Check for various typo / spelling mistakes
>   		if (defined($misspellings) &&
>   		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> -			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
> +			my $rawline_utf8 = decode("utf8", $rawline);
> +			while ($rawline_utf8 =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
>   				my $typo = $1;
> -				my $blank = copy_spacing($rawline);
> +				my $blank = copy_spacing($rawline_utf8);
>   				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);
>   				my $hereptr = "$hereline$ptr\n";
>   				my $typo_fix = $spelling_fix{lc($typo)};
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86

