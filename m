Return-Path: <linux-kernel+bounces-333599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E697CB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0CC1F22E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976BB19F41D;
	Thu, 19 Sep 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vb4w78wO"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0919E7FB
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757375; cv=none; b=SF6/oYwNFmtDmj0HYppLdKfqRHL4tKPZvFe7iZLsqg4E0T/i46WB0uFc8FqVFadhNuKrB3ZZRdAH3B6KqX3bpJJsmvR9i1R8Yz7IwtjnOAuoQX1G3Fdd7WpTmEMW834L30xwty3M0enpPkA2UfHCj6spvAx5Ks7SEsvhRHt3CHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757375; c=relaxed/simple;
	bh=aRZBcg5PTf32BVEVo663kw28ZaquL2AOfa1lep2smEQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6gK9CgziaS3Gt74iXW2Q/qKO54V0qq1hDBFpfq6agVClSNmWrQCXbn4EKfcyjGb4cWT+De1yEwy/hOVnwhV7X5xaL7rwRGUCKQuM6ubYynadu2JQKEWcGBaS4yoqB+xrH61NzwNk1x8d0nzHcWoh1iZpWzkdj6mKB4QE3y0FK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=vb4w78wO; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726757372; x=1727016572;
	bh=aRZBcg5PTf32BVEVo663kw28ZaquL2AOfa1lep2smEQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vb4w78wODwaw3/KkAkuGSUwl7K8RuLFIGpmnk5vXosSIYMYjoY6jTa6ABSRE7uYmb
	 NNl1V6kO1KyXBOuVzJkqqtYfXGkfwrjWcJDwc6s9mbxopbX+iOcxrs4LZk0ZSgmna4
	 NqFAGF8pvxm/D1bx3Wx7Z3c0SiQappjn9xNnjngwAx5p+xQYnF8REcPTJCORq6rFk3
	 ftYfHc+zxQew6TgVo4d/+Ylmx07u4CbtUM4Cr747mJpiQ0t26UB+jwU1gW2P4HjzAO
	 7z/PKWlgEDcFPZ6HOZNzBmfrZnpY+38ZMJcZYO2ipxfCsA5FVTtEmRJkIys9uPAqUG
	 nJ7yEHYOWG3jQ==
Date: Thu, 19 Sep 2024 14:49:28 +0000
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] staging: vt6655: Tidy up s_uGetDataDuration function
Message-ID: <51-n2bqKybKvd7B3wXyKmqbcPe6_OX9KQWYmJ2N1o4PCdcFnVSbxrD9nSWombi2U-RMz6d2mRzvgAm8cVcHKQqZOxq_cs6QpHamI3UadBjU=@protonmail.com>
In-Reply-To: <34860faf-b4c5-45ff-bbed-370a12c88187@gmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com> <34860faf-b4c5-45ff-bbed-370a12c88187@gmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: a784ad7bbd10346bf4bcbe4ca9a9fd5048a88fb1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Wednesday, September 18th, 2024 at 23:08, Philipp Hortmann <philipp.g.ho=
rtmann@gmail.com> wrote:
<cut>
>=20
> Hi Dominik,
>=20
> now you have put quit some afford into this patch series. Thank you.
>=20
> If we change the camel case variables this way we need thousands of
> patches to fix this driver. Therefore we typically change always one
> variable for the entire driver and not for one function.

Thank you for the insight. Indeed, this way of changing variables can
result in high number of patches in the long run. I can either rework
this series in order to clean up the variables in driver scope instead of
function scope, or apply it in future contributions.

>=20
> The following is just my personal opinion:
> You can keep working on this driver and your patches will remain in the
> git. But I think I will propose to delete this driver. Reason is that it
> supports maximum 54MBit/s and the connection is always weak. Its form
> factor is mini PCI that is really old. I use an adapter from mini PCI to
> PCI to get it into my Desktop PC. It furthermore is not buyable anymore.

Oh, I see. I was not aware of the fact it is not buyable anymore.

Can I ask to be added to CC in your proposition? It is a discussion
I would like to follow.

>=20
> I like to focus on the hardware that is really well useable and on the
> market available:
>=20
> rtl8192e
> 150MBit/s -> 12,5MByte/s real steady transfer.
>=20
> buyable for some bugs as miniPCIe Card.
>=20
>=20
> rtl8723bs
> 150MBit/s -> >3MByte/s can be reached with the Notebook:
>=20
> Odys Trendbook Next 14
> (Fedora with xfce) (I would prefer the one with 4GB RAM but I have only 2=
GB)
> buyable for not to much money.
> We can catch this devices because they run on Windows 10 which will not
> be supported after fall 2025
> The Driver has 146 Files with 70000 Lines. I think we can remove a lot
> because the bluetooth part is not used anymore...

Thank you for your suggestion, I will look into them.


Thanks,

Dominik Karol

>=20
> There are more device drivers which need our attention...
>=20
> Thanks
>=20
> Bye Philipp

