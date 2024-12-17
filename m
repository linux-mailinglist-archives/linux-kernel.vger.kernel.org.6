Return-Path: <linux-kernel+bounces-449814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8B9F5676
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61DE7A3BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283891F76A0;
	Tue, 17 Dec 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WVGOMTqA"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA6155326
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460989; cv=none; b=QNy/6Yxtpnyh17ANHjFeF2QpnqAFEf0MC9calduRiiYuzttjqpLq8zOY1PUUIwwxJ+KAtgbnGirz5ptOulME0P97ko4A33nctmU/TdJ2N5uWwjcF0QH3gJL6uSX55dgeh52pSjHyFI7q0X48w4tO5tbdvbobnB2Mw9bCPkvt7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460989; c=relaxed/simple;
	bh=MFBOghCFQxrMYgoC0DhigqYvAwhKz8jTiCtMSSCoSqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNiTAULfwLTBvdP7fftmoc78ZxIsZjkJSvpVDFnVpe8/uWtTpMRe6lIRVnUSFbIbh9FXK+rfaXbJshJtjC8SXiB62ELusIzRqf1Spn3GlZqcBwiqsMr3bukmKI3ZoYckaAlcyrxUJ+4MaQEcf7QxCaAAmygS8yMWnDC0deL1p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WVGOMTqA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so761588066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734460986; x=1735065786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mQXudYgFs4URfCivrY8wmstofKcT17DyeXJ55pVZ80=;
        b=WVGOMTqAqmsIikGyvdcwcELBSLjetSb8gEyUVs5smCmv7cBWrJAFp5FwgwsQOK+zXF
         63FxoTRkGgPnJuYJJcqrXbnw4L86vVPw+cPPZv8xlPxxF4de6vrYVTzbgBsyGGe1aG0S
         ZB26qqglhAndBFMZWkQU5nFM+R2FWqG2tJYzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460986; x=1735065786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mQXudYgFs4URfCivrY8wmstofKcT17DyeXJ55pVZ80=;
        b=L7vx86pW51TozCsuS7hhvVJPiSrlq3PtdgdLWqUzdiTAL39TPwvuGkD7JRlDzlEBXe
         FZbqzTdf52+HfP/5X04y854Uzp/OoWhz7eZQrbxeS7l3RzWp5jmLHGoVQAGO6v+RL+Vs
         BfarTBRX6fmk0Y1SyZf5cdAnuyA+mDNT5TDFL8vEBhNfdXaL4q/9My4LTt2SwmjCs67F
         +f48NNhsC54DGmIfKyVBaUpdBDNGAV7SPtEurUbJ+ZTuZ/FE2yTHznEBiU7cF9r+scIW
         LcnNgE7OhIm7uloS9jSsh017nWs/SmV1EeBFTf5Ut0K3NhgXtGYU5x0B+PyAwmMDj49G
         BmLA==
X-Gm-Message-State: AOJu0YyotM0SFkn+4ap8IUhDbM2zIv1OBI4eDd46jAStb6oRW63wg3Ru
	cdYb1GJRDY7xZznvPI3V9AO8dJQYyvXds0NH18ykHvjRmyHt9EoDSR+ubvwKFG7TTPbR1Qffkqx
	BPXA=
X-Gm-Gg: ASbGncuB/IPGA2yFlSnCDlaoIpOzdGkqDHsD4ggXaQmx9eLdEpKpxi+SCsBE+hc5gJU
	ar3+h4ux9iofj78QQ5DPW9rL0/+g8I+PdfsKmUNQei1ZUwYJCw3nMcQJD2JBDGm/y7mEqthH3KG
	RTo5sAPILVIHHoXBk2YZMMdmwjldnp2vsBfJIse1w6ikHOzSYOgQRa8PKbWyLLddECxyqOpKQLC
	4+M9Cfw9FSNxVFcIxF9xJtkQD2YY7hnp9d73NoLSOCSWt/68r+9gKQo0bOqgSYGJcQYNiKEPmdI
	DEQJZ/Hn7sJfHc37f5SuxnaJ8kwzzzs=
X-Google-Smtp-Source: AGHT+IF/qzIwcoyejTQxAuMN6U3zfMp3+4oEFu+2x40hXfV4zwc9eAoEbzJJUVDe2lwzpjEaK3vHXQ==
X-Received: by 2002:a05:6402:40ca:b0:5d3:cf89:bd3e with SMTP id 4fb4d7f45d1cf-5d7ee3fd177mr298191a12.30.1734460985842;
        Tue, 17 Dec 2024 10:43:05 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab50desm4743340a12.3.2024.12.17.10.43.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:43:05 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso779048966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:43:04 -0800 (PST)
X-Received: by 2002:a05:6402:40cc:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d7ee3b57d2mr405372a12.18.1734460984008; Tue, 17 Dec 2024
 10:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home>
In-Reply-To: <20241217133318.06f849c9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:42:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
Message-ID: <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:32, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> How else do I get the function name?

My initial suggestion was to just fix up the boot time array.

I think that's actually wrong. Just print the raw data and analyze it
in user space.

> I can make sure that it only works for core kernel code, and print the raw
> address if it isn't.

Streven, STOP HACKING AROUND GARBAGE.

Your solution to "I had a bad idea that resulted in bad code" seems to
always be "write more bad code".

STOP IT.

Really. This is literally what I started the whole original complaint
about. Go back to my original email, and try to understand the
original issue. Let me quote the really relevant part of that email
again:

  This stuff is full of crazy special cases for things that should never
  be done in the first place.

Note - and really INTERNALIZE - that "for stuff that should never be
done in the first place".

You started with the wrong design. Then you keep hacking it up, and
the hacks just get wilder and crazier as you notice there are more
special cases.

This is now getting to the point where I'm considering just ripping
out the whole boot-time previous kernel buffer crap because you seem
to have turned an interesting idea into just a morass of problems.

Your choice: get rid of the crazy, or have me rip it out.

            Linus

