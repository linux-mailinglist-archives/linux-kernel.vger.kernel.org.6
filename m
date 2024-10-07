Return-Path: <linux-kernel+bounces-353608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A4993040
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F931C223E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2F1D7E38;
	Mon,  7 Oct 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Hko1MCZ/"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A61D54CD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313132; cv=none; b=Foa41r1r3Prqv6lubNZ9wPHwZr2ENtZOXBVBk7oYihXxl9Kw50D2k2S91Rf9cfZM/o/BfBPUhF70aSdX2JVgfrbt6qotJN/0ejZ2vgG86hPPHGBJXTYTNOI/N+uVZj9RIyV/907wtBECagUsvh8UE+FWcPXH2qrm1UaBTSZ/O+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313132; c=relaxed/simple;
	bh=QBsQhjUyUz1tCiHen3Lowcz+ZZiBnQZMx/wX5smwJVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdhtMRuMur8IC7dRqA7i1eX1HLMtIViTYKJM4gHNMchZxTDSDfCg1YPVmKJl82zV0mVO2cfp1Rm0yXQ5gA3i6xZhSyTpWQRJU/nhL1dLi5bLQlRTYHbGufYk/hDQDamdN0qp5royKAYN2hBnBvt5HUfWpwn6RoAzTnWJ4jdISv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Hko1MCZ/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7ae491dacaeso546603885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1728313130; x=1728917930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKkXYRf3CazOv0yTJuEZUWEXywOPV0BtkaPCj1lqhQI=;
        b=Hko1MCZ//HE39ANamy3pyJhHUMnNwQTupHMwZjneBzA6QQ2J/Emnaaxkl9KjSbjBx0
         FJAjXlQJ2tIv1IZylirfAXaEGJGuKE5x0xZIhOudSky9+ONNxFHEb+WyYwGPUnyNzrmE
         F7YsITBu7uziHEQ4tg6tPbZ1nVMwro1LBGUHb4PVlLtzvimd/ur+SwQONPCR7xf8qg3p
         ooUx2rV56R+EXJ4zhHrTFjj27IdSEu1SG3RrY59q9OutnJlDpNCQD9fHxKdr02mPnmXx
         NmJ52WwLzZWONHyQEr1dgdPLbwlYPt1lqFmw2Vf4xQFYWCiZ3CfSAFzBEJMLZhGDkkJq
         fh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313130; x=1728917930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKkXYRf3CazOv0yTJuEZUWEXywOPV0BtkaPCj1lqhQI=;
        b=nzgrTaE/gEAkDjkIi+yxn91i7phYEjhxupq9jlVs3q+qWihPpu4AEBmjnz/SaPsMMc
         glnKVhy1qWnKQ577f7XtGb2PKUaqcegPSQPAGsUHuJdjK1CF74IZR/XZSkbvsC/OcRcW
         3RjONalBWxZxVVUg34ULsY3NlWurSCBSB4RfVzvTynpoW29BteDyO+GoNGnuhekmr0NL
         46+MVudU8Y9Q92rIAPWhi187IdNCSY0I5+jDV7VqXRTdPrR0lgr0O2dJjlsc3k+t/Rn/
         iX3tiTib4oStQywtXryQtjLPiB6+2OxaDdMrC07yqIsiceEMqA+vA7YXpMlvYNuW1IPy
         36mA==
X-Forwarded-Encrypted: i=1; AJvYcCVEm4ljP5XenVU61Q7QhQvrTk8HOALE8GwjQGtO0buIo16B0TTQ+C9DUIz7jqJO0dKotp82X/EcGyPvmw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zUzhqsPm6GPJwH2A4Bvv62UEp1ffYb2brFmWQwWPth7phISX
	RFi4xIOaybLM8M3AT/5BngJWIYN8H2wvQY4nq2xwu4JpW9ZRz8FiaqttBt4cyEE=
X-Google-Smtp-Source: AGHT+IHsLuu+g/YCiRe1EnQsVxFfrwZ3QXsTNYIeeeF4z1PpU/nBB4QTE1vrQPg0iOfC0ehh2vgNow==
X-Received: by 2002:a05:6214:5889:b0:6c7:c645:f0fb with SMTP id 6a1803df08f44-6cb9a3096aemr206595996d6.18.1728313129677;
        Mon, 07 Oct 2024 07:58:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4751520sm26304086d6.83.2024.10.07.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:58:49 -0700 (PDT)
Date: Mon, 7 Oct 2024 10:58:47 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <20241007145847.GA1898642@perftesting>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>

