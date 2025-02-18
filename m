Return-Path: <linux-kernel+bounces-520594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D3A3ABF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB087A4D78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520991D934B;
	Tue, 18 Feb 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FNRWVJRO"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B72862AD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918736; cv=none; b=f4bnLtVU44RV8ytLVlpzKYLc2Lq3rci3lP2Y7YBXryKt0A7ADR3Ohv8QLMWX0j0HnWix3yPaZsvMKTJBjnFq8ZdJUqOI6s/F+0anjG9DrNrJ35tUnAiZ4OLuhgr85fsRWxehzxigwTrts5XWjTdsp2h9DTAzfniEaphU9VwrRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918736; c=relaxed/simple;
	bh=pDXJlYOhmxnG/vCxCa4NOR5yiX5WAl+tSCYYh/n8TVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfG6mjxq4XBx43+ojL+EGcwwczjk+LFTmAhTaUFJmg6mGkaVnnIsoDdoaKr5mtijO1UREnt2cmHFTyg6lX17ZY67BLvkBkpjmKM5hUKAtJqCDQHuCLGlSX58MgccnmalU8UKAkn+p7NfDpZdGZc4gDfXDyyyuJrIV/hW5j5D91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FNRWVJRO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc3a14f6fbso5737768a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739918734; x=1740523534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/xx6dkBUeIVG8oTbkClcSNDgI7h90Rn+ZsSHTGSKHXc=;
        b=FNRWVJRONKaj9ruiR2Mo8QL0s7ApKkZVSBIm/jyHcu4Y5QOaToeyBSKsFgC1zFl2BV
         tr5dNj1F9ci9Jgio4UxlQBpV96bGWNldJ2av/UvS7DKG7dDQfL/mn87Y4KJJb0ycq4MW
         5YeNzw+MConte0HfzDZRiBINI0Nn8OxtWh01Jkaag3RsI8lpzwF85NLJRibK9QC56X7f
         CzsSfJTi2j30IPlD/79oXeiZR9bFchjqFmprLJYmE1jURcxuiossRzZmkaIsAIEvXyHV
         o6dvB0aCeSALNzT5dC8DHoBSZcthQs+ijqqq2tgl2YAjOH1S13zq/u0Fb1njlUvgTGKW
         iHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918734; x=1740523534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xx6dkBUeIVG8oTbkClcSNDgI7h90Rn+ZsSHTGSKHXc=;
        b=ZNi/eRLKvnTJM23hkrzJDF2XnBZfi++AvU4VZ64lsi8wRObLZSNGUs3gBpejqFHPDI
         SKHC45Nb+HsmISwtDNhOKu2mUhkRyPDVdQUFDFQ3+UfvreqJTWI3dwAZYU6oKs+fbzG6
         fm4QKelehUAU6nYJyHfz93assqwSHFqhZP89e9smZVfEPXolyUK6ptiaZxolIcB8Uijt
         ZWXwLoYispda/ft4NZsucLv8+FYSxDTwLdybRR352IrSFxuvhtnNs9XkrLjUqAEsT4lU
         uZ0NRGu5bhJXUYXN+rhgW6k77afhCp/b8W8L/5cEcIswOuiwF9lnCFtJKI2CF/lMc5Ul
         aF7A==
X-Forwarded-Encrypted: i=1; AJvYcCWPmW6n5XdiltnEJKeegTW4BPwW5aevc5QGZRG2OE6plvTclYJz/5ytuNryqdd0Cx3yVV0uV4p9yIDrgfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPE2J+JDHPlLtaP+6DMV6qqFzjzP+TLCxMg7J30U0BXwrq7tH
	E1lo3IEiQJ1LnIonTwGRCtVZUq2enHqm6WufY3S1UUJt/Ilz4p15w9lN/16evmI=
