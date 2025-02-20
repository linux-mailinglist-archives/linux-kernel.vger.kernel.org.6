Return-Path: <linux-kernel+bounces-524908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6ACA3E8A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84661189E179
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD7267B61;
	Thu, 20 Feb 2025 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="dfqDKRYk"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532F2638BC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094585; cv=none; b=ZmlTHOPGMzgt7l/Ners4mjUn3XS2HVr2EOC3QlTWNzUHDuwSg7ZvFPda5VbMe4KoTuIR7kmsEWOmuaQNdLA+IP2KKZv1uHKuFvnJ+gG4IONFEa/HaM7cFY38cTbJp1wvFtep/tKWaLPtm0KzaQDWmzeYUidvt58wpMDXmn3Jnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094585; c=relaxed/simple;
	bh=Z9rlOKsYkSiSq3B/m2yiuXoWI6S0rVlJ+V/aoQY6ZzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o0TvmuOjcNKxIgMycJE5Q+RoZeixb9kp9xexXz0vC/BE2TVNHMrIo+ZCA+qFu/veB0jPlKWtt5RzRx71a+e35Bl1QcDQuWR/xBuBeZZXUVpvzzZwuT7VEvo4Swlc/mG8wIGalp7plDn9kadJLmdUoeVL9SvnylsUF1k1qwH0GwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=dfqDKRYk; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4B4C6240029
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740094576; bh=Z9rlOKsYkSiSq3B/m2yiuXoWI6S0rVlJ+V/aoQY6ZzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=dfqDKRYk5INa4ZSVXa1etFrBZSQ1Q3WSYiFhA5jW/FjJJnhy7udM3KKUcuO/CuzrQ
	 pAq/L/jiD4HiIa+jl2eFLBKgJEt7cs3uqzfkpINTiWci/oYp6EWJjl/69dIFAaL41L
	 60fYEXqs6KInHx3QSnLSCVPm/R0psvBiObjVgyvx3DIPTQk3VV+j3pptsIOXz2QqJV
	 wvf584JaF13ozIFt7cKvQ+40HeEzgDhGp15naLlaD6VLknIGQ0acY9cdytS9jpYF61
	 vlvOkvstUJSEGB7jdnfDDzzW7Qh4HCO0x4SZqGo9AmzJjJ38TKCDdg84B2a7V7lmyQ
	 YoySinZe1inOw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YzV571Zd5z6tw2;
	Fri, 21 Feb 2025 00:36:11 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org,  alex.gaynor@gmail.com,  aliceryhl@google.com,
  apw@canonical.com,  arnd@arndb.de,  aswinunni01@gmail.com,
  axboe@kernel.dk,  benno.lossin@proton.me,  bhelgaas@google.com,
  bjorn3_gh@protonmail.com,  boqun.feng@gmail.com,  dakr@kernel.org,
  dwaipayanray1@gmail.com,  ethan.twardy@gmail.com,
  fujita.tomonori@gmail.com,  gary@garyguo.net,
  gregkh@linuxfoundation.org,  joe@perches.com,  lukas.bulwahn@gmail.com,
  ojeda@kernel.org,  pbonzini@redhat.com,  tmgross@umich.edu,
  walmeida@microsoft.com,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] checkpatch: throw error for malformed arrays
In-Reply-To: <20250220161951.844367-3-trintaeoitogc@gmail.com>
References: <20250220161951.844367-1-trintaeoitogc@gmail.com>
	<20250220161951.844367-3-trintaeoitogc@gmail.com>
Date: Thu, 20 Feb 2025 23:36:03 +0000
Message-ID: <m2pljcgpek.fsf@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> writes:

> Implement a check to ensure these fields are correctly formatted. If a
> line contains one of these keys that should be of type Vec<String>, use
> a regex to verify whether the array holds multiple values.
> * If the array contains more than one value, enforce vertical formatting
> * If the array has only one value, it can remain on the same line
>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  scripts/checkpatch.pl | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b28ad331742..1133fe68054b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2775,6 +2775,9 @@ sub process {
>  	$realcnt = 0;
>  	$linenr = 0;
>  	$fixlinenr = -1;
> +
> +	my %array_parse_module;
> +
>  	foreach my $line (@lines) {
>  		$linenr++;
>  		$fixlinenr++;
> @@ -3567,6 +3570,46 @@ sub process {
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =~ /^-/);
>  
> +# check if arrays has more than one value in the same line
> +		my $inline = 0;
> +		my $key = "";
> +		my $add_line = $line =~ /^\+/;
> +
> +		if ($line =~ /\s*.*\b(author|alias|firmware)\s*:\s*\[/) {

Hi Guilherme,

Will this work now that the field is called "authors" and not "author"?
I think you forgot to update the regex here.

> +			$inline = 1;
> +			$array_parse_module{$1} = 1;
> +		}
> +
> +		my @keys = keys %array_parse_module;
> +		if (@keys) {
> +			$key = $keys[0];
> +		}
> +
> +		if ($add_line && $key) {
> +			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
> +
> +			my $counter = () = $line =~ /"/g;
> +			my $more_than_one = $counter > 2;
> +			if ($more_than_one) {
> +				WARN("ARRAY_MODULE_MACRO",
> +                     "Prefer a single-line value$herevet");

What do you think about this instead?
"Prefer each array element on a separate line$herevet"

> +			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =~ /"/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +                     "Prefer declare ] on the same line$herevet");
> +			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +                     "Prefer a new line after the last value and before ]$herevet");
> +			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +                     "Prefer a new line after [$herevet");
> +			}
> +		}
> +
> +		#END OF ANALYZE FIELD
> +		if ($line =~ /\]/) {
> +			delete $array_parse_module{$key};
> +		}
> +
>  #trailing whitespace
>  		if ($line =~ /^\+.*\015/) {
>  			my $herevet = "$here\n" . cat_vet($rawline) . "\n";

