Return-Path: <linux-kernel+bounces-368121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDB9A0B72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E9C1C23B57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9159920ADDA;
	Wed, 16 Oct 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuNviwfz"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A169209687
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085411; cv=none; b=QlIOQsBvBQCYlk/jSbfu7gP/4T0zVYVHg9OhmZqd2dlVs4Pm0ls7kLL36Wml5llrEhd3k6ChGjfTVUaBpzx5NjfLWlYoFONCC2jsyft8Q28cUNgo4rq+GNKO/gQpzJ7t5OXRl3One+GFinbct3T0PKFrGHKHqSXSdWAtrb+ncxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085411; c=relaxed/simple;
	bh=9e8h8YTSxbZlnoEsQInmYl/8+L7FVJO2gjIYT1N6uBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN8Z+J5hYcOaYhtDwxK9sFmXNYwPDtNutYQF/L/0Hk+bUw/uPdsRelyDWAAkFPE2rcIFG+bpktZ4ckhKHcgjVwreLEUoE2Gvfz5lIK3logmOyjPRhqyYosP/iGZV/vgQGaDBdDAcnCG/3+MLyERJ2TZK3H1LPbiu/7oup/712JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WuNviwfz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so463568966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729085407; x=1729690207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ao59t5O1QyBE9ZTbCp+/84/h0y2L5JOpOVIMa+Mgf5E=;
        b=WuNviwfz1gRPtagpdF0MhB/v/WjcSnStOrOGO7f9qanF0aymUHkeV6r0u30BidSe3q
         Kd1zvvkX7MzL4gFSeBMlNyPf8ginzRmKsc2UxdOttkKdZ8QahexVMaoWy3BybaBYkJUj
         1eey4j/Dtk0+BfXCb5qYD/F/96c2OQFJ9NnBNdV8he8q3yWyd6mstcJUW5uZkUEYYKhd
         l1NZyZDAzW7LmIc32it0sfs4yiwcjfJM9yzMPh4nDksmsVk48UC/BOvyRJpXECnoik9n
         LCodNQGAMP8KhZ0+IoGtcdbsmgvZQL8h/WEV+qpIuWeIzz0xZaAPpG7pUm1AEZpSG2ys
         VqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085407; x=1729690207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao59t5O1QyBE9ZTbCp+/84/h0y2L5JOpOVIMa+Mgf5E=;
        b=WGefWY3/QC4ypFWuZ1WTI9YJ2+HcaikDaMyRn6ZvicPeGEDbhrMjJg3FOzdqEsQp+g
         Wyoz7HqcX8L9ENpUC4G4GT6fX8VAbxEKiIuh2mC23dNJdShi9XWmU396GOkbtrNQ++j4
         APuXk+j6yOqRargWHJm5MIsMpkmUX+GjpnhNoqH+2qZx1QBdsqEUjNqNN4PY8AgrBSyb
         UXzWGE5EAJ78vKPgzrbl8JwUvvAEEG8gaBjqQhz0gAGgQokvkGEqWhprVU3pIsACyAgZ
         McAQrB0b8Tl0qN0QK40VwZYdBKF+3YNbqq0nUGXYG52QiSdoM8pUeYsPez5GjL3IlG4M
         G5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVwuChgP2S9T3VPqHNc9iw4bOLTA4tvV6Gw5qZbW5idkE3HEude5hrph/wFM51EI9aJ4yyFcK1JlI8st9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtogRe9IYh0xkNC+Hutvjtzo5Mh8/Piiso0jXpR4UrZE7OYeC9
	ieKvPjZgD3uvya8tTR/C+zfVnWNjQjKMtwoa03r7iXGeOpHoMMppWcr597InSik=
X-Google-Smtp-Source: AGHT+IGt35vgRrWbivk3146TES2YNJa8U2VU4Ujk8u7PillY1LptcboEXTfbwCeWiP4uTFVrASD/NA==
X-Received: by 2002:a17:907:9727:b0:a99:59c6:3265 with SMTP id a640c23a62f3a-a99e3b20c0bmr1419373166b.9.1729085406838;
        Wed, 16 Oct 2024 06:30:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298176a6sm187043066b.135.2024.10.16.06.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:30:06 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:30:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marco Elver <elver@google.com>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>,
	Haoyang Liu <tttturtleruss@hust.edu.cn>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/dev-tools: fix a typo
Message-ID: <c19c79ea-a535-48da-8f13-ae0ff135bbbe@stanley.mountain>
References: <20241015140159.8082-1-tttturtleruss@hust.edu.cn>
 <CAD-N9QWdqPaZSh=Xi_CWcKyNmxCS0WOteAtRvwHLZf16fab3eQ@mail.gmail.com>
 <CANpmjNOg=+Y-E0ozJbOoxOzOcayYnZkC0JGtuz4AOQQNmjSUuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNOg=+Y-E0ozJbOoxOzOcayYnZkC0JGtuz4AOQQNmjSUuQ@mail.gmail.com>

On Tue, Oct 15, 2024 at 04:32:27PM +0200, 'Marco Elver' via HUST OS Kernel Contribution wrote:
> On Tue, 15 Oct 2024 at 16:11, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 10:09 PM Haoyang Liu <tttturtleruss@hust.edu.cn> wrote:
> > >
> > > fix a typo in dev-tools/kmsan.rst
> > >
> > > Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> > > ---
> > >  Documentation/dev-tools/kmsan.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
> > > index 6a48d96c5c85..0dc668b183f6 100644
> > > --- a/Documentation/dev-tools/kmsan.rst
> > > +++ b/Documentation/dev-tools/kmsan.rst
> > > @@ -133,7 +133,7 @@ KMSAN shadow memory
> > >  -------------------
> > >
> > >  KMSAN associates a metadata byte (also called shadow byte) with every byte of
> > > -kernel memory. A bit in the shadow byte is set iff the corresponding bit of the
> > > +kernel memory. A bit in the shadow byte is set if the corresponding bit of the
> >
> > This is not a typo. iff is if and only if
> 
> +1
> 
> https://en.wikipedia.org/wiki/If_and_only_if
> 

Does "iff" really add anything over regular "if"?  I would have thought the
"only if" could be assumed in this case.  Or if it's really necessary then we
could spell it out.

regards,
dan carpenter


