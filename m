Return-Path: <linux-kernel+bounces-358215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3622997B84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E381C21B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810B3192D63;
	Thu, 10 Oct 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1xEStT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC3191F7C;
	Thu, 10 Oct 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532323; cv=none; b=UXTUOCCuX5GXWMltiengEOgqWigwsiPNFhHEHqNMJvCyKOFgSaVSTbFHAHiEpOAP67hGlf68dATEs0wu2bev6ozQ1KBPtONatiR/zf0WhGjYIEQ38cJWoWMfue3RgUC3tQ/dcMwwQ3maVnTghymb9YSa5T9vbsMVfQZsoR/akMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532323; c=relaxed/simple;
	bh=/j0wHCMvWBlBwfRDpzNxKwFRlR8wmK3FeP7uq1EuBRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSaLHd2UM9+R3rpPwlmmSNqBT+d3IheqLh62J58azqU1enrcoyUpM05POeIAkKx+EGpD+wgvmsJNNKN4WZqjwOxes3F2aabyLtqo7WnDY7h+q7u3bw48+Lv+67NhQJt5xftSOUHExGLe3WMQSv00eUrDJI/O3IgrkjcD57H291s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1xEStT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0919AC4CEC6;
	Thu, 10 Oct 2024 03:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728532323;
	bh=/j0wHCMvWBlBwfRDpzNxKwFRlR8wmK3FeP7uq1EuBRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1xEStT9EZHkZBip2nh4Kj+fOybGt28BgGM6nkiQ3kB6PL01A3NwWZJeW43IUE0DJ
	 /i9Gm4H+uVPCa1u3JNQfpZqg5TX2HLe88zihGf76QlpMZhYFHKMpJfx8lGZdgHvvyW
	 H8zGpHxpMbUdKldd8NZiF3qrBz8+lYyeIdquUmNqa4y3LjMjLPbzqfIk30rae++2Qf
	 DZhDmvi6ForNeM2YMiGBWpU38JzihICg2gke9OldFcU7GfOCgHG45ltOdpPcqzyNTh
	 xwYzP+9DV8kfQE/TxSUUcxCLw8hmvcgIApoizTrIKWrFSIrAJqHgcvLJwoDkoJBAe7
	 /7JPvN9cnDcMg==
Date: Wed, 9 Oct 2024 22:52:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davidgow@google.com, saravanak@google.com, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] of: Fix unbalanced of node refcount and memory leaks
Message-ID: <172853232056.1399039.15155235332032802331.robh@kernel.org>
References: <20241010034416.2324196-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010034416.2324196-1-ruanjinjie@huawei.com>


