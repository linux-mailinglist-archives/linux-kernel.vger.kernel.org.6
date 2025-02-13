Return-Path: <linux-kernel+bounces-513694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9890A34D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD683AB196
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132EB245AF2;
	Thu, 13 Feb 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nopO/OdN"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CB24290D;
	Thu, 13 Feb 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470828; cv=none; b=Yi8J0sjP+24GDQ4UWy7dcFczJjmjWRUslEYahx9Hv//Ru+b2Yjz7RTj0KBVzU/XP2VTPYuQM4kkjPcCpQma/lD+9ofvZaC3iNHm9VRjt2wdn6oRnNhZ64+WGJxGQoLKQlNQhUlHHxcEB+oRuEWfJyD/vAwdA2eROIgoFJ42uQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470828; c=relaxed/simple;
	bh=nn1TJ96SmMsHE1+nkWEwcCwred9dzrqlVbvlr5vSZdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OL0NZkHfy+ZFku5IZkIWeX7REtdbbergolYGF8vBcyN4kLn8lJBNrMfNEMAWe9mPKI6r+LcHf+PG6Rnq4PysgLoSZh+BBrwjEzPsmcEcOZ/clqliF8MLFyzunpK0JRYOyQIiKA78QyB2aWRcs+8+2du1HhTg8TJe/Zyb9CBl1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nopO/OdN; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b8a0c095cfso393836fac.0;
        Thu, 13 Feb 2025 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739470825; x=1740075625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZBkaywCyi0GV8xxymyrGiudWcvm4XG/kArmEhEzir4=;
        b=nopO/OdNGC1t0/YfTOH6hAFeBAkQxZiJwDaq3VVGbMHpiLhNRCR8eVxw/rKbTdhtdD
         Y13GWsnbh1iVYeqKSSgrQq04RbqpTctYv0/gO0KZ0jr60aUgZDjriuO4BRz6daARF+Fs
         8pVELf11GELCbzy58nID5qkDkV5O4G7V9/7/1d4gtYaNF3Z3w7p0s0mWgqNV3Bbr4aUu
         21jJNxOY/3rZLFy/Sj0euuy5ZXhVE/5XKMgmlJJDsIdGYbBBdCkm8e8UcTKbav+DaaPB
         /j5cScGWCcvRAWE5KOWu3FiiFz/BYRlOMSnr9peYh+flyF2F0H12invgcjksUwrRjIfM
         9/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470825; x=1740075625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZBkaywCyi0GV8xxymyrGiudWcvm4XG/kArmEhEzir4=;
        b=TpdzD2vF/7kxnRqm48joJHlHKSVjcDqxy9Nah1otsgFGVl75veO5GbAW9PozA4VYSn
         mjS6x8yvRgylVVxqpZjH843D0OrhwfgvpqqhRgW1QQadGGVRJLwiocqU/AZHkkLltr37
         fMRPXbxh8/E3x9MjPZyFk3vIX5C3rKfBzQzbfwno8ofWD2cQnCw0+wLWvu0oATxdDjy4
         eub/aglkxY6VhuuetwQLT8smLTwN77Ti1ehSqtLERh25SC1oRJG1G8tNzMCiCZ4m2KvT
         mWnyOjLIwWEkX6WuA8Ycn6i4dMaA2M+a7RiaicAtfoafPQOP5oRCio3DqkfS+i03wmaM
         NmCg==
X-Forwarded-Encrypted: i=1; AJvYcCULUxXkRfQBSrN5B25Ixg/AUtDrmE4Dh0Nz59ZCb2vj4W2isTkBZ3HApmRlEfJcecXCZiODfxOHkDm5f2lCGk0=@vger.kernel.org, AJvYcCXC841l0VTt73pRJ1+vWv+tu530FL8mhV57lEpV29IgdYEVM9C+JZFYsYCk3ZGqpnbS3HMyiLNz1zciSqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywa94tq9HvIMqrCr3u2l6XVZv1yRG+LpKokQ4idplvtYIOqmrp
	vG/2qRBthlA+HmqRdhZ07vrEKamqEADf1ejuQgk+3P8XhnsgEKQC
X-Gm-Gg: ASbGnctDBp/94zyfLibbxRMrJCB32051XPrBNPfkM5yjN8fSCsnjLMvHQXPJpJGdH/v
	M/Fx5xcAMc6Fs1PJd/u/u+rXOMT/gyESFvsLw3W1xWFvMTEeBoPnXPCNCa09NAai0PI/VcLxK31
	oaeoewNyhVxEqX0RR1+4fEfmtogBlwnaxnV0gJsLj6UIrB9RdXxc+qaGkYrj97FYWJ9gLuuizYl
	HUskf67xVLuQZnKfVB4b8g5MWAax5b/miMt3EzalWZbPNeVw508ryUla2ntbzVuaeXn0OZWwgoQ
	9/0Wcy1bCiCMxy4Pi0MIjWhD
X-Google-Smtp-Source: AGHT+IEucI6lp69xUj1WajbwijNWxr0LzFbCbo1FprtVZD6slif9HEyP13Do0/QOH9cwUaQ6O4DxEg==
X-Received: by 2002:a05:6870:aa86:b0:29e:7a13:1341 with SMTP id 586e51a60fabf-2b8f8ab8101mr2432533fac.8.1739470825534;
        Thu, 13 Feb 2025 10:20:25 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2bc659995d3sm575069fac.22.2025.02.13.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:20:24 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: joe@perches.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH 3/3] checkpatch: throw error in malformed arrays
Date: Thu, 13 Feb 2025 15:20:11 -0300
Message-Id: <20250213182011.201234-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3a6b43bad48592887d4e67ca854eef2728464b1c.camel@perches.com>
References: <3a6b43bad48592887d4e67ca854eef2728464b1c.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joe Perches <joe@perches.com> wrotes:
> Isn't this is a style desire not a parsing limitation?
Yes.

> Probably not useful to add hungarian style naming.
hungarian style naminng ? Do you think that is better `array_parse_module` ?

> \s*.* could be just .*
> 
> > +			$inline = 1;
> > +
> > +			if ($line =~ /author/) {
> > +				$parse_module_arr{'author'} = 1;
> > +			}
> > +
> > +			if ($line =~ /alias/) {
> > +				$parse_module_arr{'alias'} = 1;
> > +			}
> > +
> > +			if ($line =~ /firmware/) {
> > +				$parse_module_arr{'firmware'} = 1;
> > +			}
> 
> $parse_module_arr{$1} = 1;
hmm, ok thanks.

> > +			if ($line =~ $more_than_one_vl) {
> > +					ERROR("ERR_ARRAY_MODULE_MACRO",
> > +						"the key $key have more than one values in same line\n$here\n". cat_vet($rawline));
> 
> "Prefer one value per line\n"
> 
> ERR_ error prefixes are not useful.
> These seem more like a WARN than an ERROR
> Bad indentation
> And please use a $herevet temporary
> 
> 
> > +			}
> > +			elsif ($inline && $line !~ /\]/ && $line =~ /\["/) {
> > +					ERROR("ERR_ARRAY_MODULE_MACRO",
> > +						qq~the key $key need a new line after declare the key\n$here\n~ . cat_vet($rawline) . qq~\nFor example:
> 
> Use } elsif
> 
> "Prefer declaring keys on separate lines"
> 
> Are quote characters allowed in keys?
> If not, this seems unnecessarily complicated.
> 
> $herevet
> 
> I think the qq is unnecessary and the for example
> should refer to some style documentation and not
> be explicit in checkpatch.
Okay, I will submit a v2 with your hints

Thanks,
Guilherme

