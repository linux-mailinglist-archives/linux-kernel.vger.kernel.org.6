Return-Path: <linux-kernel+bounces-364736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C145D99D8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF02828BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5B1D0F5D;
	Mon, 14 Oct 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGQKJiQO"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DD4C7C;
	Mon, 14 Oct 2024 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939488; cv=none; b=Leo49ENiNVQsBswhPAvI45xD5iBHhghvrPaIIDNddvjsN2eePcpfySAQ2DmVjujuBgl5/G7j9t02NyLMJ1gZrLEWctMEciWWl2KkSAlhiN0fnKfkLZrlMvO0GULYxPOITnE6Lnv5uKCRRCYQ/CutI0Xk8Qo6kKA1yYKcGA72RIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939488; c=relaxed/simple;
	bh=7XwipAiPii3LUrXDPlkFRJBwlhMTZ28xQYxDIsAf2V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uySg/JL7qJYKPKx9yrq4M6U1vQlYCvUDzksETNy4T+w/Pk4aR05scuPuLzA9/+sEz5f/WYBew6Ux/QAN3anbfyb23BpT6OhjM/bcFLS5BIVx5LghegpdUxfaeZ6fe75snByzDSnYiKVWLmp76dLYhf0J2o9ok+sQIaiM1I9NOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGQKJiQO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4603b835a1cso47526611cf.0;
        Mon, 14 Oct 2024 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728939486; x=1729544286; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XS8odNExCzPehhhxHMvAwzLaD9DLX1qfMdHuisTjlj8=;
        b=WGQKJiQOxtkM8ZJUpS8sIsIjkzkZWFofahqM+UbcS89VEQVy4+iELLzq10OQG9zfgQ
         WjxaBrF3uv13TqRP1oBQyHoJ+6awLpM9dqIQBDEoQHa1dMbxNJtHfOMyVAtrvJZGkJqR
         deKGdsl3w4QQi0EUEkpUpq9zGt5m7wwFPE+T96BMhd+Je1Di8m8VXUxfzfgkkRCrIQAh
         5gJ9JCZu4uabHF9c+rAYJ3Fh+8JcS1C6H85q5XIEqDigoAYGGqsk1ElX81XnGzE6zoDh
         qARXT+66aIXad4svoV1DnL90vVT0mCPzoZY45NityVqM01henZf6fqZo/BS1afxmRTfk
         hC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939486; x=1729544286;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS8odNExCzPehhhxHMvAwzLaD9DLX1qfMdHuisTjlj8=;
        b=pe2XDLssisuXCGHZbqufVryJwxjjIiVlH1C8w+TW3eNbO0eRiApqo+RS5WKJ8qpKL8
         7sMVSuU1NH9S6e21AA4jIptZK/c1P7gCZkF/nWdg8ajTzP0hGSiikktMprLxLn1g/1nz
         1MsavGyxPUbXhHuupS18MQnI+R4aNorT0LwqYmPOH1H0ODtg6H0iLnAAprju1cVXXNps
         ux9W4gkt8jQsKpbLzeN5D6x7zxE1eOTBMkk7pODoudIemi0FN6F1u6VOyMAVyhuPR7r6
         5gTatpbOq7mVEBPmSWsqIGLgeYludeo7Ei1nrEBgxw0r5Y5d55btZrP0wdFwkssFrHpJ
         UIJw==
X-Forwarded-Encrypted: i=1; AJvYcCU6erORrdRBIpyBX3MMShR4QuNlSdDny/4BBTSZK5qU32vgdMG6/DhnMztC8ge2mYJjo7gif2HBNeSSigw=@vger.kernel.org, AJvYcCUY3oO6GOD2C/a3Z/rWptIaN7OtDOEaEirTtHHiJQNX2arcHxulEh171JolPqnWtoDsE310k2XyvX6mUjkhM/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3XPVpXgeqatT6qv7/tCk5WacwRNIAk9WqfpRdlK/qRok+PtKi
	2yHhFFF/t2U+m16KBUcTnx0r6sdxlK01oer0i5HbffUwBHj4sqJW
X-Google-Smtp-Source: AGHT+IHOgGzfI1HiQLmKBqOxroU62qIlAPOHnOgM05JwEcijw2kM4CY/0ihqvSKXHGGQOQjiXGUDQw==
X-Received: by 2002:ac8:7c46:0:b0:45b:5e8e:3440 with SMTP id d75a77b69052e-4604bc49e94mr182005021cf.60.1728939485656;
        Mon, 14 Oct 2024 13:58:05 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4604278e6ffsm49158091cf.7.2024.10.14.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:58:05 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id CD6D41200043;
	Mon, 14 Oct 2024 16:58:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 16:58:04 -0400
X-ME-Sender: <xms:3IUNZ-MKRvvvaxWrP9wKgQafoEp3dWg1PaSIuJV3ETYoVTzVxmB7mQ>
    <xme:3IUNZ8-w1BV6M6Wnolkzoa2zZt8xizj6OI76bqZoRz_Ui5BXDxiRvTyz5ixOICWAJ
    hZUelh06lpAxpnJIg>
