Return-Path: <linux-kernel+bounces-404664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F779C4665
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C493FB27545
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EB91B3B2E;
	Mon, 11 Nov 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eULhFvzt"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646541EB36
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355656; cv=none; b=uLwOxdbxvra/gmI8etBglkdSsm17jnxfTnjYniqP8olCb0bhCDvWIOHTOszCDf95RM2fCK6BM5sIm9IN6tP7foFKA28jeRONC8WuFagmt+CWLeY4rtf44XojFZ69wHQV/wzdpzVmuH27tUGr9cfsPucGnu17WR/LHbEXmOCknR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355656; c=relaxed/simple;
	bh=nloYtyyyY7jDqjdQx/OCWTxNKzkTw3BEJn06frFfVP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVy1V5oMmF6NOL1dr4iu92eEn5gnYU/ljdwe+HLR+1Qo3f/VxUFoy1hx0B8bkvDHAVYuqG1/2MzHtg4Hu3s7pGpCqkG33KLXffDVHUPb0BLNT9Alwjbj4S+U3QrgevtPTmv07HoXXRS0caA79f+0WAHOtWUK/EY5Bl5ym+BYnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=eULhFvzt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so41313825e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1731355652; x=1731960452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIIKZQ88bUAJO/72aCrm40fHZEJ1K+otj2uYdeOXD1c=;
        b=eULhFvztVYoPnlCH2Jl/7O0x+1k9XedxGk2dt27A02XD4GkFSBvg1gg/OR0b9I2qbc
         FWL/1i/qjjv4E4JAne4zZoY8YREE6NOQez65k35iTXwA9UdBm2u4rwq0jLl1xGfAT57e
         iEJzmOd2aMWsXi9w4oPcD6fcsD1r5tJYfRhtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731355652; x=1731960452;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIIKZQ88bUAJO/72aCrm40fHZEJ1K+otj2uYdeOXD1c=;
        b=WjCCSThg0IxoBvNRz9zJ42GxA2m8THtTdI0Pr2n8R6kqsFhiyM77LltBg8P95V8yzC
         T9JR7lb60VfDoJi8aPQiU6ZTOu4ly9tZ6X6ZuA+1vkeO0xtrI2bxajgjLJurnF1lzXe7
         iVFogcqypogy2/nIdQ32zfBFW2iYm/v9gqQwcTBd571/vEi8kkSFHKc+4ceWusNIAaJ5
         TzlhOui+oZM/I7NZb3pB9M5HptfcHZPS/mpOfmZKJH/zyiKxEpew2/nxAFqJGMqQ0VMw
         oI04d1c02DgK/y4+AHwYskZbotJR16YBVArJBbYbp5uRAywlLG3yGk0DKX6o7BuX3LF0
         o4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUGoLsielbREAGcdjo7GaZArt0H02UoJdO9A/9Jz5WliIKCCXtwPMiZ1pzsctzxr5h3PYvd/QCeoOLtZHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxv1BQBxFGO6E2unQ/kqeqzEKjeFP7cuPPjzJ40b5+4R3pWcVz
	h5u9O8nGU2R2U19fZKJe8uwbcfG29QLJo7fKFhlCoRix/7tiIeyGmopBP/wBIRg=
X-Google-Smtp-Source: AGHT+IGmEyPx4cRoIIS5T3WK6yz/WPGsLjicH5l8YqImtQtFJq8OsUj0ZfrEZw+hmKFHtESQBiAbGQ==
X-Received: by 2002:a5d:47ac:0:b0:37d:5134:fe1 with SMTP id ffacd0b85a97d-381f1866a6fmr11691276f8f.17.1731355651582;
        Mon, 11 Nov 2024 12:07:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970e18sm13558728f8f.10.2024.11.11.12.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:07:31 -0800 (PST)
Date: Mon, 11 Nov 2024 21:07:28 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] Documentation/CoC: spell out enforcement for
 unacceptable behaviors
Message-ID: <ZzJkAJEjKidV8Fiz@phenom.ffwll.local>
Mail-Followup-To: Shuah Khan <skhan@linuxfoundation.org>,
	gregkh@linuxfoundation.org, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	DRI Development <dri-devel@lists.freedesktop.org>
References: <20241108161853.12325-1-skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108161853.12325-1-skhan@linuxfoundation.org>
X-Operating-System: Linux phenom 6.10.6-amd64

