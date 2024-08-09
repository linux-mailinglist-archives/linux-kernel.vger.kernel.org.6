Return-Path: <linux-kernel+bounces-281594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7FC94D89C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0BEB21482
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE0A16B395;
	Fri,  9 Aug 2024 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKeK/8WR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055C146D68;
	Fri,  9 Aug 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241186; cv=none; b=mT78t5HYdtpQgVuXp1sJpFOJIQcOCuXAnYBPma4fcpIxPzBmpw5B3a6pjN5doZxt5sA7mAxw3F/b4MN6pKR/jonwSrs8BF5UZ/YD7KdUYFhpmA/GEKeQhesUiGzZedj/hyI/EkxUbwhWndfGnIfeAOPS02zD3HMxkf6hpjgPnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241186; c=relaxed/simple;
	bh=74p4vxrrXFBm02Owa6pNXCYlL6JqV0hoL7EComjV118=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTxZa+EQ4KhwhBTwpgUAIKaQZV8tlgkEZ1xRDcfMvw3ZMF+5Mai0Y+eEvatkQ5C1Dl57rGRKlyffPk4wgyXbasZXW7pJFSf5yPIpmH385jf9Icao9rLSnCNbbl0F7H8N+KRAwuXXkXenMW8cHvlj+/Fs3qg0FjZhl7rMdx0n4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKeK/8WR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-200aa78d35aso8916605ad.3;
        Fri, 09 Aug 2024 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723241184; x=1723845984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74p4vxrrXFBm02Owa6pNXCYlL6JqV0hoL7EComjV118=;
        b=mKeK/8WRRCLFCXlYyO30QHHdtVELhwvQy9y4jMnKgi4ZZqNI4MNSYz+yRYHCjUoG/L
         cKMoX08VRfXktsN1NxTFw1RdX6pGnBIVTpTRCQYL/XTS5LRymqQf/Aqhi5Hy+cwdkOqS
         hc78X3X9knAu2OBr6YN8wSFrBHOQ3vIkLFDIRoDrjd4Sgbx85VI4ChvqxR0o1+B+oJxc
         aEl5owLcAX960Eij/jz7Eq/jN1Gfa9Yb9zV/SpLeQeV6WOHMldGRULAsB8F1z4Vv99YX
         sorwORdoiCJSNsCnKqTIArS5rtQFYMseCUT40/Oz+jgTzad1xSSP5SfbvQ78FkJ0MpZi
         goiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241184; x=1723845984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74p4vxrrXFBm02Owa6pNXCYlL6JqV0hoL7EComjV118=;
        b=aSoh0reSuW0yJvH9dHz8okTLo84VJx2AUTN+GZeXr83ITBcLD7lsQmy0rkZyTGHzCy
         Mox3P1dPdrkC1LECn/gFR2oqdUrAuHdrdaq6Hir38MczDeKW5NZ5GjmHdzo4L39GPfL+
         l07DyvFC6vkCYS5wv457llF/3MjGO5ulqiGGND1HbdiJWqH41fKex9Qnc7Roh++1ChkL
         gsfqhRDrnTKfMmlQ0EX9JGoPl72+YUuvXZQlaO/vCpATSzoeGv16QN1IKe7uc6KDyf9L
         kqcMGFT0qfDgLNz6+w2r04M49fk4h6c8e/7l5cuy05jwFbO7HxwT4FpLLXcz1+pnxmdx
         s88w==
X-Forwarded-Encrypted: i=1; AJvYcCXuLXPmwUwFdXhkcK5xmjH//ItD+/A7DNpcrvhhBUZLgHYgk5NakkpstOvhYabQwh+T0H8vRN2hAng6LTyKlXBUpIVZg/gLPuq7J4UzwAf01uvaiapAp3XZifIQXqX+5xe3wMouS9kf4ps5WJ8=
X-Gm-Message-State: AOJu0YzQ74BFLcxjoRUKCceNzYJItfMIttIlqEsP9F54aaPVA39t8YuX
	vPwTe9ihpcGXzMB9p1UWVwL9U91DNrV7v6cW7RQSRu+CHIXM6MrNq4cUYEXBYyafh8pqt0Eduyq
	EH6gUP5nvoEz9XZnTa6Nz9tq2Fms=
X-Google-Smtp-Source: AGHT+IHZedMZ99QDiRcOavRwSEGxmOLmUe/8l/c44XSDGNl309S8j7l5pc9icDrgRpQs1L52jNLWooHbKNbCsyRI4+0=
X-Received: by 2002:a17:902:d550:b0:1fd:8f14:a109 with SMTP id
 d9443c01a7336-200ae5a7a96mr37619085ad.32.1723241184382; Fri, 09 Aug 2024
 15:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134346.10630-1-zehuixu@whu.edu.cn> <3695674.9o76ZdvQCi@skuld-framework>
 <CAEg-Je9gyR2xKF8Ky8eWTR=6odZbgCRCM6DhYPVTAJTDPDxakg@mail.gmail.com>
In-Reply-To: <CAEg-Je9gyR2xKF8Ky8eWTR=6odZbgCRCM6DhYPVTAJTDPDxakg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Aug 2024 00:06:12 +0200
Message-ID: <CANiq72kG9HxZYOa+DT3ibjr0QHU3u5RGtp_m8YVouTMz=opiUQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Neal Gompa <neal@gompa.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	Zehui Xu <zehuixu@whu.edu.cn>, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:38=E2=80=AFAM Neal Gompa <neal@gompa.dev> wrote:
>
> To add, can we get this in as a fix for Linux 6.11? I can't build
> Fedora kernels with Rust stuff enabled without it since GCC 14 is
> shipped in Fedora Linux 40+.

Yeah, that is the plan -- I am picking another batch now.

Cheers,
Miguel

