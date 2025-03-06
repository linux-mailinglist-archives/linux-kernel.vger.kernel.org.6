Return-Path: <linux-kernel+bounces-549288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C147A5505F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F803AD61B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB06212D7B;
	Thu,  6 Mar 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4noyEX8D"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E09211A2A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277856; cv=none; b=WI2xpWwQR5AtZrUXTk4dpCszRpEzzHB1J4CI0Qu/ukikj+zpRUc/x4v835gW1Z6R4B5NorukuZJPMaFt4WLpwRbyhC6lynOuRbog6xjsJLZfn7m5kGkSIB9/UEPAbaRhVjwkWQ004m0jZTynLY5jdEwE7ljN058we+NsWtJ3NsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277856; c=relaxed/simple;
	bh=gr+QGcJ/zC1AFPXrM2eyX8oCllpuc/ysmFxvsfANXyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksfdrWT4f3cjRRBgprkyzVyShP6U9NkaYooz6TKRLN/KbcGSmPU7HDCTNsHt5/do85UlAHLew6mYbNYkiF/05Ba0U4tI8um+2AS+f8DnbhYZMVFALV5t4zzTbf0QcjmEi9sTUvlbwtri7kHYpESJEX1KnVyWBjbpMrw/6fXkz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4noyEX8D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so52535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741277853; x=1741882653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XzIG+I9NlmGXCMCH1grBuizviCE0Zw+vO1fKyPynjqI=;
        b=4noyEX8D0M4eD83rXKwVpolhcUeYXwAQCuIDobniLV2/+sZof2mBvDCL9HNh2Uj8Sw
         lSKeBlsFBD9hG0kgRYxeJS6pzDww8zXoba9G7UeoKbHkERXPYnksY920YRUqfoxHK/ZS
         j0oBeRNJYgQ5rtbwbguboC9MqL8aYxd/jxMMb59VC6XC/a6r/EmR42Zk7bU8V4EK02Bx
         LudisuXcsZqbaCIWwuktq4RjHgV34K2nd8NB1X/3Wnk/uxiCKCrs5CyFuhly02WY2o64
         tB5cxDzvEGN0eaCCcV4sbCtdGMthfEkxXyrTreZ6OeH+b3N/nF4+X2gtIZid8IGprFTY
         6Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277853; x=1741882653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzIG+I9NlmGXCMCH1grBuizviCE0Zw+vO1fKyPynjqI=;
        b=Tko6tKDSIpW2WMagyXJUsVCxYvh+WmcAMAVUaWE/HAP0CDhdRjrPZ99ynBylUD6TfF
         2BsHnciccTatAvJ/fzRkQhXUaZLc9qCFDHbTt1g2cEJr6GHYpNI8v9tVeML/Ogx4x83O
         Rv+5BZSTleP/pO2Z6DCxeK+Ab6ErSybb5KwTch6ijV5L5DzHbkeR27FX9E/VhN/sTjDx
         G4CJK67ThWKpA2qA0LCyC8FWzhNSjVf6RF8mCk4TvExDf/BUu1tDr1NaOGNGRpSlsw+Z
         HFsXuVnXbVf45qUQOzdkqnVAHJ3gwqMzgY5L95jacPZUIIdZgNFJ36vkeqfFRVjIkbqm
         Z5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr6A0BeLHdIyrHDl5fgOVnXw8ngPp+TYad/Td7F3qEzcuTiDoE/Ol38iVaBSTW9I68ou/WZBhP8uqwoas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4i7mN/cZw6Nao4Yh5r7ZEi/F70ZFzmXO1bmrckcpg5CGIfLaI
	fTZxj/NAjbJW0+gyDjruYXW3UDf4FKN6adNgqyE00NAa9e8AY+30H/oSHnq1vQ==