X-Gm-Gg: ASbGncu6rjK3uCuAZ5gMABu9eJAUSfZbKc2R/f9rpsE9iOQxF8l3apDIgXdLfLCrYXW
	jmoLxv0onIBGj6DkpNXYkoG16+ARo+43RCGSnmFNHuAjS7GBr34dyu+rddXP0xYHlpUQO4F1wtA
	x5K/VGJ4hVQPnUpgSr0mzkbk4gzQ8loiFMdeIqdRFuZmQqZuBSpfubTWgBuyJ/WfpZ8h8YC2fxX
	y4CkdG5yb1bO/H9D6MSLngVSThBnfcqCA84b8I5iPBxnrypMoyk/CAWq0rzbpe0os6+xcTUMXqs
	0I5wkSxZj2C9aOA1wBowhGLlNOtWPpciKduuTZ7dy0CJAjnqLL1g5NWL56wjwOjypas=
X-Google-Smtp-Source: AGHT+IFz+JM5fhIpX/tcNhHfQtt3kRKjNpi15dD6z3153gVX1Eqs275LBOpyPOw68Jg99SAhnV3HaA==
X-Received: by 2002:a17:90b:38c6:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2fc40f10876mr27972033a91.12.1739918734068;
        Tue, 18 Feb 2025 14:45:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc2dccbf12sm4123118a91.2.2025.02.18.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:45:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkWLJ-00000002zSv-3G50;
	Wed, 19 Feb 2025 09:45:29 +1100
Date: Wed, 19 Feb 2025 09:45:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <Z7UNifDL-XwIBBPH@dread.disaster.area>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>

On Tue, Feb 18, 2025 at 10:13:46AM +0100, Amir Goldstein wrote:
> On Tue, Feb 18, 2025 at 2:33 AM Dave Chinner <david@fromorbit.com> wrote:
> > > Yes, you are missing something very fundamental to backward compat API -
> > > You cannot change the existing kernels.
> > >
> > > You should ask yourself one question:
> > > What happens if I execute the old ioctl FS_IOC_FSSETXATTR
> > > on an existing old kernel with the new extended flags?
> >
> > It should ignore all the things it does not know about.
> 
> I don't know about "should" but it certainly does, that's why I was
> wondering if a new fresh ioctl was in order before extending to new flags.
> 
> > But the correct usage of FS_IOC_FSSETXATTR is to call
> > FS_IOC_FSGETXATTR to initialise the structure with all the current
> > inode state.
> 
> Yeh, this is how the API is being used by exiting xfs_io chattr.
> It does not mean that this is a good API.
> 
> > In this situation, the fsx.fsx_xflags field needs to
> > return a flag that says "FS_XFLAGS_HAS_WIN_ATTRS" and now userspace
> > knows that it can set/clear the MS windows attr flags.  Hence if the
> > filesystem supports windows attributes, we can require them to
> > -support the entire set-.
> >
> > i.e. if an attempt to set a win attr that the filesystem cannot
> > implement (e.g. compression) then it returns an error (-EINVAL),
> > otherwise it will store the attr and perform whatever operation it
> > requires.
> 
> I prefer not to limit the discussion to new "win" attributes,
> especially when discussing COMPR/ENCRYPT flags which are existing
> flags that are also part of the win attributes.

Not sure I understand why you think I don't know this, and why it
is a problem in any way?

> To put it another way, suppose Pali did not come forward with a patch set
> to add win attribute control to smb, but to add ENCRYPT support to xfs.
> What would have been your prefered way to set the ENCRYPT flag in xfs?

<sigh>

We don't have encryption on XFS yet, so we'd completely ignore it.
It would never be set in the GET op, and it would be ignored on the
SET op.

> via FS_IOC_SETFLAGS or by extending FS_IOC_FSSETXATTR?
> and if the latter, then how would xfs_io chattr be expected to know if
> setting the ENCRYPT flag is supported or not?

chattr is not the interface for enabling encryption!

FS_IOC_FSGETXATTR returns various status information, and a subset
of that information can be used for changing inode state with
the FS_IOC_FSSETXATTR command.

The reason SET ignores stuff it can't set is because it expects that
GET->SET will result in flags being set that it can't actually
change, and so it ignores flags that cannot be set....

> > IMO, the whole implementation in the patchset is wrong - there is no
> > need for a new xflags2 field,
> 
> xflags2 is needed to add more bits. I am not following.

We've got a 13 or 14 free flag bits still remaining in fsx_xflags
before we need another flags field.

