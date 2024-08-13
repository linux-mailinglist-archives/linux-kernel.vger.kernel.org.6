Return-Path: <linux-kernel+bounces-284783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83233950518
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D76C1F216FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708BC199EA6;
	Tue, 13 Aug 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Lw8i0X7Y"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BE199E93;
	Tue, 13 Aug 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552363; cv=none; b=mnVSYzc4vGpC84w6A34kPGlpF5JWuN0xrLUZcL2QFyx+euEedkhxVynN5/CTFlv28JDYcBOLEUfdb1zcVw+ks5stwx34B708lFb65ua41NVw0ggK7wxla9hts3l1wSR8QSKAn3gcm9nrxtZ1ZcgrNg+bRclQaVexq1GKxceomCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552363; c=relaxed/simple;
	bh=gE0ZYFPD+0rjYYUfTXTkptg3LDSOZxo9b0+1h/Rdcns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MA6SvBdyjkQRj+r9JjwzGboe/VyV+pA3MjqBT7Lxouo90OK5zXfRp0LdolMPdx7KZ0layvF9KLgLGnD0tNXsZp9jV2SZvqt62x4flk/xBVIO2nZkw5pw2G+c3B9ggxeYL6X75QYxx3L5HhQ/dThSIIcXGt6OhFdqyYdllaLRz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Lw8i0X7Y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723552358;
	bh=k474NsT/hKGeKvuNMaZrdo5+Fa1c4TN5fkh3uTGeTZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lw8i0X7Ys1rzFFGNLZf515xcM/EcWHWC1DxmbUymthE87tHCGx/WgfcnJXG5ESg0j
	 eP7HCCMu/Zziu/4nRu1DZbFrGWprDTIqPewyCDudnYFLcIdvb+Phu++ftbLjTC36Js
	 mpd1NWEfJmDfpK3fUuHuyd092E+DQkOU4cWqzgWxGTYcnDIcmOgnker29j5vxgw6aS
	 jSZoOesbn9XjdyoUn2HwXRH4FgADnzY6z+suRcIF1hp7pX6yZPWGrw1ol99R669VmY
	 g5JbeiHddUV5Gr95vNUq54o1gXiMCyHaO0ex8PiIbi728Q2zugJsSFlbEKxMOg9kDb
	 mShQV5joPctHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WjrPd5sjWz4xCV;
	Tue, 13 Aug 2024 22:32:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Niklas Cassel <cassel@kernel.org>
Cc: =?utf-8?Q?Kolbj=C3=B8rn?= Barmen <linux-ppc@kolla.no>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, =?utf-8?B?Sm9u?=
 =?utf-8?B?w6HFoQ==?= Vidra
 <vidra@ufal.mff.cuni.cz>, Christoph Hellwig <hch@lst.de>,
 linux@roeck-us.net
Subject: Re: Since 6.10 - kernel oops/panics on G4 macmini due to change in
 drivers/ata/pata_macio.c
In-Reply-To: <Zrstcei9WN9sRfdX@x1-carbon.wireless.wdc>
References: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no>
 <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz>
 <Zrstcei9WN9sRfdX@x1-carbon.wireless.wdc>
Date: Tue, 13 Aug 2024 22:32:36 +1000
Message-ID: <87sev81u3f.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Niklas Cassel <cassel@kernel.org> writes:
> Hello Jon=C3=A1=C5=A1, Kolbj=C3=B8rn,
>
> thank you for the report.
>
> On Tue, Aug 13, 2024 at 07:49:34AM +0200, Jon=C3=A1=C5=A1 Vidra wrote:
>> On Tue 13. Aug 2024 0:32:37 CEST, Kolbj=C3=B8rn Barmen wrote:
>> > Ever since 6.10, my macmini G4 behaved unstable when dealing with lots=
 of
>> > I/O activity, such as sync'ing of Gentoo portage tree, unpacking kernel
>> > source tarball, building large software packages (or kernel) etc.
>> >=20
>> > After a bit of testing, and patient kernel rebuilding (while crashing)=
 I
