Return-Path: <linux-kernel+bounces-192808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C78D227E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9911F2473B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A3224D1;
	Tue, 28 May 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdpnJJ5j"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE917E8E6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917435; cv=none; b=nB3uFdorIK7ayk2IqFGyV8/Z0isDs592yvWXvnqJ1AbpVLPXsHB713maXutRZDSOU+J/RTo7cS9ioJVYZq47FQbm8CQu5tY70yeqm7ramBPQBcqIcu+Wu5J+3ex/+u47Vmjm8Jnf7RKXcRCkBhMRULJBRk8YEHpP+NWj9KtVvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917435; c=relaxed/simple;
	bh=KGx/wumGhf3qNCMf0kJPQWaWTf0TglZC8EptQFFR77k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s5QRyx5zZfE0mhtc22qz98k9ZnjqaMdIiile/YhXedrb6bz/R27fSGE39WFHQdE8+jdIfcplzMzxOOzJ5ikZmSa8Fk+Arj7QfdK8I4J396A/9t/AS1OjzQXLewY/IQYUeRLFW/k0zceXN0J+uEFGPVRUtDipZkCTUl070BvQg5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdpnJJ5j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f4a5344ec7so212205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716917433; x=1717522233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5NMJAa0oCy+b2YV+284BegcExfEuoJFA55q3jP4zsXs=;
        b=TdpnJJ5jFN1YU3Cw8HZclIISR9eS9E7QMt5Zj4eMJInCBy22fhFQDpIBySCQ8kKqRK
         5j/rduumOg1PJstf0mIF5NL5PMmKoyWWtHaeMnkDznOxjzbz5ppGdeHyvtkCmRuHcIFE
         93ANWIErPyzh4iUy+cwzDhSUTvXsfO+AISBf2YBmgxYzrGQUjnYuRsIuBvxW8+7GAyGP
         vPenHAL67MU3ceNq6vcUP3vEuIrT7w1wKOHfjOyGr+E6s52u6YxHcGM5kXj5aO9oUZtn
         b28mTreIVlHDwSFReqlz0GM3abvS09NEwe27eakrIXBmT1hvW6wTJIL6CslOK9AEh0mI
         p/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917433; x=1717522233;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NMJAa0oCy+b2YV+284BegcExfEuoJFA55q3jP4zsXs=;
        b=alaQNwhs82I2JI2W7ulVC+RIC2K3epQULjTTaPf3eRSU5sSN2YNomqHhRNoCiGTn2z
         5bBd0JsVBsgPh1gKtnY0SoR1f84/DwEjMjNQVzqghlqiVUOTTEWkwrrk07s0k3D4Wcph
         auRSgKLZkdGO/a1dlbAIn8biFbSAm3esGEDP1T+tdDaMnDwaCEMFQO8MVtBRN+S2wq+V
         M2hINoiylfWXKlzQdKLFE+h8TvYAu9OVzdnxlTg377NKYWoFb9U35u/SJc7GTGSyQqU+
         rrPAVv+TVVOVFIdYljRGUmKgSAci3aWxKsgftaFHp6dALf4Wk9Ib5r5Sx48NEPzuynIK
         Hc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2LmicMzPzeSUCsbK4NNbtPj14DK59dueWbJMGfXD6GO9fxeTehKDDH4iHTueGB9WyF8kUPyW2D+QM2Vr1FVGnCthyNagavUpQrfWA
X-Gm-Message-State: AOJu0Yyg3nojLQaRpUlMZDQa+uVMNIgVhwzhL6IeHtqk3zpRHz6vnYo+
	blan7GQiPYxPKNZDbvrysrCrYtEaN5NRD84/dUXbPKzdmEeZOvArIuZvCxXrRQ==
