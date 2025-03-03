Return-Path: <linux-kernel+bounces-542121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB2A4C5DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592CC16A171
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D632144A7;
	Mon,  3 Mar 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hZ09LH30"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A286ADD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017468; cv=none; b=VJWWZh62yE1tZoBYZAJK8mPtAvrtRPVg6Q6U74WLTOofBcqtz4fsLXDUjHULXXe3Bm3B3TNT4TpKFyVS+dfOzr7+uYxVgGwc9akHXkpSRw3bgSVxqk8fkOgx7RPNkzKqdfa7kpt/UItFQTPGBiASEog2AlyiHlbCdnu2rPfXLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017468; c=relaxed/simple;
	bh=BaCYaLkFfhF0aJ9owPFoGunK7n7mUSsdKzAWLXEjmgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJG6WctrN/XeVr6+IMh3IRWmJlWL8pWBFRjyeI9iMDiSiar8P10pI9kpSkJ2awGAUv2kbJD0fpGv9QKo4+mp/i/JMkR4fS7kgrfyC9NnKwUmWD9Db5D3yCsL3aKWTVcripaaD8yfbfaR1tqZfnN7nuk+ebrMpsy+AeeuyGQuirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hZ09LH30; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd420f82e2so65388316d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741017465; x=1741622265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YinX87LDYMtoABV6o6KK1J0RlnIm0/nmsIr9899AJhw=;
        b=hZ09LH30nn7Ipp6igcagUy8vTf+KZxbT6kwnZjsSjWav33XOUaK6VE/YQWCzboAwb3
         LmOV3rejygiZaAQB+95wY9YE0dokIgsUTzcPnrrpN3brrpTH9d8BLmdfICk4OJgNHlA3
         aSPxWGwjkwXGpn42XR7HDjKflWW4UdvVFP+CyCv4/nkmCqqqYNHSPZcH3P/q1R500KtM
         40BCLEauyhCYMmBDjYg3lp5hGAHLNQdkV2Y43hBdvZ96Bv/UOchvFMD0HJ4aR1GXT0l5
         2nWwvWULu1RYYduKpmm9alY3del5IWGcJgvjnb0FIS9VuqtPO6IrAHmFAcwbwJYNjjZL
         UMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017465; x=1741622265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YinX87LDYMtoABV6o6KK1J0RlnIm0/nmsIr9899AJhw=;
        b=YsvfnPZe72bjR5y4/LT4nLcaUff/GC6/lCFfzjTeXgKAUgHuGOs4BvNjAd+MdvB8eZ
         TKH+sGM8dI1eW1S7qFPwJZ0l89wtqy8QzSfxlaTlFUx6bUGsJKoky8UKIlFFpKA9Ts7s
         u1uOUHhS2ySFoJ8bYrBC5TTnR0A8X4a7owRAervuwyAHgUHhK92wXDWD+WMaPx68yAwK
         dX1UdHn8sdTDFBGgPF117vguSJhxIKzuTCpT8EXdKGo1/fwRr45hP+eT6Ive9HmSW/39
         3ZksTU5jUb7gIYiddvkVaBNiJAp3Oktk27IVbMsyZKz8AIWoPM/X7n7OuVa9tv0+Xoi0
         4FXg==
X-Forwarded-Encrypted: i=1; AJvYcCVBw769aGNOejHzLej3K+FCgwjnLauBHTpc62cf2nUNMvTLnT8JuuuWtmYLWFhYP9jjuRnGAx9TZW9Ys5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgc5Nbo8h5Mw3KslTyXarD9cdhcp95I3RwqOPBwwJtabroTpmm
	pjGLYV4DjHqvKJTfC1qJ8EWUk5y1gWkUCw3DaZR/XkA8M+NgL3f7cBRQcU1VTTA=
X-Gm-Gg: ASbGncv8jaI84Ub8OBqii+WkRKCtpmzoXzr/oIdoLykOp/7oAAKNU+g0UZpbJBcY7G1
	k1JRqNoj7rkbEtmwlREQ5U04aUjVu0MYcvNh1mri3sKO3AO4JGHRFvegtt3yZ8kLp9tnNqfdFNo
	zhNBQK8UBajUaRCEKb/602VWLMYvTD9myJgwg/p4uxyx1xQ2hwXS8ospq4u4RFYfzsavC19CNC+
	4Y4z3VYhLp7sl9Cf2OZ2gYUVKI9zJ0DU5SQ/2V2uGdCOnJ38QeN1i+GTWiPn2hp4eRZNyh1mA7e
	/bdkhHDfSMcvPgkKOFBoGkGL//xib7Qo/8tfMiD6GFvXjXKUWTgxJe1sxizdMTtcRdkjgPg13ig
	Ol46SuyV6kVx65e23OsE0pRggWNs=
X-Google-Smtp-Source: AGHT+IE+DJuOheMVcKCaoN4GZgzluwLtYEbwq0IullHqskTTy+jfFv5btA6pSQY/LiiUMonaE7lbrg==
X-Received: by 2002:a05:6214:2aad:b0:6e6:6225:a907 with SMTP id 6a1803df08f44-6e8a0d3bae8mr227548976d6.31.1741017464767;
        Mon, 03 Mar 2025 07:57:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9f917sm612248385a.78.2025.03.03.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:57:44 -0800 (PST)
Date: Mon, 3 Mar 2025 10:57:42 -0500
From: Gregory Price <gourry@gourry.net>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
	peterz@infradead.org, keescook@chromium.org,
	gregory.price@memverge.com, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: Extend syscall_user_dispatch test to
 check allowed range
Message-ID: <Z8XRdougwM_Wx76A@gourry-fedora-PF4VCD3F>
References: <cover.1739894594.git.dvyukov@google.com>
 <5e105b1382cd43d05f1d3a80958e4f50f32144c8.1739894594.git.dvyukov@google.com>
 <Z7dHid-IL7OAPmUa@gourry-fedora-PF4VCD3F>
 <CACT4Y+btS62MDJLRToydRfK-QAMBiihv9d7Du=zEf5U_GbiOMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+btS62MDJLRToydRfK-QAMBiihv9d7Du=zEf5U_GbiOMg@mail.gmail.com>

On Mon, Feb 24, 2025 at 09:48:19AM +0100, Dmitry Vyukov wrote:
> On Thu, 20 Feb 2025 at 16:17, Gregory Price <gourry@gourry.net> wrote:
> >
> > On Tue, Feb 18, 2025 at 05:04:36PM +0100, Dmitry Vyukov wrote:
> > > diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> > > index b0969925ec64c..fa40e46e6d3e9 100644
> > > --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> > > +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> > ... snip ...
> > > @@ -110,31 +111,15 @@ TEST(bad_prctl_param)
> > >       /* PR_SYS_DISPATCH_ON */
> > >       op = PR_SYS_DISPATCH_ON;
> > >
> > > -     /* Dispatcher region is bad (offset > 0 && len == 0) */
> > > -     EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
> > > -     EXPECT_EQ(EINVAL, errno);
> > > -     EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
> > > -     EXPECT_EQ(EINVAL, errno);
> > > +     /* All ranges are allowed */
> > > +     EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
> > > +     EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
> >
> > A 0 length is ambiguous and nonsensical in every other context, not sure
> > why you'd allow it here.
> 
> Yes, but it's also not special in any way. One asks for a range of N
> bytes, one gets a range of N bytes.

It's specialy in the sense that it's nonsensical :]

I don't know what the prevaling opinion here is, but it seems pretty
obvious that a 0-length is almost certainly a mistake and reasonbly
should result in an EINVAL.

I don't feel strongly about this though.

~Gregory

