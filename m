Return-Path: <linux-kernel+bounces-433837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EE9E5DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FA5284370
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327D22B8C8;
	Thu,  5 Dec 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ItKh7b8Z"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8021CA1F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421248; cv=none; b=kSd8zGW+jvmYdicO3NQYTD37s2iR+tA3UDwMiAQOV3hCl2GghpxnMV3gDerdztkdmBPRpvnPMuMaZ9D975jgsbjDsrrhPZ3W/7HrfqEG91+sb8cb4FIktjmahfQjQ+RNaMdJ9IRCFVhTw+7tYF8TvBe/ujI36Mvt6tyyYIRVJo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421248; c=relaxed/simple;
	bh=NrNsHwGTutSb+j53Z8p/SvsXXRvumsBziuxOIsnWL54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM1MWNQ+VBW+J6mEZWqYZZRKSycf84AUTKTwwIx9mcCYxZnVoXepyTSJW5LYvK9cGCdV8KiZCVXkZ790CxNp/7tmV4TPRdgHUbkvP8LzMrsExsiGIQbt734g9oeDFuaSTIRowXoW6GXeZZq5/I8zqxJfb5SLROi4J0Mc1vaCDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ItKh7b8Z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-466a079bc5eso8722881cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733421245; x=1734026045; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYgVPkOe96gl524ikul/s07PW3stvliLI253K6Wg1VI=;
        b=ItKh7b8ZtPsOiYKby0nGA9Vv0g85COF/N2OAOeoxw54uC03g9f6eZFTgwyBKad8hkr
         /iGwnAXA7Oc1zBwY1dkfZq1V4++38FgDUvQAxhMZ5UzdphwEgBF2WWj8zDb8/hL4NvIG
         Dok1Sqwjs5CWnzdgkLlGBsIT032yIC94n/YP6B56l6MGnzNQ5C1VgDzJBLnnTJIZK6Xo
         5Pi5+xzBjqIIeLzkmTszxRBQggybMlvbbB1bNM/JYgjmJnwuDOtN5havaWjBcuyo+FJr
         ecuHT65CS5jSknw+JdaTmRrNIEjM9MmnVfxPdFTf08iFn0ccik8A0tT87+zjqQlj9b0a
         4SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421245; x=1734026045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYgVPkOe96gl524ikul/s07PW3stvliLI253K6Wg1VI=;
        b=b5LCfTlwGr22P6OGswgl4HtfKVmw8xWfKclcbyiGnyuerZ6D2NRMlQKQBDZwV1b3Uj
         PMH7Imm5NiQhhUueJD6EbRsV5Xwr6yDH8bx8QEt2DfsPrzV/CTS5SCPXH1BGc+9WjIOV
         dy4pM4pL/m2OlNn51PYHToDbl8HUME956Hf6ziBvEl4iBrRLoIsxNv0z/os2l5jXaR9y
         A3eK19mE6kE2WnW8/1tDb9MYI9wbEYVZ99PsR4ZM/tG42ffL4isoVoxasMoQGra+79h/
         Yov2+NaVbntXDozVOfJaNYJNNRFyu55V/B0X7gJWUG/MnIZH89oM8D8zUaM1lO2qKPRp
         7zzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzZyvkUq+vq4BjLHLK51ZgZ1LmtpckYCzVqL81+C9THGla667kFi8Vp5qW5l1MWaKUQC/wHDjxSx4ktS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMv+nnRNy1PyJrwAhF229Mbt64ILUzpAUclc8yroSWr9C4gnAO
	lU1Oxe9kHX92Z7B973Ygq4TxslmOdnceyHOOaNecnZoT2zf6LYXfVuZAe7nbwg==
X-Gm-Gg: ASbGncvUEGa231KXk799GyT2SCBbf68VOe30a2Jx8/TyPBXFBhuL4/A4xvyXP3oUPAI
	U+kD2athldmr3e5iVarfJnInA/w/i1kaucZkMP4OfnifEVJU7O/ylf3+9LXeZ4qkiq/ltQiBYdr
	dL40aDOSDpSYo0TgB4FeHqJLmtpM9gjmVvhHl9RIg0y1qh+bY2FdLnAUzL8i0CNdWHcvZM7a99K
	WMuIWShZZf4+9seC8XinkvrUtEzkvDrfv24p8qnKJxHwrdHjb4=
X-Google-Smtp-Source: AGHT+IGb29mWCRhahHhtntwiNrAEVGs70SziiP5bXKIajWVs6GTRPZDdEJuj1FVbjG+BGFanBTN0uA==
X-Received: by 2002:ac8:7c52:0:b0:466:a742:48cc with SMTP id d75a77b69052e-46734d031cbmr1816681cf.32.1733421245608;
        Thu, 05 Dec 2024 09:54:05 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::d4d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296a6798sm10199521cf.6.2024.12.05.09.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:54:05 -0800 (PST)
Date: Thu, 5 Dec 2024 12:54:02 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
Message-ID: <ef8b9ca2-8b23-4ecb-9c41-01412475976f@rowland.harvard.edu>
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
 <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
 <CAJvTdKm-7LbbeRkLpTDW5WBLR9vVNzjNhYWeRvM+Y4myCHN6uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvTdKm-7LbbeRkLpTDW5WBLR9vVNzjNhYWeRvM+Y4myCHN6uQ@mail.gmail.com>

On Thu, Dec 05, 2024 at 12:24:29PM -0500, Len Brown wrote:
> On Thu, Dec 5, 2024 at 10:09 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > > IMV, drivers returning errors from their suspend callbacks without a
> > > sufficiently serious reason are kind of a problem.
> >
> > There is a least one driver whose suspend callback returns an error if
> > the device is enabled for wakeup and a wakeup event occurs during the
> > suspend procedure.  We don't want to ignore those races.
> 
> That driver should invoke pm_system_wakeup() on that wakeup event, right?

Should it?  When the system isn't yet suspended?  Is this documented 
anywhere?

There's still a race.  Suppose a wakeup-enabled device signals an 
interrupt and the interrupt handler runs just before the suspend-resume 
transition begins.  The handler might end up calling pm_system_wakeup() 
before the suspend starts, which won't accomplish anything, while the 
work queue that takes care of the device's events might get frozen (as 
part of the suspend transition) before it handles the new request.  As a 
result, the wakeup event will remain in limbo, not aborting the suspend, 
not causing an immediate resume, and not getting handled until something 
else wakes up the system.

Alan Stern