>> > found the cuplit to be this commit/change
>> >=20
>> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/=
?id=3D09fe2bfa6b83f865126ce3964744863f69a4a030
>>=20
>> I've been able to reproduce this pata_macio bug on a desktop PowerMac G4
>> with the 6.10.3 kernel version. Reverting the linked change
>> ("ata: pata_macio: Fix max_segment_size with PAGE_SIZE =3D=3D 64K") makes
>> the errors go away.
>
> Michael, as the author of the this commit, could you please look into
> this issue?

I can. My commit was really just working around the warning in the SCSI
core which appeared after afd53a3d8528, it was supposed to just fix the
warning without changing behaviour. Though obviously it did for 4KB
PAGE_SIZE kernels.

I don't have easy access to my mac-mini so it would be helpful if you
can test changes Jon=C3=A1=C5=A1 and/or Kolbj=C3=B8rn.

> We could revert your patch, which appears to work for some users,
> but that would again break setups with PAGE_SIZE =3D=3D 64K.
> (I assume that Jon=C3=A1=C5=A1 and Kolbj=C3=B8rn are not building with PA=
GE_SIZE =3D=3D 64K.)

Yes they are using 4K, it says so in the oops.

>> ------------[ cut here ]------------
>> kernel BUG at drivers/ata/pata_macio.c:544!
>
> https://github.com/torvalds/linux/blob/v6.11-rc3/drivers/ata/pata_macio.c=
#L544
>
> It seems that the
> while (sg_len) loop does not play nice with the new .max_segment_size.

Right, but only for 4KB kernels for some reason. Is there some limit
elsewhere that prevents the bug tripping on 64KB kernels, or is it just
luck that no one has hit it?

I wonder if the best solution is something like below. It effectively
reverts to the old behaviour for 4KB page size, and should avoid the
same bug happening on 64KB page size kernels.

cheers


diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 1b85e8bf4ef9..eaffa510de49 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -208,6 +208,19 @@ static const char* macio_ata_names[] =3D {
 /* Don't let a DMA segment go all the way to 64K */
 #define MAX_DBDMA_SEG		0xff00
=20
+#ifdef CONFIG_PAGE_SIZE_64KB
+/*
+ * The SCSI core requires the segment size to cover at least a page, so
+ * for 64K page size kernels it must be at least 64K. However the
+ * hardware can't handle 64K, so pata_macio_qc_prep() will split large
+ * requests. To handle the split requests the tablesize must be halved.
+ */
+#define MAX_SEGMENT_SIZE SZ_64K
+#define SG_TABLESIZE (MAX_DCMDS / 2)
+#else
+#define MAX_SEGMENT_SIZE MAX_DBDMA_SEG
+#define SG_TABLESIZE MAX_DCMDS
+#endif
=20
 /*
  * Wait 1s for disk to answer on IDE bus after a hard reset
@@ -912,16 +925,10 @@ static int pata_macio_do_resume(struct pata_macio_pri=
v *priv)
=20
 static const struct scsi_host_template pata_macio_sht =3D {
 	__ATA_BASE_SHT(DRV_NAME),
-	.sg_tablesize		=3D MAX_DCMDS,
+	.sg_tablesize		=3D SG_TABLESIZE,
 	/* We may not need that strict one */
 	.dma_boundary		=3D ATA_DMA_BOUNDARY,
-	/*
-	 * The SCSI core requires the segment size to cover at least a page, so
-	 * for 64K page size kernels this must be at least 64K. However the
-	 * hardware can't handle 64K, so pata_macio_qc_prep() will split large
-	 * requests.
-	 */
-	.max_segment_size	=3D SZ_64K,
+	.max_segment_size	=3D MAX_SEGMENT_SIZE,
 	.device_configure	=3D pata_macio_device_configure,
 	.sdev_groups		=3D ata_common_sdev_groups,
 	.can_queue		=3D ATA_DEF_QUEUE,


