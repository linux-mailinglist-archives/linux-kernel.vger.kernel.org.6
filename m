Return-Path: <linux-kernel+bounces-345520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911298B736
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FFE1F21EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0B19C568;
	Tue,  1 Oct 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ktfeJ/HX"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55219ABA4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771930; cv=none; b=szN1oxICPVggT2uLZbJdtu3Zm8hY3WZXP/SH+j+2AeopBMhC5bu5IMOHJnsZvH6ZI1kqdXVoAbej3toyTkze8jg7hkHOEbl0VZEJGJxQBGRhpnLsc0lvT5tBIH/kVpxUCwBaxDuTMKMB5m5LEA2fp8HjonTPXyx4ZV4dviq/j2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771930; c=relaxed/simple;
	bh=k3u5VT6VCtaWL0ZHlYq11fY5I+cYalVv/fDNVuqQdm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMANVYp0ysgnOZMV8vDMGrtLCXCpbHAYo9OE5nA5Evpv0g8iPqUGWXQ3ORW+mkl/iH1AuXXZKT2dpVseRZe8sPnzA9eBpFOyWcaxfcQdaareHyQajm9WR1VDGEGN9+Ygc/GTxc2ImA7H6EFu16DbiHrBcqm/SnlA2G/5/kpbP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ktfeJ/HX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727771916; x=1728376716; i=spasswolf@web.de;
	bh=dHQWjXb/fiVQ65uoEfpRU6TEaFt3ZDC/VibtSLbrQ+s=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ktfeJ/HXlqqlxPhDfS8gfnpmnezMZgLTw5bheN4OMEtAqCrrFKMAfFvxJkhRlqL5
	 xo3L2+jxV5LQfAHumqXEe3zmBdEUSosYb1IysB/SIjcc+Y3AVQg/7fF3JsNKEc1er
	 62dQlHHnVBTt5WKuMMUAvPfLBOc3l6U8pah573pKw9ljMgvLVmqZd6+u3hd+PwnMx
	 n7AtJRevxYky4BJe9aLcE5/F+KNMKuOgYI8nNNFNf9SlMNI/LF8mMUNV21Juerhd/
	 UUAGx+OUWoBw6iWNhFvufosmIDM37b7zxZfNb5YO4e3g3MHuw+r2iSCaonsWSwAsw
	 PyqL47S6HboYS7CR7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyvB8-1rzizR3bDm-00rrk4; Tue, 01
 Oct 2024 10:38:35 +0200
Message-ID: <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spasswolf@web.de
Date: Tue, 01 Oct 2024 10:38:35 +0200
In-Reply-To: <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
	 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GGItFS/1Z9tQ88jusPBjFxPCaWHDc5CSRmJZwl5OWi+y/6MEafg
 umjpjEtwf5Yo9dP7CGMHN5O7ePH2KnQdoznCoUUl7mHMnkL2Kk/Lrig+GDUUYPjzbEGUFY6
 pnN9ch4wtubSYurnt+XtM6/JI2tzyJaVfgGK+wD+DyZ+4kXvbpiuAnO+wLuTgW2IbnrmnU0
 fE9AEOhvxgIcp04eF4S+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rot/5fFBva0=;G8/D7byKipVGPn/ZrevaIODN6Ie
 yjckyPa5/FMfYGUcQm0U2L4RVV9XOac61JZaLWk1Ystke43AwJlR1yQjAvCFw4bF5RR+iqXEf
 2MTraReWAcdaWuqcMASd4wwA2HHYUHwbFiHodDETdWezKsV5pU4JQbrwVui+p6H4xBMsLMnuN
 8Sg2cacgzZjuDZl2UehdxQ6Ta2RkZbNxDmygYQ6Yj6MMY3/Rox9Yi140hsLuLa2D+6IEvkCCu
 I20EeOb9YffsuZV81ouwrWV/3SytxE7AuI8v4h1FEonfst2FV0YjChsx1RuG9KWadyHsj0kHR
 jrWZJYvdIz3rZZWuNKSP1xcbmbM5J19WWpwQV9pj2tM8jucTMasWsvDcWvzekLy3gqXX6i7Bd
 6rpavyroFFx0bnq7nrPvKGlvD4ESvaniuzRitOyNuVY/GhVFZx19aC/aNu9TR2RJ810dkGwyh
 eLi3HLomvzdjw7WnAX6s918rewyMXHO10M0l1e+yG+OfwkaWwAkNdMdS7nvhcjcXDWNkFpSii
 sCzeb7vZrRyEph+a+rqIkEZ+0ef/Y8UQKhoNdf4kUFx1Ce8CacMDkvIm2UzXPbh+fdtudzM6s
 Ax97hDjEoK2yR8TUZy9BMPTk8T2BkJjLhkoHiSf2hCEM19wWFlWjKXHpxbdL5Vh9844Q27rsZ
 aDGc+SpungNCgtV/5q/+fZ10X/7VBVFowpDW4zxGHL8LEA+nfZ1iJIdFbUJe/h1to/G1rg2n0
 BCwMHMBpWV9RJL3uwA3+skCeTxRHy7/SbvUf9N8XXtx6jT/Xe0tN4oSS2N6LQXq4nqSt/40/k
 Y8d0jpxCphkxFQOvGSgdsQjA==

