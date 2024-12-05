Return-Path: <linux-kernel+bounces-433944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74F39E5F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5141885A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599322B8AD;
	Thu,  5 Dec 2024 19:48:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CB21D5B0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428083; cv=none; b=av5hV3bE8LqfPPJ9HdHomXMgCdcdyDz2VjOPEwtiMPCW+Tn2RVQZn+lV6d4z2+d5g+jVcGlGj2daSp1e3NvDo8HFya3CfxouyyhPQkjvFkCCxnzhY/Nhw4rDMtIBpaC+u95eWxdXIIGtWpzdMmS84Qf6OzFU7fT0TY9w2NQwIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428083; c=relaxed/simple;
	bh=vB6Sc+JNp5AA25FqZwnYOgSXyzrT3UtrZiag8AUuRUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ictpHtyrowIYR37tduc+0FC3i5Xqv1YnZuKFZ2/2zIi65OIiBBhPRBX/DxUpeq4ZN0PZ4bndomZU2eTtUjC+Gxpyi25yiUVkkAdyckJ2nP94UJzLvyqHePAjoYWSAtqRBJXK9HuztUEoA2LF2798FJwoWjZ0PDztXWzRvlb3/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F18C4CED1;
	Thu,  5 Dec 2024 19:48:02 +0000 (UTC)
Date: Thu, 5 Dec 2024 14:48:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: John Hawley <warthog9@eaglescrag.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Check kernelrelease return in get_version
Message-ID: <20241205144807.6962b57a@gandalf.local.home>
In-Reply-To: <20241205-ktest_kver_fallback-v1-1-8029b9189527@suse.com>
References: <20241205-ktest_kver_fallback-v1-1-8029b9189527@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Dec 2024 16:20:50 -0300
"Ricardo B. Marliere" <rbm@suse.com> wrote:

> In the case of a test that uses the special option ${KERNEL_VERSION} in one
> of its settings but has no configuration available in ${OUTPUT_DIR}, for
> example if it's a new empty directory, then the `make kernelrelease` call
> will fail and the subroutine will chomp an empty string, silently. Fix that
> by adding an empty configuration and retrying.
> 
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
> Hi! I'm not sure if this is the best fix, but here's the gist of the
> problem:
> 
> If the test has something like:
> POST_BUILD = echo ${KERNEL_VERSION}
> 
> Then the option will be evaluated in __eval_option which calls get_version
> before there's any configuration within ${OUTPUT_DIR}. Like if the
> following happened:
> 
> 16:08:09 rbmarliere@opensuse ~/src/linux/kernel/master master
> $ git clean -fdx
> Removing build/
> 16:08:13 rbmarliere@opensuse ~/src/linux/kernel/master master
> $ make O=build/ kernelrelease
> make[1]: Entering directory '~/src/linux/kernel/master/build'
> ~/src/linux/kernel/master/Makefile:777: include/config/auto.conf: No such file or directory
> make[1]: *** [~/src/linux/kernel/master/Makefile:251: __sub-make] Error 2
> make[1]: Leaving directory '~/src/linux/kernel/master/build'
> make: *** [Makefile:251: __sub-make] Error 2
> ---
>  tools/testing/ktest/ktest.pl | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index dacad94e2be42a86f9680fcb50b65d1f3a78afb5..a57b6cb9d817e2a3351a64de96092bd47733f5e3 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -2419,6 +2419,11 @@ sub get_version {
>      return if ($have_version);
>      doprint "$make kernelrelease ... ";
>      $version = `$make -s kernelrelease | tail -1`;
> +    if (!$version) {

That should probably instead be:

	if (!length($version)) {
	[..]

-- Steve


> +	run_command "$make allnoconfig" or return 0;
> +	doprint "$make kernelrelease ... ";
> +	$version = `$make -s kernelrelease | tail -1`;
> +    }
>      chomp($version);
>      doprint "$version\n";
>      $have_version = 1;
> 
> ---
> base-commit: 9d6a414ad31e8eb296cd6f2c1834b2c6994960a0
> change-id: 20241205-ktest_kver_fallback-d42e62fb8d88
> 
> Best regards,


