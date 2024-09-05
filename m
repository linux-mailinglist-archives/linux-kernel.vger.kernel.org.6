Return-Path: <linux-kernel+bounces-316358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B5796CE68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0401C227D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7D156676;
	Thu,  5 Sep 2024 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="o4uiOYUw";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Z96JVoPJ"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C9155C94
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513680; cv=none; b=gxF6J6k0bnR1sE8507jWQDYoOLxKKD4VhM6hN5QRtu/uev0jVcGgZBQvttP8KMgZbStABFQTpO3OzeeQBDWQef6LLPUlfd6CkTRgx6tkhuiRtCzgvfrMuKAiRVxMi/cD6LHJ73rOJICr0G2LNy1w08kraE4G+pJQ6w6ex+R6VSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513680; c=relaxed/simple;
	bh=hzqu6hcuNLabU4SYr3LXCgWpWo1tqdqpre23pGtSNeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIzSIl/n6+6DkQF4aeli+vdzADEeVuuvI90aIBdL5jtQeVvagRSS+Ezu09Tv//8BrIdPYtLTChr8wJVoWgRsUhZJ1J/lXrdiAes9JZwHNaT3Kb/F3mBWKDh6zONIpg0EKZzO1YXUZLsMallFmXk2ki9zz9RSWWTeiEkQ63MdX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=o4uiOYUw; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Z96JVoPJ; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725513678; x=1757049678;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=hzqu6hcuNLabU4SYr3LXCgWpWo1tqdqpre23pGtSNeY=;
  b=o4uiOYUweIh0eb7UzMD18IHNfuRiTseWQwZKsQHqB6WQA7BPh6kjMLjP
   cJTFWHFMADEY+niqNz0EaNcyCwiRXNscIE15bx2wH87/8VKtAQobiWkAo
   gmh3+3lLZ6ZrcAHC16nsRDCZ4EIyn5RxjSSEXMgUil//wQAD5vAaXr2bi
   sPr/w3LcVYh9Oh+cpvCJclDLgdDFjTHzdxVr63o3vHC5nm5cl9+hu7Peg
   CxMxP3eyZfgrlMqs8++8zM+s061i+g5Y56nPSYEzKfKMjesxOUc9kFUrN
   1v8lDNkVufLZ+JH0xF/haznMHxIgYINUwzbGtBxAt3thFceeqXtDMSaCW
   w==;
X-CSE-ConnectionGUID: lmaAgprbScOhBMfmT9lkAQ==
X-CSE-MsgGUID: A7PFGdzGR1uiJ9Q4Voxkbw==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Sep 2024 22:21:17 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8859d6e9dso374041a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 22:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725513677; x=1726118477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4qFSnkRc49fRnsqONHn9ZHWfi3Lcg5y0Rj1PJAL7gE=;
        b=Z96JVoPJbtPPGHhzfjz3aIQ17XjZBTWrpctGAh0sLBOSsCtAGgosrrnnEfyX0+vQ7L
         f/r0n7B6A6BELFtMHApyBy66oEuOAWlXEkmnU5zTYsB+2rgsV8/qQhhX9vUpo91GQU5Y
         Bm2FEBcBGL0wjWbS+kJD8Jizc2x22ZgOt3mmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725513677; x=1726118477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4qFSnkRc49fRnsqONHn9ZHWfi3Lcg5y0Rj1PJAL7gE=;
        b=RXo6RYODQa1zG9gf+3/VT1cxWq5FNVEyP0F3ro8YECGqZiw0R8Do3N/hn4FloU48gx
         ztwuzQYjk4qnPpyPvXU/RUeIijjqgUPyWjgWuDi65w1J+M08QcC2NLV/P+h4sul6HHen
         oAHXn+lX6h+30+rmYex2ckW7kSXL2Uwp9JCtmi6lZn/obuNfcpjXoltFGT/TKAjUD9za
         hMe/f9sbKKnKzwj6I2lIo8ggxGlRA/0LuLbGBXYfD4NLdpT7HuON6fDDJNX4CDmkjmJk
         MGwvAnQi05sVQRIyPa0iHdQ+kAu3CGvzuKQkvF4xIbEhbiFyVvGwWpDwFcbNi2wOR7Mh
         QNJg==
X-Forwarded-Encrypted: i=1; AJvYcCVk0VZnFZAuEkccHxRnaJj1IPUjTyw0w3SgzLsc35CMAaeNbe62kNXvAMOLW8HTMlE6UKgutGf+59/YB7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YymmeOjWYFGb1ud1F2aP9SYIFLgThOHwyaVRPKnACH3DjHUM/Cl
	+J34JUpBHKh43gWt1zB8+X2dAEgj3eTb42au403dEzARdEZ7CLjILlrr/aW6fdTd56Q1DUex2CM
	ugV+75cls5n/jfWaF2C641wofuYYY1nTvmvVwpvss62ptuMWxAMVv+5vAj5PjTI/hwjmfR6LP8d
	zVvtBT2eX6ubitUQpujyFnSrxKnrCmX7fDVvn0IQ==
X-Received: by 2002:a17:90b:4c8f:b0:2d3:d063:bdb6 with SMTP id 98e67ed59e1d1-2da62ccd6f9mr8504869a91.4.1725513676791;
        Wed, 04 Sep 2024 22:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpip/R0N1091GH4SApz5/OTbmIsWxNlpjAne9eiTOQbmfpV1Cr7it45jNN5/vJYrfLuEvezhA1ge2Z/VJT1zo=
X-Received: by 2002:a17:90b:4c8f:b0:2d3:d063:bdb6 with SMTP id
 98e67ed59e1d1-2da62ccd6f9mr8504860a91.4.1725513676368; Wed, 04 Sep 2024
 22:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <draft-87y1494nw8.ffs@tglx> <87y1498uq1.ffs@tglx>
 <CALAgD-6-f4Dax=iiC8_J9Cu-ztYFCAhXSgQCQMTt2nv4Hfe3pQ@mail.gmail.com> <87v7zd866i.ffs@tglx>
In-Reply-To: <87v7zd866i.ffs@tglx>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 4 Sep 2024 22:21:03 -0700
Message-ID: <CALAgD-4GRVO9gGHAUxHppumAw8nrTaVAKUJ_6iHQHWC8HmZCgQ@mail.gmail.com>
Subject: Re: BUG: general protection fault in __free_object
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We also tried it on v6.11-rc6 and the bug can still be triggered.

On Tue, Sep 3, 2024 at 1:58=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Sep 02 2024 at 17:10, Xingyu Li wrote:
> > it is linux mainline. We already provided a link to the linux that we
> > used, on https://github.com/TomAPU/Linux610BugReort/tree/master.
>
> No. This is not mainline. This is release v6.10, but mainline is already
> at v6.11-rc6. The question is whether the problem is still there or has
> been addressed by now.
>
> Thanks,
>
>         tglx



--=20
Yours sincerely,
Xingyu