On Sat, Oct 05, 2024 at 06:54:19PM -0400, Kent Overstreet wrote:
> On Sat, Oct 05, 2024 at 03:34:56PM GMT, Linus Torvalds wrote:
> > On Sat, 5 Oct 2024 at 11:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > Several more filesystems repaired, thank you to the users who have been
> > > providing testing. The snapshots + unlinked fixes on top of this are
> > > posted here:
> > 
> > I'm getting really fed up here Kent.
> > 
> > These have commit times from last night. Which makes me wonder how
> > much testing they got.
> 
> The /commit/ dates are from last night, because I polish up commit
> messages and reorder until the last might (I always push smaller fixes
> up front and fixes that are likely to need rework to the back).
> 
> The vast majority of those fixes are all ~2 weeks old.
> 
> > And before you start whining - again - about how you are fixing bugs,
> > let me remind you about the build failures you had on big-endian
> > machines because your patches had gotten ZERO testing outside your
> > tree.
> 
> No, there simply aren't that many people running big endian. I have
> users building and running my trees on a daily basis. If I push
> something broken before I go to bed I have bug reports waiting for me
> _the next morning_ when I wake up.
> 
> > That was just last week, and I'm getting the strong feeling that
> > absolutely nothing was learnt from the experience.
> > 
> > I have pulled this, but I searched for a couple of the commit messages
> > on the lists, and found *nothing* (ok, I found your pull request,
> > which obviously mentioned the first line of the commit messages).
> > 
> > I'm seriously thinking about just stopping pulling from you, because I
> > simply don't see you improving on your model. If you want to have an
> > experimental tree, you can damn well have one outside the mainline
> > kernel. I've told you before, and nothing seems to really make you
> > understand.
> 
> At this point, it's honestly debatable whether the experimental label
> should apply. I'm getting bug reports that talk about production use and
> working on metadata dumps where the superblock indicates the filesystem
> has been in continuous use for years.
> 
> And many, many people talking about how even at this relatively early
> point it doesn't fall over like btrfs does.
> 

I tend to ignore these kind of emails, it's been a decade and weirdly the file
system development community likes to use btrfs as a punching bag.  I honestly
don't care what anybody else thinks, but I've gotten feedback from others in the
community that they wish I'd say something when somebody says things so patently
false.  So I'm going to respond exactly once to this, and it'll be me satisfying
my quota for this kind of thing for the rest of the year.

Btrfs is used by default in the desktop spin of Fedora, openSuse, and maybe some
others.  Our development community is actively plugged into those places, we
drop everything to help when issues arise there.  Btrfs is the foundation of the
Meta fleet.  We rely on its capabilities and, most importantly of all, its
stability for our infrastructure.

Is it perfect?  Absolutely not.  You will never hear me say that.  I have often,
and publicly, said that Meta also uses XFS in our database workloads, because it
simply is just better than Btrfs at that.

Yes, XFS is better at Btrfs at some things.  I'm not afraid to admit that,
because my personal worth is not tied to the software projects I'm involved in.
Dave Chinner, Darrick Wong, Christoph Hellwig, Eric Sandeen, and many others have
done a fantastic job with XFS.  I have a lot of respect for them and the work
they've done.  I've learned a lot from them.

Ext4 is better at Btrfs in a lot of those same things.  Ted T'so, Andreas
Dilger, Jan Kara, and many others have done a fantastic job with ext4.

I have learned a lot from all of these developers, all of these file systems,
and many others in this community.

Bcachefs is doing new and interesting things.  There are many things that I see
you do that I wish we had the foresight to know were going to be a problem with
Btrfs and done it differently.  You, along with the wider file system community,
have a lot of the same ideals, same practices, and same desire to do your
absolute best work.  That is an admirable trait, one that we all share.

But dragging other people and their projects down is not the sort of behavior
that I think should have a place in this community.  This is not the kind of
community I want to exist in.  You are not the only person who does this, but
you are the most vocal and constant example of it.  Just like I tell my kids,
just because somebody else is doing something wrong doesn't mean you get to do
it too.

We can improve our own projects, we can collaborate, and we can support
each others work.  Christian and I tag-teamed the mount namespace work.  Amir
and I tag-teamed the Fanotify HSM work.  Those two projects are the most fun and
rewarding experiences I've had in the last few years.  This work is way more fun
when we can work together, and the relationships I've built in this community
through this collaboration around solving problems are my most cherished
professional relationships.

Or we can keep doing this, randomly throwing mud at each other, pissing each
other off, making ourselves into unhireable pariahs.  I've made my decision, and
honestly I think it's better.

But what the fuck do I know, I work on btrfs.  Thanks,

Josef

