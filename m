Return-Path: <linux-kernel+bounces-351731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435D9991573
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AD61C216FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171413D248;
	Sat,  5 Oct 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="SQuO+kO3"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C384D3E
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118695; cv=none; b=TTJvODwbzlAEdYxGJswH0W790GNQ3QEUB96wrQ0389i/wn/nIe1zLUEKdwEdCg2087Xlc2DkAO3RXPSzMEx2VJY1EH612u/PQ4T/0KdnD8dYRiliE2jRmnHuudPSYV6413x6uyfgoApf6ZTpSDZ7n0dZvk0kY/JVLG7msZMKAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118695; c=relaxed/simple;
	bh=saIpkOIVbPTdytYf/KWcsNza7nqA/PBbddrvekssgbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3VNbKja2qS7R1qxOCfst5Yb+EyowbnuO4iemnLvF3WDjsxHkbfqU8qw1w1m0n8xKuFEsOoKZkk5KrpDXdgPpNZjl9y2bchoWgGRfTBkY8wYhlXxPhxed2p4X9ytqY+0j+xoo+WjXXYSNPIr47YqFc0Z844Fecrf3v9kztkMNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=SQuO+kO3; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728118681; x=1728723481; i=spasswolf@web.de;
	bh=ulhG9dUDnG+bEUry+0gDLabDRVWAfLiOByQhvtovb10=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SQuO+kO3El0nXsU0LadckGZ6MqZvqKpzrPiAueg5bB/Nhqrm+3TcuyAIZSkX9zFM
	 revR4WQZAR2U5dbSbqKitWYxPA0YT+AqD2PfDQPvXZoFxdV6AsqU7MhoeiirDLcOU
	 CvobcN7ajrZVXMd4AeOGeDCSpBRAopC9o9wTnm1uf3sBlyQI3D9le5SOuuJ8QToB5
	 qcJJIZvvzxLQqRPZtpVdcY9q3sWaMCdXkW/2XEEIpxdWLX5nLwPlSsj2g342jVZxh
	 TUFy9RV7ibQ/Y2ysgT/oXfSn7jZd7s5UKw/F+MASwNToNdq8yfvJ5FPk7tyhE+DAu
	 jQ3J3YjaImkvAUIjqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElZB-1tDAZO1ihf-00EbQE; Sat, 05
 Oct 2024 10:58:01 +0200
Message-ID: <4bf6139bed2b7ed04ed0b599391dbff9272d33ce.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spasswolf@web.de
Date: Sat, 05 Oct 2024 10:57:59 +0200
In-Reply-To: <9e1f326d-7740-4f4c-baf5-45f9eae0048d@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
	 <3b83746d-b73e-4b89-9b74-5aba5a827f45@lucifer.local>
	 <088a3541b85b783ef68337bd4bb790d62f200dfa.camel@web.de>
	 <9e1f326d-7740-4f4c-baf5-45f9eae0048d@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9BGjez5Zt+A20hxoenbC3l7+5i6TSs5okgZQyi7lVf/uoL4QAe0
 vd8OMnBmDVemPhezPufHu4QXmEtyi4X9E6hI8F4F2IQjzG24q8U7VCigBGMywGprakgb9WC
 cQsP8J3J56kK+Wu5Ae8hH0POccZPgIPSd81MrR2Y3VwkGLOL6Q1tbDBhMFtXnok25ksid9L
 jHfZZB4LayonSlV4c5MIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FqcPeFtM28w=;DDWfrcAvYItuaCubNyn0FUQldEm
 jP0ayM5wIcUp/40LiC7hSnJoCx1kbWiJ62LqyGJDigp8YUrNjtjPM/GJBTi0QGYwS6RcOoQTT
 8AeTENYj3JPdXDBvYaxAsX9IYM0kgBBPbgt9J4s+RzM91YSbHWxArgnYAIxe5ozDXkH8RMWFa
 U6ILIwRPfALOWG1Xx+qMmrKGQuoO3OKUejo/kLg5KKBMH9RRlSyvVlKNdt42L3y6eonKwZyGg
 CtC/ZzQJ+6Z+HIyZerVbEUdGGyg3mJPjc3et7wvR+XYRkgpHkkLdqfpNM4ZpRPBfCeNfPFzFl
 3G7S7BdrGW9O5Ui+OTGUQm5I3IhZUhUgXdHU0p1WtxL9jPilDY2X8nBFK+yQvJU2EuiSGOCQC
 EsyJbtHGfjpbCqezGgNs34TQTvlip3zxAbWSmLup907Mmt9z4LsQtO19mfs832V+0obNfGQw0
 dvV9rtp1IF5EjzAY8WhhlmHWOPREfTp5UxSkr49jgAmKlrpFZkYsaNtNbUhloR58QXCHYVocZ
 iH1mUiTbNGaQzKZqqhYMSwsRqqYkXYi+QLcjnNxDSZC82ncAXbM8RNahj8SjHp8mDri64j4Wa
 f7OAdLMeYlvz7umEstMzMsdNPx9hhjhFpfQ8382icWxsWppp5zDUJiu6g7kIM1+iV/4hOaN+R
 RC8KRahQFKctKz8+p0Inp12vqBQvKfGljN1JgdmdF3jE0K1LyEU6rN9D3MRgyXa4maJ+cL+uO
 Q5ftD2/bAFRNWTHhEO9LXoySuqc+7HQakNeB0QXSRW/DejxJONsxBr9Sl0jZ0y/aOaWN1Ncor
 9qLXldFjM1V7G3iRMSwucY0w==


> >
> > I just tested this and it passed ten tests (i.e. upgrading the proton =
version i
> > steam) in a row.
> >
> > Bert Karwatzki
>
> Perfect :) will send the fix upstream then as a hotfix for 6.12! Thanks
> very much for helping out with this, your help has been absolutely
> invaluable and HUGELY appreciated.
>
> Cheers, Lorenzo

I also tried another debugging patch:

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e6f0da908ba7..35b0fe3e02f7 100644
=2D-- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3773,6 +3773,8 @@ static noinline void mas_wr_spanning_store(struct
ma_wr_state *wr_mas)
        /* Copy l_mas and store the value in b_node. */
        mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
        /* Copy r_mas into b_node. */
+       if (!r_populated && r_mas.offset <=3D r_mas.end)
+               printk(KERN_INFO "%s: avoiding maple tree corrution\n",
__func__);
        if (r_populated && r_mas.offset <=3D r_mas.end)
                mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
                           &b_node, b_node.b_end + 1);

and when running the test this prints

[  293.477904] [   T5720] mas_wr_spanning_store: avoiding maple tree corru=
tion
[  293.480202] [   T5720] mas_wr_spanning_store: avoiding maple tree corru=
tion
[  293.482087] [   T5720] mas_wr_spanning_store: avoiding maple tree corru=
tion
[  293.484786] [   T5720] mas_wr_spanning_store: avoiding maple tree corru=
tion
[  293.486644] [   T5720] mas_wr_spanning_store: avoiding maple tree corru=
tion

in dmesg.

Bert Karwatzki

