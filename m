Return-Path: <linux-kernel+bounces-178672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A028C5630
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC28A1C21BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362F6CDBD;
	Tue, 14 May 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jqD3WRqS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jqD3WRqS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF881879;
	Tue, 14 May 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690988; cv=none; b=QBaylyeswS1IZxQ9dMZ6956CVtpmPmt+4qwB+pDwB8/xvXL2gVxauQu/h4tYu4ri+nFWlyak8SdZDRjKURazMx5rf4L7WTSnsN/iYz0SZvpecWmGHR/wahfEGjzRXYt5IJZh+yrJnlwXSzl6KD9RA+xsP5v0/HIX1M1ieN5u33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690988; c=relaxed/simple;
	bh=a6K4hHzuy1MYWwstaaqHLrIevHBlIT/S0Pb5gq4hQF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVXvmOm0yYVTM13Dzjpj2KIC9bDt/6S/lvwiUNyFcP+aB27Il6Xw6wrPfgLli6l+3aKAznknplpl2/rh6bZfGFAaiZdYt1UTORM9yO10j9uhPg+8DFbt7Sk994GobMZ+Ks6/weZNAY1RGT2WF/0g3hazgGQLrBD2XijDyd+l3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jqD3WRqS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jqD3WRqS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 562E460C24;
	Tue, 14 May 2024 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715690984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ohSg6YjbgbhC4L4yRgqvJkso+JLgw6lS+f326pBTXE=;
	b=jqD3WRqSkPoffGUASovsNhfpVpL4MMdIkDxsjGMhaBOV29ootingsvOEEaHnrJCVKBG4Td
	CwgqZ+2DvSOpPzIC5L/pD3Frua3DVabkhFKudocYUfJsflBFu07oA0JCeMM3njOWiNWFns
	+pRkOo3vKwKI1jzPkyIi8zLOCrkhaFs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715690984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ohSg6YjbgbhC4L4yRgqvJkso+JLgw6lS+f326pBTXE=;
	b=jqD3WRqSkPoffGUASovsNhfpVpL4MMdIkDxsjGMhaBOV29ootingsvOEEaHnrJCVKBG4Td
	CwgqZ+2DvSOpPzIC5L/pD3Frua3DVabkhFKudocYUfJsflBFu07oA0JCeMM3njOWiNWFns
	+pRkOo3vKwKI1jzPkyIi8zLOCrkhaFs=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	cve@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26821: fs: relax mount_setattr() permission checks
Date: Tue, 14 May 2024 14:49:39 +0200
Message-ID: <20240514124939.77984-1-ailiop@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <2024041702-CVE-2024-26821-de6b@gregkh>
References: <2024041702-CVE-2024-26821-de6b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[]

On Wed, Apr 17, 2024 at 11:44:04AM +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> fs: relax mount_setattr() permission checks
> 
> When we added mount_setattr() I added additional checks compared to the
> legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
> mount(2). If that mount had a parent then verify that the caller and the
> mount namespace the mount is attached to match and if not make sure that
> it's an anonymous mount.
> 
> The real rootfs falls into neither category. It is neither an anoymous
> mount because it is obviously attached to the initial mount namespace
> but it also obviously doesn't have a parent mount. So that means legacy
> mount(2) allows changing mount properties on the real rootfs but
> mount_setattr(2) blocks this. I never thought much about this but of
> course someone on this planet of earth changes properties on the real
> rootfs as can be seen in [1].
> 
> Since util-linux finally switched to the new mount api in 2.39 not so
> long ago it also relies on mount_setattr() and that surfaced this issue
> when Fedora 39 finally switched to it. Fix this.
> 
> The Linux kernel CVE team has assigned CVE-2024-26821 to this issue.

This one probably needs to be disputed as it isn't an actual
vulnerability, but rather a fix for the mount_setattr which previously
didn't allow reconfiguring the real rootfs similar to what the mount
syscall always allowed to do.

So it merely brings mount_attr up to par with mount in terms of allowing
the real rootfs to be reconfigured.

Christian, what do you think ?

Regards,
Anthony

