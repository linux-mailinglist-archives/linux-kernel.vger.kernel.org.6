Return-Path: <linux-kernel+bounces-545373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB894A4EC8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF2B8A4089
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0D24C063;
	Tue,  4 Mar 2025 18:34:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20224C06A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113243; cv=none; b=lp+GP3Gjq2WbTkzUXZk8Azb/q1KT6bv26J1gdiW/Eacdu/EZOrWxjy1+jsL+ybHoYMYaOnIm23oNtmIluXUZ2Dqu0Q1ZKggAhnonpXLm/65tSBP/mt0GMkVlZKJ7kIowiC4TJteGkRCFfEjRuA7mneJl3pYYRjo96bLurl/sh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113243; c=relaxed/simple;
	bh=+6eY4JboCWUSqntkcOQ5NOvD3P2ZpGN+XZXY5oxz1Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffgv5zkaaQcp0S5yia81WzBRbwAJHWb4uw23zckUyxRC/wBHAeyFYPEWbsHZKtxc/FHvbnXnI6aGUzVBGRwvNchVoo/Ic80ROycU4GTLkdWTb8wBhDBYimxy4NAUcz9GuWEe/JXYVwRyeH2PWy8VhTAEW879rpVrzmVFn9uktPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77286C4CEE5;
	Tue,  4 Mar 2025 18:34:02 +0000 (UTC)
Date: Tue, 4 Mar 2025 13:34:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ayush Jain <Ayush.jain3@amd.com>
Cc: <warthog9@eaglescrag.net>, <linux-kernel@vger.kernel.org>,
 <srikanth.aithal@amd.com>, <kalpana.shetty@amd.com>
Subject: Re: [PATCH RESEND v1] ktest: Fix Test Failures Due to Missing
 LOG_FILE Directories
Message-ID: <20250304133457.7e8f82a1@gandalf.local.home>
In-Reply-To: <20250128051427.405808-1-Ayush.jain3@amd.com>
References: <20250128051427.405808-1-Ayush.jain3@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 05:14:27 +0000
Ayush Jain <Ayush.jain3@amd.com> wrote:

> Handle missing parent directories for LOG_FILE path to prevent test
> failures. If the parent directories don't exist, create them to ensure
> the tests proceed successfully.
> 

Sorry for the late reply. This got lost in my inbox.

> Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
> ---
>  tools/testing/ktest/ktest.pl | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 8c8da966c641..be707cbc56a7 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -4303,6 +4303,13 @@ if (defined($opt{"LOG_FILE"})) {
>      if ($opt{"CLEAR_LOG"}) {
>  	unlink $opt{"LOG_FILE"};
>      }
> +	if (! -e $opt{"LOG_FILE"}) {

First, please use the same indentation as the file. This isn't kernel code
and doesn't use the kernel indentation.

> +		my ($dir) = $opt{"LOG_FILE"} =~ m|^(.*/)|;

The above has a lot of Perl shortcuts that a normal C programmer would not
understand. Please convert this to:

	if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
		my $dir = $1;


		if (! -d $dir) {
		
Thanks,

-- Steve


> +		if ($dir && !-d $dir) {
> +			mkpath($dir) or die "Failed to create directories '$dir': $!";
> +			print "\nThe log directory $dir did not exist, so it was created.\n";
> +		}
> +	}
>      open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
>      LOG->autoflush(1);
>  }


