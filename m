Return-Path: <linux-kernel+bounces-332987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD997C1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972091F2253D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00241CB334;
	Wed, 18 Sep 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DqMCBf/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B01178CF6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726698485; cv=none; b=eixOxt702XkPG778CvoE8Ajp9l2MfsPROvUtTEys2OjVyFG6Vf4xURwC9pqq6Z8s39Q6mov+XpWnYQ9VlKy6i4BHFUuWvh42Fys1WzkWUTy23U6/zC+Bg1MDKxqc2OJqKIm785pRShU+dWhXGeE2QPcsmp6RogpygIBXH91XtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726698485; c=relaxed/simple;
	bh=DviNfOBLBfJtvGzTe4PiwqFhlg1DqqYhA659Mdmix88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adn51tKVnPXHLKqHRAVgfeBHvouQYrFeTXOYuVaJ+EUt/lfqd+i7X2synRJQMdh3W1QR08oC5rSLoNkOFaYPLnkLI4DW2wNG6tz+eA7U1F1E5D/v2J8eL2d/xXLtod99vkbBMqLNg4tpxBlOEPVB9WoRgSwupizx2iP0BsPH5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DqMCBf/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFFBC4CEC2;
	Wed, 18 Sep 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DqMCBf/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726698481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWmjdRBT0ivUDXNAnsZ9bumBL4RE93ccXi0XEeAeoT0=;
	b=DqMCBf/B5uJIiTmJrKVJFMDkraiFYgXBFcz+QJrZMm3PMEoRiytvqI72S5twJq+Jb1HvEV
	hzEASuovnk20zW5Jrn7aWqq12gxvM6U1ImGn6rowC8n5kpWGQSw7rwy202a4SGLHB13BTa
	VNjg8CfPrmqrOaKxaHuQIfX3o04kK7c=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca5a12b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 22:28:00 +0000 (UTC)
Date: Thu, 19 Sep 2024 00:27:57 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alexander Graf <graf@amazon.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Sean Christopherson <seanjc@google.com>, jann@thejh.net
Subject: vm events, userspace, the vmgenid driver, and the future [was: the
 uevent revert thread]
Message-ID: <ZutT7bArzCwW5yyf@zx2c4.com>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com>
 <Zi9ilaX3254KL3Pp@gardel-login>
 <01d2b24c-a9d2-4be0-8fa0-35d9937eceb4@amazon.com>
 <CAHmME9rxn5KJJBOC3TqTEgotnsFO5r6F-DJn3ekc5ZgW8OaCFw@mail.gmail.com>
 <84c3696d-8108-4a2e-90d7-7830ca6cc3b9@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84c3696d-8108-4a2e-90d7-7830ca6cc3b9@amazon.com>

[broadened subject line and added relevant parties to cc list]

On Tue, Sep 17, 2024 at 10:55:20PM +0200, Alexander Graf wrote:
> What is still open are user space applications that require event based 
> notification on VM clone events - and *only* VM clone events. This 
> mostly caters for tools like systemd which need to execute policy - such 
> as generating randomly generated MAC addresses - in the event a VM was 
> cloned.
> 
> That's the use case this patch "vmgenid: emit uevent when VMGENID 
> updates" is about and I think the best path forward is to just revert 
> the revert. A uevent from the device driver is a well established, well 
> fitting Linux mechanism for that type of notification.

The thing that worries me is that vmgenid is just some weird random
microsoft acpi driver. It's one sort of particular device, and not a
very good one at that. There's still room for virtio/qemu to improve on
it with their own thing, or for vbox or whatever else to have their
version, and xen theirs, and so forth. That is to say, I'm not sure that
this virtual hardware is *the* way of doing it.

Even in terms of the entropy stuff (which I know you no longer care
about, but I do), mst's original virtio-rng draft mentioned reporting
events beyond just VM forks, extending it generically to any kind of
entropy reduction situation. For example, migration or suspend or
whatever might be interesting things to trigger. Heck, one could imagine
those coming through vmgenid at some point, which would then change the
semantics you're after for systemd.

Even in terms of reporting exclusively about external VM events, there's
a subtle thing to consider between clones/forks and rollbacks, as well
as migrations. Vmgenid kind of lumps it all together, and hopefully the
hypervisor notifies in a way consistent with what userspace was hoping
to learn about. (Right now, maybe we're doing what Hyper-V does, maybe,
but also maybe not; it's kind of loose.) So at some point, there's a
question about the limitations of vmgenid and the possible extensions of
it, or whether this will come in a different driver or virtual hardware,
and how.

Right now, this is mostly unexplored. The virtio-rng avenue was largest
step in terms of exploring this problem space, but there are obviously a
few directions to go, depending on what your primary concern is.

But all of that makes me think that exposing the particulars of this
virtual hardware driver to userspace is not the best option, or at least
not an option to rush into (or to trick Greg into), and will both limit
what we can do with it later, and potentially burden userspace with
having to check multiple different things with confusing interactions
down the road. So I think it's worth stepping back a bit and thinking
about what we actually want from this and what those semantics should
be.

I'd also love to hear from the QEMU guys on this and get their input. To
that end, I've added qemu and virtio mailing lists, as well as mst.

Also, I'd be interested to learn specifically what you (Amazon) want
this for and what the larger picture there is. I get the systemd case,
but I'm under the assumption you've got a different project in your
woods.

Jason

