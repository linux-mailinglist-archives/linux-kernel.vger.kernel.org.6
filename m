Return-Path: <linux-kernel+bounces-347948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48DD98E08C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DEF28BD8A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AC1D1F4C;
	Wed,  2 Oct 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="b80Sn8Iz"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D91D1F41
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885958; cv=none; b=Ww87GlE7cqPVP8Pi2L+M4g2T5bQo8CNWKptiqxbKcK7W/KBPNzXkLu163X16psp0lg3sp0JMta6tuSG0p2mxz6bnqqA7o5tRl5437eHwJuccwQ2mYwJNecfC5Zhg1rfzFRCHKhkZswFROqWuGXDcxzuBYToTEB8U/zFUYOSI1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885958; c=relaxed/simple;
	bh=USvyk1x8c/gO7nBlxrnh7mUj3EQawxUALXZeCDwjhBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4ggScdWl4pW3RG9k3kor9zsWtZirotHKgz4qawSLIECEg02382o00yeX3sb4LVq41nDzsvExlq2KWeGImPh4Y6AquNFMOwjE5HJmF2jfp9vdXtTaMnWYJwj1Fx7Dc+3msCxfusU1TioGBH/5T/SMqccYDUox9MEuYB/uCKtsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=b80Sn8Iz; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727885952; x=1728490752; i=spasswolf@web.de;
	bh=1m6ERfeHpPphk98zvosBTzOnK4mwDn65N6tQYAU4bm0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b80Sn8IzUSsB5dOQtnPeJb+oBTZ12hAEDdMiBm1HQsVKvGWXIvtzj3+psgfMnzSx
	 51qrzdZeiGui0YhBXRijzrZTlMHkzpeUNXrWTnnzk7GIa/1ryCgFaODNYureSjLOG
	 DwQrs0vbEKG7Ujr3fa7Bm2LNJO2yQNODbDB1fvGdWUQqLVNtvCx2OvhCEX49Q5fFZ
	 V8Pa0vjzrw+QuKxdPS7TpjgMmKQSncWnXX9syUBxv7FK8LyGWN1lROiIT8+2Kczfl
	 BWFfotIH3xfLF78cGBpRIPNSi9j+vPUJI/+BQvOv2PKhOsYEWxOLkYaB5xc/ncBFD
	 RNSyYwXHwb+xjSNG1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CUp-1rv69h2e9d-012tCi; Wed, 02
 Oct 2024 18:13:48 +0200
Message-ID: <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spasswolf@web.de
Date: Wed, 02 Oct 2024 18:13:47 +0200
In-Reply-To: <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
	 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
	 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CqC7aO/ZSJHkE7Oyr2eS+4CIhKVbVP2Ar09n0LfqVvIPOIn2kFl
 vMNencPX11kbQeSPAI7Df2rsU4Z0LJGl9KkIdW5WrVbrMTeRlkehcBcMSABHgzvgN+lJjFf
 iiWodFnF70UstG5VNpGi2c4Q+QB7Z0kSonEZfnzilx198nU3Mckrq7eWdhQROht2pVO7rGO
 CjSPl8r99q+/bMMc/Fb8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BHiBF0P62Vc=;bO9ERLkmbMw/esjMpNEUtyrgUTd
 ueZZkplBpcl+firaRt/G/g7k463uomf7DUnZ1rjlta8wjZm5hlJFeiMRTwNbomudxAAAOw4nv
 bqRl+lygoyX97NE8q2rlxjQmDHsTRnp8FwXA8PkbPVsMvlDbIaxbVcVywcWbJGTOdA/rStCKm
 U753dSuyBiwNcz0CkDrkH0Wy3PQAx42ATNwyv2R7r6ZzZ2gUfy3zz+BmeVaPHYXpo15Gso3iu
 ERWCogGCIuuLojhLIIkXtSz2YUrq0/7yzyiQNjWB/JXAEOp5/FJueBTGdjXIafA0pImw7Ey/U
 JrKtHxydbsY501ooT+yTNIginZ9E6TVCpcbGMFRUYEuvTZHEBhBQuu33RALzggurwAqyeLFEn
 jCS0ivggFHGBrcTxXb/onplkBh+rLvKQX9SYMBl5veiYl/k/mKVjUEM4SGe4nf5NpCI2W2isr
 Wa5MK4nR/cusKxnCBzFw5L1g6kGrSufucACgGvCuuDNhP9kW6CHyGx23+mlSlvoaOstZOSd6l
 kmZa9VkCygr0yWjOaGUgQ1ZDq4/wm8sLt9KKxpjW87ynlwgt3mG3xoGyi7JkAILCHOZgda5j/
 zY2wASC2GNXJ1iY/88AmvaGxvIQDsvO7Qki7zh1I+I9rIUfj0Jvepi5LmCdG1FSIWjINMJAvc
 jurnOexeKbnAcKQYSNCjSICwAWxLwzCtNZtd4CPy3Yl5UoTJigUKHOPbVaFCce+p8lGMOUDQL
 P7qesMkjeepdlBWsc+pPyipi+d9Ai6maarHU4I8hYjGddtsdJZv6hTnq9RXSAVkygyZzHdVw1
 WIoUziHndgkQSPEIGdB1ryzg==

