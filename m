Return-Path: <linux-kernel+bounces-248215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020D92D9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338951C20C98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E719645C;
	Wed, 10 Jul 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YwikL/RN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BAA82D69
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642986; cv=none; b=FRRMkpT8wQSJ7R446pPPSK4/1FV+9CnZ8DHzX+UL0ODpyx1q918c64NAKQlRCrX7nkqHtwD8d61/qipe7lv4asDaQG7BVkOelHT6lgRSqFhqbecaGZEJNHT4tWiA0+BmQOAMffZcyAor4nbpq0RHTICd5GrLpmbA8i98Jd0DHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642986; c=relaxed/simple;
	bh=S2S5BrlKFHCSOaQ/HORfy3cWipQAGsIPftq+UXjaxP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFWvMLqIcpf3mazQASr6tdSpg0lI6aUbtX+rO6VgDtzUypHXjarCvSGseB3tc3Uf09PqSfEhTGH/GpPhPI3vtvYo6PDMrXsiIhBFYD8MIHFF0Qhx7RnJudPVRK9upRFMyURJopzi9q/W+5J11LC+ED0XVZSvmLA2sn8pDLYeNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YwikL/RN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720642983;
	bh=S2S5BrlKFHCSOaQ/HORfy3cWipQAGsIPftq+UXjaxP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YwikL/RNJJUIvHJd8wTCGaQR4mqEVxQVM9q+1THEV/PO0Jox6YasBoThKS7lOyK4D
	 s1/IVqj+LV3+qeQ2WWDorlPAuL2IV2B3zCQRdijKkNisIgF43GlNevEo1FZa3ek+MV
	 FTHUuZPjYSdkHuf1F5raTRMXXwSiX+OXPEjtp9JQIGeRFxZ94Pd7Ep90nhdlrDjs5X
	 Xng6NE1wZh39mN4bsIlqTIAtLek9xnw+8JD5IFJvhziLXRoVlKdh0kD7sAjw7MU5MP
	 27A8xeJqvC8s4PZq5rp6IBb8q11dTdTH4gSIYpwh5eF/4uPvQhXD1msWTrOBvFXjex
	 u1cKdFk1ExTtQ==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E87A3782180;
	Wed, 10 Jul 2024 20:22:57 +0000 (UTC)
Message-ID: <22bc825c-d726-4a4d-bd3a-508773c04071@collabora.com>
Date: Wed, 10 Jul 2024 17:22:55 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 27/52] selftests-dyndbg: check KCONFIG_CONFIG to avoid
 silly fails
To: Jim Cromie <jim.cromie@gmail.com>, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, jbaron@akamai.com,
 gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk, joe@perches.com,
 mcgrof@kernel.org
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <20240702215804.2201271-28-jim.cromie@gmail.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240702215804.2201271-28-jim.cromie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2024 18:57, Jim Cromie wrote:
> Several tests are dependent upon config choices. Lets avoid failing
> where that is noise.
> 
> The KCONFIG_CONFIG var exists to convey the config-file around.  If
> the var names a file, read it and extract the relevant CONFIG items,
> and use them to skip the dependent tests, thus avoiding the fails that
> would follow, and the disruption to whatever CI is running these
> selftests.
> 
> If the envar doesn't name a config-file, ".config" is assumed.
> 
> CONFIG_DYNAMIC_DEBUG=y:
> 
> basic-tests() and comma-terminator-tests() test for the presence of
> the builtin pr_debugs in module/main.c, which I deemed stable and
> therefore safe to count.  That said, the test fails if only
> CONFIG_DYNAMIC_DEBUG_CORE=y is set.  It could be rewritten to test
> against test-dynamic-debug.ko, but that just trades one config
> dependence for another.
> 
> CONFIG_TEST_DYNAMIC_DEBUG=m
> 
> As written, test_percent_splitting() modprobes test_dynamic_debug,
> enables several classes, and count them.  It could be re-written to
> work for the builtin module also, but builtin test modules are not a
> common or desirable build/config.
> 
> CONFIG_TEST_DYNAMIC_DEBUG=m && CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m
> 
> test_mod_submod() recaps the bug found in DRM-CI where drivers werent

