Return-Path: <linux-kernel+bounces-326784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C2976CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05852834D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9601B532D;
	Thu, 12 Sep 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="YeCRBz4U"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599B6EB4C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153234; cv=none; b=FlwpI3uIvyEjYxpO+com1E1EDwiK5fX5Qpf7rXhmfIXjESaPFn47jZzTQkQzMfiV8J6C7CD7HvcGuFISqITtIsDfi1DcEYsNKR471vqkHxMjfjUdd3jRXkUUIBZAsPNoWoLoIbOazRLQGXPvKCA4tHWw5dEmi6DkrQ3rH8xCKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153234; c=relaxed/simple;
	bh=7L47ev+2rIiO9RYsStVCwqce6vN2zxIMqLv/5Qypajk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd99ZU2bvf7s5HgNTGrmGuDVt1J5mnb/6waRDy5juc3u4gwHUIQcwT86FajN5vX73/3KSfDEQ+jlZ24J7HdcR4S4+8UNM/WKKWaTuLpcHk+/ghsJt7hZAMNHcfzsrjcYbFeNOMHlFdux/CUQDU+v7whvHW7okAmmCzz7F+8PUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=YeCRBz4U; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a4df9dc885so82752385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1726153232; x=1726758032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZAYn7AWMFdIVv0f37NgeBxnEuOXY388haBmrjcdyedA=;
        b=YeCRBz4UxFpGwCN5cT8SdrgrIaExegqVau6/pnm9u3eBJK48gJqOho1/j3STn4C8wC
         q13bU5eofxSJQOx8z6XDxjJbL18qYdJ/daQYElTEUAR4UZBkThMHXmCUyUXxWAn0cjlx
         kA1Av8urf5MsYfJd5fPUxQFRSoA2RP4WkJeaelzQHLg3elDQ1+yZLwGEfFZHoUHicshU
         SOe+HKr5HyYVXZYK/Hputy/YLVg3jb1rx6DhwJ9w/d0pkT1GtoU4Fpbdd1kslxc3yoUo
         yfz90A7TfWRwFQcr/WymGp7QWgVxfyE2RA3vnx4LctxGlXS0FFZPaOFJhw3Ldja9UmTO
         AdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153232; x=1726758032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAYn7AWMFdIVv0f37NgeBxnEuOXY388haBmrjcdyedA=;
        b=m4cava/lLJjg9438GCPcG4QYTMNLQxDSdoHlMEFFsH1R8277d8DjexnvGUI0/8RtfN
         wUWqV5KmK1+d5WusV7ojv1bdbxC8kPRXPLdUomJM9JbUwbMB0rEM3JDZco35qXNw9Ma0
         7SiCaYWATpA1dzYOoOCp/SwCRgI9L8LtJWfiCYqsXrDQnMlfLSyaRQwhOJOy3HeWpXdv
         elJHJtEdREH6RCLQ7ZmXwvCkOGEBV79gcy4alJY0LecVaQMFcAThtv4CHHjNlNw+qvbN
         48Q4oyWjl2SuWKAYjKXOxR6em1GRVb8k6qyuKAXR14Uzhl5AKMNePp/Zjm6ertgalLNR
         ObKg==
X-Forwarded-Encrypted: i=1; AJvYcCXOu1Stmwzz0YwMcdhCYl0wu261hxyD3lqXm0l3zrOFce1bvfnPUAwtkyEWUycl3hw/gHdtHSL2x5kukyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpj8Hef/NUgyTeBWEGCUVVElJiGiWIKug80r7x+bjtJdili86T
	7m08nBW7pl6naehJcnBVxXECVkaHfJDnKfRynNGcmSRtRV4UjhL6UbP7gdcjCA==
X-Google-Smtp-Source: AGHT+IGm0kosw61FYxbFzQdMrzultDRpDvVUYnNuhPbncnk9H5TX3B9V0J/rfa5HaCMNIFYZ78QQUg==
X-Received: by 2002:a05:620a:45ab:b0:7a9:b798:5e29 with SMTP id af79cd13be357-7a9e60fd4f3mr403584885a.30.1726153231339;
        Thu, 12 Sep 2024 08:00:31 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::ff03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796ad15sm550744185a.30.2024.09.12.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:00:31 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:00:27 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: gregkh@linuxfoundation.org, pavel@ucw.cz, linux-pm@vger.kernel.org,
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
 <1725931490447646.3.seg@mailgw.kylinos.cn>
 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>

On Thu, Sep 12, 2024 at 11:21:26AM +0800, duanchenghao wrote:
> 在 2024-09-11星期三的 10:40 -0400，Alan Stern写道：
> > On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao wrote:
> > > S4 wakeup restores the image that was saved before the system
> > > entered
> > > the S4 sleep state.
> > > 
> > >     S4 waking up from hibernation
> > >     =============================
> > >     kernel initialization
> > >     |   
> > >     v   
> > >     freeze user task and kernel thread
> > >     |   
> > >     v   
> > >     load saved image
> > >     |    
> > >     v   
> > >     freeze the peripheral device and controller
> > >     (Check the HCD_FLAG_WAKEUP_ PENDING flag of the USB. If it is
> > > set,
> > >      return to EBUSY and do not perform the following restore
> > > image.)
> > 
> > Why is the flag set at this point?  It should not be; the device and 
> > controller should have been frozen with wakeup disabled.
> > 
> This is check point, not set point.

Yes, I know that.  But when the flag was checked, why did the code find 
that it was set?  The flag should have been clear.

> > Is your problem related to the one discussed in this email thread?
> > 
> > https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852b6ac8ecb5@rowland.harvard.edu/
> > 
> > Would the suggestion I made there -- i.e., have the xhci-hcd 
> > interrupt handler skip calling usb_hcd_resume_root_hub() if the root
> > hub 
> > was suspended with wakeup = 0 -- fix your problem?
> 
> Skipping usb_hcd_resume_root_hub() should generally be possible, but
> it's important to ensure that normal remote wakeup functionality is not
> compromised. Is it HUB_SUSPEND that the hub you are referring to is in
> a suspended state?

I don't understand this question.  hub_quiesce() gets called with 
HUB_SUSPEND when the hub enters a suspended state.

You are correct about the need for normal remote wakeup to work 
properly.  The interrupt handler should skip calling 
usb_hcd_resume_root_hub() for port connect or disconnect changes and for 
port overcurrent changes (when the root hub is suspended with wakeup = 
0).  But it should _not_ skip calling usb_hcd_resume_root_hub() for port 
resume events.

Alan Stern