X-Gm-Gg: ASbGncsRG1/UBwrp/0YrdraJUIGlosaRhJcX1/2yXpY5ZNl4vQ8K1cLkd1gbXuQE86h
	bekU7BtgHlqXQGnN9WR/Ab16kfmZrx0uEGxjHl4UIkEYXcEjrM86+1csqqVVXDsX/q8UV0RoWcm
	XEUTgffQ5wUoyCsNxpxaR3H1tUAHs0pJbLGfxOLx8Dx0GPJou4GALLyojidt7uFgKv1CaY4Iuf9
	q5/OfXodsQMAmwv1e2CBAigl5YwJLH0NApGFpd/gQVAeKhDNo10QkzMtmJ25OJlh/4WG6T7ZmzG
	6G/6jqmXHAEr5yrxJg4bknc4PdcxHiWE+lQCN1G5PyPWzIQRwXcWQdMmSOyqx3BJQVPQzDHhiah
	ukg9g
X-Google-Smtp-Source: AGHT+IGsHHNZR9C11HbjY6cSeLPINopbox+mfM7DoTvgIhmcRrtEMk7y/uxtTv5B1t0em/wnAY68bw==
X-Received: by 2002:a05:600c:22d0:b0:43b:bfe6:d898 with SMTP id 5b1f17b1804b1-43bdbac5f6dmr1381675e9.0.1741277852683;
        Thu, 06 Mar 2025 08:17:32 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e1476sm2484502f8f.70.2025.03.06.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:17:32 -0800 (PST)
Date: Thu, 6 Mar 2025 16:17:28 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: tool: Fix bug in parsing test plan
Message-ID: <Z8nKmGwSu9RvxbWc@google.com>
References: <20250306002933.1893355-1-rmoar@google.com>
 <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
 <CA+i-1C12kG9t=jqnVaKnvN4xCn58cTeph4QHOTL0+eg98rn52w@mail.gmail.com>
 <CA+GJov5kKD+QX+kdEG3LQun=zo_aPwbA7=1NUw0dTLSGg-h=mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+GJov5kKD+QX+kdEG3LQun=zo_aPwbA7=1NUw0dTLSGg-h=mw@mail.gmail.com>

Hi Rae,

On Thu, Mar 06, 2025 at 11:02:13AM -0500, Rae Moar wrote:
> On Thu, Mar 6, 2025 at 7:26 AM Brendan Jackman <jackmanb@google.com> wrote:
> > Since I reported this bug, I discovered that the example above is in
> > fact valid TAP:
> >
> > > The plan [...] must appear once, whether at the beginning or end of the output.
> >
> > From https://testanything.org/tap-version-13-specification.html
> 
> Hi!
> This brings up an interesting question because the parser has been
> mainly geared towards parsing KTAP
> (https://docs.kernel.org/dev-tools/ktap.html) rather than TAP.
> (Although we do try to have backwards compatibility with TAP v14
> "Subtest" lines)
> 
> For example,
> 
> TAP version 13
> 1..1
>   TAP version 13
>   1..1
>   ok 1 test_case
> ok 1 test_suite
> 
> This would be accepted by the parser without error because it is valid
> KTAP even though it is not valid TAP v13.
> 
> The scenario above that caused the infinite loop would be incorrect
> KTAP (which requires the test plan to follow a version line) but
> correct TAP v13. So do we accept it without error? Ideally, we would
> parse based on the version given in the version line.
> 
> Just an interesting thought. Either way, I will remove the error for
> now as our parameterized tests don't properly produce a test plan,
> which causes errors.

OK yeah sounds good. Now I think about it, I should note that I am
abusing the KUnit scripts to parse the result of a kselftest run. I
just assumed that this would be supported but actually there's no
particular reason I should have assumed that :)

I would like to have general support in the tree for parsing test
output ([K]TAP it's not really a human-readable format IMO... even in
the best case like nice tidy KUnit tests I find the structure very
hard to read. And without something like 'kunit.py parse' I find it
extremely difficult to get a high-level gestalt of how a test run
went). But that doesn't mean kunit.py is responsible for the whole
kernel tree's output! Still, it would be nice to handle it to the
extent that's practical (and at least, with no infinite loops :D).