X-Google-Smtp-Source: AGHT+IHgAHjB4Wlkt4yAEi+JpDmXVPbR1Nq/FEWvgC3tdSoc8iD0g7K399AV/7aeyFCmKvmia2JEHQ==
X-Received: by 2002:a17:902:d505:b0:1f4:58c6:d5b with SMTP id d9443c01a7336-1f458c60fb1mr187183385ad.28.1716917432641;
        Tue, 28 May 2024 10:30:32 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9d899dsm82419885ad.290.2024.05.28.10.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 10:30:32 -0700 (PDT)
Message-ID: <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
Date: Tue, 28 May 2024 10:30:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Avichal Rakesh <arakesh@google.com>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jayant Chowdhary <jchowdhary@google.com>,
 "etalvala@google.com" <etalvala@google.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
Content-Language: en-US
In-Reply-To: <Zk4td_0RR0cMJKro@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/22/24 10:37, Michael Grzeschik wrote:
> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>> On Wed, May 22, 2024, Alan Stern wrote:
>>> On Wed, May 22, 2024 at 01:41:42AM +0000, Thinh Nguyen wrote:
>>> > On Wed, May 22, 2024, Michael Grzeschik wrote:
>>> > > On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>>> > > > For isoc endpoint IN, yes. If the host requests for isoc data IN while
>>> > > > no TRB is prepared, then the controller will automatically send 0-length
>>> > > > packet respond.
>>> > >
>>> > > Perfect! This will help a lot and will make active queueing of own
>>> > > zero-length requests run unnecessary.
>>> >
>>> > Yes, if we rely on the current start/stop isoc transfer scheme for UVC,
>>> > then this will work.
>>>
>>> You shouldn't rely on this behavior.  Other device controllers might not
>>> behave this way; they might send no packet at all to the host (causing a
>>> USB protocol error) instead of sending a zero-length packet.
>>
>> I agree. The dwc3 driver has this workaround to somewhat work with the
>> UVC. This behavior is not something the controller expected, and this
>> workaround should not be a common behavior for different function
>> driver/protocol. Since this behavior was added a long time ago, it will
>> remain the default behavior in dwc3 to avoid regression with UVC (at
>> least until the UVC is changed). However, it would be nice for UVC to
>> not rely on this.
> 
> With "this" you mean exactly the following commit, right?
> 
> (f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the active xfer)
> 
> When we start questioning this, then lets dig deeper here.
> 
> With the fast datarate of at least usb superspeed shouldn't they not all
> completely work asynchronous with their in flight trbs?
> 
> In my understanding this validates that, with at least superspeed we are
> unlikely to react fast enough to maintain a steady isoc dataflow, since
> the driver above has to react to errors in the processing context.
> 
> This runs the above patch (f5e46aa4) a gadget independent solution
> which has nothing to do with uvc in particular IMHO.
> 
> How do other controllers and their drivers work?
> 
>> Side note, when the dwc3 driver reschedules/starts isoc transfer again,
>> the first transfer will be scheduled go out at some future interval and
>> not the next immediate microframe. For UVC, it probably won't be a
>> problem since it doesn't seem to need data going out every interval.
> 
> It should not make a difference. [TM]
> 


Sorry for being absent for a lot of this discussion.

I want to take a step back from the details of how we're 
solving the problem to what problems we're trying to solve. 

So, question(s) for Michael, because I don't see an explicit 
answer in this thread (and my sincerest apologies if they've 
been answered already and I missed it):

What exactly is the bug (or bugs) we're trying to solve here?

So far, it looks like there are two main problems being 
discussed:

1. Reducing the bandwidth usage of individual usb_requests
2. Error handling for when transmission over the wire fails.

Is that correct, or are there other issues at play here?

(1) in isolation should be relatively easy to solve: Just
smear the encoded frame across some percentage 
(prefereably < 100%) of the usb_requests in one 
video frame interval.

(2) is more complicated, and your suggestion is to have a 
sentinel request between two video frames that tells the 
host if the transmission of "current" video frame was 
successful or not. (Is that correct?) 

Assuming my understanding of (2) is correct, how should
the host behave if the transmission of the sentinel
request fails after the video frame was sent 
successfully (isoc is best effort so transmission is 
never guaranteed)?


Best,
Avi.

