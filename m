Return-Path: <linux-kernel+bounces-370937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9342A9A33FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD9285498
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF017332B;
	Fri, 18 Oct 2024 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maC0+Jhw"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B32A1A4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227509; cv=none; b=QV4/4nB8gL5caSa3IbhAaAkP/klVXtgjk9PlzX8Blr2A5HuWBk+XP+bVkDAOzbreIJfGWQe0U9+RXAHCCnXzcY9DbhvwRIIfFTqqimqAmbUqcI/BYFRGdQ7kL9aJ5zQk313Z3RIeOg4fHSUZJjjgHaBMbiDR3J9S0AEbDsIhm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227509; c=relaxed/simple;
	bh=rYZm+Tqq/WZfPPSajpWGLqxVPXJ+3HvaNpbQlh9MbUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TQhqjg82NqpdDWosAGv7z9dWxw05yqDPLwIaCYZcqPal305qpuXFHi8l1znbYU3i+o019DV8seNcPFXPikT5V1uXc9edrCGSErCydfr57bqyCqHg0msHyiXB9FAVwWdsr9zXhgp1rse381Bt/PtD/Y30WCvcz1SH+9QEkGrBFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maC0+Jhw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so11860896d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729227506; x=1729832306; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cYm9sM43ycmflvnmdMHvkWe+Ks10/Yq6mWT0Q9PKNWc=;
        b=maC0+JhwlFZxAXdCR4I6gfzYAlmbEB3PJM8OXUSU6G9r6RfqmTF8m2BfP/xf9cJzPL
         XvIeBrP+/OzJ1wExbed0gUER6uCwWjsK6KKUKSp7mckoIIX+3TQepgNZR1J75Qp1sjPO
         aR3gtlIJxIHE8T7w2jWSrG7z9SKj9wjQGP7xXIk5nmIs5PpNl8kgXsIRxRSSPRjyV+Xp
         ZwCedCzdBP+Mkh0V+tL3DejCxUNT4oz3ZO1W83mpNTRDzpJnCSrOvduwj013fg+Nivju
         ZB5m/jU+HarU206Cdr5NZob4+ZYOIwQ07HCEsI9bFP0m0wTnGqiTELZBCSCMnfLByrMm
         ftNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729227506; x=1729832306;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYm9sM43ycmflvnmdMHvkWe+Ks10/Yq6mWT0Q9PKNWc=;
        b=Q+hlHw1yzfe1OoKD4jHKlWul25nKJQihkDcbC4aD+aacUm3+2xRHsUp9bpO6IhsCVO
         XeAQwva7S08Y+aIDZfQB9gS+fPnmPM3bWnz5US8Fo4ccpBJ8tz+ZwReBW8g0xaZvyauk
         DRqXE/4XCGxjqRMp6nBY6u+loSSpi6oMZWWOmN+TYS83Zy8T6dKIVTeR7l0KJyG/mh25
         kT0vLJaoGABwiR5zaHzLjLjozvC4JI/HIHqv0LxYqKdXrynDp0dm1B7hpEnBE8lOAC80
         1GQ0UC9g4x+VB6DNGOfEFxXBc9y9zrkwLq3lHXIc/J0hwKcELZ7J503AuTR6OkwWPm4J
         j3EA==
X-Forwarded-Encrypted: i=1; AJvYcCV1R7nQGNNGQvOb4vhxvgmlQNKYNSkEHSeXgSb36V5m4s0dd3Dc9E1A5Xd4fE1UNNnJyBfruugM94l4dng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdqmyGvba1FBsdpcmeStjbpi8wlUfUcOYh8I6loePJPj2WVEg5
	HxnvB5bvsezSHsNlTRipqEpp57xe/CLPbsU64SiNYgsnCtEjlQVJ
X-Google-Smtp-Source: AGHT+IFAYOOmzCdteQAL6fs8c+dw5tYEy8ZPdjxJJX7fWGJxgB2eaRmS42aYirrsXOxI5wdqewfPQQ==
X-Received: by 2002:a05:6214:568d:b0:6cb:8339:3443 with SMTP id 6a1803df08f44-6cde14c40aamr17989366d6.7.1729227505958;
        Thu, 17 Oct 2024 21:58:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde111b4c0sm3543246d6.18.2024.10.17.21.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 21:58:25 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 06201120006F;
	Fri, 18 Oct 2024 00:58:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Oct 2024 00:58:25 -0400
X-ME-Sender: <xms:8OoRZ2bNu6hsFreBDpzfFP3SG703i1EHSBAajTlqkhk0_6bA7kCIAA>
    <xme:8OoRZ5Y0fqhWI2tgRwoaRlpht6djasojg10yac31K9Lztc9yOsKjwM0vm_P-GEsMO
    H23mAS_tthIYNlazA>
