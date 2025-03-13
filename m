Return-Path: <linux-kernel+bounces-559685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D395A5F813
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6094E420BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8474267F5E;
	Thu, 13 Mar 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="YR7pErhH"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526D26138E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876035; cv=none; b=u/6IRiBQc7XUWHKI0lOdAUYH3c1LxceGVWVQz+FtXtI7WIvuH6n2N8nvlX+S5tlAXcvNIhV5oS0u0oewrDdO9RRl1Pk7IUIUrBwO2IX2ppDqAN4tUqk/wOLJKy0iaUWIXE3y9xKqbFZatzrza0P3TaTT+aSa7PgAtx/hzAMA2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876035; c=relaxed/simple;
	bh=e59kCVsU9LBM79OBuONJKfQHZ2r8EUShV3tanNlz8vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTyR8iyVEowm3J1jvLHyRQB3cDY9yO43FFOH5ip8kIIHfd/QfAkoxYNR6I6aptX/ksBcaryzsIK2OaMcK7S2AniCpG1oia8oGtKEXGFmyJJMCQse7MDOhSYf2JcB21ID/h1Q+BidWn6yKKIHGQaC1y1SX2apIoID97Co64HIEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=YR7pErhH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c08f9d0ef3so57589285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741876032; x=1742480832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H635X2IpBPTS7fd8mfmW/ZmLII9u+vyukSjlkRmuQcg=;
        b=YR7pErhH8yiAKdSYfdZCyqKUomQmx6Nu28wYYKn/7IRFnGQnlBF+cBHbqPjlblK7KC
         +kSGdBoO5j88ihrgD2vp8ijR3Yqqc+HTuPgdWULEd1ZxxSrk+JOhtO5eGUkLBOihuyJk
         rG8EAF2HRdtpiv0H2ZjgMYv/i56vujVOWIuQV9IPPxoiJOE08fYUpABqLnxHDOS5hviQ
         r4bxlrFLKGqcPMYgjsnql708p+MBUWGfqtLnbDa/qe83ymgUrP8MnVkirxxq29mrJKEl
         +DN2FGfB5rhZ38DlbGsk3yTYjksojVsPEnNstZSGYXn9TThVclq6ZZmu6uGSufPBc1AQ
         yYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876032; x=1742480832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H635X2IpBPTS7fd8mfmW/ZmLII9u+vyukSjlkRmuQcg=;
        b=uWK8kiVQt+ouZhln7e7G+3xqI7QpWEGPayVa+p0JrPIa8WvtvRr+01xYHxD83SevhS
         TAHyOwBx1lL3SnEXSjJBuN+gljhr37RyPnjkkIMFRhxNZaqEUKmGts/ZCrAYHxH/hSgc
         j9lmO/a4WwvGHNpqBTKvmxMSXZKkTQNSMacRJsBpBbXqbTft6XJ52uDqOCEXfPeFvfEl
         VKnJJi/u2NhJapUQF5yHyfO9+hTw12s9MMNj1ZFcvfwMMiUsdTm/aa2s+Yg9JZ/C9czR
         Yj4yO8U5VVwsghw9VYfxcXuMFlw5QEWp+qo8ARYlYpMPdMMNDurgNmhTOP5TTPFzkXIZ
         xebA==
X-Forwarded-Encrypted: i=1; AJvYcCWv2OMK7dJR4A/9YbchphCB4HcoyxP1xM64HgXpWkSdaoQCs+rx6uUpyPc3V6Qva5C0odhV/HQ9G/Ummhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfu2MLFveaa6yYQJ3TAyKizR0is1uFxuCG+847T0nOlk0ki56
	06lTPwk1tC9mv5pZmqHJHXHtygdaQ7xa2pTy703kWXcAy2BJLlSq9ZxU3Ex4NhgG0Ns2Qxorhuk
	=
X-Gm-Gg: ASbGncuwCq6xrpvMOirBQ0A3JYdqs0eszQjcGI1mu3xWQWcp8iMGLu5Of62mkwSstTp
	9TTGA3VwkOwAl/bspXi4CXo2m3lS8BpKbdQDYMoEO+429qo8z3zIG+Vqgnn8igtZirgum69YCFp
	A/5iAH1J5yikT7VJx0cCydTnE1onh2X2npNEXH2gpuYTkvw856NgsPZ7/5YfVZSf10TJ1foiXgb
	zWVLF+2WDB96XXExsxE3lMip/f6NgKr2DxWJwl+LB3faA94HJizJT1u6igoeDGoL/zmeSVcnptD
	9crUbdsqcjz5VBFaWO7kOjfk7GcricDIAQJspy4+9VB9qIYPRAlwvIh65XOg9uk=
X-Google-Smtp-Source: AGHT+IHcMwefl/VozsyZZiorHf0Imca6oEoKB2BrElXT5f+aQ9Lv2/4IzaPByraiDbdYH53BNvnCyQ==
X-Received: by 2002:a05:620a:2606:b0:7c5:5909:18d2 with SMTP id af79cd13be357-7c559091cc0mr2367835385a.7.1741876032491;
        Thu, 13 Mar 2025 07:27:12 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9b188sm103897185a.59.2025.03.13.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:27:12 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:27:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Roy Luo <royluo@google.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: core: Avoid redundant system
 suspend/resume callbacks
Message-ID: <480c7796-2402-4009-9463-81280f9405bd@rowland.harvard.edu>
References: <20250312223434.3071598-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312223434.3071598-1-royluo@google.com>

On Wed, Mar 12, 2025 at 10:34:34PM +0000, Roy Luo wrote:
> dwc3 device suspend/resume callbacks were being triggered during system
> suspend and resume even if the device was already runtime-suspended.
> This is redundant for device mode because the suspend and resume routines
> are essentially identical for system PM and runtime PM.
> 
> To prevent these unnecessary callbacks, indicate to the PM core that it
> can safely leave the device in runtime suspend if it's already
> runtime-suspended in device mode by returning a positive value in
> prepare() callback. This optimization only applies to devices without
> pinctrl, as pinctrl has distinct logic tied to system suspend/resume.
> 
> Signed-off-by: Roy Luo <royluo@google.com>

Out of curiosity: What happens if the USB controller is already in 
runtime suspend (with wakeup interrupts enabled) when a system suspend 
occurs?  Does the fact that the interrupts are enabled mean the 
controller will remain able to wake up the system even if 
device_may_wakeup() is false?

Alan Stern

