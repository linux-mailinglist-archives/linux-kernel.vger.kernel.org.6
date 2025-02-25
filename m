Return-Path: <linux-kernel+bounces-530560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF7A4351A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C375F17A2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F39256C9B;
	Tue, 25 Feb 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W2QiWaMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870F8172A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464558; cv=none; b=GCgcYtg/Us85qoqQX1qi5C6MkViv/2ot7xBkhP4rxFjH6XsqP+nAOkjT5s788ipJ8gl2qyR1dcNQOHswQBjkG0ki7ot0Wd4lx1AyXbmHhB0iyTu+KWbhlLehvhWLhwZNym5qIVCpAjlaBj71SSvafPCHNREq+N5YR3drkT/2ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464558; c=relaxed/simple;
	bh=XpV8O7FOYRNeMQ7j+kvwt+ECoNaMe4MRy1Mfv9FckbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgkyDH2IDTZ0yrh/+lHhOcQGEjNf6d+CEz54j1wNi4PxxQt+UyYK91+0Gr7zj93AT00mWq+uPDN5QMW1YLSn4mq8pchXvjYm8HUrIFZ2OjN7RYge0s7S+45UKWNa5B304Ij1VgXbuXTT6BkvVbG3+ahfP68Uksh/QliI8LyV0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W2QiWaMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0305FC4CEDD;
	Tue, 25 Feb 2025 06:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740464557;
	bh=XpV8O7FOYRNeMQ7j+kvwt+ECoNaMe4MRy1Mfv9FckbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2QiWaMBG3x+66UzYIYa6MkUGJiv+M7HO1XQbbJPFUKqdDa7G6eLC8g0JUVqLu/ke
	 PG+elu9+f/g4ZIs/96PTQAHRJVpUuDzdUBXB9ekMrrRqAsQEyhe30xoDKo4P51IJqu
	 wBgw7BgZN7LZJF/mMcsFFHtGALK5im5Z6IFhJh74=
Date: Tue, 25 Feb 2025 07:21:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/2] Revert "drivers: core: synchronize really_probe()
 and dev_uevent()"
Message-ID: <2025022553-maximize-ferry-8532@gregkh>
References: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>
 <2025022051-happy-plant-b40b@gregkh>
 <9232C7B6-627B-43F9-AD5C-1EA4BB69E40D@gmail.com>
 <Z70oQKHjvjutqom5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z70oQKHjvjutqom5@google.com>

On Mon, Feb 24, 2025 at 06:17:36PM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 19, 2025 at 11:22:25PM -0800, Dmitry Torokhov wrote:
> > On February 19, 2025 11:13:00 PM PST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >On Wed, Feb 19, 2025 at 10:46:44PM -0800, Dmitry Torokhov wrote:
> > >> This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0.
> > >> 
> > >> Probing a device can take arbitrary long time. In the field we observed
> > >> that, for example, probing a bad micro-SD cards in an external USB card
> > >> reader (or maybe cards were good but cables were flaky) sometimes takes
> > >> longer than 2 minutes due to multiple retries at various levels of the
> > >> stack. We can not block uevent_show() method for that long because udev
> > >> is reading that attribute very often and that blocks udev and interferes
> > >> with booting of the system.
> > >> 
> > >> The change that introduced locking was concerned with dev_uevent()
> > >> racing with unbinding the driver. However we can handle it without
> > >> locking (which will be done in subsequent patch).
> > >
> > >So shouldn't we take the second patch first to prevent any issues here?
> > 
> > I think the potential for the NULL dereference is extremely small, we
> > lived with it for many years. But if you prefer the patches can be
> > swapped.
> 
> Greg, I was looking at this again and I do not think it makes sense to
> swap the patches, as then explanation and justification makes no sense.
> So we can either keep it as a straight revert and then address the
> driver pointer handling, or combine the 2. What would be your
> preference?

Your original sequence is fine, it makes more sense as you point out.

> I will need to respin to address Rafael's comment anyways.

That would be great, thanks!

greg k-h

