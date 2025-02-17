Return-Path: <linux-kernel+bounces-516957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9FA37A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE51889C26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AA15442A;
	Mon, 17 Feb 2025 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xeyKevpr"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639295C603
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739764197; cv=none; b=G+rj2YsIod2J/fr27PAeqFNmHjiLiKB6R69TeAQRtPZEnOO30T22uEwpu++G18itRcJw5XrKurc/BC3tJnIyzv60xCjTg6zMYAaAkLbymjkHlWh7GjI4FMEt8Fead13cJT2jXS2hfVK0tggAjfd4KqV4mLtCeMxxBqr8aY1Bvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739764197; c=relaxed/simple;
	bh=AEctecPW644bInprG1Q0+EICJctiBz+Em9TO21wIBsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3YVFmY3Xr2XU4w8odrezB0MjVe82JI9GqmHVovH+sXq8ETZfsr0VNU4XEG4gKVq/d7FMOO/T1Lkzu1jZONflR7/XVZwKVmUC+XrTb+q+kLfyRSl3BZ9uJbD2ujVu4Ozk1kVFtNVA+qNRPKy9h00keQsNBwfC8EUfz3GansKL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xeyKevpr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc3a14f6fbso2653706a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 19:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739764195; x=1740368995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q6qV2LKgDU3t0RtwY5zJqsVUWjzCYVJ/54cGupGGOAA=;
        b=xeyKevprCrOYvYbdurqZtnbhcZINaGfp+vCLLYEJtPSeqEFj7E8iEMcskh9WcoROAy
         YNw9/d3YHEqoBG5t+DU4BB1e+Se29yYWVloLKZiTBFYURbtyv87qV9UyabfHfzuJxylv
         H4L5zOZrnHTF3vKjFo3ZVWNMyYKc6GzrcYBZL4tLblYJR1/dKbCoqoHwLdkf8P+qqqj3
         V5t6amp7YrmuVj5GbqUrN9X5AZttyguELNaGx0lS6h6chEaaf8gnz/Aom+J/WdQGEMwQ
         FLT9oa5ZE6JAgbwW2nyhtxg3ApRGsfJ4Sj90WomhxwjaIlmVfLW+P60Nq5hl06QzeKBY
         jl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739764195; x=1740368995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6qV2LKgDU3t0RtwY5zJqsVUWjzCYVJ/54cGupGGOAA=;
        b=tLmEXbTSoMJYoPn0ccXN7xGXa0GlFKOoRV4yB5N4rCEvIjiQ0W7X0ajQwQOZl7o0R2
         fA+ESHwE0/9R3ur72FSI3HuIB6PD35DsDpUHPlDa1jS7HSoEgWRKjeHmAcBv1mLkyVfT
         v25tdD7tex2qoXWl1jS9zZx7XYExvpgxpFV/cNwsWu5BrWHk4v5GuaBwpIdiihf4KUSO
         mONDh0LTUPPPMC7dLhCHr7gTQk6INJFGwpgjD05Y7xBi7Ce8cUTAIE/md6FVaz8CJjzG
         M9vly3sd1tPFSM53PAVcYpNIAgTb3tddBR1c/qgQMJMA/8rmsp759cHQMQVVGVT8H84a
         ZVKg==
X-Forwarded-Encrypted: i=1; AJvYcCUqokyFseca9IH2js5eVI5dTN/ut8Ssek6BY0TA+YPC1Jew8juMUzF86jaQRC+mMw9nRhNIFva50FcNOmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ITiZLCaAj6fWzt7gtScrgpCYqSscW9oB+OK5R3e1p0BUDvCN
	mzG437SnYrsTbrpOQKRSZhu4Og+v61pYu015/E2B7WcY172c+I0yJihpPd5//A==
X-Gm-Gg: ASbGnctqMBkoIZqriWusXmuWTxjxFN4WWaberIVonMJGaRxHSSDozUKIQO9USyX9zjI
	whDlf5SABqHBgt74RG281+BW0JrUsKTKchtbi5dygnDblnyBIcBePWzbDi8vpxwg9PhpqnUTX4W
	HuhVUK695gg08EWS8U/NfDD2PLYAtTjv7QZmaDNfzsO6uiR2BmgA2G+O6I+H+mGdmWInOQhJkDK
	t1uWBn7V9buolPhyBmzMLtaCTOuy2MGLmzZBOr9Q4Q37piAU4mrZ3x5lF2JLOj0OoWY6pma+MkB
	z4QYSxYFQFe2jIvXq4ZM4owIzwnrylRt60SbUEZUag54IFlWdTmELi4f6Q==
X-Google-Smtp-Source: AGHT+IG+mp2u7hYvW8OafGPbN4o2uVFyOs0S++K2BLbGBPWA98vSvCccRtLwR4LjGhALrh85g6TMxQ==
X-Received: by 2002:a17:90b:35c9:b0:2f6:d266:f462 with SMTP id 98e67ed59e1d1-2fc411540camr12191613a91.35.1739764194422;
        Sun, 16 Feb 2025 19:49:54 -0800 (PST)
