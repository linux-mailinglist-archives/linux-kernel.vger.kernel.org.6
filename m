Return-Path: <linux-kernel+bounces-325231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D4975685
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B0A1C221B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51561A38CF;
	Wed, 11 Sep 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="roEqgBCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXwlQbnH"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869D64A8F;
	Wed, 11 Sep 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067580; cv=none; b=V+An42MDm/u9Z+HjfWOXuh6OdfzVIAksdFwAXGdrSyRvKfY4aNtH8Htw+zv8HcULpx3Be28WnZMApaahXCeYjA9+uN1hmveKWpzQPidzfDhm89v2A8MDJjKhl/nCXxEjGsPmUIlexZnbCv7VHvqJhfhuh4dIK+2U7pfNVMQs1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067580; c=relaxed/simple;
	bh=MeKwSewEniQVg0QWYqtdDkP3SMlDxjYZOntP0TJPLu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9bpdoaz4cLwXD0yceVORIENr8EIcxjTWelYVoxkOENruKjT3eLW30W9wPzgLj38tEoY0QWgE8DBwa47KziLvOAcEZNzeqb+qnKheFSfY3S1zHG/GZNuL0EjiiS9Xjwiha+JuXG8GaAX8MushDdqVGFdM7qEDKzmjiP1Zi1qWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=roEqgBCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXwlQbnH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B7C7513801A0;
	Wed, 11 Sep 2024 11:12:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 11 Sep 2024 11:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1726067577; x=
	1726153977; bh=hX37uCQOGVhHQTqeJ5W0AwuwfpJ/xp+m2JV1xJw815k=; b=r
	oEqgBCFzNOLtDfQGW/GXoy+5xnao/YniwORdsTn+73sly+TADa7x9z2WIRIGgJtd
	CI6Q9jjctdZX5Ggma7DBgg2Ge29yzRKFlUlo0mn/JdLabLGc2Nzi7n+84wRUCiyX
	FCYMRHZ+tDLhYHvxec4+86gZpoz5fzFi4LKiYy3ZIpJya4X9ENPXa6qZun2BMqKe
	Fk+hdazoSMsjgYR8ffQkvBwUiKLScClOS+DXc7nln9fbZ2/tT43i3pw5mRhcMai9
	C2heJUwX8O/yuHFV2kyPuejMmttrw5K4tFuRvr12uhnSxxk0N9bD2u5mJnJeTFbQ
	MqrW9Tv6xSlWAtlsgQKzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726067577; x=1726153977; bh=hX37uCQOGVhHQTqeJ5W0AwuwfpJ/
	xp+m2JV1xJw815k=; b=dXwlQbnHnqW82aserxKQOHu6CC/l6KILIh3WzGYHszp+
	KQjQDPIAFdx/Nr1aIB//MG/2TZbk+UfXWcUFhrhv3SRHEMiOKE0tLf5s2TuVF+iz
	cQ6YCNgOQT8iLAGSO0ll1lLylyQv8+wb5gSLK2jSx9EckabSYQp7KWo1hl7g+KKc
	P50/Kr+3bWVvxApyXfgwA6qED1IIre0Un3ZJ06diqDeOvyuSQjXqStKsVwAfzMNm
	QiqTW/4OYReg87v948Sq9Zm8Zgluarbb1zdGCySeo3/dgaOOAMUsppaVkePZhmVG
	h/7qHEsCZB7/ihR6E7+BuZuqnoWdRCxyKq0ttQHpbA==
X-ME-Sender: <xms:ebPhZrK2lC9H9VJhvFrKok2GHgjXqbgJclaEn7JCEz7KAfgghXuKWA>
    <xme:ebPhZvLRg-4yuUZBpHcqlYZLl3cT98t9_jRa9F6A6a5xIRiy9Qg2KTFWv2FCEhKJo
    5xouG40l11Biir4aWU>
X-ME-Received: <xmr:ebPhZjsoOFtadSgQGFiwsXMrt434uNpqI2PU6FPqGubqr0ewwU0g28TZLqeHpX1M60L-ob2r4oLJ_Pj8meOKZIZjXwhiRXNzLw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgkeehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:ebPhZkaPVdAwyqP_NGvtUOhaWP5j5XBEDu6Rt36wpI9sKJKhX8HoFw>
    <xmx:ebPhZiap8pd-OdKolsh_yqj5O-8r3pg8V7jWFCy6NiJ2NdIhGnfEwQ>
    <xmx:ebPhZoDFOBpO_e2kF6Vpq0h_jwdm0RAMrfxpPzDeePowo6n8U5FkTA>
    <xmx:ebPhZgapOrD1isfzS5cqga3v_srS7VeLA50ZyeHJAAOSU7SA5HKqvg>
    <xmx:ebPhZiFbJJWduIfSYCnxs1eNc67pRdOwnZcTgIUGetXhNA4v_UZYMqaK>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Sep 2024 11:12:56 -0400 (EDT)
Date: Thu, 12 Sep 2024 00:12:53 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core: optimize for concurrent calls of
 fw_iso_context_flush_completions()
Message-ID: <20240911151253.GA167609@workstation.local>
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

Hi,

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

I realized that the above changes have unpreferable effects to the behaviour
for user space interface. The changes allow to call the handler of
isochronous context again to drain the rest of packet buffer after calling
the handler at first due to processing the interrupt flag of 1394 OHCI IT/IR
descriptor. As a result, it is possible to enqueue two iso_interrupt events
for user space applications in the bottom half of hardIRQ. However, this is
against the description in UAPI header:

```
$ cat include/uapi/linux/firewire-cdev.h
...
 * struct fw_cdev_event_iso_interrupt - Sent when an iso packet was completed
...
 * This event is sent when the controller has completed an &fw_cdev_iso_packet
 * with the %FW_CDEV_ISO_INTERRUPT bit set, when explicitly requested with
 * %FW_CDEV_IOC_FLUSH_ISO, or when there have been so many completed packets
 * without the interrupt bit set that the kernel's internal buffer for @header
 * is about to overflow.  (In the last case, ABI versions < 5 drop header data
 * up to the next interrupt packet.)
```

As a bottom half of hardIRQ, the work item should enqueue a single event
associated to the interrupt event. The rest of packet buffer should be
handled in the bottom half of next hardIRQ unless in the path of
FW_CDEV_ISO_INTERRUPT.

Let me revert these changes later.


Regards

Takashi Sakamoto

