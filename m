Return-Path: <linux-kernel+bounces-519906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4EA3A365
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A172B1893A22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1D26F46B;
	Tue, 18 Feb 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TY0hx9Kb"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70D26E177
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897935; cv=none; b=eOQtB1zLYCUQIU7hEVPuDEBZdsAHzC57NDcpt5Rn+o+M47FTmIgFoYB2F9Iz9UF3uqKhCyjsZDU54MeJk4xspfak1r0XOJFLyp7KKxT5yUcYWhax9tsSEh05fo/YuiPEI6zuTn45mOzV90r11YQ+7+JJ8eD/WL2HIC+Fh+bP6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897935; c=relaxed/simple;
	bh=BMZY1iGkOcpWnMwum+lF2s3plu5xKA2Zvd2spNjY7uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbB9eC1M6s8Rpk/FVwu0GeWDh70Y88afPRWsF6Q3rZd0UQN2zqax+50T77BBDP+X4gbxOHq++PtB3MlbsS7wGADVXON+s6Zn29BGUzuTOq2+/5NEEZwUplH+XA3N3rRGtr9NQXx4JMANotcV1iHLts1aEdPbjyBwYOfCdoJn0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TY0hx9Kb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c08fc20194so495698085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739897931; x=1740502731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nG7ps9pZjk+cRNHuDiESfiMPlAFCR7OyfOCSsFqItQ=;
        b=TY0hx9Kb3sqNo43no2MoiEnSXezheVPlGUP2r6DINUpOQIDmB9CgKE9vYsszDTHrY+
         GWqkDPxxo08c62yamRAOzymJG3lbGDvTIJOz6o7SINEpj75n8YPgKr8AgZo7a13pxnr9
         gnb6UQ5OLsRa3kN70BO30Vq9ofqnh2L0ZLYviDwbq5qw79naYBY5Ejb5RSLYej4385CH
         DSlhqDkVHvpCxZbL5BicYo3Be06Nm0kQzvCmwcQUCDS/3KAqU0kDryX38NhxO9VbReSL
         uhtrP2EN1YgkKhfRxOxZKDdhf3WkFwdRqhBBD6CIevx1H8cvb8MDFY76wYc73bsgmUDU
         qwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897931; x=1740502731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nG7ps9pZjk+cRNHuDiESfiMPlAFCR7OyfOCSsFqItQ=;
        b=RLjN4tbncIzhodBQQORW4Fm9qSfYelfpDlwrJr+Bt1S2eFXxEzrv/cqbP7b4VP8Epa
         bKe/BTbfRe97YTGK5KXHcU64MWt97GI1aP1jgevAfBornLkahZ0qhUF+Gp+zk1xO3UOg
         8NkU3TT7Agv3Qb5AsW4IJGqJ9CSz4UpVbOUycYbCIdewaOIFQb8JJOUzkNkcNoyxTzqG
         MjZ/9ucHjgAcHGZQRS+7Xd5F8ODa2T7v9U6giKEpx0gNdVVVra11MgfP1q8sPSUeaq0i
         X9cpx1fWhbc0QM97pRqcDFmBZ3dmk6R9IYIfMgPfYRfaZjZdAlu4KJbEFnOoxvuczxJZ
         g2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXiKcngYirEoXCuRGeGL++ZAlz98WBOy4OJ2vozut2SrBwzcJxUeHrBvzle8BytbK/TivkZhp56vAcUOzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD3btI57eaGYceOgKwelXQ442bcenza6JyT024qDg0kU2Q7Bfq
	JdspRWKf3JZhBF5MrzS2WzYrNCFB/y6ZJslfdeaI4C6rEraKCdaONvrWDAKMG10=
X-Gm-Gg: ASbGnct5jpfpVbvqyjHjmt8muPYC3rz6q4EMQEPSMRYmmC8Zk/pQZUkn3OOvHSNoP19
	99zWh3b2QX6LKpBMayVQLUAV6Wu8J0/RVBVAJbYCsmvRCIPV6cJspphP9Xwc+1fO4hk4QkQBHcR
	CyYqjQrUulPG90ZW6JFoqR/UJ75ZcoxFlmGfhQtOgdwuCkN+HEQwKIXQPJQafY0tCIbzj7628Kn
	ALBtPa8w6ykFI229yyGZXMahhUFMPXthoQqHoXYsIjQCbR/KGEFpB2C0mAQpjJbse0yB/6nlpr0
	2tDsGxfazosRrkzhTKUAvtcGdd+L7Z3Ts3raj2ksa7JjRjWsQKWde3fslqdEseE6AcXCuLOjTQ=
	=
X-Google-Smtp-Source: AGHT+IHsBiwiK4eN3gQARQDDEqdcIkGCIsdPX3m6mCWYTOycPIzgRNn8NPdgnw7C0XC4etKjOZZAaw==
X-Received: by 2002:a05:620a:2406:b0:7b6:e47a:8e14 with SMTP id af79cd13be357-7c08aa8a421mr2134500985a.35.1739897930985;
        Tue, 18 Feb 2025 08:58:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d78640fsm65527946d6.48.2025.02.18.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:58:50 -0800 (PST)
Date: Tue, 18 Feb 2025 11:58:48 -0500
From: Gregory Price <gourry@gourry.net>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
	peterz@infradead.org, keescook@chromium.org,
	gregory.price@memverge.com, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] syscall_user_dispatch: Allow allowed range
 wrap-around
Message-ID: <Z7S8SAGt8blFiFTg@gourry-fedora-PF4VCD3F>
References: <cover.1739894594.git.dvyukov@google.com>
 <607562bf50ddc81ebd404e8dc1710e5221f80342.1739894594.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607562bf50ddc81ebd404e8dc1710e5221f80342.1739894594.git.dvyukov@google.com>

On Tue, Feb 18, 2025 at 05:04:34PM +0100, Dmitry Vyukov wrote:
> There are two possible scenarios for syscall filtering:
>  - having a trusted/allowed range of PCs, and intercepting everything else
>  - or the opposite: a single untrusted/intercepted range and allowing
>    everything else
> The current implementation only allows the former use case due to
> allowed range wrap-around check. Allow the latter use case as well
> by removing the wrap-around check.
> The latter use case is relevant for any kind of sandboxing scenario,
> or monitoring behavior of a single library. If a program wants to
> intercept syscalls for PC range [START, END) then it needs to call:
> prctl(..., END, -(END-START), ...);

I don't necessarily disagree with the idea, but this sounds like using
the wrong tool for the job.  The purpose of SUD was for emulating
foreign OS system calls of entire programs - not a single library.

The point being that it's very difficult to sandbox an individual
library when you can't ensure it won't allocate resources outside the
monitored bounds (this would be very difficult to guarantee, at least).

If the intent is to load and re-use a single foreign-OS library, this
change seems to be the question of "why not allow multiple ranges?",
and you'd be on your way to reimplementing seccomp or BPF.

~Gregory

