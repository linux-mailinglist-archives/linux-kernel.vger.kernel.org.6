Return-Path: <linux-kernel+bounces-520614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4416EA3AC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991647A6374
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B51DE2B3;
	Tue, 18 Feb 2025 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ML57H0ZS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67561DDC22
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919395; cv=none; b=H/2ivTpyPZZB/2CSyGboXaraeCerHsYD1hpSMiWd3V+wJpC8Z7AvmgZisVH7A/IYK7s3to6mfUc+Wmlm3WesybICS+4edcHqvdCbzgEnTDe7X+GqQtyx5QmAXCYdkjxJalNRPRCiy/07WNscNxgA6v3AHWYmoBRdJMANOh41zZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919395; c=relaxed/simple;
	bh=fVxPrj6+hYQCby6mCw3BdWYLLIhFV5a0roY1nnG1mjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM7WLYEfvFDAmuSyQbS2yMebLz60BA4/v0kFbWYY9B6sJKMOca92d7ApyjdAAImwX4VV7uO1WsgmHzyBzMsXkhK4rbMgAXM4ffPRVwdR3nqJArXZPx4+gcHyh+bh/op0ph++xvqpLVKnM4Xwu6ZE/tuDvy9OIBDuCzkEyMbS3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ML57H0ZS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c4159f87so80802795ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739919393; x=1740524193; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jOVGrwW7CiNLR2dUss7zOvX9uZEpJq6PAvR2PcA9dY8=;
        b=ML57H0ZSZIKh0NTFj/Hi4cwPTdM7DiQ7EsOi+TlZcfapBdS4AF5gDZ0FcOQBEGOIQt
         SAyE70RLfIzxbPi2a/WwrO9APgFDdg6bmPoCNoBNJB5IZzcmtxEK+K8+SfP652mSjNFE
         vDPw2MEcLJ/6a7/ATKS8yFK+1KCDOw63vWXG1gOiuXiCikObS2Qu82egYj7tMoJXpJqj
         woiX7fbDf4fvO2CETuVhgp7EyGTgn4wVCSpXdnfcoJpWEP5HzjEJNrGXSZ/k1+EEhUV4
         BnsuzlXcLXCgB7LHI0OEsDJTEbTuKqqe0fK1P1ADYR+lfg31c0Qbw+Y8JTWg4/7gmakX
         PuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739919393; x=1740524193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOVGrwW7CiNLR2dUss7zOvX9uZEpJq6PAvR2PcA9dY8=;
        b=b8X7P4uk7vTZh8LK8z5l4fM0KUU4Sr0Pe17tyX6D2EO15u1bL4ciTi/gnPprues/D7
         qfGx1keZiNrPUIyQdA1tdweg/TqSfBL4Wouplrd+CWxwNU65QX+zYTgaKdK5Jlg0w/TO
         4Xw63rD7DcVyuNJHEnNyyo6oqPjc+0WRskQ21pOSa7t2ov6NahIxTLb5+azm31KX0jmk
         afzX9K8xSUdk9938tHnnqjNuWajatHLIiHpnWyjpVERBQ4lvcNfL7gOXSc2w6JJlWceW
         CWsAFf/yj5IUERt5KlkxBBJn9nUW4b2LM/42oVZlZSTS2JOJPHLJqM8syOcWLLa0dohu
         A9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeW+GhOr6haFZffdbzMKa468D7qkmHmZjL3+2ErWvKHT76UdTQZ1nvd17pUL3dSEmGvgtF528SmuTOT8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQM4uhp9JycdwuvhG9P6vRDtdsNjmop7/o2niI0BWN3pnEfRMw
	Gwhl/fIsBC9vVEoi4juNQY1ogtpm1JzMbAb+28m9qVl9VCQCehV/mEE2UArk2z8=
X-Gm-Gg: ASbGncubI70DgaNyZjpVrjXVLgEd00VMS7CdAZ6wb9r8Aj5gQURePa0Lysmzp8/kIHJ
	IkWUmAE+vPOcKuM2Q1llRVIGP8L0CQ49Whvip6VtFqNfahXAYWGaDZOoLzHUM8/v3xHPaqhqu4l
	lIxOOF9S82y7Uu6IzT2ruFGHc8T7vABf+74flLY7ixWH6QhD5qNCNmf1sIhZp+XQlX74qZKKEcv
	h5dB1WbOGmDEZEso1TsBPLrKoi9ofXJWA59T6h2lQ/HhvhEn0aMGxdPJ/dlXvzIhQ/5IsE4E/Yv
	XxOVuIygtsw2527qRKkShl9BbdgErTPcK6cbvO0vejNOBA9pN0DU0rxP
X-Google-Smtp-Source: AGHT+IFNeXqjJ+MxQ2VULjeC3pvBgrgbvWZov0RSWVHhUVra12Eag2ZgbapyJo1xvpnq4PV+cNOtZA==
X-Received: by 2002:a05:6a00:929a:b0:732:a24:7351 with SMTP id d2e1a72fcca58-7326179d65bmr26282695b3a.6.1739919393107;
        Tue, 18 Feb 2025 14:56:33 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73274a11a0bsm5349794b3a.123.2025.02.18.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:56:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkWVw-00000002zlY-37rX;
	Wed, 19 Feb 2025 09:56:28 +1100
Date: Wed, 19 Feb 2025 09:56:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <Z7UQHL5odYOBqAvo@dread.disaster.area>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218192701.4q22uaqdyjxfp4p3@pali>

On Tue, Feb 18, 2025 at 08:27:01PM +0100, Pali Roh�r wrote:
> On Tuesday 18 February 2025 10:13:46 Amir Goldstein wrote:
> > > and there is no need for whacky field
> > > masks or anything like that. All it needs is a single bit to
> > > indicate if the windows attributes are supported, and they are all
> > > implemented as normal FS_XFLAG fields in the fsx_xflags field.
> > >
> 
> If MS adds 3 new attributes then we cannot add them to fsx_xflags
> because all bits of fsx_xflags would be exhausted.

And then we can discuss how to extend the fsxattr structure to
implement more flags.

In this scenario we'd also need another flag bit to indicate that
there is a second set of windows attributes that are supported...

i.e. this isn't a problem we need to solve right now.

> Just having only one FS_XFLAGS_HAS_WIN_ATTRS flag for determining windows
> attribute support is not enough, as it would not say anything useful for
> userspace.

IDGI.

That flag is only needed to tell userspace "this filesystem supports
windows attributes". Then GET will return the ones that are set,
and SET will return -EINVAL for those that it can't set (e.g.
compress, encrypt). What more does userspace actually need?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

