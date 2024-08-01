Return-Path: <linux-kernel+bounces-271470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B00944EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C10528427C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353D13AD2A;
	Thu,  1 Aug 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a9nlD3VE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dcY7+Xaj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91B13A24E;
	Thu,  1 Aug 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524431; cv=none; b=fw8bINTd6mT9pRUcP8ftUoWvhlrfzR34nuosuctEbkpifW3SBOMjQTds4AQwxCCaNqws7r7DH6AU4DZV6TojAgKzoRizRfq/morNqKASDv21V6ueCKjSH5O+cnW6NmFM+Zv0FYkboXzJPYSjTNcLyMrsGRnx6P5UasuxZyEhV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524431; c=relaxed/simple;
	bh=WGxdF7Byg3+IH/mPSgpfmZhsnpPo5irbIzTY/niFtZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwXqYEfJXu1qDb11jwUB4KgQPdfF0Q9KmnmhtDWwaMisx/sDOkx6ccyxXUObDMY12ZajgQmecdI5s5GrfB+IgB8AaE2Fn7/b83nv8WtZr4htENIH0VIBU7PqCTyNDUoKK4UjO4CLkUN2iX327vjMq7fqXFBAwVkRZX7vmx6Gv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a9nlD3VE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dcY7+Xaj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id D993521A07;
	Thu,  1 Aug 2024 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722524428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCtKB/ClK6LuA6Miajn2kvCneIKvWVg1JzDDOqmoGGg=;
	b=a9nlD3VE2FJRct/imNTfjz+B+jrdApPAngZpZjVNkp06kwOP9xH7G4FmnrintDaexWX6/C
	2e5ep5CbyoYQ2oivHf5vIF6jvgr9rejAuVVnT7HJo8BnA/XDxj4Pxjb7UFX0I4zW0QbMER
	Bzyhfr7QaV9edkWVmEs22u+d6m8Aqek=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722524426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCtKB/ClK6LuA6Miajn2kvCneIKvWVg1JzDDOqmoGGg=;
	b=dcY7+Xaj14Cgi/Qh6Z8uafIbF2vRPdySiVzj1d04ezsns/uonyjhVuQFvdGG4dT1xDxPeQ
	8NSW/SKBLBPPOqPWSTuKngg21KkfAhYGh+HLs74N+COzW+hg1Z8YxjIOMfl5l/gPowfs/e
	yTXNn6FPONC2oktYWbQZJPvJDy92jxM=
From: Anthony Iliopoulos <ailiop@suse.com>
To: gregkh@linuxfoundation.org,
	Mike Marshall <hubcap@omnibond.com>,
	cve@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-42143: orangefs: fix out-of-bounds fsid access
Date: Thu,  1 Aug 2024 16:59:26 +0200
Message-ID: <20240801145925.2990-2-ailiop@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024073031-CVE-2024-42143-5cec@gregkh>
References: <2024073031-CVE-2024-42143-5cec@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.59 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-0.99)[-0.995];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.arch.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.59

On Tue, Jul 30, 2024 at 09:48:01AM +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> orangefs: fix out-of-bounds fsid access
> 
> Arnd Bergmann sent a patch to fsdevel, he says:
> 
> "orangefs_statfs() copies two consecutive fields of the superblock into
> the statfs structure, which triggers a warning from the string fortification
> helpers"
> 
> Jan Kara suggested an alternate way to do the patch to make it more readable.
> 
> I ran both ideas through xfstests and both seem fine. This patch
> is based on Jan Kara's suggestion.
> 
> The Linux kernel CVE team has assigned CVE-2024-42143 to this issue.

I think this one needs to be disputed as there was no actual out of
bounds access. The fix is basically just silencing the string
fortification warning which was due to:

memcpy(&buf->f_fsid, &ORANGEFS_SB(sb)->fs_id, sizeof(buf->f_fsid));

and fortify-string complaining as it detects that memory beyond
sb->fs_id is going to be accessed, which was intentional:

struct orangefs_sb_info_s {
	[...]
	__s32 fs_id;
	int id;
	[...]
};

The fix simply made the fs_id and id fields assignment explicit so as to
avoid the warning.

Mike, could you confirm that this should not be a CVE?

Regards,
Anthony

