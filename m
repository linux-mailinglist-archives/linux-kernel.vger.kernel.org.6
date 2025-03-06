Return-Path: <linux-kernel+bounces-549065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED6A54CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABE13A1C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5FF140E3C;
	Thu,  6 Mar 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7GV0v8E"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842F13957E;
	Thu,  6 Mar 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269552; cv=none; b=S1gWhl4XezAtXWcVI7Iy1rnIRQdkS+JImHms+upCWeXpaj4PsMzMBnjbadKbRM1Jp8Kxso1cKect5lN4oVPX9yXl9pednV/MzgdpCsG4ZwsQhTAcXjPoq1hgB8weT4qTgUW5dtbd4SiSJATdozdGm2qI4uIEbmCIGCkM/SxU4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269552; c=relaxed/simple;
	bh=NHFHKcBCqCK4qcajhpvf0jJBvCiFy0OncGFGjA8Vo4Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Aez/YBHc9OgKf9fqSZieRl0e8uYWOA5SOBbn2+rNRR6oFIlqhXS0hx3Knmg63Os/UTa5iiIkIjKM/JOE0cK2pFe82odzTz9Va5aXCIk3epq5I08PQGITEYWuomhr/a/zm1WtRRGNkP8GRTM9y9jnOgEIlJawkeEICahmIB8B1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7GV0v8E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224100e9a5cso11445625ad.2;
        Thu, 06 Mar 2025 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741269551; x=1741874351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcMj47LDDJL0C0ekfxA2WdyVcUGhX6i6MQXT5ot4g4M=;
        b=V7GV0v8ElKtmDCHBleHfTTPXQcNfoIrGltBxFLC+ODIpQej52h26WjJ/fdFj0jL9W1
         y6V9/q/c3jI/QHqfKCSQJlQtUhetfVdVFtzOi9UYfAwvdm75OEzx6em8cvvWKpS/ogRS
         JwouIJr9oDCQbGrGinF7kSYooSdsNwRamH4HJQ97gH4B79H+1uLY6PQTc2GM1bVPI1J1
         XfAXM/4Sf6rF5NTY314y/1EKh5deupcsc6PgVr6liLC+ihsykukRyjVGXNGEL7muCgsT
         piqqiVxzuiPqlqM96doJglO5Hbl/tQlB2HH5CZZ7WTPQwn/HXLWP8IEUazMXrD3XK0nH
         nCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269551; x=1741874351;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gcMj47LDDJL0C0ekfxA2WdyVcUGhX6i6MQXT5ot4g4M=;
        b=A12TZlQo6ny5Sjz6XwpuEKRH1TC5yq2ASJ3CICmwGeh5haSSiRAxockD50S/M2JJkl
         zLjHYliqrSTGbrrNM3ELyrBCVPSX+tXH9WmyvHm97YKzQqYeeZxLHqekH1+0KlkZL5Y3
         gHjHo1aEiFsciTg2MZn5debfj04qGVixfOpvfOvy4Ca1r5EoRXHFsVibbJ4FpbTm3P5O
         iOHGTIIPywiHTAm3SSFRcbuKtyZZgsCN7OdnmVqU9Y01D1eTDjqj/9xW9MdO1ZNhz001
         Z4vOX20XVroobWbCplST24AgYwXutJxy3SnetXHMzY/JZEOv+ViRtluP//gwS4D+Banp
         BMUA==
X-Forwarded-Encrypted: i=1; AJvYcCUdVhZGdsAKwFzRc+Z83aXS0ukZVAy7Y6Sr5zPgv1rmKOBZJhoe+DiY+hwOvFKrZbsmkZV5+NJjZHE=@vger.kernel.org, AJvYcCVpmjbksJhUfvCpqn5iAPNOqG2ewnq9vMbe88HLV8oV0G/SBDx71hxWgZAvLiV/ox7LDDXcVMks3+YuIhoB06g=@vger.kernel.org, AJvYcCWOK66kV5YygMJEq5kwDGzn26YUw7os5PJogyXjGFKGuwdRew0aZ9o5Qm0Rcz89+diCLuaovIPHn6xgpgFF@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXNRtp4fo87HeHulGPLVfnDDbIt3ds1yI9+m96igG0cfi2NEB
	3y1zQQj8N21oAMS3Svp1YFzmLKkTs5LWngY37N1zvP5uqaJRSzFw
