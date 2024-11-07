Return-Path: <linux-kernel+bounces-400287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B79C0B72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834661F241C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC9215C75;
	Thu,  7 Nov 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4hFP3pm"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7221217B;
	Thu,  7 Nov 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996300; cv=none; b=USmnVdbMgNmadKD6YCpe3G3VV2gYn9StvOliUo3yi9uGd0rQscWodWLKbcWnEa2hU/vI7m3jOFUHEbo0tuRkUW3LeS0GElqhJtsaXYhqq80gnR3e0EDZtHGG55IsGnmgMPRCsDgSsYNtkw/Xvffsl8hzlRAjgBFegDQwSi4dzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996300; c=relaxed/simple;
	bh=A2nMQyJoMt6BAljCrcBq7DiDey2ikvTaqDoVHrO86MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdL6G8y6QYNqkSy6sIbr79iPh1A5k5i/Ai7AHu4Q3tRil5Dp+j03NTKEjoW9ZyfVms4f0fqNfvZ83BgXKMrXsCgmhZcaHmjhglo8r6UEjVbWlDUrr/55z29rIjh0cFqhqieMOV1iXp+0uhxzDaZrDoqZZABBdyspx07MWThmoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4hFP3pm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d382664fadso6723516d6.2;
        Thu, 07 Nov 2024 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730996298; x=1731601098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ek2Pr8aC1LxJ28dsLHeiGtZcdlMJfDyuW9uAHn9N+A=;
        b=B4hFP3pmTWAkP5ux0z5GGlxSc40hjlaSYNy1Pp2XNuxKhFn99PEWFq4zcDyUucTyDP
         GAFidG5h+OU6R31hSlbSSbGZWsj+En32YNfQ4tM0zM/ljRiE+EnTh0afcNWRUaUwzIle
         cLKAUtGSSVzBDrcsBI4RQV253c4Xy12+5yW+MeTeFSLUpCsn6GMRMF0FmVasGShDQ8Ui
         6n7OQjNIx4/P8Li15ndYsLlWEkiA8doX+QvRSmITL8hHUK+0HctcEOOp/Oj0oMAdFV2i
         l7I+lSfxN2S0lloTSV/k1oCU7WoiO2SPWethb8D8qDX/crQ3PgWCOdLXABjEBkm0ATQ+
         mpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996298; x=1731601098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ek2Pr8aC1LxJ28dsLHeiGtZcdlMJfDyuW9uAHn9N+A=;
        b=YysGpfyEygnevX1Fhwll9HUe44cfpTF8svU5XEgC8fwoDhU5MW0yJDxwmq1/IujeFT
         BnXx2SFpTlW0zU8S1sqL6jkLBqj15Uyjmz50KyptZdsjy/UQNn/4oDkbNgGeSnRllzsF
         e7uNk0w0J7mXvie7yDAjA9WXQZLJybKUe+dZVe++ATtW6X15g/9SLBG2W6WkGPLI4RnB
         IeV/IOgFri11QSonXwmQyJyK+kMwMeFDn78Q+6x2TgSPWoLVdHwvAsAvt/cnoB+QlO7q
         gR9i4rL4UqRz0wSr/xYcP1Poih/WBgcuftzdfPBR/zZNr3u698pGWjiSg2yFV29B1EPR
         aQLw==
X-Forwarded-Encrypted: i=1; AJvYcCWlUPTculfO4OFs/wM3q/ZmfFuNdjgk517EOSdH0zGXWv0MldNFl4hknKG2u/P5+piJJ892BWhIFMuD/jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62lVlH+NEckZOVaADEWitfIf3jhwYX1jOp9DgEy0E1Bj7de4S
	0M51pHbBfWOjbYR7AX49E9C0NPbcvpWwrCWYSWYu0za7SeECsCeZRBoY/A==
