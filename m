Return-Path: <linux-kernel+bounces-541402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2558BA4BC95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D603AA784
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628451F1506;
	Mon,  3 Mar 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GYslWog6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66561F3B9C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998436; cv=none; b=MJq4nksj4nf7ryN+leT6BzTAkT9i61jL633iPzmvlZGUzXVJvyuD0Lbu3fAjy/XyXkVhlkH6wfy5/zwzPmkcAXqSCCB2LcJvI8qBUnFbQv0mE0pS9W1cr3+jU5XHsvZNoTEtZj4pWVJTFh/mVRRoGy4B+NMv66+faX7TSmjv0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998436; c=relaxed/simple;
	bh=zYzeZ6zTKrsdjyQMrhBRuUHzx5EImxcJueoGYS/gfNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHHt9bKpIiRiJSladIh6x2jT3HM/5dmX3ECxnC0vruAnsq9tyId8aBSKePrv/LD8jI3n3XkCy6pzKEMHTJS3Wh3XdoBs3xKnULfjiHz75x1uBognRv/Cqk6A/D9n5DILCOI4VP5mfQDx4cs3O69STqfeFgBRqlgAwd0LWsyA19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GYslWog6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf42913e95so358323766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740998433; x=1741603233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5a9h6+RNdDno0AFoqzH4L74Ntb9x5So7/S1R2/2cyIA=;
        b=GYslWog63dqMweEDm27I28sHouJUBHzjwq52qXZH1odMB2UimNOkTpsYfnwW116Pe5
         sILzOQDXALHGyIzF0xK52YOezZuDVOLBP37a7CNn2GLW9N33G8Rd1zhlzKdw0bd49et5
         E+tEMV98K8FiqYL/FamqYqN2RFvuDL3lIFaSP28+JexmH8mL+mgwQKPx7mpu0kyr8z/U
         LBUH6jKhImCIfa/wcA2ri3DLWdax8OmIUQfuPKxvgY3eHAsrTJD60B1hpMXw1smRCRj1
         WrAyTny9iMlm4WwIsEkPP/ZqWDqxo8x+cupGZkOgJgPbCIO9/8SK/czyAGBODfIniwd8
         z6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998433; x=1741603233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a9h6+RNdDno0AFoqzH4L74Ntb9x5So7/S1R2/2cyIA=;
        b=klijHMjMohHQJgxxLV03lTK5ezSwygjiA894YT63wD4lKNlYI9g1/qzA7J9nD9bHkk
         wYYnAHn9xmrUDSJN42qp2sOiypBh+9CRjmkSCuDj+R8r3xgg0Y33tG32Ar4xhUSLCxfY
         txvuP2zjeCdoXGsnOGOQ0au2bC+TwFBStv4wyEL/x6ASrhAArl/AtnMboq1H8O0jGBti
         vEH5Dp8BBJoO55pgxuebxpyzhnB5SCryBsr4drqBwkRhAFW5T7xQX34+Wu5SbHmbgHBV
         pNCQAXCqtx6tZyEIYF9i8A6etyaZZkRt4fNwjEoDLbRSxSeyxL7S5U2XvVsbtXBlFzqE
         fmKA==
X-Forwarded-Encrypted: i=1; AJvYcCWncs4gVOGNWtemlsRHSkrO3Jp5rCYIQ6k+dA+eWMJs54Nefq/Yy3mFU0ops1PuUsLCV30AEyCjmXO48RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExwrSVAjPA8bSX7kyNnnT2GcIVFpMGXxlqboQVsltasW2watG
	r/EOVPV/+0jR9UybmOx9NvWQfHlRIgodDx0MgZz7cnv4j01I/qPYILzXctBttiM=
X-Gm-Gg: ASbGncuQdCra8BncqerUoapDFGgP1MDE1VyF4lu1NjnOUISVuvy6aYpU6eSahexd56r
	/FQrUonH0DR6vWP2MFASisfip+ebGPQB10EqsBYgYbaMFc+8NkB1SujDXCwjLoyxFFpMoP8zcjT
	MpruZ6fEWMDq/XB5B1UnTGzY7aUWpyLKqqXf35s7Vk0EUf+B6wIqoDEKanNFH5OVOHDy0nQwNPl
	XlMgppaLmdPGsQJLqNs2IM7yuxWUriVgvl6Owusm6B7Jn3Z6f+Joiz2186vG0kC545HREv26tR2
	+NEz1zeXPNuac65rIO5NJ7/pY0xA/lUngoMIOfuK32T/XkE=
X-Google-Smtp-Source: AGHT+IFdxe1UliGedp4UVoTzjvVx7nmKJ02BWHR9cvVprp2v8Ja1Mccur8mOERuQ9+frcz5n+hpjGg==
X-Received: by 2002:a17:907:3ea9:b0:ab7:bac4:b321 with SMTP id a640c23a62f3a-abf2656bcefmr1434681866b.29.1740998433246;
        Mon, 03 Mar 2025 02:40:33 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf75481eb4sm207346566b.83.2025.03.03.02.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:40:32 -0800 (PST)
Date: Mon, 3 Mar 2025 11:40:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 4/5] print: use new #[export] macro for
 rust_fmt_argument
Message-ID: <Z8WHHs8eGcV2mCAw@pathway.suse.cz>
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
 <20250303-export-macro-v3-4-41fbad85a27f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-export-macro-v3-4-41fbad85a27f@google.com>

On Mon 2025-03-03 08:45:15, Alice Ryhl wrote:
> This moves the rust_fmt_argument function over to use the new #[export]
> macro, which will verify at compile-time that the function signature
> matches what is in the header file.
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

