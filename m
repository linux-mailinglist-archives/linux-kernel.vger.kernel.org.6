Return-Path: <linux-kernel+bounces-255798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E26393455D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6CDB21BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD879EA;
	Thu, 18 Jul 2024 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Di740ZIG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C364A02
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262191; cv=none; b=VLHo8y+799YtPbAwSsxDHxJ8zGmPygez49RqH0zWRteSHfzlxyzzr9DxD6vg0VMiJ7XeBGiQ9g/pPCas+7EvWUT61+BUs/j/N0YY453Hhl2NO7qJ0mmda873rsGXEJjYOsyTDFDZKgvCXQhYULxyZa4GjOqHhIj2zD8Hhmn/oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262191; c=relaxed/simple;
	bh=L3zztIlyA1ycT592luYaBx1AfG29G3i/a1u20U2mPCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=l3jK+JM/xvHMhfHERg8g+OrFkgQ6RBtzui2zBdMTmqUpCHgKPERC080bA8BDVhsd8w1aT+MbMNZLz+glDMM69OSApu3z/+R0d18mX9JVFP/oVO3/193jEuZMGihSrxjph2cfXDF1NK7WG+hm1+Hn/Woas/5Lgv9eRoteSPSjBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Di740ZIG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a79a7d1a0dbso16707066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721262187; x=1721866987; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72WbVH44i/16Etq7iUNI2JboVOFCeVeL925LyzElDFM=;
        b=Di740ZIGsub01MyA2rBZUTcilWKahEV2DTI97bc8qqcMUASkA/APzYehDaEJZl7Uny
         P/U00AzzaO5bDdz2sJkY+ZKvxjpdQb5PG/DK6qF766Qw1NLbd7X1Lufx71oNCeQfDxfh
         fAEpc1dsjvra9om8DvkEk7GVtqsIhApDIdqGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262187; x=1721866987;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72WbVH44i/16Etq7iUNI2JboVOFCeVeL925LyzElDFM=;
        b=TnzC0NhMRn/dBWHY+lxTK3aLeGZQLdoPaqJ6HiDk6mEsdF4l7Hm937j7N2h3XWIaXZ
         g/rwrJlq6VoGy3VjrKLztb/MoGPHMKYiI3VT9HsGBccJWYCMsYKRjstFTf3jgv3WIXWm
         bN69th3+W3pylt3yDLHVJ/4wNCGYBmZiTlype0FKbnwgzzQ9bJ0J0L8Ak1sYU2/pPm/a
         OCZa+LoDnpoc+o9Ffx2e0p8RxRYmf8VsHaXwvJ9w2DrqW9IjNpWUj7Dsr+wbtFwo/g3m
         Y0kxWGbxnHcsmGcbjb5L2jsp19Wq7Ao/y4hmp4T0H08mLxvssUdjiVYMEHRUTIqjzZTQ
         ZyAg==
X-Forwarded-Encrypted: i=1; AJvYcCVF/8EUuv8HznopiqkFUpPd/NZLrZUoW+iD+Ra45pxB7d28/zX/VgP/jhxLagKusEMI6swVdWKSAGjQDeyG5v1F8BliybCEy2dMBbUr
X-Gm-Message-State: AOJu0Yy5ga/QZAoNcq/jsq9sDtwV7/mUy5Ny0T+hh6U4cUtiJDgW+MWU
	uZfiHZDAcoBTX6FRc93D7ZgjjkrImqBrKSIVQlWAp2CbF5wPKSSVBxtbSbo/7DrKnDV0qoeFRI/
	sOxAVaQ==
X-Google-Smtp-Source: AGHT+IGqqKjXYgqY9hLK2jGS6Zcb5ZTNoMigQ3rHW2ZA566ULGNPh+l8UpDvHEnSKZOXWYGDN99S3w==
X-Received: by 2002:a17:906:7187:b0:a77:c364:c4f1 with SMTP id a640c23a62f3a-a7a013478ccmr201794966b.46.1721262187118;
        Wed, 17 Jul 2024 17:23:07 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a34casm505704466b.13.2024.07.17.17.23.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 17:23:06 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so192005a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:23:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSU56ZgVDwSiXZNqqaOWfuuLdnEvjPSz0lGZxgs2g62P/YWEg4cEKSWvKj6XLe+fPOcI+DHvvnNo3V8coQknSgxZQz1ik+1U+Dy5N7
X-Received: by 2002:a50:aa9c:0:b0:5a1:a447:9fab with SMTP id
 4fb4d7f45d1cf-5a1a447a39fmr127340a12.28.1721262185767; Wed, 17 Jul 2024
 17:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpY3X1tggZC3s_1X@shikoro>
In-Reply-To: <ZpY3X1tggZC3s_1X@shikoro>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 17:22:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigtUnqv+RXkLZ2TwqV35YQeGrYsMnrowpnmQNN6wyhCg@mail.gmail.com>
Message-ID: <CAHk-=wigtUnqv+RXkLZ2TwqV35YQeGrYsMnrowpnmQNN6wyhCg@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-6.11-rc1
To: Wolfram Sang <wsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 02:03, Wolfram Sang <wsa@kernel.org> wrote:
>
> Most changes are in the merged requests for I2C host drivers and the
> at24 eeprom driver with their own explanations there.

Please don't do this.

What's the point of saying "all the explanations are somewhere else".
That's not the point of a pull request.

*I NEED TO KNOW*.

The explanation is why I would pull - without that explanation, why
should I bother with a deficient pull request?

Because this all is the whole point of a pull request, for chrissake!
You are requesting me to pull, and dammit, that means that you should
explain *WHY* I should pull.

Not this "there's an explanation for this elsewhere" crap.

That just makes me go "ok, so what, this pull request is garbage".

I have looked up said explanations, but next time I need to go look
for explanations I'm just going to ignore the pull request as clearly
just not worth bothering with.

Because I'm not AT ALL interested in getting pull requests that
basically say "I'm not going to even bother telling you why to pull".

And if you can't see that, I don't know what to say.

               Linus

