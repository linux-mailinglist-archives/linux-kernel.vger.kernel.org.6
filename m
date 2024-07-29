Return-Path: <linux-kernel+bounces-266215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85E93FC90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C14B21C92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C60B16B3BA;
	Mon, 29 Jul 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z3T0vSWg"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3D17C7C1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275060; cv=none; b=j5afq+b2AeaWgXm7Na8rnTABetaBYQOfyDGrTzK9RJIFXskMIEK1C1qRpZGttXhelEYfj+Y2ZzdN5rNRSp/3PTlPa1bQ/JbWcXsIgHZWdh/HbZNTzCDhzTU952lXU/Xs58Qm4iXhGIuz7lz1kpt0ZnjS/4Qh4HxNRkwcJHw1BW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275060; c=relaxed/simple;
	bh=ypwwnBFKYTroVX5TGGRuBoOnIzOAQBfkm6PQThWbFqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1Dzz2ikL8eyddSB0+SaqLAXbuvmUdPOkv6MBmqHNHc6Rhy2ugbTUpNelVDWMwbwWWgt+FQpcJF8LwtySLDAyW2LwlEq5n+TECKIsF4CarEzDuh3umYhj0qDew7RZ5BTbVh3NEGcgAcN+5h5SAM2Jvre9mJpZFBV94eW/hoiqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z3T0vSWg; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so56582331fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722275056; x=1722879856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5VpoOJlnZJ8oPH19GJcs9MFvH4abgGshQxSK36fW6FA=;
        b=Z3T0vSWg8lKwZOKaDCT8uIG24I1nQfF5181ocF5ZxWYIrL/6a5rEFAQ3XpPwcUbmgS
         Dc7deGV2v2bQWKyMGA15TA+Um1dv+PgNr/H01/hV0Loios/adTsQrsfW2C7meLdP9ht1
         QAbDIscjpI/YiEl17P7Gp1o0hU9BwGoGFRaV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275056; x=1722879856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VpoOJlnZJ8oPH19GJcs9MFvH4abgGshQxSK36fW6FA=;
        b=gpDqv8vkqBuBg4BvUQZyyMP/57nif4CDVnoUn3yNNAv4+Cy+57rcQNQixxeigaCyHS
         mARJ2JFzMbRib/8t155GI9Fp81xroYF6XupBELeyyq/c1TicBp/zWVwIXFmyF54cZkFh
         Q5r9wkRGG4NWxT4ngGymi4HsHwPGDPB4pid6UwV+bKd1LE2pvWJKZmRwmqsSacb493wa
         B48gSK+z3Z/NGGni0xhwgumVabzUW7gOYOq1r5u4UOiw9CZDNzyGamkTI1P2Fw4oaS+3
         4GVD93wVZkgW43piYIKAvOzJAFG7mCyw6vvUY0UbGE3RVLihPJtcJf6tf7mybj4mNF+k
         wlgA==
X-Forwarded-Encrypted: i=1; AJvYcCVIE49uYGMkth8orVjtEh0kyIqf8oOq+fuv+cXuN5D9MWDtlj57NDwJayXtV9IqH/u+Ep780KlBHes6c0nYu7xCIO+EPq5yJUMX8lmP
X-Gm-Message-State: AOJu0YxWm8TN+SSbf+t/9HhRUvlhZyGUq3OpMShTD0FcJotn3xzEUfDL
	/cNiMJ3OS1HqtKLHEBHX5wrv6CsEGAAs3vyzoRg755w3lL2lYEfqelrLHYL+UKRO5khssHKP5Vl
	azBHaSA==
X-Google-Smtp-Source: AGHT+IFmNnkayWwr43ZPKrtUtHHdgTo1O90OZSwueekmG4Kw0C1+yC2wWVyn3NB+PYnlh6kRFStX7w==
X-Received: by 2002:a2e:964a:0:b0:2ef:20ae:d117 with SMTP id 38308e7fff4ca-2f12edfed9dmr68751521fa.10.1722275056366;
        Mon, 29 Jul 2024 10:44:16 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf30a69sm13831951fa.44.2024.07.29.10.44.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 10:44:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso59321981fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:44:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhi9LB+UJB6jwI6YMtEEtrtOMSEQXAqSaeQYbffZMdmChcffPTS1wJiV7IHf9byfvhBbZjuyYEg60/Nd9YJPzt76WdoS3kMp5HFnBJ
X-Received: by 2002:a2e:b019:0:b0:2ef:2012:eecf with SMTP id
 38308e7fff4ca-2f12ee28995mr64166721fa.26.1722275055045; Mon, 29 Jul 2024
 10:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7eb34e0-28cf-4e18-b642-ea8d7959f0c7@I-love.SAKURA.ne.jp>
 <2024072944-appraisal-panning-a0b1@gregkh> <f9b4ff23-ee3e-418f-b65d-c40fe28fbba8@I-love.SAKURA.ne.jp>
 <2024072930-badge-trilogy-c041@gregkh> <Zqe76gATYUcDVLaG@google.com>
In-Reply-To: <Zqe76gATYUcDVLaG@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 10:43:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgweFg4hOus9rhDEa437kpkdV88cvmOHeZWwhgSa5ia1g@mail.gmail.com>
Message-ID: <CAHk-=wgweFg4hOus9rhDEa437kpkdV88cvmOHeZWwhgSa5ia1g@mail.gmail.com>
Subject: Re: [PATCH (resend)] Input: MT - limit max slots
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Henrik Rydberg <rydberg@bitmath.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 08:57, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> iThe other types of warnings, such as the warning in the memory
> allocation case, are warnings of convenience.

No.

They are WARNINGS OF BUGS.

They are basically warning that the code seems to allow arbitrary
allocation sizes.

So apparently you've been sitting on this problem for two years
because you didn't understand that you had a bug, and thought the
warning was some "convenience thing".

I'll just apply it directly. Don't do this again.

             Linus

