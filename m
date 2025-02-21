Return-Path: <linux-kernel+bounces-525343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56093A3EEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E44421103
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B420110F;
	Fri, 21 Feb 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dNqYXzOa"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6E20011E;
	Fri, 21 Feb 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126946; cv=none; b=kum8XeSjeM9LPygfYLBMT3xRgJ97M0ZwqdYGCqH1OnPWzhMV6Jdla3lg+7YB7QSfu5QiALvb+dJWhNmiicwvhXVRAjWBwpf+qOFuZAhU6AojOWfY28VJrm3+gHZlbLy2CR44HvscSJjams0Jm0+9WyFsKmkzsb9K5wdgJrB3wC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126946; c=relaxed/simple;
	bh=W6JW6wM6TgMV46GwKzxwdEiUr7fVXEz2M00OqZcFPg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+yjWbH1yHv0bqJo1+jE+fTOEICxD/yKlxW+HyRVskUkgMwXia3oXB14XQMMtYxo8+lOSjLCeOnPkG9MnElWdY5oc5a6aEXCUhhMlYuQYiZ+5TyqD2R3iKFdgrQznnx82Uacu1cWm6FqONXn0gxEDAsj3l4dcZ3E81gsBklYdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dNqYXzOa; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740126937; x=1740386137;
	bh=W6JW6wM6TgMV46GwKzxwdEiUr7fVXEz2M00OqZcFPg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=dNqYXzOaRQ6St5npeKqfQK4VaEtJIUT6exZrTW4s+E9nayu+L9nyVoXnrHyqf7OXA
	 fkYbhXYBm2URfFlS7y5UZLTkR0Exz8LiB+9a8Xm37/L42QwvxsPkjACMrR9OU1S7VY
	 zoI59W9D+V2jCMoRBuIZeX1WmUCpm6bxNaY0TmNmy/GE3aV/mtiAr4o7FeeF4/Awc1
	 C40YmdiVcsrCI8PsQQXR/S+u++RW+p3lEs3AQgoijYpL66WsBr2+GoT4UyYn64omgw
	 jR171lApWUnzfF3c/JSRe9iVUiwz20XuMH7qIQMz03zPD3ULP6aZsw/6OwrD/6VSe+
	 O3TjJx5rB8i4g==
Date: Fri, 21 Feb 2025 08:35:32 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] Rust: Implement a unique reference type URef supplementing ARef
Message-ID: <Z7g60a63M7-zm1-G@mango>
In-Reply-To: <2025022123-channel-laundry-0393@gregkh>
References: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid> <2025022123-channel-laundry-0393@gregkh>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 1ea340b758136c3a362c07183d52387d04198585
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250221 0912, Greg KH wrote:
> Nit, please wrap your changelog text at 72 columns or so, checkpatch
> should have warned you about this, right?

Sorry, I did checkpatch before adding the description. Learned something ne=
w, I guess :)


