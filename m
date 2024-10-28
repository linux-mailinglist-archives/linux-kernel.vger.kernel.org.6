Return-Path: <linux-kernel+bounces-385806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9E9B3BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787DDB20FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6E1E0DCB;
	Mon, 28 Oct 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="XRlsP4MP"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758B148300
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147858; cv=none; b=j/0rQM8brtogRIj96ydBVesOrQLahnnhgiJ2UJMpNc21oyRsYy+jqJovDaGfoDk4CanG6NnHkFfVhE5TWsUomYxWXZmimjKsikDbI8SRHLG3l3sU9opyoY3VMbK7/4qL9KrwBauzEHiSja9VSoLtpU0mdO7ZG7eQ+42uKWI+CQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147858; c=relaxed/simple;
	bh=1cmMA6DZcIj1ByUWOXepebgMFqvxMzRHCB8E9CDMjlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skrZffAH4e9q5RFDexKjbZ43KNr5w3gP8fh5o2VHmZc4NMoysT+DNmW9NPkDQHuTrFVvS1FrnrapDYjjiinAiJibaSxO9zsn6vUSno13DUHAQvtnxRVfjrRGx633lm0edX4Ker2G7eur+L8Xgv+nWhPyvLO6u7b7Ed3Wt7IxJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=XRlsP4MP; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 75A69177109; Mon, 28 Oct 2024 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730147855; bh=1cmMA6DZcIj1ByUWOXepebgMFqvxMzRHCB8E9CDMjlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRlsP4MPGa7h7zOFzKDBEcBo9QX8tRMFmkGcgVeAYYN7yFIVqTrGPsh2IlCE50ECe
	 cHTzmVEeObLjOpkR/ceV0ajGU6tJVQC77k8mucf9hhvEv4zIMXUSAIKh/e3zG+iw66
	 VtLl7Be5XTTLEHNI0wQK1ZhTZW5tIHZDHKzpgWObuRnrmFp61KcFq1TG9ZL3RGH0Vk
	 vA5HDFi6t9epgtsfAJQj7G9Ygd3y0paPDjz1VnJEHQiLewgYC6YJPmwOGS3Zo0mTBS
	 D5O1edOSQEH7o71PZWGww57isk5YQavd38n4hwvV7MqaYhca/wY815a7Ig2txdwWa9
	 wzMgKC700bOAg==
Date: Mon, 28 Oct 2024 20:37:35 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix breakpoint enable to be silent if already
 enabled
Message-ID: <20241028203735.GA919150@lichtman.org>
References: <20241027204729.GA907155@lichtman.org>
 <CAD=FV=XP3WueSj9reLqsDm3-i3K0LMX7SJcf_Z=8E=3rD7E81g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XP3WueSj9reLqsDm3-i3K0LMX7SJcf_Z=8E=3rD7E81g@mail.gmail.com>

On Mon, Oct 28, 2024 at 11:38:00AM -0700, Doug Anderson wrote:
> On Sun, Oct 27, 2024 at 1:47 PM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > Fix the breakpoint enable command (be) to a logic that is inline with the
> > breakpoint disable command (bd) in which if the breakpoint is already in
> > an enabled state, do not print the message of enabled again to the user.
> 
> I don't ever use these commands (if I'm setting breakpoints them I'm
> using kgdb, not kdb), but this seems OK to me in general. I'm a little
> curious why you don't also make the "breakpoint clear" command
> consistent.
> 

After looking deeper into this, reason this is not applicable for the "bc"
command is that after clearing the breakpoint, upon trying to clear it again,
an error will occur that says the breakpoint doesn't exist anymore hence this
logic is not applicable for "bc" which unlike "be"/"bd" completely clear out the bp

Thanks,
Nir

> -Doug

