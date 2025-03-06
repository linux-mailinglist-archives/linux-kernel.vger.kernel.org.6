Return-Path: <linux-kernel+bounces-548012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A7A53ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C37A471B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227E2114;
	Thu,  6 Mar 2025 00:02:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975052942A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219321; cv=none; b=StU20+ERfkogHCMtJhlI5+eD2KqS9C8+a/7lYu0tFXRcl5Yz7I5gmdlpfzFiu26uA4gv5itUdOU6bGCD/aS1p4XLur78n/BxMIUdPIwYh3kpfDDjIPrBZkKeTiOvNNQDbGhdU3ryP6NWU+XczyMYPhN5OMz/n56DYOyQR4n+qjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219321; c=relaxed/simple;
	bh=kaE/bssjgEL0B2w9o0HNcUCi4/kjvhBQOLMJFkLOTZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfkH0QRUj+CqaKyUoYiyxl8V6m8KIC46o4IHnrU/6kRitTkwM/o2FRsaJrfszQSAKp4m/TAL+usoi24tEipqZRCQQHLdJoMugC3phM/oVuAXnictBV5K802mAkUxvqOcStvNjWknf4VJFwYVt1D3ewhZoatGUNGGTOcs4wpNTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71225C4CEE9;
	Thu,  6 Mar 2025 00:02:00 +0000 (UTC)
Date: Wed, 5 Mar 2025 19:01:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ayush Jain <Ayush.jain3@amd.com>
Cc: <warthog9@eaglescrag.net>, <linux-kernel@vger.kernel.org>,
 <srikanth.aithal@amd.com>, <kalpana.shetty@amd.com>
Subject: Re: [PATCH v2] ktest: Fix Test Failures Due to Missing LOG_FILE
 Directories
Message-ID: <20250305190159.7c590242@gandalf.local.home>
In-Reply-To: <20250305041913.1720599-1-Ayush.jain3@amd.com>
References: <20250305041913.1720599-1-Ayush.jain3@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 04:19:13 +0000
Ayush Jain <Ayush.jain3@amd.com> wrote:

> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 8c8da966c641..13b97e6b8459 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
>      if ($opt{"CLEAR_LOG"}) {
>  	unlink $opt{"LOG_FILE"};
>      }
> +
> +	if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
> +	my $dir = $1;
> +	if (! -d $dir) {
> +	mkpath($dir) or die "Failed to create directories '$dir': $!";
> +	print "\nThe log directory $dir did not exist, so it was created.\n";
> +	}
> +	}

Hmm, somehow the indentation is messed up here. Should be:

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 8c8da966c641..13b97e6b8459 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
     if ($opt{"CLEAR_LOG"}) {
 	unlink $opt{"LOG_FILE"};
     }
+
+    if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
+	my $dir = $1;
+	if (! -d $dir) {
+	    mkpath($dir) or die "Failed to create directories '$dir': $!";
+	    print "\nThe log directory $dir did not exist, so it was created.\n";
+	}
+    }

-- Steve

