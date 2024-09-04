Return-Path: <linux-kernel+bounces-315774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7696C6BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A40F1C225D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710791E4102;
	Wed,  4 Sep 2024 18:49:21 +0000 (UTC)
Received: from mail.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955171E203D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475761; cv=none; b=Z2dZaK8xljnfYK81YDRBWbgLe4oI2WdINzZayxT4vUl269+OV3W+BWGI/dxb3bwkOMqu7IgjR17usK+q08g85kKc9S/h+HGparZEujucWJ0jsDq/w5JgsEbyv6Uyv0h7ANr7O5iSXcNw2NRreuv0OeVCEdvGlPjpQpw4ZYOd6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475761; c=relaxed/simple;
	bh=IBj2DHy8pAJXIZ9LM0wSogXY2FcM2o6bUV5zEerVWV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJdIVJfTuLcTd51BK6gkBAbaqqTmgXAv/69hQp0Ul8HKsbiLpOuxd99eAqQBztSLKSsBdx+Nf5CyPqIEkahgajutRadVeqBqX50EXsxqidMZ1rxKb+CyuI/pPvBb9xCtRM21EeWGleNldETAuN2AZW8NKmOeoKV2ZdMNiFt/hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eaglescrag.net; spf=fail smtp.mailfrom=eaglescrag.net; arc=none smtp.client-ip=23.128.96.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eaglescrag.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=eaglescrag.net
Received: from [IPV6:2620:137:e001:0:50b6:bd77:d530:f10d] (unknown [IPv6:2620:137:e001:0:50b6:bd77:d530:f10d])
	by mail.monkeyblade.net (Postfix) with ESMTPSA id BC8EDA576971;
	Wed,  4 Sep 2024 11:44:12 -0700 (PDT)
Message-ID: <f7eae65c-fcd8-45b4-86c7-443e57e96a96@eaglescrag.net>
Date: Wed, 4 Sep 2024 11:44:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ktest.pl: Avoid false positives with grub2 skip regex
To: Daniel Jordan <daniel.m.jordan@oracle.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
References: <20240904175530.84175-1-daniel.m.jordan@oracle.com>
From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Content-Language: en-US
In-Reply-To: <20240904175530.84175-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 04 Sep 2024 11:44:12 -0700 (PDT)

On 9/4/2024 10:55 AM, Daniel Jordan wrote:
> Some distros have grub2 config files with the lines
> 
>      if [ x"${feature_menuentry_id}" = xy ]; then
>        menuentry_id_option="--id"
>      else
>        menuentry_id_option=""
>      fi
> 
> which match the skip regex defined for grub2 in get_grub_index():
> 
>      $skip = '^\s*menuentry';
> 
> These false positives cause the grub number to be higher than it
> should be, and the wrong kernel can end up booting.
> 
> Grub documents the menuentry command with whitespace between it and the
> title, so make the skip regex reflect this.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
> v2: Resend, removing unnecessary terminal + from regex.
> v1: https://lkml.kernel.org/r/20240802145706.1283189-1-daniel.m.jordan@oracle.com
> 
>   tools/testing/ktest/ktest.pl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index eb31cd9c977bf..621a874b24264 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -2047,7 +2047,7 @@ sub get_grub_index {
>       } elsif ($reboot_type eq "grub2") {
>   	$command = "cat $grub_file";
>   	$target = '^\s*menuentry.*' . $grub_menu_qt;
> -	$skip = '^\s*menuentry';
> +	$skip = '^\s*menuentry\s';
>   	$submenu = '^\s*submenu\s';
>       } elsif ($reboot_type eq "grub2bls") {
>   	$command = $grub_bls_get;

Easy enough fix.  Out of curiosity which distro(s) did you find have 
that?  Haven't run into that myself.

Acked-by: John 'Warthog9' Hawley (Tenstorrent) <warthog9@eaglescrag.net>

