Return-Path: <linux-kernel+bounces-176792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864CB8C3501
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B392818EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1BCA62;
	Sun, 12 May 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v3NemDR7"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F015B7
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488225; cv=none; b=aA5MkBhO4DNkq2GuwQMR2npXfskMLh3nZ4EL4UgcmJmPSzZPHvuG3RFrobVkN4M6ktadm50ReZkb5ReTxNn1Jchf9FvdKgXsiWn8ES83xLcLOvb54BcpBl801DtCc7PhQCOQdb1HLPxDTWizX83uqxB3V6BQB00VlELz4QHvYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488225; c=relaxed/simple;
	bh=+KAWG+E6Nyd0M6NYO11CBrd2JZbdGGHl3BLIpk7Jdfk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dvMeFKYTUqLnBW3XSjV/ERKhr+orNPZXhnAil5szjuAxAkTsIV903tW6rtJ3hyWVIgN4fchzUDvcMnjV7vEfw2ZNV2MJTdV2hOLCkR+3jH/Np0pz/PhLFtwxVWGG3H8Uf6RE2YFU70jI1xX3j129g0fvg95s9RAC4j/G+32gk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=v3NemDR7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=uh4l3X0EfCWC5vwKhDbtiQdWUpxzzFd6b5lr49IPah8=; b=v3NemDR7DCxiu3mWOXbRsiiw1/
	FiGhyGtWC+BHXnJxPLjgnBGGeN7f2MEqS5sR3agt1U4cUgqd12J+xTmSZQVfOl9be1rEllCoCMGVb
	lzHYza5jEQSy+rxBg1K2ny8dWzV6IWycreifbHFwWxXbABNEne/TVKNq/QZg8S5iwcBlNxspZqAqA
	zOH6D79+QLIOciE/hzwPE6mw0Phc+yBk9J6IqDJstyVc3hbxitlFDSNJ4deYBVF6QhdWynpDVnsgG
	jdlnlpTNKdR2oLJgUro+eIh2DEMG89VIJfIB4d7hUwROIxZiaWIAR9IdQr0rs0+e0IdOvxOSoEdg8
	tXwuDwuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s60qi-004AfJ-1j;
	Sun, 12 May 2024 04:30:12 +0000
Date: Sun, 12 May 2024 05:30:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Becker <jlbec@evilplan.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: [RFC] configfs_{un,}register_group() semantics
Message-ID: <20240512043012.GG2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Folks, could you confirm if the following is correct?

1. configfs_unregister_group() callers are supposed to prevent
having it called when some items/groups had been created under it.
The original one (in iio) *does* prevent that (the call chains come
through the module_exit() of modules pinned by ->make_group() for
the added subdirectory), but I don't see that documented anywhere and
AFAICS at least in one case (drivers/pci/endpoint/pci-ep-cfs.c) that is
not guaranteed.  The same goes for symlinks created in or to those.

2. rmdir on directory added by configfs_register_group() is supposed to
fail (is it even supposed to be used inside the stuff created by mkdir?
Original use was inside a subsystem, AFAICS).

3. rmdir that would've taken out the parent group is supposed to take
the added one out (again, are they even supposed to be used inside the
stuff created by mkdir?)

4. one is *NOT* supposed to use have ->make_group() schedule creation of
subdirectories via configfs_register_group(); configfs_add_default_group()
ought to be used instead.

drivers/pci/endpoint/pci-ep-cfs.c:pci_epf_make() has this:
        INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
        queue_delayed_work(system_wq, &epf_group->cfs_work,
                           msecs_to_jiffies(1));

        return &epf_group->group;

with pci_epf_cfs_work() allocating several config_group and calling
configfs_register_group() to link those in.  I really doubt that this
kind of "let's hope that configfs_mkdir() will get through directory
creation in less than 1ms after ->make_group() returns" is the way it
is supposed to be done; at a guess, configfs_add_default_group()
should've been used (synchronously), but I might be missing something
subtle here.

Comments?