X-Google-Smtp-Source: AGHT+IEXFFQsIp3iT1zsWEbcwE/s/lvUyCnHxT2DaOGBExHe0673Ml80H6X/0gvJxQB79Kiw3yZSFw==
X-Received: by 2002:a05:6214:3d9c:b0:6d1:992e:4c5a with SMTP id 6a1803df08f44-6d39d054bf7mr7233356d6.45.1730996298187;
        Thu, 07 Nov 2024 08:18:18 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961e07ffsm9090136d6.7.2024.11.07.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:18:17 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B20F1200066;
	Thu,  7 Nov 2024 11:18:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 07 Nov 2024 11:18:17 -0500
X-ME-Sender: <xms:SegsZ2hwpQp0iy0T3asPqS8kYMIO0yZPgazT8YRBTZnh5gjC_gx8ww>
    <xme:SegsZ3BoREMaArUShRdCeziybwBq6moU-gU3KUXTbhs-_D9X6s-LcAnq6sL1bbbWX
    wnYJp95g-87J54zEQ>
X-ME-Received: <xmr:SegsZ-FvlXjA96EdGagbdrF9ZPXpezWHSuB5rdD0r96kUe0t0AaNyfJ1p00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieev
    tdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvgiiuhhlihgrnhesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhm
    rghilhdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprh
    gtphhtthhopeifihhllhhirghmshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:SegsZ_Q0dCAjXmN73H4igej1_DTqr-iqbK1YDYi-Vy8Xnp4LqqRSdg>
    <xmx:SegsZzyIQd55nEqssMXzZoD_XwLroxk6Vs_qtIrABuRufNOl2nbmcA>
    <xmx:SegsZ96Fg6JBdfyPHpam5J3ULdE4Fo7Sxy0olRkT84dVPuHRguzNqg>
    <xmx:SegsZwwFi7uttvqBvRO2EyIXO1PatSFNwLmmjdrGqFXsgy3UFsEEQg>
    <xmx:SegsZ_i6etjr6PFG_Bxny2FuSArPSK7K04YZ0BqZcInr9zpHpalztyJR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 11:18:16 -0500 (EST)
Date: Thu, 7 Nov 2024 08:18:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Eder Zulian <ezulian@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, tglx@linutronix.de,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jlelli@redhat.com
Subject: Re: [PATCH v2] rust: Fix build error
Message-ID: <ZyzoR4JLPOm9Pi_z@Boquns-Mac-mini.local>
References: <20241106211215.2005909-1-ezulian@redhat.com>
 <Zyv6unk_tRyv_v7m@boqun-archlinux>
 <ZyxpA2ez-9E4c7G5@f39>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyxpA2ez-9E4c7G5@f39>

On Thu, Nov 07, 2024 at 08:15:15AM +0100, Eder Zulian wrote:
[...]
> > > Fixes: 876346536c1b ("rust: kbuild: split up helpers.c")
> > 
> > I'm not sure this is the correct "Fixes" tag, that commit is a code
> > move, so it's unlikely introducing issue itself. Moreover, we really
> > need PREEMPT_RT being able to trigger the issue, so I think the correct
> 
> One may argue that we need 'RUST=y' in order to trigger the issue.
> 

But RUST support was in mainline earlier than PREEMPT_RT enablement
(again I know we have RT code quite earlier than Rust support, but we
are talking about mainline and potential stable backporting here), so
when the lock support in Rust was added, although the code was missing
RT support, but it's fine from a mainline PoV, and when we really
enabled PREEMPT_RT, we should have added the missing piece.

In other words, would we want to backport this fix into an early version
(say 6.6 stable) where RT has not been enabled? Would there be users who
want to use RT and Rust in that version?

Regards,
Boqun

> > "Fixes" tag is:
> > 
> > Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> > 
> > (yes, I know PREEMPT_RT is a long existing project, but it was until
> > that commit, you can build a kernel with PREEMPT_RT=y IIUC)
> > 
> > This will help stable maintainers for backport decisions.
> > 
> 
> Perhaps omitting the 'Fixes:' tag would be a solution. Is that an option?
> 
> > 
> > The rest of patch looks good to me (we could maybe provide a
> > __spin_lock_init() for !RT build as well, but that's more of a
> > cleanup)
> > 
> > Regards,
> > Boqun
> > 
> 
> Thanks,
> Eder
> 
[...]

