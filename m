Return-Path: <linux-kernel+bounces-356303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EEC995F45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD91F21C68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5B01531E8;
	Wed,  9 Oct 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gluo-nz.20230601.gappssmtp.com header.i=@gluo-nz.20230601.gappssmtp.com header.b="sp4kSiZP"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85A2AF1D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453207; cv=none; b=d2vXC2kJNV4+k0JV8Jtp9SIOj4CJNaattkY79G8GMODMYe0OjWW+N+Zbl63CHZWDG4CWtW4S1JgXhUXv12ffU8nQa/bEPoRqVHNf7wmk7gkisolKVC55DArwixErxdqE6WRkJdQZ1ds+PA3Qk407ychVngjYfWJHhQobqCnuHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453207; c=relaxed/simple;
	bh=JQlAKpiBM2wslGk4kNSQ0u7qiLodT79BIn8TX8KP8Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA8PfEp8nGDFeh+Ehx1zGRFPiejqBwQ7IjRT9I1Qi/s3U8P0kNbt0eeUkE18/vjd5d3raqYJKZ6Y8E42Z2fmmoGcrI4ff/BONpT17vVjAt8RvpuBow8lnOYnqGgc7NUEpPAXA7B5FbFOdFRSP10Oyvz3AqR9Gf50sW0nzZZ/lBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gluo.nz; spf=pass smtp.mailfrom=gluo.nz; dkim=pass (2048-bit key) header.d=gluo-nz.20230601.gappssmtp.com header.i=@gluo-nz.20230601.gappssmtp.com header.b=sp4kSiZP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gluo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gluo.nz
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e05198d1dso1992755b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 22:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gluo-nz.20230601.gappssmtp.com; s=20230601; t=1728453204; x=1729058004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQlAKpiBM2wslGk4kNSQ0u7qiLodT79BIn8TX8KP8Qk=;
        b=sp4kSiZPpWrVmW394Enxnz3ui4TQ/IY6FRVyWAa03kdKAm8DnVEqiJVhB82AxHrsgE
         22c4UdvSIObR3btbJLh1Pfu6gIQRzgjx7pbU3oRbRcilTeSW8AUQNloB9BVV4mEbaa9N
         plJbxUps/yOFJnfuT1em/r2gU2FJEDXEUSUM+IY7Ah3tq7P/nf6/P/5j4H2x8l6P3Eb1
         D9Cqoi+FdX9yLT2Zr0atoLKjH158tiZvcGEa27K/ptYl+e6XvSWgHcjxoq+YRoAVgdJ8
         SnJ8RLUv30kU9NK1kGwZg0OEVd7LLUYBb/Vb1KqGlpDbC37xZ477asEP4Nm/S1b6Vd7i
         xdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728453204; x=1729058004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQlAKpiBM2wslGk4kNSQ0u7qiLodT79BIn8TX8KP8Qk=;
        b=ppbYX3ZOqOf2ib9BU6MxHmERqKhmdrKeY056vOSQ7pfbLu80q+dQE+AGvdcBleasbW
         I3MeY2yRN5/L0ZZBPPWLGp1ARQbw/E5kMXt/+04OYyAgLf12o4cTFqvabqXoVUq4MS7R
         1bF9w8oQiocClXuclMFD7P9+MrSl9g3me2zPvkJvKOsU0H8TJF0m+nvqsXqxvqu/qeXF
         yILFhizkWiqyb5VsK+UptEZHAUZQmZgzLg+GVBBPk8Nbxt8WseWDC9tRywA3MO6Ejtst
         47fQdC6rad9ulSj1zzJxaFDkEKqpsFxlCWapmB7Lsds74vNuC6xRFru8KkqaIZs4hNwt
         vEJA==
X-Gm-Message-State: AOJu0Yw6Qe+JOzx8bv1JCgYFL9FD3TuK8V+fMPNfa+gHNkJKPGuYvpdG
	Vvv4oaHY9VNqRdDmTtVTAEO6XOmrzyaKFsak+RHe2Kj9b7RBKu5iZ6AdRaD5QxVr2DRM4CUKutC
	w
X-Google-Smtp-Source: AGHT+IGnUi27x/j+7MgRJQomk/5p0A0rKqfgaeNqdaJPBz243DnL4S+o0N9abJ51WzxNCXMI4qUIXA==
X-Received: by 2002:a05:6a00:179b:b0:719:7475:f07e with SMTP id d2e1a72fcca58-71e1db6481fmr2538690b3a.4.1728453204189;
        Tue, 08 Oct 2024 22:53:24 -0700 (PDT)
Received: from Purple-Sunrise.. (125-238-16-224-adsl.sparkbb.co.nz. [125.238.16.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d695cdsm7085633b3a.183.2024.10.08.22.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 22:53:23 -0700 (PDT)
From: Daniel Hill <daniel@gluo.nz>
To: linux-kernel@vger.kernel.org
Cc: Daniel Hill <daniel@gluo.nz>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Date: Wed,  9 Oct 2024 18:51:50 +1300
Message-ID: <20241009055217.778948-1-daniel@gluo.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
References: <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I'm more than happy to work with people, but that's got to be a
conversation, and one based on mutual respect.

As someone who spent a year and a half working directly with you,
You're full of shit, Linus has spent over 20 years working on
Linux actually collaborating with thousands of people around the
world and then you have the arrogance to think you know how to better
run a collaborative project than him.

You say you care about stability, mutual respect, and making it
easier for your users.

You keep hating on btrfs like an insecure child.

You never afforded any respect to your users, like saying sorry
for your constant temper tantrums on IRC at noobs asking simple
questions.

You put your ego before stability,

Every single version of bcachefs I used for the last 3 years was
a x.x.0 release, I do not recall you ever rebasing to a newer minor
version inbetween major releases. And yet you now cannot empathize
with Linus as you toss 1k lines of code, with missing commit
messages, touching non-bcachefs code moments before the merge window.

You neglect reviewing my branch for a week, with a year old bug
I was working on, you reviewed a different patch, the following
Friday that had been sitting there for 3 months, and was not a
high priority, You accused me of not respecting your time, for
working on the bug fix instead, on the Saturday less than 24
hours later, after wasting my time all week, and the preceding
3 months with the prior patch.

And of course you prioritize your ego over this bug fix and
blocked me when I called you out on this hypocrisy.

That bug fix sits there for another 3 months, being ignored in the
mailing list till I nag you, about it in IRC channel, and ofc you
loved to toss around insults like the man child you are.

You would use any dirty tactic to win arguments, including
personal information I entrusted with you.

Just because you have issues with users having bugs doens't mean you
have the right to create more issues for others.

It's not that hard to setup PPAs for your users. And miss a
merge window every now and then.

I would advise Linus remove bcachefs from the kernel, I have zero
faith he'll change, if there are no consequences for his actions.

> And "upstream rules" has always been a fairly ad-hoc thing, which even
you barely seem able to spell out.

No Kent, Your reading comprehension is just terrible.

No one is on your side Kent, you're the laughing stock to everyone
covering your Drama, no one else needs it "spell out", just you.

You've been a solo dev for over 10 years, and you'll stay a
solo dev for another 10 if you don't harden up, put your big
boy pants on, lay off the weed, and get a therapist.

