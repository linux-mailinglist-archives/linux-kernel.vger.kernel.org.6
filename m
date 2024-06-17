Return-Path: <linux-kernel+bounces-218291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CAF90BC2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185801C22D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5441198A39;
	Mon, 17 Jun 2024 20:30:04 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9BF9F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656204; cv=none; b=cdVTF0CYRZW1v2HXjGi+GyLWHFyCYkNhld4N4mRsuOTqRQw34OPtU/Flh52VtuJ3ebFZczykWzq670XBdpwY1hBpl7KlmQw10Bne8iQ53ZSeuWmI/Y1VvPfMm2c8cI+UJXgXgCMyITgLLp4xWtMRQN7A9r5yVfUxkP3kj0rdhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656204; c=relaxed/simple;
	bh=XuollNm8srBVHta/po2WkAa37OTUPvcmjlfgPNRaES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1NAdMOn9qBbpDYqZ9tWnVE+A5jPozZayUlTFtmR6gVZ4f+h8laCvQB9weBIGsnsTCCELUQHIRj+Eb79VSGGBwuBfQHClFOdGGPwiFLO07GDGl/akEPtl7/3Ve+iC91waK2YgqD+9739MCEyJOC0LxXbHGJCHv2lphvVahePuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sJIz2-000000001We-1tSz;
	Mon, 17 Jun 2024 20:29:44 +0000
Date: Mon, 17 Jun 2024 21:29:36 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Richard Weinberger <richard@nod.at>
Cc: Gagan Sidhu <broly@mac.com>, ZhaoLong Wang <wangzhaolong1@huawei.com>,
	chengzhihao1 <chengzhihao1@huawei.com>,
	dpervushin <dpervushin@embeddedalley.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
Message-ID: <ZnCcsPA-flVcxiAT@makrotopia.org>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
 <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com>
 <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com>
 <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com>
 <303502000.252057.1718647746641.JavaMail.zimbra@nod.at>
 <90A90DA4-8B68-432D-9577-0D3635AF84BB@mac.com>
 <296007365.252185.1718649153090.JavaMail.zimbra@nod.at>
 <3841F21D-CA54-456C-9D9C-F06EEA332A30@mac.com>
 <136290141.252319.1718650375432.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <136290141.252319.1718650375432.JavaMail.zimbra@nod.at>

Hi Richard,