On Fri, Nov 08, 2024 at 09:18:53AM -0700, Shuah Khan wrote:
> The Code of Conduct committee's goal first and foremost is to bring about
> change to ensure our community continues to foster respectful discussions.
> 
> In the interest of transparency, the CoC enforcement policy is formalized
> for unacceptable behaviors.
> 
> Update the Code of Conduct Interpretation document with the enforcement
> information.
> 
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

I think it's really good to document these details. The freedesktop coc
team is going through the same process, we've also done a talk at XDC
about all these changes, and I think this helps a lot in transparency and
accountability in practice. With that, some thoughts below.

> ---
>  .../code-of-conduct-interpretation.rst        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
> index 66b07f14714c..21dd1cd871d2 100644
> --- a/Documentation/process/code-of-conduct-interpretation.rst
> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> @@ -156,3 +156,55 @@ overridden decisions including complete and identifiable voting details.
>  Because how we interpret and enforce the Code of Conduct will evolve over
>  time, this document will be updated when necessary to reflect any
>  changes.
> +
> +Enforcement for Unacceptable Behavior Code of Conduct Violations
> +----------------------------------------------------------------
> +
> +The Code of Conduct committee works to ensure that our community continues
> +to be inclusive and fosters diverse discussions and viewpoints, and works
> +to improve those characteristics over time. The Code of Conduct committee
> +takes measures to restore productive and respectful collaboration when an
> +unacceptable behavior has negatively impacted that relationship.
> +
> +Seek public apology for the violation
> +*************************************
> +
> +The Code of Conduct Committee publicly calls out the behavior in the
> +setting in which the violation has taken place, seeking public apology
> +for the violation.
> +
> +A public apology for the violation is the first step towards rebuilding
> +the trust. Trust is essential for the continued success and health of the
> +community which operates on trust and respect.

Personal take, but I think a forced public apology as the primary or at
least initial coc enforcement approach is one of the worst.

First, a ban or temporary suspension seems too mechanical and not in
proportion with the offence of failing to apologize. In my enforcement
thus far as maintainer and now also freedesktop.org CoC member we only use
punishment if behavior has failed to change _and_ we need to protect the
community from further harm. Usually it takes years to get to that point,
unless in extremely severe cases (like public harrassment campaigns) or
when the person stated that they refuse to even consider changing behavior
at all.

Public means you're amping up the stakes and massively increase the odds
of people being afraid of their reputation and losing face. In my
experience people are a lot more reasonable when you discuss their
behavior and what needs to change in private. This even includes the case
where a temporary suspension had to be put in place already first, to
protect others.

Lastly, a forced apology puts any victim into the awkward position that
they're forced to decide whether they want to accept the apology, or
reject it. This essentially offloads part of the CoC enforcement work onto
victims, which often are not the ones with the power to actually stand up
to problematic behavior.

Note that I don't see this as a nack, just a heads up that there's a
potential conflict. I'm not worried though since Dave and me know pretty
much everyone involved in both CoC teams. I'm sure if this ever becomes a
real issue we can bridge things and figure out a solution.

Cheers, Sima

> +
> +Remedial measures if there is no public apology for the violation
> +*****************************************************************
> +
> +The Code of Conduct Committee determines the next course of action
> +to restore the healthy collaboration by recommending remedial measure(s)
> +to the TAB for approval.
> +
> +- Ban violator from participating in the kernel development process for
> +  a period of up to a full kernel development cycle. The Code of Conduct
> +  Committtee could require public apology as a condition for lifting the
> +  ban.
> +
> +The scope of the ban for a period of time could include:
> +
> +    a. denying patch contributions and pull requests
> +    b. pausing collaboration with the violator by ignoring their
> +       contributions and/or blocking their email account(s)
> +    c. blocking their access to kernel.org accounts and mailing lists
> +
> +Once the TAB approves one or more of the measures outlined in the scope of
> +the ban by a two-thirds vote, the Code of Conduct Committee will enforce
> +the TAB approved measure(s) in collaboration with the community, maintainers,
> +sub-maintainers, and kernel.org administrators.
> +
> +The effectiveness of the remedial measure(s) approved by the TAB depends
> +on the trust and cooperation from the community, maintainers, sub-maintainers,
> +and kernel.org administrators in enforcing them.
> +
> +The Code of Conduct Committee sincerely hopes that unacceptable behaviors
> +that require seeking public apologies continue to be exceedingly rare
> +occurrences in the future.
> -- 
> 2.40.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

