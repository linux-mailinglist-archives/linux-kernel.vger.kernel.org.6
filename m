Return-Path: <linux-kernel+bounces-390083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E449B7544
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C651F213B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E457149C41;
	Thu, 31 Oct 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3H8ybTM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2CDDC1;
	Thu, 31 Oct 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359326; cv=none; b=nsmQT4m5O3rV0byd5mYEVnvoyC47om6eaAkSdF+gQTuEZFXu30/zWqWhmy1oDQpOked4AG38ysz7C94ZlgQ8QueZop5Nv5FBlJzdluCjY/AXd3QZsOn78FrnF56PofuEEQvmVvwKWhRXDNaQRHI7RBSdVHS1eTo6iR8m0xlPnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359326; c=relaxed/simple;
	bh=48EtQZsswJzjNxyapamsww98N1IDeDuuU9r3y88pPMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1IU7SsFNs8xeAsJ2nlBNo1csvPq1uEu21OZKFRx7wfAa9F6eov/izJ/7dW8gCtl8l6nF1YTgcq0j46XUmKcgAGZH2BIDUDIqWHU/qNvOxCtMEfALIFZ/H6SoIrIRR2xr2ATR2/bndbakIjpLZzLPf+DKVMmhLmiZe7YOH6rlSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3H8ybTM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fb49c64aso933854e87.0;
        Thu, 31 Oct 2024 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730359323; x=1730964123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gM5wWgi2TSKmVeY5SDcJMm3bhY1ZPCy6wez8pJ+kKGg=;
        b=O3H8ybTMszj38WHLeTnPZXN0amXRa1zIhi20ZtcOTU2IXxrFaZsGsGhu9nnSFHLpdY
         yI1FhLcvr9+vzEs/jNGab3RdqC9THJc0eOiuAdNvejC3osHZyhjM7prNsF7WWfV2RJdg
         CQ1tK8vwxxk6hWjqgOwySKUbnEloENYypWWToecAQfb2adcGdn/skzvW88HIdjx4iIqI
         WkwJpU2xCCsvKX+cdJsFAk+J5k2xxQYplrFbPxXnrj9nswqOgxGe+dvQlKVILLZileZs
         oSllXe5u+dMPjDfxTlgJ0wJBDMo7Yow/M7Hb03CvPNlZ0ZgrciIoz4p3Va6D1fiDS+dT
         6hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359323; x=1730964123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM5wWgi2TSKmVeY5SDcJMm3bhY1ZPCy6wez8pJ+kKGg=;
        b=B4YHxUt7oJjjaan2/O/Ch+C17yt9VVzM2Xr1G40CuqQwPQ5KGuYl6QVlXF07gc4WBi
         c/NOBy1g16iy5Ljp9zd6n9T3uroJPX6ql0a2OEvIcv0A6CbVM1kwjctU3Y4Ms9bzRYcl
         y/hO5Zhf/k1u0V4R5t9RZLOQvg2dABEXnTT3e2F0zTFGEoS6gt3fwvejPBQMGJYtAAYB
         304e9Qj0n/ySn2SGPx8tPB4A9R+a+aEf5ZCYvZbjqJm4/SuS6dj2RSmDBjlZjgSb+rb3
         O8/Y1PW7S8zGOJHP1r2BzJcEIXQbXHHu/FVh4JaVffqCvkwhgxu1o2u3lnMvmcZlNeBR
         heow==
X-Forwarded-Encrypted: i=1; AJvYcCUqRVfdy+in2/SQthE01A6vfSjmASjAe1MRejpEJkhJQihcSgsqA9nlgcd3ZrHoNePJ/au/3BQtLDbHyjg7@vger.kernel.org, AJvYcCX5ue+b2LKXApob8HAaR8PWxNvg0XwbH3BnjJnNb61KVpM3r70zb++fx7298bDjZqCNnpklac/di11o@vger.kernel.org
X-Gm-Message-State: AOJu0YxTEK0jw3FiyYQr9Z29KnwiqzGBlfjAaGDXNisvNa71p/+bIjAi
	HPifvdfqpD5SUI4Da3WPEkt/JgKZU43yg7TzvdSOG/gEYkxX+nD9
X-Google-Smtp-Source: AGHT+IEBjM65tt3SAt8nK0ae6K3GOnG5v1Naqby10xKQgpFyglnNtSWRc/TdgW4uy2gigZZl2XbJFQ==
X-Received: by 2002:ac2:4e16:0:b0:535:6951:9e1c with SMTP id 2adb3069b0e04-53b348cbb48mr14201223e87.15.1730359322220;
        Thu, 31 Oct 2024 00:22:02 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e095bsm35533866b.99.2024.10.31.00.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:22:01 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:21:59 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Cleanup Spreadtrum/Unisoc ARM64 DT (part 2)
Message-ID: <ZyMwF9AnVTEI1a_m@standask-GA-A55M-S2HP>
References: <cover.1723716331.git.stano.jakubek@gmail.com>
 <ZyJ1keHD-neTNZ2J@standask-GA-A55M-S2HP>
 <CAAfSe-uZ5KWfnZ=DqAy=4fJp0TrTimdEs0Vy57CYcsK06Ev_UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfSe-uZ5KWfnZ=DqAy=4fJp0TrTimdEs0Vy57CYcsK06Ev_UQ@mail.gmail.com>

On Thu, Oct 31, 2024 at 10:08:27AM +0800, Chunyan Zhang wrote:
> Hi Stanislav,
> 
> On Thu, 31 Oct 2024 at 02:06, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
> >
> > Hi all,
> >
> > not sure which tree this should go through, but could someone pick this up?
> > It's been sitting for ~2.5 months.
> 
> One question is what do we do about those warnings reported by Rob's bot?

Hi, you're correct, we should do something about those, I'll be sending
a V2 soon. Also found an issue with the 2nd patch, will write it up there.

Regards,
Stanislav

> Apart from that I suggest you send a pull request to soc@kernel.org directly.
> 
> Thanks,
> Chunyan