> > and there is no need for whacky field
> > masks or anything like that. All it needs is a single bit to
> > indicate if the windows attributes are supported, and they are all
> > implemented as normal FS_XFLAG fields in the fsx_xflags field.
> >
> 
> Sorry, I did not understand your vision about the API.
> On the one hand, you are saying that there is no need for xflags2.

Because we have enough spare bits for all the new flags, yes?

> On the other hand, that new flags should be treated differently than
> old flags (FS_XFLAGS_HAS_WIN_ATTRS).

Yes, new flags can have different behaviour. If we tell userspace
that we support windows attributes, we can define whatever behaviour
we want when setting -those new flag fields-.

> Either I did not understand what you mean or the documentation of
> what you are proposing sounds terribly confusing to me.

Misunderstanding, I think.

> > > The answer, to the best of my code emulation abilities is that
> > > old kernel will ignore the new xflags including FS_XFLAG_HASEXTFIELDS
> > > and this is suboptimal, because it would be better for the new chattr tool
> > > to get -EINVAL when trying to set new xflags and mask on an old kernel.
> >
> > What new chattr tool? I would expect that xfs_io -c "chattr ..."
> > will be extended to support all these new fields because that is the
> > historical tool we use for FS_IOC_FS{GS}ETXATTR regression test
> > support in fstests. I would also expect that the e2fsprogs chattr(1)
> > program to grow support for the new FS_XFLAGS bits as well...
> >
> 
> That's exactly what I meant by "new chattr tool".

"new chattr tool" implies a new implementation/binary, not modifying
the existing tools.

> when user executes chattr +i or xfs_io -c "chattr +i"
> user does not care which ioctl is used and it is best if both
> utils will support the entire set of modern flags with the new ioctls
> so that eventually (after old fs are deprecated) the old ioctl may also
> be deprecated.

We will never be able to deprecate/remove deprecate the existing
ioctls.


> > > It is true that the new chattr can call the old FS_IOC_FSGETXATTR
> > > ioctl and see that it has no FS_XFLAG_HASEXTFIELDS,
> > > so I agree that a new ioctl is not absolutely necessary,
> > > but I still believe that it is a better API design.
> >
> > This is how FS{GS}ETXATTR interface has always worked. You *must*
> > do a GET before a SET so that the fsx structure has been correctly
> > initialised so the SET operation makes only the exact change being
> > asked for.
> >
> > This makes the -API pair- backwards compatible by allowing struct
> > fsxattr feature bits to be reported in the GET operation. If the
> > feature bit is set, then those optional fields can be set. If the
> > feature bit is not set by the GET operation, then if you try to use
> > it on a SET operation you'll either get an error or it will be
> > silently ignored.
> >
> 
> Yes, I know. I still think that this is a poor API design pattern.
> Imagine that people will be interested to include the fsxattr
> in rsync or such (it has been mentioned in the context of this effort)
> The current API is pretty useless for backup/restore and for
> copying supported attributes across filesystems.

xfsrestore has been using this interface for backup/restore
for about 25 years now. It only uses the SET function, because the
dump format stores all the flags from the dump side GET operation
natively.

i.e. xfsdump returns all the FS_XFLAGS that it supports in bulkstat
output so that xfsdump can avoid needing to call GET on every inode
it is going to back up.

So, yeah, we've been using this get/set xattr interface successfully
for backup for a long, long time.

> BTW, the internal ->fileattr_[gs]et() vfs API was created so that
> overlayfs could copy flags between filesystems on copy-up,
> but right now it only copies common flags.

That's an implementation problem, not an API issue.

> Adding a support mask to the API will allow smarter copy of
> supported attributes between filesystems that have a more
> specific common set of supported flags.

I don't think such a static mask belongs in the GET/SET interface. If
overlay wants to know what features a filesytem supports so it can
find commonality, then the feature mask it should be calculated
once at mount time and not on every single operation...

> I'd still like to hear from other stakeholders before we perpetuate
> the existing design pattern which requires apps to GET before SET
> and treat new (WIN) flags differently than old flags.

I just don't see why we need -yet another- inode attribute userspace
API just to support a few new feature flags...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

