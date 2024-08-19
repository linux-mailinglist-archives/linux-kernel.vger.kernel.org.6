Return-Path: <linux-kernel+bounces-293016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA5957810
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A292847E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655761DD3B4;
	Mon, 19 Aug 2024 22:48:53 +0000 (UTC)
Received: from mail.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451B3C482
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107733; cv=none; b=PlpoW/5u605CXai52Y1BvJrqt3jn9GckgE8BUBh3OGblUNTCYDGhxipdR/8x5lxtAhon11NYC/P52AEHazVFNzP5mFrl2a7G1Ge0mhc4jqt7LnpnmnmGhlSG0Eadth0Vve+ryFdURhGPH5Qb5RmnFpjHml2c/g7hql9bvRzOQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107733; c=relaxed/simple;
	bh=gv6ZSwkyoglsiovWHh0oKoeaozVCOEbYX+zfegr8+EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bSXBkeQKlT+nB7YKgQ1V54d6oML0NGUXaQD2L5HbMh4ahJ4pcq+u8rrfj22BxICyftZyRRw401LQORHc9scRh3TyL8rOQ0QE2do6b/S59qMnmvlqEfcAzqqnW15p8VltUxe3ERbkOr9cvwc5fWT69VhAKzNI+gzV6HOkVtTEl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eaglescrag.net; spf=fail smtp.mailfrom=eaglescrag.net; arc=none smtp.client-ip=23.128.96.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eaglescrag.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=eaglescrag.net
Received: from [172.19.5.171] (not.afront.org [50.126.75.182])
	by mail.monkeyblade.net (Postfix) with ESMTPSA id A44E9A516063;
	Mon, 19 Aug 2024 15:42:21 -0700 (PDT)
Message-ID: <eface540-8e16-4424-bb3e-38b4f37632e1@eaglescrag.net>
Date: Mon, 19 Aug 2024 15:42:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ktest.pl: Always warn on build warnings
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240819172028.3a7fae09@gandalf.local.home>
From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Content-Language: en-US
In-Reply-To: <20240819172028.3a7fae09@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Mon, 19 Aug 2024 15:42:21 -0700 (PDT)

Acked-by: John 'Warthog9' Hawley (Tenstorrent) <warthog9@eaglescrag.net>

On 8/19/2024 2:20 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> If a warning happens at build, give a warning at the end:
> 
>    Build time:   1 minute 40 seconds
>    Install time: 17 seconds
>    Reboot time:  25 seconds
> 
>    *** WARNING found in build: 1 ***
> 
>    *******************************************
>    *******************************************
>    KTEST RESULT: TEST 1 SUCCESS!!!!   **
>    *******************************************
>    *******************************************
> 
> This way, even if the test isn't made to fail on warnings during the
> build, a message is still displayed that warnings were found.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>   tools/testing/ktest/ktest.pl | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index eb31cd9c977b..c82b8d55dddb 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -222,6 +222,8 @@ my $install_time;
>   my $reboot_time;
>   my $test_time;
>   
> +my $warning_found = 0;
> +
>   my $pwd;
>   my $dirname = $FindBin::Bin;
>   
> @@ -729,11 +731,18 @@ sub print_times {
>   	show_time($test_time);
>   	doprint "\n";
>       }
> +    if ($warning_found) {
> +	doprint "\n*** WARNING";
> +	doprint "S" if ($warning_found > 1);
> +	doprint " found in build: $warning_found ***\n\n";
> +    }
> +
>       # reset for iterations like bisect
>       $build_time = 0;
>       $install_time = 0;
>       $reboot_time = 0;
>       $test_time = 0;
> +    $warning_found = 0;
>   }
>   
>   sub get_mandatory_configs {
> @@ -2460,8 +2469,6 @@ sub process_warning_line {
>   # Returns 1 if OK
>   #         0 otherwise
>   sub check_buildlog {
> -    return 1 if (!defined $warnings_file);
> -
>       my %warnings_list;
>   
>       # Failed builds should not reboot the target
> @@ -2482,18 +2489,21 @@ sub check_buildlog {
>   	close(IN);
>       }
>   
> -    # If warnings file didn't exist, and WARNINGS_FILE exist,
> -    # then we fail on any warning!
> -
>       open(IN, $buildlog) or dodie "Can't open $buildlog";
>       while (<IN>) {
>   	if (/$check_build_re/) {
>   	    my $warning = process_warning_line $_;
>   
>   	    if (!defined $warnings_list{$warning}) {
> -		fail "New warning found (not in $warnings_file)\n$_\n";
> -		$no_reboot = $save_no_reboot;
> -		return 0;
> +		$warning_found++;
> +
> +		# If warnings file didn't exist, and WARNINGS_FILE exist,
> +		# then we fail on any warning!
> +		if (defined $warnings_file) {
> +		    fail "New warning found (not in $warnings_file)\n$_\n";
> +		    $no_reboot = $save_no_reboot;
> +		    return 0;
> +		}
>   	    }
>   	}
>       }