Am Dienstag, dem 01.10.2024 um 09:02 +0100 schrieb Lorenzo Stoakes:
> On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> > I just noticed (via a bisect between v6.11 and v6.12-rc1) that this pa=
tch
> > (commit f8d112a4e657 in linux-next tree) leads to a severe memory corr=
uption
> > error under these (rather rare) circumstances:
> > 1. Start a 32bit windows game via steam (which uses proton, steam's ve=
rsion of wine)
> > 2. When starting the game you the proton version used has to be update=
d
>
> Yikes. Thanks for the report, very very much appreciated. Will look into
> this as Liam is out until next week.
>
> How repro is this? Is it consistent?

Reproducability is 100%, only the method is weird, you have to switch to a=
n
older version of proton in the steam settings of the game, start the game =
and
then switch back to the new version and start the game again.
 It might also be possible using standard wine and repeatedly upgrading an=
d
downgrading wine and (I have not tried this, yet ...)

>
> Can you confirm exactly what commit you are at in the kernel when you
> generate the below dmesg?
>
> If you are able to reliably repro, could you try again with:

Kernel is "commit f8d112a4e657 (HEAD) mm/mmap: avoid zeroing vma tree in
mmap_region()" in linux-next tree.


>
> CONFIG_DEBUG_VM, CONFIG_DEBUG_VM_MAPLE_TREE and CONFIG_DEBUG_MAPLE_TREE =
enabled?
>
> Might be useful to get CONFIG_KASAN on the go too... and CONFIG_DEBUG_IN=
FO :))
>
> Actually CONFIG_LOCKDEP and CONFIG_PROVE_LOCKING would be handy here too=
...
>
> Very much appreciated!
>
> >
> > The effect is the following: The updating process of proton hangs and =
the game does
> > not start and even after an exit from steam two processes remain, one =
of them at
> > 100% CPU:
> > $ ps aux | grep rundll
> > bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\=
windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128=
 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Expe=
rimental\files\share\wine\wine.inf
> > bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\=
windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128=
 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Expe=
rimental\files\share\wine\wine.inf
>
> Is there any dmesg at this point? Or not?

As long as I don not try to kill those processes there's no error message =
(but I
only have let them run for a few minutes ...)

>
> >
> > When trying to kill those processes with "killall rundll32.exe", these=
 error happen:
> >
> > [ T4313] ------------[ cut here ]------------
> > [ T4313] WARNING: CPU: 6 PID: 4313 at include/linux/rwsem.h:85 free_pg=
tables+0x233/0x250
>
> That should be rwsem_assert_held_write_nolockdep() if my kernel is not t=
oo
> different from yours, which suggests we're asserting that a write lock i=
s
> held and it's not...
>

Yes, that's the warning.

Bert Karwatzki