X-ME-Received: <xmr:3IUNZ1SandrE64PeYl4gg90Ow0E_2kYYx-HDBSq0OYwmEqgoR2csXz7byaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudet
    leegjeelvdffteeihfelfeehvdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtghomhdp
    rhgtphhtthhopegviihulhhirghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtgh
    hlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehruhhsthdqfhhorhdqlhhi
    nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhhirghm
    shesrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:3IUNZ-uZFRC9hJJuDmG33tMshDUu6fhVM63nepm6GFmijIJFYRfOaA>
    <xmx:3IUNZ2dvYywIN6Udw2RolyjW0LnuvxaspbHmSobX3Xp5S0V_IK6R9w>
    <xmx:3IUNZy2VR8JifUfHB1ueWqI8BCy8GtdMRgaMta-wJi3xha4DNhUAAw>
    <xmx:3IUNZ6-DmgaWXvhjtP0mylebzuXOMxZPjEe52xGfhVA_c2kxcL-xlw>
    <xmx:3IUNZ18YHtJw5knSxIG6zW4ZlTY0h_P50Qqm55k__6d6Rh6I6DrHgl3l>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 16:58:04 -0400 (EDT)
Date: Mon, 14 Oct 2024 13:58:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Eder Zulian <ezulian@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Subject: Re: [PATCH] rust: Fix build error
Message-ID: <Zw2F27-Crx3G8_fz@Boquns-Mac-mini.local>
References: <20241014195253.1704625-1-ezulian@redhat.com>
 <CANiq72n5cPxDORQad2_fJPHXaE2YDHW3enavjWyz1MZBU3oasQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n5cPxDORQad2_fJPHXaE2YDHW3enavjWyz1MZBU3oasQ@mail.gmail.com>

On Mon, Oct 14, 2024 at 10:38:45PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 14, 2024 at 9:54 PM Eder Zulian <ezulian@redhat.com> wrote:
> >
> > Error observed while building a rt-debug kernel for aarch64.
> 
> Thanks for testing with Rust enabled!
> 
> > Suggested-by: Clark Williams <williams@redhat.com>
> 
> Do you mean `Reported-by`?
> 
> Also, I am not sure which `Fixes:` tag would fit best here, since
> `PREEMPT_RT` has been around for quite a while, but only enabled very
> recently. Thomas: do you have a preference?
> 
> In addition (sorry, it was in my backlog):
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
> 
> Finally, I think we should perhaps put a helper in `spinlock{_,rt}.h`
> that takes the `key` (instead of having this `#ifdef` here) and then
> just use that from the Rust helpers, because we don't want to
> duplicate such logic (conditionals) in helpers. And with the RT init
> open coding that Boqun mentioned, even more. After all, helpers are
> meant to be as straightforward as possible, and if we have this sort
> of thing in helpers, it is harder for everyone to keep them in sync.
> 

Make sense, and we did have something for !PREEMPT_RT spinlock:

	https://lore.kernel.org/rust-for-linux/20230411054543.21278-4-wedsonaf@gmail.com/

and we can do the same thing for PREEMPT_RT:

(untested code)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 61c49b16f69a..6ccdd2231575 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -16,20 +16,34 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 }
 #endif

+static inline void __spin_lock_init_with_key(spinlock_t *lock,
+                                            const char *name,
+                                            struct lock_class_key *key,
+                                            bool percpu)
+{
+       rt_mutex_base_init(&lock->lock);
+       __rt_spin_lock_init(slock, name, key, percpu);
+}
+
+static inline void spin_lock_init_with_key(spinlock_t *lock,
+                                            const char *name,
+                                            struct lock_class_key *key)
+{
+       __spin_lock_init_with_key(lock, name, key, false);
+}
+
 #define spin_lock_init(slock)                                  \
 do {                                                           \
        static struct lock_class_key __key;                     \
                                                                \
-       rt_mutex_base_init(&(slock)->lock);                     \
-       __rt_spin_lock_init(slock, #slock, &__key, false);      \
+       spin_lock_init_with_key(slock, #slock, &__key);         \
 } while (0)

 #define local_spin_lock_init(slock)                            \
 do {                                                           \
        static struct lock_class_key __key;                     \
                                                                \
-       rt_mutex_base_init(&(slock)->lock);                     \
-       __rt_spin_lock_init(slock, #slock, &__key, true);       \
+       __spin_lock_init_with_key(slock, #slock, &__key, true); \
 } while (0)

 extern void rt_spin_lock(spinlock_t *lock);

> In other words, I see helpers as following the same "avoid `#ifdef`s"
> rule that we prefer in C source files vs. headers.
> 
> What do you think, Thomas?
> 

Thanks for copying Thomas, my reply to Eder is here:

	https://lore.kernel.org/rust-for-linux/Zw1_rXUyjTBOh0QH@boqun-archlinux/

Regards,
Boqun

> >
> 
> Spurious newline.
> 
> Cheers,
> Miguel

