Return-Path: <linux-kernel+bounces-413438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E129D1906
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E872815B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337631E501C;
	Mon, 18 Nov 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxYLiZdl"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776B208A5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958592; cv=none; b=SbkA8eEg9KVi/DTc247x21OV1r6SQ5dMxWhW8ZuAg7/JQIf93oNjXK1tS9jaXjmrujjYGupUFv8GSEWH6eqMz1LmGySUijTjjl4572nryHkFfU+orENoxtmvmKy1Vxfbmaz4b7abQH1iCsbYaLrJ/50XMdajWWJTOf0s18xXgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958592; c=relaxed/simple;
	bh=ZqN6ut5dSfU3Bti48mWt3vS82j33P1ZVeJJ3WvgEITQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMYzqzx2/jptB0koREQMvsGJFw9os2KBSJpFFbCsN0WYlLGeMuEnFmJsJPiAQDHZe3caRM3EMHrw7iOSq+Lf+xOFqOcOBx3fFAYm75XzAWVGIVeHLqEso2zSS9n5QKTCnf0IIzDVCi/sHjEyEhlrydfo3w1pUpSo80Py70vYmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxYLiZdl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53c779ef19cso4276252e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731958589; x=1732563389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9cHoNsJX6d/IATsERIAcBhEOeUK5vYwNIayqBP5ZTFE=;
        b=SxYLiZdlPEnjaDga1BysOgDEZrupj9XNNIbGmsI3rDOqhH0SSgPNZRF2uhd69+rEVY
         wv/Xl65uHNH8FV+jU71VcToY9J6Kpos8TJuWRcYvLPSShvscafwtQSwVWUq+rSPZL810
         oj8vFTS7gv1xx8YV6q9BNxLzhHGRpstgFCEfXDvHdx09g5uo13EghpkE4nHETElyLr59
         +StrYb+Ha9welUlCrnltwxKilZOi73CAkIiT9zHNiQ1SjZjibobZt8lM/iBcZTnLAPqh
         Ff7dRtiHBwUKE5WYrlabEjxYM66/h1EOokIWpRnzIsVT1kWfVwtXItBCV8GzfjjEImGv
         4Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958589; x=1732563389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cHoNsJX6d/IATsERIAcBhEOeUK5vYwNIayqBP5ZTFE=;
        b=mUvQ/hH1C1RYcxLJbq9LYEr5qQn1q2J6xb3X29oJ9NcmZZOFqpp7KJcC3T9gz8fNnT
         k1CeXaeIMzD6XyoqZ5RfzL8cYuM+lAfvCKcwHtiFC9NL1i78l7qGA5TH+2+Hru/tjRfG
         Wva5LdusThVTLR2p6OxgT/X+AIOGHKa7ZulaxboduSNgUZp5e/GEhIRzk6eJygle4dLO
         eBMrW+aLBRhpZMXRYT1OYPI+5ORirZTu85gsF4E0qs1RaH7TbjXREnNM0XNTzQ2IYc8u
         FEKsCPWHQ9gXOWPyYECqsuHF1Fittkf3Dar/VaWst7zsQfdaka+2/oNrseMzvPIpoCst
         7M3A==
X-Gm-Message-State: AOJu0YwQRmGPhMqbMnht2bKV/vjui+QavnS4tsviiFmMmnA7UrxWPDBh
	fMP5pURggwAGl6C/sPZm95U1d+jRH355y0l/ctq+6PUycUY1o4Ym2HNcFmcdFf103/MyzYSMpus
	mNpkafw+/mI5ahOXvj4NRV8tsbHE=
X-Google-Smtp-Source: AGHT+IE5DUGbxw8ccFHGYFtiXj3sXb1tweaJ/+BvQxj1DGp30XOil935SW3Ok17xJKvvLAMG/y2TlxQjnVQdoUXn0Nc=
X-Received: by 2002:a05:6512:224e:b0:539:e7f8:7bf1 with SMTP id
 2adb3069b0e04-53dab2926a2mr6069417e87.2.1731958588890; Mon, 18 Nov 2024
 11:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104053824.36672-1-advaitdhamorikar@gmail.com>
In-Reply-To: <20241104053824.36672-1-advaitdhamorikar@gmail.com>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Tue, 19 Nov 2024 01:06:17 +0530
Message-ID: <CAJ7bepLDK8C=Vyz0QDuBEP4eCE5U4O7rM7KAZnbeeiRv__v2UA@mail.gmail.com>
Subject: Re: [PATCH RESEND] scripts/checkpatch: Fix multiple Reported-by:
 false positive warning
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Joe,

Please let me know if you have any feedback for this patch,
if there's something more that can be worked on in this fix.

Kind regards,
Advait

On Mon, 4 Nov 2024 at 11:09, Advait Dhamorikar
<advaitdhamorikar@gmail.com> wrote:
>
> If multiple Reported-by: tags are used, the
> checkpatch script throws a false positive warning
> even when there is a Closes tag following the two
> tags. This fix checks if the closes tag is present
> after multiple Reported-by tags.
>
> Here is an example of the same:
> > WARNING: Reported-by: should be immediately followed by Closes: with a
> > URL to the report
> > #10:
> > Reported-by: Kernel test bot <ppppqqqq@ymail.com>
> > Reported-by: Some Person <xxxyyy@gmail.com>
>
> > total: 0 errors, 1 warnings, 0 checks, 8 lines checked
>
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>  scripts/checkpatch.pl | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4427572b2477..c74519f02180 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3188,10 +3188,13 @@ sub process {
>                         if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>                                 if (!defined $lines[$linenr]) {
>                                         WARN("BAD_REPORTED_BY_LINK",
> -                                            "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
> -                               } elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
> +                                               "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
> +                               } elsif ($lines[$linenr] =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] =~ /^reported(?:|-and-tested)-by:/i) {
> +                                        # Do nothing if the next line is another Reported-by:
> +                }
> +                               elsif ($lines[$linenr]  =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] !~ /^closes:\s*/i) {
>                                         WARN("BAD_REPORTED_BY_LINK",
> -                                            "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> +                                               "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . "#" . ($linenr + 1) . ":" . "\n" . $rawlines[$linenr] . "\n");
>                                 }
>                         }
>                 }
> --
> 2.34.1
>