X-Gm-Gg: ASbGncsnjr6YxvHuIRG3wyL7D0Zekmh8+vRFxUcrMRhNmpkiqg5XdunTBpyKoGlIcOD
	uiLA1rMs4MKxKjyNR7LrClpixzXWka/VwOUD01a8//oDzeyBQ5sp64VM+ruIxSJsb3J8svd00yO
	AF6yGczqRiucdSN1UvKjfHF9XaxBpAnSJp0UhyBZZSxfShL5oXYFGUqyT52F77z80Vud2C2Cll0
	aiGyn/Dn+4RNyb+dVv09wiqxAM3AnSljmU9+jhPAesAQi2FqpL3Ecuc826SUdHe2Q/HO+98ffvx
	JDN/IdY2UuyfZszStHqN4XooxRHdRSoEe/UPB4VEvsMeZZa8HGMWxQxyhFAP52fXGHjIITkFuxm
	/Xq6a2BbVXuI3GdtZ9Of+RgPNmos=
X-Google-Smtp-Source: AGHT+IFqC7dar9vSI6YGsXxKnsXEPE0Q3GPt4+bYPBgIONPD8wz2KSMdMkJPHp0sptOtsCw8Cul/TQ==
X-Received: by 2002:a05:6a20:4305:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1f34944ed8bmr12193897637.8.1741269550654;
        Thu, 06 Mar 2025 05:59:10 -0800 (PST)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28bbf3ab0sm76581a12.9.2025.03.06.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:59:10 -0800 (PST)
Date: Thu, 06 Mar 2025 22:59:02 +0900 (JST)
Message-Id: <20250306.225902.541492197262171384.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: fujita.tomonori@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
 pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add initial documentation
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z8mm4fJQxXMiN5tu@cassiopeiae>
References: <20250304173555.2496-6-dakr@kernel.org>
	<20250306.215638.838863448505767234.fujita.tomonori@gmail.com>
	<Z8mm4fJQxXMiN5tu@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 14:45:05 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> On Thu, Mar 06, 2025 at 09:56:38PM +0900, FUJITA Tomonori wrote:
>> On Tue,  4 Mar 2025 18:34:52 +0100
>> Danilo Krummrich <dakr@kernel.org> wrote:
>> 
>> > +Delay / Sleep abstractions
>> > +--------------------------
>> > +
>> > +Rust abstractions for the kernel's delay() and sleep() functions.
>> > +
>> > +There is some ongoing work from FUJITA Tomonori [1], which has not seen any updates
>> > +since Oct. 24.
>> > +
>> > +| Complexity: Beginner
>> > +| Link: https://lore.kernel.org/netdev/20241001112512.4861-2-fujita.tomonori@gmail.com/ [1]
>> 
>> I posted v11 last month.
>> 
>> https://lore.kernel.org/netdev/20250220070611.214262-1-fujita.tomonori@gmail.com/
> 
> Thanks for letting me know.
> 
> I think I lost track of this because in v1 the series was named "add delay
> abstraction (sleep functions)" and with v2 it was switched to "rust: Add IO
> polling" and I was searching for subsequent patch series with the "delay"
> keyword.

I see.

During the review process, I changed the subject due to the consensus
that, in most cases, device drivers should use read_poll_timeout
instead of calling the sleep function directly.

> Anyways, AFAICS you ended up with adding fsleep(). I think nova-core will need
> control over having a busy loop or actually re-schedule.

I plan to add read_poll_timeout_atomic() with delay functions:

https://lore.kernel.org/netdev/20250228.080550.354359820929821928.fujita.tomonori@gmail.com/

delay functions need Delta struct in the patchset so the patchset
needs to be merged first.

