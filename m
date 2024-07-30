Return-Path: <linux-kernel+bounces-267236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A6940EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593521F244EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66589197A82;
	Tue, 30 Jul 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPldjl6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDF192B93;
	Tue, 30 Jul 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334463; cv=none; b=PzOzsWHFFDAiTwHWA6nWNNwK/PLfKHzzw/dbnYPK3c72RkrUSGMmQEWzGHeyLoUysmZQN/1/KQS2pGOPOsuLZBScS//ktqCQUFgKdYvUmj1eKr5Rxq7LwuQ3zwNuUgijHmR2uEZzt1wRoY2Q1ySzHgmzr/RzGhXiy+PhaI3Mhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334463; c=relaxed/simple;
	bh=ef3mNoWpD3GxYoxgxOSr4kEuGojZFLPO82xFzGB1hmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL6pcm//77ux4sVsXa9ibxhSJJmw0pA3JEqUwlc2wMjhu6+NiJ+D71F9FiwZgD9Zm3BmlhtdXyTttaB7rwTLc+BzzG4HemeZdo/stctd2LGyF9RR3RzmBOhtCnqlHWePRvUZuGdsEx9j1tzjGjf8oHT79VO9dj6ddoGOoXL7NII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPldjl6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE9EC4AF0B;
	Tue, 30 Jul 2024 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722334463;
	bh=ef3mNoWpD3GxYoxgxOSr4kEuGojZFLPO82xFzGB1hmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPldjl6Muz51/HfYaxRLnylC1vetaJN+vKU5SeBe0rQVYL4xrI98Cq0W/DA7hbT+l
	 L9jC7eE2kVtsyCv9KSycebe7vRDQD0gB6SFXKWK0oHpoETs9Q2hZilL0kDp4v3yLXK
	 tC8zqw5adT68Ge2aIAOnflovjXe90oOiZ5cdcCdsk74kpdW9BeCBZliw4aG08/Y99B
	 lKUQvUengn3eYVsDXrzNguNWwNmLwDG+6YLsXwWius9H40v1m4+Q/ssWLjE0JuW6Ko
	 wkB6Cn8uYPWnhVimH6KuK+EbTwBpLzE8gND0dUpIu1GH2n/LRav2ftvOFcNWhP8Pgv
	 YknVhafds4Nxg==
Date: Tue, 30 Jul 2024 10:14:20 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Patryk Duda <patrykd@google.com>
Cc: Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Lock device when
 updating MKBP version
Message-ID: <Zqi8_JeZJU0rGfEE@google.com>
References: <20240725175714.1769080-1-patrykd@google.com>
 <ZqcQ3rjY6Wu4lU6t@google.com>
 <CAMxeMi3864MhJvaH16mw5hHKzYnoRWpZWnxJJuWm9bSKiTojWQ@mail.gmail.com>
 <ZqiCV_EXnJONOdyV@google.com>
 <CAMxeMi3VFN91FpGb3dgobz9aXt+Ok8rEqGkidwrGxNNk43O=6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxeMi3VFN91FpGb3dgobz9aXt+Ok8rEqGkidwrGxNNk43O=6g@mail.gmail.com>

On Tue, Jul 30, 2024 at 10:05:16AM +0200, Patryk Duda wrote:
> On Tue, Jul 30, 2024 at 8:04 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > On Mon, Jul 29, 2024 at 01:57:09PM +0200, Patryk Duda wrote:
> > > On Mon, Jul 29, 2024 at 5:47 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > Also, the patch also needs an unlock at [1].
> > > >
> > > > [1]: https://elixir.bootlin.com/linux/v6.10/source/drivers/platform/chrome/cros_ec_proto.c#L819
> > >
> > > Yeah. I'll fix it in v2
> >
> > I'm wondering if it's simpler to just lock and unlock around calling
> > cros_ec_get_host_command_version_mask().  What do you think?
> >
> Initially, I thought it would be good to keep ec_dev->mkbp_event_supported
> update under the mutex (similar to cros_ec_query_all() which is called with
> locked mutex), but mkbp_event_supported is also used without locked mutex.
> 
> I don't see any obvious risks with updating the MKBP version outside mutex.
> Do you want me to change it?

Yes.

