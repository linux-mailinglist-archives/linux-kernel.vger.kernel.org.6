Return-Path: <linux-kernel+bounces-322701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE47C972C82
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60657B25B82
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318A186E21;
	Tue, 10 Sep 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ouAH4DGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVfaEIHn"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F52339AC;
	Tue, 10 Sep 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958284; cv=none; b=MiqSeCAg8rtWouTeSZcnk7Z0oUtLeTIbvc2mjh2+NxmuxOcEVVKW1BWrR9XaPTKLyP6JWsimCTezK69guLquOUQgfNkz4mf+PG8r0PW4pTPFZhYYI5uWnWhPtnI8Y3uQaWhQ4oYTsJSCk+lGlgJd8EJhroLkOjUFffrhungkHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958284; c=relaxed/simple;
	bh=CZjuz3xJPTGqO0ibF0Qgl3Y8guh+5IhmvGl5MsGeDAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRsVGHTX3oXM1HCHHbvk6aHjcfuCA8TGqjq3oxiJESC33JA692jx0FXnXYrKgZplA0CRFLr4WyjLPkqGC/SvAEtExJk4iqkIhYfPEiy8Dji8+wKC1OjAfm9gWNbPd3MYheAW13QRnVc3SbvNlptw0l0NLgSLBBbLpHhk72fOa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ouAH4DGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVfaEIHn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 314C61140316;
	Tue, 10 Sep 2024 04:51:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 10 Sep 2024 04:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725958281; x=
	1726044681; bh=QC78W/7TuXehLycwIf9mynBigVoR8+44ttRaTS2VOZQ=; b=o
	uAH4DGr3XF1Q9ug6D1tqNlAPM5XeEzmgqBFnpSlpJcmpXSlJumKgl2sa1IizBg3N
	dlEQ7OxvX4wDFa+YcX7eMHfXHEI75dEgFdx/j7TKljkwiN8Eh4tj0WVMiDqu+mPp
	ZA9VpQyj2F6I4PbmWyHLqppFxZknaPmNSmkRty8tQHiLDAH1WbfOhhIRQsqVd9tr
	/vtMPhcbuOEJpOv6nH1cs28UvMH7OzCajGm/OSbCRGHoYZdqj97YRwbymPSb+ddx
	e3lL+x37Cx9OvjQpsY7SzA5N9G+RgM70NsNfyCoMAHSuGdKoFp+2D27OWRNMENgc
	3yjI/Y46Je1K9OBX83LhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725958281; x=1726044681; bh=QC78W/7TuXehLycwIf9mynBigVoR
	8+44ttRaTS2VOZQ=; b=cVfaEIHnc1BYb1Brt/rVr1ANGllUH3X4edTlXNbUZI45
	wspMme5y05pwWuorkL/bCBA+LV6HH+0AhE51nvyFPZxD6Y8ah3mtqbZI8CZtJ76f
	XqYk7/+qslxZ6mDkYAfmlCQX6SYiXSq8bwzvqyiarHOH85VTZWedtov9nD+CzlcJ
	ICGr1LGeXAMsJ02r5PInEc8B3KZEs32XGDn8+s6Jw9YDL2W1H6lKXgXlR3AoZ0jZ
	ihPBHIKROiIe5/ZeiYq0Oo2tlqOjI5uvR/sMd9GyvwfLa1bNSXhNCajTrBVVrXM+
	1JRkc86W4yr6I0/0GfSvEV59J4x1OqDZm6snIcMYUw==
X-ME-Sender: <xms:iQjgZj06Kio82_LtVIAMpmyb03Gl_bxJQ6MBqHAzVXoaInTBgbyQ8A>
    <xme:iQjgZiG2f8JoZX7sdFzOi7zJBQxPS7CAub1eA4DkcEtyo5lEXT6oIonPvpg5EWzz2
    nXy91ARICZdN9Cm3v4>
X-ME-Received: <xmr:iQjgZj6KzgkymXAbmFQRVXMBdQjNkUYQzOHWJZ4GcjqTOl0KBzdRRIBTZHsk_yxBxmLbMXnD9XVta6fA70bpVDuIJEDCrjpjinY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeu
    udekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iQjgZo38LzfOYE7YYQWTeSTMhaccZFNMA3HOqAh2EnU5xCLXR6LuSA>
    <xmx:iQjgZmH6lPA7xvwymoiuBRW6ZWzcsspmF5Pd4WTZ3I8EH2vQ2j4C5w>
    <xmx:iQjgZp9dtLgCia1xapN-hOj6hjOk5tiqdZaTtlXIzdJKP5RyLeh-NQ>
    <xmx:iQjgZjlIGlSL6-Cr_EnZpZUvYOYB2Wy3mYn7hXHQmIrCz4R46t1dFw>
    <xmx:iQjgZiA4CQSdSSHM-xKyjlLoaQav4_3Tl6ifYC1_gODflcu-VL80ATOD>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 04:51:19 -0400 (EDT)
Date: Tue, 10 Sep 2024 17:51:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core: optimize for concurrent calls of
 fw_iso_context_flush_completions()
Message-ID: <20240910085117.GA91104@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240909140018.65289-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909140018.65289-1-o-takashi@sakamocchi.jp>

On Mon, Sep 09, 2024 at 11:00:16PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> It seems to be the last week for v6.12 development. I realize it
> unpreferable to propose intrusive changes, however I also realized that
> there is a room to refactor core functions in respect to handler of work
> item for isochronous context for the next merge window...
> 
> This series of changes refactors the core function to call
> fw_iso_context_flush_completions() from the work item. It optimizes some
> event waiting and mediation of concurrent calls as well.
> 
> Takashi Sakamoto (2):
>   firewire: core: move workqueue handler from 1394 OHCI driver to core
>     function
>   firewire: core: use mutex to coordinate concurrent calls to flush
>     completions
> 
>  drivers/firewire/core-iso.c | 31 ++++++++-------
>  drivers/firewire/core.h     |  5 ---
>  drivers/firewire/ohci.c     | 78 +++++++------------------------------
>  include/linux/firewire.h    |  1 +
>  4 files changed, 31 insertions(+), 84 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