X-ME-Received: <xmr:8OoRZw-Ao6acR8BK9XtQ7gu5JbMpLJmRr6aaGQtWJqVh3LnPaQDGCh3VZsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeltdefueegfefhuedtheefvdelhfeftedvhfdtveel
    ueegtdejjedvieettedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegsohhquhhn
    rdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhr
    ohhnihigrdguvgdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehthhhomhgrshdrhhgvlhhlshhtrhhomheslhhinhhugidrihhnthgvlhdr
    tghomh
X-ME-Proxy: <xmx:8OoRZ4psYi2Mq0w2u3gQeeCKPLkZfEy8QzciVNYlRc6kamfuLR-0Tg>
    <xmx:8OoRZxr357ejcHLjIsf1Zn3OLLILApRZTyi2CDRbwETNgefqXe-k9g>
    <xmx:8OoRZ2QupI4urHTor7i4tis1AILwXKQIsvD0pA3oJrhGxTtIAJIf_A>
    <xmx:8OoRZxoqYyxwoRZD9YM2lEEdYCR--BuKI87kyVjEXkIc228ZqDDo5A>
    <xmx:8OoRZ-4VtWKBc58vdmmb4i_wvAbT3K6Ij2v2aLqnUMXfT0pTWPQyAaf_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 00:58:24 -0400 (EDT)
Date: Thu, 17 Oct 2024 21:58:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com
Cc: will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	paulmck@kernel.org, thomas.hellstrom@linux.intel.com
Subject: [GIT PULL] LOCKDEP changes for v6.13
Message-ID: <ZxHq7-o8vV07M36J@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter & Ingo,

Please pull the changes of lockdep for v6.13 into tip.

The following changes since commit 87347f148061b48c3495fb61dcbad384760da9cf:

  futex: Use atomic64_try_cmpxchg_relaxed() in get_inode_sequence_number() (2024-10-17 22:02:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux tags/lockdep-for-tip.20241017

for you to fetch changes up to 2628cbd03924b91a360f72117a9b9c78cfd050e7:

  locking/pvqspinlock: Convert fields of 'enum vcpu_state' to uppercase (2024-10-17 21:21:16 -0700)


Again, I've reviewed and tested these changes from my end, but since I
don't have a branch tracked by linux-next, so that part of testing is
missing. It does pass the 0day build test though. Two important things
(because of which I'm happy to redo the pull request):

* I added a non lockdep patch into the pull request:
  
  "Convert fields of 'enum vcpu_state' to uppercase" [1]

  Because it's trivial enough and we also have Waiman's Acked-by.

* There is one commit in tip/locking/core that may need some changes
  because it fails lockdep selftests. See [2], and the author (Cced)
  already send a new version [3]. If you want to rebase the
  tip/locking/core, I'm happy to adjust my pull request on to it, if
  needed.


I read through Documentation/process/maintainer-tip.rst this time, and
try to apply it to the patches in this pull request. Hopefully I'm
getting better. Thanks for the patience!

[1]: https://lore.kernel.org/all/20240809014802.15320-1-qiuxu.zhuo@intel.com/
[2]: https://lore.kernel.org/all/Zw19sMtnKdyOVQoh@boqun-archlinux/
[3]: https://lore.kernel.org/all/20241017151007.92215-1-thomas.hellstrom@linux.intel.com/

----------------------------------------------------------------
Lockdep changes for v6.13:

- Add a cpu-offline callback for lockdep to reset hardirq tracing status, this provides
  more information to locate issues other than a triple fault on x86.
- Fix an issue that lockdep_set_subclass() can set the lockdep_map::name into a newly
  created one instead of the existing, this can end up with a WARN triggered in
  look_up_lock_class(), because class->name != lock->name while the key is the same.
  A test case is also added to prevent this from happening in the future.
- Use pr_info() to print lockdep initial information instead of printk().
- Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.
- (non lockdep) Convert fields of 'enum vcpu_state' to uppercase.

----------------------------------------------------------------
Ahmed Ehab (2):
      locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()
      locking/lockdep: Add a test for lockdep_set_subclass()

David Woodhouse (1):
      lockdep: Add lockdep_cleanup_dead_cpu()

Jiri Slaby (SUSE) (1):
      lockdep: Use info level for lockdep initial info messages

Qiuxu Zhuo (1):
      locking/pvqspinlock: Convert fields of 'enum vcpu_state' to uppercase

Sebastian Andrzej Siewior (1):
      lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.

 include/linux/irqflags.h            |  6 +++++
 include/linux/lockdep.h             |  2 +-
 kernel/cpu.c                        |  1 +
 kernel/locking/lockdep.c            | 46 ++++++++++++++++++++++++++++---------
 kernel/locking/qspinlock_paravirt.h | 36 ++++++++++++++---------------
 lib/Kconfig.debug                   | 12 ++--------
 lib/locking-selftest.c              | 39 +++++++++++++++++++++++++++++++
 7 files changed, 102 insertions(+), 40 deletions(-)

