Return-Path: <linux-kernel+bounces-367839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE289A076A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C321F27913
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C1207A03;
	Wed, 16 Oct 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="KUC3FfL6"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5E2076BB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074552; cv=none; b=s01HVOC2xRGey4GvQjbjYjiWB5nb62uDOHqDcVVpJQ9+Rb1qEymlGFbzQM3vrZ/i+ckhi88FEX+6QQVpq5/RgqSBs0g9W1O44m2QHtRyx5sXSmJUBGW17Q5oFbGJLAa07Sdx01ZU8DEnR3u7U4NfH5suW/yhajsn1sNqseCxC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074552; c=relaxed/simple;
	bh=RbU0+0DOnMsXLLdR7n0L5xhF+PhyrXNs05EJ7xUTn6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=byH/KFlXgYtv718p1lZOWBWYzSKzNSskvidrrUyygAlgNxr7hwNyGOhlwIxMzAX7bCoteJeBCyTAC9gu3POt3RT8c5BStD6w3YwMF41oP3DekZN9/SSZBipMtGU01SFXmWm00zZGUBW1qq0G/yaYFLun2JmB5zrn8ILne3IuOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=KUC3FfL6; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729074533; x=1729679333; i=spasswolf@web.de;
	bh=zDfoqgLtdwSDhWCua6b4bat7DM5huFT3TSNkpfKFdmI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KUC3FfL6dK6gP6kI6GXycVa0x70gOVgaKh+25C8contPSveEB3P15bslPKON5/I2
	 k93a2+vhMxZanuLL13Cp2ScGu+F6zCY2JkvqakTa0yxwdRoXtx4/wjT6XAsSzloUa
	 duhxSR0uuyA3ZCEPsaCQOivo+2aOphmq/fCLz1MjLljB2s2PJz8T2+0iSXgqqcgYC
	 tUQJtFFbxhyppO8aQcyznOc0nfs53amjHDXthhLpGDCIazl6oGro8HH6ELmiahfK8
	 DWkgHAJbDEKYcDosdWlyLol97GUdqQGUdFubJgTLmKQKd3PLjE+1EeJuPPQ3/wNti
	 Aasjj2tLGRgRmDOQUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1tftnC1lSl-00lDOA; Wed, 16
 Oct 2024 12:28:53 +0200
Message-ID: <3b4dccf8dfbfb5a9d7c07a745c48a96164fbf19a.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Oct 2024 12:28:51 +0200
In-Reply-To: <02217d08-bc08-4ffe-8e63-07878561f9b7@lucifer.local>
References: <20241013223601.3823-1-spasswolf@web.de>
	 <02217d08-bc08-4ffe-8e63-07878561f9b7@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8OCwwgktF/amC+f5zXUZ+R89/j0D+sZHnTcr/ZGlt4DG6simpol
 Q3cnErJh2PlMnPvjE1eL/C6IMjvDuN0x1rE4whu2jJ2x38D/vEGlI3jlPq7GgCfaB7FjK9/
 /+Lhvawy48050kb7CIVvCwHpelHJnTiARORPI/bl9CyBaMuaqDqeSvK+20sN6ZUN/kUFtfu
 sSuOnGQa664j920oD8AQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V8RVBPwwDvs=;BYNRIfGXRdhkTugF6vDLmmDgIE+
 eHOJQAErC/UKXJt+03PyiuKXapMvVz5WUgRsMW38Mx/SF1nr69l5fgiw8KERJOFKiIeav0Ev3
 0eoyy0h1Zdp48P8nWbr7drsYhvY3lyV8FsOikrMqPcjd4qbW0dnEW4KZBYUkdhs/OyWtt9/XI
 gPAukiFxMjFgeO259jJZfGVjkCPe7RLViHKNN172hd/dQ7YuZKz+Z6dPlasp1tbLkqsGf+Xn9
 mOQu0+yFNcRYlBLrG0BD3sSgSmcrJggwLXQHh/wo0TamKihOLNSZ1zgGypHfnffbGMzpQbfmx
 zUg8GyWO7PCq3WjmnQwfcXhHbSNIxFYz1RuJfUzI54RVHQ8udLlD3wFglI5s9pmfYHJQJx+q7
 Lgxi6GLc3Hn4ES7cL8KbEUmQhZhriF+YuoZkBIJ3nKt3nf9DXJ1guGFaauxYlrrj8b1Xuk2zf
 jaii/TJ6ygWnLz4FuSBTf1Fs96nfJLqymPbZFjlEBTyIi7cNWwuz4AzOzsyBxYiRwqK9lXWMa
 7vOr9HJ1yRQCclA3zg0BpUIArPEs75HKLOoQDGOwo83zOmf+iBrbKEaoOOWoCffxi97IqAAhp
 qPA46V+7TiHGvtP/mz8HHa+1CFzbQ3OoZMGdl2e9SP6nz9wDMhLhVsQ34KnYLZV3xi9z1KDHG
 69iKj0Na3kjtgELlI3GFQ1z4ciU/a6e1DWvq5dj+7kdcyCYC+/qbhHHBPQClP6y98ULFjuxzl
 UycOwMkVWjtJZPAO4MVix0bWP63Vm1kDQdWXqV2irfznX6V/yjZ5g6RN5ny8SyxUB9a0tDl1Y
 FrO7F/eq6cAcAbTdUSnKqheA==

Am Montag, dem 14.10.2024 um 10:46 +0100 schrieb Lorenzo Stoakes:
> On Mon, Oct 14, 2024 at 12:35:59AM +0200, Bert Karwatzki wrote:
> > I created a program which can trigger the bug on newer kernel (after t=
he
> > "Avoid zeroing vma tree in mmap_region()" patch and before the fix).
> > My original goal was to trigger the bug on older kernels,
> > but that does not work, yet.
> >
> > Bert Karwatzki
>
> Thanks, that's great!
>
> For older kernels the problem should still be present, the fundamental
> thing that changed from the point of view of this bug is that merge won'=
t
> contribute to the number of VMAs being overwritten at once.
>
> To trigger prior to commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tre=
e
> in mmap_region()") you would need to create a situation where the _clear=
_
> triggers the bug, i.e. you must consistute all the VMAs that are being
> overwritten by the store from existing VMAs you are overwriting with a
> MAP_FIXED.
>
> So some tweaks should get you there...
> >

I don't think triggering the bug on a clear works, because a write of a %N=
ULL
that will cause a node to end with a %NULL becomes a spanning write into t=
he
next node:

/*
 * mas_is_span_wr() - Check if the write needs to be treated as a write th=
at
 * spans the node.
 * @mas: The maple state
 * @piv: The pivot value being written
 * @type: The maple node type
 * @entry: The data to write
 *
 * Spanning writes are writes that start in one node and end in another OR=
 if
 * the write of a %NULL will cause the node to end with a %NULL.
 *
 * Return: True if this is a spanning write, false otherwise.
 */
static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
{


I think the could would trigger in this situation

              Node_0
	     /
            /
	 Node_1
         /    \
        /      \
     Node_2    Node_3

but only if Node_3 contained only two ranges, one empty range and one norm=
al
range, and if the mmap into empty range of Node_3 would merge with the las=
t
range of Node_2 and the last range of Node_3. But I think the rebalancing =
of the
tree will make it very hard if not impossible to create such a node.


Bert Karwatzki

