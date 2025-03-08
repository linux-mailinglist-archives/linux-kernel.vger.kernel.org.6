Return-Path: <linux-kernel+bounces-552679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFFAA57CC9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3436216C446
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A99F1DB122;
	Sat,  8 Mar 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="GWLeJhO1"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121C2744E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458655; cv=none; b=CNdd6SpfBbFoOTAkmUUi9SVTIJVC+pnrNbTizW1hLytL0PKcBF5DgWhDK3mzEz8AvB/COMYpDTQHVkBqYB9HlKbse6+I9A1s5GA0vLq3R1YtIxHLku5swL21ke6HPtzT4wd7xokPPxyPiuu6o+/TuTea3Gnli7NqYE4kmYTL+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458655; c=relaxed/simple;
	bh=uegV6SzNrvzv8Lu72cW1Lqhek1OERJI0RNLRHc22BCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frPJJVuM7oXuVHYJifNifI67u8EZKm5ZXiaEtv13wIO5y/2Y0t2KedZ1wtuapyePIL5Anzm3Q7kBfrXuDLjERl+f3x1Xe84iPVsEIhPkKrztHOu9gq0Qdw/ZDePtU6mfip3hfEfma/Shpbqnhmdg3jiGlxGdWSJQEVnmWnCWu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=GWLeJhO1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso595071366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 10:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1741458651; x=1742063451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYzCwEg8iZQ/2MVSbV7YyAM5WpMPKmd4xSEbITKoHKU=;
        b=GWLeJhO1NO+d8aE7JzLMHeqWtMyO/0BdjVaUwc6IwLxWSwGO+3tz1fvIEGaiRDu/LE
         hE/0066M0Viz1V0CErutPwK03NyPWo/Shh1uw3P1maHystIHRz0FtvUpOuO9hZCIycu+
         ZmdXiaixtf0FKPV9FhpHUvqlkIHpw7bUO9mfKexvUSqXWEt6JqYDmrtKyolVvlB8BMa7
         2pH4Bm3PQ6nqTHsZ2ifNG3G6VbMXudjqpwHVc47dY+m8Mm2PPDtGqmuycsdEfRH3ESUD
         B1p0bNBNb+Rzm3ETbFKfA6nq73y/nxqyIKKJq5+NT3VEe7FS3f/AdMmE1hRcj5uxuxlf
         Z40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741458651; x=1742063451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYzCwEg8iZQ/2MVSbV7YyAM5WpMPKmd4xSEbITKoHKU=;
        b=tFpqm2D8SAxp9EAV5GyLKYJ18HE4DAnmqG804Rd8UR3z72C1ffX1odBtd3rxqK+xvT
         fdbVDTX+9ov4KF20w8s7d765fGJPcXaqTOxwbTefnTBhZXGZn5Rs6g4vLbLzFiFxF2Oy
         9kNX9zKr5MiPuOcDTz6Oq2a027+yeB8NfFqG7D+Jf7iy3y2zQh03q0gy4V6gQDtzqx3j
         qk3M8bgNDBmIDQE6W+OvQ9ntQMTkIhdI+2V4howHmOMuMkY9/4OLK3bJxnxMN64EvnwR
         wZMrUqG44vlxXz9sfJLhF5Fd644l8ZjRwsAIpX6m5/65KqX6fMhQy42kJ2y9cemCp9fO
         xMRA==
X-Forwarded-Encrypted: i=1; AJvYcCVU+pdf1AL/EGboxJS6qZbagMklFZHe44B1vpPZkLnE7vaCgzTYxj26d+cIb5Z497nwVnZCOSVCPZ3C0Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvrWY9fWKzwYT02tyt1HwvEvAkD5NcyrOEBkBXxdfkWqiviVV
	ZBghRlxoZ/lpAKK5eF9aPkanuy3pDuV/IVSlTrMFANzunspFmbQ6XB0iAFO8F5w=
X-Gm-Gg: ASbGncsVsJSUKtlUcI1DZ5tsGszE2l3dkfBwibQKm5AYui6+Te4DHJzViqdYgx4P5/0
	K++MFE4RCJ0YQ494jrJp7t/fSVSq7jEfJ203bQjMWWPA98RMhee9silqFjycHusSw1Bjz89hDzY
	HIHKLnLrrlfwZZz7sZLuAUp1vweS4y0ARiMaQLIDqww/U9M6zv/ghITSqv43SnAGeCnOf0oQOAt
	dLT480kWnNixeloKC2p1u0bHDn9TerMwmF6G55/k1ZyB/Ue8kJ7M1awYdLTJFHnpzGKrhbvApc4
	v7FRzvUx69lgu9AXQhSEBn7TxtpcI3r8jYLpMFG/iA/zyllwL7Dq0av7Y+0KVWe8ivJ9HEvK
