Return-Path: <linux-kernel+bounces-520602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90240A3AC08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D733189022A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39911D6DB1;
	Tue, 18 Feb 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="onzu8fRT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543D2862B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919177; cv=none; b=r+Sk6SjBrKLlSFGaFk3hn/22LU10mTMyufsi+lYOZYO5vhFJVi+HqI8uJuK1b0cLezWaipVtmvWf13R31H/aq+gVxmPJp2/YxMGc91f1kEsAe6nlnlRR999hk3KnfKwI+HdGuWhBbFhcHWF8yGGl0JsHIDDvHREUTsPZNB5hbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919177; c=relaxed/simple;
	bh=TXtY7nLeS8PW+yqLiU9tMoo4KhjQk30X3Ab0W/BQRUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmvBYSLRuZ/YDMc6sgYWvz8M/Z7YyJEYYknYK2EkkxwupDEOUEFsDZFg2sAk2VKWe9MeyTBsC4lCao4CndgGfkPznufD5qKUuFOQYN6G1jlkU7BJebaExqgXy3kqIBkiD2l3TEhaJQMBZUnc5PLWoxWwaPRvu3Glss4uPdNOzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=onzu8fRT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIxptN004282;
	Tue, 18 Feb 2025 22:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GaJME74QyLqMkiZIqT+fdiJXd85Ecz
	GT682zhcyP6j8=; b=onzu8fRTDgnGwxo0ULVsUMfYIBS1W1BVDl3WCx43X4iNrh
	uL40WsTkTDiKwpa02A84osXTDKL9sJfs1H7mRz5oUELnr0+pgJkXFaEtljgLf4wj
	YBLFBaAcZDNIMlCu5nl/j3yl9BvpF42jRm2Sfh6XcGxCmKpW7TwfwbUTm1GrF6tu
	fV8xOpqwFVsTLBn59Iel5dJtmkybSVPM/xd3qA/FGqPVHqbd6PT/fn3Qf1NLNAAP
	RXt34LFM9+pwH/bWGwejaxG9UPmDBaSMHig4XP0u8C4qxj0luUxtmAK7TlSkJjVO
	vNf+tzZq74iIrpoEcIIn9VTVRsbyRuOslSALYgcg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyp0vew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 22:52:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51IMl30p008091;
	Tue, 18 Feb 2025 22:52:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyp0ves-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 22:52:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJ6hgX005844;
	Tue, 18 Feb 2025 22:52:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02x8v7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 22:52:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IMqdst26673736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 22:52:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0294F58054;
	Tue, 18 Feb 2025 22:52:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D38CD58056;
	Tue, 18 Feb 2025 22:52:38 +0000 (GMT)
Received: from localhost (unknown [9.61.56.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 22:52:38 +0000 (GMT)
Date: Tue, 18 Feb 2025 16:52:38 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH next 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <Z7UPNhW_bXSOzACk@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250216201901.161781-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216201901.161781-1-david.laight.linux@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SV1Hzj3b9bk0t-IlXFOhkdlV9-hQ_43N
X-Proofpoint-ORIG-GUID: t__mJiAXJojkyKTuYqtDlRzmj9Eeky8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_10,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=963 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502180151

On Sun, Feb 16, 2025 at 08:19:01PM +0000, David Laight wrote:
> Fastpath the normal case of single byte output that fits in the buffer.
> Output byte groups (byteswapped on little-endian) without calling snprintf().
> Remove the restriction that rowsize must be 16 or 32.
> Remove the restriction that groupsize must be 8 or less.
> If groupsize isn't a power of 2 or doesn't divide into both len and
>   rowsize it is set to 1 (otherwise byteswapping is hard).
> Change the types of the rowsize and groupsize parameters to be unsigned types.
>

Thank you!

> Tested in a userspace harness, code size (x86-64) halved to 723 bytes.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  include/linux/printk.h |   6 +-
>  lib/hexdump.c          | 165 ++++++++++++++++++++---------------------
>  2 files changed, 85 insertions(+), 86 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 4217a9f412b2..49e67f63277e 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -752,9 +752,9 @@ enum {
>  	DUMP_PREFIX_ADDRESS,
>  	DUMP_PREFIX_OFFSET
>  };
...
> - * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
> + * If @groupsize isn't a power of 2 that divides into both @len and @rowsize
> + * the it is set to 1.

s/the/then/

> + *
> + * hex_dump_to_buffer() works on one "line" of output at a time, e.g.,
>   * 16 or 32 bytes of input data converted to hex + ASCII output.
...
> -		linebuf[lx++] = ' ';
> +	if (!ascii) {
> +		*dst = 0;
> +		return out_len;
>  	}
> + 
> +	pad_len += 2;

So at a minimum there is 2 spaces before the ascii translation?
when people allocate linebuf, what should they use to calculate the len?

Also side nit, this existed before this patch, the endian switch may
occur on the hex dump but it doesn't on the ascii conversion:
[   20.172006][  T150] 706f6e6d6c6b6a696867666564636261  abcdefghijklmnop


> +	out_len += pad_len + len;
> +	if (dst + pad_len >= dst_end)
> +		pad_len = dst_end - dst - 1;

Why not jump to hex_truncate here? This feels like an error case and
if I am understanding correctly, this will pad the rest of the buffer
leaving no room for ascii.

> +	while (pad_len--)
> +		*dst++ = ' ';
> +
> +	if (dst + len >= dst_end)
...
> -- 
> 2.39.5

I will like to also support a wrapper to a bitmap argument as Andy
mentioned. Mostly for selfish reasons though: I would like an argument
to be added to skip endian conversion, and just observe the bytes as they
appear in memory (without having to use groupsize 1).

I had fun tracking some of these bitwise operations on power of 2
integers, I think I must've missed that day in school. Cool stuff :)