On Thu, 10 Oct 2024 11:44:16 +0800, Jinjie Ruan wrote:
> Got following report when doing overlay_test:
> 
> 	OF: ERROR: memory leak, expected refcount 1 instead of 2,
> 	of_node_get()/of_node_put() unbalanced - destroy cset entry:
> 	attach overlay node            /kunit-test
> 
> 	OF: ERROR: memory leak before free overlay changeset,  /kunit-test
> 
> In of_overlay_apply_kunit_cleanup(), the "np" should be associated with
> fake instead of test to call of_node_put(), so the node is put before
> the overlay is removed.
> 
> It also fix the following memory leaks:
> 
> 	unreferenced object 0xffffff80c7d22800 (size 256):
> 	  comm "kunit_try_catch", pid 236, jiffies 4294894764
> 	  hex dump (first 32 bytes):
> 	    d0 26 d4 c2 80 ff ff ff 00 00 00 00 00 00 00 00  .&..............
> 	    60 19 75 c1 80 ff ff ff 00 00 00 00 00 00 00 00  `.u.............
> 	  backtrace (crc ee0a471c):
> 	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
> 	    [<00000000c538ac7e>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<00000000119f34f3>] __of_node_dup+0x4c/0x328
> 	    [<00000000b212ca39>] build_changeset_next_level+0x2cc/0x4c0
> 	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
> 	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
> 	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
> 	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000000b296be1>] kthread+0x2e8/0x374
> 	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80c1751960 (size 16):
> 	  comm "kunit_try_catch", pid 236, jiffies 4294894764
> 	  hex dump (first 16 bytes):
> 	    6b 75 6e 69 74 2d 74 65 73 74 00 c1 80 ff ff ff  kunit-test......
> 	  backtrace (crc 18196259):
> 	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
> 	    [<0000000071006e2c>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
> 	    [<00000000b16ac6cb>] kstrdup+0x48/0x84
> 	    [<0000000050e3373b>] __of_node_dup+0x60/0x328
> 	    [<00000000b212ca39>] build_changeset_next_level+0x2cc/0x4c0
> 	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
> 	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
> 	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
> 	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000000b296be1>] kthread+0x2e8/0x374
> 	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80c2e96e00 (size 192):
> 	  comm "kunit_try_catch", pid 236, jiffies 4294894764
> 	  hex dump (first 32 bytes):
> 	    80 19 75 c1 80 ff ff ff 0b 00 00 00 00 00 00 00  ..u.............
> 	    a0 19 75 c1 80 ff ff ff 00 6f e9 c2 80 ff ff ff  ..u......o......
> 	  backtrace (crc 1924cba4):
> 	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
> 	    [<00000000c538ac7e>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<000000009fdd35ad>] __of_prop_dup+0x7c/0x2ec
> 	    [<00000000aa4e0111>] add_changeset_property+0x548/0x9e0
> 	    [<000000004777e25b>] build_changeset_next_level+0xd4/0x4c0
> 	    [<00000000a9c93f8a>] build_changeset_next_level+0x3a8/0x4c0
> 	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
> 	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
> 	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
> 	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000000b296be1>] kthread+0x2e8/0x374
> 	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80c1751980 (size 16):
> 	  comm "kunit_try_catch", pid 236, jiffies 4294894764
> 	  hex dump (first 16 bytes):
> 	    63 6f 6d 70 61 74 69 62 6c 65 00 c1 80 ff ff ff  compatible......
> 	  backtrace (crc 42df3c87):
> 	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
> 	    [<0000000071006e2c>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
> 	    [<00000000b16ac6cb>] kstrdup+0x48/0x84
> 	    [<00000000a8888fd8>] __of_prop_dup+0xb0/0x2ec
> 	    [<00000000aa4e0111>] add_changeset_property+0x548/0x9e0
> 	    [<000000004777e25b>] build_changeset_next_level+0xd4/0x4c0
> 	    [<00000000a9c93f8a>] build_changeset_next_level+0x3a8/0x4c0
> 	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
> 	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
> 	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
> 	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000000b296be1>] kthread+0x2e8/0x374
> 	unreferenced object 0xffffff80c2e96f00 (size 192):
> 	  comm "kunit_try_catch", pid 236, jiffies 4294894764
> 	  hex dump (first 32 bytes):
> 	    40 f7 bb c6 80 ff ff ff 0b 00 00 00 00 00 00 00  @...............
> 	    c0 19 75 c1 80 ff ff ff 00 00 00 00 00 00 00 00  ..u.............
> 	  backtrace (crc f2f57ea7):
> 	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
> 	    [<00000000c538ac7e>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<000000009fdd35ad>] __of_prop_dup+0x7c/0x2ec
> 	    [<00000000aa4e0111>] add_changeset_property+0x548/0x9e0
> 	    [<000000004777e25b>] build_changeset_next_level+0xd4/0x4c0
> 	    [<00000000a9c93f8a>] build_changeset_next_level+0x3a8/0x4c0
> 	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
> 	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
> 	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
> 	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000000b296be1>] kthread+0x2e8/0x374
> 	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
> 	......
> 
> How to reproduce:
> 	CONFIG_OF_OVERLAY_KUNIT_TEST=y, CONFIG_DEBUG_KMEMLEAK=y
> 	and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, launch the kernel.
> 
> Fixes: 5c9dd72d8385 ("of: Add a KUnit test for overlays and test managed APIs")
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Change the fix way by replacing test with fake.
> - Add Reviewed-by.
> v2:
> - Add memory leak stack.
> - Update the commit message.
> ---
>  drivers/of/overlay_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