Am Mittwoch, dem 02.10.2024 um 14:23 +0100 schrieb Lorenzo Stoakes:
> On Wed, Oct 02, 2024 at 01:13:16PM GMT, Lorenzo Stoakes wrote:
> > On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> > > I just noticed (via a bisect between v6.11 and v6.12-rc1) that this =
patch
> > > (commit f8d112a4e657 in linux-next tree) leads to a severe memory co=
rruption
> > > error under these (rather rare) circumstances:
> > > 1. Start a 32bit windows game via steam (which uses proton, steam's =
version of wine)
> > > 2. When starting the game you the proton version used has to be upda=
ted
> > >
> > > The effect is the following: The updating process of proton hangs an=
d the game does
> > > not start and even after an exit from steam two processes remain, on=
e of them at
> > > 100% CPU:
> > > $ ps aux | grep rundll
> > > bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C=
:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 1=
28 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Ex=
perimental\files\share\wine\wine.inf
> > > bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C=
:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 1=
28 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Ex=
perimental\files\share\wine\wine.inf
> > >
> > > When trying to kill those processes with "killall rundll32.exe", the=
se error happen:
> >
> > [snip]
> >
> > Starting a new thread because lei is totally breaking with all these d=
mesg
> > logs and I'm struggling to be able to reply correctly.
> >
> > Sorry to make it hard to follow everyone but there we go.
> >
> > I have tried to recreate the exact series of anon mappings and it is n=
ot
> > triggering for me, so unfortunately I'm going to have to ask you to tr=
y
> > something else.
> >
> > This does sort of hint at it being maybe an unusual code path with a f=
ile
> > set (possibly...) - could you try the below patch on fresh next 1st oc=
t?
> >
> > You can grep the dmesg for 'LJS' and just provide that if it triggers,
> > mostly I want to see if this (unusual) code path triggers. There shoul=
dn't
> > be any spamming.
> >
> > Thanks!
> >
>
> [snip]
>
> Ugh trying this locally and trying to repro now (and not succeeding
> unfortunately), and I realise that _does_ spam because apparently it's v=
ery
> common with steam to be call_mmap()'ing things into VM_PFNMAP (who knew)=
.
>
> Can you try this instead? Thanks!
>
> ----8<----
> From e69b8c05daa20921bd86ef604982297bd2ced663 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 2 Oct 2024 13:04:55 +0100
> Subject: [PATCH] ljs: add hacky log output
>
> ---
>  mm/mmap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..e513eb3721a3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1463,11 +1463,18 @@ unsigned long mmap_region(struct file *file, uns=
igned long addr,
>  		 * vma again as we may succeed this time.
>  		 */
>  		if (unlikely(vm_flags !=3D vma->vm_flags && vmg.prev)) {
> +			unsigned long ljs_start =3D vma->vm_start;
> +			unsigned long ljs_end =3D vma->vm_end;
> +
>  			vmg.flags =3D vma->vm_flags;
> +
>  			/* If this fails, state is reset ready for a reattempt. */
>  			merge =3D vma_merge_new_range(&vmg);
>
>  			if (merge) {
> +				pr_err("LJS: HIT CASE [%lx, %lx) -> [%lx, %lx) orig flags=3D[%lu] f=
lags=3D[%lu]\n",
> +				       ljs_start, ljs_end, vma->vm_start, vma->vm_end, vm_flags, vm=
a->vm_flags);
> +
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
>  				 * the original file. So fput the vma->vm_file
> --
> 2.46.2

This gives no output.

Bert Karwatzki