Received: from google.com (49.156.143.34.bc.googleusercontent.com. [34.143.156.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ac0a5bsm6833135a91.18.2025.02.16.19.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 19:49:53 -0800 (PST)
Date: Mon, 17 Feb 2025 09:19:45 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@google.com>, Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Joy Chakraborty <joychakr@google.com>,
	Vamshi Gajjela <vamshigajjela@google.com>,
	Manu Gautam <manugautam@google.com>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z7Kx2RN35QVyg8nP@google.com>
References: <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
 <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>

On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 11, 2025 at 11:21 PM Brian Norris <briannorris@google.com> wrote:
> >
> > Hi Ajay,
> >
> > On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> > > On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > > > Well, in general suspending or resuming a device is a collaborative
> > > > > > effort and if one of the pieces falls over, making it work again
> > > > > > involves fixing up the failing piece and notifying the others that it
> > > > > > is ready again.  However, that part isn't covered and I'm not sure if
> > > > > > it can be covered in a sufficiently generic way.
> > > > >
> > > > > True. But that still cannot solve the question what is to be done
> > > > > if error handling fails. Hence my proposal:
> > > > > - record all failures
> > > > > - heed the record only when suspending
> > > >
> > > > I guess that would boil down to moving the power.runtime_error update
> > > > from rpm_callback() to rpm_suspend()?
> > > Resuming this discussion. One of the ways the device drivers are
> > > clearing the runtime_error flag is by calling pm_runtime_set_suspended
> > > [1].
> 
> I personally think that jumping on a 2.5 years old thread is not a
> good idea.  It would be better to restate the problem statement and
> provide the link to the previous discussion.
> 
> > > To me, it feels weird that a device driver calls pm_runtime_set_suspended
> > > if the runtime_resume() has failed. It should be implied that the device
> > > is in suspended state if the resume failed.
> > >
> > > So how really should the runtime_error flag be cleared? Should there be
> > > a new API exposed to device drivers for this? Or should we plan for it
> > > in the framework itself?
> >
> > While the API naming is unclear, that's exactly what
> > pm_runtime_set_suspended() is about. Personally, I find it nice when a
> > driver adds the comment "clear runtime_error flag", because otherwise
> > it's not really obvious why a driver has to take care of "suspending"
> > after a failed resume. But that's not the biggest question here, IMO.
> >
> > The real reson I pointed you at this thread was because I think it's
> > useful to pursue the proposal above: to avoid setting a persistent
> > "runtime_error" for resume failures. This seems to just create a pitfall
> > for clients, as asked by Vincent and Oliver upthread.
> >
> > And along this line, there are relatively few drivers that actually
> > bother to reset this error flag ever (e.g., commit f2bc2afe34c1
> > ("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get()
> > fails")).
> >
> > So to me, we should simply answer Rafael's question:
> >
> > (repeated:)
> > > > I guess that would boil down to moving the power.runtime_error update
> > > > from rpm_callback() to rpm_suspend()?
> >
> > Yes, I think so. (Although I'm not sure if this leaves undesirable spam
> > where persistent .runtime_resume() failures occur.)
> >
> > ...and then write/test/submit such a patch, provided it achieves the
> > desired results.
> >
> > Unless of course one of the thread participants here has some other
> > update in the intervening 2.5 years, or if Rafael was simply asking the
> > above rhetorically, and wasn't actually interested in fielding such a
> > change.
> 
> The reason why runtime_error is there is to prevent runtime PM
> callbacks from being run until something is done about the error,
> under the assumption that running them in that case may make the
> problem worse.
> 
> I'm not sure if I see a substantial difference between suspend and
> resume in that respect: If any of them fails, the state of the device
> is kind of unstable.  In particular, if resume fails and the device
> doesn't actually resume, something needs to be done about it or it
> just becomes unusable.
> 
> Now, the way of clearing the error may not be super-convenient, which
> was a bit hard to figure out upfront, so I'm not against making any
> changes as long as there are sufficient reasons for making them.
I am thinking if we can start with a change to not check runtime_error
in rpm_resume, and let it go through even if the previous rpm_resume
attempt failed. Something like this:

```
static int rpm_resume(struct device *dev, int rpmflags)
        trace_rpm_resume(dev, rpmflags);

  repeat:
-       if (dev->power.runtime_error) {
-               retval = -EINVAL;
-       } else if (dev->power.disable_depth > 0) {
+       if (dev->power.disable_depth > 0) {
                if (dev->power.runtime_status == RPM_ACTIVE &&
                    dev->power.last_status == RPM_ACTIVE)
                        retval = 1;
```

I think setting the runtime_error in rpm_callback, i.e. for both resume
and suspend is still a good idea for book-keeping purposes, e.g. the
user reading the runtime_status of the device from sysfs.