On Mon, Jun 17, 2024 at 08:52:55PM +0200, Richard Weinberger wrote:
> [CC'ing Daniel]
> 
> ----- Ursprüngliche Mail -----
> > Von: "Gagan Sidhu" <broly@mac.com>
> > An: "richard" <richard@nod.at>
> > CC: "ZhaoLong Wang" <wangzhaolong1@huawei.com>, "chengzhihao1" <chengzhihao1@huawei.com>, "dpervushin"
> > <dpervushin@embeddedalley.com>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-mtd"
> > <linux-mtd@lists.infradead.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> > "yangerkun" <yangerkun@huawei.com>, "yi zhang" <yi.zhang@huawei.com>
> > Gesendet: Montag, 17. Juni 2024 20:46:10
> > Betreff: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by ftl notifier
> 
> >> On Jun 17, 2024, at 12:32 PM, Richard Weinberger <richard@nod.at> wrote:
> >> 
> >> ----- Ursprüngliche Mail -----
> >>> Von: "Gagan Sidhu" <broly@mac.com>
> >>>> AFAICT, this log line is not part of the mainline kernel.
> >>> 
> >>> this is mainline. it’s just not 6.x. it’s 4.14.
> >> 
> >> I've double checked and disagree.
> >> This line comes from:
> >> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-4.14/480-mtd-set-rootfs-to-be-root-dev.patch;h=6cddaf01b75cb58cfb377f568f2c375af87e2f1b;hb=c3bd1321de1e0d814f5cfc4f494f6b2fb1f5133b
> > 
> > no i know that, that’s the patch i showed you. i meant the rest of it is
> > mainline. the patch obviously is not.
> >> 
> >> In recent OpenWRT kernels I see:
> >> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.patch;h=266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=HEAD
> >> 
> >> Looks like in recent versions the patch in question does *not* cause a
> >> regression.
> > 
> > that patch is also applied in my version as well, so i don’t see how this avoids
> > the regression.
> > 
> > https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774
> > 
> > mine says "[6.051426] mtd: device 12 (rootfs) set to be root filesystem"
> > 
> > which is simply the call from drivers/mtd/mtdcore.c
> > 
> > so the rootfs device is set correctly. it’s just not booting from it.
> > 
> > the regression comes from having GLUEBI+BLOCK enabled, it seems, are they
> > fighting for/operating on the same partition?
> 
> I don't know. Let's ask Daniel.

I've tried to follow up with this thread and to understand what this is all
about.

Let me add a few things:

 * In OpenWrt we are trying to get rid of the downstream patches
   mentioned here. They were introduced at a time when we did not have
   Device Tree and hence no option to use kernel cmdline to attach UBI,
   or use root= parameter. Nowadays they are legacy and we should not
   use the various auto-rootfs hacks in favor of doing the same thing
   using /chosen/bootargs in DT and the like.

 * Shortly after the introduction of ubiblock we happily got rid of gluebi.
   In OpenWrt gluebi has not been enabled for a very long time, and
   hence I can tell little about potential problems it may cause, or at
   least I can't do more than anyone else can which is reading the code
   and the logs supplied by the user.

All that being said there are of course cases where one may simply
require to use a very old kernel (4.14 here) in order to be able to run
proprietary out-of-tree drivers (rt2860 wifi here). And, of course, if
you can compile a kernel with gluebi and ubiblock both enabled, then
that should work as well and not result in either of them going south.

So reading the logs I do understand what has happened:
Note that the error for unknown-block(31,12) is ENXIO ("No such device
or address"), and that makes sense as that mtdblock12 device indeed
doesn't exist:

> [    6.457518] 1f0b            4608 mtdblock11
> [    6.457523]  (driver?)
> [    6.470720] fe00           33604 ubiblock0_0
> [    6.470724]  (driver?)

And yes, that's due to the added tests for mtd->type != MTD_UBIVOLUME
which prevent mtdblock from being created for gluebi devices.

I understand that the board depends on OpenWrt's patches, as back in the
days of Linux 4.14 MT7621 was still using platform C code for each board
and there was no way to set, append or replace bootargs from DT, simply
because there isn't DT.

As at the time also ubiblock wasn't used and also most likely won't work
with that semi-proprietary firmware based Linux 4.14 which expects JFFS2
to be used, my suggestion is to disabled CONFIG_FTL (if it isn't already
disabled anyway) and apply this patch (which should be further
discussed) in order to fix commit ("mtd: Fix gluebi NULL pointer
dereference caused by ftl notifier"):

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 3caa0717d46c..3ef57dd56288 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -461,7 +461,7 @@ static void blktrans_notify_add(struct mtd_info *mtd)
 {
 	struct mtd_blktrans_ops *tr;
 
-	if (mtd->type == MTD_ABSENT || mtd->type == MTD_UBIVOLUME)
+	if (mtd->type == MTD_ABSENT || (IS_ENABLED(CONFIG_FTL) && mtd->type == MTD_UBIVOLUME))
 		return;
 
 	list_for_each_entry(tr, &blktrans_majors, list)
@@ -501,7 +501,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	mutex_lock(&mtd_table_mutex);
 	list_add(&tr->list, &blktrans_majors);
 	mtd_for_each_device(mtd)
-		if (mtd->type != MTD_ABSENT && mtd->type != MTD_UBIVOLUME)
+		if (mtd->type != MTD_ABSENT && (!IS_ENABLED(CONFIG_FTL || mtd->type != MTD_UBIVOLUME)))
 			tr->add_mtd(tr, mtd);
 	mutex_unlock(&mtd_table_mutex);
 	return 0;


Let me know if that helps and lets discuss if it could be considered for
being applied in upstream Linux.

> 
> > 
> >> 
> >>>> (31, 12) would be mtdblock12.
> >>>> How does your kernel know that mtdblock12 shall be the rootfs?
> >>> 
> >>> this is an openwrt approach: https://openwrt.org/docs/techref/filesystems (under
> >>> “technical details”, third paragraph)
> >>> 
> >>> essentially there’s a feature they add to the kernel (via patch) where you can
> >>> enable a feature that sets the root device based on the name of the partition.
> >> 
> >> So, this is all not mainline. :-/
> > 
> > i did say openwrt at the start, and i think that’s pretty close to mainline as
> > it gets.
> > 
> > sometimes these patches aren’t appropriate to push upstream. this one is not the
> > one causing the issue.
> > 
> > it seems to me that there is a problem with GLUEBI+BLOCK playing together.
> > 
> > as far as i can see, the setting of the device is being doing by mtdcore.c
> > 
> > it’s just not working with gluebi and block are enabled, and i need to know
> > whether disabling gluebi will allow it to work.
> > 
> > in other words, is it possible for gluebi to use the partition created by
> > ubi_block, and add the MTD_UBIVOLUME flag?
> 
> No. UBIBlock works on top of UBI volumes and creates a block device.
> 
> We'll sort this out. :)
> 
> Thanks,
> //richard
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

