Return-Path: <linux-kernel+bounces-220883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE990E891
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20754283CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD6132102;
	Wed, 19 Jun 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W60hgxO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1912FB37;
	Wed, 19 Jun 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793839; cv=none; b=BHK46y9VtGypNqjgUIBeTVKsu0bOFrdaTIXhfFxcLA2xucOnxiFujZYUBHfo6lipMSqZoOkEvpBO3/5Lytg/L2nXdYZplYS9TrloUpVyKeat1fZL1M1Qfm30QWs9ZjbIbmZJgrp+UHPoKzbaKPaEIMQYsdbH1PzpE2yvmsSQ2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793839; c=relaxed/simple;
	bh=VaHnzoB2BRFFgfQ9BYYa6NonCLsBYoZgqxn9xZh5mHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7cZffIEpgC7sNqkWWwFVsewhUiArzvsrSKVM9YICMVbXPK0//JNuo7BEoKct0//2GfhQX//NZUaUb3KTD12RUwsuz5+Bj+6CA9W9HBaCnH0QS1kVYYAZfFm6qsZie06j03gUeeubtw9upJ7zyLhqfgtSS01kBt/BxEXPaeV+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W60hgxO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF30C2BBFC;
	Wed, 19 Jun 2024 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718793838;
	bh=VaHnzoB2BRFFgfQ9BYYa6NonCLsBYoZgqxn9xZh5mHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W60hgxO4Dmv0I70GYuKdv3UQU03jl/Lb8wRKSC29k8HneXovw8TNVV3VYwiS34r8h
	 urqhTLAnolUIQXB9a+pcUGnVqwoiTvhrPKHrsbnRa6ugzIOKcI8GK1fP//gyVE6Nsi
	 jlmHVGaPkLQuxEOykDfiTP/k6Pu7pfzVQgvWJ+Xs=
Date: Wed, 19 Jun 2024 12:43:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rafael@kernel.org,
	mcgrof@kernel.org, russ.weight@linux.dev, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: add firmware abstractions
Message-ID: <2024061900-outspoken-blast-a391@gregkh>
References: <20240618154841.6716-1-dakr@redhat.com>
 <20240618154841.6716-3-dakr@redhat.com>
 <8d6f98c2-afe2-4e94-b630-96a8fa0b39cf@proton.me>
 <ZnKod6Wn5louhPu8@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKod6Wn5louhPu8@pollux>

On Wed, Jun 19, 2024 at 11:44:23AM +0200, Danilo Krummrich wrote:
> Greg,
> 
> Benno's comments provide some nice hints to further improve the safety comments.
> Since I was notified that those patches hit your tree already, how do you want
> to proceed?

Please start by not top-posting :)

Anyway, patches on top of what is in my tree is fine, these are just
comment updates, not any real broken issue to prevent the existing stuff
from existing.

thanks,

greg k-h