X-Google-Smtp-Source: AGHT+IFpvqrtMcNxEKdZ9ZCMtzR7eszu134IcdgZnLa27XaORcUskX6N4V3lxdQs799jBVuIH8FSzQ==
X-Received: by 2002:a17:906:68cc:b0:ac2:66ff:878 with SMTP id a640c23a62f3a-ac266ff0c24mr562524366b.50.1741458649864;
        Sat, 08 Mar 2025 10:30:49 -0800 (PST)
Received: from [192.168.1.15] (89-24-188-1.customers.tmcz.cz. [89.24.188.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac27bd0ea5asm104546766b.4.2025.03.08.10.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 10:30:49 -0800 (PST)
Message-ID: <d2fe8cfc-df97-4947-bcbc-7d43b5c24ecc@sedlak.dev>
Date: Sat, 8 Mar 2025 19:30:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/2] checkpatch: check format of Vec<String> in modules
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
 a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com,
 apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk,
 benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com,
 ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net,
 gregkh@linuxfoundation.org, joe@perches.com, lukas.bulwahn@gmail.com,
 ojeda@kernel.org, pbonzini@redhat.com, tmgross@umich.edu,
 walmeida@microsoft.com, charmitro@posteo.net
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250307131401.638820-1-trintaeoitogc@gmail.com>
 <20250307131401.638820-3-trintaeoitogc@gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250307131401.638820-3-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/7/25 2:14 PM, Guilherme Giacomo Simoes wrote:
> Implement a check to ensure that the author, firmware, and alias fields
> of the module! macro are properly formatted.
> 
> * If the array contains more than one value, enforce vertical
>    formatting.
> * If the array contains only one value, it may be formatted on a single
>    line
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>   scripts/checkpatch.pl | 67 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b28ad331742..7c42c1a0ea6b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2775,6 +2775,12 @@ sub process {
>   	$realcnt = 0;
>   	$linenr = 0;
>   	$fixlinenr = -1;
> +
> +	my %array_parse_module;
> +	my $expected_spaces;
> +	my $spaces;
> +	my $herevet_space_add;
> +
>   	foreach my $line (@lines) {
>   		$linenr++;
>   		$fixlinenr++;
> @@ -3567,6 +3573,67 @@ sub process {
>   # ignore non-hunk lines and lines being removed
>   		next if (!$hunk_line || $line =~ /^-/);
>   
> +# check if the field is about author, firmware or alias from module! macro and find malformed arrays
> +		my $inline = 0;
> +		my $key = "";
> +		my $add_line = $line =~ /^\+/;
> +
> +		if ($line =~ /\b(authors|alias|firmware)\s*:\s*\[/) {
> +			$inline = 1;
> +			$array_parse_module{$1} = 1;
> +		}
> +
> +		my @keys = keys %array_parse_module;
> +		if (@keys) {
> +			$key = $keys[0];
> +		}
> +
> +		if (!$expected_spaces && (!$add_line && $key && !$inline)) {
> +			if ($line =~ /^([\t ]+)(\s)/) {
> +				$expected_spaces = $1;
> +			}
> +		}
> +
> +		if ($add_line && $key) {
> +			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
> +
> +			my $counter = () = $line =~ /"/g;
> +			my $more_than_one = $counter > 2;
> +			if ($more_than_one) {
> +				WARN("ARRAY_MODULE_MACRO",
> +				     "Prefer each array element on a separate line\n". $herevet);
> +			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =~ /"/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +				     "Prefer declare ] on the same line\n" . $herevet);

Small grammar nit. "Prefer to declare…"

> +			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +				     "Prefer a new line after the last value and before ]\n" . $herevet);
> +			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +				     "Prefer a new line after [\n" . $herevet);
> +			}
> +
> +			if ($line =~ /^\+\s*([\t ]+)(\S)/) {
> +				$spaces = $1;
> +				$herevet_space_add = $herevet;
> +			}
> +		}
> +
> +		if ($expected_spaces && $spaces) {
> +			if (length($spaces) != length($expected_spaces)) {
> +				WARN("ARRAY_MODULE_MACRO",
> +					 "Prefer a align parameters\n" . $herevet_space_add);

Small grammar nit. Shouldn't this be rather: "Prefer to align 
parameters" or "Prefer aligned parameters"?

> +			}
> +
> +			$spaces = undef;
> +		}
> +
> +		#END OF ANALYZE FIELD
> +		if ($line =~ /\]/) {
> +			delete $array_parse_module{$key};
> +			$expected_spaces = undef;
> +		}
> +
>   #trailing whitespace
>   		if ($line =~ /^\+.*\015/) {
>   			my $herevet = "$here\n" . cat_vet($rawline) . "\n";