If this fixes any but listed in drm/ci/xfails folder, please update it too.

Regards,
Helen

> enabled by drm.debug=<bits>.  It modprobes both test_dynamic_debug &
> test_dynamic_debug_submod, so it depends on a loadable modules config.
> 
> It could be rewritten to work in a builtin parent config; DRM=y is
> common enough to be pertinent, but testing that config also wouldn't
> really test anything more fully than all-loadable modules, since they
> default together.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> 
> fixup-kconfig
> ---
>   .../dynamic_debug/dyndbg_selftest.sh          | 45 ++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index fccd2012b548..d09ef26b2308 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> @@ -11,6 +11,30 @@ CYAN="\033[0;36m"
>   NC="\033[0;0m"
>   error_msg=""
>   
> +[ -e /proc/dynamic_debug/control ] || {
> +    echo -e "${RED}: this test requires CONFIG_DYNAMIC_DEBUG=y ${NC}"
> +    exit 0 # nothing to test here, no good reason to fail.
> +}
> +
> +# need info to avoid failures due to untestable configs
> +
> +[ -f "$KCONFIG_CONFIG" ] || KCONFIG_CONFIG=".config"
> +if [ -f "$KCONFIG_CONFIG" ]; then
> +    echo "# consulting KCONFIG_CONFIG: $KCONFIG_CONFIG"
> +    grep -q "CONFIG_DYNAMIC_DEBUG=y" $KCONFIG_CONFIG ; LACK_DD_BUILTIN=$?
> +    grep -q "CONFIG_TEST_DYNAMIC_DEBUG=m" $KCONFIG_CONFIG ; LACK_TMOD=$?
> +    grep -q "CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m" $KCONFIG_CONFIG ; LACK_TMOD_SUBMOD=$?
> +    if [ $V -eq 1 ]; then
> +	echo LACK_DD_BUILTIN: $LACK_DD_BUILTIN
> +	echo LACK_TMOD: $LACK_TMOD
> +	echo LACK_TMOD_SUBMOD: $LACK_TMOD_SUBMOD
> +    fi
> +else
> +    LACK_DD_BUILTIN=0
> +    LACK_TMOD=0
> +    LACK_TMOD_SUBMOD=0
> +fi
> +
>   function vx () {
>       echo $1 > /sys/module/dynamic_debug/parameters/verbose
>   }
> @@ -192,6 +216,10 @@ function check_err_msg() {
>   
>   function basic_tests {
>       echo -e "${GREEN}# BASIC_TESTS ${NC}"
> +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> +	echo "SKIP"
> +	return
> +    fi
>       ddcmd =_ # zero everything (except class'd sites)
>       check_match_ct =p 0
>       # there are several main's :-/
> @@ -214,6 +242,10 @@ EOF
>   
>   function comma_terminator_tests {
>       echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
> +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> +	echo "SKIP"
> +	return
> +    fi
>       # try combos of spaces & commas
>       check_match_ct '\[params\]' 4 -r
>       ddcmd module,params,=_		# commas as spaces
> @@ -226,9 +258,12 @@ function comma_terminator_tests {
>       ddcmd =_
>   }
>   
> -
>   function test_percent_splitting {
>       echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
> +    if [ $LACK_TMOD -eq 1 ]; then
> +	echo "SKIP"
> +	return
> +    fi
>       ifrmmod test_dynamic_debug_submod
>       ifrmmod test_dynamic_debug
>       ddcmd =_
> @@ -248,6 +283,14 @@ function test_percent_splitting {
>   
>   function test_mod_submod {
>       echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
> +    if [ $LACK_TMOD -eq 1 ]; then
> +	echo "SKIP"
> +	return
> +    fi
> +    if [ $LACK_TMOD_SUBMOD -eq 1 ]; then
> +	echo "SKIP"
> +	return
> +    fi
>       ifrmmod test_dynamic_debug_submod
>       ifrmmod test_dynamic_debug
>       ddcmd =_

